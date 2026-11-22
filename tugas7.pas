uses crt;

type
  matkul = record
    nama: string[25];
    sks: integer;
    nilai: string[2];
    skor: real;
  end;

  mahasiswa = record
    nama: string[40];
    nim: string[15];
    jml: integer;
    mk: array[1..15] of matkul;
    totSks: integer;
    totSkor, ip: real;
  end;

  arrMhs = array[1..30] of mahasiswa;

function hitungBobot(n: string): real;
begin
  n := upcase(n);
  if n = 'A' then
    hitungBobot := 4.0
  else if n = 'B+' then
    hitungBobot := 3.5
  else if n = 'B' then
    hitungBobot := 3.0
  else if n = 'C+' then
    hitungBobot := 2.5
  else if n = 'C' then
    hitungBobot := 2.0
  else if n = 'D' then
    hitungBobot := 1.0
  else
    hitungBobot := 0.0;
end;

procedure inputData(var mhs: arrMhs; var n: integer);
var
  i, j: integer;
begin
  write('Masukkan jumlah mahasiswa: ');
  readln(n);

  for i := 1 to n do
  begin
    clrscr;
    writeln('=== Input Data Mahasiswa ke-', i, ' ===');
    write('Nama               : '); readln(mhs[i].nama);
    write('NIM                : '); readln(mhs[i].nim);
    write('Jumlah Mata Kuliah : '); readln(mhs[i].jml);

    mhs[i].totSks := 0;
    mhs[i].totSkor := 0;

    for j := 1 to mhs[i].jml do
    begin
      writeln;
      writeln('Mata Kuliah ke-', j);
      write('Nama Mata Kuliah : '); readln(mhs[i].mk[j].nama);
      write('Jumlah SKS       : '); readln(mhs[i].mk[j].sks);
      write('Nilai            : '); readln(mhs[i].mk[j].nilai);

      mhs[i].mk[j].nilai := upcase(mhs[i].mk[j].nilai);
      mhs[i].mk[j].skor := mhs[i].mk[j].sks * hitungBobot(mhs[i].mk[j].nilai);

      mhs[i].totSks := mhs[i].totSks + mhs[i].mk[j].sks;
      mhs[i].totSkor := mhs[i].totSkor + mhs[i].mk[j].skor;
    end;

    mhs[i].ip := mhs[i].totSkor / mhs[i].totSks;
  end;
end;

procedure tampilData(mhs: arrMhs; n: integer);
var
  i, j: integer;
begin
  for i := 1 to n do
  begin
    clrscr;
    writeln('+--------------------------------------------------------------+');
    writeln('| Nama : ', mhs[i].nama:53, ' |');
    writeln('| NIM  : ', mhs[i].nim:53, ' |');
    writeln('| ------------------------------------------------------------ |');
    writeln('| | No | Mata Kuliah         | SKS | Nilai | Skor            | |');
    writeln('| ------------------------------------------------------------ |');

    for j := 1 to mhs[i].jml do
    begin
      writeln('| | ', j:2, ' | ',
              mhs[i].mk[j].nama:19, ' | ',
              mhs[i].mk[j].sks:3, ' | ',
              mhs[i].mk[j].nilai:5, ' | ',
              mhs[i].mk[j].skor:15:1, ' | |');
    end;

    writeln('| ------------------------------------------------------------ |');
    writeln('| | TOTAL                                 | ', mhs[i].totSkor:15:1, ' | |');
    writeln('| ------------------------------------------------------------ |');
    writeln('| Jumlah SKS : ', mhs[i].totSks:47, ' |');
    writeln('| IP         : ', mhs[i].ip:47:2, ' |');
    writeln('|                                                              |');
    writeln('| Tekan sembarang tombol untuk melihat data selanjutnya..      |');
    writeln('+--------------------------------------------------------------+');
    readkey;
  end;
end;

var
  mhs: arrMhs;
  n: integer;

begin
  clrscr;
  inputData(mhs, n);
  tampilData(mhs, n);
end.
