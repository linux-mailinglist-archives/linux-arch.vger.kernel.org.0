Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF5E24E1EF
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgHUUOY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 16:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgHUUOY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 16:14:24 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE02207CD;
        Fri, 21 Aug 2020 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598040863;
        bh=GIZSv+n11Fktxzw4XltsqI4m6vkx8INTDFrt/8602bc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jsm0SiwjyjLdaC9x30KSU052qwlMNfDxNbp/v2GTQ314YIOfB5mn0PNyo3a5HyfAT
         4sANyMs+iVHal+mEKYqfPdgxvyiLDgv11V+6Lbb/SF/R9PYsMREn8gTcrgWQaSROWb
         u9xVLheHbRwcaiQ0OLEd29483GS1ksAQUXUfNqp0=
Date:   Fri, 21 Aug 2020 13:14:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 05/12] mm: HUGE_VMAP arch support cleanup
Message-Id: <20200821131422.110abb1a0c0b6a9d378b0e48@linux-foundation.org>
In-Reply-To: <20200821151216.1005117-6-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
        <20200821151216.1005117-6-npiggin@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 22 Aug 2020 01:12:09 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> This changes the awkward approach where architectures provide init
> functions to determine which levels they can provide large mappings for,
> to one where the arch is queried for each call.
> 
> This removes code and indirection, and allows constant-folding of dead
> code for unsupported levels.
> 
> This also adds a prot argument to the arch query. This is unused
> currently but could help with some architectures (e.g., some powerpc
> processors can't map uncacheable memory with large pages).
> 
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

Moving these out of generic code and into multiple arch headers is
unfortunate.  Can we leave them in include/linux/somewhere?  And remove
the ifdefs, if so inclined - they just move the build error from
link-time to compile-time, and such an error shouldn't occur!

