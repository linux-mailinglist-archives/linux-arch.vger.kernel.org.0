Return-Path: <linux-arch+bounces-8195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E1B99FC80
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9772F1C2452F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 23:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4041D63E6;
	Tue, 15 Oct 2024 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2eDDGKB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7E21E3CA;
	Tue, 15 Oct 2024 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729035295; cv=none; b=mcoalbsv2IOpE3DyC1dBohQVtfmFIXPzg1RhUxLLDejISBd2j4TA4h/EMszEsDXp2Tb8CV5KQtPOo8+pcRRQZfGHUPr+f4zswpJsvxARseYrvRYKbsbFMl+A3hVjzZ3j4IuAJIoRRuxWn+x294QXO1H9j5lPHDUAYkILlpMbCyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729035295; c=relaxed/simple;
	bh=2xFRWYphLd7qkM9xPunfre15LOORnDtHIuyhWZLYh/I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oiI1mrCZaJQxfD83t0HZAFeGgxgRsYQwUwJ2bftoG84UyLUo9gz4bvjwqQQmGTwCv7LungdOMm87jBFqh9wfnUXkfHAnplLYuQuJI9ZOGiRsQHGyjI3w+eTIWZ6UCbIDKq8/SJafmpcMEM8TIqo3D/Le9eCz43eFvrEarVliDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2eDDGKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CE3C4CEC6;
	Tue, 15 Oct 2024 23:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729035294;
	bh=2xFRWYphLd7qkM9xPunfre15LOORnDtHIuyhWZLYh/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g2eDDGKBgH2aMp592Fk4gLPPE6eW8BplpTblR6SbMYJ3Bncus4qx0Ju4BMYgPzU1F
	 7+wtudNcacdSEkgx7qZxNlJupAIMu526nLvWdScLJ0E7X8Uh5XF2GybZpso2TSygGv
	 s/Rs3z+TJhLM0ksqNrSebOCLaM+97eys0jSu0YyOIoXvFh9Gyhu9qwG6KlOywxK3h9
	 aLH/spYKpo+slOlkRvNiah1nhmDZ9wvrvjhL3WQ+OvOlru+dvKoNZ2Kzj+k0OwgKdy
	 lL9MY+WGH0zUUqCW6agTwMsimFvCTcvzvTBfdsrulZ1mOMC9APzDNeCGMt/pqHxfgD
	 m7VKjDjz4G26g==
Date: Wed, 16 Oct 2024 08:34:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v16 09/18] tracing: Add ftrace_fill_perf_regs() for perf
 event
Message-Id: <20241016083445.df18db7ab09e75b903a94dbe@kernel.org>
In-Reply-To: <20241015181802.19678-A-hca@linux.ibm.com>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
	<172895581574.107311.17609909207681074574.stgit@devnote2>
	<20241015181802.19678-A-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 20:18:02 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Tue, Oct 15, 2024 at 10:30:15AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add ftrace_fill_perf_regs() which should be compatible with the
> > perf_fetch_caller_regs(). In other words, the pt_regs returned from the
> > ftrace_fill_perf_regs() must satisfy 'user_mode(regs) == false' and can be
> > used for stack tracing.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   Changes from previous series: NOTHING, just forward ported.
> > ---
> >  arch/s390/include/asm/ftrace.h    |    5 +++++
> 
> ...
> 
> > diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
> > index 5c94c1fc1bc1..f1c0e677a325 100644
> > --- a/arch/s390/include/asm/ftrace.h
> > +++ b/arch/s390/include/asm/ftrace.h
> > @@ -76,6 +76,11 @@ ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
> >  	return ftrace_regs_get_stack_pointer(fregs);
> >  }
> >  
> > +#define arch_ftrace_fill_perf_regs(fregs, _regs)	 do {		\
> > +		(_regs)->psw.addr = arch_ftrace_regs(fregs)->regs.psw.addr;		\
> > +		(_regs)->gprs[15] = arch_ftrace_regs(fregs)->regs.gprs[15];		\
> > +	} while (0)
> > +
> 
> This misses the feedback I gave for v15:
> https://lore.kernel.org/all/20241009100502.8007-E-hca@linux.ibm.com

Oops, sorry. And thanks for your feedback!



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

