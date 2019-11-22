Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3905A10751C
	for <lists+linux-arch@lfdr.de>; Fri, 22 Nov 2019 16:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKVPne (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Nov 2019 10:43:34 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:36727 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKVPne (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Nov 2019 10:43:34 -0500
Received: by mail-wm1-f73.google.com with SMTP id z3so3247136wmk.1
        for <linux-arch@vger.kernel.org>; Fri, 22 Nov 2019 07:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UhG4TbrFQmzzMiP4BKNG5iQmKmV3aCdN4xUR1YDfRPM=;
        b=EgIhXGwxSlXKCqO9kVBayPbiq4hyG74I+asYHqVDHlCdKm1TKDUGLDjOKqV6V63Dth
         MkProWx344EvfoHaLjeEyMdttahCSVJ8DQ+YFXo09JVb2l52z9zNBO2jaj8PmxD2zidB
         HQfTaH6mUB1w0KtCsdMwwEWQBD8DMwuwh17aCpmhRfkgQ/WdZvlFDg8Yd/oTaIXOZrkJ
         OQF8R4PlSAS/2oH0eWrQwgk6SY2shUXfmClsRAwwii8HktP8Las5obZgLY+HyRVtrckd
         GR/YwXNHpFSUiHiQLtRTfcf/YZ7QidF5Zws5xb5TH2sY4G7IFgrknse14xbfOQ2fMt5O
         2Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UhG4TbrFQmzzMiP4BKNG5iQmKmV3aCdN4xUR1YDfRPM=;
        b=QMnrhXm/wlqPf/w79nm6fc1BKFXzWIoHM6E57pW5IIpbfITbgd5PmuUYdbRvH8RT09
         gzihAGObBlIS00xh9mGmr5laRCMDkufx61FdNP6i63SM2BR9foO85m4VXe2aNny1ppai
         Lsh0pqXqf/N1wy3Q727ejz3kaM7reYGNsTOCJi89/xcXekRNt2CaEV2jMQXcCZ7L0qOM
         YaZaIT3/odCryVNeYJiLvjGDs/IyQSfp1UW+pWmqCeW2Z3yabFSAsmG62C1TqApybXqN
         8SYT/7wbMU3Sr5OxE/KRqR95BxjQN/zTbmsQ5S7CRtiv7MKkUPfKbRgM4FSB8yLOLTO9
         AKrw==
X-Gm-Message-State: APjAAAUwymOE9lkp0tJzEy8Dn9Nui1XAEUQSktNS3cIVPdPsAHVq+09N
        cpKipVHlH+/yUx/9pvVX8MSxKcqhxw==
X-Google-Smtp-Source: APXvYqxCvXftZQxGxDuuOz6iEtLb6TjZa0CLPJQ59QyXpdTpO/HePDajxADFF3WrBDkeMgeXQhSJErgi8A==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr19174146wro.346.1574437411113;
 Fri, 22 Nov 2019 07:43:31 -0800 (PST)
Date:   Fri, 22 Nov 2019 16:42:21 +0100
In-Reply-To: <20191122154221.247680-1-elver@google.com>
Message-Id: <20191122154221.247680-2-elver@google.com>
Mime-Version: 1.0
References: <20191122154221.247680-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 2/2] kcsan: Prefer __always_inline for fast-path
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, dvyukov@google.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        paulmck@kernel.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Prefer __always_inline for fast-path functions that are called outside
of user_access_save, to avoid generating UACCESS warnings when
optimizing for size (CC_OPTIMIZE_FOR_SIZE). It will also avoid future
surprises with compiler versions that change the inlining heuristic even
when optimizing for performance.

Report: http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
Rebased on: locking/kcsan branch of tip tree.
---
 kernel/kcsan/atomic.h   |  2 +-
 kernel/kcsan/core.c     | 16 +++++++---------
 kernel/kcsan/encoding.h | 14 +++++++-------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index 576e03ddd6a3..a9c193053491 100644
--- a/kernel/kcsan/atomic.h
+++ b/kernel/kcsan/atomic.h
@@ -18,7 +18,7 @@
  * than cast to volatile. Eventually, we hope to be able to remove this
  * function.
  */
-static inline bool kcsan_is_atomic(const volatile void *ptr)
+static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
 {
 	/* only jiffies for now */
 	return ptr == &jiffies;
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 3314fc29e236..c616fec639cd 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -78,10 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
  */
 static DEFINE_PER_CPU(long, kcsan_skip);
 
-static inline atomic_long_t *find_watchpoint(unsigned long addr,
-					     size_t size,
-					     bool expect_write,
-					     long *encoded_watchpoint)
+static __always_inline atomic_long_t *
+find_watchpoint(unsigned long addr, size_t size, bool expect_write, long *encoded_watchpoint)
 {
 	const int slot = watchpoint_slot(addr);
 	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
@@ -146,7 +144,7 @@ insert_watchpoint(unsigned long addr, size_t size, bool is_write)
  *	2. the thread that set up the watchpoint already removed it;
  *	3. the watchpoint was removed and then re-used.
  */
-static inline bool
+static __always_inline bool
 try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
 {
 	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
@@ -160,7 +158,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
 	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
 }
 
-static inline struct kcsan_ctx *get_ctx(void)
+static __always_inline struct kcsan_ctx *get_ctx(void)
 {
 	/*
 	 * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
@@ -169,7 +167,7 @@ static inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
-static inline bool is_atomic(const volatile void *ptr)
+static __always_inline bool is_atomic(const volatile void *ptr)
 {
 	struct kcsan_ctx *ctx = get_ctx();
 
@@ -193,7 +191,7 @@ static inline bool is_atomic(const volatile void *ptr)
 	return kcsan_is_atomic(ptr);
 }
 
-static inline bool should_watch(const volatile void *ptr, int type)
+static __always_inline bool should_watch(const volatile void *ptr, int type)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -226,7 +224,7 @@ static inline void reset_kcsan_skip(void)
 	this_cpu_write(kcsan_skip, skip_count);
 }
 
-static inline bool kcsan_is_enabled(void)
+static __always_inline bool kcsan_is_enabled(void)
 {
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
 }
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index b63890e86449..f03562aaf2eb 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -59,10 +59,10 @@ encode_watchpoint(unsigned long addr, size_t size, bool is_write)
 		      (addr & WATCHPOINT_ADDR_MASK));
 }
 
-static inline bool decode_watchpoint(long watchpoint,
-				     unsigned long *addr_masked,
-				     size_t *size,
-				     bool *is_write)
+static __always_inline bool decode_watchpoint(long watchpoint,
+					      unsigned long *addr_masked,
+					      size_t *size,
+					      bool *is_write)
 {
 	if (watchpoint == INVALID_WATCHPOINT ||
 	    watchpoint == CONSUMED_WATCHPOINT)
@@ -78,13 +78,13 @@ static inline bool decode_watchpoint(long watchpoint,
 /*
  * Return watchpoint slot for an address.
  */
-static inline int watchpoint_slot(unsigned long addr)
+static __always_inline int watchpoint_slot(unsigned long addr)
 {
 	return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
 }
 
-static inline bool matching_access(unsigned long addr1, size_t size1,
-				   unsigned long addr2, size_t size2)
+static __always_inline bool matching_access(unsigned long addr1, size_t size1,
+					    unsigned long addr2, size_t size2)
 {
 	unsigned long end_range1 = addr1 + size1 - 1;
 	unsigned long end_range2 = addr2 + size2 - 1;
-- 
2.24.0.432.g9d3f5f5b63-goog

