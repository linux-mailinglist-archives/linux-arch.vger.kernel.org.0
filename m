Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910C0301BCC
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbhAXMXK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 07:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbhAXMXJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 07:23:09 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5D7C061573;
        Sun, 24 Jan 2021 04:22:29 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 31so5885095plb.10;
        Sun, 24 Jan 2021 04:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=CRaVGlQqRX3eurTgpUbO4LACsIgYJz7bYMhi3+skM5w=;
        b=bKuMIpY94qcNZor5JJbg9y1rkV+5c8vEcy8sNNmZrJUwLgNFSRZhf+all1fV932huz
         wST13It32l8icQp15BnImsizqjvbJQLYNhoL7x7ZRkgBgcOfNuR8Oy0kVPUtgd1ORKS6
         JEyqT1VlF3ILsaDXQZtPvomWZNaQJnlMIURLJq0oMoqXmWEnsJ9AEU7HJ5sPiJoq/dOm
         vwEBo/rNNqQJZ9HFhwjQUVLozjNpoyus8kim5gwC4+mChA5Y9Kan3xIm7TjU2jav6WrC
         5DV23rzG1YktYfARiBniJtFxlEvfZYmXbYjVn2fO51jteM+KsG+O3Dr62VcXSAjmPccp
         gqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=CRaVGlQqRX3eurTgpUbO4LACsIgYJz7bYMhi3+skM5w=;
        b=G/j8l49aPOXHpQ2f5K8vAdK+CUdPKepE9/lsSvs2D2B4hjOQZ8iR2dOW30pz+zgTQ0
         uiBxb1zftOBr8/THW0IwihAcselRFESMlOq30tyFMeUDgS5WDKQAkgsSoY+/bbl1dNrA
         IRCJGmFb14UlIBr00PXY6VeFB81OsBEfNlAE4X637BNHkZOfL2rWEz+dyhfFUuMS0T2f
         yGdUSILh6njkjWnnlg/IrUhOHM8V6k8+fToXZMbbFmT6XoivcJkY5dh4XLlMtXMDVRCP
         g+y2uYXRmbb3l99ERILBSxg4uXILH0n1VsSYJ+z9JoizCMk1wJKaLBrJO38BBviI9/di
         ks7Q==
X-Gm-Message-State: AOAM531fmM+RnULb6XG/u6J7/HxB2ZWvqOly1YimIiPSq83cbdOOU7fo
        u8AakT8NmJsDOWBddZpsT6A=
X-Google-Smtp-Source: ABdhPJy/cCBq2SaALYuvfokncGx1EYWoF3TIXnlyNQ1FvlbAreoJvYPu98Y/UK3bgTxLg0uNGqM4cA==
X-Received: by 2002:a17:90a:de97:: with SMTP id n23mr7464729pjv.216.1611490949139;
        Sun, 24 Jan 2021 04:22:29 -0800 (PST)
Received: from localhost ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id 5sm13830020pff.125.2021.01.24.04.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 04:22:28 -0800 (PST)
Date:   Sun, 24 Jan 2021 22:22:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v10 05/12] mm: HUGE_VMAP arch support cleanup
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ding Tianhong <dingtianhong@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20210124082230.2118861-1-npiggin@gmail.com>
        <20210124082230.2118861-6-npiggin@gmail.com>
        <20210124114008.GE694255@infradead.org>
In-Reply-To: <20210124114008.GE694255@infradead.org>
MIME-Version: 1.0
Message-Id: <1611489959.87u9aj91nf.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christoph Hellwig's message of January 24, 2021 9:40 pm:
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
>=20
> Shouldn't the be inlines or macros?  Also it would be useful
> if the architectures would not have to override all functions
> but just those that are it actually implements?

It gets better in the next patches. I did it this way again to avoid=20
moving a lot of code at the same time as changing name / prototype
slightly.

I didn't see individual generic fallbacks being all that useful really=20
at this scale. I don't mind keeping the explicit false.

> Also lots of > 80 char lines in the patch.

Yeah there's a few, I can reduce those.

Thanks,
Nick
