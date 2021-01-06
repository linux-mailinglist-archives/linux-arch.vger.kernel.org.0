Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6652EC262
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 18:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbhAFRga (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 12:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbhAFRga (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Jan 2021 12:36:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27EE620657;
        Wed,  6 Jan 2021 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954549;
        bh=k/pidVaDKztHR41se4lBhvy8bU+Plsc0TOzwpF2mduk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hnsJIqRKhC24C/Stvdg5YKGmas3ubUsxEHrnaljMTkRZZZfYugDUrOd8B04PHjptH
         74s04YV9YWhg6RsV7VHoIbEgIKGqbO0Ft7uPuGoXUFg16s9bZ9T4mTbY02mv5+ukT9
         B8rZDLHondps6aXX+pohT/nmRJFF115otfGe3PQZbs2AMYczh48nflSHYbJeYFgpuq
         k2gq2X2g/U42mEKpwQFsFgRSSTp9xAPstrqxFauKu4vi+2ZJprMP08obC9hMFNIB3C
         xZMJqdzdNgAPPOu7ErBpkHL7YCLEwS+cbwhUkRkV0EwV9VRfiKM5IY685xRviQLMxz
         apXhNnxsJ2C8w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E421735225EC; Wed,  6 Jan 2021 09:35:48 -0800 (PST)
Date:   Wed, 6 Jan 2021 09:35:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/3] LKMM updates for v5.12
Message-ID: <20210106173548.GA23664@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series provides a few LKMM updates:

1.	tools/memory-model: Tie acquire loads to reads-from.

2.	tools/memory-model: Remove redundant initialization in litmus
	tests, courtesy of Akira Yokosawa.

3.	tools/memory-model: Fix typo in klitmus7 compatibility table,
	courtesy of Akira Yokosawa.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/glossary.txt                                              |   12 +++++++---
 README                                                                  |    2 -
 litmus-tests/CoRR+poonceonce+Once.litmus                                |    4 ---
 litmus-tests/CoRW+poonceonce+Once.litmus                                |    4 ---
 litmus-tests/CoWR+poonceonce+Once.litmus                                |    4 ---
 litmus-tests/CoWW+poonceonce.litmus                                     |    4 ---
 litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus                      |    5 ----
 litmus-tests/IRIW+poonceonces+OnceOnce.litmus                           |    5 ----
 litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus                 |    7 -----
 litmus-tests/ISA2+poonceonces.litmus                                    |    6 -----
 litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus   |    6 -----
 litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus                     |    5 ----
 litmus-tests/LB+poacquireonce+pooncerelease.litmus                      |    5 ----
 litmus-tests/LB+poonceonces.litmus                                      |    5 ----
 litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus                |    5 ----
 litmus-tests/MP+onceassign+derefonce.litmus                             |    4 ---
 litmus-tests/MP+polockmbonce+poacquiresilsil.litmus                     |    5 ----
 litmus-tests/MP+polockonce+poacquiresilsil.litmus                       |    5 ----
 litmus-tests/MP+polocks.litmus                                          |    6 -----
 litmus-tests/MP+poonceonces.litmus                                      |    5 ----
 litmus-tests/MP+pooncerelease+poacquireonce.litmus                      |    5 ----
 litmus-tests/MP+porevlocks.litmus                                       |    6 -----
 litmus-tests/R+fencembonceonces.litmus                                  |    5 ----
 litmus-tests/R+poonceonces.litmus                                       |    5 ----
 litmus-tests/S+fencewmbonceonce+poacquireonce.litmus                    |    5 ----
 litmus-tests/S+poonceonces.litmus                                       |    5 ----
 litmus-tests/SB+fencembonceonces.litmus                                 |    5 ----
 litmus-tests/SB+poonceonces.litmus                                      |    5 ----
 litmus-tests/SB+rfionceonce-poonceonces.litmus                          |    5 ----
 litmus-tests/WRC+poonceonces+Once.litmus                                |    5 ----
 litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus             |    5 ----
 litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus                 |    7 -----
 litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus                 |    7 -----
 litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus |    6 -----
 34 files changed, 42 insertions(+), 138 deletions(-)
