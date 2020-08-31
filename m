Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B58B2580C7
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgHaSTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgHaSSK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A0621527;
        Mon, 31 Aug 2020 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897889;
        bh=hBoTCY3wufyykmsMzLAZBTAUqq6AkK7/XOgebGts+Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fn8Jyr95jYbB/aSvYoFkJhECOdjtkbUR67dWEJCAszFbK0qZlLKzT9LfNUc8EReF6
         YFvYxhdkZls1FCZuEgh2G50j21JPhyl025W3jaKOdTKUwLwfYn4mUMNMfXtrhrLoVw
         raPCgDFHA/FTiJ2s7zm8TP6FSPBPllieZFlEcD94=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Subject: [PATCH kcsan 18/19] bitops, kcsan: Partially revert instrumentation for non-atomic bitops
Date:   Mon, 31 Aug 2020 11:18:04 -0700
Message-Id: <20200831181805.1833-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marco Elver <elver@google.com>

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

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../asm-generic/bitops/instrumented-non-atomic.h   | 30 +++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index f86234c..37363d5 100644
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
2.9.5

