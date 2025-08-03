Return-Path: <linux-arch+bounces-13020-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A7B1941A
	for <lists+linux-arch@lfdr.de>; Sun,  3 Aug 2025 15:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED3F175102
	for <lists+linux-arch@lfdr.de>; Sun,  3 Aug 2025 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919F215E8B;
	Sun,  3 Aug 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="PMpQwddE"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF61610B;
	Sun,  3 Aug 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754228041; cv=none; b=p4g9pPuJ5GKTQ/8mpI5Wf6Mvv28/IzI7u3vX8b9hi1KV7IDmKg3kdZPJC0huUqOfXfFCzDNdG7enavbRsxTa2LndkHypFZ7Myr9hE1x/H4yB/R48G0KCSmfwDjiVT4p+A/N154QKls5gbghwexKgkezYDWzOCL7Y3XnXrpacdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754228041; c=relaxed/simple;
	bh=C6poKcSFX0ZHIYPWAuqutRnp5v8WeIC4hXE5E5b6Ru0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CudcdRG7pXzCDAcJARkdd9GRiC2ciOHrde6gD5/dTnMuDPKSxtatGAj8WV+xklSUkzfDGHhIhTwOvEPX9lQXR08rmojzgfzt4eAYUC0X1KeMKYDCSJzBg5JfsFbhos7Jc2/mdh7Q/Bmi3p5u5PVzTJRGkM8pfX2QfihYthi1yKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=PMpQwddE; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BKui5Y1Cxx7K/c9ulHH65bRL/16q8bqUzJeUnYBfMQI=; t=1754228035; x=1754832835; 
	b=PMpQwddEpsQVNK5nhwtp19ebF5g0b+UVS0hFNcuztIRoE5LV3JJmB6ZGllYdJAVPVjQJHp2k305
	i/yV3UzPYpleARHrpfKMzbmLtun4scYQdfi1OmrfzYGB9IiZvV7nddoW6g+0YAc1sKlYcR9/b65Dy
	gKFleKgwnFAiThFwn37An1imsChqOZDVIparFAmyaUstdST2d4YwhaVtlFasSUI3XysvQbQELkmcU
	REcVgl/JDDQiKbkPKxuJT8h476MCwXT+npcBYAS6A9k9swZFCmXR5vZAsesdUHc+uyR0M6CbHEH+o
	7nOmKjfT3jVjnXX6ZCLSm5rt8+ymEmjUVtCQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uiYqW-00000003MKf-0qlV; Sun, 03 Aug 2025 15:33:52 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uiYqV-000000027R3-3LgX; Sun, 03 Aug 2025 15:33:52 +0200
Message-ID: <5d9ab8b51a3281f249f514598c949d2c9ca6d194.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 34/41] sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 sparclinux@vger.kernel.org
Date: Sun, 03 Aug 2025 15:33:50 +0200
In-Reply-To: <20250314071013.1575167-35-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
	 <20250314071013.1575167-35-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Thomas,

