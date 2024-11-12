Return-Path: <linux-arch+bounces-9036-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854F9C5AC0
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 15:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347CF1F228AA
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C31FEFA9;
	Tue, 12 Nov 2024 14:44:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2D1FE10A;
	Tue, 12 Nov 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422672; cv=none; b=D839Pi9TwgEMO3Ut4KjGxJ+VlA96UwPQsupfesqBAVp7T1f68iIqqfP2WlVNJwE8Nq4KZy8eFpiEsySWE/fKS1v2AhSoJZhVYipR/j39LpewRHorc+qiRwrlpxkANZIL+QF2726dlR1/x6POqzojAGh2FtU+ypQXy6etyPL0tFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422672; c=relaxed/simple;
	bh=spgfkYfdtxiRXj09AHTCjCq+F7GElLNu1CMfPrjHt4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd+Dyo0CAH0eKdFXcHQ+J0kYCN/cy5N4PzWX8lxvqP4dBZW2FWgEMIDeMPZbrxPmweedH4n1fKu+nZDoxBB2WceB30+BtrRwqKfPwqoQqNJhFqbKTLTguzrzJegr5iEmKAzwI8N1Z3W7oUTgNsArmaOPUZzBe33gmX9iwfrZVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A02C4CECD;
	Tue, 12 Nov 2024 14:44:28 +0000 (UTC)
Date: Tue, 12 Nov 2024 09:44:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Message-ID: <20241112094437.59848631@gandalf.local.home>
In-Reply-To: <20241110001054.b0a5afb2d7bb1c09b4bd6b0b@kernel.org>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991747946.443985.11014834036464028393.stgit@devnote2>
	<20241101102212.5e9d74d9@gandalf.local.home>
	<20241110001054.b0a5afb2d7bb1c09b4bd6b0b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Nov 2024 00:10:54 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > +++ b/arch/x86/include/asm/fprobe.h
> > > @@ -0,0 +1,9 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _ASM_X86_FPROBE_H
> > > +#define _ASM_X86_FPROBE_H
> > > +
> > > +#ifdef CONFIG_64BIT
> > > +#include <asm-generic/fprobe.h>
> > > +#endif
> > > +
> > > +#endif /* _ASM_X86_FPROBE_H */
> > > \ No newline at end of file  
> > 
> > Same for the above.  
> 
> OK, but x86 and riscv, we need this default template on 64bit only.
> So those may keep it, right?

Hmm, I wonder if we could just add:

  generic-$(CONFIG_X86_32)

But since I don't see that used anywhere, we may need this for archs that
partially have it.

-- Steve

