Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3E30EAED
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 04:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhBDDaN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 22:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhBDDaM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 22:30:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC25C0613D6;
        Wed,  3 Feb 2021 19:29:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i7so1164318pgc.8;
        Wed, 03 Feb 2021 19:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=meM8RTX/oMZMB1tmtCU5xYCclN9QRO5zHnt/l71QK3s=;
        b=pFrJGB5wxqzH9s5zXb7wa3CRbpN64aRd0pQcPwL/GoJ43ytdtXeXwTwh/3ojB+7D4E
         M+ULuGibAG+p08TzNNPKQXRy+HfnGoXyd9R0n9FsWtzQ1J1jsViSzPolAj49mjU6zdjO
         NUYAHKXLBMbuABxvqFHwXsvJxDLw6hyCNt+BgGGGS5+YNLoaA2sYBI2ImnZxiLC/yWkM
         6aHEEyXPH0TYV05NTKqLge2naOT5+QwcEOUoiwznzixpGbGyPY1r9bwJ2vaCS0DGk8we
         WtV/eLAMxwVDjrZEOmvLRC96zszg14uUCNTPdCaNmsAeZv070WrKbh/g7f8lrk23j7Ix
         KkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=meM8RTX/oMZMB1tmtCU5xYCclN9QRO5zHnt/l71QK3s=;
        b=c92kSZaANUyWvfimGv6o34Uur2eoqv2j/qGniQbO9nqLGKmLkfQWs8OonG6fgoyDP8
         FEsKOzdnih1uYIeszRYUSlXHI13YozVBszOocpExReMl1CEqa78PEr0gBopxo5Mu8c4F
         O/Ur/OAufNIPdX/gBh+hQU0bbdQR3Fyj332DMIEqKIWps63QzZ9uw4ifPMAYwKw1y7e9
         0Yi3UpckId+/+ZkU5G6anDfLEAvSbeh4J+6LlO3I+XvY7pwnRrQ9aGpQ22BOepB5IZMS
         opBKtDj3J6WCcLteBiPLBEOIaIrad9jxM4YQHihigVyj2S5wcto08HY6MvtSSpjdvvtU
         3Eyw==
X-Gm-Message-State: AOAM532dvQVuxVFBU8P03t4Kb0dZ/pE99Ja0smHiP0hhlClBxoKwTHJG
        bj7AzbQ8M0ajtb14mk6tjfE=
X-Google-Smtp-Source: ABdhPJyVDDd+GZl3qrx9BrvSpsNwEpq/FLUYqbPzm1H66kJXQ8Ov3rvZoZfBLI2gVc6EWWdSZIYCjw==
X-Received: by 2002:a63:ac19:: with SMTP id v25mr6872882pge.258.1612409372206;
        Wed, 03 Feb 2021 19:29:32 -0800 (PST)
Received: from localhost (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id o10sm3705684pfp.87.2021.02.03.19.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:29:31 -0800 (PST)
Date:   Thu, 04 Feb 2021 13:29:26 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] MIPS: make userspace mapping young by default
To:     ambrosehua@gmail.com, Huang Pei <huangpei@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhc@lemote.com>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, Li Xuefeng <lixuefeng@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>
References: <20210204013942.8398-1-huangpei@loongson.cn>
In-Reply-To: <20210204013942.8398-1-huangpei@loongson.cn>
MIME-Version: 1.0
Message-Id: <1612409285.q4gi3x2bhk.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Huang Pei's message of February 4, 2021 11:39 am:
> MIPS page fault path(except huge page) takes 3 exceptions (1 TLB Miss
> + 2 TLB Invalid), butthe second TLB Invalid exception is just
> triggered by __update_tlb from do_page_fault writing tlb without
> _PAGE_VALID set. With this patch, user space mapping prot is made
> young by default (with both _PAGE_VALID and _PAGE_YOUNG set),
> and it only take 1 TLB Miss + 1 TLB Invalid exception
>=20
> Remove pte_sw_mkyoung without polluting MM code and make page fault
> delay of MIPS on par with other architecture
>=20
> Signed-off-by: Huang Pei <huangpei@loongson.cn>

