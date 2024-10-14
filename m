Return-Path: <linux-arch+bounces-8068-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A0399C303
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 10:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46971284635
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224AE157481;
	Mon, 14 Oct 2024 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vO0Nh6O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z/ZvZF07"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61415575B;
	Mon, 14 Oct 2024 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894171; cv=none; b=JMWl+UF4e5RceH1PghJu17Ie1uPGFLyXUUtLmNhu7lyHty2yFjexjSXzsiAk0sTss3ntJ25J5quqaNf6Tc0442wxuSfDobzzqiwldk+aQl0zlpAeSFoofyftVrVSoLCPYTMMCtP2cawwuaUnSQIFw6aDpCE75/K/HdS4iJvrrxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894171; c=relaxed/simple;
	bh=u8QJ5+veB/42sFjbq73Nx90Rwi8dxtfPYberW/kuDhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDgZ5Ycz7lTg1wVtYP8aZAmFr82kPsv0u78DMHLtVFQADrPCSkcox13cTbXVLLuKmewzkrYK4mBWMrObS3EXB65xmAWesButiGq6qYePowyHQUYglEtysIQFmhu4BSJqeCO0nH3SbTcU8vX0kpCLqeq++fM6Oa0Lbb1QVg0T3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vO0Nh6O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z/ZvZF07; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6f9ANd86VKUTjMkX0jmN2iyxtAUU2JdpNcLRkkFjFA=;
	b=0vO0Nh6OCzktv2f7aCX4RjoGIE23b0ST65q/DfxZySwBMbLepYEwkTRBKEOOLOzMUCN3Gf
	3bbFyh7wMqdnUzws4nfHzI48rwtOIPc/Gz9oJYEWwEvuNFQZl0WKxT3/sEI1l0Vq2aXVBw
	zgkb+qXhXRKkEh1lUaxWA9LTlQMU3QZcCjLCMwNuxN1dHXnskGdwMR0ZAZy+WfLWdlj0LD
	9RoA7XIbI4gz1ZZxtOpJ0Vd/uiA6ZLoJYSWhWgQmLj2l6Fyrv1lILuYLDXzJtIX/fpBw0s
	4a5WXaVZ02LkS8gJ+xghUhVJtKvrbp7BsHp+MDlYqbUkkdl/Aa0YJNqo4BtO+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6f9ANd86VKUTjMkX0jmN2iyxtAUU2JdpNcLRkkFjFA=;
	b=Z/ZvZF07hN8kzJsgK9euX4QKIb5o2S7c5/Chk7jBhLk5eAVOdYpsfxhlir+aTs1a4C2Ypp
	fVxfgK829fCHoWAw==
Date: Mon, 14 Oct 2024 10:22:22 +0200
Subject: [PATCH v3 05/16] timers: Update function descriptions of
 sleep/delay related functions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-5-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-arch@vger.kernel.org

A lot of commonly used functions for inserting a sleep or delay lack a
proper function description. Add function descriptions to all of them to
have important information in a central place close to the code.

No functional change.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v3:
 - Rephrase msleep function description to make it clear

v2:
 - Fix typos
 - Fix proper usage of kernel-doc return formatting
---
 include/asm-generic/delay.h | 41 +++++++++++++++++++++++++++++++----
 include/linux/delay.h       | 48 ++++++++++++++++++++++++++++++----------
 kernel/time/sleep_timeout.c | 53 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 120 insertions(+), 22 deletions(-)

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index e448ac61430c..a8cee41cc51b 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -12,11 +12,39 @@ extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);
 
 /*
- * The weird n/20000 thing suppresses a "comparison is always false due to
- * limited range of data type" warning with non-const 8-bit arguments.
+ * Implementation details:
+ *
+ * * The weird n/20000 thing suppresses a "comparison is always false due to
+ *   limited range of data type" warning with non-const 8-bit arguments.
+ * * 0x10c7 is 2**32 / 1000000 (rounded up) -> udelay
+ * * 0x5 is 2**32 / 1000000000 (rounded up) -> ndelay
  */
 
