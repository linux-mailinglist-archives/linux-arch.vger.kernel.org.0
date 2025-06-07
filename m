Return-Path: <linux-arch+bounces-12259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF64AD0B4E
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 07:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3272D188B36F
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 05:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E7258CCC;
	Sat,  7 Jun 2025 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiD7hV6o"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325BEC4;
	Sat,  7 Jun 2025 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749275643; cv=none; b=BKaFaovX3Xd45JOPGvOy7RbXyyzJt0wHGDkLa2ygFjLhAscc7XpcHANLPEsMnGxMfCQiDTjvdE2cTKot4FFLawDNbqN1cxHlanpLOlB2BY3np8YL+RKMDJdl43Cz50KS7q9NFxRau5Lbemn1rVwDf9CmZMDrIp3RwpLkklESEog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749275643; c=relaxed/simple;
	bh=NP4EOS5NyTyz8u4io2V10MTCuX9FmsWjgiY+gthNb3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcqDOHEeqvrJCtlff2C16gHoUqoRSzJiscfRqRSL4fowOLoKRNysgEGSCw9UY8tkNEmUds4PcpslAESi9ZJhLCG+gowMIpUsZPDhLINejUA61k2+zTDtHpqx554S/CnZ2QyDs6giCBt3u0/WLHAp/4n1B10g1+e7oas7zDDZrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiD7hV6o; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1408531f8f.1;
        Fri, 06 Jun 2025 22:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749275640; x=1749880440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QU48uw1hkwy8nOYgKJq/pVDJATL50b3W2YOv6VUcTJA=;
        b=LiD7hV6omdxfMxJe9fAvcvvVqzpvyGzXhNq+egDpNlf+CKczU3l8ebgwz3hFYnkk1M
         lXTC0Qpbt8v/ABJEECTAIBI8GN7ueR7YE9Yn7YtLgwRHz/05n9jTHG7u43TthASeBhzf
         p+7OjYZy51Rx3AlmXl5oSz4yKLj4IF8vfVYz453SqA6LG/vpFx3XHfWZjkgMzdtBjCcH
         MeJCpm8lf6LNu2s94S8feCXkUZ7kSYoHQ6WeqfObJY9bCtTLXheBX/nd5fgSLmyWABxE
         liN/RZul4XyGJJLlZJvq38wPYhxRdlZR6KZZ10S8ZqkGmVGMaNcAqqQsedw+idOEUBMp
         HxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749275640; x=1749880440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU48uw1hkwy8nOYgKJq/pVDJATL50b3W2YOv6VUcTJA=;
        b=sCqZXVe+EjHSHijVqTBsr3YdpG84X306v+cfi9qbU2Iq1pcqy130whua8k2TXmIvlI
         Ua0jNeY9v4EC9cy+GYqB/0UIqyiyfchG9dbny380BSRkwQyH56yT1P5C2vJr+vzNdHAc
         fkL15rbwQuUhJmvWlTZAU1b1BPysK0FlEG2PvjEtaO02gQZTfAA9JtUWV42T2ARVWSyn
         tTkrTJRWXTxTWS4HFAOpm0NjhQLMzaSgbj48zn7IJ25dAqdtrCPALTvhH5OAYxdBiyJp
         edWqi5K+pp8Lb8Ddddfza8irBPeFbqlqGX6F3fhmxFngp2egouwXCtyUmgyEkfCoje56
         20qg==
X-Forwarded-Encrypted: i=1; AJvYcCUB7nSGGkA9SKhCrPhPA5CsTVWxxY/upWY2EotMTNMJNzxmMQrvwI0XxZ5c5Oc2CidLt9XLCikSHtjY@vger.kernel.org, AJvYcCW7KfE7KxrtSwYbqlCSAo92Cg9Cy4SHRpTSA6L0l6JENtDUJQ/c+peFrEy5kV6AIrn3h5YOb2Mr8WBdokiK1lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3C4QVdgdyw0HIGdLmymY74U+fe7CP8ZSG0I+IMzK6bF9W97Q
	yUcljtDJjIocPshtWx6+V1UmImgHji3jWDNfxeqN8M0ZTkQwJ3xd6hxb
X-Gm-Gg: ASbGncvhLQNfTBP5BAI998zGRwmiPzvjoLsxrOIk2KeqW/Im5ZaTfD5cyrsI++6Ze6F
	kV/rijVYFg+MrrJw49Ta0vEym+1EAIEBduxsauDzDZoEc8vSBvxMee7gIvqWZR6kdPjMYJjTBV4
	qnNqDBXEnaOta/Ts2vKdWJ2tO/yozSFcUMlJBgs9DLTX67EBSatUfcqzn3v6NnYpbLsPbBZxkcW
	Pl5CSWiIDMY/x73F+0kZGn4QsTJfZ1VLuJP/l1B6aGAKGUj9yShrPQycLn9dSJFfAXD8KbBvRCa
	S+8p4KG3P/v9wZu3HN/TurgDLFdJwVZ4XMjgE90SJ5O/jXbL4GsCm9XKfPStA16AZtmIFK698oS
	UQGNMCewcL7mb0sK93/bBlpFySw==
X-Google-Smtp-Source: AGHT+IGQj91T18RvkaQmwHDv2aDfFpJ7eAu2BIp4YrOyTmDl3qQExiamDanKxvoZFyGPSrNSYD3b6Q==
X-Received: by 2002:a05:6000:4283:b0:3a5:1241:ce99 with SMTP id ffacd0b85a97d-3a53188d3famr4577440f8f.24.1749275639593;
        Fri, 06 Jun 2025 22:53:59 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532435f94sm3759690f8f.60.2025.06.06.22.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 22:53:58 -0700 (PDT)
