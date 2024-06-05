Return-Path: <linux-arch+bounces-4710-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1B8FD020
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1999D1F22205
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943B339AC3;
	Wed,  5 Jun 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKBP8ozb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4136249FF;
	Wed,  5 Jun 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595373; cv=none; b=NIHsQuPMR8q1IAmqD2+Ul7bQs4nZBt1QQDAwVo1iR8LEQCuNr4jgZopZgdZK+bONTxVv3Cpdn5XJB128atTa2Tkc3GR7FzF8xeMPcnh91WXz0AU+Y9MfmPWOW7n5hLCos4QPHgkRbCn1TjlpoTN6weA/0LsjySN8rFp44GfGLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595373; c=relaxed/simple;
	bh=AsDFqKY6j1IUFcQ5abR5Se2CR4lHkYcVFPogT9g5F/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pqu3XKMwnJlrnwV4pggWduvuTDTXIovH228iLem1kpUaDuGTov4crQ3nZbqRZ//4V4hK0chD5X2+7litffoX/mqSR6tLxEkDM/t5lclYrpCF9KVFDF6Ga18131EHGKyL3Pbqta5nqtV13WD5bGkTnusykO51NORgPpLi++ca9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKBP8ozb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354be94c874so5839663f8f.3;
        Wed, 05 Jun 2024 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717595369; x=1718200169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGjCGSATkxFOWmlKkLsqqwxsslX0Utr8SiqRZMgElAY=;
        b=bKBP8ozbwraRgSUVvqnXxRYipHGyiuZWcgAmb6eZgXgrS7XIyTZbuRgHrohkiTu7xY
         jzer5cRxKFNs0bjeFJhFJwMzQPK+62M1Cabh8z3yXssBHkPkxb/TIlMq5QDQGihFDTEE
         JOdoQhAF7KL3MxF+IBm7LuBpkQe5u6rjElWpA6Sr0jdghq+cjp/yoGHaKyeCXv5Yj/Qp
         g/SYYeDLtyjBPy17XQ24WRRHhfvikOn9ckNADX/+JbMofELgFaG/CST43b+IK/e2FTOo
         z8fvxDXwkdmPu55TzI/3PhuIF6GMBSmngBSpiV66zN6LZltqysmNLcw3Rg8mOq58azIN
         Xqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717595369; x=1718200169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGjCGSATkxFOWmlKkLsqqwxsslX0Utr8SiqRZMgElAY=;
        b=b93c2SFw0PHUYe8rDUEfvSA7SIvzYXPlSDGYVFdf3vycikXvNayXIVOYiiPN/hXM0u
         KEjlHYztj1L+0lw4c+DAalBr1ECzoX3Hut3jgd1kIfb+EsPDugbLs3NeQoLLGIO1DUUt
         HTnHE5d9H+mecEwoh1eCAc9ZSAqJLCaK48zUTPr+a3dZC6O+koejcaSe58cjWyEhd3E0
         2xiD+SQ8isR1jlB1n57mIBUi7t0gurGcxVdRkcqda3g6SnKneYzuBT7vzWspfTsdCqkV
         Fgy/GA9U9M3SwPLgYmbnGMG0I7w87J7uje5MmI+0L/qUmt50Oy+7eJCT7okN/MMHPAXI
         u9rg==
X-Forwarded-Encrypted: i=1; AJvYcCX6O6yJO8QONDq+n4ZStPlhTN/Kjxyi+6srO20OAtmYZ7PHLovVTFA0dG1tPuZcTSzNGXXtq9iJbpQfvQ1xhz068P181qZCIO+dLw==
X-Gm-Message-State: AOJu0YwqBZ7SDDCNemp01VBFzmCe8r4PgniPIS/kdtB2rukfbQB3+arA
	6NTMeVgTb6c6pOKeNamPiuVbgAxktYfciWx2c3juYkI/1Je2y4V/
X-Google-Smtp-Source: AGHT+IGdCxTgPrw5WUTGx19uKTtqj4he0UOPapPewY4cNxCdW+DGt6wGld6OTvEeGG0xx8mrZorzeA==
X-Received: by 2002:a05:6000:400f:b0:35e:ec9c:f78f with SMTP id ffacd0b85a97d-35eec9cf8cdmr1477033f8f.19.1717595368913;
        Wed, 05 Jun 2024 06:49:28 -0700 (PDT)
Received: from andrea.wind3.hub ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd066ff17sm14539284f8f.116.2024.06.05.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:49:28 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: stern@rowland.harvard.edu,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	paulmck@kernel.org,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2] tools/memory-model: Document herd7 (abstract) representation
Date: Wed,  5 Jun 2024 15:49:18 +0200
Message-Id: <20240605134918.365579-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tools/memory-model/ and herdtool7 are closely linked: the latter is
responsible for (pre)processing each C-like macro of a litmus test,
and for providing the LKMM with a set of events, or "representation",
corresponding to the given macro.  Provide herd-representation.txt
to document the representations of the concurrency macros, following
their "classification" in Documentation/atomic_t.txt.

Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
Changes since v1[1]:
  - add legenda/notations
  - add some SRCU, locking macros
  - update formatting of failure cases
  - update README file

[1] https://lore.kernel.org/lkml/20240524151356.236071-1-parri.andrea@gmail.com/

 tools/memory-model/Documentation/README       |   7 +-
 .../Documentation/herd-representation.txt     | 107 ++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 tools/memory-model/Documentation/herd-representation.txt

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index db90a26dbdf40..1f73014cc48a3 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -33,7 +33,8 @@ o	You are familiar with Linux-kernel concurrency and the use of
 
 o	You are familiar with Linux-kernel concurrency and the use
 	of LKMM, and would like to learn about LKMM's requirements,
