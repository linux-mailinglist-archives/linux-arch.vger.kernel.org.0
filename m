Return-Path: <linux-arch+bounces-8236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F0E9A0CF8
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 16:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46D7B27733
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8A20C026;
	Wed, 16 Oct 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1ZtLk0o"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA220C017;
	Wed, 16 Oct 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089674; cv=none; b=Y5i4baapvky7507OzbV7S/ZGoY6pFI2qX4Y9vtvqU66Q8+GSU0MsxaqnD/pZljBNkr/DQub+6G74al1wCkMXwfxKTqmTrvSQk2RUcVTskWBrOGEELjlA90zIdgHT99urYtN613vqK5xCqyqW0KTbLV71GsiP3lctn8EUlVNNos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089674; c=relaxed/simple;
	bh=cFm6C9yHF4d5EJsvTt2L486kzgO4ydnk8peQ4k2qH0U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY6UrDtyeS62HjTASn+ZxnQkmJcYqzFRcIrZsejRpLek75v5hd/TWwxrQlssvh0/ABHHdjLE4d8dr++/UAV/Mv7tl/byyNXrxnQ1iP3dVI0Jc7txVdFDigD2627LiV4kA77qTeIrwzrnf2pjLxWsW4aKvcsTlV09RmQyhg2WQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1ZtLk0o; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so24767651fa.1;
        Wed, 16 Oct 2024 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729089669; x=1729694469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNOEBHIW89c1j/jhsHn9BJm63iz+XQaKnsI8oRx93vU=;
        b=Q1ZtLk0oeCSMYe6D5RRe1+xn3EdzrFZmrLdWKuP4jwtn3Rn2ZHAZGh4qFtBtI4vFnB
         2Fr/5Z+DlsiEjb/Gn0w55+QZf5UHLEB2xyky4dvL37GEluYSP31Sv62+g/LJENbZQ7H4
         m2fU5+dqgC4gmkz3pCF8dJKOH6vVB8zTB8/zQh0IAK0E05ZP/szOUVhqXForzaElQvz5
         2pP9wiNOycLjNkx0fyhA1s0cS9atS5Z1qZRIv9I8l3oWJB5bsuh3rRjwTsB7gcRSbAfd
         6A7qaAUgXcUjOtTtJRg+p9Nzp3MbgNtMpbSl4+MXIJZByttBRKAWUgfBEKSNN7dJUa35
         SYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729089669; x=1729694469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNOEBHIW89c1j/jhsHn9BJm63iz+XQaKnsI8oRx93vU=;
        b=JY6DVHFslzP/AkNIB38FBSEwG4wS4Z/EZ5ScbJ+RJyeoH7ePZo9xfqx2/PwM3Mp6CF
         8MadJYm2Xyx+bk96PvLXvtB8YqJ/KwzEUdpnMhkaOZ/gspC26k7Xn/C0V5FYUGQIzRk8
         c9y2I4COo8RMapmrQxd7Kr9VgRO7jBM5zcDmyAJDtBQjPToQnLILczCG25RoU2pb+4iv
         8oDZpysP2ZabDwQ4zCsWqpYvNANsLe3dZy9bkkHKF757Hm08mtrpVTUeH/Na+ZDSKh+6
         t12PgS6T7kJM8M1UTDdFe/ySdVsoiGy9gP3tD9KmWqlI9x0knHQoXJN9bdUs2Y+uRPR/
         TFNw==
X-Forwarded-Encrypted: i=1; AJvYcCUCIChCbnfViWEF8DQOTPLY3Hsx+h53h+E1XBpbo3jgT4GkjK144pvSMSxCjS8qmWvM7CXREdb+jEAlLw==@vger.kernel.org, AJvYcCUSEQoioM8/+qJLlEmLtYI/wZev5lpLIjUhUMOZFJUpAYI+4bLNBxZyScoubsMZlr8xaB1/BRnPByo+rg==@vger.kernel.org, AJvYcCUkZofM2BZFrmPAZLgrk4Iw1oo40u44zsYokk9ZDV5nOvWe5EiKP7l3ZzFDixyJErYQWpXDCHoPQJXUacJ1@vger.kernel.org, AJvYcCV+AhRbtyI3l3GPDJpWot+1le1fBEhIPOylobahwCDhbJrz56XPs4ArOo4a7VwLg5w9y2R4JtCqbvw5ux5ekzY=@vger.kernel.org, AJvYcCV+sdj0cB/Ouidqe+xg+V8oDkGwlfPXIgK+CAWnu9VduksFyPX8D3XrJaR7HKnFumelQXaKv2nIZF4d4Q==@vger.kernel.org, AJvYcCVgAMxwaaVa3C5n2A0WCk6CTDV92zV5r+jp+7HawkSsvD+wPZ3Sl2+F8wWRedB+eB4l3JnpqT306gS+RQ0KFtQ4YnNx@vger.kernel.org, AJvYcCVsOtt1B+pFndOuyF8b85QpPRXrrBOG+HrPdZSWm+PtYYW6VVwBUlc2r0agRactLlf25uyU4ptrOhxa2Y+b@vger.kernel.org, AJvYcCVyYggDQub9YXbBdbWbX2B5uWhqDpJm683IqYbEEWAFnP/2uBjitvDZKUeo5xsGoiv19Fn+vfpcAtV9/yEzig==@vger.kernel.org, AJvYcCWNYvx0pXeyHgZ1FPjZVsURvyqLoXcFIUpzBnnoCeugpXvME6QrNSIjDJP7tO3NJLSxz4di9Q4D24fHPCb4Cg==@vger.kernel.o
 rg, AJvYcCXNOd7Z9J6sg043BHAx6NRvz2DstqoP64RRKkL+WcInVyTHzL4dVg/shQy+zTlsQBK5mlw=@vger.kernel.org, AJvYcCXV8W2xqRZFTGwhDm8RuXKoS9fePuPGBpE64EYcfMDnyjaLtGxtQGKt2UIZTm7axjpkoVDjWf7vDU4=@vger.kernel.org, AJvYcCXgO0LRIbXjHSbT3A1/2QZxhI0pAAkPU42r3EnLvdAauFuxbR3RTqCvCr8OSZQOuqEIR4nX9jGjXeZfaA==@vger.kernel.org, AJvYcCXmywYtcfGWUPHEr0DCGb6h1b9sXLNTrLIx+HQ2mL/6lWcY/CvaopGnn4YebzDXBDpFZD+jp9zQmaFIOAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxaoxOA/wjAqa7C9mRQ2R91bUQlTztDFQhgAKp+oN0jzxAgOG
	EwZ7wWGCKSPs51GdBMxkQBYGj7KRPIocIJHbGj73qYka67E9Geul
