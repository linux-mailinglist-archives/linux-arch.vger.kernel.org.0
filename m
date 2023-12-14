Return-Path: <linux-arch+bounces-1046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B9F81391F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 18:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287461C209CD
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 17:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95891675DA;
	Thu, 14 Dec 2023 17:53:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7F60B8F;
	Thu, 14 Dec 2023 17:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2886CC433C8;
	Thu, 14 Dec 2023 17:53:47 +0000 (UTC)
Date: Thu, 14 Dec 2023 12:54:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Linux Arch
 <linux-arch@vger.kernel.org>
Subject: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231214125433.03091e5e@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Each event has a 27 bit timestamp delta that is used to hold the delta
from the last event. If the time between events is greater than 2^27, then
a timestamp is added that holds a 59 bit absolute timestamp.

Until a389d86f7fd09 ("ring-buffer: Have nested events still record running
time stamp"), if an interrupt interrupted an event in progress, all the
events delta would be zero to not deal with the races that need to be
handled. The commit a389d86f7fd09 changed that to handle the races giving
all events, even those that preempt other events, still have an accurate
timestamp.

To handle those races requires performing 64-bit cmpxchg on the
timestamps. But doing 64-bit cmpxchg on 32-bit architectures is considered
very slow. To try to deal with this the timestamp logic was broken into
two and then three 32-bit cmpxchgs, with the thought that two (or three)
32-bit cmpxchgs are still faster than a single 64-bit cmpxchg on 32-bit
architectures.

Part of the problem with this is that I didn't have any 32-bit
architectures to test on. After hitting several subtle bugs in this code,
an effort was made to try and see if three 32-bit cmpxchgs are indeed
faster than a single 64-bit. After a few people brushed off the dust of
their old 32-bit machines, tests were done, and even though 32-bit cmpxchg
was faster than a single 64-bit, it was in the order of 50% at best, not
300%.

This means that this complex code is not only complex but also not even
faster than just using 64-bit cmpxchg.

Nuke it!

This is basically a revert of 10464b4aa605e ("ring-buffer: Add rb_time_t
64 bit operations for speeding up 32 bit").

Cc: stable@vger.kernel.org
Fixes: 10464b4aa605e ("ring-buffer: Add rb_time_t 64 bit operations for speeding up 32 bit")
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231213232957.498cd339@gandalf.local.home

-- Added check for architectures that can not handle cmpxchg in NMI or
   x86 architectures that do not support true 64bit cmpxchg, and for
   them, to bail out of tracing if in NMI context.

 kernel/trace/ring_buffer.c | 232 ++++---------------------------------
 1 file changed, 22 insertions(+), 210 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1d9caee7f542..9fdbd08af72f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -27,6 +27,7 @@
 #include <linux/cpu.h>
 #include <linux/oom.h>
 
+#include <asm/local64.h>
 #include <asm/local.h>
 
 /*
@@ -463,27 +464,9 @@ enum {
 	RB_CTX_MAX
 };
 
-#if BITS_PER_LONG == 32
-#define RB_TIME_32
-#endif
-
-/* To test on 64 bit machines */
-//#define RB_TIME_32
-
-#ifdef RB_TIME_32
-
-struct rb_time_struct {
-	local_t		cnt;
-	local_t		top;
-	local_t		bottom;
-	local_t		msb;
-};
-#else
-#include <asm/local64.h>
 struct rb_time_struct {
 	local64_t	time;
 };
-#endif
 typedef struct rb_time_struct rb_time_t;
 
 #define MAX_NEST	5
@@ -573,179 +556,9 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
-#ifdef RB_TIME_32
-
-/*
- * On 32 bit machines, local64_t is very expensive. As the ring
- * buffer doesn't need all the features of a true 64 bit atomic,
- * on 32 bit, it uses these functions (64 still uses local64_t).
- *
- * For the ring buffer, 64 bit required operations for the time is
- * the following:
- *
- *  - Reads may fail if it interrupted a modification of the time stamp.
- *      It will succeed if it did not interrupt another write even if
- *      the read itself is interrupted by a write.
- *      It returns whether it was successful or not.
- *
- *  - Writes always succeed and will overwrite other writes and writes
- *      that were done by events interrupting the current write.
- *
- *  - A write followed by a read of the same time stamp will always succeed,
- *      but may not contain the same value.
- *
- *  - A cmpxchg will fail if it interrupted another write or cmpxchg.
- *      Other than that, it acts like a normal cmpxchg.
- *
- * The 60 bit time stamp is broken up by 30 bits in a top and bottom half
- *  (bottom being the least significant 30 bits of the 60 bit time stamp).
- *
- * The two most significant bits of each half holds a 2 bit counter (0-3).
- * Each update will increment this counter by one.
- * When reading the top and bottom, if the two counter bits match then the
- *  top and bottom together make a valid 60 bit number.
- */
-#define RB_TIME_SHIFT	30
-#define RB_TIME_VAL_MASK ((1 << RB_TIME_SHIFT) - 1)
-#define RB_TIME_MSB_SHIFT	 60
-
-static inline int rb_time_cnt(unsigned long val)
-{
-	return (val >> RB_TIME_SHIFT) & 3;
-}
-
-static inline u64 rb_time_val(unsigned long top, unsigned long bottom)
-{
-	u64 val;
-
-	val = top & RB_TIME_VAL_MASK;
-	val <<= RB_TIME_SHIFT;
-	val |= bottom & RB_TIME_VAL_MASK;
-
-	return val;
-}
-
-static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
-{
-	unsigned long top, bottom, msb;
-	unsigned long c;
-
-	/*
-	 * If the read is interrupted by a write, then the cnt will
-	 * be different. Loop until both top and bottom have been read
-	 * without interruption.
-	 */
-	do {
-		c = local_read(&t->cnt);
-		top = local_read(&t->top);
-		bottom = local_read(&t->bottom);
-		msb = local_read(&t->msb);
-	} while (c != local_read(&t->cnt));
-
-	*cnt = rb_time_cnt(top);
-
-	/* If top and msb counts don't match, this interrupted a write */
-	if (*cnt != rb_time_cnt(msb))
-		return false;
-
-	/* The shift to msb will lose its cnt bits */
-	*ret = rb_time_val(top, bottom) | ((u64)msb << RB_TIME_MSB_SHIFT);
-	return true;
-}
-
-static bool rb_time_read(rb_time_t *t, u64 *ret)
-{
-	unsigned long cnt;
-
-	return __rb_time_read(t, ret, &cnt);
-}
-
-static inline unsigned long rb_time_val_cnt(unsigned long val, unsigned long cnt)
-{
-	return (val & RB_TIME_VAL_MASK) | ((cnt & 3) << RB_TIME_SHIFT);
-}
-
-static inline void rb_time_split(u64 val, unsigned long *top, unsigned long *bottom,
-				 unsigned long *msb)
-{
-	*top = (unsigned long)((val >> RB_TIME_SHIFT) & RB_TIME_VAL_MASK);
-	*bottom = (unsigned long)(val & RB_TIME_VAL_MASK);
-	*msb = (unsigned long)(val >> RB_TIME_MSB_SHIFT);
-}
-
-static inline void rb_time_val_set(local_t *t, unsigned long val, unsigned long cnt)
-{
-	val = rb_time_val_cnt(val, cnt);
-	local_set(t, val);
-}
-
-static void rb_time_set(rb_time_t *t, u64 val)
-{
-	unsigned long cnt, top, bottom, msb;
-
-	rb_time_split(val, &top, &bottom, &msb);
-
-	/* Writes always succeed with a valid number even if it gets interrupted. */
-	do {
-		cnt = local_inc_return(&t->cnt);
-		rb_time_val_set(&t->top, top, cnt);
-		rb_time_val_set(&t->bottom, bottom, cnt);
-		rb_time_val_set(&t->msb, val >> RB_TIME_MSB_SHIFT, cnt);
-	} while (cnt != local_read(&t->cnt));
-}
-
-static inline bool
-rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
-{
-	return local_try_cmpxchg(l, &expect, set);
-}
-
-static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
-{
-	unsigned long cnt, top, bottom, msb;
-	unsigned long cnt2, top2, bottom2, msb2;
-	u64 val;
-
-	/* The cmpxchg always fails if it interrupted an update */
-	 if (!__rb_time_read(t, &val, &cnt2))
-		 return false;
-
-	 if (val != expect)
-		 return false;
-
-	 cnt = local_read(&t->cnt);
-	 if ((cnt & 3) != cnt2)
-		 return false;
-
-	 cnt2 = cnt + 1;
-
-	 rb_time_split(val, &top, &bottom, &msb);
-	 top = rb_time_val_cnt(top, cnt);
-	 bottom = rb_time_val_cnt(bottom, cnt);
-
-	 rb_time_split(set, &top2, &bottom2, &msb2);
-	 top2 = rb_time_val_cnt(top2, cnt2);
-	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
-
-	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->top, top, top2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
-		return false;
-	return true;
-}
-
-#else /* 64 bits */
-
-/* local64_t always succeeds */
-
-static inline bool rb_time_read(rb_time_t *t, u64 *ret)
+static inline void rb_time_read(rb_time_t *t, u64 *ret)
 {
 	*ret = local64_read(&t->time);
-	return true;
 }
 static void rb_time_set(rb_time_t *t, u64 val)
 {
@@ -756,7 +569,6 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
 	return local64_try_cmpxchg(&t->time, &expect, set);
 }
-#endif
 
 /*
  * Enable this to make sure that the event passed to
@@ -863,10 +675,7 @@ u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
 	WARN_ONCE(1, "nest (%d) greater than max", nest);
 
  fail:
-	/* Can only fail on 32 bit */
-	if (!rb_time_read(&cpu_buffer->write_stamp, &ts))
-		/* Screw it, just read the current time */
-		ts = rb_time_stamp(cpu_buffer->buffer);
+	rb_time_read(&cpu_buffer->write_stamp, &ts);
 
 	return ts;
 }
@@ -2863,7 +2672,7 @@ rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  (unsigned long long)info->ts,
 		  (unsigned long long)info->before,
 		  (unsigned long long)info->after,
-		  (unsigned long long)(rb_time_read(&cpu_buffer->write_stamp, &write_stamp) ? write_stamp : 0),
+		  (unsigned long long)({rb_time_read(&cpu_buffer->write_stamp, &write_stamp); write_stamp;}),
 		  sched_clock_stable() ? "" :
 		  "If you just came from a suspend/resume,\n"
 		  "please switch to the trace global clock:\n"
@@ -3021,8 +2830,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 
 	delta = rb_time_delta(event);
 
-	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
-		return false;
+	rb_time_read(&cpu_buffer->write_stamp, &write_stamp);
 
 	/* Make sure the write stamp is read before testing the location */
 	barrier();
@@ -3560,16 +3368,14 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	struct ring_buffer_event *event;
 	struct buffer_page *tail_page;
 	unsigned long tail, write, w;
-	bool a_ok;
-	bool b_ok;
 
 	/* Don't let the compiler play games with cpu_buffer->tail_page */
 	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
 
  /*A*/	w = local_read(&tail_page->write) & RB_WRITE_MASK;
 	barrier();
-	b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
-	a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
+	rb_time_read(&cpu_buffer->before_stamp, &info->before);
+	rb_time_read(&cpu_buffer->write_stamp, &info->after);
 	barrier();
 	info->ts = rb_time_stamp(cpu_buffer->buffer);
 
@@ -3584,7 +3390,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		if (!w) {
 			/* Use the sub-buffer timestamp */
 			info->delta = 0;
-		} else if (unlikely(!a_ok || !b_ok || info->before != info->after)) {
+		} else if (unlikely(info->before != info->after)) {
 			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
 			info->length += RB_LEN_TIME_EXTEND;
 		} else {
@@ -3613,13 +3419,11 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
 	if (likely(tail == w)) {
 		u64 save_before;
-		bool s_ok;
 
 		/* Nothing interrupted us between A and C */
  /*D*/		rb_time_set(&cpu_buffer->write_stamp, info->ts);
 		barrier();
- /*E*/		s_ok = rb_time_read(&cpu_buffer->before_stamp, &save_before);
-		RB_WARN_ON(cpu_buffer, !s_ok);
+ /*E*/		rb_time_read(&cpu_buffer->before_stamp, &save_before);
 		if (likely(!(info->add_timestamp &
 			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 			/* This did not interrupt any time update */
@@ -3632,8 +3436,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		if (unlikely(info->ts != save_before)) {
 			/* SLOW PATH - Interrupted between C and E */
 
-			a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-			RB_WARN_ON(cpu_buffer, !a_ok);
+			rb_time_read(&cpu_buffer->write_stamp, &info->after);
 
 			/* Write stamp must only go forward */
 			if (save_before > info->after) {
@@ -3648,9 +3451,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		/* Was interrupted before here, write_stamp must be valid */
-		RB_WARN_ON(cpu_buffer, !a_ok);
+		rb_time_read(&cpu_buffer->write_stamp, &info->after);
 		ts = rb_time_stamp(cpu_buffer->buffer);
 		barrier();
  /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
@@ -3712,6 +3513,17 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	int nr_loops = 0;
 	int add_ts_default;
 
+	/*
+	 * For architectures that can not do cmpxchg() in NMI, or require
+	 * disabling interrupts to do 64-bit cmpxchg(), do not allow them
+	 * to record in NMI context.
+	 */
+	if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
+	     (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64))) &&
+	    unlikely(in_nmi())) {
+		return NULL;
+	}
+
 	rb_start_commit(cpu_buffer);
 	/* The commit page can not change after this */
 
-- 
2.42.0


