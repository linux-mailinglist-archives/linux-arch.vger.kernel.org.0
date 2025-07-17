Return-Path: <linux-arch+bounces-12831-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CB1B08798
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 10:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3FE1A65CEC
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D2E286D5E;
	Thu, 17 Jul 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPfaibOk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725A2798EA;
	Thu, 17 Jul 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739632; cv=none; b=kf3xnSGVYHdAvkcpq7HqY9fdLg+vzdqO1BczfsEwqWPCbAy7Dg1SbYVB7y7pObQ9q40+7ExdRkLDWI2tqL/6TWRKTjx3W7CtWK9877jg9LYm5iN8e7QI66iSeCkdV5whmk4PeslRiOBuMGQ28A/EodXroS0RaYRPc41b1o4W228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739632; c=relaxed/simple;
	bh=A5Bl5PhbnERdxjfihgJK3JijiNJjvaDc6LBpyeI8vK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAg8jqXKd1W8ZrsoTXTpsZQYubadPO3IzaY2e1V0uJyXF6VwN2u0j6dFciwGUeA//OeMrFvxju2unMScSnipHkmJc2y2T2wka639wma6QJnBlqcfhi+kPcr3qccymQmFVJ1Ts9s5BFsvouLvEoX5SnD7rYqOVZaAazv86sows7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPfaibOk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3134c67a173so704173a91.1;
        Thu, 17 Jul 2025 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752739626; x=1753344426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sStfoPRVkQT18ZxDHikn0EExqA59vXvo5zP8nXI1xJs=;
        b=TPfaibOkB0myt8pRS2WgqtV85BPSRIUY1r7i2SRNB7ZqMdTaTXgVrGUQ/JCrtUQ7iw
         PYbmp/mgc+qpWzGIezO0JESMERb7el+Fa0clYDSHL926lzCFD3NgbnmhGdxapvIGQGmY
         muWc44YA+t/1NbywgnorF5KsAW5xtGqzbELU4+lPWLOnlJeqGTr2p6ckm6s5ieYM8FwC
         sgFV77/kKPnu0Kfmbbs5F89CYmZ6I8OKApk9fjSPP+KJkzdDP31n621xiECAfrn2LH//
         7wbNWYuCLoUfkqiR64MeQMOdai7UAcS7yVrF57WBUzV5B2BwIlKTgcEIsBhWRiNf0Jn5
         HcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739626; x=1753344426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sStfoPRVkQT18ZxDHikn0EExqA59vXvo5zP8nXI1xJs=;
        b=HzQ0GFwFli252OHcfwOkDmSK4MqOghWeu5m2oEsPXKjfrvQp+m5Uh8HLrzahSa9QGc
         Red1KT+6hb4hp9/E+wBSY8GogMQmTPvbD8Fxd6S65bM3Hd1bGnRC4MD/xm+VyhqTjqZp
         AQRL9U7dr9aqOGh79p5OQpB08t9+vG7O3ioxCUW7/Jzvn+5frCwGi9QQool0tj/yQmxs
         hkPJtzT+sv+S4XACHnEhppUv0H2v/zO8ysHmVSvf6GiqSQVPRH/wJCmjoWtQYUA8l1nV
         imghmXUWoa1dQbC6fRnGXEhf9AFeq2VDAIQWLqNnUzONGZFtSGAToFVL4f4CrcXR2FLZ
         g8hw==
X-Forwarded-Encrypted: i=1; AJvYcCVO8TjIWgSq72IRPjjlwS5xxj7WW4xDg6iJJxYCE2mtjTQ/GfbjXf/CuxS3mgOc9knTmkSp@vger.kernel.org, AJvYcCXDoIKeEHjQWJtV7zel3SO+vunYLvLt+BG+X9mCvwkgX0bt+FG2pljrtJ1y7LL4qfROCC0=@vger.kernel.org, AJvYcCXQRqO0jt7UbSIpS/t/+HB/t4kcmBiyKUkDrT9KqxBeJMVwpAt5g6NjnRu5NGPhg4YNLAqd8qM2Cho+nA==@vger.kernel.org, AJvYcCXbuKeIdyK6p7CElIOeOORIdH0dD83KsydrlvAKNmqvvJDo/XIxLHvEjGl9ETQn0J2GbykV/OEJlK2S@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+j1lC26RaHaQ//ddsckcHgh/miPZU3Eop3EO5k9pQl6DNPKp
	s2Wwv/ItRcvvza8a/UQM/02TxaCvwkwoMVD3ubAOzMSD60XL3GqFNCjq
X-Gm-Gg: ASbGncvZ8x9ylc/sQYcPF/EaHdDtHITe8SwOX0qgoCrP3yMWKQUVceX2Qbhkr9mnGR/
	dnzJngZxY8rIKMuXsdMU88FGmCM93rqpEGjfSsvnSRR0tsxakiD68nxZ+NNinYnT2h6zd7kg8Kg
	eF4ZKZzjhAfg2/WbrMze2NSPxhvP4o4WF3UzUpYZWzX2lRGHHwGY0JReyLQPJ/hEkVxrv0GXp6n
	sYUwiZzL80CHucSlf+r0PszgmxfmQGwRA3gU712OW2VPuUElANdrkYEIGBEHKBRHdx7wtXqiCH4
	ey6OcOZf8ZKO9bEY0JxS7vT8cHN5CbS6Zt++5MvfOlIOTDO6hUdSmhZvb67KNe06AYlp0Q/mzGh
	1lTsgepalBHTOnI+xXbw1Sg==
X-Google-Smtp-Source: AGHT+IEvJh5EbYXxNOy0QefSBm3CzBAisI9Ue9+scD725w2KCNp8Fllv7+4o6Lgp+GfmMxJU6/WNFg==
X-Received: by 2002:a17:90b:2650:b0:311:baa0:89ce with SMTP id 98e67ed59e1d1-31c9f3fc33bmr8555560a91.12.1752739623116;
        Thu, 17 Jul 2025 01:07:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f287be2sm2896901a91.23.2025.07.17.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 01:06:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B100C424E29A; Thu, 17 Jul 2025 15:06:53 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux RCU <rcu@vger.kernel.org>,
	Linux CPU Architectures Development <linux-arch@vger.kernel.org>,
	Linux LKMM <lkmm@lists.linux.dev>,
	Linux KVM <kvm@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xavier <xavier_qy@163.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/4] Documentation: memory-barriers: Convert to reST format
Date: Thu, 17 Jul 2025 15:06:14 +0700
Message-ID: <20250717080617.35577-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717080617.35577-1-bagasdotme@gmail.com>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=121145; i=bagasdotme@gmail.com; h=from:subject; bh=A5Bl5PhbnERdxjfihgJK3JijiNJjvaDc6LBpyeI8vK4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkVa5M7hCWyfcvkm9vF75TUWZy332Fm8eNq1L8j8jJdd 34e/xnfUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIkweDIyvOuee11YncXT543v 3OQDks0S0rPEVGbM4d58p7+2NkDwGMM/1fS+P86Spa4WGmkusREr0o4+cI/oXL8hcd5GFb5l2uW 8AA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert memory barriers documentation to reST syntax:

* Fix up title and section headings (and sentence-case headings)
* Generate in-doc table of contents with contents:: directive
* Use proper bullet list syntax
* Mark-up admonitions, code blocks, and footnotes

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/core-api/index.rst              |    2 +-
 .../memory-barriers.rst}                      | 1580 +++++++++--------
 .../core-api/wrappers/memory-barriers.rst     |   18 -
 3 files changed, 840 insertions(+), 760 deletions(-)
 rename Documentation/{memory-barriers.txt => core-api/memory-barriers.rst} (67%)
 delete mode 100644 Documentation/core-api/wrappers/memory-barriers.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 7a4ca18ca6e2d3..a0c3749c655b05 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -77,7 +77,7 @@ Documentation/locking/index.rst for more related documentation.
    local_ops
    padata
    ../RCU/index
-   wrappers/memory-barriers.rst
+   memory-barriers
 
 Low-level hardware management
 =============================
diff --git a/Documentation/memory-barriers.txt b/Documentation/core-api/memory-barriers.rst
similarity index 67%
rename from Documentation/memory-barriers.txt
rename to Documentation/core-api/memory-barriers.rst
index 93d58d9a428b87..da8e682dc58d86 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/core-api/memory-barriers.rst
@@ -1,14 +1,15 @@
-			 ============================
-			 LINUX KERNEL MEMORY BARRIERS
-			 ============================
+.. SPDX-License-Identifier: GPL-2.0
 
-By: David Howells <dhowells@redhat.com>
-    Paul E. McKenney <paulmck@linux.ibm.com>
-    Will Deacon <will.deacon@arm.com>
-    Peter Zijlstra <peterz@infradead.org>
+============================
+Linux Kernel Memory Barriers
+============================
 
