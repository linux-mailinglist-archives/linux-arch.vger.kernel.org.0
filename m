Return-Path: <linux-arch+bounces-1063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C6813BF0
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 21:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519FF281016
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 20:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAD7494;
	Thu, 14 Dec 2023 20:46:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24712112;
	Thu, 14 Dec 2023 20:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EE9C433C7;
	Thu, 14 Dec 2023 20:46:28 +0000 (UTC)
Date: Thu, 14 Dec 2023 15:47:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linux Arch
 <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231214154715.223f245d@gandalf.local.home>
In-Reply-To: <CAHk-=wjHf48o15sugNeZkzNy2sJ2XUjaJLUWskTB0FnrnFGDeA@mail.gmail.com>
References: <20231214125433.03091e5e@gandalf.local.home>
	<CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
	<20231214151911.2df9f845@gandalf.local.home>
	<CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
	<CAHk-=wjHf48o15sugNeZkzNy2sJ2XUjaJLUWskTB0FnrnFGDeA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 12:32:38 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 14 Dec 2023 at 12:30, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Read my email. Don't do random x86-centric things. We have that
> >
> >   #ifndef system_has_cmpxchg64
> >       #define system_has_cmpxchg64() false
> >   #endif
> >
> > which should work.  
> 
> And again, by "should work" I mean that it would disable this entirely
> on things like arm32 until the arm people decide they care. But at
> least it won't use an unsafe non-working 64-bit cmpxchg.

If archs have no implementation of cmpxchg64 then the code cannot be
removed. If it's just slower and emulated, then it shouldn't be a big deal.
The only thing it may lose is tracing in NMI context, which I'm not sure
that really matters.

> 
> And no, for 6.7, only fix reported bugs. No big reorgs at all,
> particularly for something that likely has never been hit by any user
> and sounds like this all just came out of discussion.

The discussion came out of adding new tests to cover new changes I'm making
in the ring buffer code that happened to trigger subtle bugs in the 32-bit
version of reading the 64-bit timestamps. The reason for that code, is
because of the 64-bit cmpcxhg that is required to implement it. If we are
keeping this code, then there's 2 or 3 fixes to it that I need to send to
you, and also one outstanding one that in theory can be a bug, but in
practice is highly unlikely to ever be hit. The fix for that one is a bit
more involved, and will have to come later.

When I was discussing these fixes and other changes with Mathieu, we
started thinking "is this complexity worth it?" and "does anything actually
need this?".

That's where this patch originated from.

Now, I could also make this special code only compile for the
"!system_has_cmpxchg64" case as well, which shouldn't punish the Atom
processor to do 3 cmpxchg's instead of one cmpxchg8b.

-- Steve

