Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3A226690C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 21:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIKTkG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 15:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgIKTkD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 15:40:03 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C33C061757
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 12:40:02 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h6so8795232qtd.6
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BK+tuqq8QDNrIoMgEZ8skJmt+wwLfpOudGjevs6T6M8=;
        b=pR94XQptn8bYWaLD/i62y0BbH4X2j7wiJqZGlqseUoyJZSGJ0zI0HKYeJ35DMYKrYj
         WbhjcV6+xwWxfqIPSocDLvuU4le3AHcBTI0Kkw63m7PTGBSfCFh8H4C0gtlUJ6ddWvCd
         XcdsVVT9YWUzwHhTOFC4l3Lbeao4TtBRlS8AFvOhX/pLbALT6BgXMIp8At2yTcyVWT+X
         /Gi+2KyTFER9vciFK2XRsy2Nx/3JqByhLTyHCxqiGpqrTEcqOAYJOLnNIo+XUP+DsmVi
         X10VcO/OtSw+SdWqS+NdVAAiGzoxEsRPjZQhGjyOxN9ZUZUawxj+MaNI5ivGNv9YOJ5y
         bbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BK+tuqq8QDNrIoMgEZ8skJmt+wwLfpOudGjevs6T6M8=;
        b=X5/xPjfARgmmZYWJgOHPFDyQv/NPuC1IC3yQnv64mqIwXkxjXcafs2uKMyByI59iuo
         ysCU+V9wWu09O3UVkKeem1slsEKyCHbw3zPYZqh6E7G6Qy6vMCJIfimiF2aEXA1wNb7C
         Eu+xVOM1wybkVFIGrgl9HtYv9qOHMQzvSvtzr0uSOaK1eVu1hdlpqRIgvuzXfvNka4yf
         L0fwy0UxTRKrNh7JX5ftbRjudvMJgyX0UwOW5iLfJJemxjf35KesHxcQVXI7GTMioBml
         11KK2UjixBMAvndTzlW/af8xqBX1GKka/wX/jdZiiSnCeLW9avDoMzYbE7cUDjbDJ8qu
         JKhA==
X-Gm-Message-State: AOAM53231fhXjzdYQp9iK4s3IUdkGcxZ8eL/+sC5kk+hYP1yGDwEn4C2
        MlHnsSY5gGmc2OAugH0Lx+Rahw==
X-Google-Smtp-Source: ABdhPJxer3roPhN5O41vGECqY/2AzhDkztmY22iufRFTo4PTGgzF7YR4n8VSHFjV/DPaACcXuMPDOw==
X-Received: by 2002:ac8:3a06:: with SMTP id w6mr3467667qte.255.1599853201602;
        Fri, 11 Sep 2020 12:40:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o4sm3733647qkk.75.2020.09.11.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 12:40:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGots-0059mB-64; Fri, 11 Sep 2020 16:40:00 -0300
Date:   Fri, 11 Sep 2020 16:40:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH] mm/gup: fix gup_fast with dynamic page table folding
Message-ID: <20200911194000.GB1221970@ziepe.ca>
References: <20200911070939.GB1362448@hirez.programming.kicks-ass.net>
 <patch.git-2c4880212370.your-ad-here.call-01599849957-ext-4686@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch.git-2c4880212370.your-ad-here.call-01599849957-ext-4686@work.hours>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 11, 2020 at 09:03:06PM +0200, Vasily Gorbik wrote:
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e8cbc2e795d5..e899d3506671 100644
> +++ b/include/linux/pgtable.h
> @@ -1427,6 +1427,16 @@ typedef unsigned int pgtbl_mod_mask;
>  #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>  #endif
>  
> +#ifndef p4d_offset_lockless
> +#define p4d_offset_lockless(pgdp, pgd, address) p4d_offset(&pgd, address)
> +#endif
> +#ifndef pud_offset_lockless
> +#define pud_offset_lockless(p4dp, p4d, address) pud_offset(&p4d, address)
> +#endif
> +#ifndef pmd_offset_lockless
> +#define pmd_offset_lockless(pudp, pud, address) pmd_offset(&pud, address)

Needs brackets: &(pgd) 

These would probably be better as static inlines though, as only s390
compiles will type check pudp like this.

Jason
