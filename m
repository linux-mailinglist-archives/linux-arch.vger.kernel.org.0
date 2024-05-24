Return-Path: <linux-arch+bounces-4527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CA8CE79C
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CD71F21BCE
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D653E31;
	Fri, 24 May 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDO8Ooj6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C971E52C;
	Fri, 24 May 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563758; cv=none; b=EUqcZDXVo3hWoxXcf7Zo6vLDwuYjFGyjUG4pQy4KwYITqxo6cWcLsyDTm8Fu+S6KvAcIXXOGg3nrcgtTFdH8BPED87SYst00na4Uaqh1UUjBcv/mjT3ag5eLt5FHVRWzAkRW53+4gIQm4/X5oBN6egglYzCSaTgDDmna8JoXL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563758; c=relaxed/simple;
	bh=iQj7paXxa9m4HBRxrJ5rOjX+6iDwWmEtIN2VBpQvuk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b1uBcXhyjrSlL79FI1i+ILRDmo0n0V5WqDIktHgN7+7GvmIuuSphZhcAYGtwjXsnlcvNIrdxoHeL/GzmM1evBmYkF1D+pOGTqMBLszcXBjXUSQjiHXn2MOqTjqWJznk0hngw4Bk/7zFfQmbRZpuca/8UNF/pQwadqB0RFWUEEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDO8Ooj6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42011507a4eso29219455e9.0;
        Fri, 24 May 2024 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716563755; x=1717168555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j424eB0o9SSl+5AGpT7a6cPlE6nJl9ixqKSa6y2ppzE=;
        b=TDO8Ooj6rukOH3moA//kvNl2exJvQ7ue652hCgDxIh6B5tbKgzvI2sv0l57HPcDba1
         X12LojbJ45D7hYoG82IV6cccQ7pybWoGR46lDbvRlfZrTgEt/5gNxEs50jvemrJAlRT9
         3CwWVc/QlJBjXx37uEluDQoqBjHxz4trEazlqb5piokKuamDUnUQBqFywfgRwW/Ae8Yz
         DHN+U80OitrGhsdeH7mmah8K886YFt8ukBXojSYt7XBoznAt2Agdeb4w/YgxGUUrvTUU
         AYdiswR4RFLgtYXByVqhR6lT5GDp03fLQffp6McditC+ro8ysbS0pUbNAKIw+KLPxFMX
         lWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563755; x=1717168555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j424eB0o9SSl+5AGpT7a6cPlE6nJl9ixqKSa6y2ppzE=;
        b=Q/7CeTFa3tdiarsVUAlGIAwg+ObBtbZ5P0hxgCbbioSnXlirj/UXlCuVLU+feaiYm+
         OLJrDIe3TLyCF6hEozLaLBkBm2ohK1vyy3n63hy0IOtTpr4UnTg7mo+PtpLQC7NlVBqo
         bAiJA853aCvmwwXH2MnC+pw7ac6yUilyehL8yvsGzgOuLDVbIuMZux+eVTY86spAKz1U
         IkgdEb+j2vpWOmlcglXCvJqQ6ZJzTljk046CYuSCqmkY1uATClpL39qVNL8xcHP9Atsw
         2frg2PEO+nG7RbuSJNEuLbBV2v8nqO+8GIp2pUIKWfeDS3vD4jyc0BqZFhBLViWUjHpN
         LbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTmxWGp1S99W11ig4Jmh82XwJSLqsPJr3vH6uJP3o0wEZMvaezo9bq3JJzCphFrNky/I3ulI5d+5MGNqJVvD2WgrS6zP8eXwI6nA==
X-Gm-Message-State: AOJu0YwK/JQFBe9xPX8ERA0ZY+h1ghvaWr5rYMU2fjIJiXR7aW2mYaQe
	Dq4rkfgnpeVo7jd7uQFHcp5IkS/fBao5YzlWk1rOSWBNy6odW0AG
X-Google-Smtp-Source: AGHT+IGRtZzuoZH3qHlf5ZNX+BgP57h7AOFCoGx5efxQ7R8TqmPMVIws+3gGoYevB9Ce3wBUPZc59A==
X-Received: by 2002:a05:600c:4f89:b0:41b:a670:a9f1 with SMTP id 5b1f17b1804b1-421089ccf68mr19138745e9.7.1716563754689;
        Fri, 24 May 2024 08:15:54 -0700 (PDT)
Received: from andrea.wind3.hub ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108971393sm22873395e9.19.2024.05.24.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:15:54 -0700 (PDT)
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
Subject: [PATCH] tools/memory-model: Document herd7 (internal) representation
Date: Fri, 24 May 2024 17:13:56 +0200
Message-Id: <20240524151356.236071-1-parri.andrea@gmail.com>
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
to document the representation of synchronization macros, following
their "classification" in Documentation/atomic_t.txt.

Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
- Leaving srcu_{up,down}_read() and smp_mb__after_srcu_read_unlock() for
  the next version.

