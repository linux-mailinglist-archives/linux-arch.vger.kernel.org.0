Return-Path: <linux-arch+bounces-4342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114B78C3793
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 18:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435061C20881
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CB4A99C;
	Sun, 12 May 2024 16:32:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC246435;
	Sun, 12 May 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715531557; cv=none; b=iOlizaY6Lh39MC7rxK6Nl4j+TMaOglhtmJDN+DsmT4qpuS2BOj7dXZgTiAagCulWyPL/LR7aeNRaHXt9nXTcwDOo42eZajLIOy55mpxDXqNj6baijZFfDW0aQ9IrBUoCHdvi/bbpW2iN0/DlxmtYWRWFnIBYYfqm2Epx2l8rDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715531557; c=relaxed/simple;
	bh=2fmYuzsF53sotwxXlB7hG9j2/QIAXITmWcD/TyP5X6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEJHo4k6cYlS7JZbmn2dJxcuMAWrgAOmafrmA0Rsd01Sj3r/pq8q9VZv60XGKl1Mp6RtS3jlt6uZMgkt6qbMjOJBZA3u7MX57/1/sAD7qQk7ezqYm/kAHGCvxyHhA/spULKibS89pZu0rWyOZRnk6fb6oeoNly06C9IzDHKxEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id C83DD40004;
	Sun, 12 May 2024 16:31:25 +0000 (UTC)
Message-ID: <276fa17b-cd62-433d-b0ec-fa98c65a46ca@ghiti.fr>
Date: Sun, 12 May 2024 18:31:24 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/29] riscv mmu: write protect and shadow stack
To: Deepak Gupta <debug@rivosinc.com>, paul.walmsley@sifive.com,
 rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
 kito.cheng@sifive.com, keescook@chromium.org, ajones@ventanamicro.com,
 conor.dooley@microchip.com, cleger@rivosinc.com, atishp@atishpatra.org,
 bjorn@rivosinc.com, alexghiti@rivosinc.com, samuel.holland@sifive.com,
 conor@kernel.org
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
 akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
 shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
 jerry.shih@sifive.com, hankuan.chen@sifive.com, greentime.hu@sifive.com,
 evan@rivosinc.com, xiao.w.wang@intel.com, charlie@rivosinc.com,
 apatel@ventanamicro.com, mchitale@ventanamicro.com,
 dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com,
 willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org,
 samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org,
 heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com,
 cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com,
 mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com,
 mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, david@redhat.com,
 catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org,
 shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
 jhubbard@nvidia.com
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-14-debug@rivosinc.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240403234054.2020347-14-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 04/04/2024 01:35, Deepak Gupta wrote:
> `fork` implements copy on write (COW) by making pages readonly in child
> and parent both.
>
> ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
> Assumption is that page is readable and on fault copy on write happens.
>
> To implement COW on such pages,


I guess you mean "shadow stack pages" here.


>   clearing up W bit makes them XWR = 000.
> This will result in wrong PTE setting which says no perms but V=1 and PFN
> field pointing to final page. Instead desired behavior is to turn it into
> a readable page, take an access (load/store) fault on sspush/sspop
> (shadow stack) and then perform COW on such pages.
> This way regular reads
> would still be allowed and not lead to COW maintaining current behavior
> of COW on non-shadow stack but writeable memory.
>
> On the other hand it doesn't interfere with existing COW for read-write
> memory. Assumption is always that _PAGE_READ must have been set and thus
> setting _PAGE_READ is harmless.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 9b837239d3e8..7a1c2a98d272 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -398,7 +398,7 @@ static inline int pte_special(pte_t pte)
>   
>   static inline pte_t pte_wrprotect(pte_t pte)
>   {
> -	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
> +	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
>   }
>   
>   /* static inline pte_t pte_mkread(pte_t pte) */
> @@ -581,7 +581,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>   static inline void ptep_set_wrprotect(struct mm_struct *mm,
>   				      unsigned long address, pte_t *ptep)
>   {
> -	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
> +	volatile pte_t read_pte = *ptep;
> +	/*
> +	 * ptep_set_wrprotect can be called for shadow stack ranges too.
> +	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
> +	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
> +	 * but we dont want this wrong configuration to be set in page tables.
> +	 */
> +	atomic_long_set((atomic_long_t *)ptep,
> +			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
>   }
>   
>   #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH


Doesn't making the shadow stack page readable allow "normal" loads to 
access the page? If it does, isn't that an issue (security-wise)?


