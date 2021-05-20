#include <Arduino.h>
#include <Wire.h>

#define AS5600_AS5601_DEV_ADDRESS 0x36
#define AS5600_AS5601_REG_RAW_ANGLE 0x0C

void setup() {
  Wire.begin();
  Wire.setClock(400000);

  Serial.begin(9600);
}

void loop() {
  Wire.beginTransmission(AS5600_AS5601_DEV_ADDRESS);
  Wire.write(AS5600_AS5601_REG_RAW_ANGLE);
  Wire.endTransmission(false);
  Wire.requestFrom(AS5600_AS5601_DEV_ADDRESS, 2);

  uint16_t RawAngle = 0;
  RawAngle = ((uint16_t)Wire.read() << 8) & 0x0F00;
  RawAngle |= (uint16_t)Wire.read();

  RawAngle = RawAngle * 360.0 / 4096.0;

  int degInt = round(RawAngle);

  Serial.write('H');
  Serial.write(highByte(degInt));
  Serial.write(lowByte(degInt));

  delay(5);
}