Return-Path: <linux-arch+bounces-7005-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3B596BDD9
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F6C1C21994
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063BA1DCB22;
	Wed,  4 Sep 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KkWUiI7G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGVPaphm"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7C1DC1AC;
	Wed,  4 Sep 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455139; cv=none; b=VJ1db6scj97tvvgxZkUT08IRZ4oRQgZRNsXPMqIlGzEfLKTxJDzutc11Djh8v5wdz9bvWOIlQ2IWamhlorSejuq3XC5+AJLf3BBuc79enNsezWoYqvJn6FxkjP87fhIXbsGVF4y2EIn4gZ9DjBlrhUERwRzwh23mYyWJLdcWCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455139; c=relaxed/simple;
	bh=lq+j0e/8+B+CBghNSJokdBW4yysfRaHHcpZuOTFu4jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OC32ZJddXzWZx6u4BhOrZ9T2N1nPMFtJ9jeCCVCXPwoHAFXvCf8+dUJIujLAXXB4PWu8GaZsxl+1urHXHl9xLseEh8qZTMzidOh/k3E2XnXPeBXsrglh59VnGrSb5JoapcW/3EPMIebM2AghZRz7ofL17PsMnPCvWg2HEddzvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KkWUiI7G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGVPaphm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6wpVq7tSU8GXjnK50bDdv4b35oGLvoXViWUHQ1ET4U=;
	b=KkWUiI7G5XAYGHsQr1rkeyfVFQ7dZPXjuv80Vxc5N2xu6MUZ8RBweRA9houKeZMcXhtDjb
	oTl4BGrdRa/p9umShdst3ON7WcUW/Yhy8iSGmGFtjjL9BVRXL/VUw5Kl5dp9efEWNSOlh6
	qAW7tvfJR79Jg2EAvPntIe5Z5T/+uFR6UAkDsnScuNBiFG/rjF4dlNHtphfzWFsuxDveng
	hh8M46l3OhNdKoVasY3GlvB8gYHaCjJ294CsJsepc5SzUHx8op8Uv6yNiX5S/AFGyrSDaX
	5m4qdi6QnurqaXPcf6IrECWTtbJ1yQ8gkhR4RdmixEubLbRpZA77Fw5EPaqRWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6wpVq7tSU8GXjnK50bDdv4b35oGLvoXViWUHQ1ET4U=;
	b=zGVPaphm8MGqWJxNTta9PUrLNw4Jfjrye1zXQp7mXvr3NtTBLS1OcNTAyh7jD31Qx9MvBB
	4F+4rH/koRGvxIBg==
Date: Wed, 04 Sep 2024 15:04:56 +0200
Subject: [PATCH 06/15] timers: Update function descriptions of sleep/delay
 related functions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-6-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

A lot of commonly used functions for inserting a sleep or delay lack a
proper function description. Add function descriptions to all of them to
have important information in a central place close to the code.

No functional change.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/asm-generic/delay.h | 46 ++++++++++++++++++++++++++++++++++-----
 include/linux/delay.h       | 48 ++++++++++++++++++++++++++++++----------
 kernel/time/sleep_timeout.c | 53 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 123 insertions(+), 24 deletions(-)

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index e448ac61430c..76531ea7597a 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -11,12 +11,37 @@ extern void __ndelay(unsigned long nsecs);
 extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);
 
