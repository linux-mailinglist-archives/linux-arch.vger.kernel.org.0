Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CF213CA13
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 17:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAOQ6U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 11:58:20 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:53500 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAOQ6U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 11:58:20 -0500
Received: by mail-qv1-f73.google.com with SMTP id g15so11381909qvq.20
        for <linux-arch@vger.kernel.org>; Wed, 15 Jan 2020 08:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1xyFxbboVErs2lDyuCkQizXSlJ3hz4CWgsOgebKOGj4=;
        b=aU2dtLHigZRJd+hlW8EQuXLHMX2F9ZXY7sCEvFpLeh51N7x7lJHs85kOd8HFZMs1f8
         oq7jGjUtbQQubJ99O/Af/0JWQL2OAC9LpF5RfG186nDtgWI71DXLdV1w2UqevG4rUBCQ
         0Qd2GJpH/WZoe9ZioaZM28D7Bg3LFOc+A9x/iEj9tjgfWyb86mn7IDSdd33MbGQzd1SM
         3ZA7edHXg8mTIrburBDoA4BCh1L0EkorUWKQZZqITF9tLl3qG4Op0QbKBdvApS0cM6R/
         4NScpwma4R4e/Na3FDvZPNEFqyu40EbjXri1/pCAI1aBQl5nEjqOXNVyWaGxau01HeC/
         JDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1xyFxbboVErs2lDyuCkQizXSlJ3hz4CWgsOgebKOGj4=;
        b=Ng0Jh0JhCp4G9NxkSlC1d2iv70vSOE23LSYpzvJE3Qiueg2MqhQ+fOm8m0zBdxfgoE
         i3fPye17iS8Fiyluv2GDT2OXMv0d44tHMmtMuguVXU5xUbiG34uusPpoJrxBDB7QuksD
         XxpnMaDcaOsRSlehubUiRI0O06tXYveqglh5PBZGsMbGEs6UE0TpB1BGde8NOBhcO2j5
         pOWsGu5Myo3vzD8uI5TpHXD4cv3JloThIGIM4XmvAvgJV/pRRaZiLS3i/OzXZ0XsbdjL
         FK6CNAzzafOblutB9TqONEiGoSB3xawxQrVF7UG8tPOtVbuRgc4MFMsYReepDc1rVKX5
         1euA==
X-Gm-Message-State: APjAAAX5QHVaspv/xU4ZVjeJ/wJGKB1kBDMajysqRZyl7/EUYL4fLIfo
        Rfd9/L7CYqG1VjvcHpbEsa8rm8H6Dg==
X-Google-Smtp-Source: APXvYqxJE/Ataswadww4mtWXwvOLdKAEh1UpAz1OhNLbQMvG5lheRc9H7MVreNjGxDM52EbxfEmCm11qZg==
X-Received: by 2002:ac8:330e:: with SMTP id t14mr4605524qta.232.1579107498675;
 Wed, 15 Jan 2020 08:58:18 -0800 (PST)
Date:   Wed, 15 Jan 2020 17:57:49 +0100
Message-Id: <20200115165749.145649-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr, dja@axtens.net, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add explicit KCSAN checks for bitops.

Signed-off-by: Marco Elver <elver@google.com>
---
The same patch was previously sent, but at that point the updated bitops
instrumented infrastructure was not yet in mainline:
 http://lkml.kernel.org/r/20191115115524.GA77379@google.com

Note that test_bit() is an atomic bitop, and KCSAN treats it as such,
although it is in the non-atomic header. Currently it cannot be moved:
 http://lkml.kernel.org/r/87pnh5dlmn.fsf@dja-thinkpad.axtens.net
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
2.25.0.rc1.283.g88dfdc4193-goog

