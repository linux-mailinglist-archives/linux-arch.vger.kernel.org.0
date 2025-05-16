Return-Path: <linux-arch+bounces-11978-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A50ABA036
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7181A7ACED5
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1101C5485;
	Fri, 16 May 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+14PxNf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256745661;
	Fri, 16 May 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410347; cv=none; b=tQsVPgYfnc86BkgQtjECrMwoPwIyreoEzcRDeEykNP3f60gcHHQGcl0KDxPtMgqQS7MRSwrpi5RgJ8DzqBXILOQ9qcFCxbAeq67VauCjvQapuLPVgWptL7OPYtpEW7czEq8xOcQJuUk+AOLE+M1QWQjqxSw6V7xSHhTrvwqyksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410347; c=relaxed/simple;
	bh=IfcZCOVl2cZHsDX4T04yuRwLb2cGUd5JrIqFBLn0nwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsbluSoDPt+VdvGJ78EKdfy9nZksikKFNZxVoC39rEl0VCyeBPV1c7Zvs/wZFNZZr8ZY97IXczu0NRucgozqS1IBLMmst1/eUTtOWS0eHup7qE2x9MNYV96ehNf3n7n+nv1zq7C7q3UGHYY5Yk2i4kS78niOFMtWyiAoVMch5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+14PxNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86432C4CEF0;
	Fri, 16 May 2025 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747410346;
	bh=IfcZCOVl2cZHsDX4T04yuRwLb2cGUd5JrIqFBLn0nwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+14PxNfE0L1mwRb2/UUcId9ZR9psC9eFsVgvYi3wqboKHWHm9DQ7O0uPVdTemFma
	 /RFaAVG4Cb/Ys2T7+QDDuHz65FNA8W/H9koCm34x6dEIyz+IJ3HBH4E4gt9oeQ6Kbd
	 losyxjBUQ1ccb5RF2loDJByFk/5dmaBpAF3gI8o3RxZ/5rr5aqmqcqp44Sffl32PTC
	 hO+wi/xP6d0K7SVya2aschjBqyBEyYPTuWFXRLJLuJ81rdtyeXSnQr/3GgfqhNsDJN
	 FjtuKW1Z+/N7lon0efBeqqKbmElL6HJYQ1VhhDXPxi2otlLAhFXRS7qWuMWvucgHmr
	 KdOK1kFglX+Zw==
Date: Fri, 16 May 2025 17:45:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 12/15] bugs/riscv: Concatenate 'cond_str' with '__FILE__'
 in __BUG_FLAGS(), to extend WARN_ON/BUG_ON output
Message-ID: <aCddpaKTVTTucMX9@gmail.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-13-mingo@kernel.org>
 <6886cf50-1a05-4ebd-bf8c-1afa652e8c89@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6886cf50-1a05-4ebd-bf8c-1afa652e8c89@ghiti.fr>


* Alexandre Ghiti <alex@ghiti.fr> wrote:

> Hi Ingo,
> 
> On 15/05/2025 14:46, Ingo Molnar wrote:
> > Extend WARN_ON and BUG_ON style output from:
> > 
> >    WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410
> > 
> > to:
> > 
> >    WARNING: CPU: 0 PID: 0 at [idx < 0 && ptr] kernel/sched/core.c:8511 sched_init+0x20/0x410
> > 
> > Note that the output will be further reorganized later in this series.
> > 
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Alexandre Ghiti <alex@ghiti.fr>
> > Cc: linux-riscv@lists.infradead.org
> > Cc: <linux-arch@vger.kernel.org>
> > ---
> >   arch/riscv/include/asm/bug.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> > index feaf456d465b..da9b8e83934d 100644
> > --- a/arch/riscv/include/asm/bug.h
> > +++ b/arch/riscv/include/asm/bug.h
> > @@ -61,7 +61,7 @@ do {								\
> >   			".org 2b + %3\n\t"                      \
> >   			".popsection"				\
> >   		:						\
> > -		: "i" (__FILE__), "i" (__LINE__),		\
> > +		: "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
> >   		  "i" (flags),					\
> >   		  "i" (sizeof(struct bug_entry)));              \
> >   } while (0)
> 
> I have added a dummy WARN_ON_ONCE(pgtable_l5_enabled == true) and I get the
> following output:
> 
> WARNING: [pgtable_l5_enabled == true] arch/riscv/kernel/setup.c:364 at
> setup_arch+0x6c4/0x704, CPU#0: swapper/0
> 
> So you can add for riscv:
> 
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks, I've updated the tags section of the riscv patches.

BTW., if you tried the WIP.core/bugs tree it has a final (and silly) 
WARN_ON_ONCE()-testing commit as well:

   af0503e693cf ("bugs/core: Test WARN_ON_ONCE()")

   +       WARN_ON_ONCE(ptr == 0 && 1);

:-)

Thanks,

	Ingo

