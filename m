Return-Path: <linux-arch+bounces-9711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA438A09FEB
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jan 2025 02:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942963A863E
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jan 2025 01:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4A374F1;
	Sat, 11 Jan 2025 01:16:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C94C83;
	Sat, 11 Jan 2025 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736558201; cv=none; b=H4XhUnXAFdTPj9Azb1xOQHQ1+bvOUSXSmi3b9Isl5v53gxRo6tW9EgpfBQb+UToeAFv3Nd6muRRP70kiG7l5llciW0YGEDUPXWcgFxyjFuRS2sztCw/X4AU0Ak2QXAtAheg49FcDa0PQLfo+gORS06XGJ7AIfR3omnr5otksU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736558201; c=relaxed/simple;
	bh=sQ0hKscqgkFbQlYbywE8EkWkGZ06l86yKwob99Aviyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUR2hGFDLTEiNTvLBamVMhQScwC1jkMv6ZS/+BGzNawd6+eb1mK1L7TtZzVWcY6vSEyToM/Yz8zNpBIhC5JR9K4ZzBxg7iNABGmymxVx2MCOcggFDcr2K37NQZUbpCtIO5aPKoqoPnJJtR/kIGLEhOiapCddIRbptKuO41VJQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 3DA2E72C97D;
	Sat, 11 Jan 2025 04:16:32 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 2736C7CCB3A; Sat, 11 Jan 2025 03:16:32 +0200 (IST)
Date: Sat, 11 Jan 2025 03:16:32 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/6] syscall.h: introduce syscall_set_nr()
Message-ID: <20250111011632.GA1724@strace.io>
References: <20250107230438.GC30633@strace.io>
 <yt9dzfjz6rw5.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dzfjz6rw5.fsf@linux.ibm.com>

On Fri, Jan 10, 2025 at 08:37:46AM +0100, Sven Schnelle wrote:
> "Dmitry V. Levin" <ldv@strace.io> writes:
> 
> > Similar to syscall_set_arguments() that complements
> > syscall_get_arguments(), introduce syscall_set_nr()
> > that complements syscall_get_nr().
> >
> > syscall_set_nr() is going to be needed along with
> > syscall_set_arguments() on all HAVE_ARCH_TRACEHOOK
> > architectures to implement PTRACE_SET_SYSCALL_INFO API.
[...]
> > diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> > index b3dd883699e7..1c0e349fd5c9 100644
> > --- a/arch/s390/include/asm/syscall.h
> > +++ b/arch/s390/include/asm/syscall.h
> > @@ -24,6 +24,13 @@ static inline long syscall_get_nr(struct task_struct *task,
> >  		(regs->int_code & 0xffff) : -1;
> >  }
> >  
> > +static inline void syscall_set_nr(struct task_struct *task,
> > +				  struct pt_regs *regs,
> > +				  int nr)
> > +{
> 
> I think there should be a
> 
> 	if (!test_pt_regs_flags(regs, PIF_SYSCALL))
> 		return;
> 
> before the modification so a user can't accidentally change int_code
> when ptrace stopped in a non-syscall path.

The reason why syscall_get_nr() has this check on s390 (and similar checks
on arc, powerpc, and sparc) is that syscall_get_nr() can be called while
the target task is not in syscall.

Unlike syscall_get_nr(), syscall_set_nr() can be called only when the
target task is stopped for tracing on entering syscall: the description in
include/asm-generic/syscall.h explicitly states that, and the follow-up
patch that introduces PTRACE_SET_SYSCALL_INFO adds a syscall_set_nr() call
when the tracee is stopped on entering syscall in either
PTRACE_SYSCALL_INFO_ENTRY or PTRACE_SYSCALL_INFO_SECCOMP state.

I don't mind adding a check, but syscall_set_nr() invocation while the
target task is not in syscall wouldn't be a result of user actions but
a kernel programing error, and in that case WARN_ON_ONCE() would be more
appropriate.

If calling syscall_set_nr() while the target task is not in syscall was
legal, then syscall_set_nr() would have been designed to return a value
indicating the status of operation.

Anyway, I'll add an explanatory comment to syscall_set_nr() on all
architectures where syscall_get_nr() has a check.


-- 
ldv

