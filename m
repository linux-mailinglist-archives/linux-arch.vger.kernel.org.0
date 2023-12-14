Return-Path: <linux-arch+bounces-1065-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AA2813C3A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 22:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF20EB21C08
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89F2DF66;
	Thu, 14 Dec 2023 21:01:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C0282E9;
	Thu, 14 Dec 2023 21:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFC8C433C8;
	Thu, 14 Dec 2023 21:01:09 +0000 (UTC)
Date: Thu, 14 Dec 2023 16:01:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231214160156.73e5ec51@gandalf.local.home>
In-Reply-To: <CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
References: <20231213211126.24f8c1dd@gandalf.local.home>
	<20231213214632.15047c40@gandalf.local.home>
	<CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
	<20231214115614.2cf5a40e@gandalf.local.home>
	<CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
	<20231214153636.655e18ce@gandalf.local.home>
	<CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 12:50:29 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > But do all archs have an implementation of cmpxchg64, even if it requires
> > disabling interrupts? If not, then I definitely cannot remove this code.  
> 
> We have a generic header file, so anybody who uses that would get the
> fallback version, ie
> 
> arch_cmpxchg64 -> generic_cmpxchg64_local -> __generic_cmpxchg64_local
> 
> which does that irq disabling thing.
> 
> But no, not everybody is guaranteed to use that fallback. From a quick
> look, ARC, hexagon and CSky don't do this, for example.
> 
> And then I got bored and stopped looking.
> 
> My guess is that *most* 32-bit architectures do not have a 64-bit
> cmpxchg - not even the irq-safe one.

OK, that means I have to completely abandon this change, even for the next
merge window.

I may add a check if cmpxchg64 exists before falling back to the 32bit
cmpxchg version. But even that will have to wait till the next merge 
window, with a fixes tag (but not Cc'd stable) in case anyone would like to
backport it.

Thanks for the advice!

-- Steve