-/* 0x10c7 is 2**32 / 1000000 (rounded up) */
+/**
+ * udelay - Inserting a delay based on microseconds with busy waiting
+ * @usec:	requested delay in microseconds
+ *
+ * When delaying in an atomic context ndelay(), udelay() and mdelay() are the
+ * only valid variants of delaying/sleeping to go with.
+ *
+ * When inserting delays in non atomic context which are shorter than the time
+ * which is required to queue e.g. an hrtimer and to enter then the scheduler,
+ * it is also valuable to use udelay(). But it is not simple to specify a
+ * generic threshold for this which will fit for all systems. An approximation
+ * is a threshold for all delays up to 10 microseconds.
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
+ */
 #define udelay(n)							\
 	({								\
 		if (__builtin_constant_p(n)) {				\
@@ -29,7 +57,12 @@ extern void __delay(unsigned long loops);
 		}							\
 	})
 
-/* 0x5 is 2**32 / 1000000000 (rounded up) */
+/**
+ * ndelay - Inserting a delay based on nanoseconds with busy waiting
+ * @nsec:	requested delay in nanoseconds
+ *
+ * See udelay() for basic information about ndelay() and it's variants.
+ */
 #define ndelay(n)							\
 	({								\
 		if (__builtin_constant_p(n)) {				\
diff --git a/include/linux/delay.h b/include/linux/delay.h
index 2bc586aa2068..2de509e4adce 100644
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
+ * mdelay - Inserting a delay based on milliseconds with busy waiting
+ * @n:	requested delay in milliseconds
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
+ * ssleep - wrapper for seconds around msleep
+ * @seconds:	Requested sleep duration in seconds
+ *
+ * Please refere to msleep() for detailed information.
+ */
 static inline void ssleep(unsigned int seconds)
 {
 	msleep(seconds * 1000);
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 560d17c30aa5..f3f246e4c8d1 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -281,7 +281,34 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout);
 
 /**
  * msleep - sleep safely even with waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
+ * @msecs:	Requested sleep duration in milliseconds
+ *
+ * msleep() uses jiffy based timeouts for the sleep duration. Because of the
+ * design of the timer wheel, the maximum additional percentage delay (slack) is
+ * 12.5%. This is only valid for timers which will end up in level 1 or a higher
+ * level of the timer wheel. For explanation of those 12.5% please check the
+ * detailed description about the basics of the timer wheel.
+ *
+ * The slack of timers which will end up in level 0 depends on sleep duration
+ * (msecs) and HZ configuration and can be calculated in the following way (with
+ * the timer wheel design restriction that the slack is not less than 12.5%):
+ *
+ *   ``slack = MSECS_PER_TICK / msecs``
+ *
+ * When the allowed slack of the callsite is known, the calculation could be
+ * turned around to find the minimal allowed sleep duration to meet the
+ * constraints. For example:
+ *
+ * * ``HZ=1000`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 1 / (1/4) = 4``:
+ *   all sleep durations greater or equal 4ms will meet the constraints.
+ * * ``HZ=1000`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 1 / (1/8) = 8``:
+ *   all sleep durations greater or equal 8ms will meet the constraints.
+ * * ``HZ=250`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 4 / (1/4) = 16``:
+ *   all sleep durations greater or equal 16ms will meet the constraints.
+ * * ``HZ=250`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 4 / (1/8) = 32``:
+ *   all sleep durations greater or equal 32ms will meet the constraints.
+ *
+ * See also the signal aware variant msleep_interruptible().
  */
 void msleep(unsigned int msecs)
 {
@@ -294,7 +321,15 @@ EXPORT_SYMBOL(msleep);
 
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
+ * Returns: The remaining time of the sleep duration transformed to msecs (see
+ * schedule_timeout() for details).
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
@@ -312,11 +347,17 @@ EXPORT_SYMBOL(msleep_interruptible);
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
 void __sched usleep_range_state(unsigned long min, unsigned long max, unsigned int state)
 {

-- 
2.39.5


