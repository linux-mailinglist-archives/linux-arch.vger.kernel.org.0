Return-Path: <linux-arch+bounces-9045-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71819C6580
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 00:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020D7B2D2AB
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 23:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C9821C165;
	Tue, 12 Nov 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URFA3fSM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7921B42A;
	Tue, 12 Nov 2024 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455015; cv=none; b=j8dbDqVdufa5P3CjkKl6Ga9m9Qj+IkALooOO/XJXEvH11PnPzQvgYhuMZuZU9Ro9oJ3mkHMCk+cAix+GlF3YQ/uQAPvFs7UDZJesgiHZzpRW93n5zMfmg7u9EhJo+TUSSm3TGpkbRftMWh/xnMXB5ZxtSCz9bUhSWfkpLoqmf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455015; c=relaxed/simple;
	bh=hb1Htn+5sDXBHE+CTAnltprKQkxsZPkpf1Cx8nA+0gE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pBulwNb+pcxRZcRXusbTpg9apV43f4tpYufQu1jncve/zhVKln6Qdz9pB8BZ1yIeFBezaTZFroQUBnz3aHDgIyJFyLUwo6cpYB3vzjlkR4hL4IxEBXULu3zO/3KZDCL91K+6Ka93wgWa/gCy2o062IHHtdOAhR+1C3Sw9HSQSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URFA3fSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60632C4CECD;
	Tue, 12 Nov 2024 23:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731455014;
	bh=hb1Htn+5sDXBHE+CTAnltprKQkxsZPkpf1Cx8nA+0gE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=URFA3fSMK8EIXeMZ0vESdJGmupyx9D8vAPUB2v7VtD4SV3JlPsmGkiFYDVfe0HMji
	 dr9JJqLtxB5bvSYy06WtXI3pQmfjizEUnvtj7Ykc8X3P38HQr9HUD3ftqn/PmQMVlk
	 aP/kjOUUuRH8Al20dwBf3TzGKszrhzLYAGnBQ0mZRZQ5vfFPCF+QBcyJGfFXOHbDLi
	 wKv0beyyMkHH2s9Sl58ock67+jA6Ujo0pKFBULkpn0xbSu48ARN5croBQpLE4OGn6c
	 Xj9Beedm7j8H1lBw09yxfHshaUidSi8UTNK0q3WehymSJqjEeYxZ8gMM4j9SvJNtOX
	 vJn3V8okTmEsg==
Date: Wed, 13 Nov 2024 08:43:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v18 12/17] fprobe: Add fprobe_header encoding feature
Message-Id: <20241113084325.86ce3d6bb44e7d67f5008825@kernel.org>
In-Reply-To: <20241112094437.59848631@gandalf.local.home>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991747946.443985.11014834036464028393.stgit@devnote2>
	<20241101102212.5e9d74d9@gandalf.local.home>
	<20241110001054.b0a5afb2d7bb1c09b4bd6b0b@kernel.org>
	<20241112094437.59848631@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 09:44:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 10 Nov 2024 00:10:54 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > > +++ b/arch/x86/include/asm/fprobe.h
> > > > @@ -0,0 +1,9 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef _ASM_X86_FPROBE_H
> > > > +#define _ASM_X86_FPROBE_H
> > > > +
> > > > +#ifdef CONFIG_64BIT
> > > > +#include <asm-generic/fprobe.h>
> > > > +#endif
> > > > +
> > > > +#endif /* _ASM_X86_FPROBE_H */
> > > > \ No newline at end of file  
> > > 
> > > Same for the above.  
> > 
> > OK, but x86 and riscv, we need this default template on 64bit only.
> > So those may keep it, right?
> 
> Hmm, I wonder if we could just add:
> 
>   generic-$(CONFIG_X86_32)
> 
> But since I don't see that used anywhere, we may need this for archs that
> partially have it.

Since this mask is not available on 32bit (since 32-4 = 28bit is 256MB,
which is too small for kernel space), I checked CONFIG_64BIT in 
asm-generic header in v19. So now I can use generic-y for most
architecture.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

