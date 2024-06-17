Return-Path: <linux-arch+bounces-4951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 270CC90BC02
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 22:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81CE1F2197E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E06019D09F;
	Mon, 17 Jun 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATluY9by"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7C198823;
	Mon, 17 Jun 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655495; cv=none; b=aufdTaGCQdOq79a/MU7RLTnsgBfzjmIGdukk5KWkuJoXBKAX+5mYmaSclmlgXUU3t9cgrHu75Uf2ekHP3n5DyMrjqMNVe/28LusufPLnzRQglsOnBT/QGiMSCC8JpzZfrq7pOM9wzPALGnj6DQR6lfOj2XUX4Tk075m8ZN/OX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655495; c=relaxed/simple;
	bh=OtVJdGEulRR6iKBFNWOxb7iykvDXqHHzSJe5xWSLj/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JfR/wEjeUJQ5CZL409nqNc3qqHo8wL7VyCt7KVOUDTozXl2X+xbATsRVbDGO/HKJKjyAsIYuEc1dmpZbsdfUnXtTt//SKFe5skennJHnAsEEimuSAoMc1VGvPAIUhloaKoPKgEqWRYOA8D5DpsVOk827pnBGilVvmQypT4qx5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATluY9by; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so1017385a12.1;
        Mon, 17 Jun 2024 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718655491; x=1719260291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihwEhBftKt1w8XQkg13RWLFkeL3798aqGLkbQ6rlJCc=;
        b=ATluY9bykrMqBoRTzdWM9PliWnhU0PBoa0qt/RtPS9XZbBOWjGJ+LAmAm71nNVwUKx
         9+kkb9ex4lErTvEe/4FLcx3vnLqlwT8BWPU3DNI2DifsnzC7r6UIr05fTdmQoFoxOIcu
         Gf+P84Qb+KjX5SRgz4dHP1pKdGSO2RE8O+7TkgkCZgO32BKaMRb80goYWi/hRl7P9Jcu
         Xi2/o5RuNlkS7noSoc4cP9yye1DH2O7LF2RGu+7kjHdoqJh1qH5qVTdl64/k690kayEL
         79rhiES+vGjceQK43MxWXE61jEYCPIAflQ4qVVkFbiqxRDOPO2jn1UaCFVFAbsNA2J6l
         tVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718655491; x=1719260291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihwEhBftKt1w8XQkg13RWLFkeL3798aqGLkbQ6rlJCc=;
        b=tj0qRRmVSKByUJtwioq2h5xdd3RdX4EXwq64mzafLJt0Bqov/NhyRPJ60v+FrfKrag
         sI96lfmBAvXWvLM/c4SDMiLTGQj0LehRGOrWRFsCVnN8LK5sPoVZZs1zde6GM4PJBRqt
         /FpKCKcM3ixULXpKU0CvuDppm+uttWFcCHEluS7XSImnN21h395AVQcHv42Ah+GwaMoD
         zbRszDl30AWZjTlKqydvRAejy08xXI5uVNkTFmxXmHqrX2GwoU5Zi/D57Cq5MZaMeL71
         DnQ+yFpJfDZXIZfxd9trjbcYRIC5YgY7+rN6xlg2t/umKmtIPu4feeWHY443+3/u1hXT
         EZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYnHkS9xeoLRmCWuZ0P8xAmx/kYVT75Efc6G7iBlUjL9fX6SywtPFz2GhJhWHOO+bwLr2IX0nnJm3+iPd82pk6K2K35BSR/Abujg==
X-Gm-Message-State: AOJu0YxfHIc197SM/3mRPYbRVBVKjXd3Yc3VLHIcMsmwdKY1TIDgiAPT
	ioNOeICBwA+kymPCz9X7FLsafC+TifQbqYvAZQPk/ohG+ii1LOGrqYh1cIHh
X-Google-Smtp-Source: AGHT+IH0twaBCtMlcDcRVhYz45raKGKvcQXzLY/cPs1uD6bo90wAdszMT1pzUcI7XWBu/zJyb4SCcg==
X-Received: by 2002:aa7:de8b:0:b0:57c:bc03:caa2 with SMTP id 4fb4d7f45d1cf-57cf7ad5216mr304971a12.20.1718655491211;
        Mon, 17 Jun 2024 13:18:11 -0700 (PDT)
Received: from andrea.fritz.box (host-79-26-69-235.retail.telecomitalia.it. [79.26.69.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbc4f5870sm6087128a12.4.2024.06.17.13.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 13:18:10 -0700 (PDT)
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
Subject: [PATCH v3] tools/memory-model: Document herd7 (abstract) representation
Date: Mon, 17 Jun 2024 22:17:59 +0200
Message-Id: <20240617201759.1670994-1-parri.andrea@gmail.com>
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
Changes since v2 [1]:
  - drop lk-rmw links

Changes since v1 [2]:
  - add legenda/notations
  - add some SRCU, locking macros
  - update formatting of failure cases
  - update README file

[1] https://lore.kernel.org/lkml/20240605134918.365579-1-parri.andrea@gmail.com/
[2] https://lore.kernel.org/lkml/20240524151356.236071-1-parri.andrea@gmail.com/

 tools/memory-model/Documentation/README       |   7 +-
 .../Documentation/herd-representation.txt     | 106 ++++++++++++++++++
 2 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 tools/memory-model/Documentation/herd-representation.txt

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 304162743a5b8..44e7dae73b296 100644
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
@@ -61,6 +62,10 @@ control-dependencies.txt
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
index 0000000000000..2fe270e902635
--- /dev/null
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -0,0 +1,106 @@
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
+    |                      spin_lock | LKR ->po LKW                              |
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
+    |                   spin_trylock | On success: LKR ->po LKW                  |
+    |                                | On failure: LF                            |
+    ------------------------------------------------------------------------------
-- 
2.34.1