-/*
- * The weird n/20000 thing suppresses a "comparison is always false due to
- * limited range of data type" warning with non-const 8-bit arguments.
+/**
+ * udelay - Inserting a delay based on microseconds with busy waiting
+ * @n:	requested delay in microseconds
+ *
+ * When delaying in an atomic context ndelay(), udelay() and mdelay() are the
+ * only valid variants of delaying/sleeping to go with.
+ *
+ * When inserting delays in non atomic context which are shorter than the time
+ * which is required to queue e.g. an hrtimer and to enter then the scheduler,
+ * it is also valuable to use udelay(). But is not simple to specify a generic
+ * threshold for this which will fit for all systems, but an approximation would
+ * be a threshold for all delays up to 10 microseconds.
+ *
+ * When having a delay which is larger than the architecture specific
+ * %MAX_UDELAY_MS value, please make sure mdelay() is used. Otherwise a overflow
+ * risk is given.
+ *
+ * Please note that ndelay(), udelay() and mdelay() may return early for several
+ * reasons (https://lists.openwall.net/linux-kernel/2011/01/09/56):
+ *
+ * #. computed loops_per_jiffy too low (due to the time taken to execute the
+ *    timer interrupt.)
+ * #. cache behaviour affecting the time it takes to execute the loop function.
+ * #. CPU clock rate changes.
+ *
+ * Impelementation details for udelay() only:
+ *
+ * * The weird n/20000 thing suppresses a "comparison is always false due to
+ *   limited range of data type" warning with non-const 8-bit arguments.
+ * * 0x10c7 is 2**32 / 1000000 (rounded up)
  */
-
-/* 0x10c7 is 2**32 / 1000000 (rounded up) */
 #define udelay(n)							\
 	({								\
 		if (__builtin_constant_p(n)) {				\
@@ -29,7 +54,16 @@ extern void __delay(unsigned long loops);
 		}							\
 	})
 