-	rationale, and implementation:	explanation.txt
+	rationale, and implementation:	explanation.txt and
+	herd-representation.txt
 
 o	You are interested in the publications related to LKMM, including
 	hardware manuals, academic literature, standards-committee
@@ -57,6 +58,10 @@ control-dependencies.txt
 explanation.txt
 	Detailed description of the memory model.
 
+herd-representation.txt
+	The (abstract) representation of the Linux-kernel concurrency
+	primitives in terms of events.
+
 litmus-tests.txt
 	The format, features, capabilities, and limitations of the litmus
 	tests that LKMM can evaluate.
diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
new file mode 100644
index 0000000000000..1860995a3d5a5
--- /dev/null
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -0,0 +1,107 @@
+#
+# Legenda:
+#	R,	a Load event
+#	W,	a Store event
+#	F,	a Fence event
+#	LKR,	a Lock-Read event
+#	LKW,	a Lock-Write event
+#	UL,	an Unlock event
+#	LF,	a Lock-Fail event
+#	RL,	a Read-Locked event
+#	RU,	a Read-Unlocked event
+#	R*,	a Load event included in RMW
+#	W*,	a Store event included in RMW
+#	SRCU,	a Sleepable-Read-Copy-Update event
+#
+#	po,	a Program-Order link
+#	rmw,	a Read-Modify-Write link
+#	lk-rmw,	a Lock-Read-Modify-Write link
+#
+# By convention, a blank entry/representation means "same as the preceding entry".
+#
+    ------------------------------------------------------------------------------
+    |                        C macro | Events                                    |
+    ------------------------------------------------------------------------------
+    |                    Non-RMW ops |                                           |
+    ------------------------------------------------------------------------------
+    |                      READ_ONCE | R[once]                                   |
+    |                    atomic_read |                                           |
+    |                     WRITE_ONCE | W[once]                                   |
+    |                     atomic_set |                                           |
+    |               smp_load_acquire | R[acquire]                                |
+    |            atomic_read_acquire |                                           |
+    |              smp_store_release | W[release]                                |
+    |             atomic_set_release |                                           |
+    |                   smp_store_mb | W[once] ->po F[mb]                        |
+    |                         smp_mb | F[mb]                                     |
+    |                        smp_rmb | F[rmb]                                    |
+    |                        smp_wmb | F[wmb]                                    |
+    |          smp_mb__before_atomic | F[before-atomic]                          |
+    |           smp_mb__after_atomic | F[after-atomic]                           |
+    |                    spin_unlock | UL                                        |
+    |                 spin_is_locked | On success: RL                            |
+    |                                | On failure: RU                            |
+    |         smp_mb__after_spinlock | F[after-spinlock]                         |
+    |      smp_mb__after_unlock_lock | F[after-unlock-lock]                      |
+    |                  rcu_read_lock | F[rcu-lock]                               |
+    |                rcu_read_unlock | F[rcu-unlock]                             |
+    |                synchronize_rcu | F[sync-rcu]                               |
+    |                rcu_dereference | R[once]                                   |
+    |             rcu_assign_pointer | W[release]                                |
+    |                 srcu_read_lock | R[srcu-lock]                              |
+    |                 srcu_down_read |                                           |
+    |               srcu_read_unlock | W[srcu-unlock]                            |
+    |                   srcu_up_read |                                           |
+    |               synchronize_srcu | SRCU[sync-srcu]                           |
+    | smp_mb__after_srcu_read_unlock | F[after-srcu-read-unlock]                 |
+    ------------------------------------------------------------------------------
+    |       RMW ops w/o return value |                                           |
+    ------------------------------------------------------------------------------
+    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
+    |                     atomic_and |                                           |
+    |                      spin_lock | LKR ->lk-rmw LKW                          |
+    ------------------------------------------------------------------------------
+    |        RMW ops w/ return value |                                           |
+    ------------------------------------------------------------------------------
+    |              atomic_add_return | F[mb] ->po R*[once]                       |
+    |                                |     ->rmw W*[once] ->po F[mb]             |
+    |               atomic_fetch_add |                                           |
+    |               atomic_fetch_and |                                           |
+    |                    atomic_xchg |                                           |
+    |                           xchg |                                           |
+    |            atomic_add_negative |                                           |
+    |      atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
+    |       atomic_fetch_add_relaxed |                                           |
+    |       atomic_fetch_and_relaxed |                                           |
+    |            atomic_xchg_relaxed |                                           |
+    |                   xchg_relaxed |                                           |
+    |    atomic_add_negative_relaxed |                                           |
+    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
+    |       atomic_fetch_add_acquire |                                           |
+    |       atomic_fetch_and_acquire |                                           |
+    |            atomic_xchg_acquire |                                           |
+    |                   xchg_acquire |                                           |
+    |    atomic_add_negative_acquire |                                           |
+    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
+    |       atomic_fetch_add_release |                                           |
+    |       atomic_fetch_and_release |                                           |
+    |            atomic_xchg_release |                                           |
+    |                   xchg_release |                                           |
+    |    atomic_add_negative_release |                                           |
+    ------------------------------------------------------------------------------
+    |            Conditional RMW ops |                                           |
+    ------------------------------------------------------------------------------
+    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
+    |                                |                 ->rmw W*[once] ->po F[mb] |
+    |                                | On failure: R*[once]                      |
+    |                        cmpxchg |                                           |
+    |              atomic_add_unless |                                           |
+    |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
+    |                                | On failure: R*[once]                      |
+    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
+    |                                | On failure: R*[once]                      |
+    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
+    |                                | On failure: R*[once]                      |
+    |                   spin_trylock | On success: LKR ->lk-rmw LKW              |
+    |                                | On failure: LF                            |
+    ------------------------------------------------------------------------------
-- 
2.34.1


