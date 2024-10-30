Return-Path: <linux-arch+bounces-8724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D099B5E25
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 09:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195531C2138E
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7906E1E1324;
	Wed, 30 Oct 2024 08:45:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83866190486;
	Wed, 30 Oct 2024 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277954; cv=none; b=odyGpV+ggVCzs0jd0hEXMvd2QcMOgIp9zoxptkSqHhl43JK4dpCHKNb3L/6hqIOF0DHwjeU5YNUqLY1Fs+TljlzBzGtxN1ZRlxZUiynPRE1CNWocXarUR+NggkDU3y5jRuOX0kQ78oNjTk3dYitklme9j+j++E4neoTYCnWRsjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277954; c=relaxed/simple;
	bh=KiS8/A7H+BpbLA7WifTR9v99Xtw24pJxGu4EYpC8VOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2+UGZIhomP57zP7c1kCk6Zqy1AYpfN0eX5OKNDx/WWg13fQJObYMnDRgz1NtVqKtsfbxkXPqwvUbRzrtqwCTOnFB/lS15wMXM0eOF8Xcc5V9BzlVYvFePOgzAqTdWJpfE6pFHucvdoyfrWLU8j16NACDIMS/6U7k8vAKIihSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A737113E;
	Wed, 30 Oct 2024 01:46:13 -0700 (PDT)
