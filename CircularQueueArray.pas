program CircularQueueArray;
uses crt;

const
    Maks_ElemenQueue = 5;
type
    Queue = record
        Elemen: array[1..Maks_ElemenQueue] of char;
        Front, Rear: integer;
    end;

var
    Queue1: Queue;

procedure Inisialisasi(var Queue1: Queue);
begin
    Queue1.Front := -1;
    Queue1.Rear := -1;
end;

function isEmpty(Queue1: Queue): Boolean;
begin
    isEmpty := (Queue1.Front = -1) and (Queue1.Rear = -1);
end;

function isFull(Queue1: Queue): Boolean;
begin
    isFull := ((Queue1.Rear + 1) mod Maks_ElemenQueue = Queue1.Front);
end;

procedure Enqueue(var Queue1: Queue; elemenbaru: char);
begin
    if isFull(Queue1) then
        writeln('ERROR: QUEUE PENUH!')
    else
    begin
        if isEmpty(Queue1) then
        begin
            Queue1.Front := 0;
            Queue1.Rear := 0;
        end
        else
            Queue1.Rear := (Queue1.Rear + 1) mod Maks_ElemenQueue;
        Queue1.Elemen[Queue1.Rear] := elemenbaru;
        writeln('Elemen ', elemenbaru, ' telah ditambahkan ke dalam antrian.');
    end;
end;

function Dequeue(var Queue1: Queue): char;
var
    elemenFront: char;
begin
    if isEmpty(Queue1) then
    begin
        writeln('QUEUE KOSONG!');
        Dequeue := #0;
    end
    else
    begin
        elemenFront := Queue1.Elemen[Queue1.Front];
        if Queue1.Front = Queue1.Rear then
        begin
            Queue1.Front := -1;
            Queue1.Rear := -1;
        end
        else
            Queue1.Front := (Queue1.Front + 1) mod Maks_ElemenQueue;
        Dequeue := elemenFront;
        writeln('Elemen ', elemenFront, ' telah dihapus dari antrian.');
    end;
end;

function Count(Queue1: Queue): integer;
begin
    if isEmpty(Queue1) then
        Count := 0
    else if Queue1.Rear >= Queue1.Front then
        Count := Queue1.Rear - Queue1.Front + 1
    else
        Count := Maks_ElemenQueue - Queue1.Front + Queue1.Rear + 1;
end;

procedure Display(Queue1: Queue);
var
    i: integer;
begin
    write('Isi Queue: ');
    if isEmpty(Queue1) then
        writeln('[Kosong]')
    else
    begin
        write('[FRONT] ');
        i := Queue1.Front;
        repeat
            write(Queue1.Elemen[i]:3);
            i := (i + 1) mod Maks_ElemenQueue;
        until i = (Queue1.Rear + 1) mod Maks_ElemenQueue;
        writeln(' [REAR]');
    end;
end;

procedure Menu;
var
    pilihan: integer;
    elemen: char;
begin
    repeat
        clrscr;
        writeln('Menu Antrian:');
        writeln('1. Menambah antrian (Enqueue)');
        writeln('2. Menghapus antrian (Dequeue)');
        writeln('3. Menampilkan antrian (Display)');
        writeln('4. Menghitung jumlah antrian');
        writeln('5. Keluar');
        write('Pilih menu: ');
        readln(pilihan);

        case pilihan of
            1: begin
                   write('Masukkan elemen untuk ditambahkan: ');
                   readln(elemen);
                   Enqueue(Queue1, elemen);
               end;
            2: begin
                   elemen := Dequeue(Queue1);
                   if elemen <> #0 then
                       writeln('Elemen ', elemen, ' telah dihapus.');
               end;
            3: Display(Queue1);
            4: writeln('Jumlah elemen dalam antrian: ', Count(Queue1));
            5: writeln('Keluar dari program...');
        else
            writeln('Pilihan tidak valid!');
        end;
        if pilihan <> 5 then
        begin
            writeln('Tekan Enter untuk melanjutkan....');
            readln;
        end;
    until pilihan = 5;
end;

begin
    Inisialisasi(Queue1);
    Menu;
end.