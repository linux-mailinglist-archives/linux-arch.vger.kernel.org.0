Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5432F422466
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 13:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhJELDV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhJELDA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:03:00 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AF2C0613AA
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 04:00:23 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 90-20020aed3163000000b002a6bd958077so22834993qtg.6
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 04:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aJbTcuURS/chesQOBDsBj7S41hJcRc/zL/qDV/Um5us=;
        b=BbV5uAK97obmNYDliUtqw0GOKWU8gRY8670jg0FGkfCOl/BDOBUmvDlO6y+6Nw4Jgn
         CfJN7QglUerqcxhodLjEyBZShqp4ICKrf4W5xF34Vl5c5QKflyz98mLQU//FeWddOm2e
         p/uR5E2cuLHejLdL8vN8jRxSsC4BcY9UOkkNxSr0C7fJ7qv75CXtp4D3Ic92scHPNmif
         dD338wArlvfKbLVVOSM+Nw9cqI/cJgYIsB/FYIikM+8eanE27mb2CRogMrrq2fTAUK7N
         5KvvRfLb6EijEfArLGnmjYZ5E3/gz/90hEH6UQiVZRzs8RZ5JrdlRULHMetclefDRlYT
         Tgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aJbTcuURS/chesQOBDsBj7S41hJcRc/zL/qDV/Um5us=;
        b=mgHPurDUGR5npDbyICOS5ClJFcyZ4Dn19OEjrbjbU3e5oQh/3U7Ar1joUoQ88DSfcb
         jl/S0lbFXnb8dvtNJz0BX8d3UvplUq/FSQStApDirrLlyugw43pZNejzgyXvqyYs4H0b
         zraru+pGrMtndqpUZJblYZDkLNtE65+MPrg253dnepCUaJzBTyPmdkcbdknfLtYTFPjn
         5S//yYHBksQUJHa7u0t87s1CnNq2hkGlf9A8QAsjN6O2Fl+WJJ66moL2vDxUsXdoZFiZ
         10rKM5V5r+4hERs9mOaq8VgAVVEl7ZZkbkkSKcXKmvXLiUe7a9+Zn/l3+toZ34VdjBbp
         1idw==
X-Gm-Message-State: AOAM530UDOXaW1GPPDxn2ib1WW16p2E8PEYl+UVO1YNhbjuzn79Puww5
        6P3vPiikpx9uXZyIpBsR6KR/2HA//Q==
X-Google-Smtp-Source: ABdhPJxFPawR3DIW3jGpiP41o9DqoiOU2oJs+4Aki7E3BJ7Dw7hLuRBw5fCDg3CS98qZ1Osa83SG8HjgJg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6214:1022:: with SMTP id
 k2mr27294558qvr.53.1633431622928; Tue, 05 Oct 2021 04:00:22 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:59 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-18-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 17/23] asm-generic/bitops, kcsan: Add
 instrumentation for barriers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
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
2.33.0.800.g4c38ced690-goog

