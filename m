Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAB2144190
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 17:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgAUQFf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 11:05:35 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:41262 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbgAUQFf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 11:05:35 -0500
Received: by mail-wm1-f74.google.com with SMTP id b9so800815wmj.6
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XsOEVIH7jX8NSYZHOvo5XGjY3g9CTXyDnOv/v4uZ/Bk=;
        b=OiZZ2Nb93WzqM/xay4g2MPDQaess9FXRBwerPe/bjrB4AM1B5fq0yrgDCk0BlgpFT2
         SpIRqiZDEUj80LWb1VBF86zD5sqE+1RB74+6xasrreaTbaOdq61PQlsvSaTKu2gaxZzD
         erOR1NuwBSIJAtchjbV9KoJJcMs/0ljiXBp/PUpOENSp/SdCmnSHG8tVZ6eXKNzr0M+t
         Xs2i/Js2gQS4oZaUSGgXkyT1V8RNPkN6NAeEqQFpUjTsXjxaW1D0v2bgFMV2EBkqWwhQ
         WN7O99VdX+Z3tshCFERKkNu9P/yMN3G5BW3JJeS2Jv4+0o34EgFzhzA4I4CpS1h8Y6pR
         Q/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XsOEVIH7jX8NSYZHOvo5XGjY3g9CTXyDnOv/v4uZ/Bk=;
        b=jnk7jhrZYOWj4prsrFcA/1GArRgnw2PeuC0PdamedfGYw05nt4fqtU4FXC+9Hni44k
         ka+jMssDnofQLwsW4/+Y/CzOPGvE3poVlU+PnTAGRPl2mGS8vqD/h0dCp1L3q58Xd/NC
         0P4bGaQk0rxre8fMwF6dnZG4ulqVI61rbPnlkaNXSieBOZoZbc54sE77SusCD51Kd9MS
         HIC4NDsMD/7OziZ72SdBDaotc652m3IBAgBCAP/g5gtU1Tof7HXSfUXgY0NPUk2rjvwZ
         HLEog2U9xkGI2/dZksTPMqml8vhisnCPuCapMgQDAc5Egk1cxuPu3doiSgoP5DHBPofv
         IENg==
X-Gm-Message-State: APjAAAXV13mcKEXdtOe+AShfXvRIte0Nxt+iQRYE/UTm668ze971fXgP
        Zjup3jm/7iu0oLK066rVmahB4h5ctA==
X-Google-Smtp-Source: APXvYqz+1Mjgby+x98GYjMFotAm6hv41vsDbXkTi9FjjY0lpD1ghVFNdSvClGDRFe0vsVkWX9JAtnZEWrQ==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr6190858wre.372.1579622732563;
 Tue, 21 Jan 2020 08:05:32 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:05:10 +0100
In-Reply-To: <20200121160512.70887-1-elver@google.com>
Message-Id: <20200121160512.70887-3-elver@google.com>
Mime-Version: 1.0
References: <20200121160512.70887-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 3/5] asm-generic, kcsan: Add KCSAN instrumentation for bitops
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, viro@zeniv.linux.org.uk, dja@axtens.net,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, mhiramat@kernel.org,
        rostedt@goodmis.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        keescook@chromium.org, cyphar@cyphar.com,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add explicit KCSAN checks for bitops.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/bitops/instrumented-atomic.h | 14 +++++++-------
 include/asm-generic/bitops/instrumented-lock.h   | 10 +++++-----
 .../asm-generic/bitops/instrumented-non-atomic.h | 16 ++++++++--------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index 18ce3c9e8eec..fb2cb33a4013 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
 
-#include <linux/kasan-checks.h>
+#include <linux/instrumented.h>
 
 /**
  * set_bit - Atomically set a bit in memory
@@ -25,7 +25,7 @@
  */
 static inline void set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_set_bit(nr, addr);
 }
 
@@ -38,7 +38,7 @@ static inline void set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit(nr, addr);
 }
 
@@ -54,7 +54,7 @@ static inline void clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_change_bit(nr, addr);
 }
 
@@ -67,7 +67,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit(nr, addr);
 }
 
@@ -80,7 +80,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_clear_bit(nr, addr);
 }
 
@@ -93,7 +93,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_change_bit(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
index ec53fdeea9ec..b9bec468ae03 100644
--- a/include/asm-generic/bitops/instrumented-lock.h
+++ b/include/asm-generic/bitops/instrumented-lock.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H
 
-#include <linux/kasan-checks.h>
+#include <linux/instrumented.h>
 
 /**
  * clear_bit_unlock - Clear a bit in memory, for unlock
@@ -22,7 +22,7 @@
  */
 static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit_unlock(nr, addr);
 }
 
@@ -37,7 +37,7 @@ static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit_unlock(nr, addr);
 }
 
@@ -52,7 +52,7 @@ static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
@@ -71,7 +71,7 @@ static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 static inline bool
 clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
 }
 /* Let everybody know we have it. */
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index 95ff28d128a1..20f788a25ef9 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
-#include <linux/kasan-checks.h>
+#include <linux/instrumented.h>
 
 /**
  * __set_bit - Set a bit in memory
@@ -24,7 +24,7 @@
  */
 static inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
 }
 
@@ -39,7 +39,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
 }
 
@@ -54,7 +54,7 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
 }
 
@@ -68,7 +68,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -82,7 +82,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -96,7 +96,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_change_bit(nr, addr);
 }
 
@@ -107,7 +107,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
-	kasan_check_read(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
 }
 
-- 
2.25.0.341.g760bfbb309-goog

