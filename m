Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36ED109FD9
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 15:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfKZOFC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 09:05:02 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:53846 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKZOFC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 09:05:02 -0500
Received: by mail-wr1-f74.google.com with SMTP id m17so10531788wrb.20
        for <linux-arch@vger.kernel.org>; Tue, 26 Nov 2019 06:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UhG4TbrFQmzzMiP4BKNG5iQmKmV3aCdN4xUR1YDfRPM=;
        b=EymjOpB0+8SfpmZCmMcNlsOPRU3RMG0wks+OGGU5RoKu5iNnds8kJyGLwdmaUmWXuE
         dnqplvFAsz1dWhct6ntlAzyoICh86s7vqDfU6+IiJYYhw0Ph7X2fvARCSRMsQKHfLcNY
         twyP1G55MZ7sV/FGuuzZKyNFCtBZ/DG2K9EYcJHInSWHOW/ZNLNYA4kU6LSSjWhUk2gG
         NExttxy8LAyaJZ5/yDTur8/fhlLE+CiaawhkaNeLA1hrypDOSghW49sZ+Y4WyKUgRSzD
         X9V8XACo+gcKTYWQ7YjmfJF3aMm7g21gt2l8Aug8yD4aTHxnklsLncYC51IY8LEDjVG/
         D70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UhG4TbrFQmzzMiP4BKNG5iQmKmV3aCdN4xUR1YDfRPM=;
        b=q06w8ahBCplIUnUi+8sLz6M3UVZjrLeFbd9SSot1B9jiWXvYX43T6oKb4VwXKbrwM8
         T93czMGrfQWeP5losoFArKKRdZ0GSN5MlmRRFZ0JQXoSA/3Gt09Ci+hMHf4smb1nw33m
         LAgj2qEgJgbItuChJpFeMwZaaRCXMzP/K8b3IWYPhxLZkaGoy54WvGwabnC5YWLK+Klf
         Xau9ujiqcKvnqbkw5B1MDSweM4SotZr3i5aE/9HsSiDUa5J25oGS+NYu3mhb2w1mQzST
         zN7v8rXiGUfUhDh6Lz4y7qV6q+NoXha0VkS2vzr5TOtqLJMIjZX6/IdreWyfv+QQhp2E
         3L8g==
X-Gm-Message-State: APjAAAWqAB8aHZE5e7Fv8kJX7rtJATomyizDOl1Q5PduntCWHOakmTnu
        ChM+zvRo6Om0y2I3plpQsLHTuTRJtw==
X-Google-Smtp-Source: APXvYqw9j0kZ8yZja/mDU6fkiXpuVcqv6MuNt/1Adi5eUhrQ8V9TJqWro+GxVoczfRpyHQ5yB27MPvs0tg==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr27765421wrw.395.1574777098959;
 Tue, 26 Nov 2019 06:04:58 -0800 (PST)
Date:   Tue, 26 Nov 2019 15:04:06 +0100
In-Reply-To: <20191126140406.164870-1-elver@google.com>
Message-Id: <20191126140406.164870-3-elver@google.com>
Mime-Version: 1.0
References: <20191126140406.164870-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 3/3] kcsan: Prefer __always_inline for fast-path
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     mark.rutland@arm.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, arnd@arndb.de,
        dvyukov@google.com, linux-arch@vger.kernel.org,
        kasan-dev@googlegroups.com, Randy Dunlap <rdunlap@infradead.org>
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

