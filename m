Return-Path: <linux-arch+bounces-7847-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8040299577E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 21:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344121F263D8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC21E0E1F;
	Tue,  8 Oct 2024 19:15:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D813541B;
	Tue,  8 Oct 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414950; cv=none; b=LtG/Wjp4Uc1vVS5t5XPYiAbD8r8sMVAOzbnySfraZ1nkiGIj53tAkLo0AtRQr9ff2IW1aQeA5bpR7V+sQGkuxiYjmLNjKkAaZS4fivLL2ErfdSd9Qrh+nOWximJobScay14aGyieNDpA7wVTWSA7bXWV9RgGcqIGrbe+gn+nTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414950; c=relaxed/simple;
	bh=O8MjuzFLVlk/VicWstQS6pFfK2YteU+f/iH5wcaRa7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+3aJHLOO1wBuYuKh8jxdXXSWsN2BLapM2k/CP28Tz2wjINpri7H1kZtOFKQnqwX6M/qufRcpl5WSRndgX9vfiv6lA7aTcgXOy3tUbwRnEahSNYh4cEl46GAtnks2R+On5d3XU99gZhOpOjh0V93gE9vXUvndqM6YqjcTV9wYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F50EC4CEC7;
	Tue,  8 Oct 2024 19:15:45 +0000 (UTC)
Date: Tue, 8 Oct 2024 15:15:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] ftrace: Make ftrace_regs abstract from direct use
Message-ID: <20241008151548.6a721c20@gandalf.local.home>
In-Reply-To: <8e99826f-b38a-4cb3-ba5e-a20512248853@csgroup.eu>
References: <20241007204743.41314f1d@gandalf.local.home>
	<20241007205458.2bbdf736@gandalf.local.home>
	<8e99826f-b38a-4cb3-ba5e-a20512248853@csgroup.eu>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 08:24:22 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> >> +
> >> +struct ftrace_regs;
> >> +#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
> >> +  
> > 
> > I just realized I can simplify it with:
> > 
> > #define arch_ftrace_get_regs(fregs)	({ &arch_ftrace_regs(fregs)->regs; })  
> 
> Is it possible to write it as a static inline function to enforce type 
> checking ?

Will do. Thanks,

-- Steve

