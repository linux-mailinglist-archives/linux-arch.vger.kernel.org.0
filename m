Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C770243D8E
	for <lists+linux-arch@lfdr.de>; Thu, 13 Aug 2020 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMQjM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Aug 2020 12:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMQjK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Aug 2020 12:39:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B99C061757
        for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2020 09:39:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x6so2641314ybp.10
        for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2020 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EXiQM+OwcDwzJXyrdpXsirkqETQSrhVgpmlZfZrdtjc=;
        b=kbQXXy2Br/AFpYkqCCVq+6G3bfVl89zpyvWXt4TYDX2SXDXd1iTdCN07X+axL36Ey0
         sOLxfln1DJ3GV+qih0WxxGSejMXTb9MAqj2CbHKxwIGhHFoH9VHb+0jMFniJwIY+QqJS
         kohWx/f16EI4Xk2vY0WtiJtXgZTB1CUZ81oYhgzzp1WGyCYiqI1Rhd+/Tvo6lfOVXvcb
         qieie+McAyR3Chc5Bshekzyr6fXw8nmKvLUoXiHU+UQQYjvZt0Vfrfs+zem9wXXRUgqm
         RKH6F6lMdvBahsYXEPq8MvPsLrx5zWia9CpNZm94jyEh8bxKDUyTXnmMul+Owa+1n16D
         1AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EXiQM+OwcDwzJXyrdpXsirkqETQSrhVgpmlZfZrdtjc=;
        b=ou6pundhwJNlpy93RMmWJGQwRXNZbLLDI3EClXAxGEmpGYI83udOeUt7hjvY6XuFd0
         ePbT7wj4R3HN3Vw1Pi08y9KAsgfc5oJGDdBnJCHmqoTfrRHl8cmeSWLlkyeQu0YL8D05
         rMGrPNooUELhAE10Yfc3jAc7xsK7VlAgGwYiIne7tktUtzkWVogpBaSGouMxSI3DpR0K
         yqxBJFvtKE7TWxqsAjvhh1T4eNEj45BtLCMkG8fx6pKftH0TdSYTcQGbuPP3tEblvvof
         YBAdxG1cqUfwjJdasA10IgeH+v4BW2jPPYuVEcDw0QP4UD4YzvotnnMP2+exrE+avmtH
         +DeQ==
X-Gm-Message-State: AOAM533GWAWU3qgoZTor4ylEMfdx7gt3wR1Id5y44PcYZAqWmvMPvsLq
        nIeHnT/GtTTDQRkQQpXZEiaW8Vp51A==
X-Google-Smtp-Source: ABdhPJwOdPYdqT7+nmxItFw65wVeLEm8uIeKJi5WajcP2puZEWW51k4mZdhZm91QlF9mSA9SXdnhIZ7JgQ==
X-Received: by 2002:a25:d1ce:: with SMTP id i197mr8653927ybg.100.1597336748940;
 Thu, 13 Aug 2020 09:39:08 -0700 (PDT)
Date:   Thu, 13 Aug 2020 18:38:59 +0200
Message-Id: <20200813163859.1542009-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH] bitops, kcsan: Partially revert instrumentation for
 non-atomic bitops
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        linux-arch@vger.kernel.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Previous to the change to distinguish read-write accesses, when
CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y is set, KCSAN would consider
the non-atomic bitops as atomic. We want to partially revert to this
behaviour, but with one important distinction: report racing
modifications, since lost bits due to non-atomicity are certainly
possible.

Given the operations here only modify a single bit, assuming
non-atomicity of the writer is sufficient may be reasonable for certain
usage (and follows the permissible nature of the "assume plain writes
atomic" rule). In other words:

	1. We want non-atomic read-modify-write races to be reported;
	   this is accomplished by kcsan_check_read(), where any
	   concurrent write (atomic or not) will generate a report.

	2. We do not want to report races with marked readers, but -do-
	   want to report races with unmarked readers; this is
	   accomplished by the instrument_write() ("assume atomic
	   write" with Kconfig option set).

With the above rules, when KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is selected,
it is hoped that KCSAN's reporting behaviour is better aligned with
current expected permissible usage for non-atomic bitops.

Note that, a side-effect of not telling KCSAN that the accesses are
read-writes, is that this information is not displayed in the access
summary in the report. It is, however, visible in inline-expanded stack
traces. For now, it does not make sense to introduce yet another special
case to KCSAN's runtime, only to cater to the case here.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
As discussed, partially reverting behaviour for non-atomic bitops when
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is selected.

I'd like to avoid more special cases in KCSAN's runtime to cater to
cases like this, not only because it adds more complexity, but it
invites more special cases to be added. If there are other such
primitives, we likely have to do it on a case-by-case basis as well, and
justify carefully for each such case. But currently, as far as I can
tell, the bitops are truly special, simply because we do know each op
just touches a single bit.
---
 .../bitops/instrumented-non-atomic.h          | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index f86234c7c10c..37363d570b9b 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -58,6 +58,30 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
 	arch___change_bit(nr, addr);
 }
 
+static inline void __instrument_read_write_bitop(long nr, volatile unsigned long *addr)
+{
+	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC)) {
+		/*
+		 * We treat non-atomic read-write bitops a little more special.
+		 * Given the operations here only modify a single bit, assuming
+		 * non-atomicity of the writer is sufficient may be reasonable
+		 * for certain usage (and follows the permissible nature of the
+		 * assume-plain-writes-atomic rule):
+		 * 1. report read-modify-write races -> check read;
+		 * 2. do not report races with marked readers, but do report
+		 *    races with unmarked readers -> check "atomic" write.
+		 */
+		kcsan_check_read(addr + BIT_WORD(nr), sizeof(long));
+		/*
+		 * Use generic write instrumentation, in case other sanitizers
+		 * or tools are enabled alongside KCSAN.
+		 */
+		instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	} else {
+		instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
+	}
+}
+
 /**
  * __test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
@@ -68,7 +92,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -82,7 +106,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -96,7 +120,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_change_bit(nr, addr);
 }
 
-- 
2.28.0.220.ged08abb693-goog

