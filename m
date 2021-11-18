Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4484556B3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbhKRIRp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbhKRIQb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:16:31 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26653C061229
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:41 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so2709676wms.8
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JvNCvfwB/M304r5/BDcWOzh3dLnMrHum3apHlfxEx/4=;
        b=KS5G8h986j9sc/Uc4XdJMHZJhIlkOTQBAy48Lxafi4vJyp5Ph9GvBgnIcXQ14fx5Ll
         tsZ58qA/jCMlqmF97AHABIaHWfYbihigO0oV7oES1tFIrl7wChZIblILu2NSz7D85M26
         MO+Zmc9OW5xDLFr+AeHQMzsQRAZBrhRpVbKTwKLwKSZIeKS8lfzxmR95Ui6ni+nTmr6E
         wIwwW5KNJkUDHLF/lHPW9IKwSmwlz/J8Rj5xMp8kJyR6HDTkULvDsTTQEg3DaKv4fJPl
         ZN4B5/+VWhh9oqETcL/7ufk5kSgUCWzyBJ3vde31WmCYvQdiuWX+stm/J176jRrPe9v2
         G5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JvNCvfwB/M304r5/BDcWOzh3dLnMrHum3apHlfxEx/4=;
        b=4aYq3ztBgYEKp/6VVhUUNWuWd97eMFLBebNSurp+1bmJUSBqhSTzMWjHFWr0v5z6Z7
         ndC/Czpl8kNiGcwKiU0PMOwXIT2zns8NVUYXIjpWubAuVGWxS/jSK5EwClUcq0fI+8DI
         Rg+K7uouUav0g/d+KG47pJMZU/c0M36d0CtbtsOcV8t/CdkpvWbtCQMqljgOhhorb6++
         qvqd49ARSAjH+6pkhbpESSZOwF26aRs0GK8iUZMisyUm9tAfZmJg+GT4HjHySt9UPQvu
         3ZVZmpNU+rpCdswhWE4ICP/c+CNeIyg+bzzcgU7bnOXseEK5n0jCk4mbS1VDSCPFc35H
         vT0Q==
X-Gm-Message-State: AOAM533nbgECxwjs3aNe05m9Z0FWRC/F43hUa6s56Mpk2oOs8A6GNd3w
        AUwoUvmr9Kd77/2IH8yNJO7SdfVh/A==
X-Google-Smtp-Source: ABdhPJwIZSXmzEGob1LuBcisccmmFYtbTwPz0+SiD1LD4+JTB2zMVVMY+W3yM6QPfYERPfOO7UZZAKBHKQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a05:600c:4f44:: with SMTP id
 m4mr7898634wmq.95.1637223099727; Thu, 18 Nov 2021 00:11:39 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:21 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-18-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 17/23] asm-generic/bitops, kcsan: Add instrumentation for barriers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Adds the required KCSAN instrumentation for barriers of atomic bitops.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/asm-generic/bitops/instrumented-atomic.h | 3 +++
 include/asm-generic/bitops/instrumented-lock.h   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index 81915dcd4b4e..c90192b1c755 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -67,6 +67,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
+	kcsan_mb();
 	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit(nr, addr);
 }
@@ -80,6 +81,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
+	kcsan_mb();
 	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_clear_bit(nr, addr);
 }
@@ -93,6 +95,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
+	kcsan_mb();
 	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_change_bit(nr, addr);
 }
diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
index 75ef606f7145..eb64bd4f11f3 100644
--- a/include/asm-generic/bitops/instrumented-lock.h
+++ b/include/asm-generic/bitops/instrumented-lock.h
@@ -22,6 +22,7 @@
  */
 static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
+	kcsan_release();
 	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit_unlock(nr, addr);
 }
@@ -37,6 +38,7 @@ static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
+	kcsan_release();
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit_unlock(nr, addr);
 }
@@ -71,6 +73,7 @@ static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 static inline bool
 clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
 {
+	kcsan_release();
 	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

