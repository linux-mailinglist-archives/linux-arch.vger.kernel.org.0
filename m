Return-Path: <linux-arch+bounces-9733-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF33A0C1CE
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 20:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791001889101
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 19:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E7E1C549F;
	Mon, 13 Jan 2025 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX4L2vh3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B21B6D09;
	Mon, 13 Jan 2025 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797707; cv=none; b=U6h4RdKPIzUGg8SikdC007qvADF0La88y6fbRwREwxnRbd/FLBhbJbEWeFXb1w8jiUlWUsDZYLsAcC58WJ+DLhU2qtoOoMuTJKYbRL+hJ1HBZlLLbUNXvFI1dSebgXdjTh6U9Fdnxp68LN/So1blOVQrRvILew9LIZr6bda22G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797707; c=relaxed/simple;
	bh=ARh1E+X9nvq4M7WgNmEsV07y0RtOChSd374gUp+r3KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZLjHzmvnEL5XZqcVMG/5OmOcH+RIKj/U0uxKdIQ0qxLlzVDAGFMw5r58viMuAL1lq5vdtelDtgr4UYNlip+ylzaEteW3sG9wxxTQEtnZN5trE6NvwJ+t9pgN9/LBp8kSQlOjpNQmkrnLVe2tZaqUfaau7MtEaJgrFc0eJCpppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX4L2vh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD0AC4CEE1;
	Mon, 13 Jan 2025 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736797706;
	bh=ARh1E+X9nvq4M7WgNmEsV07y0RtOChSd374gUp+r3KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RX4L2vh3SEV95XNwIcId5cSnXh5x9Ya/9L2M/vOD8iOVc4pzb3R47MbLOjOOHsNnY
	 dLRUg8LuZreYFGu6CFeLmjxGyUIwMA40dFoiEpQg5MIzVkASeZHuCn5I+iiYK80zzi
	 fF7Y7pU7wVTFJC0/S3jOh6wyrLhitt+vfVaroRsDeVPmHwfIBQvS1IKL6XQnrKaG1a
	 6txc1yVBZm1PMPHNIyBlhij0zjZXI7ViCEYPDQbUhZLgWaCrqbNlzBTUeSS6XdRPbb
	 FjEZ+YsvmhKZbZPv8hAed7uepTmNoGjDe7QdA1ktErTg3dCwry1vuH/YFYz8du0bVA
	 7iJ1L5pamoEpw==
Date: Mon, 13 Jan 2025 19:48:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, linux-csky@vger.kernel.org
Subject: Re: [PATCH v2 09/18] riscv: vdso: Switch to generic storage
 implementation
Message-ID: <20250113-kissable-monstrous-aace0cf7182e@spud>
References: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
 <20250110-vdso-store-rng-v2-9-350c9179bbf1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5blIZ1Iqus9/6yzw"
Content-Disposition: inline
In-Reply-To: <20250110-vdso-store-rng-v2-9-350c9179bbf1@linutronix.de>


--5blIZ1Iqus9/6yzw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 04:23:48PM +0100, Thomas Wei=DFschuh wrote:
> The generic storage implementation provides the same features as the
> custom one. However it can be shared between architectures, making
> maintenance easier.
>=20
> Co-developed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Thomas Wei=DFschuh <thomas.weissschuh@linutronix.de>

For rv64, nommu:
  LD      vmlinux
ld.lld: error: undefined symbol: vmf_insert_pfn
>>> referenced by datastore.c
>>>               lib/vdso/datastore.o:(vvar_fault) in archive vmlinux.a

ld.lld: error: undefined symbol: _install_special_mapping
>>> referenced by datastore.c
>>>               lib/vdso/datastore.o:(vdso_install_vvar_mapping) in archi=
ve vmlinux.a

Later patches in the series don't make it build again.
rv32 builds now though, so thanks for fixing that.

Cheers,
Conor.