X-Google-Smtp-Source: AGHT+IEQ2b77do+Ei5H+uRLYrEtNQq0NK3oK0wCc+2cFtuWRuK/aQBOOdJJvL1LeKTNOBzUMcJr/yQ==
X-Received: by 2002:a05:651c:1989:b0:2fb:6181:8ca1 with SMTP id 38308e7fff4ca-2fb61b37a76mr33036831fa.6.1729089669341;
        Wed, 16 Oct 2024 07:41:09 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d1d0244sm4327361fa.139.2024.10.16.07.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:41:08 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 16:41:03 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 1/8] mm: vmalloc: group declarations depending on
 CONFIG_MMU together
Message-ID: <Zw_QfzopOv7pCZc_@pc636>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-2-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-2-rppt@kernel.org>

On Wed, Oct 16, 2024 at 03:24:17PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> There are a couple of declarations that depend on CONFIG_MMU in
> include/linux/vmalloc.h spread all over the file.
> 
> Group them all together to improve code readability.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/vmalloc.h | 60 +++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index ad2ce7a6ab7a..27408f21e501 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -134,12 +134,6 @@ extern void vm_unmap_ram(const void *mem, unsigned int count);
>  extern void *vm_map_ram(struct page **pages, unsigned int count, int node);
>  extern void vm_unmap_aliases(void);
>  
> -#ifdef CONFIG_MMU
> -extern unsigned long vmalloc_nr_pages(void);
> -#else
> -static inline unsigned long vmalloc_nr_pages(void) { return 0; }
> -#endif
> -
>  extern void *vmalloc_noprof(unsigned long size) __alloc_size(1);
>  #define vmalloc(...)		alloc_hooks(vmalloc_noprof(__VA_ARGS__))
>  
> @@ -266,12 +260,29 @@ static inline bool is_vm_area_hugepages(const void *addr)
>  #endif
>  }
>  
> +/* for /proc/kcore */
> +long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
> +
> +/*
> + *	Internals.  Don't use..
> + */
> +__init void vm_area_add_early(struct vm_struct *vm);
> +__init void vm_area_register_early(struct vm_struct *vm, size_t align);
> +
> +int register_vmap_purge_notifier(struct notifier_block *nb);
> +int unregister_vmap_purge_notifier(struct notifier_block *nb);
> +
>  #ifdef CONFIG_MMU
> +#define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
> +
> +unsigned long vmalloc_nr_pages(void);
> +
>  int vm_area_map_pages(struct vm_struct *area, unsigned long start,
>  		      unsigned long end, struct page **pages);
>  void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
>  			 unsigned long end);
>  void vunmap_range(unsigned long addr, unsigned long end);
> +
>  static inline void set_vm_flush_reset_perms(void *addr)
>  {
>  	struct vm_struct *vm = find_vm_area(addr);
> @@ -279,24 +290,14 @@ static inline void set_vm_flush_reset_perms(void *addr)
>  	if (vm)
>  		vm->flags |= VM_FLUSH_RESET_PERMS;
>  }
> +#else  /* !CONFIG_MMU */
> +#define VMALLOC_TOTAL 0UL
>  
> -#else
> -static inline void set_vm_flush_reset_perms(void *addr)
> -{
> -}
> -#endif
> -
> -/* for /proc/kcore */
> -extern long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
> -
> -/*
> - *	Internals.  Don't use..
> - */
> -extern __init void vm_area_add_early(struct vm_struct *vm);
> -extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);
> +static inline unsigned long vmalloc_nr_pages(void) { return 0; }
> +static inline void set_vm_flush_reset_perms(void *addr) {}
> +#endif /* CONFIG_MMU */
>  
> -#ifdef CONFIG_SMP
> -# ifdef CONFIG_MMU
> +#if defined(CONFIG_MMU) && defined(CONFIG_SMP)
>  struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  				     const size_t *sizes, int nr_vms,
>  				     size_t align);
> @@ -311,22 +312,9 @@ pcpu_get_vm_areas(const unsigned long *offsets,
>  	return NULL;
>  }
>  
> -static inline void
> -pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> -{
> -}
> -# endif
> -#endif
> -
> -#ifdef CONFIG_MMU
> -#define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
> -#else
> -#define VMALLOC_TOTAL 0UL
> +static inline void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms) {}
>  #endif
>  
> -int register_vmap_purge_notifier(struct notifier_block *nb);
> -int unregister_vmap_purge_notifier(struct notifier_block *nb);
> -
>  #if defined(CONFIG_MMU) && defined(CONFIG_PRINTK)
>  bool vmalloc_dump_obj(void *object);
>  #else
> -- 
> 2.43.0
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

