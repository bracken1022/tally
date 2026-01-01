# Jidian (Tally)

Jidian (Tally) is a **parent-only family incentive tracking app**.

It helps parents record children’s positive behaviors using
**points (tally) + real-world rewards**,  
so children can *see their progress over time*.

This app is **not an educational assessment tool**.  
It does not judge, rank, or punish behavior.

Its purpose is simple:

> To reduce the mental and operational burden on parents  
> while making positive effort visible to children.

---

## Users & Roles

### Parents (Primary and Only Operators)
- Create and manage children
- Record positive behaviors as points
- Define reward goals
- Control pacing and rules

### Children (Read-Only Viewers)
- View current point total
- View reward goals and progress
- **Cannot operate or modify the system**

---

## Core Mechanism

---

## Feature Overview

### 1. Children Management

Manages the subjects being encouraged.

Capabilities:
- Support multiple children
- Each child has an independent point total
- Parent switches the active child manually

Design constraints:
- No child accounts
- No login system
- No complex family role modeling

---

### 2. Points System

Records positive behaviors.

Capabilities:
- Add points to the active child
- Points only increase, never decrease
- Points accumulate long-term

Point rules:
- Default action: +1 point
- Parent may apply temporary weighting (e.g. +2, +3)
- No predefined rule configuration required

Design principles:
- One-tap interaction
- System does not decide correctness
- Full discretion remains with the parent

---

### 3. Reward Goals

Provides direction and motivation for accumulated points.

Capabilities:
- Parent-defined reward goals
- Each reward includes:
  - Reward name (e.g. “Buy a toy”, “Cake day”)
  - Target point value
- Multiple rewards may exist simultaneously

Reward rules:
- Rewards are not automatically redeemed
- Reaching a reward does not deduct points
- Rewards are fulfilled in the real world

---

### 4. Child Display Page (Tally Wall)

A read-only page designed for children to view progress.

Displayed content:
- Current total points (prominently)
- Reward goals and progress toward them

Design constraints:
- No interactive controls
- No history or analytics
- No daily score emphasis

Purpose:
> To let children *see accumulation*,  
> not to manage tasks or performance.

---

### 5. Daily Point Limit (Optional)

Helps parents control daily pacing.

Capabilities:
- Parent may set a daily maximum point limit
- Disabled by default (unlimited)
- When exceeded, additional points are silently ignored

Design principle:
- Limits are for parents only
- Children do not need to know limits exist

---

### 6. Data Storage (Local-First)

Ensures stability and privacy.

Characteristics:
- All data stored locally
- No network dependency
- No registration or login required

Design priorities:
- Stability over architecture
- Privacy over convenience
- No cloud dependency in early versions

---

## Explicitly Unsupported Features

The following features are **intentionally excluded**:

- Child accounts or authentication
- Point deduction or punishment
- Streaks, resets, or failure states
- Gamification (avatars, pets, badges)
- Behavioral analysis or reports
- Social sharing or leaderboards
- Cloud sync or multi-device support
- Automatic reward redemption

These constraints are **deliberate design decisions**  
to preserve simplicity and long-term usability.

---

## Design Philosophy Summary

- Systems should be simple; family interactions are not
- Tools record, people decide
- Points represent process, not evaluation
- Motivation comes from being seen, not being controlled

---

## Naming

- App name: **Jidian**
- English name: **Tally**
- Child display page: **Tally Wall**
- Default reward symbol: 🌸 Red Flower
