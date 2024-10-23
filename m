Return-Path: <linux-arch+bounces-8452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73939AC26D
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 10:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CFA1C20845
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC616A930;
	Wed, 23 Oct 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKoFw8up"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E1C161311;
	Wed, 23 Oct 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673911; cv=none; b=BsM/E4XU9gWHHz750IBRrrYyb4qlxT8U9lksG1wNKmexY840F2PYGIQpwqfuMktCIfVnkLyIfYCZZ7iT8Q9WP/RTaZ6LzJfvJKnrTTGypTq28r4DqmuBPP1vZ33YyP6F8T78nWaHV5E3sggdNnIb0MFBPgvHf6XOeZBO5VhmajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673911; c=relaxed/simple;
	bh=ZHUuyIo+LdaBGMKfmTuSwB2eVOTFinDEnOjlYscMntQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p4ZO1A14hfngvBUxQKyjC9W/fQjt8vPsu10kVik0wqBbdyFpdckh7wg68VmZfxEJah7yOEemQCCWC/uzH0oHv5zzf3tZC6uHxg8+Z+44slGHfhlkxPVqlcMYMCY7In6Sit0oNP56PxGyZ1IJ+tAaIwgP/uaxxGtS6HqBJXUQI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKoFw8up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0720C4CEC6;
	Wed, 23 Oct 2024 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729673910;
	bh=ZHUuyIo+LdaBGMKfmTuSwB2eVOTFinDEnOjlYscMntQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BKoFw8uppSxVl6lmayYfFZAfaUTJ93dWVIZfBt08fvZCCzGBrzt5PKI/j/azmRd/+
	 9Fa/2LB7/HjrVA6tkeGpUiwYuF7FZmLCQ2boZGa9gacSakzmiJG/EjNzIRTBVj7WJg
	 fZ+3YFgAaZn8zHrGVKtMBCT5WNQHn9uEQIJARj2KGcG5+AzdR2IysYoIQZy8BEh+HV
	 hOmmYL2EliM/CD5Kz01HJDlGLEvG6VwjQM5FvfB9vv8Go0/3OZJ6127vIHLn/1OTSN
	 0j1zaoWo7kW8zIqoC+bM118HxSep9RULHViYjP1KZMCwRC58GqxguAeTW4/G0mlAPL
	 SnmqtxHLH8JMw==
Date: Wed, 23 Oct 2024 17:58:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v17 07/16] tracing: Add ftrace_fill_perf_regs() for perf
 event
Message-Id: <20241023175825.45040316e4b4c146de4bcece@kernel.org>
In-Reply-To: <20241021170121.GA26122@willie-the-truck>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904035199.36809.9900108557809424653.stgit@devnote2>
	<20241021170121.GA26122@willie-the-truck>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 18:01:21 +0100
Will Deacon <will@kernel.org> wrote:

> On Wed, Oct 16, 2024 at 09:59:12AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add ftrace_fill_perf_regs() which should be compatible with the
> > perf_fetch_caller_regs(). In other words, the pt_regs returned from the
> > ftrace_fill_perf_regs() must satisfy 'user_mode(regs) == false' and can be
> > used for stack tracing.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: Naveen N Rao <naveen@kernel.org>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > 
> > ---
> >   Changes in v16:
> >    - Fix s390 to clear psw.mask according to Heiko's suggestion.
> > ---
> >  arch/arm64/include/asm/ftrace.h   |    7 +++++++
> >  arch/powerpc/include/asm/ftrace.h |    7 +++++++
> >  arch/s390/include/asm/ftrace.h    |    6 ++++++
> >  arch/x86/include/asm/ftrace.h     |    7 +++++++
> >  include/linux/ftrace.h            |   31 +++++++++++++++++++++++++++++++
> >  5 files changed, 58 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index d344c69eb01e..6493a575664f 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -146,6 +146,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> >  	return regs;
> >  }
> >  
> > +#define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
> > +		(_regs)->pc = arch_ftrace_regs(fregs)->pc;			\
> > +		(_regs)->regs[29] = arch_ftrace_regs(fregs)->fp;		\
> > +		(_regs)->sp = arch_ftrace_regs(fregs)->sp;			\
> > +		(_regs)->pstate = PSR_MODE_EL1h;		\
> > +	} while (0)
> 
> arm64 bit looks correct to me:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thank you!

> 
> Will


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