-/* 0x5 is 2**32 / 1000000000 (rounded up) */
+/**
+ * ndelay - Inserting a delay based on nanoseconds with busy waiting
+ * @n:	requested delay in nanoseconds
+ *
+ * See udelay() for basic information about ndelay() and it's variants.
+ *
+ * Impelmentation details for ndelay():
+ *
+ * * 0x5 is 2**32 / 1000000000 (rounded up)
+ */
 #define ndelay(n)							\
 	({								\
 		if (__builtin_constant_p(n)) {				\
diff --git a/include/linux/delay.h b/include/linux/delay.h
index 2bc586aa2068..23623fa79768 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -6,17 +6,7 @@
  * Copyright (C) 1993 Linus Torvalds
  *
  * Delay routines, using a pre-computed "loops_per_jiffy" value.
- *
- * Please note that ndelay(), udelay() and mdelay() may return early for
- * several reasons:
- *  1. computed loops_per_jiffy too low (due to the time taken to
- *     execute the timer interrupt.)
- *  2. cache behaviour affecting the time it takes to execute the
- *     loop function.
- *  3. CPU clock rate changes.
- *
- * Please see this thread:
- *   https://lists.openwall.net/linux-kernel/2011/01/09/56
+ * Sleep routines using timer list timers or hrtimers.
  */
 
 #include <linux/math.h>
@@ -35,12 +25,21 @@ extern unsigned long loops_per_jiffy;
  * The 2nd mdelay() definition ensures GCC will optimize away the 
  * while loop for the common cases where n <= MAX_UDELAY_MS  --  Paul G.
  */
-
 #ifndef MAX_UDELAY_MS
 #define MAX_UDELAY_MS	5
 #endif
 
 #ifndef mdelay
+/**
+ * mdelay - Inserting a delay based on microseconds with busy waiting
+ * @n:	requested delay in microseconds
+ *
+ * See udelay() for basic information about mdelay() and it's variants.
+ *
+ * Please double check, whether mdelay() is the right way to go or whether a
+ * refactoring of the code is the better variant to be able to use msleep()
+ * instead.
+ */
 #define mdelay(n) (\
 	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
 	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
@@ -63,16 +62,41 @@ unsigned long msleep_interruptible(unsigned int msecs);
 void usleep_range_state(unsigned long min, unsigned long max,
 			unsigned int state);
 
+/**
+ * usleep_range - Sleep for an approximate time
+ * @min:	Minimum time in microseconds to sleep
+ * @max:	Maximum time in microseconds to sleep
+ *
+ * For basic information please refere to usleep_range_state().
+ *
+ * The task will be in the state TASK_UNINTERRUPTIBLE during the sleep.
+ */
 static inline void usleep_range(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
 }
 
+/**
+ * usleep_range_idle - Sleep for an approximate time with idle time accounting
+ * @min:	Minimum time in microseconds to sleep
+ * @max:	Maximum time in microseconds to sleep
+ *
+ * For basic information please refere to usleep_range_state().
+ *
+ * The sleeping task has the state TASK_IDLE during the sleep to prevent
+ * contribution to the load avarage.
+ */
 static inline void usleep_range_idle(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_IDLE);
 }
 
+/**
+ * ssleep - wrapper for seconds arount msleep
+ * @seconds:	Requested sleep duration in seconds
+ *
+ * Please refere to msleep() for detailed information.
+ */
 static inline void ssleep(unsigned int seconds)
 {
 	msleep(seconds * 1000);
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 9ecbce7da537..1ebd8429a64a 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -267,7 +267,34 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout);
 
 /**
  * msleep - sleep safely even with waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
+ * @msecs:	Requested sleep duration in milliseconds
+ *
+ * msleep() uses jiffie based timeouts for the sleep duration. The accuracy of
+ * the resulting sleep duration depends on:
+ *
+ * * HZ configuration
+ * * sleep duration (as granularity of a bucket which collects timers increases
+ *   with the timer wheel levels)
+ *
+ * When the timer is queued into the second level of the timer wheel the maximum
+ * additional delay will be 12.5%. For explanation please check the detailed
+ * description about the basics of the timer wheel. In case this is accurate
+ * enough check which sleep length is selected to make sure required accuracy is
+ * given. Please use therefore the following simple steps:
+ *
+ * #. Decide which slack is fine for the requested sleep duration - but do not
+ *    use values shorter than 1/8
+ * #. Check whether your sleep duration is equal or greater than the following
+ *    result: ``TICK_NSEC / slack / NSEC_PER_MSEC``
+ *
+ * Examples:
+ *
+ * * ``HZ=1000`` with `slack=1/4``: all sleep durations greater or equal 4ms will meet
+ *   the constrains.
+ * * ``HZ=250`` with ``slack=1/4``: all sleep durations greater or equal 16ms will meet
+ *   the constrains.
+ *
+ * See also the signal aware variant msleep_interruptible().
  */
 void msleep(unsigned int msecs)
 {
@@ -280,7 +307,15 @@ EXPORT_SYMBOL(msleep);
 
 /**
  * msleep_interruptible - sleep waiting for signals
- * @msecs: Time in milliseconds to sleep for
+ * @msecs:	Requested sleep duration in milliseconds
+ *
+ * See msleep() for some basic information.
+ *
+ * The difference between msleep() and msleep_interruptible() is that the sleep
+ * could be interrupted by a signal delivery and then returns early.
+ *
+ * Returns the remaining time of the sleep duration transformed to msecs (see
+ * schedule_timeout() for details).
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
@@ -298,11 +333,17 @@ EXPORT_SYMBOL(msleep_interruptible);
  * @max:	Maximum time in usecs to sleep
  * @state:	State of the current task that will be while sleeping
  *
+ * usleep_range_state() sleeps at least for the minimum specified time but not
+ * longer than the maximum specified amount of time. The range might reduce
+ * power usage by allowing hrtimers to coalesce an already scheduled interrupt
+ * with this hrtimer. In the worst case, an interrupt is scheduled for the upper
+ * bound.
+ *
+ * The sleeping task is set to the specified state before starting the sleep.
+ *
  * In non-atomic context where the exact wakeup time is flexible, use
- * usleep_range_state() instead of udelay().  The sleep improves responsiveness
- * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
- * power usage by allowing hrtimers to take advantage of an already-
- * scheduled interrupt instead of scheduling a new one just for this sleep.
+ * usleep_range() or its variants instead of udelay(). The sleep improves
+ * responsiveness by avoiding the CPU-hogging busy-wait of udelay().
  */
 void __sched usleep_range_state(unsigned long min, unsigned long max,
 				unsigned int state)

-- 
2.39.2


