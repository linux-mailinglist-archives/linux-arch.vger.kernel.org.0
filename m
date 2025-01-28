Return-Path: <linux-arch+bounces-9940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4E0A20E77
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 17:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DA33A48A8
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF051D6DBC;
	Tue, 28 Jan 2025 16:25:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253AA1AA1FE;
	Tue, 28 Jan 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081548; cv=none; b=frLtTlQmZVuePV2O519MClVxP2EHpKk8NG5uT9S91vNtZV5dJ9R+FvS4hRnjDUTSQ2HPQW+y+rgghbsmtJln7wL1ONZzQZFXaLsK8QppRSP+S5xyRNcS/7wT0ePBQTkcSBkCD0OFiz4e77hG1D4ftK3EGMV90KHmEQf5lCDLZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081548; c=relaxed/simple;
	bh=jvB3dDUGhF3Hu8AIvKOd8DjrgajpM6JZ/iGC0VGHckA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+KOnwMVOwUsj50OdChnv4TPJ9mU2/rKzEYeMAXQNdcjg3GPAeFckWPZvs2gFMG6Hq/6zoBcjTs0tR6fKcq106S1YBnBE4EajuDEHK8TkBr+L7Nr0tsCKmm0d0CA7pA9JjrAX0A/YrVcdnG+F6sqOIjQrXhAdYWrLfIG2QmqExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 2396B72C97D;
	Tue, 28 Jan 2025 19:25:45 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 0E2917CCB3A; Tue, 28 Jan 2025 18:25:45 +0200 (IST)
Date: Tue, 28 Jan 2025 18:25:44 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-snps-arc@lists.infradead.org,
	Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-mips@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	linux-hexagon@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-riscv@lists.infradead.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	strace-devel@lists.strace.io, linux-arch@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Mike Frysinger <vapier@gentoo.org>,
	Davide Berardi <berardi.dav@gmail.com>,
	Renzo Davoli <renzo@cs.unibo.it>, linux-um@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-m68k@lists.linux-m68k.org, Borislav Petkov <bp@alien8.de>,
	loongarch@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Stafford Horne <shorne@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-parisc@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexey Gladkov <legion@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 3/6] syscall.h: introduce syscall_set_nr()
Message-ID: <20250128162544.GE11869@strace.io>
References: <20250128091636.GC8601@strace.io>
 <e76df471-1346-459a-9f24-fa053d7dcbe8@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e76df471-1346-459a-9f24-fa053d7dcbe8@csgroup.eu>

On Tue, Jan 28, 2025 at 04:13:52PM +0100, Christophe Leroy wrote:
> Le 28/01/2025 à 10:16, Dmitry V. Levin a écrit :
> > Similar to syscall_set_arguments() that complements
> > syscall_get_arguments(), introduce syscall_set_nr()
> > that complements syscall_get_nr().
> > 
> > syscall_set_nr() is going to be needed along with
> > syscall_set_arguments() on all HAVE_ARCH_TRACEHOOK
> > architectures to implement PTRACE_SET_SYSCALL_INFO API.
> > 
> > Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> > Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >   arch/arc/include/asm/syscall.h        | 11 +++++++++++
> >   arch/arm/include/asm/syscall.h        | 24 ++++++++++++++++++++++++
> >   arch/arm64/include/asm/syscall.h      | 16 ++++++++++++++++
> >   arch/hexagon/include/asm/syscall.h    |  7 +++++++
> >   arch/loongarch/include/asm/syscall.h  |  7 +++++++
> >   arch/m68k/include/asm/syscall.h       |  7 +++++++
> >   arch/microblaze/include/asm/syscall.h |  7 +++++++
> >   arch/mips/include/asm/syscall.h       | 14 ++++++++++++++
> >   arch/nios2/include/asm/syscall.h      |  5 +++++
> >   arch/openrisc/include/asm/syscall.h   |  6 ++++++
> >   arch/parisc/include/asm/syscall.h     |  7 +++++++
> >   arch/powerpc/include/asm/syscall.h    | 10 ++++++++++
> >   arch/riscv/include/asm/syscall.h      |  7 +++++++
> >   arch/s390/include/asm/syscall.h       | 12 ++++++++++++
> >   arch/sh/include/asm/syscall_32.h      | 12 ++++++++++++
> >   arch/sparc/include/asm/syscall.h      | 12 ++++++++++++
> >   arch/um/include/asm/syscall-generic.h |  5 +++++
> >   arch/x86/include/asm/syscall.h        |  7 +++++++
> >   arch/xtensa/include/asm/syscall.h     |  7 +++++++
> >   include/asm-generic/syscall.h         | 14 ++++++++++++++
> >   20 files changed, 197 insertions(+)
> > 
> 
> > diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> > index 76020b66286b..712daa90e643 100644
> > --- a/arch/arm64/include/asm/syscall.h
> > +++ b/arch/arm64/include/asm/syscall.h
> > @@ -61,6 +61,22 @@ static inline void syscall_set_return_value(struct task_struct *task,
> >   	regs->regs[0] = val;
> >   }
> >   
> > +static inline void syscall_set_nr(struct task_struct *task,
> > +				  struct pt_regs *regs,
> > +				  int nr)
> > +{
> > +	regs->syscallno = nr;
> > +	if (nr == -1) {
> > +		/*
> > +		 * When the syscall number is set to -1, the syscall will be
> > +		 * skipped.  In this case the syscall return value has to be
> > +		 * set explicitly, otherwise the first syscall argument is
> > +		 * returned as the syscall return value.
> > +		 */
> > +		syscall_set_return_value(task, regs, -ENOSYS, 0);
> > +	}
> > +}
> > +
> >   #define SYSCALL_MAX_ARGS 6
> >   
> >   static inline void syscall_get_arguments(struct task_struct *task,
> 
> > diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> > index 521f279e6b33..7505dcfed247 100644
> > --- a/arch/powerpc/include/asm/syscall.h
> > +++ b/arch/powerpc/include/asm/syscall.h
> > @@ -39,6 +39,16 @@ static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
> >   		return -1;
> >   }
> >   
> > +static inline void syscall_set_nr(struct task_struct *task, struct pt_regs *regs, int nr)
> > +{
> > +	/*
> > +	 * Unlike syscall_get_nr(), syscall_set_nr() can be called only when
> > +	 * the target task is stopped for tracing on entering syscall, so
> > +	 * there is no need to have the same check syscall_get_nr() has.
> > +	 */
> > +	regs->gpr[0] = nr;
> 
> Doesn't the same as for ARM64 apply here as well ?

I carefully checked all affected architectures and added that
syscall_set_return_value() call only where I think it's needed.

On powerpc it's not needed with the current implementation: their
do_seccomp() sets -ENOSYS before __secure_computing() invocation, and
their do_syscall_trace_enter() sets -ENOSYS in case of an invalid syscall
number.


-- 
ldv

