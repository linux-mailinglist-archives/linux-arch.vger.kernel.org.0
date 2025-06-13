Return-Path: <linux-arch+bounces-12341-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA53AD8F88
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 16:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D917A33B4
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 14:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8C15689A;
	Fri, 13 Jun 2025 14:28:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136C1519B4;
	Fri, 13 Jun 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749824924; cv=none; b=mjbWr7iKNp7CBhi/8guK81vk6g4U6Qs74YXQJii6QNucTj0ktT/3pNfYh5N77ABZJwSRfD0AFtBO2jWFhpyMwKEv64meOrIJ+luTRp1LVKj1n6psAH5pAsYoyj86ngOd/7N62RxkrPVJYr6xaDoq5WW6UnH7w9HAfJ+X5RkAS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749824924; c=relaxed/simple;
	bh=k9oFOLhS+q9ZyAuz50xoIcrjxofh89Ip2jCaH0VAkRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtyKW/ZQl/kepqdkgYq6cgCY16muAGhmV/BT5xXw5oPrsw90BWsDt2xHQ8vtkGC93ubDfaICubIgwkWAvDVaOQiEUB6mCmU2fqDhbWaJHHKxlC1Fc+9LOSR4mMNKtXh1s0JX5piZ+6E+Ug1M4MgdkLJBNJJidotjOhdHGFnbwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 3588B120654;
	Fri, 13 Jun 2025 14:28:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 1EA046000D;
	Fri, 13 Jun 2025 14:28:36 +0000 (UTC)
Date: Fri, 13 Jun 2025 10:28:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas.schier@linux.dev>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/5] tracepoints: Add warnings for unused tracepoints
 and trace events
Message-ID: <20250613102834.539bd849@batman.local.home>
In-Reply-To: <20250612235827.011358765@goodmis.org>
References: <20250612235827.011358765@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/n=4aWwYXO.j1EfJakr4BvWZ"
X-Stat-Signature: jo59oiuxhrioyimb7538r9agfu7go8i9
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 1EA046000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18eCKmAw3ZBnHWPjOUQ4DEXbj8Mu+HkeVQ=
X-HE-Tag: 1749824916-657807
X-HE-Meta: U2FsdGVkX19S4cdj/hB+4a4YRknRu9pSjij2+OTAPDPCnsbtvK7kd82ohBUoUGjT3quQiAo3pIfsTMLAkEiH0+Iw/bhl2TaAEqh4oVjnB8Poqp3fFGpiLJSvy6cXEEgdNvQ5nLVQDnY/o+cI0+XKPiSK2SuNY+GUqlc2nAZL6ORM8gezlcawwS8cPQnCxEcZg2x8zu8rx0kU9WLN+4HvkYf+nRtMaINkFtCkAfwGy7/1Imh4AkdN98C9LmD2CCA5Sys6U4wRZU12ibuZzKyZMDpeY7Tye1AveLlKB1Re7W7vvcQo6faze8nOcCpTXvvu4f17B0jmi/A1G8h/Rf/ym006CLFe81Dk0u43zflxGxvKLycDWM3P0Mnq7aJAYTHPACRUBaVNYXw=

--MP_/n=4aWwYXO.j1EfJakr4BvWZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 12 Jun 2025 19:58:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Every trace event can take up to 5K of memory in text and meta data regardless
> if they are used or not. Trace events should not be created if they are not
> used.  Currently there's over a hundred events in the kernel that are defined
> but unused, either because their callers were removed without removing the
> trace event with it, or a config hides the trace event caller but not the
> trace event itself. And in some cases, trace events were simply added but were
> never called for whatever reason. The number of unused trace events continues
> to grow.

Now it's been a while since I looked at the actual sizes, so I decided
to see what they are again.

So I created a trace header with 10 events (attached file), that had this:

TRACE_EVENT(size_event_1,
        TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
        TP_ARGS(A, B),
        TP_STRUCT__entry(
                __field(        unsigned long,  Aa)
                __field(        unsigned long,  Ab)
                __field(        unsigned long,  Ba)
                __field(        unsigned long,  Bb)
        ),
        TP_fast_assign(
                __entry->Aa = A->a;
                __entry->Ab = A->b;
                __entry->Ba = B->a;
                __entry->Bb = B->b;
        ),
        TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
                __entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);

And I created 9 more by just renaming the event name (size_event_2, etc).

I also looked at how well DEFINE_EVENT() works (note a TRACE_EVENT()
macro is just a DECLARE_EVENT_CLASS() followed by a DEFINE_EVENT() with
the same name as the class, so I could use the first TRACE_EVENT as a
class and the first event).