- Limiting to "add" and "and" ops (skipping similar/same representations
  for "sub", "inc", "dec", "or", "xor", "andnot").

- While preparing this submission, I recalled that atomic_add_unless()
  is not listed in the .def file.  I can't remember the reason for this
  omission though.

- While checking the information below using herd7, I've observed some
  "strange" behavior with spin_is_locked() (perhaps, unsurprisingly...);
  IAC, that's also excluded from this table/submission.


 .../Documentation/herd-representation.txt     | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 tools/memory-model/Documentation/herd-representation.txt

diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
new file mode 100644
index 0000000000000..94d0d0a9eee50
--- /dev/null
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -0,0 +1,81 @@
+    ---------------------------------------------------------------------------
+    |                     C macro | Events                                    |
+    ---------------------------------------------------------------------------
+    |                 Non-RMW ops |                                           |
+    ---------------------------------------------------------------------------
+    |                   READ_ONCE | R[once]                                   |
+    |                 atomic_read | (as in the previous row)                  |
+    |                  WRITE_ONCE | W[once]                                   |
+    |                  atomic_set |                                           |
+    |            smp_load_acquire | R[acquire]                                |
+    |         atomic_read_acquire |                                           |
+    |           smp_store_release | W[release]                                |
+    |          atomic_set_release |                                           |
+    |                smp_store_mb | W[once] ->po F[mb]                        |
+    |                      smp_mb | F[mb]                                     |
+    |                     smp_rmb | F[rmb]                                    |
+    |                     smp_wmb | F[wmb]                                    |
+    |       smp_mb__before_atomic | F[before-atomic]                          |
+    |        smp_mb__after_atomic | F[after-atomic]                           |
+    |                 spin_unlock | UL                                        |
+    |      smp_mb__after_spinlock | F[after-spinlock]                         |
+    |   smp_mb__after_unlock_lock | F[after-unlock-lock]                      |
+    |               rcu_read_lock | F[rcu-lock]                               |
+    |             rcu_read_unlock | F[rcu-unlock]                             |
+    |             synchronize_rcu | F[sync-rcu]                               |
+    |             rcu_dereference | R[once]                                   |
+    |          rcu_assign_pointer | W[release]                                |
+    |              srcu_read_lock | R[srcu-lock]                              |
+    |            srcu_read_unlock | W[srcu-unlock]                            |
+    |            synchronize_srcu | SRCU[sync-srcu]                           |
+    ---------------------------------------------------------------------------
+    |    RMW ops w/o return value |                                           |
+    ---------------------------------------------------------------------------
+    |                  atomic_add | R*[noreturn] ->rmw W*[once]               |
+    |                  atomic_and |                                           |
+    |                   spin_lock | LKR ->lk-rmw LKW                          |
+    ---------------------------------------------------------------------------
+    |     RMW ops w/ return value |                                           |
+    ---------------------------------------------------------------------------
+    |           atomic_add_return | F[mb] ->po R*[once]                       |
+    |                             |     ->rmw W*[once] ->po F[mb]             |
+    |            atomic_fetch_add |                                           |
+    |            atomic_fetch_and |                                           |
+    |                 atomic_xchg |                                           |
+    |                        xchg |                                           |
+    |         atomic_add_negative |                                           |
+    |   atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
+    |    atomic_fetch_add_relaxed |                                           |
+    |    atomic_fetch_and_relaxed |                                           |
+    |         atomic_xchg_relaxed |                                           |
+    |                xchg_relaxed |                                           |
+    | atomic_add_negative_relaxed |                                           |
+    |   atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
+    |    atomic_fetch_add_acquire |                                           |
+    |    atomic_fetch_and_acquire |                                           |
+    |         atomic_xchg_acquire |                                           |
+    |                xchg_acquire |                                           |
+    | atomic_add_negative_acquire |                                           |
+    |   atomic_add_return_release | R*[once] ->rmw W*[release]                |
+    |    atomic_fetch_add_release |                                           |
+    |    atomic_fetch_and_release |                                           |
+    |         atomic_xchg_release |                                           |
+    |                xchg_release |                                           |
+    | atomic_add_negative_release |                                           |
+    ---------------------------------------------------------------------------
+    |         Conditional RMW ops |                                           |
+    ---------------------------------------------------------------------------
+    |              atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
+    |                             |                 ->rmw W*[once] ->po F[mb] |
+    |                             |     On failure: R*[once]                  |
+    |                     cmpxchg |                                           |
+    |           atomic_add_unless |                                           |
+    |      atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
+    |                             |     On failure: R*[once]                  |
+    |      atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
+    |                             |     On failure: R*[once]                  |
+    |      atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
+    |                             |     On failure: R*[once]                  |
+    |                spin_trylock | On success: LKR ->lk-rmw LKW              |
+    |                             |     On failure: LF                        |
+    ---------------------------------------------------------------------------
-- 
2.34.1


