Return-Path: <linux-arch+bounces-12342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD89CAD8FD9
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 16:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137D73B3322
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A7A1AA1D8;
	Fri, 13 Jun 2025 14:42:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAC1A76AE;
	Fri, 13 Jun 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825774; cv=none; b=JMl4OyKtpL3iI6pslp17eYRVQ6H1U9ZzemFNTcmepBwfi07gfdyYFBVYWV6A3UesNQHNy75ZzTKHn8Hq4In5UFaK7MjykhHL82t1Jm35JRuutt0iABfc6eK4yx+CQBiqjBe52btbeHQP4f3Ql5hd9w0ARKkiHWu9vQbM2eojJas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825774; c=relaxed/simple;
	bh=zNSItPiMcI4v/nvELFQJ9buQognVR0LRfdwUYdA7JTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdBbhFmz9QmjJeO0n/YjD/isNILwyO4vL2bQP87Awvt0P1IyERre7P99zgBtaerjZs7qGaUNyaDmDUHqi62AqPx6BClFLbkRmH6r29QnWjOA6GCMiRxB1nWvIVzkxVr/19jC+9j0wzlO/Upas4lgzrNYtIr6PtyBa3XnQ9AKMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 4AD61BB03F;
	Fri, 13 Jun 2025 14:42:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 630861C;
	Fri, 13 Jun 2025 14:42:41 +0000 (UTC)
Date: Fri, 13 Jun 2025 10:42:40 -0400
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
Message-ID: <20250613104240.509ff13c@batman.local.home>
In-Reply-To: <20250613102834.539bd849@batman.local.home>
References: <20250612235827.011358765@goodmis.org>
	<20250613102834.539bd849@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/xB7r9y84J_G.DlS_P53lw5b"
X-Rspamd-Queue-Id: 630861C
X-Stat-Signature: omq3hajmpzo3ob4drj5o4h13adurdfe6
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19doMhSzneEzGuG6B8X7pg0zB3jxon5srI=
X-HE-Tag: 1749825761-133021
X-HE-Meta: U2FsdGVkX1+xSdW4RT4iCL3xaAa4KmDyXuBqJMj3ZV6NY1gosoLvuIj4UG51QLMtlTI/gwH4pOn0Nuq2rt+7m1GWGgmUFhz/dohTzI4b1RNUWYXq7Hl+ppWhmkCv4TKDdnhRAr6moOjtlgIG8UcL0BmNq/y5nAqE/ezK/2snNCIw/NsN1vilgo8HhxN0D0TME1eFsgXeKvtneZzDk2qWQNGTxbBP58CT4zTkgyhTrx9gB4IA4N9j6+quoko7j9oBAoto302Ys1yfRRsnr/X4A10L1Iz/3sv0dqWnTcYxx5I0z6zo92kjwA87H8p+dD0VM3/VGINtYoki6uEwCoLy78aP2ezGRfB0d+HSgBX7okQFTZE36isYl6t8aJlmHzX5EXnoVkHaOoY=

--MP_/xB7r9y84J_G.DlS_P53lw5b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 13 Jun 2025 10:28:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> And each DEFINE_EVENT() is approximately 1296 bytes.
>   ((19559 - 2069) - 5819) / 9

Interesting enough, just raw tracepoints are not much better. I updated
the header file (attached) to have 10 of these, and compiled that.

DECLARE_TRACE(size_event_1,
        TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
        TP_ARGS(A, B));

The result is:

   text    data     bss     dec     hex filename
    629    1440       0    2069     815 no-events.ko
  44837   15424       0   60261    eb65 trace-events.ko
  11495    8064       0   19559    4c67 define-events.ko
  10865    4408       0   15273    3ba9 declare-trace.ko

Where each DECLARE_TRACE() ends up being 1320 bytes.
  (15273 - 2069) / 10

This is slightly bigger than a DEFINE_EVENT(), but that's also because
the DEFINE_EVENT() shares some of the tracepoint creation in the
DECLARE_EVENT_CLASS(), where as that work is done fully in the
DECLARE_TRACE().

-- Steve

--MP_/xB7r9y84J_G.DlS_P53lw5b
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

#define DEFINE_EVENT_SIZES 0
#define DEFINE_FULL_EVENTS 0
#define DEFINE_JUST_TRACEPOINTS 1

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

#elif DEFINE_JUST_TRACEPOINTS

DECLARE_TRACE(size_event_1,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DECLARE_TRACE(size_event_2,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DECLARE_TRACE(size_event_3,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DECLARE_TRACE(size_event_4,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DECLARE_TRACE(size_event_5,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DECLARE_TRACE(size_event_6,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DECLARE_TRACE(size_event_7,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DECLARE_TRACE(size_event_8,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DECLARE_TRACE(size_event_9,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));

DECLARE_TRACE(size_event_10,
	TP_PROTO(struct size_event_struct *A, struct size_event_struct *B),
	TP_ARGS(A, B));
#endif /* DEFINE_EVENT_SIZES && DEFINE_JUST_TRACEPOINTS */

#endif

/***** NOTICE! The #if protection ends here. *****/


#undef TRACE_INCLUDE_PATH
#undef TRACE_INCLUDE_FILE
#define TRACE_INCLUDE_PATH .
#define TRACE_INCLUDE_FILE size_events 
#include <trace/define_trace.h>

--MP_/xB7r9y84J_G.DlS_P53lw5b--