-==========
-DISCLAIMER
+:Author: David Howells <dhowells@redhat.com>,
+         Paul E. McKenney <paulmck@linux.ibm.com>,
+         Will Deacon <will.deacon@arm.com>,
+         Peter Zijlstra <peterz@infradead.org>
+
+Disclaimer
 ==========
 
 This document is not a specification; it is intentionally (for the sake of
@@ -27,7 +28,6 @@ The purpose of this document is twofold:
 
  (1) to specify the minimum functionality that one can rely on for any
      particular barrier, and
-
  (2) to provide a guide as to how to use the barriers that are available.
 
 Note that an architecture can provide more than the minimum requirement
@@ -39,75 +39,15 @@ architecture because the way that arch works renders an explicit barrier
 unnecessary in that case.
 
 
-========
-CONTENTS
+Contents
 ========
 
- (*) Abstract memory access model.
+.. contents::
 
-     - Device operations.
-     - Guarantees.
-
- (*) What are memory barriers?
-
-     - Varieties of memory barrier.
-     - What may not be assumed about memory barriers?
-     - Address-dependency barriers (historical).
-     - Control dependencies.
-     - SMP barrier pairing.
-     - Examples of memory barrier sequences.
-     - Read memory barriers vs load speculation.
-     - Multicopy atomicity.
-
- (*) Explicit kernel barriers.
-
-     - Compiler barrier.
-     - CPU memory barriers.
-
- (*) Implicit kernel memory barriers.
-
-     - Lock acquisition functions.
-     - Interrupt disabling functions.
-     - Sleep and wake-up functions.
-     - Miscellaneous functions.
-
- (*) Inter-CPU acquiring barrier effects.
-
-     - Acquires vs memory accesses.
-
- (*) Where are memory barriers needed?
-
-     - Interprocessor interaction.
-     - Atomic operations.
-     - Accessing devices.
-     - Interrupts.
-
- (*) Kernel I/O barrier effects.
-
- (*) Assumed minimum execution ordering model.
-
- (*) The effects of the cpu cache.
-
-     - Cache coherency vs DMA.
-     - Cache coherency vs MMIO.
-
- (*) The things CPUs get up to.
-
-     - And then there's the Alpha.
-     - Virtual Machine Guests.
-
- (*) Example uses.
-
-     - Circular buffers.
-
- (*) References.
-
-
-============================
-ABSTRACT MEMORY ACCESS MODEL
+Abstract Memory Access Model
 ============================
 
-Consider the following abstract model of the system:
+Consider the following abstract model of the system::
 
 		            :                :
 		            :                :
@@ -144,7 +84,7 @@ CPU are perceived by the rest of the system as the operations cross the
 interface between the CPU and rest of the system (the dotted lines).
 
 
-For example, consider the following sequence of events:
+For example, consider the following sequence of events::
 
 	CPU 1		CPU 2
 	===============	===============
@@ -153,7 +93,7 @@ For example, consider the following sequence of events:
 	B = 4;		y = A;
 
 The set of accesses as seen by the memory system in the middle can be arranged
-in 24 different combinations:
+in 24 different combinations::
 
 	STORE A=3,	STORE B=4,	y=LOAD A->3,	x=LOAD B->4
 	STORE A=3,	STORE B=4,	x=LOAD B->4,	y=LOAD A->3
@@ -165,7 +105,7 @@ in 24 different combinations:
 	STORE B=4, ...
 	...
 
-and can thus result in four different combinations of values:
+and can thus result in four different combinations of values::
 
 	x == 2, y == 1
 	x == 2, y == 3
@@ -178,7 +118,7 @@ perceived by the loads made by another CPU in the same order as the stores were
 committed.
 
 
-As a further example, consider this sequence of events:
+As a further example, consider this sequence of events::
 
 	CPU 1		CPU 2
 	===============	===============
@@ -188,17 +128,17 @@ As a further example, consider this sequence of events:
 
 There is an obvious address dependency here, as the value loaded into D depends
 on the address retrieved from P by CPU 2.  At the end of the sequence, any of
-the following results are possible:
+the following results are possible::
 
 	(Q == &A) and (D == 1)
 	(Q == &B) and (D == 2)
 	(Q == &B) and (D == 4)
 
 Note that CPU 2 will never try and load C into D because the CPU will load P
-into Q before issuing the load of *Q.
+into Q before issuing the load of \*Q.
 
 
-DEVICE OPERATIONS
+Device Operations
 -----------------
 
 Some devices present their control interfaces as collections of memory
@@ -206,12 +146,12 @@ locations, but the order in which the control registers are accessed is very
 important.  For instance, imagine an ethernet card with a set of internal
 registers that are accessed through an address port register (A) and a data
 port register (D).  To read internal register 5, the following code might then
-be used:
+be used::
 
 	*A = 5;
 	x = *D;
 
-but this might show up as either of the following two sequences:
+but this might show up as either of the following two sequences::
 
 	STORE *A = 5, x = LOAD *D
 	x = LOAD *D, STORE *A = 5
@@ -220,63 +160,81 @@ the second of which will almost certainly result in a malfunction, since it set
 the address _after_ attempting to read the register.
 
 
-GUARANTEES
+Guarantees
 ----------
 
 There are some minimal guarantees that may be expected of a CPU:
 
- (*) On any given CPU, dependent memory accesses will be issued in order, with
-     respect to itself.  This means that for:
+ * On any given CPU, dependent memory accesses will be issued in order, with
+   respect to itself.  This means that for:
+
+   .. code-block:: c
 
 	Q = READ_ONCE(P); D = READ_ONCE(*Q);
 
-     the CPU will issue the following memory operations:
+   the CPU will issue the following memory operations:
+
+   .. code-block::
 
 	Q = LOAD P, D = LOAD *Q
 
-     and always in that order.  However, on DEC Alpha, READ_ONCE() also
-     emits a memory-barrier instruction, so that a DEC Alpha CPU will
-     instead issue the following memory operations:
+   and always in that order.  However, on DEC Alpha, READ_ONCE() also emits
+   a memory-barrier instruction, so that a DEC Alpha CPU will instead issue
+   the following memory operations
+
+   .. code-block::
 
 	Q = LOAD P, MEMORY_BARRIER, D = LOAD *Q, MEMORY_BARRIER
 
-     Whether on DEC Alpha or not, the READ_ONCE() also prevents compiler
-     mischief.
+   Whether on DEC Alpha or not, the READ_ONCE() also prevents compiler
+   mischief.
 
- (*) Overlapping loads and stores within a particular CPU will appear to be
-     ordered within that CPU.  This means that for:
+ * Overlapping loads and stores within a particular CPU will appear to be
+   ordered within that CPU.  This means that for:
+
+   .. code-block:: c
 
 	a = READ_ONCE(*X); WRITE_ONCE(*X, b);
 
-     the CPU will only issue the following sequence of memory operations:
+   the CPU will only issue the following sequence of memory operations:
+
+   .. code-block::
 
 	a = LOAD *X, STORE *X = b
 
-     And for:
+   And for:
+
+   .. code-block:: c
 
 	WRITE_ONCE(*X, c); d = READ_ONCE(*X);
 
-     the CPU will only issue:
+   the CPU will only issue:
+
+   .. code-block::
 
 	STORE *X = c, d = LOAD *X
 
-     (Loads and stores overlap if they are targeted at overlapping pieces of
-     memory).
+   (Loads and stores overlap if they are targeted at overlapping pieces of
+   memory).
 
-And there are a number of things that _must_ or _must_not_ be assumed:
+And there are a number of things that **must** or **must not** be assumed:
 
- (*) It _must_not_ be assumed that the compiler will do what you want
-     with memory references that are not protected by READ_ONCE() and
-     WRITE_ONCE().  Without them, the compiler is within its rights to
-     do all sorts of "creative" transformations, which are covered in
-     the COMPILER BARRIER section.
+ * It **must not** be assumed that the compiler will do what you want
+   with memory references that are not protected by READ_ONCE() and
+   WRITE_ONCE().  Without them, the compiler is within its rights to
+   do all sorts of "creative" transformations, which are covered in
+   the COMPILER BARRIER section.
 
- (*) It _must_not_ be assumed that independent loads and stores will be issued
-     in the order given.  This means that for:
+ * It **must not** be assumed that independent loads and stores will be issued
+   in the order given.  This means that for:
+
+   .. code-block:: c
 
 	X = *A; Y = *B; *D = Z;
 
-     we may get any of the following sequences:
+   we may get any of the following sequences:
+
+   .. code-block::
 
 	X = LOAD *A,  Y = LOAD *B,  STORE *D = Z
 	X = LOAD *A,  STORE *D = Z, Y = LOAD *B
@@ -285,22 +243,30 @@ And there are a number of things that _must_ or _must_not_ be assumed:
 	STORE *D = Z, X = LOAD *A,  Y = LOAD *B
 	STORE *D = Z, Y = LOAD *B,  X = LOAD *A
 
- (*) It _must_ be assumed that overlapping memory accesses may be merged or
-     discarded.  This means that for:
+ * It **must** be assumed that overlapping memory accesses may be merged or
+   discarded.  This means that for:
+
+   .. code-block:: c
 
 	X = *A; Y = *(A + 4);
 
-     we may get any one of the following sequences:
+   we may get any one of the following sequences:
+
+   .. code-block::
 
 	X = LOAD *A; Y = LOAD *(A + 4);
 	Y = LOAD *(A + 4); X = LOAD *A;
 	{X, Y} = LOAD {*A, *(A + 4) };
 
-     And for:
+   And for:
+
+   .. code-block:: c
 
 	*A = X; *(A + 4) = Y;
 
-     we may get any of:
+   we may get any of:
+
+   .. code-block::
 
 	STORE *A = X; STORE *(A + 4) = Y;
 	STORE *(A + 4) = Y; STORE *A = X;
@@ -308,51 +274,49 @@ And there are a number of things that _must_ or _must_not_ be assumed:
 
 And there are anti-guarantees:
 
- (*) These guarantees do not apply to bitfields, because compilers often
-     generate code to modify these using non-atomic read-modify-write
-     sequences.  Do not attempt to use bitfields to synchronize parallel
-     algorithms.
+ * These guarantees do not apply to bitfields, because compilers often generate
+   code to modify these using non-atomic read-modify-write sequences.  Do not
+   attempt to use bitfields to synchronize parallel algorithms.
 
- (*) Even in cases where bitfields are protected by locks, all fields
-     in a given bitfield must be protected by one lock.  If two fields
-     in a given bitfield are protected by different locks, the compiler's
-     non-atomic read-modify-write sequences can cause an update to one
-     field to corrupt the value of an adjacent field.
+ * Even in cases where bitfields are protected by locks, all fields in a given
+   bitfield must be protected by one lock.  If two fields in a given bitfield
+   are protected by different locks, the compiler's non-atomic read-modify-write
+   sequences can cause an update to one field to corrupt the value of an
+   adjacent field.
 
- (*) These guarantees apply only to properly aligned and sized scalar
-     variables.  "Properly sized" currently means variables that are
-     the same size as "char", "short", "int" and "long".  "Properly
-     aligned" means the natural alignment, thus no constraints for
-     "char", two-byte alignment for "short", four-byte alignment for
-     "int", and either four-byte or eight-byte alignment for "long",
-     on 32-bit and 64-bit systems, respectively.  Note that these
-     guarantees were introduced into the C11 standard, so beware when
-     using older pre-C11 compilers (for example, gcc 4.6).  The portion
-     of the standard containing this guarantee is Section 3.14, which
-     defines "memory location" as follows:
+ * These guarantees apply only to properly aligned and sized scalar variables.
+   "Properly sized" currently means variables that are the same size as "char",
+   "short", "int" and "long".  "Properly aligned" means the natural alignment,
+   thus no constraints for "char", two-byte alignment for "short", four-byte
+   alignment for "int", and either four-byte or eight-byte alignment for "long",
+   on 32-bit and 64-bit systems, respectively.  Note that these guarantees were
+   introduced into the C11 standard, so beware when using older pre-C11
+   compilers (for example, gcc 4.6).  The portion of the standard containing
+   this guarantee is Section 3.14, which defines "memory location" as follows:
 
      	memory location
 		either an object of scalar type, or a maximal sequence
 		of adjacent bit-fields all having nonzero width
 
-		NOTE 1: Two threads of execution can update and access
-		separate memory locations without interfering with
-		each other.
+		.. note::
+		   Two threads of execution can update and access
+		   separate memory locations without interfering with
+		   each other.
 
-		NOTE 2: A bit-field and an adjacent non-bit-field member
-		are in separate memory locations. The same applies
-		to two bit-fields, if one is declared inside a nested
-		structure declaration and the other is not, or if the two
-		are separated by a zero-length bit-field declaration,
-		or if they are separated by a non-bit-field member
-		declaration. It is not safe to concurrently update two
-		bit-fields in the same structure if all members declared
-		between them are also bit-fields, no matter what the
-		sizes of those intervening bit-fields happen to be.
+		.. note::
+		   A bit-field and an adjacent non-bit-field member
+		   are in separate memory locations. The same applies
+		   to two bit-fields, if one is declared inside a nested
+		   structure declaration and the other is not, or if the two
+		   are separated by a zero-length bit-field declaration,
+		   or if they are separated by a non-bit-field member
+		   declaration. It is not safe to concurrently update two
+		   bit-fields in the same structure if all members declared
+		   between them are also bit-fields, no matter what the
+		   sizes of those intervening bit-fields happen to be.
 
 
-=========================
-WHAT ARE MEMORY BARRIERS?
+What are Memory Barriers?
 =========================
 
 As can be seen above, independent memory operations are effectively performed
@@ -371,7 +335,7 @@ override or suppress these tricks, allowing the code to sanely control the
 interaction of multiple CPUs and/or devices.
 
 
-VARIETIES OF MEMORY BARRIER
+Varieties of Memory Barrier
 ---------------------------
 
 Memory barriers come in four basic varieties:
@@ -387,19 +351,22 @@ Memory barriers come in four basic varieties:
      to have any effect on loads.
 
      A CPU can be viewed as committing a sequence of store operations to the
-     memory system as time progresses.  All stores _before_ a write barrier
-     will occur _before_ all the stores after the write barrier.
+     memory system as time progresses.  All stores **before** a write barrier
+     will occur **before** all the stores after the write barrier.
 
-     [!] Note that write barriers should normally be paired with read or
-     address-dependency barriers; see the "SMP barrier pairing" subsection.
+     .. note::
+        Write barriers should normally be paired with read or address-dependency
+        barriers; see the "SMP barrier pairing" subsection.
 
 
  (2) Address-dependency barriers (historical).
-     [!] This section is marked as HISTORICAL: it covers the long-obsolete
-     smp_read_barrier_depends() macro, the semantics of which are now
-     implicit in all marked accesses.  For more up-to-date information,
-     including how compiler transformations can sometimes break address
-     dependencies, see Documentation/RCU/rcu_dereference.rst.
+
+     .. warning::
+        This section is marked as HISTORICAL: it covers the long-obsolete
+        smp_read_barrier_depends() macro, the semantics of which are now
+        implicit in all marked accesses.  For more up-to-date information,
+        including how compiler transformations can sometimes break address
+        dependencies, see Documentation/RCU/rcu_dereference.rst.
 
      An address-dependency barrier is a weaker form of read barrier.  In the
      case where two loads are performed such that the second depends on the
@@ -424,20 +391,24 @@ Memory barriers come in four basic varieties:
      See the "Examples of memory barrier sequences" subsection for diagrams
      showing the ordering constraints.
 
-     [!] Note that the first load really has to have an _address_ dependency and
-     not a control dependency.  If the address for the second load is dependent
-     on the first load, but the dependency is through a conditional rather than
-     actually loading the address itself, then it's a _control_ dependency and
-     a full read barrier or better is required.  See the "Control dependencies"
-     subsection for more information.
+     .. note::
 
-     [!] Note that address-dependency barriers should normally be paired with
-     write barriers; see the "SMP barrier pairing" subsection.
+        The first load really has to have an **address** dependency and not a
+        control dependency.  If the address for the second load is dependent
+        on the first load, but the dependency is through a conditional rather
+        than actually loading the address itself, then it's a **control**
+        dependency and a full read barrier or better is required.  See the
+        "Control dependencies" subsection for more information.
 
-     [!] Kernel release v5.9 removed kernel APIs for explicit address-
-     dependency barriers.  Nowadays, APIs for marking loads from shared
-     variables such as READ_ONCE() and rcu_dereference() provide implicit
-     address-dependency barriers.
+     .. note::
+        Address-dependency barriers should normally be paired with write
+        barriers; see the "SMP barrier pairing" subsection.
+
+     .. warning::
+        Kernel release v5.9 removed kernel APIs for explicit address-dependency
+        barriers.  Nowadays, APIs for marking loads from shared variables such
+        as READ_ONCE() and rcu_dereference() provide implicit address-dependency
+        barriers.
 
  (3) Read (or load) memory barriers.
 
@@ -452,8 +423,9 @@ Memory barriers come in four basic varieties:
      Read memory barriers imply address-dependency barriers, and so can
      substitute for them.
 
-     [!] Note that read barriers should normally be paired with write barriers;
-     see the "SMP barrier pairing" subsection.
+     .. warning::
+        Note that read barriers should normally be paired with write barriers;
+        see the "SMP barrier pairing" subsection.
 
 
  (4) General memory barriers.
@@ -499,7 +471,7 @@ And a couple of implicit varieties:
 
      The use of ACQUIRE and RELEASE operations generally precludes the need
      for other sorts of memory barrier.  In addition, a RELEASE+ACQUIRE pair is
-     -not- guaranteed to act as a full memory barrier.  However, after an
+     **not** guaranteed to act as a full memory barrier.  However, after an
      ACQUIRE on a given variable, all memory accesses preceding any prior
      RELEASE on that same variable are guaranteed to be visible.  In other
      words, within a given variable's critical section, all accesses of all
@@ -521,50 +493,53 @@ there won't be any such interaction in any particular piece of code, then
 memory barriers are unnecessary in that piece of code.
 
 
-Note that these are the _minimum_ guarantees.  Different architectures may give
-more substantial guarantees, but they may _not_ be relied upon outside of arch
-specific code.
+Note that these are the **minimum** guarantees.  Different architectures may
+give more substantial guarantees, but they may **not** be relied upon outside
+of arch specific code.
 
 
-WHAT MAY NOT BE ASSUMED ABOUT MEMORY BARRIERS?
+What May Not be Assumed About Memory Barriers?
 ----------------------------------------------
 
 There are certain things that the Linux kernel memory barriers do not guarantee:
 
- (*) There is no guarantee that any of the memory accesses specified before a
-     memory barrier will be _complete_ by the completion of a memory barrier
-     instruction; the barrier can be considered to draw a line in that CPU's
-     access queue that accesses of the appropriate type may not cross.
+ * There is no guarantee that any of the memory accesses specified before a
+   memory barrier will be _complete_ by the completion of a memory barrier
+   instruction; the barrier can be considered to draw a line in that CPU's
+   access queue that accesses of the appropriate type may not cross.
 
- (*) There is no guarantee that issuing a memory barrier on one CPU will have
-     any direct effect on another CPU or any other hardware in the system.  The
-     indirect effect will be the order in which the second CPU sees the effects
-     of the first CPU's accesses occur, but see the next point:
+ * There is no guarantee that issuing a memory barrier on one CPU will have
+   any direct effect on another CPU or any other hardware in the system.  The
+   indirect effect will be the order in which the second CPU sees the effects
+   of the first CPU's accesses occur, but see the next point:
 
- (*) There is no guarantee that a CPU will see the correct order of effects
-     from a second CPU's accesses, even _if_ the second CPU uses a memory
-     barrier, unless the first CPU _also_ uses a matching memory barrier (see
-     the subsection on "SMP Barrier Pairing").
+ * There is no guarantee that a CPU will see the correct order of effects
+   from a second CPU's accesses, even _if_ the second CPU uses a memory
+   barrier, unless the first CPU _also_ uses a matching memory barrier (see
+   the subsection on "SMP Barrier Pairing").
 
- (*) There is no guarantee that some intervening piece of off-the-CPU
-     hardware[*] will not reorder the memory accesses.  CPU cache coherency
-     mechanisms should propagate the indirect effects of a memory barrier
-     between CPUs, but might not do so in order.
+ * There is no guarantee that some intervening piece of off-the-CPU
+   hardware [#dma_coherency]_ will not reorder the memory accesses.  CPU
+   cache coherency mechanisms should propagate the indirect effects of a
+   memory barrier between CPUs, but might not do so in order.
 
-	[*] For information on bus mastering DMA and coherency please read:
+   .. [#dma_coherency] For information on bus mastering DMA and coherency
+      please read:
 
-	    Documentation/driver-api/pci/pci.rst
-	    Documentation/core-api/dma-api-howto.rst
-	    Documentation/core-api/dma-api.rst
+      * Documentation/driver-api/pci/pci.rst
+      * Documentation/core-api/dma-api-howto.rst
+      * Documentation/core-api/dma-api.rst
 
 
-ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
+Address-Dependency Barriers (Historical)
 ----------------------------------------
-[!] This section is marked as HISTORICAL: it covers the long-obsolete
-smp_read_barrier_depends() macro, the semantics of which are now implicit
-in all marked accesses.  For more up-to-date information, including
-how compiler transformations can sometimes break address dependencies,
-see Documentation/RCU/rcu_dereference.rst.
+
+.. warning::
+   This section is marked as HISTORICAL: it covers the long-obsolete
+   smp_read_barrier_depends() macro, the semantics of which are now implicit
+   in all marked accesses.  For more up-to-date information, including
+   how compiler transformations can sometimes break address dependencies,
+   see Documentation/RCU/rcu_dereference.rst.
 
 As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
 DEC Alpha, which means that about the only people who need to pay attention
@@ -573,13 +548,14 @@ and those working on READ_ONCE() itself.  For those who need it, and for
 those who are interested in the history, here is the story of
 address-dependency barriers.
 
-[!] While address dependencies are observed in both load-to-load and
-load-to-store relations, address-dependency barriers are not necessary
-for load-to-store situations.
+.. warning::
+   While address dependencies are observed in both load-to-load and
+   load-to-store relations, address-dependency barriers are not necessary
+   for load-to-store situations.
 
 The requirement of address-dependency barriers is a little subtle, and
 it's not always obvious that they're needed.  To illustrate, consider the
-following sequence of events:
+following sequence of events::
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -590,17 +566,18 @@ following sequence of events:
 			      Q = READ_ONCE_OLD(P);
 			      D = *Q;
 
-[!] READ_ONCE_OLD() corresponds to READ_ONCE() of pre-4.15 kernel, which
-doesn't imply an address-dependency barrier.
+.. warning::
+   READ_ONCE_OLD() corresponds to READ_ONCE() of pre-4.15 kernel, which doesn't
+   imply an address-dependency barrier.
 
 There's a clear address dependency here, and it would seem that by the end of
-the sequence, Q must be either &A or &B, and that:
+the sequence, Q must be either &A or &B, and that::
 
 	(Q == &A) implies (D == 1)
 	(Q == &B) implies (D == 4)
 
-But!  CPU 2's perception of P may be updated _before_ its perception of B, thus
-leading to the following situation:
+But!  CPU 2's perception of P may be updated **before** its perception of B,
+thus leading to the following situation::
 
 	(Q == &B) and (D == 2) ????
 
@@ -609,7 +586,7 @@ isn't, and this behaviour can be observed on certain real CPUs (such as the DEC
 Alpha).
 
 To deal with this, READ_ONCE() provides an implicit address-dependency barrier
-since kernel release v4.15:
+since kernel release v4.15::
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -625,23 +602,26 @@ This enforces the occurrence of one of the two implications, and prevents the
 third possibility from arising.
 
 
-[!] Note that this extremely counterintuitive situation arises most easily on
-machines with split caches, so that, for example, one cache bank processes
-even-numbered cache lines and the other bank processes odd-numbered cache
-lines.  The pointer P might be stored in an odd-numbered cache line, and the
-variable B might be stored in an even-numbered cache line.  Then, if the
-even-numbered bank of the reading CPU's cache is extremely busy while the
-odd-numbered bank is idle, one can see the new value of the pointer P (&B),
-but the old value of the variable B (2).
+.. note::
+   This extremely counterintuitive situation arises most easily on machines
+   with split caches, so that, for example, one cache bank processes
+   even-numbered cache lines and the other bank processes odd-numbered cache
+   lines.  The pointer P might be stored in an odd-numbered cache line, and the
+   variable B might be stored in an even-numbered cache line.  Then, if the
+   even-numbered bank of the reading CPU's cache is extremely busy while the
+   odd-numbered bank is idle, one can see the new value of the pointer P (&B),
+   but the old value of the variable B (2).
 
 
 An address-dependency barrier is not required to order dependent writes
 because the CPUs that the Linux kernel supports don't do writes until they
 are certain (1) that the write will actually happen, (2) of the location of
-the write, and (3) of the value to be written.
-But please carefully read the "CONTROL DEPENDENCIES" section and the
-Documentation/RCU/rcu_dereference.rst file:  The compiler can and does break
-dependencies in a great many highly creative ways.
+the write, and (3) of the value to be written.  But please carefully read the
+"CONTROL DEPENDENCIES" section and the Documentation/RCU/rcu_dereference.rst
+file:  The compiler can and does break dependencies in a great many highly
+creative ways.
+
+.. code-block::
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -653,8 +633,8 @@ dependencies in a great many highly creative ways.
 			      WRITE_ONCE(*Q, 5);
 
 Therefore, no address-dependency barrier is required to order the read into
-Q with the store into *Q.  In other words, this outcome is prohibited,
-even without an implicit address-dependency barrier of modern READ_ONCE():
+Q with the store into \*Q.  In other words, this outcome is prohibited,
+even without an implicit address-dependency barrier of modern READ_ONCE()::
 
 	(Q == &B) && (B == 4)
 
@@ -677,7 +657,7 @@ pointer to be replaced with a new modified target, without the replacement
 target appearing to be incompletely initialised.
 
 
-CONTROL DEPENDENCIES
+Control Dependencies
 --------------------
 
 Control dependencies can be a bit tricky because current compilers do
@@ -688,6 +668,8 @@ A load-load control dependency requires a full read memory barrier, not
 simply an (implicit) address-dependency barrier to make it work correctly.
 Consider the following bit of code:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	<implicit address-dependency barrier>
 	if (q) {
@@ -701,6 +683,8 @@ by attempting to predict the outcome in advance, so that other CPUs see
 the load from b as having happened before the load from a.  In such a case
 what's actually required is:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	if (q) {
 		<read barrier>
@@ -710,6 +694,8 @@ what's actually required is:
 However, stores are not speculated.  This means that ordering -is- provided
 for load-store control dependencies, as in the following example:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	if (q) {
 		WRITE_ONCE(b, 1);
@@ -727,13 +713,17 @@ variable 'a' is always non-zero, it would be well within its rights
 to optimize the original example by eliminating the "if" statement
 as follows:
 
+.. code-block:: c
+
 	q = a;
 	b = 1;  /* BUG: Compiler and CPU can both reorder!!! */
 
 So don't leave out the READ_ONCE().
 
 It is tempting to try to enforce ordering on identical stores on both
-branches of the "if" statement as follows:
+branches of the "if" statement as follows
+
+.. code-block:: c
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -749,6 +739,8 @@ branches of the "if" statement as follows:
 Unfortunately, current compilers will transform this as follows at high
 optimization levels:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	barrier();
 	WRITE_ONCE(b, 1);  /* BUG: No ordering vs. load from a!!! */
@@ -767,6 +759,8 @@ assembly code even after all compiler optimizations have been applied.
 Therefore, if you need ordering in this example, you need explicit
 memory barriers, for example, smp_store_release():
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	if (q) {
 		smp_store_release(&b, 1);
@@ -779,6 +773,8 @@ memory barriers, for example, smp_store_release():
 In contrast, without explicit memory barriers, two-legged-if control
 ordering is guaranteed only when the stores differ, for example:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	if (q) {
 		WRITE_ONCE(b, 1);
@@ -795,6 +791,8 @@ In addition, you need to be careful what you do with the local variable 'q',
 otherwise the compiler might be able to guess the value and again remove
 the needed conditional.  For example:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	if (q % MAX) {
 		WRITE_ONCE(b, 1);
@@ -808,6 +806,8 @@ If MAX is defined to be 1, then the compiler knows that (q % MAX) is
 equal to zero, in which case the compiler is within its rights to
 transform the above code into the following:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	WRITE_ONCE(b, 2);
 	do_something_else();
@@ -819,6 +819,8 @@ is gone, and the barrier won't bring it back.  Therefore, if you are
 relying on this ordering, you should make sure that MAX is greater than
 one, perhaps as follows:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	BUILD_BUG_ON(MAX <= 1); /* Order load from a with store to b. */
 	if (q % MAX) {
@@ -836,6 +838,8 @@ of the 'if' statement.
 You must also be careful not to rely too much on boolean short-circuit
 evaluation.  Consider this example:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	if (q || 1 > 0)
 		WRITE_ONCE(b, 1);
@@ -844,6 +848,8 @@ Because the first condition cannot fault and the second condition is
 always true, the compiler can transform this example as following,
 defeating control dependency:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	WRITE_ONCE(b, 1);
 
@@ -856,6 +862,8 @@ In addition, control dependencies apply only to the then-clause and
 else-clause of the if-statement in question.  In particular, it does
 not necessarily apply to code following the if-statement:
 
+.. code-block:: c
+
 	q = READ_ONCE(a);
 	if (q) {
 		WRITE_ONCE(b, 1);
@@ -871,6 +879,8 @@ of reasoning, the compiler might compile the two writes to 'b' as
 conditional-move instructions, as in this fanciful pseudo-assembly
 language:
 
+.. code-block:: asm
+
 	ld r1,a
 	cmp r1,$0
 	cmov,ne r4,$1
@@ -893,50 +903,50 @@ for more information.
 
 In summary:
 
-  (*) Control dependencies can order prior loads against later stores.
-      However, they do -not- guarantee any other sort of ordering:
-      Not prior loads against later loads, nor prior stores against
-      later anything.  If you need these other forms of ordering,
-      use smp_rmb(), smp_wmb(), or, in the case of prior stores and
-      later loads, smp_mb().
+  * Control dependencies can order prior loads against later stores.
+    However, they do **not** guarantee any other sort of ordering:
+    Not prior loads against later loads, nor prior stores against
+    later anything.  If you need these other forms of ordering,
+    use smp_rmb(), smp_wmb(), or, in the case of prior stores and
+    later loads, smp_mb().
 
-  (*) If both legs of the "if" statement begin with identical stores to
-      the same variable, then those stores must be ordered, either by
-      preceding both of them with smp_mb() or by using smp_store_release()
-      to carry out the stores.  Please note that it is -not- sufficient
-      to use barrier() at beginning of each leg of the "if" statement
-      because, as shown by the example above, optimizing compilers can
-      destroy the control dependency while respecting the letter of the
-      barrier() law.
+  * If both legs of the "if" statement begin with identical stores to
+    the same variable, then those stores must be ordered, either by
+    preceding both of them with smp_mb() or by using smp_store_release()
+    to carry out the stores.  Please note that it is -not- sufficient
+    to use barrier() at beginning of each leg of the "if" statement
+    because, as shown by the example above, optimizing compilers can
+    destroy the control dependency while respecting the letter of the
+    barrier() law.
 
-  (*) Control dependencies require at least one run-time conditional
-      between the prior load and the subsequent store, and this
-      conditional must involve the prior load.  If the compiler is able
-      to optimize the conditional away, it will have also optimized
-      away the ordering.  Careful use of READ_ONCE() and WRITE_ONCE()
-      can help to preserve the needed conditional.
+  * Control dependencies require at least one run-time conditional
+    between the prior load and the subsequent store, and this
+    conditional must involve the prior load.  If the compiler is able
+    to optimize the conditional away, it will have also optimized
+    away the ordering.  Careful use of READ_ONCE() and WRITE_ONCE()
+    can help to preserve the needed conditional.
 
-  (*) Control dependencies require that the compiler avoid reordering the
-      dependency into nonexistence.  Careful use of READ_ONCE() or
-      atomic{,64}_read() can help to preserve your control dependency.
-      Please see the COMPILER BARRIER section for more information.
+  * Control dependencies require that the compiler avoid reordering the
+    dependency into nonexistence.  Careful use of READ_ONCE() or
+    atomic{,64}_read() can help to preserve your control dependency.
+    Please see the COMPILER BARRIER section for more information.
 
-  (*) Control dependencies apply only to the then-clause and else-clause
-      of the if-statement containing the control dependency, including
-      any functions that these two clauses call.  Control dependencies
-      do -not- apply to code following the if-statement containing the
-      control dependency.
+  * Control dependencies apply only to the then-clause and else-clause
+    of the if-statement containing the control dependency, including
+    any functions that these two clauses call.  Control dependencies
+    do **not** apply to code following the if-statement containing the
+    control dependency.
 
-  (*) Control dependencies pair normally with other types of barriers.
+  * Control dependencies pair normally with other types of barriers.
 
-  (*) Control dependencies do -not- provide multicopy atomicity.  If you
-      need all the CPUs to see a given store at the same time, use smp_mb().
+  * Control dependencies do **not** provide multicopy atomicity.  If you
+    need all the CPUs to see a given store at the same time, use smp_mb().
 
-  (*) Compilers do not understand control dependencies.  It is therefore
-      your job to ensure that they do not break your code.
+  * Compilers do not understand control dependencies.  It is therefore
+    your job to ensure that they do not break your code.
 
 
-SMP BARRIER PAIRING
+SMP Barrier Pairing
 -------------------
 
 When dealing with CPU-CPU interactions, certain types of memory barrier should
@@ -950,7 +960,7 @@ with an address-dependency barrier, a control dependency, an acquire barrier,
 a release barrier, a read barrier, or a general barrier.  Similarly a
 read barrier, control dependency, or an address-dependency barrier pairs
 with a write barrier, an acquire barrier, a release barrier, or a
-general barrier:
+general barrier::
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -960,7 +970,7 @@ general barrier:
 			      <read barrier>
 			      y = READ_ONCE(a);
 
-Or:
+Or::
 
 	CPU 1		      CPU 2
 	===============	      ===============================
@@ -970,7 +980,7 @@ Or:
 			      <implicit address-dependency barrier>
 			      y = *x;
 
-Or even:
+Or even::
 
 	CPU 1		      CPU 2
 	===============	      ===============================
@@ -986,9 +996,10 @@ Or even:
 Basically, the read barrier always has to be there, even though it can be of
 the "weaker" type.
 
-[!] Note that the stores before the write barrier would normally be expected to
-match the loads after the read barrier or the address-dependency barrier, and
-vice versa:
+.. note::
+   The stores before the write barrier would normally be expected to
+   match the loads after the read barrier or the address-dependency barrier, and
+   vice versa::
 
 	CPU 1                               CPU 2
 	===================                 ===================
@@ -999,11 +1010,11 @@ vice versa:
 	WRITE_ONCE(d, 4);    }----   --->{  y = READ_ONCE(b);
 
 
-EXAMPLES OF MEMORY BARRIER SEQUENCES
+Examples of Memory Barrier Sequences
 ------------------------------------
 
 Firstly, write barriers act as partial orderings on store operations.
-Consider the following sequence of events:
+Consider the following sequence of events::
 
 	CPU 1
 	=======================
@@ -1017,7 +1028,7 @@ Consider the following sequence of events:
 This sequence of events is committed to the memory coherence system in an order
 that the rest of the system might perceive as the unordered set of { STORE A,
 STORE B, STORE C } all occurring before the unordered set of { STORE D, STORE E
-}:
+}::
 
 	+-------+       :      :
 	|       |       +------+
@@ -1041,7 +1052,7 @@ STORE B, STORE C } all occurring before the unordered set of { STORE D, STORE E
 
 
 Secondly, address-dependency barriers act as partial orderings on address-
-dependent loads.  Consider the following sequence of events:
+dependent loads.  Consider the following sequence of events::
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1054,7 +1065,7 @@ dependent loads.  Consider the following sequence of events:
 				LOAD *C (reads B)
 
 Without intervention, CPU 2 may perceive the events on CPU 1 in some
-effectively random order, despite the write barrier issued by CPU 1:
+effectively random order, despite the write barrier issued by CPU 1::
 
 	+-------+       :      :                :       :
 	|       |       +------+                +-------+  | Sequence of update
@@ -1083,11 +1094,11 @@ effectively random order, despite the write barrier issued by CPU 1:
 	                                        :       :
 
 
-In the above example, CPU 2 perceives that B is 7, despite the load of *C
+In the above example, CPU 2 perceives that B is 7, despite the load of \*C
 (which would be B) coming after the LOAD of C.
 
 If, however, an address-dependency barrier were to be placed between the load
-of C and the load of *C (ie: B) on CPU 2:
+of C and the load of \*C (ie: B) on CPU 2::
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1100,7 +1111,7 @@ of C and the load of *C (ie: B) on CPU 2:
 				<address-dependency barrier>
 				LOAD *C (reads B)
 
-then the following will occur:
+then the following will occur::
 
 	+-------+       :      :                :       :
 	|       |       +------+                +-------+
@@ -1128,7 +1139,7 @@ then the following will occur:
 
 
 And thirdly, a read barrier acts as a partial order on loads.  Consider the
-following sequence of events:
+following sequence of events::
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1140,7 +1151,7 @@ following sequence of events:
 				LOAD A
 
 Without intervention, CPU 2 may then choose to perceive the events on CPU 1 in
-some effectively random order, despite the write barrier issued by CPU 1:
+some effectively random order, despite the write barrier issued by CPU 1::
 
 	+-------+       :      :                :       :
 	|       |       +------+                +-------+
@@ -1164,7 +1175,7 @@ some effectively random order, despite the write barrier issued by CPU 1:
 
 
 If, however, a read barrier were to be placed between the load of B and the
-load of A on CPU 2:
+load of A on CPU 2::
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1177,7 +1188,7 @@ load of A on CPU 2:
 				LOAD A
 
 then the partial ordering imposed by CPU 1 will be perceived correctly by CPU
-2:
+2::
 
 	+-------+       :      :                :       :
 	|       |       +------+                +-------+
@@ -1200,7 +1211,7 @@ then the partial ordering imposed by CPU 1 will be perceived correctly by CPU
 
 
 To illustrate this more completely, consider what could happen if the code
-contained a load of A either side of the read barrier:
+contained a load of A either side of the read barrier::
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1214,7 +1225,7 @@ contained a load of A either side of the read barrier:
 				LOAD A [second load of A]
 
 Even though the two loads of A both occur after the load of B, they may both
-come up with different values:
+come up with different values::
 
 	+-------+       :      :                :       :
 	|       |       +------+                +-------+
@@ -1240,7 +1251,7 @@ come up with different values:
 
 
 But it may be that the update to A from CPU 1 becomes perceptible to CPU 2
-before the read barrier completes anyway:
+before the read barrier completes anyway::
 
 	+-------+       :      :                :       :
 	|       |       +------+                +-------+
@@ -1270,7 +1281,7 @@ load of B came up with B == 2.  No such guarantee exists for the first load of
 A; that may come up with either A == 0 or A == 1.
 
 
-READ MEMORY BARRIERS VS LOAD SPECULATION
+Read Memory Barriers vs Load Speculation
 ----------------------------------------
 
 Many CPUs speculate with loads: that is they see that they will need to load an
@@ -1284,7 +1295,7 @@ It may turn out that the CPU didn't actually need the value - perhaps because a
 branch circumvented the load - in which case it can discard the value or just
 cache it for later use.
 
-Consider:
+Consider::
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1293,7 +1304,7 @@ Consider:
 				DIVIDE		} take a long time to perform
 				LOAD A
 
-Which might appear as this:
+Which might appear as this::
 
 	                                        :       :       +-------+
 	                                        +-------+       |       |
@@ -1312,7 +1323,7 @@ Which might appear as this:
 
 
 Placing a read barrier or an address-dependency barrier just before the second
-load:
+load::
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1324,7 +1335,7 @@ load:
 
 will force any value speculatively obtained to be reconsidered to an extent
 dependent on the type of barrier used.  If there was no change made to the
-speculated memory location, then the speculated value will just be used:
+speculated memory location, then the speculated value will just be used::
 
 	                                        :       :       +-------+
 	                                        +-------+       |       |
@@ -1346,7 +1357,7 @@ speculated memory location, then the speculated value will just be used:
 
 
 but if there was an update or an invalidation from another CPU pending, then
-the speculation will be cancelled and the value reloaded:
+the speculation will be cancelled and the value reloaded::
 
 	                                        :       :       +-------+
 	                                        +-------+       |       |
@@ -1367,20 +1378,20 @@ the speculation will be cancelled and the value reloaded:
 	retrieved                               :       :       +-------+
 
 
-MULTICOPY ATOMICITY
---------------------
+Multicopy Atomicity
+-------------------
 
 Multicopy atomicity is a deeply intuitive notion about ordering that is
 not always provided by real computer systems, namely that a given store
 becomes visible at the same time to all CPUs, or, alternatively, that all
 CPUs agree on the order in which all stores become visible.  However,
 support of full multicopy atomicity would rule out valuable hardware
-optimizations, so a weaker form called ``other multicopy atomicity''
+optimizations, so a weaker form called "other multicopy atomicity"
 instead guarantees only that a given store becomes visible at the same
 time to all -other- CPUs.  The remainder of this document discusses this
-weaker form, but for brevity will call it simply ``multicopy atomicity''.
+weaker form, but for brevity will call it simply "multicopy atomicity".
 
-The following example demonstrates multicopy atomicity:
+The following example demonstrates multicopy atomicity::
 
 	CPU 1			CPU 2			CPU 3
 	=======================	=======================	=======================
@@ -1413,7 +1424,7 @@ from X must indeed also return 1.
 However, dependencies, read barriers, and write barriers are not always
 able to compensate for non-multicopy atomicity.  For example, suppose
 that CPU 2's general barrier is removed from the above example, leaving
-only the data dependency shown below:
+only the data dependency shown below::
 
 	CPU 1			CPU 2			CPU 3
 	=======================	=======================	=======================
@@ -1441,6 +1452,8 @@ which means that only those CPUs on the chain are guaranteed to agree
 on the combined order of the accesses.  For example, switching to C code
 in deference to the ghost of Herman Hollerith:
 
+.. code-block:: c
+
 	int u, v, x, y, z;
 
 	void cpu0(void)
@@ -1473,23 +1486,23 @@ in deference to the ghost of Herman Hollerith:
 
 Because cpu0(), cpu1(), and cpu2() participate in a chain of
 smp_store_release()/smp_load_acquire() pairs, the following outcome
-is prohibited:
+is prohibited::
 
 	r0 == 1 && r1 == 1 && r2 == 1
 
 Furthermore, because of the release-acquire relationship between cpu0()
 and cpu1(), cpu1() must see cpu0()'s writes, so that the following
-outcome is prohibited:
+outcome is prohibited::
 
 	r1 == 1 && r5 == 0
 
 However, the ordering provided by a release-acquire chain is local
 to the CPUs participating in that chain and does not apply to cpu3(),
-at least aside from stores.  Therefore, the following outcome is possible:
+at least aside from stores.  Therefore, the following outcome is possible::
 
 	r0 == 0 && r1 == 1 && r2 == 1 && r3 == 0 && r4 == 0
 
-As an aside, the following outcome is also possible:
+As an aside, the following outcome is also possible::
 
 	r0 == 0 && r1 == 1 && r2 == 1 && r3 == 0 && r4 == 0 && r5 == 1
 
@@ -1505,8 +1518,8 @@ intended order.
 
 However, please keep in mind that smp_load_acquire() is not magic.
 In particular, it simply reads from its argument with ordering.  It does
--not- ensure that any particular value will be read.  Therefore, the
-following outcome is possible:
+*not* ensure that any particular value will be read.  Therefore, the
+following outcome is possible::
 
 	r0 == 0 && r1 == 0 && r2 == 0 && r5 == 0
 
@@ -1517,23 +1530,21 @@ To reiterate, if your code requires full ordering of all operations,
 use general barriers throughout.
 
 
-========================
-EXPLICIT KERNEL BARRIERS
+Explicit Kernel Barriers
 ========================
 
 The Linux kernel has a variety of different barriers that act at different
 levels:
 
-  (*) Compiler barrier.
-
-  (*) CPU memory barriers.
+  * Compiler barrier.
+  * CPU memory barriers.
 
 
-COMPILER BARRIER
+Compiler Barrier
 ----------------
 
 The Linux kernel has an explicit compiler barrier function that prevents the
-compiler from moving the memory accesses either side of it to the other side:
+compiler from moving the memory accesses either side of it to the other side::
 
 	barrier();
 
@@ -1544,145 +1555,175 @@ accesses flagged by the READ_ONCE() or WRITE_ONCE().
 
 The barrier() function has the following effects:
 
- (*) Prevents the compiler from reordering accesses following the
-     barrier() to precede any accesses preceding the barrier().
-     One example use for this property is to ease communication between
-     interrupt-handler code and the code that was interrupted.
+ * Prevents the compiler from reordering accesses following the barrier()
+   to precede any accesses preceding the barrier().  One example use for this
+   property is to ease communication between interrupt-handler code and the
+   code that was interrupted.
 
- (*) Within a loop, forces the compiler to load the variables used
-     in that loop's conditional on each pass through that loop.
+ * Within a loop, forces the compiler to load the variables used in that
+   loop's conditional on each pass through that loop.
 
 The READ_ONCE() and WRITE_ONCE() functions can prevent any number of
 optimizations that, while perfectly safe in single-threaded code, can
 be fatal in concurrent code.  Here are some examples of these sorts
 of optimizations:
 
- (*) The compiler is within its rights to reorder loads and stores
-     to the same variable, and in some cases, the CPU is within its
-     rights to reorder loads to the same variable.  This means that
-     the following code:
+ * The compiler is within its rights to reorder loads and stores
+   to the same variable, and in some cases, the CPU is within its
+   rights to reorder loads to the same variable.  This means that
+   the following code:
+
+   .. code-block:: c
 
 	a[0] = x;
 	a[1] = x;
 
-     Might result in an older value of x stored in a[1] than in a[0].
-     Prevent both the compiler and the CPU from doing this as follows:
+   Might result in an older value of x stored in a[1] than in a[0].
+   Prevent both the compiler and the CPU from doing this as follows:
+
+   .. code-block:: c
 
 	a[0] = READ_ONCE(x);
 	a[1] = READ_ONCE(x);
 
-     In short, READ_ONCE() and WRITE_ONCE() provide cache coherence for
-     accesses from multiple CPUs to a single variable.
+   In short, READ_ONCE() and WRITE_ONCE() provide cache coherence for
+   accesses from multiple CPUs to a single variable.
 
- (*) The compiler is within its rights to merge successive loads from
-     the same variable.  Such merging can cause the compiler to "optimize"
-     the following code:
+ * The compiler is within its rights to merge successive loads from
+   the same variable.  Such merging can cause the compiler to "optimize"
+   the following code:
+
+   .. code-block:: c
 
 	while (tmp = a)
 		do_something_with(tmp);
 
-     into the following code, which, although in some sense legitimate
-     for single-threaded code, is almost certainly not what the developer
-     intended:
+   into the following code, which, although in some sense legitimate
+   for single-threaded code, is almost certainly not what the developer
+   intended:
+
+   .. code-block:: c
 
 	if (tmp = a)
 		for (;;)
 			do_something_with(tmp);
 
-     Use READ_ONCE() to prevent the compiler from doing this to you:
+   Use READ_ONCE() to prevent the compiler from doing this to you:
+
+   .. code-block::
 
 	while (tmp = READ_ONCE(a))
 		do_something_with(tmp);
 
- (*) The compiler is within its rights to reload a variable, for example,
-     in cases where high register pressure prevents the compiler from
-     keeping all data of interest in registers.  The compiler might
-     therefore optimize the variable 'tmp' out of our previous example:
+ * The compiler is within its rights to reload a variable, for example,
+   in cases where high register pressure prevents the compiler from
+   keeping all data of interest in registers.  The compiler might
+   therefore optimize the variable 'tmp' out of our previous example:
+
+   .. code-block:: c
 
 	while (tmp = a)
 		do_something_with(tmp);
 
-     This could result in the following code, which is perfectly safe in
-     single-threaded code, but can be fatal in concurrent code:
+   This could result in the following code, which is perfectly safe in
+   single-threaded code, but can be fatal in concurrent code:
+
+   .. code-block:: c
 
 	while (a)
 		do_something_with(a);
 
-     For example, the optimized version of this code could result in
-     passing a zero to do_something_with() in the case where the variable
-     a was modified by some other CPU between the "while" statement and
-     the call to do_something_with().
+   For example, the optimized version of this code could result in
+   passing a zero to do_something_with() in the case where the variable
+   a was modified by some other CPU between the "while" statement and
+   the call to do_something_with().
 
-     Again, use READ_ONCE() to prevent the compiler from doing this:
+   Again, use READ_ONCE() to prevent the compiler from doing this:
+
+   .. code-block:: c
 
 	while (tmp = READ_ONCE(a))
 		do_something_with(tmp);
 
-     Note that if the compiler runs short of registers, it might save
-     tmp onto the stack.  The overhead of this saving and later restoring
-     is why compilers reload variables.  Doing so is perfectly safe for
-     single-threaded code, so you need to tell the compiler about cases
-     where it is not safe.
+   Note that if the compiler runs short of registers, it might save
+   tmp onto the stack.  The overhead of this saving and later restoring
+   is why compilers reload variables.  Doing so is perfectly safe for
+   single-threaded code, so you need to tell the compiler about cases
+   where it is not safe.
 
- (*) The compiler is within its rights to omit a load entirely if it knows
-     what the value will be.  For example, if the compiler can prove that
-     the value of variable 'a' is always zero, it can optimize this code:
+ * The compiler is within its rights to omit a load entirely if it knows
+   what the value will be.  For example, if the compiler can prove that
+   the value of variable 'a' is always zero, it can optimize this code:
+
+   .. code-block:: c
 
 	while (tmp = a)
 		do_something_with(tmp);
 
-     Into this:
+   Into this:
+
+   .. code-block:: c
 
 	do { } while (0);
 
-     This transformation is a win for single-threaded code because it
-     gets rid of a load and a branch.  The problem is that the compiler
-     will carry out its proof assuming that the current CPU is the only
-     one updating variable 'a'.  If variable 'a' is shared, then the
-     compiler's proof will be erroneous.  Use READ_ONCE() to tell the
-     compiler that it doesn't know as much as it thinks it does:
+   This transformation is a win for single-threaded code because it
+   gets rid of a load and a branch.  The problem is that the compiler
+   will carry out its proof assuming that the current CPU is the only
+   one updating variable 'a'.  If variable 'a' is shared, then the
+   compiler's proof will be erroneous.  Use READ_ONCE() to tell the
+   compiler that it doesn't know as much as it thinks it does:
+   
+   .. code-block:: c
 
 	while (tmp = READ_ONCE(a))
 		do_something_with(tmp);
 
-     But please note that the compiler is also closely watching what you
-     do with the value after the READ_ONCE().  For example, suppose you
-     do the following and MAX is a preprocessor macro with the value 1:
+   But please note that the compiler is also closely watching what you
+   do with the value after the READ_ONCE().  For example, suppose you
+   do the following and MAX is a preprocessor macro with the value 1:
+
+   .. code-block:: c
 
 	while ((tmp = READ_ONCE(a)) % MAX)
 		do_something_with(tmp);
 
-     Then the compiler knows that the result of the "%" operator applied
-     to MAX will always be zero, again allowing the compiler to optimize
-     the code into near-nonexistence.  (It will still load from the
-     variable 'a'.)
+   Then the compiler knows that the result of the "%" operator applied
+   to MAX will always be zero, again allowing the compiler to optimize
+   the code into near-nonexistence.  (It will still load from the
+   variable 'a'.)
 
- (*) Similarly, the compiler is within its rights to omit a store entirely
-     if it knows that the variable already has the value being stored.
-     Again, the compiler assumes that the current CPU is the only one
-     storing into the variable, which can cause the compiler to do the
-     wrong thing for shared variables.  For example, suppose you have
-     the following:
+ * Similarly, the compiler is within its rights to omit a store entirely
+   if it knows that the variable already has the value being stored.
+   Again, the compiler assumes that the current CPU is the only one
+   storing into the variable, which can cause the compiler to do the
+   wrong thing for shared variables.  For example, suppose you have
+   the following:
+
+   .. code-block:: c
 
 	a = 0;
 	... Code that does not store to variable a ...
 	a = 0;
 
-     The compiler sees that the value of variable 'a' is already zero, so
-     it might well omit the second store.  This would come as a fatal
-     surprise if some other CPU might have stored to variable 'a' in the
-     meantime.
+   The compiler sees that the value of variable 'a' is already zero, so
+   it might well omit the second store.  This would come as a fatal
+   surprise if some other CPU might have stored to variable 'a' in the
+   meantime.
 
-     Use WRITE_ONCE() to prevent the compiler from making this sort of
-     wrong guess:
+   Use WRITE_ONCE() to prevent the compiler from making this sort of
+   wrong guess:
+
+   .. code-block:: c
 
 	WRITE_ONCE(a, 0);
 	... Code that does not store to variable a ...
 	WRITE_ONCE(a, 0);
 
- (*) The compiler is within its rights to reorder memory accesses unless
-     you tell it not to.  For example, consider the following interaction
-     between process-level code and an interrupt handler:
+ * The compiler is within its rights to reorder memory accesses unless
+   you tell it not to.  For example, consider the following interaction
+   between process-level code and an interrupt handler:
+
+   .. code-block:: c
 
 	void process_level(void)
 	{
@@ -1696,9 +1737,11 @@ of optimizations:
 			process_message(msg);
 	}
 
-     There is nothing to prevent the compiler from transforming
-     process_level() to the following, in fact, this might well be a
-     win for single-threaded code:
+   There is nothing to prevent the compiler from transforming
+   process_level() to the following, in fact, this might well be a
+   win for single-threaded code:
+
+   .. code-block:: c
 
 	void process_level(void)
 	{
@@ -1706,9 +1749,11 @@ of optimizations:
 		msg = get_message();
 	}
 
-     If the interrupt occurs between these two statement, then
-     interrupt_handler() might be passed a garbled msg.  Use WRITE_ONCE()
-     to prevent this as follows:
+   If the interrupt occurs between these two statement, then
+   interrupt_handler() might be passed a garbled msg.  Use WRITE_ONCE()
+   to prevent this as follows:
+
+   .. code-block:: c
 
 	void process_level(void)
 	{
@@ -1722,81 +1767,93 @@ of optimizations:
 			process_message(READ_ONCE(msg));
 	}
 
-     Note that the READ_ONCE() and WRITE_ONCE() wrappers in
-     interrupt_handler() are needed if this interrupt handler can itself
-     be interrupted by something that also accesses 'flag' and 'msg',
-     for example, a nested interrupt or an NMI.  Otherwise, READ_ONCE()
-     and WRITE_ONCE() are not needed in interrupt_handler() other than
-     for documentation purposes.  (Note also that nested interrupts
-     do not typically occur in modern Linux kernels, in fact, if an
-     interrupt handler returns with interrupts enabled, you will get a
-     WARN_ONCE() splat.)
+   Note that the READ_ONCE() and WRITE_ONCE() wrappers in
+   interrupt_handler() are needed if this interrupt handler can itself
+   be interrupted by something that also accesses 'flag' and 'msg',
+   for example, a nested interrupt or an NMI.  Otherwise, READ_ONCE()
+   and WRITE_ONCE() are not needed in interrupt_handler() other than
+   for documentation purposes.  (Note also that nested interrupts
+   do not typically occur in modern Linux kernels, in fact, if an
+   interrupt handler returns with interrupts enabled, you will get a
+   WARN_ONCE() splat.)
 
-     You should assume that the compiler can move READ_ONCE() and
-     WRITE_ONCE() past code not containing READ_ONCE(), WRITE_ONCE(),
-     barrier(), or similar primitives.
+   You should assume that the compiler can move READ_ONCE() and
+   WRITE_ONCE() past code not containing READ_ONCE(), WRITE_ONCE(),
+   barrier(), or similar primitives.
 
-     This effect could also be achieved using barrier(), but READ_ONCE()
-     and WRITE_ONCE() are more selective:  With READ_ONCE() and
-     WRITE_ONCE(), the compiler need only forget the contents of the
-     indicated memory locations, while with barrier() the compiler must
-     discard the value of all memory locations that it has currently
-     cached in any machine registers.  Of course, the compiler must also
-     respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
-     though the CPU of course need not do so.
+   This effect could also be achieved using barrier(), but READ_ONCE()
+   and WRITE_ONCE() are more selective:  With READ_ONCE() and
+   WRITE_ONCE(), the compiler need only forget the contents of the
+   indicated memory locations, while with barrier() the compiler must
+   discard the value of all memory locations that it has currently
+   cached in any machine registers.  Of course, the compiler must also
+   respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
+   though the CPU of course need not do so.
 
- (*) The compiler is within its rights to invent stores to a variable,
-     as in the following example:
+ * The compiler is within its rights to invent stores to a variable,
+   as in the following example:
+
+   .. code-block:: c
 
 	if (a)
 		b = a;
 	else
 		b = 42;
 
-     The compiler might save a branch by optimizing this as follows:
+   The compiler might save a branch by optimizing this as follows:
+
+   .. code-block:: c
 
 	b = 42;
 	if (a)
 		b = a;
 
-     In single-threaded code, this is not only safe, but also saves
-     a branch.  Unfortunately, in concurrent code, this optimization
-     could cause some other CPU to see a spurious value of 42 -- even
-     if variable 'a' was never zero -- when loading variable 'b'.
-     Use WRITE_ONCE() to prevent this as follows:
+   In single-threaded code, this is not only safe, but also saves
+   a branch.  Unfortunately, in concurrent code, this optimization
+   could cause some other CPU to see a spurious value of 42 -- even
+   if variable 'a' was never zero -- when loading variable 'b'.
+   Use WRITE_ONCE() to prevent this as follows:
+
+   .. code-block:: c
 
 	if (a)
 		WRITE_ONCE(b, a);
 	else
 		WRITE_ONCE(b, 42);
 
-     The compiler can also invent loads.  These are usually less
-     damaging, but they can result in cache-line bouncing and thus in
-     poor performance and scalability.  Use READ_ONCE() to prevent
-     invented loads.
+   The compiler can also invent loads.  These are usually less
+   damaging, but they can result in cache-line bouncing and thus in
+   poor performance and scalability.  Use READ_ONCE() to prevent
+   invented loads.
 
- (*) For aligned memory locations whose size allows them to be accessed
-     with a single memory-reference instruction, prevents "load tearing"
-     and "store tearing," in which a single large access is replaced by
-     multiple smaller accesses.  For example, given an architecture having
-     16-bit store instructions with 7-bit immediate fields, the compiler
-     might be tempted to use two 16-bit store-immediate instructions to
-     implement the following 32-bit store:
+ * For aligned memory locations whose size allows them to be accessed
+   with a single memory-reference instruction, prevents "load tearing"
+   and "store tearing," in which a single large access is replaced by
+   multiple smaller accesses.  For example, given an architecture having
+   16-bit store instructions with 7-bit immediate fields, the compiler
+   might be tempted to use two 16-bit store-immediate instructions to
+   implement the following 32-bit store:
+
+   .. code-block:: c
 
 	p = 0x00010002;
 
-     Please note that GCC really does use this sort of optimization,
-     which is not surprising given that it would likely take more
-     than two instructions to build the constant and then store it.
-     This optimization can therefore be a win in single-threaded code.
-     In fact, a recent bug (since fixed) caused GCC to incorrectly use
-     this optimization in a volatile store.  In the absence of such bugs,
-     use of WRITE_ONCE() prevents store tearing in the following example:
+   Please note that GCC really does use this sort of optimization,
+   which is not surprising given that it would likely take more
+   than two instructions to build the constant and then store it.
+   This optimization can therefore be a win in single-threaded code.
+   In fact, a recent bug (since fixed) caused GCC to incorrectly use
+   this optimization in a volatile store.  In the absence of such bugs,
+   use of WRITE_ONCE() prevents store tearing in the following example:
+
+   .. code-block:: c
 
 	WRITE_ONCE(p, 0x00010002);
 
-     Use of packed structures can also result in load and store tearing,
-     as in this example:
+   Use of packed structures can also result in load and store tearing,
+   as in this example:
+
+   .. code-block:: c
 
 	struct __attribute__((__packed__)) foo {
 		short a;
@@ -1810,12 +1867,14 @@ of optimizations:
 	foo2.b = foo1.b;
 	foo2.c = foo1.c;
 
-     Because there are no READ_ONCE() or WRITE_ONCE() wrappers and no
-     volatile markings, the compiler would be well within its rights to
-     implement these three assignment statements as a pair of 32-bit
-     loads followed by a pair of 32-bit stores.  This would result in
-     load tearing on 'foo1.b' and store tearing on 'foo2.b'.  READ_ONCE()
-     and WRITE_ONCE() again prevent tearing in this example:
+   Because there are no READ_ONCE() or WRITE_ONCE() wrappers and no
+   volatile markings, the compiler would be well within its rights to
+   implement these three assignment statements as a pair of 32-bit
+   loads followed by a pair of 32-bit stores.  This would result in
+   load tearing on 'foo1.b' and store tearing on 'foo2.b'.  READ_ONCE()
+   and WRITE_ONCE() again prevent tearing in this example:
+
+   .. code-block:: c
 
 	foo2.a = foo1.a;
 	WRITE_ONCE(foo2.b, READ_ONCE(foo1.b));
@@ -1832,24 +1891,26 @@ Please note that these compiler barriers have no direct effect on the CPU,
 which may then reorder things however it wishes.
 
 
-CPU MEMORY BARRIERS
+CPU Memory Barriers
 -------------------
 
 The Linux kernel has seven basic CPU memory barriers:
 
-	TYPE			MANDATORY	SMP CONDITIONAL
+        ======================= =============== ===============
+	Type                    Mandatory       SMP conditional
 	=======================	===============	===============
-	GENERAL			mb()		smp_mb()
-	WRITE			wmb()		smp_wmb()
-	READ			rmb()		smp_rmb()
-	ADDRESS DEPENDENCY			READ_ONCE()
+	General                 mb()            smp_mb()
+	Write                   wmb()           smp_wmb()
+	Read                    rmb()           smp_rmb()
+	Address dependency                      READ_ONCE()
+        ======================= =============== ===============
 
 
 All memory barriers except the address-dependency barriers imply a compiler
 barrier.  Address dependencies do not impose any additional compiler ordering.
 
 Aside: In the case of address dependencies, the compiler would be expected
-to issue the loads in the correct order (eg. `a[b]` would have to load
+to issue the loads in the correct order (eg. a[b] would have to load
 the value of b before loading a[b]), however there is no guarantee in
 the C specification that the compiler may not speculate the value of b
 (eg. is equal to 1) and load a[b] before b (eg. tmp = a[1]; if (b != 1)
@@ -1863,9 +1924,10 @@ systems because it is assumed that a CPU will appear to be self-consistent,
 and will order overlapping accesses correctly with respect to itself.
 However, see the subsection on "Virtual Machine Guests" below.
 
-[!] Note that SMP memory barriers _must_ be used to control the ordering of
-references to shared memory on SMP systems, though the use of locking instead
-is sufficient.
+.. note::
+   SMP memory barriers _must_ be used to control the ordering of references
+   to shared memory on SMP systems, though the use of locking instead is
+   sufficient.
 
 Mandatory barriers should not be used to control SMP effects, since mandatory
 barriers impose unnecessary overhead on both SMP and UP systems. They may,
@@ -1877,53 +1939,57 @@ compiler and the CPU from reordering them.
 
 There are some more advanced barrier functions:
 
- (*) smp_store_mb(var, value)
+ * smp_store_mb(var, value)
 
-     This assigns the value to the variable and then inserts a full memory
-     barrier after it.  It isn't guaranteed to insert anything more than a
-     compiler barrier in a UP compilation.
+   This assigns the value to the variable and then inserts a full memory
+   barrier after it.  It isn't guaranteed to insert anything more than a
+   compiler barrier in a UP compilation.
 
 
- (*) smp_mb__before_atomic();
- (*) smp_mb__after_atomic();
+ * smp_mb__before_atomic();
+ * smp_mb__after_atomic();
 
-     These are for use with atomic RMW functions that do not imply memory
-     barriers, but where the code needs a memory barrier. Examples for atomic
-     RMW functions that do not imply a memory barrier are e.g. add,
-     subtract, (failed) conditional operations, _relaxed functions,
-     but not atomic_read or atomic_set. A common example where a memory
-     barrier may be required is when atomic ops are used for reference
-     counting.
+   These are for use with atomic RMW functions that do not imply memory
+   barriers, but where the code needs a memory barrier. Examples for atomic
+   RMW functions that do not imply a memory barrier are e.g. add,
+   subtract, (failed) conditional operations, _relaxed functions,
+   but not atomic_read or atomic_set. A common example where a memory
+   barrier may be required is when atomic ops are used for reference
+   counting.
 
-     These are also used for atomic RMW bitop functions that do not imply a
-     memory barrier (such as set_bit and clear_bit).
+   These are also used for atomic RMW bitop functions that do not imply a
+   memory barrier (such as set_bit and clear_bit).
 
-     As an example, consider a piece of code that marks an object as being dead
-     and then decrements the object's reference count:
+   As an example, consider a piece of code that marks an object as being dead
+   and then decrements the object's reference count:
+
+   .. code-block:: c
 
 	obj->dead = 1;
 	smp_mb__before_atomic();
 	atomic_dec(&obj->ref_count);
 
-     This makes sure that the death mark on the object is perceived to be set
-     *before* the reference counter is decremented.
+   This makes sure that the death mark on the object is perceived to be set
+   *before* the reference counter is decremented.
 
-     See Documentation/atomic_{t,bitops}.txt for more information.
+   See Documentation/atomic_{t,bitops}.txt for more information.
 
 
- (*) dma_wmb();
- (*) dma_rmb();
- (*) dma_mb();
+ * dma_wmb();
+ * dma_rmb();
+ * dma_mb();
 
-     These are for use with consistent memory to guarantee the ordering
-     of writes or reads of shared memory accessible to both the CPU and a
-     DMA capable device. See Documentation/core-api/dma-api.rst file for more
-     information about consistent memory.
+   These are for use with consistent memory to guarantee the ordering
+   of writes or reads of shared memory accessible to both the CPU and a
+   DMA capable device. See Documentation/core-api/dma-api.rst file for more
+   information about consistent memory.
 
-     For example, consider a device driver that shares memory with a device
-     and uses a descriptor status value to indicate if the descriptor belongs
-     to the device or the CPU, and a doorbell to notify it when new
-     descriptors are available:
+   For example, consider a device driver that shares memory with a device
+   and uses a descriptor status value to indicate if the descriptor belongs
+   to the device or the CPU, and a doorbell to notify it when new
+   descriptors are available:
+
+     .. code-block:: c
 
 	if (desc->status != DEVICE_OWN) {
 		/* do not read data until we own descriptor */
@@ -1945,41 +2011,40 @@ There are some more advanced barrier functions:
 		writel(DESC_NOTIFY, doorbell);
 	}
 
-     The dma_rmb() allows us to guarantee that the device has released ownership
-     before we read the data from the descriptor, and the dma_wmb() allows
-     us to guarantee the data is written to the descriptor before the device
-     can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
-     a dma_wmb().
+   The dma_rmb() allows us to guarantee that the device has released ownership
+   before we read the data from the descriptor, and the dma_wmb() allows
+   us to guarantee the data is written to the descriptor before the device
+   can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
+   a dma_wmb().
 
-     Note that the dma_*() barriers do not provide any ordering guarantees for
-     accesses to MMIO regions.  See the later "KERNEL I/O BARRIER EFFECTS"
-     subsection for more information about I/O accessors and MMIO ordering.
+   Note that the dma_*() barriers do not provide any ordering guarantees for
+   accesses to MMIO regions.  See the later "KERNEL I/O BARRIER EFFECTS"
+   subsection for more information about I/O accessors and MMIO ordering.
 
- (*) pmem_wmb();
+ * pmem_wmb();
 
-     This is for use with persistent memory to ensure that stores for which
-     modifications are written to persistent storage reached a platform
-     durability domain.
+   This is for use with persistent memory to ensure that stores for which
+   modifications are written to persistent storage reached a platform
+   durability domain.
 
-     For example, after a non-temporal write to pmem region, we use pmem_wmb()
-     to ensure that stores have reached a platform durability domain. This ensures
-     that stores have updated persistent storage before any data access or
-     data transfer caused by subsequent instructions is initiated. This is
-     in addition to the ordering done by wmb().
+   For example, after a non-temporal write to pmem region, we use pmem_wmb()
+   to ensure that stores have reached a platform durability domain. This
+   ensures that stores have updated persistent storage before any data access
+   or data transfer caused by subsequent instructions is initiated. This is
+   in addition to the ordering done by wmb().
 
-     For load from persistent memory, existing read memory barriers are sufficient
-     to ensure read ordering.
+   For load from persistent memory, existing read memory barriers are sufficient
+   to ensure read ordering.
 
- (*) io_stop_wc();
+ * io_stop_wc();
 
-     For memory accesses with write-combining attributes (e.g. those returned
-     by ioremap_wc()), the CPU may wait for prior accesses to be merged with
-     subsequent ones. io_stop_wc() can be used to prevent the merging of
-     write-combining memory accesses before this macro with those after it when
-     such wait has performance implications.
+   For memory accesses with write-combining attributes (e.g. those returned
+   by ioremap_wc()), the CPU may wait for prior accesses to be merged with
+   subsequent ones. io_stop_wc() can be used to prevent the merging of
+   write-combining memory accesses before this macro with those after it when
+   such wait has performance implications.
 
-===============================
-IMPLICIT KERNEL MEMORY BARRIERS
+Implicit Kernel Memory Barriers
 ===============================
 
 Some of the other functions in the linux kernel imply memory barriers, amongst
@@ -1990,16 +2055,16 @@ provide more substantial guarantees, but these may not be relied upon outside
 of arch specific code.
 
 
-LOCK ACQUISITION FUNCTIONS
+Lock Acquisition Functions
 --------------------------
 
 The Linux kernel has a number of locking constructs:
 
- (*) spin locks
- (*) R/W spin locks
- (*) mutexes
- (*) semaphores
- (*) R/W semaphores
+ * spin locks
+ * R/W spin locks
+ * mutexes
+ * semaphores
+ * R/W semaphores
 
 In all cases there are variants on "ACQUIRE" operations and "RELEASE" operations
 for each construct.  These operations all imply certain barriers:
@@ -2037,21 +2102,22 @@ for each construct.  These operations all imply certain barriers:
      signal while asleep waiting for the lock to become available.  Failed
      locks do not imply any sort of barrier.
 
-[!] Note: one of the consequences of lock ACQUIREs and RELEASEs being only
-one-way barriers is that the effects of instructions outside of a critical
-section may seep into the inside of the critical section.
+.. note::
+   One of the consequences of lock ACQUIREs and RELEASEs being only one-way
+   barriers is that the effects of instructions outside of a critical section
+   may seep into the inside of the critical section.
 
 An ACQUIRE followed by a RELEASE may not be assumed to be full memory barrier
 because it is possible for an access preceding the ACQUIRE to happen after the
 ACQUIRE, and an access following the RELEASE to happen before the RELEASE, and
-the two accesses can themselves then cross:
+the two accesses can themselves then cross::
 
 	*A = a;
 	ACQUIRE M
 	RELEASE M
 	*B = b;
 
-may occur as:
+may occur as::
 
 	ACQUIRE M, STORE *B, STORE *A, RELEASE M
 
@@ -2064,14 +2130,14 @@ RELEASE may -not- be assumed to be a full memory barrier.
 Similarly, the reverse case of a RELEASE followed by an ACQUIRE does
 not imply a full memory barrier.  Therefore, the CPU's execution of the
 critical sections corresponding to the RELEASE and the ACQUIRE can cross,
-so that:
+so that::
 
 	*A = a;
 	RELEASE M
 	ACQUIRE N
 	*B = b;
 
-could occur as:
+could occur as::
 
 	ACQUIRE N, STORE *B, STORE *A, RELEASE M
 
@@ -2110,7 +2176,7 @@ with interrupt disabling operations.
 See also the section on "Inter-CPU acquiring barrier effects".
 
 
-As an example, consider the following:
+As an example, consider the following::
 
 	*A = a;
 	*B = b;
@@ -2121,13 +2187,14 @@ As an example, consider the following:
 	*E = e;
 	*F = f;
 
-The following sequence of events is acceptable:
+The following sequence of events is acceptable::
 
 	ACQUIRE, {*F,*A}, *E, {*C,*D}, *B, RELEASE
 
-	[+] Note that {*F,*A} indicates a combined access.
+.. note::
+   {\*F,\*A} indicates a combined access.
 
-But none of the following are:
+But none of the following are::
 
 	{*F,*A}, *B,	ACQUIRE, *C, *D,	RELEASE, *E
 	*A, *B, *C,	ACQUIRE, *D,		RELEASE, *E, *F
@@ -2136,7 +2203,7 @@ But none of the following are:
 
 
 
-INTERRUPT DISABLING FUNCTIONS
+Interrupt Disabling Functions
 -----------------------------
 
 Functions that disable interrupts (ACQUIRE equivalent) and enable interrupts
@@ -2145,7 +2212,7 @@ barriers are required in such a situation, they must be provided from some
 other means.
 
 
-SLEEP AND WAKE-UP FUNCTIONS
+Sleep and Wake-Up Functions
 ---------------------------
 
 Sleeping and waking on an event flagged in global data can be viewed as an
@@ -2157,6 +2224,8 @@ barriers.
 
 Firstly, the sleeper normally follows something like this sequence of events:
 
+.. code-block:: c
+
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (event_indicated)
@@ -2165,7 +2234,7 @@ Firstly, the sleeper normally follows something like this sequence of events:
 	}
 
 A general memory barrier is interpolated automatically by set_current_state()
-after it has altered the task state:
+after it has altered the task state::
 
 	CPU 1
 	===============================
@@ -2175,14 +2244,14 @@ after it has altered the task state:
 	    <general barrier>
 	LOAD event_indicated
 
-set_current_state() may be wrapped by:
+set_current_state() may be wrapped by::
 
 	prepare_to_wait();
 	prepare_to_wait_exclusive();
 
 which therefore also imply a general memory barrier after setting the state.
 The whole sequence above is available in various canned forms, all of which
-interpolate the memory barrier in the right place:
+interpolate the memory barrier in the right place::
 
 	wait_event();
 	wait_event_interruptible();
@@ -2196,11 +2265,15 @@ interpolate the memory barrier in the right place:
 
 Secondly, code that performs a wake up normally follows something like this:
 
+.. code-block:: c
+
 	event_indicated = 1;
 	wake_up(&event_wait_queue);
 
 or:
 
+.. code-block:: c
+
 	event_indicated = 1;
 	wake_up_process(event_daemon);
 
@@ -2208,7 +2281,7 @@ A general memory barrier is executed by wake_up() if it wakes something up.
 If it doesn't wake anything up then a memory barrier may or may not be
 executed; you must not rely on it.  The barrier occurs before the task state
 is accessed, in particular, it sits between the STORE to indicate the event
-and the STORE to set TASK_RUNNING:
+and the STORE to set TASK_RUNNING::
 
 	CPU 1 (Sleeper)			CPU 2 (Waker)
 	===============================	===============================
@@ -2224,7 +2297,7 @@ where "task" is the thread being woken up and it equals CPU 1's "current".
 To repeat, a general memory barrier is guaranteed to be executed by wake_up()
 if something is actually awakened, but otherwise there is no such guarantee.
 To see this, consider the following sequence of events, where X and Y are both
-initially zero:
+initially zero::
 
 	CPU 1				CPU 2
 	===============================	===============================
@@ -2240,7 +2313,7 @@ occurs before the task state is accessed.  In particular, if the wake_up() in
 the previous snippet were replaced by a call to wake_up_process() then one of
 the two loads would be guaranteed to see 1.
 
-The available waker functions include:
+The available waker functions include::
 
 	complete();
 	wake_up();
@@ -2261,10 +2334,13 @@ The available waker functions include:
 In terms of memory ordering, these functions all provide the same guarantees of
 a wake_up() (or stronger).
 
-[!] Note that the memory barriers implied by the sleeper and the waker do _not_
-order multiple stores before the wake-up with respect to loads of those stored
-values after the sleeper has called set_current_state().  For instance, if the
-sleeper does:
+.. note::
+   The memory barriers implied by the sleeper and the waker do _not_ order
+   multiple stores before the wake-up with respect to loads of those stored
+   values after the sleeper has called set_current_state().  For instance,
+   if the sleeper does:
+
+   .. code-block:: c
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (event_indicated)
@@ -2272,16 +2348,20 @@ sleeper does:
 	__set_current_state(TASK_RUNNING);
 	do_something(my_data);
 
-and the waker does:
+   and the waker does:
+
+   .. code-block:: c
 
 	my_data = value;
 	event_indicated = 1;
 	wake_up(&event_wait_queue);
 
-there's no guarantee that the change to event_indicated will be perceived by
-the sleeper as coming after the change to my_data.  In such a circumstance, the
-code on both sides must interpolate its own memory barriers between the
-separate data accesses.  Thus the above sleeper ought to do:
+   there's no guarantee that the change to event_indicated will be perceived by
+   the sleeper as coming after the change to my_data.  In such a circumstance,
+   the code on both sides must interpolate its own memory barriers between the
+   separate data accesses.  Thus the above sleeper ought to do:
+
+   .. code-block:: c
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (event_indicated) {
@@ -2289,7 +2369,9 @@ separate data accesses.  Thus the above sleeper ought to do:
 		do_something(my_data);
 	}
 
-and the waker should do:
+   and the waker should do:
+
+   .. code-block:: c
 
 	my_data = value;
 	smp_wmb();
@@ -2297,16 +2379,15 @@ and the waker should do:
 	wake_up(&event_wait_queue);
 
 
-MISCELLANEOUS FUNCTIONS
+Miscellaneous Functions
 -----------------------
 
 Other functions that imply barriers:
 
- (*) schedule() and similar imply full memory barriers.
+ * schedule() and similar imply full memory barriers.
 
 
-===================================
-INTER-CPU ACQUIRING BARRIER EFFECTS
+Inter-CPU Acquiring Barrier Effects
 ===================================
 
 On SMP systems locking primitives give a more substantial form of barrier: one
@@ -2314,11 +2395,11 @@ that does affect memory access ordering on other CPUs, within the context of
 conflict on any particular lock.
 
 
-ACQUIRES VS MEMORY ACCESSES
+Acquires vs Memory Accesses
 ---------------------------
 
 Consider the following: the system has a pair of spinlocks (M) and (Q), and
-three CPUs; then should the following sequence of events occur:
+three CPUs; then should the following sequence of events occur::
 
 	CPU 1				CPU 2
 	===============================	===============================
@@ -2329,13 +2410,13 @@ three CPUs; then should the following sequence of events occur:
 	RELEASE M			RELEASE Q
 	WRITE_ONCE(*D, d);		WRITE_ONCE(*H, h);
 
-Then there is no guarantee as to what order CPU 3 will see the accesses to *A
-through *H occur in, other than the constraints imposed by the separate locks
-on the separate CPUs.  It might, for example, see:
+Then there is no guarantee as to what order CPU 3 will see the accesses to \*A
+through \*H occur in, other than the constraints imposed by the separate locks
+on the separate CPUs.  It might, for example, see::
 
 	*E, ACQUIRE M, ACQUIRE Q, *G, *C, *F, *A, *B, RELEASE Q, *D, *H, RELEASE M
 
-But it won't see any of:
+But it won't see any of::
 
 	*B, *C or *D preceding ACQUIRE M
 	*A, *B or *C following RELEASE M
@@ -2343,25 +2424,21 @@ But it won't see any of:
 	*E, *F or *G following RELEASE Q
 
 
-=================================
-WHERE ARE MEMORY BARRIERS NEEDED?
+Where are Memory Barriers Needed?
 =================================
 
 Under normal operation, memory operation reordering is generally not going to
 be a problem as a single-threaded linear piece of code will still appear to
 work correctly, even if it's in an SMP kernel.  There are, however, four
-circumstances in which reordering definitely _could_ be a problem:
+circumstances in which reordering definitely **could** be a problem:
 
- (*) Interprocessor interaction.
-
- (*) Atomic operations.
-
- (*) Accessing devices.
-
- (*) Interrupts.
+ * Interprocessor interaction.
+ * Atomic operations.
+ * Accessing devices.
+ * Interrupts.
 
 
-INTERPROCESSOR INTERACTION
+Interprocessor Interaction
 --------------------------
 
 When there's a system with more than one processor, more than one CPU in the
@@ -2376,6 +2453,8 @@ Consider, for example, the R/W semaphore slow path.  Here a waiting process is
 queued on the semaphore, by virtue of it having a piece of its stack linked to
 the semaphore's list of waiting processes:
 
+.. code-block:: c
+
 	struct rw_semaphore {
 		...
 		spinlock_t lock;
@@ -2400,7 +2479,7 @@ To wake up a particular waiter, the up_read() or up_write() functions have to:
 
  (5) release the reference held on the waiter's task struct.
 
-In other words, it has to perform this sequence of events:
+In other words, it has to perform this sequence of events::
 
 	LOAD waiter->list.next;
 	LOAD waiter->task;
@@ -2418,7 +2497,7 @@ if the task pointer is cleared _before_ the next pointer in the list is read,
 another CPU might start processing the waiter and might clobber the waiter's
 stack before the up*() function has a chance to read the next pointer.
 
-Consider then what might happen to the above sequence of events:
+Consider then what might happen to the above sequence of events::
 
 	CPU 1				CPU 2
 	===============================	===============================
@@ -2441,7 +2520,7 @@ Consider then what might happen to the above sequence of events:
 This could be dealt with using the semaphore lock, but then the down_xxx()
 function has to needlessly get the spinlock again after being woken up.
 
-The way to deal with this is to insert a general SMP memory barrier:
+The way to deal with this is to insert a general SMP memory barrier::
 
 	LOAD waiter->list.next;
 	LOAD waiter->task;
@@ -2462,7 +2541,7 @@ right order without actually intervening in the CPU.  Since there's only one
 CPU, that CPU's dependency ordering logic will take care of everything else.
 
 
-ATOMIC OPERATIONS
+Atomic Operations
 -----------------
 
 While they are technically interprocessor interaction considerations, atomic
@@ -2473,7 +2552,7 @@ kernel.
 See Documentation/atomic_t.txt for more information.
 
 
-ACCESSING DEVICES
+Accessing Devices
 -----------------
 
 Many devices can be memory mapped, and so appear to the CPU as if they're just
@@ -2496,7 +2575,7 @@ memory barriers are required to enforce ordering.
 See Documentation/driver-api/device-io.rst for more information.
 
 
-INTERRUPTS
+Interrupts
 ----------
 
 A driver may be interrupted by its own interrupt service routine, and thus the
@@ -2512,7 +2591,7 @@ handled, thus the interrupt handler does not need to lock against that.
 
 However, consider a driver that was talking to an ethernet card that sports an
 address register and a data register.  If that driver's core talks to the card
-under interrupt-disablement and then the driver's interrupt handler is invoked:
+under interrupt-disablement and then the driver's interrupt handler is invoked::
 
 	LOCAL IRQ DISABLE
 	writew(ADDR, 3);
@@ -2524,7 +2603,7 @@ under interrupt-disablement and then the driver's interrupt handler is invoked:
 	</interrupt>
 
 The store to the data register might happen after the second store to the
-address register if ordering rules are sufficiently relaxed:
+address register if ordering rules are sufficiently relaxed::
 
 	STORE *ADDR = 3, STORE *ADDR = 4, STORE *DATA = y, q = LOAD *DATA
 
@@ -2544,8 +2623,7 @@ running on separate CPUs that communicate with each other.  If such a case is
 likely, then interrupt-disabling locks should be used to guarantee ordering.
 
 
-==========================
-KERNEL I/O BARRIER EFFECTS
+Kernel I/O Barrier Effects
 ==========================
 
 Interfacing with peripherals via I/O accesses is deeply architecture and device
@@ -2556,101 +2634,103 @@ between multiple architectures and bus implementations, the kernel offers a
 series of accessor functions that provide various degrees of ordering
 guarantees:
 
- (*) readX(), writeX():
+ * readX(), writeX():
 
-	The readX() and writeX() MMIO accessors take a pointer to the
-	peripheral being accessed as an __iomem * parameter. For pointers
-	mapped with the default I/O attributes (e.g. those returned by
-	ioremap()), the ordering guarantees are as follows:
+   The readX() and writeX() MMIO accessors take a pointer to the
+   peripheral being accessed as an __iomem * parameter. For pointers
+   mapped with the default I/O attributes (e.g. those returned by
+   ioremap()), the ordering guarantees are as follows:
 
-	1. All readX() and writeX() accesses to the same peripheral are ordered
-	   with respect to each other. This ensures that MMIO register accesses
-	   by the same CPU thread to a particular device will arrive in program
-	   order.
+   1. All readX() and writeX() accesses to the same peripheral are ordered
+      with respect to each other. This ensures that MMIO register accesses
+      by the same CPU thread to a particular device will arrive in program
+      order.
 
-	2. A writeX() issued by a CPU thread holding a spinlock is ordered
-	   before a writeX() to the same peripheral from another CPU thread
-	   issued after a later acquisition of the same spinlock. This ensures
-	   that MMIO register writes to a particular device issued while holding
-	   a spinlock will arrive in an order consistent with acquisitions of
-	   the lock.
+   2. A writeX() issued by a CPU thread holding a spinlock is ordered
+      before a writeX() to the same peripheral from another CPU thread
+      issued after a later acquisition of the same spinlock. This ensures
+      that MMIO register writes to a particular device issued while holding
+      a spinlock will arrive in an order consistent with acquisitions of
+      the lock.
 
-	3. A writeX() by a CPU thread to the peripheral will first wait for the
-	   completion of all prior writes to memory either issued by, or
-	   propagated to, the same thread. This ensures that writes by the CPU
-	   to an outbound DMA buffer allocated by dma_alloc_coherent() will be
-	   visible to a DMA engine when the CPU writes to its MMIO control
-	   register to trigger the transfer.
+   3. A writeX() by a CPU thread to the peripheral will first wait for the
+      completion of all prior writes to memory either issued by, or
+      propagated to, the same thread. This ensures that writes by the CPU
+      to an outbound DMA buffer allocated by dma_alloc_coherent() will be
+      visible to a DMA engine when the CPU writes to its MMIO control
+      register to trigger the transfer.
 
-	4. A readX() by a CPU thread from the peripheral will complete before
-	   any subsequent reads from memory by the same thread can begin. This
-	   ensures that reads by the CPU from an incoming DMA buffer allocated
-	   by dma_alloc_coherent() will not see stale data after reading from
-	   the DMA engine's MMIO status register to establish that the DMA
-	   transfer has completed.
+   4. A readX() by a CPU thread from the peripheral will complete before
+      any subsequent reads from memory by the same thread can begin. This
+      ensures that reads by the CPU from an incoming DMA buffer allocated
+      by dma_alloc_coherent() will not see stale data after reading from
+      the DMA engine's MMIO status register to establish that the DMA
+      transfer has completed.
 
-	5. A readX() by a CPU thread from the peripheral will complete before
-	   any subsequent delay() loop can begin execution on the same thread.
-	   This ensures that two MMIO register writes by the CPU to a peripheral
-	   will arrive at least 1us apart if the first write is immediately read
-	   back with readX() and udelay(1) is called prior to the second
-	   writeX():
+   5. A readX() by a CPU thread from the peripheral will complete before
+      any subsequent delay() loop can begin execution on the same thread.
+      This ensures that two MMIO register writes by the CPU to a peripheral
+      will arrive at least 1us apart if the first write is immediately read
+      back with readX() and udelay(1) is called prior to the second
+      writeX():
+
+      .. code-block:: c
 
 		writel(42, DEVICE_REGISTER_0); // Arrives at the device...
 		readl(DEVICE_REGISTER_0);
 		udelay(1);
 		writel(42, DEVICE_REGISTER_1); // ...at least 1us before this.
 
-	The ordering properties of __iomem pointers obtained with non-default
-	attributes (e.g. those returned by ioremap_wc()) are specific to the
-	underlying architecture and therefore the guarantees listed above cannot
-	generally be relied upon for accesses to these types of mappings.
+      The ordering properties of __iomem pointers obtained with non-default
+      attributes (e.g. those returned by ioremap_wc()) are specific to the
+      underlying architecture and therefore the guarantees listed above cannot
+      generally be relied upon for accesses to these types of mappings.
 
- (*) readX_relaxed(), writeX_relaxed():
+ * readX_relaxed(), writeX_relaxed():
 
-	These are similar to readX() and writeX(), but provide weaker memory
-	ordering guarantees. Specifically, they do not guarantee ordering with
-	respect to locking, normal memory accesses or delay() loops (i.e.
-	bullets 2-5 above) but they are still guaranteed to be ordered with
-	respect to other accesses from the same CPU thread to the same
-	peripheral when operating on __iomem pointers mapped with the default
-	I/O attributes.
+   These are similar to readX() and writeX(), but provide weaker memory
+   ordering guarantees. Specifically, they do not guarantee ordering with
+   respect to locking, normal memory accesses or delay() loops (i.e.
+   bullets 2-5 above) but they are still guaranteed to be ordered with
+   respect to other accesses from the same CPU thread to the same
+   peripheral when operating on __iomem pointers mapped with the default
+   I/O attributes.
 
- (*) readsX(), writesX():
+ * readsX(), writesX():
 
-	The readsX() and writesX() MMIO accessors are designed for accessing
-	register-based, memory-mapped FIFOs residing on peripherals that are not
-	capable of performing DMA. Consequently, they provide only the ordering
-	guarantees of readX_relaxed() and writeX_relaxed(), as documented above.
+   The readsX() and writesX() MMIO accessors are designed for accessing
+   register-based, memory-mapped FIFOs residing on peripherals that are not
+   capable of performing DMA. Consequently, they provide only the ordering
+   guarantees of readX_relaxed() and writeX_relaxed(), as documented above.
 
- (*) inX(), outX():
+ * inX(), outX():
 
-	The inX() and outX() accessors are intended to access legacy port-mapped
-	I/O peripherals, which may require special instructions on some
-	architectures (notably x86). The port number of the peripheral being
-	accessed is passed as an argument.
+   The inX() and outX() accessors are intended to access legacy port-mapped
+   I/O peripherals, which may require special instructions on some
+   architectures (notably x86). The port number of the peripheral being
+   accessed is passed as an argument.
 
-	Since many CPU architectures ultimately access these peripherals via an
-	internal virtual memory mapping, the portable ordering guarantees
-	provided by inX() and outX() are the same as those provided by readX()
-	and writeX() respectively when accessing a mapping with the default I/O
-	attributes.
+   Since many CPU architectures ultimately access these peripherals via an
+   internal virtual memory mapping, the portable ordering guarantees
+   provided by inX() and outX() are the same as those provided by readX()
+   and writeX() respectively when accessing a mapping with the default I/O
+   attributes.
 
-	Device drivers may expect outX() to emit a non-posted write transaction
-	that waits for a completion response from the I/O peripheral before
-	returning. This is not guaranteed by all architectures and is therefore
-	not part of the portable ordering semantics.
+   Device drivers may expect outX() to emit a non-posted write transaction
+   that waits for a completion response from the I/O peripheral before
+   returning. This is not guaranteed by all architectures and is therefore
+   not part of the portable ordering semantics.
 
- (*) insX(), outsX():
+ * insX(), outsX():
 
-	As above, the insX() and outsX() accessors provide the same ordering
-	guarantees as readsX() and writesX() respectively when accessing a
-	mapping with the default I/O attributes.
+   As above, the insX() and outsX() accessors provide the same ordering
+   guarantees as readsX() and writesX() respectively when accessing a
+   mapping with the default I/O attributes.
 
- (*) ioreadX(), iowriteX():
+ * ioreadX(), iowriteX():
 
-	These will perform appropriately for the type of access they're actually
-	doing, be it inX()/outX() or readX()/writeX().
+   These will perform appropriately for the type of access they're actually
+   doing, be it inX()/outX() or readX()/writeX().
 
 With the exception of the string accessors (insX(), outsX(), readsX() and
 writesX()), all of the above assume that the underlying peripheral is
@@ -2658,8 +2738,7 @@ little-endian and will therefore perform byte-swapping operations on big-endian
 architectures.
 
 
-========================================
-ASSUMED MINIMUM EXECUTION ORDERING MODEL
+Assumed Minimum Execution Ordering Model
 ========================================
 
 It has to be assumed that the conceptual CPU is weakly-ordered but that it will
@@ -2671,13 +2750,13 @@ of arch-specific code.
 This means that it must be considered that the CPU will execute its instruction
 stream in any order it feels like - or even in parallel - provided that if an
 instruction in the stream depends on an earlier instruction, then that
-earlier instruction must be sufficiently complete[*] before the later
-instruction may proceed; in other words: provided that the appearance of
-causality is maintained.
+earlier instruction must be sufficiently complete [#multiple-effects]_ before
+the later instruction may proceed; in other words: provided that the appearance
+of causality is maintained.
 
- [*] Some instructions have more than one effect - such as changing the
-     condition codes, changing registers or changing memory - and different
-     instructions may depend on different effects.
+.. [#multiple-effects] Some instructions have more than one effect - such as
+   changing the condition codes, changing registers or changing memory - and
+   different instructions may depend on different effects.
 
 A CPU may also discard any instruction sequence that winds up having no
 ultimate effect.  For example, if two adjacent instructions both load an
@@ -2689,8 +2768,7 @@ stream in any way it sees fit, again provided the appearance of causality is
 maintained.
 
 
-============================
-THE EFFECTS OF THE CPU CACHE
+The Effects of the CPU Cache
 ============================
 
 The way cached memory operations are perceived across the system is affected to
@@ -2700,7 +2778,7 @@ memory coherence system that maintains the consistency of state in the system.
 As far as the way a CPU interacts with another part of the system through the
 caches goes, the memory system has to include the CPU's caches, and memory
 barriers for the most part act at the interface between the CPU and its cache
-(memory barriers logically act on the dotted line in the following diagram):
+(memory barriers logically act on the dotted line in the following diagram)::
 
 	    <--- CPU --->         :       <----------- Memory ----------->
 	                          :
@@ -2742,15 +2820,17 @@ accesses cross from the CPU side of things to the memory side of things, and
 the order in which the effects are perceived to happen by the other observers
 in the system.
 
-[!] Memory barriers are _not_ needed within a given CPU, as CPUs always see
-their own loads and stores as if they had happened in program order.
+.. warning::
+   Memory barriers are _not_ needed within a given CPU, as CPUs always see
+   their own loads and stores as if they had happened in program order.
 
-[!] MMIO or other device accesses may bypass the cache system.  This depends on
-the properties of the memory window through which devices are accessed and/or
-the use of any special device communication instructions the CPU may have.
+.. warning::
+   MMIO or other device accesses may bypass the cache system.  This depends on
+   the properties of the memory window through which devices are accessed and/or
+   the use of any special device communication instructions the CPU may have.
 
 
-CACHE COHERENCY VS DMA
+Cache Coherency vs DMA
 ----------------------
 
 Not all systems maintain cache coherency with respect to devices doing DMA.  In
@@ -2772,7 +2852,7 @@ See Documentation/core-api/cachetlb.rst for more information on cache
 management.
 
 
-CACHE COHERENCY VS MMIO
+Cache Coherency vs MMIO
 -----------------------
 
 Memory mapped I/O usually takes place through memory locations that are part of
@@ -2787,14 +2867,15 @@ flushed between the cached memory write and the MMIO access if the two are in
 any way dependent.
 
 
-=========================
-THE THINGS CPUS GET UP TO
+The Things CPUs Get Up To
 =========================
 
 A programmer might take it for granted that the CPU will perform memory
 operations in exactly the order specified, so that if the CPU is, for example,
 given the following piece of code to execute:
 
+.. code-block:: c
+
 	a = READ_ONCE(*A);
 	WRITE_ONCE(*B, b);
 	c = READ_ONCE(*C);
@@ -2803,7 +2884,7 @@ given the following piece of code to execute:
 
 they would then expect that the CPU will complete the memory operation for each
 instruction before moving on to the next one, leading to a definite sequence of
-operations as seen by external observers in the system:
+operations as seen by external observers in the system::
 
 	LOAD *A, STORE *B, LOAD *C, LOAD *D, STORE *E.
 
@@ -2811,31 +2892,31 @@ operations as seen by external observers in the system:
 Reality is, of course, much messier.  With many CPUs and compilers, the above
 assumption doesn't hold because:
 
- (*) loads are more likely to need to be completed immediately to permit
-     execution progress, whereas stores can often be deferred without a
-     problem;
+ * loads are more likely to need to be completed immediately to permit
+   execution progress, whereas stores can often be deferred without a
+   problem;
 
- (*) loads may be done speculatively, and the result discarded should it prove
-     to have been unnecessary;
+ * loads may be done speculatively, and the result discarded should it prove
+   to have been unnecessary;
 
- (*) loads may be done speculatively, leading to the result having been fetched
-     at the wrong time in the expected sequence of events;
+ * loads may be done speculatively, leading to the result having been fetched
+   at the wrong time in the expected sequence of events;
 
- (*) the order of the memory accesses may be rearranged to promote better use
-     of the CPU buses and caches;
+ * the order of the memory accesses may be rearranged to promote better use
+   of the CPU buses and caches;
 
- (*) loads and stores may be combined to improve performance when talking to
-     memory or I/O hardware that can do batched accesses of adjacent locations,
-     thus cutting down on transaction setup costs (memory and PCI devices may
-     both be able to do this); and
+ * loads and stores may be combined to improve performance when talking to
+   memory or I/O hardware that can do batched accesses of adjacent locations,
+   thus cutting down on transaction setup costs (memory and PCI devices may
+   both be able to do this); and
 
- (*) the CPU's data cache may affect the ordering, and while cache-coherency
-     mechanisms may alleviate this - once the store has actually hit the cache
-     - there's no guarantee that the coherency management will be propagated in
-     order to other CPUs.
+ * the CPU's data cache may affect the ordering, and while cache-coherency
+   mechanisms may alleviate this - once the store has actually hit the cache
+   - there's no guarantee that the coherency management will be propagated in
+   order to other CPUs.
 
 So what another CPU, say, might actually observe from the above piece of code
-is:
+is::
 
 	LOAD *A, ..., LOAD {*C,*D}, STORE *E, STORE *B
 
@@ -2846,6 +2927,8 @@ However, it is guaranteed that a CPU will be self-consistent: it will see its
 _own_ accesses appear to be correctly ordered, without the need for a memory
 barrier.  For instance with the following code:
 
+.. code-block:: c
+
 	U = READ_ONCE(*A);
 	WRITE_ONCE(*A, V);
 	WRITE_ONCE(*A, W);
@@ -2854,7 +2937,7 @@ barrier.  For instance with the following code:
 	Z = READ_ONCE(*A);
 
 and assuming no intervention by an external influence, it can be assumed that
-the final result will appear to be:
+the final result will appear to be::
 
 	U == the original value of *A
 	X == W
@@ -2862,7 +2945,7 @@ the final result will appear to be:
 	*A == Y
 
 The code above may cause the CPU to generate the full sequence of memory
-accesses:
+accesses::
 
 	U=LOAD *A, STORE *A=V, STORE *A=W, X=LOAD *A, STORE *A=Y, Z=LOAD *A
 
@@ -2881,15 +2964,21 @@ the CPU even sees them.
 
 For instance:
 
+.. code-block:: c
+
 	*A = V;
 	*A = W;
 
 may be reduced to:
 
+.. code-block:: c
+
 	*A = W;
 
 since, without either a write barrier or an WRITE_ONCE(), it can be
-assumed that the effect of the storage of V to *A is lost.  Similarly:
+assumed that the effect of the storage of V to \*A is lost.  Similarly:
+
+.. code-block:: c
 
 	*A = Y;
 	Z = *A;
@@ -2897,13 +2986,15 @@ assumed that the effect of the storage of V to *A is lost.  Similarly:
 may, without a memory barrier or an READ_ONCE() and WRITE_ONCE(), be
 reduced to:
 
+.. code-block:: c
+
 	*A = Y;
 	Z = Y;
 
 and the LOAD operation never appear outside of the CPU.
 
 
-AND THEN THERE'S THE ALPHA
+And Then There's The Alpha
 --------------------------
 
 The DEC Alpha CPU is one of the most relaxed CPUs there is.  Not only that,
@@ -2918,7 +3009,7 @@ the Linux kernel's addition of smp_mb() to READ_ONCE() on Alpha greatly
 reduced its impact on the memory model.
 
 
-VIRTUAL MACHINE GUESTS
+Virtual Machine Guests
 ----------------------
 
 Guests running within virtual machines might be affected by SMP effects even if
@@ -2937,78 +3028,85 @@ in particular, they do not control MMIO effects: to control
 MMIO effects, use mandatory barriers.
 
 
-============
-EXAMPLE USES
+Example Uses
 ============
 
-CIRCULAR BUFFERS
+Circular Buffers
 ----------------
 
 Memory barriers can be used to implement circular buffering without the need
-of a lock to serialise the producer with the consumer.  See:
-
-	Documentation/core-api/circular-buffers.rst
-
-for details.
+of a lock to serialise the producer with the consumer.  See
+Documentation/core-api/circular-buffers.rst for details.
 
 
-==========
-REFERENCES
+References
 ==========
 
-Alpha AXP Architecture Reference Manual, Second Edition (Sites & Witek,
-Digital Press)
-	Chapter 5.2: Physical Address Space Characteristics
-	Chapter 5.4: Caches and Write Buffers
-	Chapter 5.5: Data Sharing
-	Chapter 5.6: Read/Write Ordering
+1. Alpha AXP Architecture Reference Manual, Second Edition (Sites & Witek,
+   Digital Press)
 
-AMD64 Architecture Programmer's Manual Volume 2: System Programming
-	Chapter 7.1: Memory-Access Ordering
-	Chapter 7.4: Buffering and Combining Memory Writes
+	* Chapter 5.2: Physical Address Space Characteristics
+	* Chapter 5.4: Caches and Write Buffers
+	* Chapter 5.5: Data Sharing
+	* Chapter 5.6: Read/Write Ordering
 
-ARM Architecture Reference Manual (ARMv8, for ARMv8-A architecture profile)
-	Chapter B2: The AArch64 Application Level Memory Model
+2. AMD64 Architecture Programmer's Manual Volume 2: System Programming
 
-IA-32 Intel Architecture Software Developer's Manual, Volume 3:
-System Programming Guide
-	Chapter 7.1: Locked Atomic Operations
-	Chapter 7.2: Memory Ordering
-	Chapter 7.4: Serializing Instructions
+	* Chapter 7.1: Memory-Access Ordering
+	* Chapter 7.4: Buffering and Combining Memory Writes
 
-The SPARC Architecture Manual, Version 9
-	Chapter 8: Memory Models
-	Appendix D: Formal Specification of the Memory Models
-	Appendix J: Programming with the Memory Models
+3. ARM Architecture Reference Manual (ARMv8, for ARMv8-A architecture profile)
 
-Storage in the PowerPC (Stone and Fitzgerald)
+	* Chapter B2: The AArch64 Application Level Memory Model
 
-UltraSPARC Programmer Reference Manual
-	Chapter 5: Memory Accesses and Cacheability
-	Chapter 15: Sparc-V9 Memory Models
+4. IA-32 Intel Architecture Software Developer's Manual, Volume 3:
+   System Programming Guide
 
-UltraSPARC III Cu User's Manual
-	Chapter 9: Memory Models
+	* Chapter 7.1: Locked Atomic Operations
+	* Chapter 7.2: Memory Ordering
+	* Chapter 7.4: Serializing Instructions
 
-UltraSPARC IIIi Processor User's Manual
-	Chapter 8: Memory Models
+5. The SPARC Architecture Manual, Version 9
 
-UltraSPARC Architecture 2005
-	Chapter 9: Memory
-	Appendix D: Formal Specifications of the Memory Models
+	* Chapter 8: Memory Models
+	* Appendix D: Formal Specification of the Memory Models
+	* Appendix J: Programming with the Memory Models
 
-UltraSPARC T1 Supplement to the UltraSPARC Architecture 2005
-	Chapter 8: Memory Models
-	Appendix F: Caches and Cache Coherency
+6. Storage in the PowerPC (Stone and Fitzgerald)
 
-Solaris Internals, Core Kernel Architecture, p63-68:
-	Chapter 3.3: Hardware Considerations for Locks and
-			Synchronization
+7. UltraSPARC Programmer Reference Manual
 
-Unix Systems for Modern Architectures, Symmetric Multiprocessing and Caching
-for Kernel Programmers:
-	Chapter 13: Other Memory Models
+	* Chapter 5: Memory Accesses and Cacheability
+	* Chapter 15: Sparc-V9 Memory Models
 
-Intel Itanium Architecture Software Developer's Manual: Volume 1:
-	Section 2.6: Speculation
-	Section 4.4: Memory Access
+8. UltraSPARC III Cu User's Manual
+
+	* Chapter 9: Memory Models
+
+9. UltraSPARC IIIi Processor User's Manual
+
+	* Chapter 8: Memory Models
+
+10. UltraSPARC Architecture 2005
+
+	* Chapter 9: Memory
+	* Appendix D: Formal Specifications of the Memory Models
+
+11. UltraSPARC T1 Supplement to the UltraSPARC Architecture 2005
+
+	* Chapter 8: Memory Models
+	* Appendix F: Caches and Cache Coherency
+
+12. Solaris Internals, Core Kernel Architecture, p63-68:
+
+	* Chapter 3.3: Hardware Considerations for Locks and Synchronization
+
+13. Unix Systems for Modern Architectures, Symmetric Multiprocessing and Caching
+    for Kernel Programmers:
+
+	* Chapter 13: Other Memory Models
+
+14. Intel Itanium Architecture Software Developer's Manual: Volume 1:
+
+	* Section 2.6: Speculation
+	* Section 4.4: Memory Access
diff --git a/Documentation/core-api/wrappers/memory-barriers.rst b/Documentation/core-api/wrappers/memory-barriers.rst
deleted file mode 100644
index 532460b5e3eb88..00000000000000
--- a/Documentation/core-api/wrappers/memory-barriers.rst
+++ /dev/null
@@ -1,18 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-   This is a simple wrapper to bring memory-barriers.txt into the RST world
-   until such a time as that file can be converted directly.
-
-============================
-Linux kernel memory barriers
-============================
-
-.. raw:: latex
-
-    \footnotesize
-
-.. include:: ../../memory-barriers.txt
-   :literal:
-
-.. raw:: latex
-
-    \normalsize
-- 
An old man doll... just what I always wanted! - Clara


