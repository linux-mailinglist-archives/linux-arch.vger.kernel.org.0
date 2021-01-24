Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11662301B75
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 12:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbhAXLmF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 06:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbhAXLmE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 06:42:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF84C061573;
        Sun, 24 Jan 2021 03:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M3FSAWCV2zmyTdtnVy67d93WEezl2jaS3Y+9V7bxgfg=; b=TIp1qmX+Wc+PSElTTUMYQCiVsq
        byjIKNxpCDGZTlBLtYSCfzzBQ/svyQIdDu8hmDtW57KcoQgW4aMH8avBI7mkjFI66OoQe4tP6TXY+
        VntHOHWgpyQaw54rxeyxKYBsI4YiaNhltMoEV3QvqI+fYWJOLY+uZsHc97xgSqpC+RFRUzNVB+Dal
        4ucRF9Z02bGcU7dN2MBNgHSDeanSSmIEuyLn1FMgjM5GYDzQL6dd0R9c+ur3uNZHpHYf3faGylVML
        qd31reJoqDmyOsc47wypl/AVuY1rQoeVIPwisZOoFAY3IKgbNNtBUVwdUf5XD4bi9xxwtQn9Vh4zg
        /VGZlMAg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3dkW-002v8C-GD; Sun, 24 Jan 2021 11:40:29 +0000
Date:   Sun, 24 Jan 2021 11:40:08 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v10 05/12] mm: HUGE_VMAP arch support cleanup
Message-ID: <20210124114008.GE694255@infradead.org>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124082230.2118861-6-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index 2ca708ab9b20..597b40405319 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -1,4 +1,12 @@
>  #ifndef _ASM_ARM64_VMALLOC_H
>  #define _ASM_ARM64_VMALLOC_H
>  
> +#include <asm/page.h>
> +
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +bool arch_vmap_p4d_supported(pgprot_t prot);
> +bool arch_vmap_pud_supported(pgprot_t prot);
> +bool arch_vmap_pmd_supported(pgprot_t prot);
> +#endif

Shouldn't the be inlines or macros?  Also it would be useful
if the architectures would not have to override all functions
but just those that are it actually implements?

Also lots of > 80 char lines in the patch.
