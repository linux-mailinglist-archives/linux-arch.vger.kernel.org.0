Return-Path: <linux-arch+bounces-1058-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53455813B69
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 21:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F1F1C20A83
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B006A34C;
	Thu, 14 Dec 2023 20:18:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F836A347;
	Thu, 14 Dec 2023 20:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B415C433C7;
	Thu, 14 Dec 2023 20:18:24 +0000 (UTC)
Date: Thu, 14 Dec 2023 15:19:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linux Arch
 <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231214151911.2df9f845@gandalf.local.home>
In-Reply-To: <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
References: <20231214125433.03091e5e@gandalf.local.home>
	<CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 11:46:55 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 14 Dec 2023 at 09:53, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > +       /*
> > +        * For architectures that can not do cmpxchg() in NMI, or require
> > +        * disabling interrupts to do 64-bit cmpxchg(), do not allow them
> > +        * to record in NMI context.
> > +        */
> > +       if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
> > +            (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64))) &&
> > +           unlikely(in_nmi())) {
> > +               return NULL;
> > +       }  
> 
> Again, this is COMPLETE GARBAGE.
> 
> You're using "ARCH_HAVE_NMI_SAFE_CMPXCHG" to test something that just
> isn't what it's about.

For the 64-bit cmpxchg, on it isn't useful, but this code also calls normal
cmpxchg too. I had that part of the if condition as a separate patch, but
not for this purpose, but for actual architectures that do not support
cmpxchg in NMI. Those are broken here too, and that check fixes it.

> 
> Having a NMI-safe cmpxchg does *not* mean that you actualyl have a
> NMI-safe 64-bit version.

Understood, but we also have cmpxchg in this path as well.

> 
> You can't test it that way.
> 
> Stop making random changes that just happen to work on the one machine
> you tested it on.

They are not random, but they are two different reasons. I still have the
standalone patch that adds the ARCH_HAVE_NMI_SAFE_CMPXCHG for the purpose
of not calling this code on architectures that do not support cmpxchg in
NMI, because if cmpxchg is not supported in NMI, then this should bail.

My mistake was to combine that change into this one which made it looks like
they are related, when in actuality they are not. Which is why there's a
"||" and not an "&&"

For this issue of the 64bit cmpxchg, is there any config that works for any
arch that do not have a safe 64-bit cmpxchg? At least for 486, is the
second half of the if condition reasonable?

	if (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64)) {
		if (unlikely(in_nmi()))
			return NULL;
	}

?

-- Steve

