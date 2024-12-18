Return-Path: <linux-arch+bounces-9419-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE1E9F5F27
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 08:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BE17A0723
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E901155C83;
	Wed, 18 Dec 2024 07:21:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE620ED;
	Wed, 18 Dec 2024 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734506463; cv=none; b=eMfvQrf1gFpPK3RcKBLnJ+u0KXSBMM3X7n2MNDDuoiE+ORmAwyMbVkVJoAw+R/KsKIdEq9YITbjIEfZyZbYgoZ4hbRicfqUSG1/rGPous0fqt/UTqdrOQGo44joCK/nqNVhenUkoD6+FBLx0UjY11G3Nv4stexBJND0T2lcXdD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734506463; c=relaxed/simple;
	bh=TFVjqrLoZp8KXbs1B4z2a2jr/pzuvI/bCUv3pNeEnso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0WitdwiV41V6DHEMcIw8CCn201cFW467pMY27l6cxrWTm36bHI7CO7e3HGuJfnY4PwqkIMS9HXzMkl4RWPmoDlDzTKaErfMJpb4g8ElidoKwfcMNm9cYz2MGv/puf85qsVdpVjVa0zAWJJzXrCK4+fevwo96EetYZUt3K3gC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YClTH73q4z9sPd;
	Wed, 18 Dec 2024 08:20:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fhAxNvgajVJb; Wed, 18 Dec 2024 08:20:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YClTH5WtQz9rvV;
	Wed, 18 Dec 2024 08:20:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A3D388B770;
	Wed, 18 Dec 2024 08:20:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kG4K2BrHS9cT; Wed, 18 Dec 2024 08:20:51 +0100 (CET)
Received: from [10.25.209.139] (unknown [10.25.209.139])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 37A438B763;
	Wed, 18 Dec 2024 08:20:51 +0100 (CET)