Received: from [10.57.89.111] (unknown [10.57.89.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B1993F73B;
	Wed, 30 Oct 2024 01:45:34 -0700 (PDT)
Message-ID: <e33a8ead-ca36-4570-92ac-b27708f50023@arm.com>
Date: Wed, 30 Oct 2024 08:45:32 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/57] mm: Add macros ahead of supporting boot-time
 page size selection
Content-Language: en-GB
To: "David S. Miller" <davem@davemloft.net>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Chris Zankel <chris@zankel.net>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg Marsden <greg.marsden@oracle.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Ivan Ivanov <ivan.ivanov@suse.com>, Johannes Berg
 <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonas Bonn <jonas@southpole.se>, Kalesh Singh <kaleshsingh@google.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Miroslav Benes <mbenes@suse.cz>, Rich Felker <dalias@libc.org>,
 Richard Weinberger <richard@nod.at>, Stafford Horne <shorne@gmail.com>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org
Cc: linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all (especially mm people!),


On 14/10/2024 11:58, Ryan Roberts wrote:
> arm64 can support multiple base page sizes. Instead of selecting a page
> size at compile time, as is done today, we will make it possible to
> select the desired page size on the command line.
> 
> In this case PAGE_SHIFT and it's derivatives, PAGE_SIZE and PAGE_MASK
> (as well as a number of other macros related to or derived from
> PAGE_SHIFT, but I'm not worrying about those yet), are no longer
> compile-time constants. So the code base needs to cope with that.
> 
> As a first step, introduce MIN and MAX variants of these macros, which
> express the range of possible page sizes. These are always compile-time
> constants and can be used in many places where PAGE_[SHIFT|SIZE|MASK]
> were previously used where a compile-time constant is required.
> (Subsequent patches will do that conversion work). When the arch/build
> doesn't support boot-time page size selection, the MIN and MAX variants
> are equal and everything resolves as it did previously.
> 
> Additionally, introduce DEFINE_GLOBAL_PAGE_SIZE_VAR[_CONST]() which wrap
> global variable defintions so that for boot-time page size selection
> builds, the variable being wrapped is initialized at boot-time, instead
> of compile-time. This is done by defining a function to do the
> assignment, which has the "constructor" attribute. Constructor is
> preferred over initcall, because when compiling a module, the module is
> limited to a single initcall but constructors are unlimited. For
> built-in code, constructors are now called earlier to guarrantee that
> the variables are initialized by the time they are used. Any arch that
> wants to enable boot-time page size selection will need to select
> CONFIG_CONSTRUCTORS.
> 
> These new macros need to be available anywhere PAGE_SHIFT and friends
> are available. Those are defined via asm/page.h (although some arches
> have a sub-include that defines them). Unfortunately there is no
> reliable asm-generic header we can easily piggy-back on, so let's define
> a new one, pgtable-geometry.h, which we include near where each arch
> defines PAGE_SHIFT. Ugh.

I haven't had any feedback on this particular patch yet. It would be great to
get this one into v6.13, since once this is in place, the changes in other
subsystems can go via their respective trees without any dependency issues.
Although time is getting tight.

If anyone has any feedback for this patch it would be great to hear it now. Then
I'll re-post on it's own in a couple of days time.

Thanks,
Ryan


> 
> -------
> 
> Most of the problems that need to be solved over the next few patches
> fall into these broad categories, which are all solved with the help of
> these new macros:
> 
> 1. Assignment of values derived from PAGE_SIZE in global variables
> 
>   For boot-time page size builds, we must defer the initialization of
>   these variables until boot-time, when the page size is known. See
>   DEFINE_GLOBAL_PAGE_SIZE_VAR[_CONST]() as described above.
> 
> 2. Define static storage in units related to PAGE_SIZE
> 
>   This static storage will be defined according to PAGE_SIZE_MAX.
> 
> 3. Define size of struct so that it is related to PAGE_SIZE
> 
>   The struct often contains an array that is sized to fill the page. In
>   this case, use a flexible array with dynamic allocation. In other
>   cases, the struct fits exactly over a page, which is a header (e.g.
>   swap file header). In this case, remove the padding, and manually
>   determine the struct pointer within the page.
> 
> 4. BUILD_BUG_ON() with values derived from PAGE_SIZE
> 
>   In most cases, we can change these to compare againt the appropriate
>   limit (either MIN or MAX). In other cases, we must change these to
>   run-time BUG_ON().
> 
> 5. Ensure page alignment of static data structures
> 
>   Align instead to PAGE_SIZE_MAX.
> 
> 6. #ifdeffery based on PAGE_SIZE
> 
>   Often these can be changed to c code constructs. e.g. a macro that
>   returns a different value depending on page size can be changed to use
>   the ternary operator and the compiler will dead code strip it for the
>   compile-time constant case and runtime evaluate it for the non-const
>   case. Or #if/#else/#endif within a function can be converted to c
>   if/else blocks, which are also dead code stripped for the const case.
>   Sometimes we can change the c-preprocessor logic to use the
>   appropriate MIN/MAX limit.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  arch/alpha/include/asm/page.h          |  1 +
>  arch/arc/include/asm/page.h            |  1 +
>  arch/arm/include/asm/page.h            |  1 +
>  arch/arm64/include/asm/page-def.h      |  2 +
>  arch/csky/include/asm/page.h           |  3 ++
>  arch/hexagon/include/asm/page.h        |  2 +
>  arch/loongarch/include/asm/page.h      |  2 +
>  arch/m68k/include/asm/page.h           |  1 +
>  arch/microblaze/include/asm/page.h     |  1 +
>  arch/mips/include/asm/page.h           |  1 +
>  arch/nios2/include/asm/page.h          |  2 +
>  arch/openrisc/include/asm/page.h       |  1 +
>  arch/parisc/include/asm/page.h         |  1 +
>  arch/powerpc/include/asm/page.h        |  2 +
>  arch/riscv/include/asm/page.h          |  1 +
>  arch/s390/include/asm/page.h           |  1 +
>  arch/sh/include/asm/page.h             |  1 +
>  arch/sparc/include/asm/page.h          |  3 ++
>  arch/um/include/asm/page.h             |  2 +
>  arch/x86/include/asm/page_types.h      |  2 +
>  arch/xtensa/include/asm/page.h         |  1 +
>  include/asm-generic/pgtable-geometry.h | 71 ++++++++++++++++++++++++++
>  init/main.c                            |  5 +-
>  23 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 include/asm-generic/pgtable-geometry.h
> 
> diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
> index 70419e6be1a35..d0096fb5521b8 100644
> --- a/arch/alpha/include/asm/page.h
> +++ b/arch/alpha/include/asm/page.h
> @@ -88,5 +88,6 @@ typedef struct page *pgtable_t;
>  
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #endif /* _ALPHA_PAGE_H */
> diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
> index def0dfb95b436..8d56549db7a33 100644
> --- a/arch/arc/include/asm/page.h
> +++ b/arch/arc/include/asm/page.h
> @@ -6,6 +6,7 @@
>  #define __ASM_ARC_PAGE_H
>  
>  #include <uapi/asm/page.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #ifdef CONFIG_ARC_HAS_PAE40
>  
> diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
> index 62af9f7f9e963..417aa8533c718 100644
> --- a/arch/arm/include/asm/page.h
> +++ b/arch/arm/include/asm/page.h
> @@ -191,5 +191,6 @@ extern int pfn_valid(unsigned long);
>  
>  #include <asm-generic/getorder.h>
>  #include <asm-generic/memory_model.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #endif
> diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
> index 792e9fe881dcf..d69971cf49cd2 100644
> --- a/arch/arm64/include/asm/page-def.h
> +++ b/arch/arm64/include/asm/page-def.h
> @@ -15,4 +15,6 @@
>  #define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
>  #define PAGE_MASK		(~(PAGE_SIZE-1))
>  
> +#include <asm-generic/pgtable-geometry.h>
> +
>  #endif /* __ASM_PAGE_DEF_H */
> diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
> index 0ca6c408c07f2..95173d57adc8b 100644
> --- a/arch/csky/include/asm/page.h
> +++ b/arch/csky/include/asm/page.h
> @@ -92,4 +92,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>  #include <asm-generic/getorder.h>
>  
>  #endif /* !__ASSEMBLY__ */
> +
> +#include <asm-generic/pgtable-geometry.h>
> +
>  #endif /* __ASM_CSKY_PAGE_H */
> diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
> index 8a6af57274c2d..ba7ad5231695f 100644
> --- a/arch/hexagon/include/asm/page.h
> +++ b/arch/hexagon/include/asm/page.h
> @@ -139,4 +139,6 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>  #endif /* ifdef __ASSEMBLY__ */
>  #endif /* ifdef __KERNEL__ */
>  
> +#include <asm-generic/pgtable-geometry.h>
> +
>  #endif
> diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
> index e85df33f11c77..9862e8fb047a6 100644
> --- a/arch/loongarch/include/asm/page.h
> +++ b/arch/loongarch/include/asm/page.h
> @@ -123,4 +123,6 @@ extern int __virt_addr_valid(volatile void *kaddr);
>  
>  #endif /* !__ASSEMBLY__ */
>  
> +#include <asm-generic/pgtable-geometry.h>
> +
>  #endif /* _ASM_PAGE_H */
> diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
> index 8cfb84b499751..4df4681b02194 100644
> --- a/arch/m68k/include/asm/page.h
> +++ b/arch/m68k/include/asm/page.h
> @@ -60,5 +60,6 @@ extern unsigned long _ramend;
>  
>  #include <asm-generic/getorder.h>
>  #include <asm-generic/memory_model.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #endif /* _M68K_PAGE_H */
> diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> index 8810f4f1c3b02..abc23c3d743bd 100644
> --- a/arch/microblaze/include/asm/page.h
> +++ b/arch/microblaze/include/asm/page.h
> @@ -142,5 +142,6 @@ static inline const void *pfn_to_virt(unsigned long pfn)
>  
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #endif /* _ASM_MICROBLAZE_PAGE_H */
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index 4609cb0326cf3..3d91021538f02 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -227,5 +227,6 @@ static inline unsigned long kaslr_offset(void)
>  
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #endif /* _ASM_PAGE_H */
> diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
> index 0722f88e63cc7..2e5f93beb42b7 100644
> --- a/arch/nios2/include/asm/page.h
> +++ b/arch/nios2/include/asm/page.h
> @@ -97,4 +97,6 @@ extern struct page *mem_map;
>  
>  #endif /* !__ASSEMBLY__ */
>  
> +#include <asm-generic/pgtable-geometry.h>
> +
>  #endif /* _ASM_NIOS2_PAGE_H */
> diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
> index 1d5913f67c312..a0da2a9842241 100644
> --- a/arch/openrisc/include/asm/page.h
> +++ b/arch/openrisc/include/asm/page.h
> @@ -88,5 +88,6 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>  
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #endif /* __ASM_OPENRISC_PAGE_H */
> diff --git a/arch/parisc/include/asm/page.h b/arch/parisc/include/asm/page.h
> index 4bea2e95798f0..2a75496237c09 100644
> --- a/arch/parisc/include/asm/page.h
> +++ b/arch/parisc/include/asm/page.h
> @@ -173,6 +173,7 @@ extern int npmem_ranges;
>  
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> +#include <asm-generic/pgtable-geometry.h>
>  #include <asm/pdc.h>
>  
>  #define PAGE0   ((struct zeropage *)absolute_pointer(__PAGE_OFFSET))
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 83d0a4fc5f755..4601c115b6485 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -300,4 +300,6 @@ static inline unsigned long kaslr_offset(void)
>  #include <asm-generic/memory_model.h>
>  #endif /* __ASSEMBLY__ */
>  
> +#include <asm-generic/pgtable-geometry.h>
> +
>  #endif /* _ASM_POWERPC_PAGE_H */
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 7ede2111c5917..e5af7579e45bf 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -204,5 +204,6 @@ static __always_inline void *pfn_to_kaddr(unsigned long pfn)
>  
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #endif /* _ASM_RISCV_PAGE_H */
> diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
> index 16e4caa931f1f..42157e7690a77 100644
> --- a/arch/s390/include/asm/page.h
> +++ b/arch/s390/include/asm/page.h
> @@ -275,6 +275,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>  
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #define AMODE31_SIZE		(3 * PAGE_SIZE)
>  
> diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
> index f780b467e75d7..09533d46ef033 100644
> --- a/arch/sh/include/asm/page.h
> +++ b/arch/sh/include/asm/page.h
> @@ -162,5 +162,6 @@ typedef struct page *pgtable_t;
>  
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> +#include <asm-generic/pgtable-geometry.h>
>  
>  #endif /* __ASM_SH_PAGE_H */
> diff --git a/arch/sparc/include/asm/page.h b/arch/sparc/include/asm/page.h
> index 5e44cdf2a8f2b..4327fe2bfa010 100644
> --- a/arch/sparc/include/asm/page.h
> +++ b/arch/sparc/include/asm/page.h
> @@ -9,4 +9,7 @@
>  #else
>  #include <asm/page_32.h>
>  #endif
> +
> +#include <asm-generic/pgtable-geometry.h>
> +
>  #endif
> diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
> index 9ef9a8aedfa66..f26011808f514 100644
> --- a/arch/um/include/asm/page.h
> +++ b/arch/um/include/asm/page.h
> @@ -119,4 +119,6 @@ extern unsigned long uml_physmem;
>  #define __HAVE_ARCH_GATE_AREA 1
>  #endif
>  
> +#include <asm-generic/pgtable-geometry.h>
> +
>  #endif	/* __UM_PAGE_H */
> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
> index 52f1b4ff0cc16..6d2381342047f 100644
> --- a/arch/x86/include/asm/page_types.h
> +++ b/arch/x86/include/asm/page_types.h
> @@ -71,4 +71,6 @@ extern void initmem_init(void);
>  
>  #endif	/* !__ASSEMBLY__ */
>  
> +#include <asm-generic/pgtable-geometry.h>
> +
>  #endif	/* _ASM_X86_PAGE_DEFS_H */
> diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
> index 4db56ef052d22..86952cb32af23 100644
> --- a/arch/xtensa/include/asm/page.h
> +++ b/arch/xtensa/include/asm/page.h
> @@ -200,4 +200,5 @@ static inline unsigned long ___pa(unsigned long va)
>  #endif /* __ASSEMBLY__ */
>  
>  #include <asm-generic/memory_model.h>
> +#include <asm-generic/pgtable-geometry.h>
>  #endif /* _XTENSA_PAGE_H */
> diff --git a/include/asm-generic/pgtable-geometry.h b/include/asm-generic/pgtable-geometry.h
> new file mode 100644
> index 0000000000000..358e729a6ac37
> --- /dev/null
> +++ b/include/asm-generic/pgtable-geometry.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ASM_GENERIC_PGTABLE_GEOMETRY_H
> +#define ASM_GENERIC_PGTABLE_GEOMETRY_H
> +
> +#if   defined(PAGE_SHIFT_MAX) && defined(PAGE_SIZE_MAX) && defined(PAGE_MASK_MAX) && \
> +      defined(PAGE_SHIFT_MIN) && defined(PAGE_SIZE_MIN) && defined(PAGE_MASK_MIN)
> +/* Arch supports boot-time page size selection. */
> +#elif defined(PAGE_SHIFT_MAX) || defined(PAGE_SIZE_MAX) || defined(PAGE_MASK_MAX) || \
> +      defined(PAGE_SHIFT_MIN) || defined(PAGE_SIZE_MIN) || defined(PAGE_MASK_MIN)
> +#error Arch must define all or none of the boot-time page size macros
> +#else
> +/* Arch does not support boot-time page size selection. */
> +#define PAGE_SHIFT_MIN	PAGE_SHIFT
> +#define PAGE_SIZE_MIN	PAGE_SIZE
> +#define PAGE_MASK_MIN	PAGE_MASK
> +#define PAGE_SHIFT_MAX	PAGE_SHIFT
> +#define PAGE_SIZE_MAX	PAGE_SIZE
> +#define PAGE_MASK_MAX	PAGE_MASK
> +#endif
> +
> +/*
> + * Define a global variable (scalar or struct), whose value is derived from
> + * PAGE_SIZE and friends. When PAGE_SIZE is a compile-time constant, the global
> + * variable is simply defined with the static value. When PAGE_SIZE is
> + * determined at boot-time, a pure initcall is registered and run during boot to
> + * initialize the variable.
> + *
> + * @type: Unqualified type. Do not include "const"; implied by macro variant.
> + * @name: Variable name.
> + * @...:  Initialization value. May be scalar or initializer.
> + *
> + * "static" is declared by placing "static" before the macro.
> + *
> + * Example:
> + *
> + * struct my_struct {
> + *         int a;
> + *         char b;
> + * };
> + *
> + * static DEFINE_GLOBAL_PAGE_SIZE_VAR(struct my_struct, my_variable, {
> + *         .a = 10,
> + *         .b = 'e',
> + * });
> + */
> +#if PAGE_SIZE_MIN != PAGE_SIZE_MAX
> +#define __DEFINE_GLOBAL_PAGE_SIZE_VAR(type, name, attrib, ...)		\
> +	type name attrib;						\
> +	static int __init __attribute__((constructor)) __##name##_init(void)	\
> +	{								\
> +		name = (type)__VA_ARGS__;				\
> +		return 0;						\
> +	}
> +
> +#define DEFINE_GLOBAL_PAGE_SIZE_VAR(type, name, ...)			\
> +	__DEFINE_GLOBAL_PAGE_SIZE_VAR(type, name, , __VA_ARGS__)
> +
> +#define DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(type, name, ...)		\
> +	__DEFINE_GLOBAL_PAGE_SIZE_VAR(type, name, __ro_after_init, __VA_ARGS__)
> +#else /* PAGE_SIZE_MIN == PAGE_SIZE_MAX */
> +#define __DEFINE_GLOBAL_PAGE_SIZE_VAR(type, name, attrib, ...)		\
> +	type name attrib = __VA_ARGS__;					\
> +
> +#define DEFINE_GLOBAL_PAGE_SIZE_VAR(type, name, ...)			\
> +	__DEFINE_GLOBAL_PAGE_SIZE_VAR(type, name, , __VA_ARGS__)
> +
> +#define DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(type, name, ...)		\
> +	__DEFINE_GLOBAL_PAGE_SIZE_VAR(const type, name, , __VA_ARGS__)
> +#endif
> +
> +#endif /* ASM_GENERIC_PGTABLE_GEOMETRY_H */
> diff --git a/init/main.c b/init/main.c
> index 206acdde51f5a..ba1515eb20b9d 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -899,6 +899,8 @@ static void __init early_numa_node_init(void)
>  #endif
>  }
>  
> +static __init void do_ctors(void);
> +
>  asmlinkage __visible __init __no_sanitize_address __noreturn __no_stack_protector
>  void start_kernel(void)
>  {
> @@ -910,6 +912,8 @@ void start_kernel(void)
>  	debug_objects_early_init();
>  	init_vmlinux_build_id();
>  
> +	do_ctors();
> +
>  	cgroup_init_early();
>  
>  	local_irq_disable();
> @@ -1360,7 +1364,6 @@ static void __init do_basic_setup(void)
>  	cpuset_init_smp();
>  	driver_init();
>  	init_irq_proc();
> -	do_ctors();
>  	do_initcalls();
>  }
>  


