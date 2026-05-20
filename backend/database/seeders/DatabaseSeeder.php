<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Protocol; // <-- Import your fresh Protocol model
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Add a couple of realistic TACRU medical protocol placeholders
        Protocol::create([
            'title' => 'Adult CPR and Basic Life Support Guide',
            'type' => 'BLS',
            'category' => 'Cardiovascular',
            'file_path' => 'protocols/bls_adult_cpr.pdf',
            'description' => 'Standard TACRU protocol for chest compressions and rescue breathing.'
        ]);

        Protocol::create([
            'title' => 'Advanced Airway Management and Intubation',
            'type' => 'ALS',
            'category' => 'Respiratory',
            'file_path' => 'protocols/als_airway_mgmt.pdf',
            'description' => 'Advanced operational manual for endotracheal intubation in trauma scenarios.'
        ]);
    }
}