Message-ID: <12120bbe-1d79-425b-982d-46af1fa5d70d@csgroup.eu>
Date: Wed, 18 Dec 2024 08:20:51 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] powerpc/vdso: Switch to generic storage
 implementation
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-12-f7aed1bdb3b2@linutronix.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241216-vdso-store-rng-v1-12-f7aed1bdb3b2@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/12/2024 à 15:10, Thomas Weißschuh a écrit :
> The generic storage implementation provides the same features as the
> custom one. However it can be shared between architectures, making
> maintenance easier.
> 
> Co-developed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   arch/powerpc/Kconfig                         |   2 +
>   arch/powerpc/include/asm/vdso.h              |   1 +
>   arch/powerpc/include/asm/vdso/arch_data.h    |  37 +++++++++
>   arch/powerpc/include/asm/vdso/getrandom.h    |  11 +--
>   arch/powerpc/include/asm/vdso/gettimeofday.h |  36 +++++----
>   arch/powerpc/include/asm/vdso/vsyscall.h     |  13 ---
>   arch/powerpc/include/asm/vdso_datapage.h     |  44 +---------
>   arch/powerpc/kernel/asm-offsets.c            |   1 -
>   arch/powerpc/kernel/time.c                   |   2 +-
>   arch/powerpc/kernel/vdso.c                   | 115 +++------------------------
>   arch/powerpc/kernel/vdso/cacheflush.S        |   2 +-
>   arch/powerpc/kernel/vdso/datapage.S          |   4 +-
>   arch/powerpc/kernel/vdso/gettimeofday.S      |   4 +-
>   arch/powerpc/kernel/vdso/vdso32.lds.S        |   4 +-
>   arch/powerpc/kernel/vdso/vdso64.lds.S        |   4 +-
>   arch/powerpc/kernel/vdso/vgettimeofday.c     |  14 ++--
>   16 files changed, 101 insertions(+), 193 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a0ce777f97063bf858942c60654d8411bcf2a3dc..600fa3b917ee902d016f2a04376950a9dc49074f 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -156,6 +156,7 @@ config PPC
>   	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_HAS_UACCESS_FLUSHCACHE
>   	select ARCH_HAS_UBSAN
> +	select ARCH_HAS_VDSO_ARCH_DATA
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	select ARCH_HAVE_EXTRA_ELF_NOTES        if SPU_BASE
>   	select ARCH_KEEP_MEMBLOCK
> @@ -206,6 +207,7 @@ config PPC
>   	select GENERIC_PTDUMP
>   	select GENERIC_SMP_IDLE_THREAD
>   	select GENERIC_TIME_VSYSCALL
> +	select GENERIC_VDSO_DATA_STORE
>   	select GENERIC_VDSO_TIME_NS
>   	select HAS_IOPORT			if PCI
>   	select HAVE_ARCH_AUDITSYSCALL
> diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
> index 8d972bc98b55fe916f23488ca9e2a5918046b9aa..1ca23fbfe087ae90b90c4286335f86d9f8121078 100644
> --- a/arch/powerpc/include/asm/vdso.h
> +++ b/arch/powerpc/include/asm/vdso.h
> @@ -3,6 +3,7 @@
>   #define _ASM_POWERPC_VDSO_H
>   
>   #define VDSO_VERSION_STRING	LINUX_2.6.15
> +#define __VDSO_PAGES		4
>   
>   #ifndef __ASSEMBLY__
>   
> diff --git a/arch/powerpc/include/asm/vdso/arch_data.h b/arch/powerpc/include/asm/vdso/arch_data.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..c240a6b875181ac4159f2e80b11f9bf214e22808
> --- /dev/null
> +++ b/arch/powerpc/include/asm/vdso/arch_data.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2002 Peter Bergner <bergner@vnet.ibm.com>, IBM
> + * Copyright (C) 2005 Benjamin Herrenschmidy <benh@kernel.crashing.org>,
> + * 		      IBM Corp.
> + */
> +#ifndef _ASM_POWERPC_VDSO_ARCH_DATA_H
> +#define _ASM_POWERPC_VDSO_ARCH_DATA_H
> +
> +#include <linux/unistd.h>
> +#include <linux/types.h>
> +
> +#define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
> +
> +#ifdef CONFIG_PPC64
> +
> +struct vdso_arch_data {
> +	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
> +	__u32 dcache_block_size;		/* L1 d-cache block size     */
> +	__u32 icache_block_size;		/* L1 i-cache block size     */
> +	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
> +	__u32 icache_log_block_size;		/* L1 i-cache log block size */
> +	__u32 syscall_map[SYSCALL_MAP_SIZE];	/* Map of syscalls  */
> +	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
> +};
> +
> +#else /* CONFIG_PPC64 */
> +
> +struct vdso_arch_data {
> +	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
> +	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
> +	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
> +};
> +
> +#endif /* CONFIG_PPC64 */
> +
> +#endif /* _ASM_POWERPC_VDSO_ARCH_DATA_H */
> diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
> index 80ce0709725eb89c1f3b69e0733038b458fbf24f..c82eb0d8237681a7396abfe7d161292636b8cce4 100644
> --- a/arch/powerpc/include/asm/vdso/getrandom.h
> +++ b/arch/powerpc/include/asm/vdso/getrandom.h
> @@ -43,20 +43,21 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
>   			    (unsigned long)len, (unsigned long)flags);
>   }
>   
> -static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> +static __always_inline const struct vdso_rng_data *__ppc_get_vdso_u_rng_data(void)
>   {
> -	struct vdso_arch_data *data;
> +	struct vdso_rng_data *data;
>   
>   	asm (
>   		"	bcl	20, 31, .+4 ;"
>   		"0:	mflr	%0 ;"
> -		"	addis	%0, %0, (_vdso_datapage - 0b)@ha ;"
> -		"	addi	%0, %0, (_vdso_datapage - 0b)@l  ;"
> +		"	addis	%0, %0, (vdso_u_rng_data - 0b)@ha ;"
> +		"	addi	%0, %0, (vdso_u_rng_data - 0b)@l  ;"
>   		: "=r" (data) : : "lr"
>   	);
>   
> -	return &data->rng_data;
> +	return data;
>   }
> +#define __arch_get_vdso_u_rng_data __ppc_get_vdso_u_rng_data
>   
>   ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
>   			     size_t opaque_len);
> diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
> index c6390890a60c2fdcb608bf321b2945c3fb372f54..bddd9cde97db197d0d3daba6c2289cb29e6b5a75 100644
> --- a/arch/powerpc/include/asm/vdso/gettimeofday.h
> +++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
> @@ -94,22 +94,29 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
>   #endif
>   
>   static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
> -						 const struct vdso_data *vd)
> +						 const struct vdso_time_data *vd)
>   {
>   	return get_tb();
>   }
>   
> -const struct vdso_data *__arch_get_vdso_data(void);
> -
>   #ifdef CONFIG_TIME_NS
> -static __always_inline
> -const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
> +static __always_inline const struct vdso_time_data *__ppc_get_vdso_u_timens_data(void)
>   {
> -	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
> +	struct vdso_time_data *time_data;
> +
> +	asm(
> +		"	bcl	20, 31, .+4\n"
> +		"0:	mflr	%0\n"
> +		"	addis	%0, %0, (vdso_u_timens_data - 0b)@ha\n"
> +		"	addi	%0, %0, (vdso_u_timens_data - 0b)@l\n"
> +	: "=r" (time_data) :: "lr");
> +
> +	return time_data;

Please don't do that, it kills optimisation efforts done when 
implementing VDSO time. Commit ce7d8056e38b ("powerpc/vdso: Prepare for 
switching VDSO to generic C implementation.") explains why.

For time data, the bcl/mflr dance is done by get_datapage macro called 
by cvdso_call macro in gettimeofday.S, and given to 
__cvdso_clock_gettime_data() by __c_kernel_clock_gettime() in 
vgettimeofday.c . Use that information and don't redo the bcl/mflr sequence.

See for instance function __c_kernel_clock_getres():

Before your series it is 30 instructions.
After your series it is 59 instructions.

Before:
000010f8 <__c_kernel_clock_getres>:
     10f8:	28 03 00 0f 	cmplwi  r3,15
     10fc:	41 81 00 60 	bgt     115c <__c_kernel_clock_getres+0x64>
     1100:	81 45 00 04 	lwz     r10,4(r5)
     1104:	3d 20 7f ff 	lis     r9,32767
     1108:	61 29 ff ff 	ori     r9,r9,65535
     110c:	7c 0a 48 00 	cmpw    r10,r9
     1110:	40 a2 00 08 	bne     1118 <__c_kernel_clock_getres+0x20>
     1114:	38 a5 40 00 	addi    r5,r5,16384
     1118:	39 20 00 01 	li      r9,1
     111c:	7d 29 18 30 	slw     r9,r9,r3
     1120:	71 2a 08 93 	andi.   r10,r9,2195
     1124:	40 82 00 30 	bne     1154 <__c_kernel_clock_getres+0x5c>
     1128:	71 29 00 60 	andi.   r9,r9,96
     112c:	41 82 00 30 	beq     115c <__c_kernel_clock_getres+0x64>
     1130:	3d 20 00 98 	lis     r9,152
     1134:	61 29 96 80 	ori     r9,r9,38528
     1138:	2c 04 00 00 	cmpwi   r4,0
     113c:	41 82 00 10 	beq     114c <__c_kernel_clock_getres+0x54>
     1140:	39 40 00 00 	li      r10,0
     1144:	91 24 00 04 	stw     r9,4(r4)
     1148:	91 44 00 00 	stw     r10,0(r4)
     114c:	38 60 00 00 	li      r3,0
     1150:	4e 80 00 20 	blr
     1154:	81 25 00 e8 	lwz     r9,232(r5)
     1158:	4b ff ff e0 	b       1138 <__c_kernel_clock_getres+0x40>
     115c:	38 00 00 f7 	li      r0,247
     1160:	44 00 00 02 	sc
     1164:	40 a3 00 08 	bns     116c <__c_kernel_clock_getres+0x74>
     1168:	7c 63 00 d0 	neg     r3,r3
     116c:	4e 80 00 20 	blr

After:
000011ac <__c_kernel_clock_getres>:
     11ac:	28 03 00 0f 	cmplwi  r3,15
     11b0:	41 81 00 c0 	bgt     1270 <__c_kernel_clock_getres+0xc4>
     11b4:	81 45 00 04 	lwz     r10,4(r5)
     11b8:	3d 20 7f ff 	lis     r9,32767
     11bc:	61 29 ff ff 	ori     r9,r9,65535
     11c0:	7c 0a 48 00 	cmpw    r10,r9
     11c4:	41 82 00 48 	beq     120c <__c_kernel_clock_getres+0x60>
     11c8:	39 20 00 01 	li      r9,1
     11cc:	7d 29 18 30 	slw     r9,r9,r3
     11d0:	71 2a 08 93 	andi.   r10,r9,2195
     11d4:	40 82 00 30 	bne     1204 <__c_kernel_clock_getres+0x58>
     11d8:	71 29 00 60 	andi.   r9,r9,96
     11dc:	41 82 00 94 	beq     1270 <__c_kernel_clock_getres+0xc4>
     11e0:	3d 20 00 98 	lis     r9,152
     11e4:	61 29 96 80 	ori     r9,r9,38528
     11e8:	2c 04 00 00 	cmpwi   r4,0
     11ec:	41 82 00 10 	beq     11fc <__c_kernel_clock_getres+0x50>
     11f0:	39 40 00 00 	li      r10,0
     11f4:	91 24 00 04 	stw     r9,4(r4)
     11f8:	91 44 00 00 	stw     r10,0(r4)
     11fc:	38 60 00 00 	li      r3,0
     1200:	4e 80 00 20 	blr
     1204:	81 25 00 e8 	lwz     r9,232(r5)
     1208:	4b ff ff e0 	b       11e8 <__c_kernel_clock_getres+0x3c>
     120c:	39 20 00 01 	li      r9,1
     1210:	7d 29 18 30 	slw     r9,r9,r3
     1214:	71 2a 08 93 	andi.   r10,r9,2195
     1218:	7c 08 02 a6 	mflr    r0
     121c:	90 01 00 04 	stw     r0,4(r1)
     1220:	42 9f 00 05 	bcl     20,4*cr7+so,1224 
<__c_kernel_clock_getres+0x78>
     1224:	7c a8 02 a6 	mflr    r5
     1228:	3c a5 ff ff 	addis   r5,r5,-1
     122c:	38 a5 2d dc 	addi    r5,r5,11740
     1230:	40 82 00 38 	bne     1268 <__c_kernel_clock_getres+0xbc>
     1234:	71 29 00 60 	andi.   r9,r9,96
     1238:	41 82 00 4c 	beq     1284 <__c_kernel_clock_getres+0xd8>
     123c:	3d 20 00 98 	lis     r9,152
     1240:	61 29 96 80 	ori     r9,r9,38528
     1244:	2c 04 00 00 	cmpwi   r4,0
     1248:	41 82 00 10 	beq     1258 <__c_kernel_clock_getres+0xac>
     124c:	39 40 00 00 	li      r10,0
     1250:	91 24 00 04 	stw     r9,4(r4)
     1254:	91 44 00 00 	stw     r10,0(r4)
     1258:	38 60 00 00 	li      r3,0
     125c:	80 01 00 04 	lwz     r0,4(r1)
     1260:	7c 08 03 a6 	mtlr    r0
     1264:	4e 80 00 20 	blr
     1268:	81 25 00 e8 	lwz     r9,232(r5)
     126c:	4b ff ff d8 	b       1244 <__c_kernel_clock_getres+0x98>
     1270:	38 00 00 f7 	li      r0,247
     1274:	44 00 00 02 	sc
     1278:	40 a3 00 08 	bns     1280 <__c_kernel_clock_getres+0xd4>
     127c:	7c 63 00 d0 	neg     r3,r3
     1280:	4e 80 00 20 	blr
     1284:	38 00 00 f7 	li      r0,247
     1288:	44 00 00 02 	sc
     128c:	40 a3 00 08 	bns     1294 <__c_kernel_clock_getres+0xe8>
     1290:	7c 63 00 d0 	neg     r3,r3
     1294:	4b ff ff c8 	b       125c <__c_kernel_clock_getres+0xb0>

>   }
> +#define __arch_get_vdso_u_timens_data __ppc_get_vdso_u_timens_data

There is not #ifdef __arch_get_vdso_u_timens_data anywhere, this #define 
is not needed, the function should be called 
__arch_get_vdso_u_timens_data() directly as before, unnecessary 
indirections reduce readability.

>   #endif
>   
> -static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
> +static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
>   {
>   	return true;
>   }