DEFINE_EVENT(size_event_1, size_event_2,
        TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
        TP_ARGS(A, B));

The module is simply:

echo '#include <linux/module.h>

#define CREATE_TRACE_POINTS
#include "size_events.h"

static __init int size_init(void)
{
        return 0;
}

static __exit void size_exit(void)
{
}

module_init(size_init);
module_exit(size_exit);

MODULE_AUTHOR("Steven Rostedt");
MODULE_DESCRIPTION("Test the size of trace event");
MODULE_LICENSE("GPL");' > event-mod.c

The results are (renaming the module to what they did):

   text    data     bss     dec     hex filename
    629    1440       0    2069     815 no-events.ko
  44837   15424       0   60261    eb65 trace-events.ko
  11495    8064       0   19559    4c67 define-events.ko

With no events, the size is 2069.
With full trace events it jumped to 60261
With One DECLARE_EVENT_CLASS() and 9 DEFINE_EVENT(), it changed to 19559

That means each TRACE_EVENT() is approximately 5819 bytes.
  (60261 - 2069) / 10

And each DEFINE_EVENT() is approximately 1296 bytes.
  ((19559 - 2069) - 5819) / 9

Now I do have a bit of debugging options enabled which could cause this
to bloat even more. But yeah, trace events do take up a bit of memory.

-- Steve

--MP_/n=4aWwYXO.j1EfJakr4BvWZ
Content-Type: text/x-chdr
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=size_events.h


/* SPDX-License-Identifier: GPL-2.0 */
#undef TRACE_SYSTEM
#define TRACE_SYSTEM event-sizes 

#undef TRACE_SYSTEM_VAR
#define TRACE_SYSTEM_VAR event_sizes

#if !defined(_SIZE_EVENT_H) || defined(TRACE_HEADER_MULTI_READ)
#define _SIZE_EVENT_H

#include <linux/tracepoint.h>

#ifndef SIZE_EVENT_DEFINED
#define SIZE_EVENT_DEFINED
struct size_event_struct {
	unsigned long a;
	unsigned long b;
};
#endif

#define DEFINE_EVENT_SIZES 1
#define DEFINE_FULL_EVENTS 0

#if DEFINE_EVENT_SIZES

TRACE_EVENT(size_event_1,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);

#if DEFINE_FULL_EVENTS
TRACE_EVENT(size_event_2,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);
TRACE_EVENT(size_event_3,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);
TRACE_EVENT(size_event_4,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);
TRACE_EVENT(size_event_5,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);
TRACE_EVENT(size_event_6,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);
TRACE_EVENT(size_event_7,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);
TRACE_EVENT(size_event_8,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);
TRACE_EVENT(size_event_9,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);
TRACE_EVENT(size_event_10,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B),
	TP_STRUCT__entry(
		__field(	unsigned long,	Aa)
		__field(	unsigned long,	Ab)
		__field(	unsigned long,	Ba)
		__field(	unsigned long,	Bb)
	),
	TP_fast_assign(
		__entry->Aa = A->a;
		__entry->Ab = A->b;
		__entry->Ba = B->a;
		__entry->Bb = B->b;
	),
	TP_printk("Aa=%ld Ab=%ld Ba=%ld Bb=%ld",
		__entry->Aa, __entry->Ab, __entry->Ba, __entry->Bb)
);
#else /* !DEFINE_FULL_EVENTS */
DEFINE_EVENT(size_event_1, size_event_2,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DEFINE_EVENT(size_event_1, size_event_3,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DEFINE_EVENT(size_event_1, size_event_4,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DEFINE_EVENT(size_event_1, size_event_5,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DEFINE_EVENT(size_event_1, size_event_6,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DEFINE_EVENT(size_event_1, size_event_7,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DEFINE_EVENT(size_event_1, size_event_8,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DEFINE_EVENT(size_event_1, size_event_9,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DEFINE_EVENT(size_event_1, size_event_10,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

#endif /* !DEFINE_FULL_EVENTS */
#endif /* DEFINE_EVENT_SIZES */

#endif

/***** NOTICE! The #if protection ends here. *****/


#undef TRACE_INCLUDE_PATH
#undef TRACE_INCLUDE_FILE
#define TRACE_INCLUDE_PATH .
#define TRACE_INCLUDE_FILE size_events 
#include <trace/define_trace.h>

--MP_/n=4aWwYXO.j1EfJakr4BvWZ--