Could we merge this? For the core code,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/mips/mm/cache.c    | 30 ++++++++++++++++--------------
>  include/linux/pgtable.h |  8 --------
>  mm/memory.c             |  3 ---
>  3 files changed, 16 insertions(+), 25 deletions(-)
>=20
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 23b16bfd97b2..e19cf424bb39 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -156,29 +156,31 @@ unsigned long _page_cachable_default;
>  EXPORT_SYMBOL(_page_cachable_default);
> =20
>  #define PM(p)	__pgprot(_page_cachable_default | (p))
> +#define PVA(p)	PM(_PAGE_VALID | _PAGE_ACCESSED | (p))
> =20
>  static inline void setup_protection_map(void)
>  {
>  	protection_map[0]  =3D PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ=
);
> -	protection_map[1]  =3D PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
> -	protection_map[2]  =3D PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ=
);
> -	protection_map[3]  =3D PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
> -	protection_map[4]  =3D PM(_PAGE_PRESENT);
> -	protection_map[5]  =3D PM(_PAGE_PRESENT);
> -	protection_map[6]  =3D PM(_PAGE_PRESENT);
> -	protection_map[7]  =3D PM(_PAGE_PRESENT);
> +	protection_map[1]  =3D PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
> +	protection_map[2]  =3D PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_REA=
D);
> +	protection_map[3]  =3D PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
> +	protection_map[4]  =3D PVA(_PAGE_PRESENT);
> +	protection_map[5]  =3D PVA(_PAGE_PRESENT);
> +	protection_map[6]  =3D PVA(_PAGE_PRESENT);
> +	protection_map[7]  =3D PVA(_PAGE_PRESENT);
> =20
>  	protection_map[8]  =3D PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ=
);
> -	protection_map[9]  =3D PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
> -	protection_map[10] =3D PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE |
> +	protection_map[9]  =3D PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
> +	protection_map[10] =3D PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE =
|
>  				_PAGE_NO_READ);
> -	protection_map[11] =3D PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
> -	protection_map[12] =3D PM(_PAGE_PRESENT);
> -	protection_map[13] =3D PM(_PAGE_PRESENT);
> -	protection_map[14] =3D PM(_PAGE_PRESENT | _PAGE_WRITE);
> -	protection_map[15] =3D PM(_PAGE_PRESENT | _PAGE_WRITE);
> +	protection_map[11] =3D PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE)=
;
> +	protection_map[12] =3D PVA(_PAGE_PRESENT);
> +	protection_map[13] =3D PVA(_PAGE_PRESENT);
> +	protection_map[14] =3D PVA(_PAGE_PRESENT);
> +	protection_map[15] =3D PVA(_PAGE_PRESENT);
>  }
> =20
> +#undef _PVA
>  #undef PM
> =20
>  void cpu_cache_init(void)
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8fcdfa52eb4b..8c042627399a 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -432,14 +432,6 @@ static inline void ptep_set_wrprotect(struct mm_stru=
ct *mm, unsigned long addres
>   * To be differentiate with macro pte_mkyoung, this macro is used on pla=
tforms
>   * where software maintains page access bit.
>   */
> -#ifndef pte_sw_mkyoung
> -static inline pte_t pte_sw_mkyoung(pte_t pte)
> -{
> -	return pte;
> -}
> -#define pte_sw_mkyoung	pte_sw_mkyoung
> -#endif
> -
>  #ifndef pte_savedwrite
>  #define pte_savedwrite pte_write
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index feff48e1465a..95718a623884 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2890,7 +2890,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf=
)
>  		}
>  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  		entry =3D mk_pte(new_page, vma->vm_page_prot);
> -		entry =3D pte_sw_mkyoung(entry);
>  		entry =3D maybe_mkwrite(pte_mkdirty(entry), vma);
> =20
>  		/*
> @@ -3548,7 +3547,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>  	__SetPageUptodate(page);
> =20
>  	entry =3D mk_pte(page, vma->vm_page_prot);
> -	entry =3D pte_sw_mkyoung(entry);
>  	if (vma->vm_flags & VM_WRITE)
>  		entry =3D pte_mkwrite(pte_mkdirty(entry));
> =20
> @@ -3824,7 +3822,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, stru=
ct page *page)
> =20
>  	flush_icache_page(vma, page);
>  	entry =3D mk_pte(page, vma->vm_page_prot);
> -	entry =3D pte_sw_mkyoung(entry);
>  	if (write)
>  		entry =3D maybe_mkwrite(pte_mkdirty(entry), vma);
>  	/* copy-on-write page */
> --=20
> 2.17.1
>=20
>=20
>=20
