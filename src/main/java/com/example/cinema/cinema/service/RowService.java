package com.example.cinema.cinema.service;

import com.example.cinema.cinema.model.Hall;
import com.example.cinema.cinema.model.Row;
import com.example.cinema.cinema.model.Seat;
import com.example.cinema.cinema.repository.RowRepository;
import com.example.cinema.cinema.repository.SeatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RowService {
    @Autowired
    private RowRepository rowRepository;

    @Autowired
    private SeatRepository seatRepository;

    public List<Row> findAll() {
        return rowRepository.findAll(Sort.by(Sort.Direction.ASC, "id"));
    }

    public List<Row> findByHall(Hall hall) {
        return rowRepository.findByHall(hall, Sort.by(Sort.Direction.ASC, "id"));
    }

    public Row findById(Long rowId){
        Optional<Row> rowOptional = rowRepository.findById(rowId);

        return rowOptional.orElse(null);
    }

    public Row getIfExist(Row row){
        return rowRepository.findByHallAndName(row.getHall(), row.getName());
    }

    public void saveRow(Row row) throws Exception {
        Hall hall = row.getHall();
        if(row.getNumSeats() + hall.countSeats() > hall.getNumSeats())
            throw new Exception("The number of seats in the hall is exceeded");

        for(int i = 1; i <= row.getNumSeats(); i++){
            Seat seat = new Seat();
            seat.setNumber(i);
            seat.setRow(row);
            seat.setType(row.getType());
            row.getSeats().add(seat);
        }

        rowRepository.save(row);
    }

    public void updateRow(Row editRow, Row row) throws Exception {
        if(editRow.getHall().countSeats() - editRow.getNumSeats() + row.getNumSeats() > editRow.getHall().getNumSeats())
            throw new Exception("Can't edit amount of seats in row");

        editRow.setName(row.getName());
        editRow.setNumSeats(row.getNumSeats());
        editRow.setType(row.getType());

        for(Seat seat : seatRepository.findByRow(editRow)){
            editRow.getSeats().remove(seat);
            seatRepository.delete(seat);
        }

        for(int i = 1; i <= row.getNumSeats(); i++){
            Seat seat = new Seat();
            seat.setNumber(i);
            seat.setRow(editRow);
            seat.setType(row.getType());
            editRow.getSeats().add(seat);
        }

        rowRepository.save(editRow);
    }

    public void deleteRow(Row row) {
        rowRepository.delete(row);
    }

}