Date: Sat, 7 Jun 2025 06:53:56 +0100
From: Stafford Horne <shorne@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH 23/41] openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__
 in non-uapi headers
Message-ID: <aEPT9DeL2nfxG_L9@antec>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-24-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314071013.1575167-24-thuth@redhat.com>

On Fri, Mar 14, 2025 at 08:09:54AM +0100, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize on
> the __ASSEMBLER__ macro that is provided by the compilers now.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).

Hi Thomas,

I have applied this to the OpenRISC queue, as discussed on 22.

Thanks,

-Stafford

> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: linux-openrisc@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/openrisc/include/asm/mmu.h         | 2 +-
>  arch/openrisc/include/asm/page.h        | 8 ++++----
>  arch/openrisc/include/asm/pgtable.h     | 4 ++--
>  arch/openrisc/include/asm/processor.h   | 4 ++--
>  arch/openrisc/include/asm/ptrace.h      | 4 ++--
>  arch/openrisc/include/asm/setup.h       | 2 +-
>  arch/openrisc/include/asm/thread_info.h | 8 ++++----
>  7 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/mmu.h b/arch/openrisc/include/asm/mmu.h
> index eb720110f3a20..e7826a681bc4a 100644
> --- a/arch/openrisc/include/asm/mmu.h
> +++ b/arch/openrisc/include/asm/mmu.h
> @@ -15,7 +15,7 @@
>  #ifndef __ASM_OPENRISC_MMU_H
>  #define __ASM_OPENRISC_MMU_H
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  typedef unsigned long mm_context_t;
>  #endif
>  
> diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
> index c589e96035e15..85797f94d1d74 100644
> --- a/arch/openrisc/include/asm/page.h
> +++ b/arch/openrisc/include/asm/page.h
> @@ -25,7 +25,7 @@
>   */
>  #include <asm/setup.h>
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  #define clear_page(page)	memset((page), 0, PAGE_SIZE)
>  #define copy_page(to, from)	memcpy((to), (from), PAGE_SIZE)
> @@ -55,10 +55,10 @@ typedef struct page *pgtable_t;
>  #define __pgd(x)	((pgd_t) { (x) })
>  #define __pgprot(x)	((pgprot_t) { (x) })
>  
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>  
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
>  #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
> @@ -73,7 +73,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>  
>  #define virt_addr_valid(kaddr)	(pfn_valid(virt_to_pfn(kaddr)))
>  
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> index 60c6ce7ff2dcf..cd979bd28ab3b 100644
> --- a/arch/openrisc/include/asm/pgtable.h
> +++ b/arch/openrisc/include/asm/pgtable.h
> @@ -23,7 +23,7 @@
>  
>  #include <asm-generic/pgtable-nopmd.h>
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <asm/mmu.h>
>  #include <asm/fixmap.h>
>  
> @@ -432,5 +432,5 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  
>  typedef pte_t *pte_addr_t;
>  
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* __ASM_OPENRISC_PGTABLE_H */
> diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
> index e05d1b59e24e1..3ff893a67c13b 100644
> --- a/arch/openrisc/include/asm/processor.h
> +++ b/arch/openrisc/include/asm/processor.h
> @@ -39,7 +39,7 @@
>   */
>  #define TASK_UNMAPPED_BASE      (TASK_SIZE / 8 * 3)
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  struct task_struct;
>  
> @@ -78,5 +78,5 @@ void show_registers(struct pt_regs *regs);
>  
>  #define cpu_relax()     barrier()
>  
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* __ASM_OPENRISC_PROCESSOR_H */
> diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
> index e5a282b670757..28facf2f3e00c 100644
> --- a/arch/openrisc/include/asm/ptrace.h
> +++ b/arch/openrisc/include/asm/ptrace.h
> @@ -27,7 +27,7 @@
>   * they share a cacheline (not done yet, though... future optimization).
>   */
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  /*
>   * This struct describes how the registers are laid out on the kernel stack
>   * during a syscall or other kernel entry.
> @@ -147,7 +147,7 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
>  	return *(unsigned long *)((unsigned long)regs + offset);
>  }
>  
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  
>  /*
>   * Offsets used by 'ptrace' system call interface.
> diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
> index 9acbc5deda691..dce9f4d3b378f 100644
> --- a/arch/openrisc/include/asm/setup.h
> +++ b/arch/openrisc/include/asm/setup.h
> @@ -8,7 +8,7 @@
>  #include <linux/init.h>
>  #include <asm-generic/setup.h>
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  void __init or1k_early_setup(void *fdt);
>  #endif
>  
> diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
> index 4af3049c34c21..e338fff7efb0e 100644
> --- a/arch/openrisc/include/asm/thread_info.h
> +++ b/arch/openrisc/include/asm/thread_info.h
> @@ -17,7 +17,7 @@
>  
>  #ifdef __KERNEL__
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <asm/types.h>
>  #include <asm/processor.h>
>  #endif
> @@ -38,7 +38,7 @@
>   * - if the contents of this structure are changed, the assembly constants
>   *   must also be changed
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  struct thread_info {
>  	struct task_struct	*task;		/* main task structure */
> @@ -58,7 +58,7 @@ struct thread_info {
>   *
>   * preempt_count needs to be 1 initially, until the scheduler is functional.
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #define INIT_THREAD_INFO(tsk)				\
>  {							\
>  	.task		= &tsk,				\
> @@ -75,7 +75,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
>  #define get_thread_info(ti) get_task_struct((ti)->task)
>  #define put_thread_info(ti) put_task_struct((ti)->task)
>  
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>  
>  /*
>   * thread information flags
> -- 
> 2.48.1
> 