On Fri, 2025-03-14 at 08:10 +0100, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize on
> the __ASSEMBLER__ macro that is provided by the compilers now.
>=20
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
>=20
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/sparc/include/asm/adi_64.h         |  4 +-
>  arch/sparc/include/asm/auxio.h          |  4 +-
>  arch/sparc/include/asm/auxio_32.h       |  4 +-
>  arch/sparc/include/asm/auxio_64.h       |  4 +-
>  arch/sparc/include/asm/cacheflush_64.h  |  4 +-
>  arch/sparc/include/asm/cpudata.h        |  4 +-
>  arch/sparc/include/asm/cpudata_64.h     |  4 +-
>  arch/sparc/include/asm/delay_64.h       |  4 +-
>  arch/sparc/include/asm/ftrace.h         |  2 +-
>  arch/sparc/include/asm/hvtramp.h        |  2 +-
>  arch/sparc/include/asm/hypervisor.h     | 92 ++++++++++++-------------
>  arch/sparc/include/asm/irqflags_32.h    |  4 +-
>  arch/sparc/include/asm/irqflags_64.h    |  4 +-
>  arch/sparc/include/asm/jump_label.h     |  4 +-
>  arch/sparc/include/asm/kdebug_32.h      |  4 +-
>  arch/sparc/include/asm/leon.h           |  8 +--
>  arch/sparc/include/asm/leon_amba.h      |  6 +-
>  arch/sparc/include/asm/mman.h           |  4 +-
>  arch/sparc/include/asm/mmu_64.h         |  4 +-
>  arch/sparc/include/asm/mmu_context_32.h |  4 +-
>  arch/sparc/include/asm/mmu_context_64.h |  4 +-
>  arch/sparc/include/asm/mxcc.h           |  4 +-
>  arch/sparc/include/asm/obio.h           |  4 +-
>  arch/sparc/include/asm/openprom.h       |  4 +-
>  arch/sparc/include/asm/page_32.h        |  8 +--
>  arch/sparc/include/asm/page_64.h        |  8 +--
>  arch/sparc/include/asm/pcic.h           |  2 +-
>  arch/sparc/include/asm/pgtable_32.h     |  4 +-
>  arch/sparc/include/asm/pgtable_64.h     |  8 +--
>  arch/sparc/include/asm/pgtsrmmu.h       |  6 +-
>  arch/sparc/include/asm/processor_64.h   | 10 +--
>  arch/sparc/include/asm/psr.h            |  4 +-
>  arch/sparc/include/asm/ptrace.h         | 12 ++--
>  arch/sparc/include/asm/ross.h           |  4 +-
>  arch/sparc/include/asm/sbi.h            |  4 +-
>  arch/sparc/include/asm/sigcontext.h     |  4 +-
>  arch/sparc/include/asm/signal.h         |  6 +-
>  arch/sparc/include/asm/smp_32.h         |  8 +--
>  arch/sparc/include/asm/smp_64.h         |  8 +--
>  arch/sparc/include/asm/spinlock_32.h    |  4 +-
>  arch/sparc/include/asm/spinlock_64.h    |  4 +-
>  arch/sparc/include/asm/spitfire.h       |  4 +-
>  arch/sparc/include/asm/starfire.h       |  2 +-
>  arch/sparc/include/asm/thread_info_32.h |  4 +-
>  arch/sparc/include/asm/thread_info_64.h | 12 ++--
>  arch/sparc/include/asm/trap_block.h     |  4 +-
>  arch/sparc/include/asm/traps.h          |  4 +-
>  arch/sparc/include/asm/tsb.h            |  2 +-
>  arch/sparc/include/asm/ttable.h         |  2 +-
>  arch/sparc/include/asm/turbosparc.h     |  4 +-
>  arch/sparc/include/asm/upa.h            |  4 +-
>  arch/sparc/include/asm/vaddrs.h         |  2 +-
>  arch/sparc/include/asm/viking.h         |  4 +-
>  arch/sparc/include/asm/visasm.h         |  2 +-
>  drivers/char/hw_random/n2rng.h          |  4 +-
>  55 files changed, 172 insertions(+), 172 deletions(-)
>=20
> diff --git a/arch/sparc/include/asm/adi_64.h b/arch/sparc/include/asm/adi=
_64.h
> index 4301c6fd87f7a..0c066fdab6963 100644
> --- a/arch/sparc/include/asm/adi_64.h
> +++ b/arch/sparc/include/asm/adi_64.h
> @@ -9,7 +9,7 @@
> =20
>  #include <linux/types.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  struct adi_caps {
>  	__u64 blksz;
> @@ -41,6 +41,6 @@ static inline unsigned long adi_nbits(void)
>  	return adi_state.caps.nbits;
>  }
> =20
> -#endif	/* __ASSEMBLY__ */
> +#endif	/* __ASSEMBLER__ */
> =20
>  #endif	/* !(__ASM_SPARC64_ADI_H) */
> diff --git a/arch/sparc/include/asm/auxio.h b/arch/sparc/include/asm/auxi=
o.h
> index a2681052e9000..d0a933ed0d04b 100644
> --- a/arch/sparc/include/asm/auxio.h
> +++ b/arch/sparc/include/asm/auxio.h
> @@ -2,11 +2,11 @@
>  #ifndef ___ASM_SPARC_AUXIO_H
>  #define ___ASM_SPARC_AUXIO_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  extern void __iomem *auxio_register;
> =20
> -#endif /* ifndef __ASSEMBLY__ */
> +#endif /* ifndef __ASSEMBLER__ */
> =20
>  #if defined(__sparc__) && defined(__arch64__)
>  #include <asm/auxio_64.h>
> diff --git a/arch/sparc/include/asm/auxio_32.h b/arch/sparc/include/asm/a=
uxio_32.h
> index 852457c7a265a..db58fa28de9ec 100644
> --- a/arch/sparc/include/asm/auxio_32.h
> +++ b/arch/sparc/include/asm/auxio_32.h
> @@ -29,7 +29,7 @@
>  #define AUXIO_FLPY_EJCT   0x02    /* Eject floppy disk.  Write only. */
>  #define AUXIO_LED         0x01    /* On if set, off if unset. Read/Write=
 */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  /*
>   * NOTE: these routines are implementation dependent--
> @@ -75,7 +75,7 @@ do { \
>  	} \
>  } while (0)
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
> =20
>  /* AUXIO2 (Power Off Control) */
> diff --git a/arch/sparc/include/asm/auxio_64.h b/arch/sparc/include/asm/a=
uxio_64.h
> index ae1ed41987db7..8a4ae07daf168 100644
> --- a/arch/sparc/include/asm/auxio_64.h
> +++ b/arch/sparc/include/asm/auxio_64.h
> @@ -74,7 +74,7 @@
>  #define AUXIO_PCIO_CPWR_OFF	0x02 /* Courtesy Power Off	*/
>  #define AUXIO_PCIO_SPWR_OFF	0x01 /* System Power Off	*/
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #define AUXIO_LTE_ON	1
>  #define AUXIO_LTE_OFF	0
> @@ -94,6 +94,6 @@ void auxio_set_lte(int on);
>   */
>  void auxio_set_led(int on);
> =20
> -#endif /* ifndef __ASSEMBLY__ */
> +#endif /* ifndef __ASSEMBLER__ */
> =20
>  #endif /* !(_SPARC64_AUXIO_H) */
> diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/=
asm/cacheflush_64.h
> index 2b1261b77ecd1..06092572c0455 100644
> --- a/arch/sparc/include/asm/cacheflush_64.h
> +++ b/arch/sparc/include/asm/cacheflush_64.h
> @@ -4,7 +4,7 @@
> =20
>  #include <asm/page.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/mm.h>
> =20
> @@ -78,6 +78,6 @@ void flush_ptrace_access(struct vm_area_struct *, struc=
t page *,
>  #define flush_cache_vmap_early(start, end)	do { } while (0)
>  #define flush_cache_vunmap(start, end)		do { } while (0)
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #endif /* _SPARC64_CACHEFLUSH_H */
> diff --git a/arch/sparc/include/asm/cpudata.h b/arch/sparc/include/asm/cp=
udata.h
> index d213165ee713b..67022a153023f 100644
> --- a/arch/sparc/include/asm/cpudata.h
> +++ b/arch/sparc/include/asm/cpudata.h
> @@ -2,14 +2,14 @@
>  #ifndef ___ASM_SPARC_CPUDATA_H
>  #define ___ASM_SPARC_CPUDATA_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/threads.h>
>  #include <linux/percpu.h>
> =20
>  extern const struct seq_operations cpuinfo_op;
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #if defined(__sparc__) && defined(__arch64__)
>  #include <asm/cpudata_64.h>
> diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm=
/cpudata_64.h
> index 9c3fc03abe9ae..056b3c0e7ef94 100644
> --- a/arch/sparc/include/asm/cpudata_64.h
> +++ b/arch/sparc/include/asm/cpudata_64.h
> @@ -7,7 +7,7 @@
>  #ifndef _SPARC64_CPUDATA_H
>  #define _SPARC64_CPUDATA_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  typedef struct {
>  	/* Dcache line 1 */
> @@ -35,7 +35,7 @@ DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
>  #define cpu_data(__cpu)		per_cpu(__cpu_data, (__cpu))
>  #define local_cpu_data()	(*this_cpu_ptr(&__cpu_data))
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #include <asm/trap_block.h>
> =20
> diff --git a/arch/sparc/include/asm/delay_64.h b/arch/sparc/include/asm/d=
elay_64.h
> index 22213b1c119d2..5de5b5f23188c 100644
> --- a/arch/sparc/include/asm/delay_64.h
> +++ b/arch/sparc/include/asm/delay_64.h
> @@ -7,12 +7,12 @@
>  #ifndef _SPARC64_DELAY_H
>  #define _SPARC64_DELAY_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  void __delay(unsigned long loops);
>  void udelay(unsigned long usecs);
>  #define mdelay(n)	udelay((n) * 1000)
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #endif /* _SPARC64_DELAY_H */
> diff --git a/arch/sparc/include/asm/ftrace.h b/arch/sparc/include/asm/ftr=
ace.h
> index e284394cb3aa2..f7c9036199c5e 100644
> --- a/arch/sparc/include/asm/ftrace.h
> +++ b/arch/sparc/include/asm/ftrace.h
> @@ -6,7 +6,7 @@
>  #define MCOUNT_ADDR		((unsigned long)(_mcount))
>  #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  void _mcount(void);
>  #endif
> =20
> diff --git a/arch/sparc/include/asm/hvtramp.h b/arch/sparc/include/asm/hv=
tramp.h
> index ce2453ea4f2be..8cf7a54fa528a 100644
> --- a/arch/sparc/include/asm/hvtramp.h
> +++ b/arch/sparc/include/asm/hvtramp.h
> @@ -2,7 +2,7 @@
>  #ifndef _SPARC64_HVTRAP_H
>  #define _SPARC64_HVTRAP_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/types.h>
> =20
> diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm=
/hypervisor.h
> index f220edcf17c7c..94ac56d43746b 100644
> --- a/arch/sparc/include/asm/hypervisor.h
> +++ b/arch/sparc/include/asm/hypervisor.h
> @@ -102,7 +102,7 @@
>   */
>  #define HV_FAST_MACH_EXIT		0x00
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  void sun4v_mach_exit(unsigned long exit_code);
>  #endif
> =20
> @@ -131,7 +131,7 @@ void sun4v_mach_exit(unsigned long exit_code);
>   */
>  #define HV_FAST_MACH_DESC		0x01
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_mach_desc(unsigned long buffer_pa,
>  			      unsigned long buf_len,
>  			      unsigned long *real_buf_len);
> @@ -152,7 +152,7 @@ unsigned long sun4v_mach_desc(unsigned long buffer_pa=
,
>   */
>  #define HV_FAST_MACH_SIR		0x02
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  void sun4v_mach_sir(void);
>  #endif
> =20
> @@ -208,7 +208,7 @@ void sun4v_mach_sir(void);
>   */
>  #define HV_FAST_MACH_SET_WATCHDOG	0x05
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_mach_set_watchdog(unsigned long timeout,
>  				      unsigned long *orig_timeout);
>  #endif
> @@ -254,7 +254,7 @@ unsigned long sun4v_mach_set_watchdog(unsigned long t=
imeout,
>   */
>  #define HV_FAST_CPU_START		0x10
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_cpu_start(unsigned long cpuid,
>  			      unsigned long pc,
>  			      unsigned long rtba,
> @@ -282,7 +282,7 @@ unsigned long sun4v_cpu_start(unsigned long cpuid,
>   */
>  #define HV_FAST_CPU_STOP		0x11
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_cpu_stop(unsigned long cpuid);
>  #endif
> =20
> @@ -299,7 +299,7 @@ unsigned long sun4v_cpu_stop(unsigned long cpuid);
>   */
>  #define HV_FAST_CPU_YIELD		0x12
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_cpu_yield(void);
>  #endif
> =20
> @@ -317,7 +317,7 @@ unsigned long sun4v_cpu_yield(void);
>   */
>  #define HV_FAST_CPU_POKE                0x13
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_cpu_poke(unsigned long cpuid);
>  #endif
> =20
> @@ -363,7 +363,7 @@ unsigned long sun4v_cpu_poke(unsigned long cpuid);
>  #define  HV_CPU_QUEUE_RES_ERROR		 0x3e
>  #define  HV_CPU_QUEUE_NONRES_ERROR	 0x3f
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_cpu_qconf(unsigned long type,
>  			      unsigned long queue_paddr,
>  			      unsigned long num_queue_entries);
> @@ -416,7 +416,7 @@ unsigned long sun4v_cpu_qconf(unsigned long type,
>   */
>  #define HV_FAST_CPU_MONDO_SEND		0x42
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_cpu_mondo_send(unsigned long cpu_count,
>  				   unsigned long cpu_list_pa,
>  				   unsigned long mondo_block_pa);
> @@ -449,7 +449,7 @@ unsigned long sun4v_cpu_mondo_send(unsigned long cpu_=
count,
>  #define  HV_CPU_STATE_RUNNING		 0x02
>  #define  HV_CPU_STATE_ERROR		 0x03
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  long sun4v_cpu_state(unsigned long cpuid);
>  #endif
> =20
> @@ -485,7 +485,7 @@ long sun4v_cpu_state(unsigned long cpuid);
>   *
>   * Layout of a TSB description for mmu_tsb_ctx{,non}0() calls.
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct hv_tsb_descr {
>  	unsigned short		pgsz_idx;
>  	unsigned short		assoc;
> @@ -536,7 +536,7 @@ struct hv_tsb_descr {
>   * The fault status block is a multiple of 64-bytes and must be aligned
>   * on a 64-byte boundary.
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct hv_fault_status {
>  	unsigned long		i_fault_type;
>  	unsigned long		i_fault_addr;
> @@ -651,7 +651,7 @@ struct hv_fault_status {
>   */
>  #define HV_FAST_MMU_TSB_CTX0		0x20
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_mmu_tsb_ctx0(unsigned long num_descriptions,
>  				 unsigned long tsb_desc_ra);
>  #endif
> @@ -736,7 +736,7 @@ unsigned long sun4v_mmu_tsb_ctx0(unsigned long num_de=
scriptions,
>   */
>  #define HV_FAST_MMU_DEMAP_ALL		0x24
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  void sun4v_mmu_demap_all(void);
>  #endif
> =20
> @@ -766,7 +766,7 @@ void sun4v_mmu_demap_all(void);
>   */
>  #define HV_FAST_MMU_MAP_PERM_ADDR	0x25
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_mmu_map_perm_addr(unsigned long vaddr,
>  				      unsigned long set_to_zero,
>  				      unsigned long tte,
> @@ -990,7 +990,7 @@ unsigned long sun4v_mmu_map_perm_addr(unsigned long v=
addr,
>   */
> =20
>  #define HV_CCB_SUBMIT               0x34
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_ccb_submit(unsigned long ccb_buf,
>  			       unsigned long len,
>  			       unsigned long flags,
> @@ -1035,7 +1035,7 @@ unsigned long sun4v_ccb_submit(unsigned long ccb_bu=
f,
>   */
> =20
>  #define HV_CCB_INFO                 0x35
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_ccb_info(unsigned long ca,
>  			     void *info_arr);
>  #endif
> @@ -1069,7 +1069,7 @@ unsigned long sun4v_ccb_info(unsigned long ca,
>   */
> =20
>  #define HV_CCB_KILL                 0x36
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_ccb_kill(unsigned long ca,
>  			     void *kill_status);
>  #endif
> @@ -1104,7 +1104,7 @@ unsigned long sun4v_ccb_kill(unsigned long ca,
>   */
>  #define HV_FAST_TOD_GET			0x50
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_tod_get(unsigned long *time);
>  #endif
> =20
> @@ -1121,7 +1121,7 @@ unsigned long sun4v_tod_get(unsigned long *time);
>   */
>  #define HV_FAST_TOD_SET			0x51
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_tod_set(unsigned long time);
>  #endif
> =20
> @@ -1197,7 +1197,7 @@ unsigned long sun4v_tod_set(unsigned long time);
>   */
>  #define HV_FAST_CONS_WRITE		0x63
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  long sun4v_con_getchar(long *status);
>  long sun4v_con_putchar(long c);
>  long sun4v_con_read(unsigned long buffer,
> @@ -1239,7 +1239,7 @@ unsigned long sun4v_con_write(unsigned long buffer,
>  #define  HV_SOFT_STATE_NORMAL		 0x01
>  #define  HV_SOFT_STATE_TRANSITION	 0x02
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_mach_set_soft_state(unsigned long soft_state,
>  				        unsigned long msg_string_ra);
>  #endif
> @@ -1318,7 +1318,7 @@ unsigned long sun4v_mach_set_soft_state(unsigned lo=
ng soft_state,
>   */
>  #define HV_FAST_SVC_CLRSTATUS		0x84
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_svc_send(unsigned long svc_id,
>  			     unsigned long buffer,
>  			     unsigned long buffer_size,
> @@ -1348,7 +1348,7 @@ unsigned long sun4v_svc_clrstatus(unsigned long svc=
_id,
>   * start (offset 0) of the trap trace buffer, and is described as
>   * follows:
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct hv_trap_trace_control {
>  	unsigned long		head_offset;
>  	unsigned long		tail_offset;
> @@ -1367,7 +1367,7 @@ struct hv_trap_trace_control {
>   *
>   * Each trap trace buffer entry is laid out as follows:
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct hv_trap_trace_entry {
>  	unsigned char	type;		/* Hypervisor or guest entry?	*/
>  	unsigned char	hpstate;	/* Hyper-privileged state	*/
> @@ -1617,7 +1617,7 @@ struct hv_trap_trace_entry {
>   */
>  #define HV_FAST_INTR_DEVINO2SYSINO	0xa0
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_devino_to_sysino(unsigned long devhandle,
>  				     unsigned long devino);
>  #endif
> @@ -1635,7 +1635,7 @@ unsigned long sun4v_devino_to_sysino(unsigned long =
devhandle,
>   */
>  #define HV_FAST_INTR_GETENABLED		0xa1
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_intr_getenabled(unsigned long sysino);
>  #endif
> =20
> @@ -1651,7 +1651,7 @@ unsigned long sun4v_intr_getenabled(unsigned long s=
ysino);
>   */
>  #define HV_FAST_INTR_SETENABLED		0xa2
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_intr_setenabled(unsigned long sysino,
>  				    unsigned long intr_enabled);
>  #endif
> @@ -1668,7 +1668,7 @@ unsigned long sun4v_intr_setenabled(unsigned long s=
ysino,
>   */
>  #define HV_FAST_INTR_GETSTATE		0xa3
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_intr_getstate(unsigned long sysino);
>  #endif
> =20
> @@ -1688,7 +1688,7 @@ unsigned long sun4v_intr_getstate(unsigned long sys=
ino);
>   */
>  #define HV_FAST_INTR_SETSTATE		0xa4
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_intr_setstate(unsigned long sysino, unsigned long in=
tr_state);
>  #endif
> =20
> @@ -1706,7 +1706,7 @@ unsigned long sun4v_intr_setstate(unsigned long sys=
ino, unsigned long intr_state
>   */
>  #define HV_FAST_INTR_GETTARGET		0xa5
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_intr_gettarget(unsigned long sysino);
>  #endif
> =20
> @@ -1723,7 +1723,7 @@ unsigned long sun4v_intr_gettarget(unsigned long sy=
sino);
>   */
>  #define HV_FAST_INTR_SETTARGET		0xa6
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_intr_settarget(unsigned long sysino, unsigned long c=
puid);
>  #endif
> =20
> @@ -1807,7 +1807,7 @@ unsigned long sun4v_intr_settarget(unsigned long sy=
sino, unsigned long cpuid);
>   */
>  #define HV_FAST_VINTR_SET_TARGET	0xae
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_vintr_get_cookie(unsigned long dev_handle,
>  				     unsigned long dev_ino,
>  				     unsigned long *cookie);
> @@ -3047,7 +3047,7 @@ unsigned long sun4v_vintr_set_target(unsigned long =
dev_handle,
>  #define LDC_MTE_SZ64K	0x0000000000000001 /* 64K page           */
>  #define LDC_MTE_SZ8K	0x0000000000000000 /* 8K page            */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct ldc_mtable_entry {
>  	unsigned long	mte;
>  	unsigned long	cookie;
> @@ -3130,7 +3130,7 @@ struct ldc_mtable_entry {
>   */
>  #define HV_FAST_LDC_REVOKE		0xef
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_ldc_tx_qconf(unsigned long channel,
>  				 unsigned long ra,
>  				 unsigned long num_entries);
> @@ -3230,7 +3230,7 @@ unsigned long sun4v_ldc_revoke(unsigned long channe=
l,
>  #define HV_FAST_N2_GET_PERFREG		0x104
>  #define HV_FAST_N2_SET_PERFREG		0x105
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_niagara_getperf(unsigned long reg,
>  				    unsigned long *val);
>  unsigned long sun4v_niagara_setperf(unsigned long reg,
> @@ -3247,7 +3247,7 @@ unsigned long sun4v_niagara2_setperf(unsigned long =
reg,
>   * a buffer where these statistics can be collected.  It is continually
>   * updated once configured.  The layout is as follows:
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct hv_mmu_statistics {
>  	unsigned long immu_tsb_hits_ctx0_8k_tte;
>  	unsigned long immu_tsb_ticks_ctx0_8k_tte;
> @@ -3332,7 +3332,7 @@ struct hv_mmu_statistics {
>   */
>  #define HV_FAST_MMUSTAT_INFO		0x103
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_mmustat_conf(unsigned long ra, unsigned long *orig_r=
a);
>  unsigned long sun4v_mmustat_info(unsigned long *ra);
>  #endif
> @@ -3343,7 +3343,7 @@ unsigned long sun4v_mmustat_info(unsigned long *ra)=
;
>  #define HV_NCS_QCONF			0x01
>  #define HV_NCS_QTAIL_UPDATE		0x02
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct hv_ncs_queue_entry {
>  	/* MAU Control Register */
>  	unsigned long	mau_control;
> @@ -3422,7 +3422,7 @@ struct hv_ncs_qtail_update_arg {
>   */
>  #define HV_FAST_NCS_REQUEST		0x110
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_ncs_request(unsigned long request,
>  			        unsigned long arg_ra,
>  			        unsigned long arg_size);
> @@ -3433,7 +3433,7 @@ unsigned long sun4v_ncs_request(unsigned long reque=
st,
> =20
>  #define HV_FAST_REBOOT_DATA_SET		0x172
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_reboot_data_set(unsigned long ra,
>  				    unsigned long len);
>  #endif
> @@ -3441,7 +3441,7 @@ unsigned long sun4v_reboot_data_set(unsigned long r=
a,
>  #define HV_FAST_VT_GET_PERFREG		0x184
>  #define HV_FAST_VT_SET_PERFREG		0x185
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_vt_get_perfreg(unsigned long reg_num,
>  				   unsigned long *reg_val);
>  unsigned long sun4v_vt_set_perfreg(unsigned long reg_num,
> @@ -3451,7 +3451,7 @@ unsigned long sun4v_vt_set_perfreg(unsigned long re=
g_num,
>  #define	HV_FAST_T5_GET_PERFREG		0x1a8
>  #define	HV_FAST_T5_SET_PERFREG		0x1a9
> =20
> -#ifndef	__ASSEMBLY__
> +#ifndef	__ASSEMBLER__
>  unsigned long sun4v_t5_get_perfreg(unsigned long reg_num,
>  				   unsigned long *reg_val);
>  unsigned long sun4v_t5_set_perfreg(unsigned long reg_num,
> @@ -3462,7 +3462,7 @@ unsigned long sun4v_t5_set_perfreg(unsigned long re=
g_num,
>  #define HV_FAST_M7_GET_PERFREG	0x43
>  #define HV_FAST_M7_SET_PERFREG	0x44
> =20
> -#ifndef	__ASSEMBLY__
> +#ifndef	__ASSEMBLER__
>  unsigned long sun4v_m7_get_perfreg(unsigned long reg_num,
>  				      unsigned long *reg_val);
>  unsigned long sun4v_m7_set_perfreg(unsigned long reg_num,
> @@ -3506,7 +3506,7 @@ unsigned long sun4v_m7_set_perfreg(unsigned long re=
g_num,
>  #define HV_GRP_T5_CPU			0x0211
>  #define HV_GRP_DIAG			0x0300
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  unsigned long sun4v_get_version(unsigned long group,
>  			        unsigned long *major,
>  			        unsigned long *minor);
> diff --git a/arch/sparc/include/asm/irqflags_32.h b/arch/sparc/include/as=
m/irqflags_32.h
> index 7ca3eaf3dace9..f5f20774faac1 100644
> --- a/arch/sparc/include/asm/irqflags_32.h
> +++ b/arch/sparc/include/asm/irqflags_32.h
> @@ -11,7 +11,7 @@
>  #ifndef _ASM_IRQFLAGS_H
>  #define _ASM_IRQFLAGS_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/types.h>
>  #include <asm/psr.h>
> @@ -43,6 +43,6 @@ static inline notrace bool arch_irqs_disabled(void)
>  	return arch_irqs_disabled_flags(arch_local_save_flags());
>  }
> =20
> -#endif /* (__ASSEMBLY__) */
> +#endif /* (__ASSEMBLER__) */
> =20
>  #endif /* !(_ASM_IRQFLAGS_H) */
> diff --git a/arch/sparc/include/asm/irqflags_64.h b/arch/sparc/include/as=
m/irqflags_64.h
> index c29ed571ae49e..0071566c2c223 100644
> --- a/arch/sparc/include/asm/irqflags_64.h
> +++ b/arch/sparc/include/asm/irqflags_64.h
> @@ -13,7 +13,7 @@
> =20
>  #include <asm/pil.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  static inline notrace unsigned long arch_local_save_flags(void)
>  {
> @@ -93,6 +93,6 @@ static inline notrace unsigned long arch_local_irq_save=
(void)
>  	return flags;
>  }
> =20
> -#endif /* (__ASSEMBLY__) */
> +#endif /* (__ASSEMBLER__) */
> =20
>  #endif /* !(_ASM_IRQFLAGS_H) */
> diff --git a/arch/sparc/include/asm/jump_label.h b/arch/sparc/include/asm=
/jump_label.h
> index 2718cbea826a7..f49d1e6104e11 100644
> --- a/arch/sparc/include/asm/jump_label.h
> +++ b/arch/sparc/include/asm/jump_label.h
> @@ -2,7 +2,7 @@
>  #ifndef _ASM_SPARC_JUMP_LABEL_H
>  #define _ASM_SPARC_JUMP_LABEL_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/types.h>
> =20
> @@ -48,5 +48,5 @@ struct jump_entry {
>  	jump_label_t key;
>  };
> =20
> -#endif  /* __ASSEMBLY__ */
> +#endif  /* __ASSEMBLER__ */
>  #endif
> diff --git a/arch/sparc/include/asm/kdebug_32.h b/arch/sparc/include/asm/=
kdebug_32.h
> index 763d423823bdd..7627701a032cf 100644
> --- a/arch/sparc/include/asm/kdebug_32.h
> +++ b/arch/sparc/include/asm/kdebug_32.h
> @@ -19,7 +19,7 @@
> =20
>  #define DEBUG_BP_TRAP     126
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  /* The debug vector is passed in %o1 at boot time.  It is a pointer to
>   * a structure in the debuggers address space.  Here is its format.
>   */
> @@ -64,7 +64,7 @@ enum die_val {
>  	DIE_OOPS,
>  };
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  /* Some nice offset defines for assembler code. */
>  #define KDEBUG_ENTRY_OFF    0x0
> diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.=
h
> index c1e05e4ab9e35..053a24b67aeda 100644
> --- a/arch/sparc/include/asm/leon.h
> +++ b/arch/sparc/include/asm/leon.h
> @@ -59,7 +59,7 @@
>  #define ASI_LEON3_SYSCTRL_CFG_SNOOPING (1 << 27)
>  #define ASI_LEON3_SYSCTRL_CFG_SSIZE(c) (1 << ((c >> 20) & 0xf))
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  /* do a physical address bypass write, i.e. for 0x80000000 */
>  static inline void leon_store_reg(unsigned long paddr, unsigned long val=
ue)
> @@ -132,7 +132,7 @@ static inline int sparc_leon3_cpuid(void)
>  	return sparc_leon3_asr17() >> 28;
>  }
> =20
> -#endif /*!__ASSEMBLY__*/
> +#endif /*!__ASSEMBLER__*/
> =20
>  #ifdef CONFIG_SMP
>  # define LEON3_IRQ_IPI_DEFAULT		13
> @@ -194,7 +194,7 @@ static inline int sparc_leon3_cpuid(void)
>  #define LEON2_CCR_DSETS_MASK 0x03000000UL
>  #define LEON2_CFG_SSIZE_MASK 0x00007000UL
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct vm_area_struct;
> =20
>  unsigned long leon_swprobe(unsigned long vaddr, unsigned long *paddr);
> @@ -247,7 +247,7 @@ extern int leon_ipi_irq;
> =20
>  #endif /* CONFIG_SMP */
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
>  /* macros used in leon_mm.c */
>  #define PFN(x)           ((x) >> PAGE_SHIFT)
> diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/=
leon_amba.h
> index 6433a93f51264..2ff5714d7a63a 100644
> --- a/arch/sparc/include/asm/leon_amba.h
> +++ b/arch/sparc/include/asm/leon_amba.h
> @@ -8,7 +8,7 @@
>  #ifndef LEON_AMBA_H_INCLUDE
>  #define LEON_AMBA_H_INCLUDE
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  struct amba_prom_registers {
>  	unsigned int phys_addr;	/* The physical address of this register */
> @@ -89,7 +89,7 @@ struct amba_prom_registers {
>  #define LEON3_GPTIMER_CONFIG_NRTIMERS(c) ((c)->config & 0x7)
>  #define LEON3_GPTIMER_CTRL_ISPENDING(r)  (((r)&LEON3_GPTIMER_CTRL_PENDIN=
G) ? 1 : 0)
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  struct leon3_irqctrl_regs_map {
>  	u32 ilevel;
> @@ -189,7 +189,7 @@ extern int leon_debug_irqout;
>  extern unsigned long leon3_gptimer_irq;
>  extern unsigned int sparc_leon_eirq;
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
>  #define LEON3_IO_AREA 0xfff00000
>  #define LEON3_CONF_AREA 0xff000
> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.=
h
> index af9c10c83dc58..0ae05fbdc023e 100644
> --- a/arch/sparc/include/asm/mman.h
> +++ b/arch/sparc/include/asm/mman.h
> @@ -4,7 +4,7 @@
> =20
>  #include <uapi/asm/mman.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #define arch_mmap_check(addr,len,flags)	sparc_mmap_check(addr,len)
>  int sparc_mmap_check(unsigned long addr, unsigned long len);
> =20
> @@ -87,5 +87,5 @@ static inline bool arch_validate_flags(unsigned long vm=
_flags)
>  }
>  #endif /* CONFIG_SPARC64 */
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* __SPARC_MMAN_H__ */
> diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu=
_64.h
> index 7e2704c770e9f..4eeb938f3e61c 100644
> --- a/arch/sparc/include/asm/mmu_64.h
> +++ b/arch/sparc/include/asm/mmu_64.h
> @@ -59,7 +59,7 @@
>  #define CTX_HWBITS(__ctx)	((__ctx.sparc64_ctx_val) & CTX_HW_MASK)
>  #define CTX_NRBITS(__ctx)	((__ctx.sparc64_ctx_val) & CTX_NR_MASK)
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #define TSB_ENTRY_ALIGNMENT	16
> =20
> @@ -117,7 +117,7 @@ typedef struct {
>  	spinlock_t		tag_lock;
>  } mm_context_t;
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #define TSB_CONFIG_TSB		0x00
>  #define TSB_CONFIG_RSS_LIMIT	0x08
> diff --git a/arch/sparc/include/asm/mmu_context_32.h b/arch/sparc/include=
/asm/mmu_context_32.h
> index 509043f815602..d9ff73f776f93 100644
> --- a/arch/sparc/include/asm/mmu_context_32.h
> +++ b/arch/sparc/include/asm/mmu_context_32.h
> @@ -2,7 +2,7 @@
>  #ifndef __SPARC_MMU_CONTEXT_H
>  #define __SPARC_MMU_CONTEXT_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <asm-generic/mm_hooks.h>
> =20
> @@ -29,6 +29,6 @@ void switch_mm(struct mm_struct *old_mm, struct mm_stru=
ct *mm,
> =20
>  #include <asm-generic/mmu_context.h>
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(__SPARC_MMU_CONTEXT_H) */
> diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include=
/asm/mmu_context_64.h
> index 08160bf9a0f41..78bbacc14d2d9 100644
> --- a/arch/sparc/include/asm/mmu_context_64.h
> +++ b/arch/sparc/include/asm/mmu_context_64.h
> @@ -4,7 +4,7 @@
> =20
>  /* Derived heavily from Linus's Alpha/AXP ASN code... */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/spinlock.h>
>  #include <linux/mm_types.h>
> @@ -193,6 +193,6 @@ static inline unsigned long mm_untag_mask(struct mm_s=
truct *mm)
> =20
>  #include <asm-generic/mmu_context.h>
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(__SPARC64_MMU_CONTEXT_H) */
> diff --git a/arch/sparc/include/asm/mxcc.h b/arch/sparc/include/asm/mxcc.=
h
> index 3a2561bea4dd4..bd6339dcf693d 100644
> --- a/arch/sparc/include/asm/mxcc.h
> +++ b/arch/sparc/include/asm/mxcc.h
> @@ -84,7 +84,7 @@
>   * MID: The moduleID of the cpu your read this from.
>   */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  static inline void mxcc_set_stream_src(unsigned long *paddr)
>  {
> @@ -133,6 +133,6 @@ static inline void mxcc_set_creg(unsigned long mxcc_c=
ontrol)
>  			     "i" (ASI_M_MXCC));
>  }
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #endif /* !(_SPARC_MXCC_H) */
> diff --git a/arch/sparc/include/asm/obio.h b/arch/sparc/include/asm/obio.=
h
> index 1b151f738b00e..f1ad7f7bcac23 100644
> --- a/arch/sparc/include/asm/obio.h
> +++ b/arch/sparc/include/asm/obio.h
> @@ -97,7 +97,7 @@
>  #define CC_EREG		0x1F00E00  /* Error code register */
>  #define CC_CID		0x1F00F04  /* Component ID */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  static inline int bw_get_intr_mask(int sbus_level)
>  {
> @@ -221,6 +221,6 @@ static inline void cc_set_igen(unsigned int gen)
>  			      "i" (ASI_M_MXCC));
>  }
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #endif /* !(_SPARC_OBIO_H) */
> diff --git a/arch/sparc/include/asm/openprom.h b/arch/sparc/include/asm/o=
penprom.h
> index 69545b3e54547..ce68000dffac3 100644
> --- a/arch/sparc/include/asm/openprom.h
> +++ b/arch/sparc/include/asm/openprom.h
> @@ -11,7 +11,7 @@
>  /* Empirical constants... */
>  #define LINUX_OPPROM_MAGIC      0x10010407
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <linux/of.h>
> =20
>  /* V0 prom device operations. */
> @@ -275,6 +275,6 @@ struct linux_prom_pci_intmask {
>  	unsigned int interrupt;
>  };
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(__SPARC_OPENPROM_H) */
> diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/pa=
ge_32.h
> index 9954254ea5698..c1bccbedf567e 100644
> --- a/arch/sparc/include/asm/page_32.h
> +++ b/arch/sparc/include/asm/page_32.h
> @@ -13,7 +13,7 @@
> =20
>  #include <vdso/page.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #define clear_page(page)	 memset((void *)(page), 0, PAGE_SIZE)
>  #define copy_page(to,from) 	memcpy((void *)(to), (void *)(from), PAGE_SI=
ZE)
> @@ -108,14 +108,14 @@ typedef pte_t *pgtable_t;
> =20
>  #define TASK_UNMAPPED_BASE	0x50000000
> =20
> -#else /* !(__ASSEMBLY__) */
> +#else /* !(__ASSEMBLER__) */
> =20
>  #define __pgprot(x)	(x)
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #define PAGE_OFFSET	0xf0000000
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  extern unsigned long phys_base;
>  extern unsigned long pfn_base;
>  #endif
> diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/pa=
ge_64.h
> index 2a68ff5b6eabd..d764d8a8586bd 100644
> --- a/arch/sparc/include/asm/page_64.h
> +++ b/arch/sparc/include/asm/page_64.h
> @@ -30,7 +30,7 @@
>  #define HUGE_MAX_HSTATE		5
>  #endif
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
>  struct pt_regs;
> @@ -128,7 +128,7 @@ extern unsigned long sparc64_va_hole_bottom;
> =20
>  extern unsigned long PAGE_OFFSET;
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  /* The maximum number of physical memory address bits we support.  The
>   * largest value we can support is whatever "KPGD_SHIFT + KPTE_BITS"
> @@ -139,7 +139,7 @@ extern unsigned long PAGE_OFFSET;
>  #define ILOG2_4MB		22
>  #define ILOG2_256MB		28
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
>  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
> @@ -153,7 +153,7 @@ extern unsigned long PAGE_OFFSET;
>  #define virt_to_phys __pa
>  #define phys_to_virt __va
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #include <asm-generic/getorder.h>
> =20
> diff --git a/arch/sparc/include/asm/pcic.h b/arch/sparc/include/asm/pcic.=
h
> index 238376b1ffcc4..fb5ed6a59535a 100644
> --- a/arch/sparc/include/asm/pcic.h
> +++ b/arch/sparc/include/asm/pcic.h
> @@ -8,7 +8,7 @@
>  #ifndef __SPARC_PCIC_H
>  #define __SPARC_PCIC_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/types.h>
>  #include <linux/smp.h>
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm=
/pgtable_32.h
> index 62bcafe38b1f6..ff11ee1831786 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -21,7 +21,7 @@
>  #define PGDIR_MASK      	(~(PGDIR_SIZE-1))
>  #define PGDIR_ALIGN(__addr) 	(((__addr) + ~PGDIR_MASK) & PGDIR_MASK)
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <asm-generic/pgtable-nopud.h>
> =20
>  #include <linux/spinlock.h>
> @@ -428,7 +428,7 @@ static inline int io_remap_pfn_range(struct vm_area_s=
truct *vma,
>  	__changed;							  \
>  })
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #define VMALLOC_START           _AC(0xfe600000,UL)
>  #define VMALLOC_END             _AC(0xffc00000,UL)
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm=
/pgtable_64.h
> index 2b7f358762c18..f1ce04744df8c 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -79,7 +79,7 @@
>  #error PMD_SHIFT must equal HPAGE_SHIFT for transparent huge pages.
>  #endif
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  extern unsigned long VMALLOC_END;
> =20
> @@ -106,7 +106,7 @@ bool kern_addr_valid(unsigned long addr);
>  	pr_err("%s:%d: bad pgd %p(%016lx) seen at (%pS)\n",		\
>  	       __FILE__, __LINE__, &(e), pgd_val(e), __builtin_return_address(0=
))
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  /* PTE bits which are the same in SUN4U and SUN4V format.  */
>  #define _PAGE_VALID	  _AC(0x8000000000000000,UL) /* Valid TTE           =
 */
> @@ -191,7 +191,7 @@ bool kern_addr_valid(unsigned long addr);
>  /* We borrow bit 20 to store the exclusive marker in swap PTEs. */
>  #define _PAGE_SWP_EXCLUSIVE	_AC(0x0000000000100000, UL)
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  pte_t mk_pte_io(unsigned long, pgprot_t, int, unsigned long);
> =20
> @@ -1181,6 +1181,6 @@ extern unsigned long pte_leaf_size(pte_t pte);
> =20
>  #endif /* CONFIG_HUGETLB_PAGE */
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(_SPARC64_PGTABLE_H) */
> diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/p=
gtsrmmu.h
> index 18e68d43f0367..a265822a475ee 100644
> --- a/arch/sparc/include/asm/pgtsrmmu.h
> +++ b/arch/sparc/include/asm/pgtsrmmu.h
> @@ -10,7 +10,7 @@
> =20
>  #include <asm/page.h>
> =20
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
>  #include <asm/thread_info.h>	/* TI_UWINMASK for WINDOW_FLUSH */
>  #endif
> =20
> @@ -97,7 +97,7 @@
>  	bne	99b;							\
>  	 restore %g0, %g0, %g0;
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  extern unsigned long last_valid_pfn;
> =20
>  /* This makes sense. Honest it does - Anton */
> @@ -136,6 +136,6 @@ srmmu_get_pte (unsigned long addr)
>  	return entry;
>  }
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(_SPARC_PGTSRMMU_H) */
> diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/a=
sm/processor_64.h
> index 0a0d5c3d184c7..321859454ca4c 100644
> --- a/arch/sparc/include/asm/processor_64.h
> +++ b/arch/sparc/include/asm/processor_64.h
> @@ -21,7 +21,7 @@
>   * XXX No longer using virtual page tables, kill this upper limit...
>   */
>  #define VA_BITS		44
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #define VPTE_SIZE	(1UL << (VA_BITS - PAGE_SHIFT + 3))
>  #else
>  #define VPTE_SIZE	(1 << (VA_BITS - PAGE_SHIFT + 3))
> @@ -45,7 +45,7 @@
> =20
>  #endif
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  /* The Sparc processor specific thread struct. */
>  /* XXX This should die, everything can go into thread_info now. */
> @@ -62,7 +62,7 @@ struct thread_struct {
>  #endif
>  };
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #ifndef CONFIG_DEBUG_SPINLOCK
>  #define INIT_THREAD  {			\
> @@ -75,7 +75,7 @@ struct thread_struct {
>  }
>  #endif /* !(CONFIG_DEBUG_SPINLOCK) */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/types.h>
>  #include <asm/fpumacro.h>
> @@ -242,6 +242,6 @@ static inline void prefetchw(const void *x)
> =20
>  int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_in=
sn_trap);
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(__ASM_SPARC64_PROCESSOR_H) */
> diff --git a/arch/sparc/include/asm/psr.h b/arch/sparc/include/asm/psr.h
> index 65127ce565abc..5af50ccda0233 100644
> --- a/arch/sparc/include/asm/psr.h
> +++ b/arch/sparc/include/asm/psr.h
> @@ -14,7 +14,7 @@
>  #include <uapi/asm/psr.h>
> =20
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  /* Get the %psr register. */
>  static inline unsigned int get_psr(void)
>  {
> @@ -63,6 +63,6 @@ static inline unsigned int get_fsr(void)
>  	return fsr;
>  }
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(__LINUX_SPARC_PSR_H) */
> diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptr=
ace.h
> index d1419e6690274..8adf3fd2f00fe 100644
> --- a/arch/sparc/include/asm/ptrace.h
> +++ b/arch/sparc/include/asm/ptrace.h
> @@ -5,7 +5,7 @@
>  #include <uapi/asm/ptrace.h>
> =20
>  #if defined(__sparc__) && defined(__arch64__)
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/compiler.h>
>  #include <linux/threads.h>
> @@ -113,10 +113,10 @@ static inline unsigned long kernel_stack_pointer(st=
ruct pt_regs *regs)
>  {
>  	return regs->u_regs[UREG_I6];
>  }
> -#else /* __ASSEMBLY__ */
> -#endif /* __ASSEMBLY__ */
> +#else /* __ASSEMBLER__ */
> +#endif /* __ASSEMBLER__ */
>  #else /* (defined(__sparc__) && defined(__arch64__)) */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <asm/switch_to.h>
> =20
>  static inline bool pt_regs_is_syscall(struct pt_regs *regs)
> @@ -144,8 +144,8 @@ static inline bool pt_regs_clear_syscall(struct pt_re=
gs *regs)
>  #define instruction_pointer(regs) ((regs)->pc)
>  #define user_stack_pointer(regs) ((regs)->u_regs[UREG_FP])
>  unsigned long profile_pc(struct pt_regs *);
> -#else /* (!__ASSEMBLY__) */
> -#endif /* (!__ASSEMBLY__) */
> +#else /* (!__ASSEMBLER__) */
> +#endif /* (!__ASSEMBLER__) */
>  #endif /* (defined(__sparc__) && defined(__arch64__)) */
>  #define STACK_BIAS		2047
> =20
> diff --git a/arch/sparc/include/asm/ross.h b/arch/sparc/include/asm/ross.=
h
> index 79a54d66a2c0b..53a42b37495d0 100644
> --- a/arch/sparc/include/asm/ross.h
> +++ b/arch/sparc/include/asm/ross.h
> @@ -95,7 +95,7 @@
>  #define HYPERSPARC_ICCR_FTD     0x00000002
>  #define HYPERSPARC_ICCR_ICE     0x00000001
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  static inline unsigned int get_ross_icr(void)
>  {
> @@ -187,6 +187,6 @@ static inline void hyper_flush_cache_page(unsigned lo=
ng page)
>  	}
>  }
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(_SPARC_ROSS_H) */
> diff --git a/arch/sparc/include/asm/sbi.h b/arch/sparc/include/asm/sbi.h
> index 4d6026c1e446f..861f85b5bf9bb 100644
> --- a/arch/sparc/include/asm/sbi.h
> +++ b/arch/sparc/include/asm/sbi.h
> @@ -64,7 +64,7 @@ struct sbi_regs {
>   */
> =20
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  static inline int acquire_sbi(int devid, int mask)
>  {
> @@ -111,6 +111,6 @@ static inline void set_sbi_ctl(int devid, int cfgno, =
int cfg)
>  			      "i" (ASI_M_CTL));
>  }
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #endif /* !(_SPARC_SBI_H) */
> diff --git a/arch/sparc/include/asm/sigcontext.h b/arch/sparc/include/asm=
/sigcontext.h
> index ee05f9d2bcf2c..200f95144fd29 100644
> --- a/arch/sparc/include/asm/sigcontext.h
> +++ b/arch/sparc/include/asm/sigcontext.h
> @@ -5,7 +5,7 @@
>  #include <asm/ptrace.h>
>  #include <uapi/asm/sigcontext.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #define __SUNOS_MAXWIN   31
> =20
> @@ -104,6 +104,6 @@ typedef struct {
>  #endif /* (CONFIG_SPARC64) */
> =20
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(__SPARC_SIGCONTEXT_H) */
> diff --git a/arch/sparc/include/asm/signal.h b/arch/sparc/include/asm/sig=
nal.h
> index 28f81081e37da..d93fe93544ec6 100644
> --- a/arch/sparc/include/asm/signal.h
> +++ b/arch/sparc/include/asm/signal.h
> @@ -2,16 +2,16 @@
>  #ifndef __SPARC_SIGNAL_H
>  #define __SPARC_SIGNAL_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <linux/personality.h>
>  #include <linux/types.h>
>  #endif
>  #include <uapi/asm/signal.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #define __ARCH_HAS_KA_RESTORER
>  #define __ARCH_HAS_SA_RESTORER
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
>  #endif /* !(__SPARC_SIGNAL_H) */
> diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp=
_32.h
> index 2cf7971d7f6c9..9c6ed98fbaf12 100644
> --- a/arch/sparc/include/asm/smp_32.h
> +++ b/arch/sparc/include/asm/smp_32.h
> @@ -10,15 +10,15 @@
>  #include <linux/threads.h>
>  #include <asm/head.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/cpumask.h>
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
>  #ifdef CONFIG_SMP
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <asm/ptrace.h>
>  #include <asm/asi.h>
> @@ -105,7 +105,7 @@ int hard_smp_processor_id(void);
> =20
>  void smp_setup_cpu_possible_map(void);
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  /* Sparc specific messages. */
>  #define MSG_CROSS_CALL         0x0005       /* run func on cpus */
> diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp=
_64.h
> index 0964fede0b2cc..759fb4a9530ed 100644
> --- a/arch/sparc/include/asm/smp_64.h
> +++ b/arch/sparc/include/asm/smp_64.h
> @@ -12,16 +12,16 @@
>  #include <asm/starfire.h>
>  #include <asm/spitfire.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/cpumask.h>
>  #include <linux/cache.h>
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #ifdef CONFIG_SMP
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  /*
>   *	Private routines/data
> @@ -68,7 +68,7 @@ int __cpu_disable(void);
>  void __cpu_die(unsigned int cpu);
>  #endif
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #else
> =20
> diff --git a/arch/sparc/include/asm/spinlock_32.h b/arch/sparc/include/as=
m/spinlock_32.h
> index bc5aa6f616764..6d6d261bf8d2f 100644
> --- a/arch/sparc/include/asm/spinlock_32.h
> +++ b/arch/sparc/include/asm/spinlock_32.h
> @@ -7,7 +7,7 @@
>  #ifndef __SPARC_SPINLOCK_H
>  #define __SPARC_SPINLOCK_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <asm/psr.h>
>  #include <asm/barrier.h>
> @@ -183,6 +183,6 @@ static inline int __arch_read_trylock(arch_rwlock_t *=
rw)
>  	res; \
>  })
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* __SPARC_SPINLOCK_H */
> diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/as=
m/spinlock_64.h
> index 3a9a0b0c74654..13cd15d346be4 100644
> --- a/arch/sparc/include/asm/spinlock_64.h
> +++ b/arch/sparc/include/asm/spinlock_64.h
> @@ -7,13 +7,13 @@
>  #ifndef __SPARC64_SPINLOCK_H
>  #define __SPARC64_SPINLOCK_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <asm/processor.h>
>  #include <asm/barrier.h>
>  #include <asm/qspinlock.h>
>  #include <asm/qrwlock.h>
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* !(__SPARC64_SPINLOCK_H) */
> diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/s=
pitfire.h
> index e9b7d25b29fae..79b9dd5e9ac68 100644
> --- a/arch/sparc/include/asm/spitfire.h
> +++ b/arch/sparc/include/asm/spitfire.h
> @@ -68,7 +68,7 @@
>  #define CPU_ID_M8		('8')
>  #define CPU_ID_SONOMA1		('N')
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  enum ultra_tlb_layout {
>  	spitfire =3D 0,
> @@ -363,6 +363,6 @@ static inline void cheetah_put_itlb_data(int entry, u=
nsigned long data)
>  			       "i" (ASI_ITLB_DATA_ACCESS));
>  }
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
>  #endif /* CONFIG_SPARC64 */
>  #endif /* !(_SPARC64_SPITFIRE_H) */
> diff --git a/arch/sparc/include/asm/starfire.h b/arch/sparc/include/asm/s=
tarfire.h
> index fb1a8c499cb03..8e511ed787755 100644
> --- a/arch/sparc/include/asm/starfire.h
> +++ b/arch/sparc/include/asm/starfire.h
> @@ -8,7 +8,7 @@
>  #ifndef _SPARC64_STARFIRE_H
>  #define _SPARC64_STARFIRE_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  extern int this_is_starfire;
> =20
> diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include=
/asm/thread_info_32.h
> index 45b4955b253f2..fdaf7b171e0ac 100644
> --- a/arch/sparc/include/asm/thread_info_32.h
> +++ b/arch/sparc/include/asm/thread_info_32.h
> @@ -14,7 +14,7 @@
> =20
>  #ifdef __KERNEL__
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <asm/ptrace.h>
>  #include <asm/page.h>
> @@ -72,7 +72,7 @@ register struct thread_info *current_thread_info_reg as=
m("g6");
>   */
>  #define THREAD_SIZE_ORDER  1
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
>  /* Size of kernel stack for each process */
>  #define THREAD_SIZE		(2 * PAGE_SIZE)
> diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include=
/asm/thread_info_64.h
> index 1a44372e2bc07..c8a73dff27f80 100644
> --- a/arch/sparc/include/asm/thread_info_64.h
> +++ b/arch/sparc/include/asm/thread_info_64.h
> @@ -26,7 +26,7 @@
> =20
>  #include <asm/page.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <asm/ptrace.h>
>  #include <asm/types.h>
> @@ -64,7 +64,7 @@ struct thread_info {
>  		__attribute__ ((aligned(64)));
>  };
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  /* offsets into the thread_info struct for assembly code access */
>  #define TI_TASK		0x00000000
> @@ -110,7 +110,7 @@ struct thread_info {
>  /*
>   * macros/functions for gaining access to the thread information structu=
re
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #define INIT_THREAD_INFO(tsk)				\
>  {							\
> @@ -150,7 +150,7 @@ extern struct thread_info *current_thread_info(void);
>  #define set_thread_fpdepth(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYT=
E_FPDEPTH] =3D (val))
>  #define get_thread_wsaved()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_WS=
AVED])
>  #define set_thread_wsaved(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE=
_WSAVED] =3D (val))
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  /*
>   * Thread information flags, only 16 bits are available as we encode
> @@ -228,14 +228,14 @@ extern struct thread_info *current_thread_info(void=
);
>   * Note that there are only 8 bits available.
>   */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #define thread32_stack_is_64bit(__SP) (((__SP) & 0x1) !=3D 0)
>  #define test_thread_64bit_stack(__SP) \
>  	((test_thread_flag(TIF_32BIT) && !thread32_stack_is_64bit(__SP)) ? \
>  	 false : true)
> =20
> -#endif	/* !__ASSEMBLY__ */
> +#endif	/* !__ASSEMBLER__ */
> =20
>  #endif /* __KERNEL__ */
> =20
> diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm=
/trap_block.h
> index ace0d48e837e5..6cf2a60a0156d 100644
> --- a/arch/sparc/include/asm/trap_block.h
> +++ b/arch/sparc/include/asm/trap_block.h
> @@ -7,7 +7,7 @@
>  #include <asm/hypervisor.h>
>  #include <asm/asi.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  /* Trap handling code needs to get at a few critical values upon
>   * trap entry and to process TSB misses.  These cannot be in the
> @@ -91,7 +91,7 @@ extern struct sun4v_2insn_patch_entry __sun_m7_2insn_pa=
tch,
>  	__sun_m7_2insn_patch_end;
> =20
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #define TRAP_PER_CPU_THREAD		0x00
>  #define TRAP_PER_CPU_PGD_PADDR		0x08
> diff --git a/arch/sparc/include/asm/traps.h b/arch/sparc/include/asm/trap=
s.h
> index 2fba2602ba69c..e4e10b0e7887d 100644
> --- a/arch/sparc/include/asm/traps.h
> +++ b/arch/sparc/include/asm/traps.h
> @@ -9,7 +9,7 @@
> =20
>  #include <uapi/asm/traps.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  /* This is for V8 compliant Sparc CPUS */
>  struct tt_entry {
>  	unsigned long inst_one;
> @@ -21,5 +21,5 @@ struct tt_entry {
>  /* We set this to _start in system setup. */
>  extern struct tt_entry *sparc_ttable;
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
>  #endif /* !(_SPARC_TRAPS_H) */
> diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
> index 522a677e050d7..239be259e1669 100644
> --- a/arch/sparc/include/asm/tsb.h
> +++ b/arch/sparc/include/asm/tsb.h
> @@ -59,7 +59,7 @@
>   * The kernel TSB is locked into the TLB by virtue of being in the
>   * kernel image, so we don't play these games for swapper_tsb access.
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct tsb_ldquad_phys_patch_entry {
>  	unsigned int	addr;
>  	unsigned int	sun4u_insn;
> diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/tta=
ble.h
> index 8f64694080198..b32d3068cce12 100644
> --- a/arch/sparc/include/asm/ttable.h
> +++ b/arch/sparc/include/asm/ttable.h
> @@ -5,7 +5,7 @@
>  #include <asm/utrap.h>
>  #include <asm/pil.h>
> =20
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
>  #include <asm/thread_info.h>
>  #endif
> =20
> diff --git a/arch/sparc/include/asm/turbosparc.h b/arch/sparc/include/asm=
/turbosparc.h
> index 23df777f9cea5..5f73263b6ded8 100644
> --- a/arch/sparc/include/asm/turbosparc.h
> +++ b/arch/sparc/include/asm/turbosparc.h
> @@ -57,7 +57,7 @@
>  #define TURBOSPARC_WTENABLE 0x00000020	 /* Write thru for dcache */
>  #define TURBOSPARC_SNENABLE 0x40000000	 /* DVMA snoop enable */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  /* Bits [13:5] select one of 512 instruction cache tags */
>  static inline void turbosparc_inv_insn_tag(unsigned long addr)
> @@ -121,6 +121,6 @@ static inline unsigned long turbosparc_get_ccreg(void=
)
>  	return regval;
>  }
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #endif /* !(_SPARC_TURBOSPARC_H) */
> diff --git a/arch/sparc/include/asm/upa.h b/arch/sparc/include/asm/upa.h
> index 782691b30f545..b1df3a7f40ed0 100644
> --- a/arch/sparc/include/asm/upa.h
> +++ b/arch/sparc/include/asm/upa.h
> @@ -24,7 +24,7 @@
>  #define UPA_PORTID_ID           0x000000000000ffff /* Module Identificat=
ion bits  */
> =20
>  /* UPA I/O space accessors */
> -#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
> +#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
>  static inline unsigned char _upa_readb(unsigned long addr)
>  {
>  	unsigned char ret;
> @@ -105,6 +105,6 @@ static inline void _upa_writeq(unsigned long q, unsig=
ned long addr)
>  #define upa_writew(__w, __addr)		(_upa_writew((__w), (unsigned long)(__a=
ddr)))
>  #define upa_writel(__l, __addr)		(_upa_writel((__l), (unsigned long)(__a=
ddr)))
>  #define upa_writeq(__q, __addr)		(_upa_writeq((__q), (unsigned long)(__a=
ddr)))
> -#endif /* __KERNEL__ && !__ASSEMBLY__ */
> +#endif /* __KERNEL__ && !__ASSEMBLER__ */
> =20
>  #endif /* !(_SPARC64_UPA_H) */
> diff --git a/arch/sparc/include/asm/vaddrs.h b/arch/sparc/include/asm/vad=
drs.h
> index 4fec0341e2a81..da567600c8974 100644
> --- a/arch/sparc/include/asm/vaddrs.h
> +++ b/arch/sparc/include/asm/vaddrs.h
> @@ -31,7 +31,7 @@
>   */
>  #define SRMMU_NOCACHE_ALCRATIO	64	/* 256 pages per 64MB of system RAM */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <asm/kmap_size.h>
> =20
>  enum fixed_addresses {
> diff --git a/arch/sparc/include/asm/viking.h b/arch/sparc/include/asm/vik=
ing.h
> index 08ffc605035f3..bbb714de43c42 100644
> --- a/arch/sparc/include/asm/viking.h
> +++ b/arch/sparc/include/asm/viking.h
> @@ -110,7 +110,7 @@
>  #define VIKING_PTAG_DIRTY   0x00010000   /* Block has been modified */
>  #define VIKING_PTAG_SHARED  0x00000100   /* Shared with some other cache=
 */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  static inline void viking_flush_icache(void)
>  {
> @@ -250,6 +250,6 @@ static inline unsigned long viking_hwprobe(unsigned l=
ong vaddr)
>  	return val;
>  }
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #endif /* !(_SPARC_VIKING_H) */
> diff --git a/arch/sparc/include/asm/visasm.h b/arch/sparc/include/asm/vis=
asm.h
> index 7903e84e09e05..71eb4e9afb3e0 100644
> --- a/arch/sparc/include/asm/visasm.h
> +++ b/arch/sparc/include/asm/visasm.h
> @@ -45,7 +45,7 @@
>  #define VISExitHalfFast					\
>  	wr		%o5, 0, %fprs;
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  static inline void save_and_clear_fpu(void) {
>  	__asm__ __volatile__ (
>  "		rd %%fprs, %%o5\n"
> diff --git a/drivers/char/hw_random/n2rng.h b/drivers/char/hw_random/n2rn=
g.h
> index 9a870f5dc3712..7612f15a261fe 100644
> --- a/drivers/char/hw_random/n2rng.h
> +++ b/drivers/char/hw_random/n2rng.h
> @@ -48,7 +48,7 @@
> =20
>  #define HV_RNG_NUM_CONTROL		4
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  extern unsigned long sun4v_rng_get_diag_ctl(void);
>  extern unsigned long sun4v_rng_ctl_read_v1(unsigned long ctl_regs_ra,
>  					   unsigned long *state,
> @@ -147,6 +147,6 @@ struct n2rng {
>  #define N2RNG_BUSY_LIMIT	100
>  #define N2RNG_HCHECK_LIMIT	100
> =20
> -#endif /* !(__ASSEMBLY__) */
> +#endif /* !(__ASSEMBLER__) */
> =20
>  #endif /* _N2RNG_H */

This causes the kernel build to fail:

  CC [M]  drivers/gpu/drm/nouveau/nv04_fence.o
  CC [M]  drivers/gpu/drm/nouveau/nv10_fence.o
  CC [M]  drivers/gpu/drm/nouveau/nv17_fence.o
  CC [M]  drivers/gpu/drm/nouveau/nv50_fence.o
  CC [M]  drivers/gpu/drm/nouveau/nv84_fence.o
  CC [M]  drivers/gpu/drm/nouveau/nvc0_fence.o
  LD [M]  drivers/gpu/drm/nouveau/nouveau.o
  AR      drivers/gpu/built-in.a
  AR      drivers/built-in.a
make: *** [Makefile:2026: .] Error 2
glaubitz@node54:/data/home/glaubitz/linux> make
  CALL    scripts/checksyscalls.sh
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  AS      arch/sparc/kernel/head_64.o
./arch/sparc/include/uapi/asm/ptrace.h: Assembler messages:
./arch/sparc/include/uapi/asm/ptrace.h:22: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/ptrace.h:23: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:24: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:25: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:26: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:27: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:40: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:41: Error: junk at end of line, firs=
t unrecognized character is `}'
./arch/sparc/include/uapi/asm/ptrace.h:43: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/ptrace.h:44: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:45: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:46: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:47: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:48: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:49: Error: junk at end of line, firs=
t unrecognized character is `}'
./arch/sparc/include/uapi/asm/ptrace.h:52: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/ptrace.h:53: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:54: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:55: Error: junk at end of line, firs=
t unrecognized character is `}'
./arch/sparc/include/uapi/asm/ptrace.h:58: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/ptrace.h:59: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:60: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:61: Error: junk at end of line, firs=
t unrecognized character is `}'
./arch/sparc/include/uapi/asm/ptrace.h:64: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/ptrace.h:65: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:66: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:67: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/ptrace.h:68: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:69: Error: Unknown opcode: `char'
./arch/sparc/include/uapi/asm/ptrace.h:70: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:71: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:72: Error: junk at end of line, firs=
t unrecognized character is `}'
./arch/sparc/include/uapi/asm/ptrace.h:75: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/ptrace.h:76: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:77: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:78: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:79: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:80: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:81: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:82: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:83: Error: junk at end of line, firs=
t unrecognized character is `}'
./arch/sparc/include/uapi/asm/ptrace.h:85: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/ptrace.h:86: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:87: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:88: Error: Unknown opcode: `unsigned=
'
./arch/sparc/include/uapi/asm/ptrace.h:89: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/ptrace.h:90: Error: junk at end of line, firs=
t unrecognized character is `}'
./arch/sparc/include/uapi/asm/signal.h:110: Error: Unknown opcode: `typedef=
'
./arch/sparc/include/uapi/asm/signal.h:112: Error: Unknown opcode: `typedef=
'
./arch/sparc/include/uapi/asm/signal.h:113: Error: Unknown opcode: `unsigne=
d'
./arch/sparc/include/uapi/asm/signal.h:114: Error: junk at end of line, fir=
st unrecognized character is `}'
./arch/sparc/include/uapi/asm/signal.h:117: Error: Unknown opcode: `struct'
./arch/sparc/include/uapi/asm/signal.h:119: Error: Unknown opcode: `char'
./arch/sparc/include/uapi/asm/signal.h:120: Error: Unknown opcode: `int'
./arch/sparc/include/uapi/asm/signal.h:121: Error: junk at end of line, fir=
st unrecognized character is `}'
./arch/sparc/include/uapi/asm/posix_types.h:14: Error: Unknown opcode: `typ=
edef'
./arch/sparc/include/uapi/asm/posix_types.h:15: Error: Unknown opcode: `typ=
edef'
./arch/sparc/include/uapi/asm/posix_types.h:19: Error: Unknown opcode: `typ=
edef'
./arch/sparc/include/uapi/asm/posix_types.h:22: Error: Unknown opcode: `typ=
edef'
./arch/sparc/include/uapi/asm/posix_types.h:23: Error: Unknown opcode: `typ=
edef'
./arch/sparc/include/uapi/asm/posix_types.h:26: Error: Unknown opcode: `str=
uct'
./arch/sparc/include/uapi/asm/posix_types.h:27: Error: Unknown opcode: `__k=
ernel_long_t tv_sec'
./arch/sparc/include/uapi/asm/posix_types.h:28: Error: Unknown opcode: `__k=
ernel_suseconds_t tv_usec'
./arch/sparc/include/uapi/asm/posix_types.h:29: Error: junk at end of line,=
 first unrecognized character is `}'
./include/uapi/asm-generic/posix_types.h:20: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:24: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:28: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:32: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:36: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:37: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:45: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:49: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:50: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:59: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:72: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:73: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:74: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:79: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:80: Error: Unknown opcode: `int'
./include/uapi/asm-generic/posix_types.h:81: Error: junk at end of line, fi=
rst unrecognized character is `}'
./include/uapi/asm-generic/posix_types.h:87: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:88: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:89: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:93: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:94: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:95: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:96: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:97: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:98: Error: Unknown opcode: `typede=
f'
./include/uapi/asm-generic/posix_types.h:99: Error: Unknown opcode: `typede=
f'
./arch/sparc/include/uapi/asm/signal.h:172: Error: Unknown opcode: `typedef=
'
./arch/sparc/include/uapi/asm/signal.h:173: Error: Unknown opcode: `void'
./arch/sparc/include/uapi/asm/signal.h:174: Error: Unknown opcode: `int'
./arch/sparc/include/uapi/asm/signal.h:175: Error: Unknown opcode: `__kerne=
l_size_t ss_size'
./arch/sparc/include/uapi/asm/signal.h:176: Error: junk at end of line, fir=
st unrecognized character is `}'
./arch/sparc/include/uapi/asm/utrap.h:48: Error: Unknown opcode: `typedef'
./arch/sparc/include/uapi/asm/utrap.h:49: Error: Unknown opcode: `typedef'
arch/sparc/kernel/head_64.S:709: Error: found '(', expected: ')'
arch/sparc/kernel/head_64.S:709: Error: Illegal operands
arch/sparc/kernel/etrap_64.S:41: Error: Illegal operands
arch/sparc/kernel/etrap_64.S:48: Error: found '(', expected: ')'
arch/sparc/kernel/etrap_64.S:48: Error: Expression inside %hi could not be =
parsed
arch/sparc/kernel/etrap_64.S:50: Error: found '(', expected: ')'
arch/sparc/kernel/etrap_64.S:50: Error: Expression inside %lo could not be =
parsed
arch/sparc/kernel/etrap_64.S:57: Error: Illegal operands
arch/sparc/kernel/etrap_64.S:59: Error: Illegal operands
arch/sparc/kernel/etrap_64.S:61: Error: Illegal operands
arch/sparc/kernel/etrap_64.S:63: Error: Illegal operands
arch/sparc/kernel/etrap_64.S:66: Error: Illegal operands
arch/sparc/kernel/etrap_64.S:144: Error: found '(', expected: ')'
arch/sparc/kernel/etrap_64.S:144: Error: Illegal operands
arch/sparc/kernel/etrap_64.S:145: Error: found '(', expected: ')'
(...)
arch/sparc/kernel/ttable_64.S:243: Error: Illegal operands
arch/sparc/kernel/ttable_64.S:243: Error: found '(', expected: ')'
arch/sparc/kernel/ttable_64.S:243: Error: Illegal operands
arch/sparc/kernel/ttable_64.S:243: Error: found '(', expected: ')'
arch/sparc/kernel/ttable_64.S:243: Error: Illegal operands
arch/sparc/kernel/etrap_64.S:48: Error: can't resolve L0 - sizeof
arch/sparc/kernel/etrap_64.S:50: Error: can't resolve L0 - sizeof
make[3]: *** [scripts/Makefile.build:374: arch/sparc/kernel/head_64.o] Erro=
r 1
make[2]: *** [scripts/Makefile.build:494: arch/sparc/kernel] Error 2
make[1]: *** [scripts/Makefile.build:494: arch/sparc] Error 2
make: *** [Makefile:2026: .] Error 2

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

