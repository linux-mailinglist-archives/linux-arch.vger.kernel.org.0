Return-Path: <linux-arch+bounces-4966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D430A90E11F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jun 2024 03:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3DD1C225E3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jun 2024 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05F3C0B;
	Wed, 19 Jun 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7PHqmXW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5A6FA8;
	Wed, 19 Jun 2024 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759175; cv=none; b=u2A0D7oGI5dub1luIPBxxjlfC5vaT03jHo4KspmXDWpMz+av2k5oTU/6WPp2GVkG0ktGpRVMSSjZeGeyIFMVWlTRflXmSDhbkOgtVyt73/SGkJ8z1awC8IYRFfguQzbBRbkEmiJWfxOanXyCeVQfppigKCfOnINsgCXRNYecIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759175; c=relaxed/simple;
	bh=KNZEzOZU0iwl4WEMB/1YFkUJY9JmHEoGKn+CWMDA3og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjeIYsivItzWQWnfRViPMVRDF89rdW7DKeDnO/COQLXIrrM0xEkz147ldsYRkV1EGOciP26XX3y9qEoxeQKzhkrC4K9LNkthZq3d7vw35z4oVdfzJpiMs1f/M/P3WZOwXeXBj2SmRgN6xyDS5tdIdbI68FQ3aRVHoFkNF3QHrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7PHqmXW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4217d808034so53630955e9.3;
        Tue, 18 Jun 2024 18:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718759171; x=1719363971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0srqU1MUelmJG10HNIPhaMkO7Xyj63fftpR0cEbOpfM=;
        b=K7PHqmXWdaQe+ervepqu5Yd7J8nWf4tgMc+IPCGixZxqn0H98PvFUHoNmk3EJHlUdp
         KQBZNs0z/J+fPlo+XUHEz1NfXDxIX4mvFhcNs6uvMUTZcV33g07XeGQEREywqVibgdUY
         JO6QhLmeoSCk9se7vY5aJaKrjSzyOom0XLe8f69NmHkgrYDff/RYjqkLIwVgNdWSKTjB
         jgQgB5VkbYClbnmXHqOzyCY5OzKA3olig4klx1Bere9xZQGF2+A7axGzCxy3/ftP8bxH
         qTSkDQUYTHbPsOsq/Mgeo23RdbezgfGH011gZHz+5E9ASR2pia8ZMAW5KIKvfiJD+9lS
         YIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718759171; x=1719363971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0srqU1MUelmJG10HNIPhaMkO7Xyj63fftpR0cEbOpfM=;
        b=dGQW5DGafRwBXDU+Q7gO7s34Sjx5TZrUTK2Mcxi58PH0XHaYZpB3W43PeC5pYF5MWO
         o9Y0uCw6WdjhwgJ3LzXdvBn+m72Zf4lmZD0LQzx/R/Sl//oYqeYnUitew9uYaAJEJ6rr
         D9FBtz9sIi9QXS8ahYN5l/BZnbfAyQlpwXpRuN0Nyd1vR4HnwqyiF1tPX1P6ctRuKe1V
         4x0eJJgV6VqLLg3LFdZLjrJEEZvRVnc4Hz1eZ/OpX4YFNxvkiup0GXZNnMHldlu0BdRZ
         P68imL0m8QVLRorzeYgcuKRnvD05fPz+Dwem351rpyjM0HAa/qCar0kFhaHX+prF798Y
         xeOA==
X-Forwarded-Encrypted: i=1; AJvYcCViyn5lU4iKjbEn5LxTTYoxyIWjMb7urOiahU/douU18KYs3/Gqi+007BxV4Ft/q5ZMznTsCLUS1wl4I9HHD4j8jOmZHdPMNYX9Wg==
X-Gm-Message-State: AOJu0YwMoJciER/lgJnLo0bq/rfcODuWQyu8HmgwlPR0T/leqcmq8T04
	rHqQ3UXMHmGmNd120q1S5xfjrfz9R3H0e0niNJBgCeIWXM7Ptx2t
X-Google-Smtp-Source: AGHT+IErEZudXYpTcdfEpdy2r79aWIGSn5FCLTRyDXPlA4DeT42d0mMPCHsi168bvm/wqqUhkNz98g==
X-Received: by 2002:a5d:658c:0:b0:35f:caa:1ebd with SMTP id ffacd0b85a97d-363171e2be7mr816666f8f.8.1718759171251;
        Tue, 18 Jun 2024 18:06:11 -0700 (PDT)
Received: from andrea.fritz.box (host-95-245-158-89.retail.telecomitalia.it. [95.245.158.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-361bdd955f2sm2946632f8f.17.2024.06.18.18.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 18:06:10 -0700 (PDT)
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
Subject: [PATCH v4] tools/memory-model: Document herd7 (abstract) representation
Date: Wed, 19 Jun 2024 03:06:04 +0200
Message-Id: <20240619010604.1789103-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux-kernel memory model (LKMM) source code and the herd7 tool are
closely linked in that the latter is responsible for (pre)processing
each C-like macro of a litmus test, and for providing the LKMM with a
set of events, or "representation", corresponding to the given macro.
This commit therefore provides herd-representation.txt to document
the representations of the concurrency macros, following their
"classification" in Documentation/atomic_t.txt.

Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
---
Changes since v3 [1]:
  - note that rmw is a subset of po
  - include paulmck's wordsmithing
  - add limitations, aka stress that certain ops have been intentionally omitted
  - add collected Reviewed-by: tags

Changes since v2 [2]:
  - drop lk-rmw links

Changes since v1 [3]:
  - add legenda/notations
  - add some SRCU, locking macros
  - update formatting of failure cases
  - update README file

[1] https://lore.kernel.org/lkml/20240617201759.1670994-1-parri.andrea@gmail.com/
[2] https://lore.kernel.org/lkml/20240605134918.365579-1-parri.andrea@gmail.com/
[3] https://lore.kernel.org/lkml/20240524151356.236071-1-parri.andrea@gmail.com/

 tools/memory-model/Documentation/README       |   7 +-
 .../Documentation/herd-representation.txt     | 110 ++++++++++++++++++
 2 files changed, 116 insertions(+), 1 deletion(-)
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
index 0000000000000..ed988906f2b71
--- /dev/null
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -0,0 +1,110 @@
+#
+# Legend:
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
+#	rmw,	a Read-Modify-Write link - every rmw link is a po link
+#
+# By convention, a blank line in a cell means "same as the preceding line".
+#
+# Disclaimer.  The table includes representations of "add" and "and" operations;
+# corresponding/identical representations of "sub", "inc", "dec" and "or", "xor",
+# "andnot" operations are omitted.
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


