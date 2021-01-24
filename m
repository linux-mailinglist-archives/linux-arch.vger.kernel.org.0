Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB679301A5B
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 08:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAXHoc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 02:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbhAXHoa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 02:44:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B1DC061573;
        Sat, 23 Jan 2021 23:43:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t6so5735978plq.1;
        Sat, 23 Jan 2021 23:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=+/6kKIloWjHkv6epE2TcP1cNMAlAxbqvJ/hMS+1BVS4=;
        b=ECst8pGK76Kt1i3hYRpk0C6YXFoVILwmhhITV8vLf7lxSp2DLkJIQbiJRMgNAQ8RhZ
         2FVBi6yU5cpVn2+k1ymdhPEiD0mTUZewRMTA/C2lx5qVisItC7g1Qk4OGg76U8ceJGgf
         oVWl3fnrKEggNSaXGGGHmXoOoXhZnwiVh1RBJL+lYFEHkFwpvlYF/ZZKyKChrGABAFdp
         R/fMbwbCbc15w5wSt5bs8uhzzHSiG/b/UpPKVMdktKCdkIGIrgNk1sVD54D/UhBtSvjQ
         s/HrxyZxn4pyAnjsJNo50WHO0keUtTPyw5qR6gy6UgFyMCLXWft4SR0fRSKV2J1bQRZG
         TWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=+/6kKIloWjHkv6epE2TcP1cNMAlAxbqvJ/hMS+1BVS4=;
        b=EIrszH50sy2p5PmXEtQrMgpJkRW2qj8W0knMKty27+kIRWwlRIaeGmvAmrFkiAtS93
         5EoIyz5HFy4Wd+TV8SL99FV+5iTy+JaIUkuXiCBaBMWZTQp7ksr+StKyB0fppXBntfmx
         orju92wg/yLUd4GMfx3zptGfc/jtGRcFfG3Tsfgiirlf/M6pordLINIKID4z8cTuzhys
         DyBQqca8mhWPGdj8p5gRsIZaWEHkIM3KvKqHbfqjNpyRr36u+kmWnmLgVOpQMnmsM9Q1
         eurvW9gTbAzqhmuSWdM/jOX7Oj0yfgP1sITosPdRaUnOAndfsW3QMTohmsbJzN1bHegA
         7qIA==
X-Gm-Message-State: AOAM533COurQx6m8pfEkH7aVLLjAdK3/73WetN9g8TEyR4iP9ssZou/9
        V4sugYo1NMxpasSh8pRs+eE=
X-Google-Smtp-Source: ABdhPJzN8ma2KWKosLen5J4F3FRMoKuPNeofyB7rb0dBGiGJZybg1BFnjDhMrrGiBy+u68O8a9eDMw==
X-Received: by 2002:a17:90a:de97:: with SMTP id n23mr6422067pjv.216.1611474229873;
        Sat, 23 Jan 2021 23:43:49 -0800 (PST)
Received: from localhost ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id b17sm12014448pfp.167.2021.01.23.23.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 23:43:49 -0800 (PST)
Date:   Sun, 24 Jan 2021 17:43:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v9 05/12] mm: HUGE_VMAP arch support cleanup
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ding Tianhong <dingtianhong@huawei.com>, linux-mm@kvack.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?iso-8859-1?q?Jonathan=0A?= Cameron 
        <Jonathan.Cameron@Huawei.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?iso-8859-1?q?Rick=0A?= Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20201205065725.1286370-1-npiggin@gmail.com>
        <20201205065725.1286370-6-npiggin@gmail.com>
        <c7eb5ba6-1187-d82f-d74c-0ca2c8ae8faf@huawei.com>
In-Reply-To: <c7eb5ba6-1187-d82f-d74c-0ca2c8ae8faf@huawei.com>
MIME-Version: 1.0
Message-Id: <1611473993.etnqidihnt.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Ding Tianhong's message of January 4, 2021 10:33 pm:
> On 2020/12/5 14:57, Nicholas Piggin wrote:
>> This changes the awkward approach where architectures provide init
>> functions to determine which levels they can provide large mappings for,
>> to one where the arch is queried for each call.
>>=20
>> This removes code and indirection, and allows constant-folding of dead
>> code for unsupported levels.
>>=20
>> This also adds a prot argument to the arch query. This is unused
>> currently but could help with some architectures (e.g., some powerpc
>> processors can't map uncacheable memory with large pages).
>>=20
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: x86@kernel.org
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com> [arm64]
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/arm64/include/asm/vmalloc.h         |  8 +++
>>  arch/arm64/mm/mmu.c                      | 10 +--
>>  arch/powerpc/include/asm/vmalloc.h       |  8 +++
>>  arch/powerpc/mm/book3s64/radix_pgtable.c |  8 +--
>>  arch/x86/include/asm/vmalloc.h           |  7 ++
>>  arch/x86/mm/ioremap.c                    | 10 +--
>>  include/linux/io.h                       |  9 ---
>>  include/linux/vmalloc.h                  |  6 ++
>>  init/main.c                              |  1 -
>>  mm/ioremap.c                             | 88 +++++++++---------------
>>  10 files changed, 77 insertions(+), 78 deletions(-)
>>=20
>> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/v=
malloc.h
>> index 2ca708ab9b20..597b40405319 100644
>> --- a/arch/arm64/include/asm/vmalloc.h
>> +++ b/arch/arm64/include/asm/vmalloc.h
>> @@ -1,4 +1,12 @@
>>  #ifndef _ASM_ARM64_VMALLOC_H
>>  #define _ASM_ARM64_VMALLOC_H
>> =20
>> +#include <asm/page.h>
>> +
>> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>> +bool arch_vmap_p4d_supported(pgprot_t prot);
>> +bool arch_vmap_pud_supported(pgprot_t prot);
>> +bool arch_vmap_pmd_supported(pgprot_t prot);
>> +#endif
>> +
>>  #endif /* _ASM_ARM64_VMALLOC_H */
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index ca692a815731..1b60079c1cef 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1315,12 +1315,12 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phy=
s, int *size, pgprot_t prot)
>>  	return dt_virt;
>>  }
>> =20
>> -int __init arch_ioremap_p4d_supported(void)
>> +bool arch_vmap_p4d_supported(pgprot_t prot)
>>  {
>> -	return 0;
>> +	return false;
>>  }
>> =20
>=20
> I think you should put this function in the CONFIG_HAVE_ARCH_HUGE_VMAP, o=
therwise it may break the compile when disable the CONFIG_HAVE_ARCH_HUGE_VM=
AP, the same
> as the x86 and ppc.

Ah, good catch. arm64 is okay because it always selects=20
HAVE_ARCH_HUGE_VMAP, powerpc is okay because it places
them in a file that's only compiled for configs that select
huge vmap, but x86-32 without PAE build breaks. I'll fix that.

Thanks,
Nick
