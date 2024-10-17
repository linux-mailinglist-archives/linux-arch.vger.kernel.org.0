Return-Path: <linux-arch+bounces-8259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296E39A2F4B
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 23:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC78284D05
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774F1EE030;
	Thu, 17 Oct 2024 21:10:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891C1EE01A;
	Thu, 17 Oct 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199408; cv=none; b=BO2vilDR670LWZPPhIuZpV4h9UY+HJBShuNGTL7OvPFPQjnlFBG36COFCtqdZ4eRSYthQwUcnWrOXcr+iv84zx9yPxMzcmuvj4L7/FSPnWgv92U1gBjoR1zVKIyohsxBW/dU51YEkBO9EMvVCH+4vfMsoDYgyR6hm2syPJ/QVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199408; c=relaxed/simple;
	bh=MMEe+Lru/5RFVuvhSECpvYf3L0qpiyR6db5+8d1u5dI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iReR8O6BHH8dnDanLm5aCYmP5g5O9n4nrqsGafBZTGviG5B9xN0f+xw1jKpm7ODi0czFb916y6s6zfEqKSO99jzybHLmHH/GI/Yx5jMcE4G17XyKr19cuIMaAhCjvEX9wi1RxmcdDRHuspgTtzAqq3MCr5mb6tZIUWwtv7aYpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F80AC4CEC3;
	Thu, 17 Oct 2024 21:10:03 +0000 (UTC)
Date: Thu, 17 Oct 2024 17:10:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen
 N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v17 11/16] fprobe: Rewrite fprobe on function-graph
 tracer
Message-ID: <20241017171026.6a617f57@gandalf.local.home>
In-Reply-To: <yt9da5f3gblm.fsf@linux.ibm.com>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904040206.36809.2263909331707439743.stgit@devnote2>
	<yt9ded4gfdz0.fsf@linux.ibm.com>
	<20241016101022.185f741b@gandalf.local.home>
	<yt9da5f3gblm.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 20:13:25 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> > From what you said in v15:
> >  
> >> I haven't yet fully understood why this logic is needed, but the
> >> WARN_ON_ONCE triggers on s390. I'm assuming this fails because fp always
> >> has the upper bits of the address set on x86 (and likely others). As an
> >> example, in my test setup, fp is 0x8feec218 on s390, while it is
> >> 0xffff888100add118 in x86-kvm.  
> >
> > Since we only need to save 4 bits for size, we could have what it is
> > replacing always be zero or always be f, depending on the arch. The
> > question then is, is s390's 4 MSBs always zero?  
> 
> s390 has separate address spaces for kernel and userspace - so kernel
> addresses could be anywhere. I don't know think the range should be
> limited artifically because of some optimizations.

Note, this is information saved in the shadow stack. When the first
callback is attached to the fgraph tracer, all tasks will get a shadow
stack. It currently defaults to PAGE_SIZE. When a function is entered and
one of the callbacks wants to trace that function, information is saved on
the shadow stack, including the original return address as the old return
address is replaced to a call to a trampoline to jump to the return side
callback on function exit.

We allow up to 16 callbacks to be attached to the tracer. Each that wants
to trace the return side will have some information saved on this shadow
stack. Note all information in the shadow stack is saved by natural word
size (8 bytes on 64 bit machines, leaving 512 storage slots on 4096 size
shadow stack).

Each entry callback can also reserve information on this shadow stack (in
word aligned segments) that can be retrieved by the function exit callback.

This information we are storing is saved on this shadow stack. The
optimization being done here is to not waste a full 8 bytes (1 slot on the
shadow stack) for just 4 bits.

If we need to save the full fp, then there's no choice but to use a full
slot to also save the 4 bits. If other architectures can do tricks to
combine the size and fp, they should, to save the slots.

I also plan on changing the size of the shadow stack. We could even do that
per architecture. Thus, if we need to use two slots on the shadow stack to
save the fp and size, then we could make the shadow stack bigger for those
architectures that need that.

-- Steve