> ---
>  arch/riscv/Kconfig                                 |  3 +-
>  arch/riscv/include/asm/vdso.h                      |  2 +-
>  .../include/asm/vdso/{time_data.h =3D> arch_data.h}  |  8 +-
>  arch/riscv/include/asm/vdso/gettimeofday.h         | 14 +---
>  arch/riscv/include/asm/vdso/vsyscall.h             |  9 ---
>  arch/riscv/kernel/sys_hwprobe.c                    |  3 +-
>  arch/riscv/kernel/vdso.c                           | 90 +---------------=
------
>  arch/riscv/kernel/vdso/hwprobe.c                   |  6 +-
>  arch/riscv/kernel/vdso/vdso.lds.S                  |  7 +-
>  9 files changed, 18 insertions(+), 124 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d4a7ca0388c071b536df59c0eb11d55f9080c7cd..335cbbd4dddb17e5ccaa2cdda=
efc298cb559dbc0 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -52,7 +52,7 @@ config RISCV
>  	select ARCH_HAS_SYSCALL_WRAPPER
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UBSAN
> -	select ARCH_HAS_VDSO_TIME_DATA
> +	select ARCH_HAS_VDSO_ARCH_DATA
>  	select ARCH_KEEP_MEMBLOCK if ACPI
>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> @@ -115,6 +115,7 @@ config RISCV
>  	select GENERIC_SCHED_CLOCK
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
> +	select GENERIC_VDSO_DATA_STORE
>  	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
>  	select HARDIRQS_SW_RESEND
>  	select HAS_IOPORT if MMU
> diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
> index f891478829a52c41e06240f67611694cc28197d9..c130d8100232cbe50e52e35eb=
418e354bd114cb7 100644
> --- a/arch/riscv/include/asm/vdso.h
> +++ b/arch/riscv/include/asm/vdso.h
> @@ -14,7 +14,7 @@
>   */
>  #ifdef CONFIG_MMU
> =20
> -#define __VVAR_PAGES    2
> +#define __VDSO_PAGES    4
> =20
>  #ifndef __ASSEMBLY__
>  #include <generated/vdso-offsets.h>
> diff --git a/arch/riscv/include/asm/vdso/time_data.h b/arch/riscv/include=
/asm/vdso/arch_data.h
> similarity index 71%
> rename from arch/riscv/include/asm/vdso/time_data.h
> rename to arch/riscv/include/asm/vdso/arch_data.h
> index dfa65228999bed41dfd6c5e36cb678e1e055eec8..da57a3786f7a53c866fc00948=
826b4a2d839940f 100644
> --- a/arch/riscv/include/asm/vdso/time_data.h
> +++ b/arch/riscv/include/asm/vdso/arch_data.h
> @@ -1,12 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __RISCV_ASM_VDSO_TIME_DATA_H
> -#define __RISCV_ASM_VDSO_TIME_DATA_H
> +#ifndef __RISCV_ASM_VDSO_ARCH_DATA_H
> +#define __RISCV_ASM_VDSO_ARCH_DATA_H
> =20
>  #include <linux/types.h>
>  #include <vdso/datapage.h>
>  #include <asm/hwprobe.h>
> =20
> -struct arch_vdso_time_data {
> +struct vdso_arch_data {
>  	/* Stash static answers to the hwprobe queries when all CPUs are select=
ed. */
>  	__u64 all_cpu_hwprobe_values[RISCV_HWPROBE_MAX_KEY + 1];
> =20
> @@ -14,4 +14,4 @@ struct arch_vdso_time_data {
>  	__u8 homogeneous_cpus;
>  };
> =20
> -#endif /* __RISCV_ASM_VDSO_TIME_DATA_H */
> +#endif /* __RISCV_ASM_VDSO_ARCH_DATA_H */
> diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/incl=
ude/asm/vdso/gettimeofday.h
> index ba3283cf7accaa93a38512d2c17eda0eefde0612..29164f84f93cec6e28251e6a0=
adfbc341ac88241 100644
> --- a/arch/riscv/include/asm/vdso/gettimeofday.h
> +++ b/arch/riscv/include/asm/vdso/gettimeofday.h
> @@ -69,7 +69,7 @@ int clock_getres_fallback(clockid_t _clkid, struct __ke=
rnel_timespec *_ts)
>  #endif /* CONFIG_GENERIC_TIME_VSYSCALL */
> =20
>  static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
> -						 const struct vdso_data *vd)
> +						 const struct vdso_time_data *vd)
>  {
>  	/*
>  	 * The purpose of csr_read(CSR_TIME) is to trap the system into
> @@ -79,18 +79,6 @@ static __always_inline u64 __arch_get_hw_counter(s32 c=
lock_mode,
>  	return csr_read(CSR_TIME);
>  }
> =20
> -static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
> -{
> -	return _vdso_data;
> -}
> -
> -#ifdef CONFIG_TIME_NS
> -static __always_inline
> -const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_da=
ta *vd)
> -{
> -	return _timens_data;
> -}
> -#endif
>  #endif /* !__ASSEMBLY__ */
> =20
>  #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
> diff --git a/arch/riscv/include/asm/vdso/vsyscall.h b/arch/riscv/include/=
asm/vdso/vsyscall.h
> index e8a9c4b53c0c9f4744196eed800b21f3918d1040..1140b54b4bc8278d7a322036c=
d9f84f71258f246 100644
> --- a/arch/riscv/include/asm/vdso/vsyscall.h
> +++ b/arch/riscv/include/asm/vdso/vsyscall.h
> @@ -6,15 +6,6 @@
> =20
>  #include <vdso/datapage.h>
> =20
> -extern struct vdso_data *vdso_data;
> -
> -static __always_inline struct vdso_data *__riscv_get_k_vdso_data(void)
> -{
> -	return vdso_data;
> -}
> -
> -#define __arch_get_k_vdso_data __riscv_get_k_vdso_data
> -
>  /* The asm-generic header needs to be included after the definitions abo=
ve */
>  #include <asm-generic/vdso/vsyscall.h>
> =20
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index cb93adfffc486e710409fd3b8a8ab22525ac4093..37e155dd3ab26da7b6a03e0b1=
1b467e5aac51091 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -445,8 +445,7 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __us=
er *pairs,
> =20
>  static int __init init_hwprobe_vdso_data(void)
>  {
> -	struct vdso_data *vd =3D __arch_get_k_vdso_data();
> -	struct arch_vdso_time_data *avd =3D &vd->arch_data;
> +	struct vdso_arch_data *avd =3D vdso_k_arch_data;
>  	u64 id_bitsmash =3D 0;
>  	struct riscv_hwprobe pair;
>  	int key;
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 3ca3ae4277e187e790a8bf513a9e80d8b6290bb2..cc2895d1fbc2fe752b3edc94f=
4e28a6a8fca7a3b 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -13,20 +13,11 @@
>  #include <linux/err.h>
>  #include <asm/page.h>
>  #include <asm/vdso.h>
> -#include <linux/time_namespace.h>
> +#include <linux/vdso_datastore.h>
>  #include <vdso/datapage.h>
>  #include <vdso/vsyscall.h>
> =20
> -enum vvar_pages {
> -	VVAR_DATA_PAGE_OFFSET,
> -	VVAR_TIMENS_PAGE_OFFSET,
> -	VVAR_NR_PAGES,
> -};
> -
> -#define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
> -
> -static union vdso_data_store vdso_data_store __page_aligned_data;
> -struct vdso_data *vdso_data =3D vdso_data_store.data;
> +#define VVAR_SIZE  (VDSO_NR_PAGES << PAGE_SHIFT)
> =20
>  struct __vdso_info {
>  	const char *name;
> @@ -79,78 +70,6 @@ static void __init __vdso_init(struct __vdso_info *vds=
o_info)
>  	vdso_info->cm->pages =3D vdso_pagelist;
>  }
> =20
> -#ifdef CONFIG_TIME_NS
> -struct vdso_data *arch_get_vdso_data(void *vvar_page)
> -{
> -	return (struct vdso_data *)(vvar_page);
> -}
> -
> -static const struct vm_special_mapping rv_vvar_map;
> -
> -/*
> - * The vvar mapping contains data for a specific time namespace, so when=
 a task
> - * changes namespace we must unmap its vvar data for the old namespace.
> - * Subsequent faults will map in data for the new namespace.
> - *
> - * For more details see timens_setup_vdso_data().
> - */
> -int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> -{
> -	struct mm_struct *mm =3D task->mm;
> -	struct vm_area_struct *vma;
> -	VMA_ITERATOR(vmi, mm, 0);
> -
> -	mmap_read_lock(mm);
> -
> -	for_each_vma(vmi, vma) {
> -		if (vma_is_special_mapping(vma, &rv_vvar_map))
> -			zap_vma_pages(vma);
> -	}
> -
> -	mmap_read_unlock(mm);
> -	return 0;
> -}
> -#endif
> -
> -static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
> -			     struct vm_area_struct *vma, struct vm_fault *vmf)
> -{
> -	struct page *timens_page =3D find_timens_vvar_page(vma);
> -	unsigned long pfn;
> -
> -	switch (vmf->pgoff) {
> -	case VVAR_DATA_PAGE_OFFSET:
> -		if (timens_page)
> -			pfn =3D page_to_pfn(timens_page);
> -		else
> -			pfn =3D sym_to_pfn(vdso_data);
> -		break;
> -#ifdef CONFIG_TIME_NS
> -	case VVAR_TIMENS_PAGE_OFFSET:
> -		/*
> -		 * If a task belongs to a time namespace then a namespace
> -		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
> -		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
> -		 * offset.
> -		 * See also the comment near timens_setup_vdso_data().
> -		 */
> -		if (!timens_page)
> -			return VM_FAULT_SIGBUS;
> -		pfn =3D sym_to_pfn(vdso_data);
> -		break;
> -#endif /* CONFIG_TIME_NS */
> -	default:
> -		return VM_FAULT_SIGBUS;
> -	}
> -
> -	return vmf_insert_pfn(vma, vmf->address, pfn);
> -}
> -
> -static const struct vm_special_mapping rv_vvar_map =3D {
> -	.name   =3D "[vvar]",
> -	.fault =3D vvar_fault,
> -};
> -
>  static struct vm_special_mapping rv_vdso_map __ro_after_init =3D {
>  	.name   =3D "[vdso]",
>  	.mremap =3D vdso_mremap,
> @@ -196,7 +115,7 @@ static int __setup_additional_pages(struct mm_struct =
*mm,
>  	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
>  	void *ret;
> =20
> -	BUILD_BUG_ON(VVAR_NR_PAGES !=3D __VVAR_PAGES);
> +	BUILD_BUG_ON(VDSO_NR_PAGES !=3D __VDSO_PAGES);
> =20
>  	vdso_text_len =3D vdso_info->vdso_pages << PAGE_SHIFT;
>  	/* Be sure to map the data page */
> @@ -208,8 +127,7 @@ static int __setup_additional_pages(struct mm_struct =
*mm,
>  		goto up_fail;
>  	}
> =20
> -	ret =3D _install_special_mapping(mm, vdso_base, VVAR_SIZE,
> -		(VM_READ | VM_MAYREAD | VM_PFNMAP), &rv_vvar_map);
> +	ret =3D vdso_install_vvar_mapping(mm, vdso_base);
>  	if (IS_ERR(ret))
>  		goto up_fail;
> =20
> diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hw=
probe.c
> index a158c029344f60c022e7565757ff44df7e3d89e5..2ddeba6c68dda09b0249117fd=
06a5d249f3b0abd 100644
> --- a/arch/riscv/kernel/vdso/hwprobe.c
> +++ b/arch/riscv/kernel/vdso/hwprobe.c
> @@ -16,8 +16,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *=
pairs, size_t pair_count,
>  				 size_t cpusetsize, unsigned long *cpus,
>  				 unsigned int flags)
>  {
> -	const struct vdso_data *vd =3D __arch_get_vdso_data();
> -	const struct arch_vdso_time_data *avd =3D &vd->arch_data;
> +	const struct vdso_arch_data *avd =3D &vdso_u_arch_data;
>  	bool all_cpus =3D !cpusetsize && !cpus;
>  	struct riscv_hwprobe *p =3D pairs;
>  	struct riscv_hwprobe *end =3D pairs + pair_count;
> @@ -51,8 +50,7 @@ static int riscv_vdso_get_cpus(struct riscv_hwprobe *pa=
irs, size_t pair_count,
>  			       size_t cpusetsize, unsigned long *cpus,
>  			       unsigned int flags)
>  {
> -	const struct vdso_data *vd =3D __arch_get_vdso_data();
> -	const struct arch_vdso_time_data *avd =3D &vd->arch_data;
> +	const struct vdso_arch_data *avd =3D &vdso_u_arch_data;
>  	struct riscv_hwprobe *p =3D pairs;
>  	struct riscv_hwprobe *end =3D pairs + pair_count;
>  	unsigned char *c =3D (unsigned char *)cpus;
> diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/v=
dso.lds.S
> index cbe2a179331d2511a8b4a26c06383e46131661b1..8e86965a8aae4d7c5a36d0f26=
026cd1c8680b339 100644
> --- a/arch/riscv/kernel/vdso/vdso.lds.S
> +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> @@ -4,15 +4,14 @@
>   */
>  #include <asm/page.h>
>  #include <asm/vdso.h>
> +#include <vdso/datapage.h>
> =20
>  OUTPUT_ARCH(riscv)
> =20
>  SECTIONS
>  {
> -	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
> -#ifdef CONFIG_TIME_NS
> -	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
> -#endif
> +	VDSO_VVAR_SYMS
> +
>  	. =3D SIZEOF_HEADERS;
> =20
>  	.hash		: { *(.hash) }			:text
>=20
> --=20
> 2.47.1
>=20

--5blIZ1Iqus9/6yzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ4Vt/wAKCRB4tDGHoIJi
0lwyAQD+yye8SRzx9pyZXyzt5ruAXg053IJCy0RXsiu2LaPq+QEAwtkD8YlzzacM
TTOqh1wjgshKTebOnUrqL3Hw5Fmv2QI=
=tTC2
-----END PGP SIGNATURE-----

--5blIZ1Iqus9/6yzw--

