Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEEBFDCC0
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2019 12:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOLzf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Nov 2019 06:55:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40698 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfKOLzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Nov 2019 06:55:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id f3so10081031wmc.5
        for <linux-arch@vger.kernel.org>; Fri, 15 Nov 2019 03:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y2n2+Uz9lfxeIcRjHd5xKcgiwSj7xMIx4TZvu7ih+9A=;
        b=d37xtxs0OyxXEgxd2vBPqffrAhLM/MRpoLejTA0XmotnghUoYngT44PnZEzK6iiiak
         kcO3q0hw8V3w4uTUZ00JW6SZQjPxPHgqB7FDBNiZV1fLYedu0ISVeMuMDApHmR6Q/w/r
         uxO8uzDlOqJPyOjSf5pPVsWOE/RLJ1DKTXjarVFpaM6Q2Gt9LlepYKj0oeGbdRhtXJtx
         fKwXnqs0Senmm91apKAJI7LBWwn4ogo77hDaKe4af+ZUI64piUH5/wjbJLXpZvW2JvxJ
         GhfmQhgHVCwldueHxjdETOqKBKO2tsmJAZll2+/BiWxwhGUZWNcGLtZbHwe6fSIt3jpG
         VIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y2n2+Uz9lfxeIcRjHd5xKcgiwSj7xMIx4TZvu7ih+9A=;
        b=Xu5jPuq3l2BZ69u8Jk/twEw/Nmsv0fVoWHVd7T64LHt9o3p9Qqm0CmZYs3rkcVau18
         WMNbb26c4UqKMnXOXh6IIM1H0M/6W9QbrYkGVLZ6PsweAwAvcd5wbQtYhwB9yCDq1eim
         +JHtN5G7i7ofHWlMg+K6TOu9YCVw7BETd4GPKFCQZeJjzGtQdJcyinz0kiAmZxq9pv1l
         Rbpfvs85S+JjshawZ46/holpJ28AcKKliaowLJLkm0ficXJoWQ2gNCjyQaIEawh40oeQ
         3983pdd0pgwAFEcuwJKjFWlbqTptnhmsjMiUXPsecse2TNiIsssLjUEDlJLGR1Re3TF3
         m8lQ==
X-Gm-Message-State: APjAAAXzY2yPUA4HXLln5NB/WLyuwmNzuRpOESBR7heAPemXr3ZVUHWM
        U3eNnhUwCRtjP2uJc+8rkjcezQ==
X-Google-Smtp-Source: APXvYqy2kfX55qFBNCb+Wrn5ApCpMkIIPzig/1KQ0/VrZP9q4n9Rn3BPNonIOGVM4M7H0XvQuYQdEQ==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr14719193wmc.164.1573818931176;
        Fri, 15 Nov 2019 03:55:31 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id d202sm8926257wmd.47.2019.11.15.03.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 03:55:30 -0800 (PST)
Date:   Fri, 15 Nov 2019 12:55:24 +0100
From:   Marco Elver <elver@google.com>
To:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, edumazet@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 08/10] asm-generic, kcsan: Add KCSAN instrumentation
 for bitops
Message-ID: <20191115115524.GA77379@google.com>
References: <20191114180303.66955-1-elver@google.com>
 <20191114180303.66955-9-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114180303.66955-9-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Marco Elver <elver@google.com>
---
Tentative version of the bitops patch that applies with the new
instrumented bitops infrastructure currently in linux-next. (Note that
that test_bit() is an atomic bitop, but is currently in the wrong
header.)

Otherwise there is no functional change compared to v4 that applies to
mainline.

---
 include/asm-generic/bitops/instrumented-atomic.h     | 7 +++++++
 include/asm-generic/bitops/instrumented-lock.h       | 5 +++++
 include/asm-generic/bitops/instrumented-non-atomic.h | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index 18ce3c9e8eec..eb3abf7e5c08 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -12,6 +12,7 @@
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
 
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 
 /**
  * set_bit - Atomically set a bit in memory
@@ -26,6 +27,7 @@
 static inline void set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_set_bit(nr, addr);
 }
 
@@ -39,6 +41,7 @@ static inline void set_bit(long nr, volatile unsigned long *addr)
 static inline void clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit(nr, addr);
 }
 
@@ -55,6 +58,7 @@ static inline void clear_bit(long nr, volatile unsigned long *addr)
 static inline void change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_change_bit(nr, addr);
 }
 
@@ -68,6 +72,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
 static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit(nr, addr);
 }
 
@@ -81,6 +86,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_clear_bit(nr, addr);
 }
 
@@ -94,6 +100,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_change_bit(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
index ec53fdeea9ec..2c80dca31e27 100644
--- a/include/asm-generic/bitops/instrumented-lock.h
+++ b/include/asm-generic/bitops/instrumented-lock.h
@@ -12,6 +12,7 @@
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H
 
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 
 /**
  * clear_bit_unlock - Clear a bit in memory, for unlock
@@ -23,6 +24,7 @@
 static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit_unlock(nr, addr);
 }
 
@@ -38,6 +40,7 @@ static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit_unlock(nr, addr);
 }
 
@@ -53,6 +56,7 @@ static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
@@ -72,6 +76,7 @@ static inline bool
 clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
 }
 /* Let everybody know we have it. */
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index 95ff28d128a1..8479af8b3309 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -12,6 +12,7 @@
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 
 /**
  * __set_bit - Set a bit in memory
@@ -25,6 +26,7 @@
 static inline void __set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
 }
 
@@ -40,6 +42,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
 static inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
 }
 
@@ -55,6 +58,7 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
 static inline void __change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
 }
 
@@ -69,6 +73,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -83,6 +88,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -97,6 +103,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_change_bit(nr, addr);
 }
 
@@ -108,6 +115,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 static inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
 	kasan_check_read(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
 }
 
-- 
2.24.0.432.g9d3f5f5b63-goog

