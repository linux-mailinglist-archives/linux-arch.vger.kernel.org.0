Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB10207BB8
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405969AbgFXSph (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 14:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405581AbgFXSph (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:45:37 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3422081A;
        Wed, 24 Jun 2020 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593024337;
        bh=E6OIJZbTsXd21Iy1/vA8hcrT6xT8e3j93Tf+tQvTOd0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aJJ1kYS2JPdRjBiUDYlM1E78ZAi58Fy8LC3g2QYZh12Sn2tApP6Kwm7cI4tu/pu61
         Sl/mqCEM0Tu/Q/bGjgux7NDEVs/kzhMSJy7EVQJr1PBu/ghV1L777kBPawqt+VfAf4
         CGOgekjAlBc2SccextFmczx29bANPvB4Figc71Zc=
Date:   Wed, 24 Jun 2020 11:45:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v5 21/25] mm: Add arch hooks for saving/restoring tags
Message-Id: <20200624114534.9520ba5ed235bc32bf1af3a2@linux-foundation.org>
In-Reply-To: <20200624175244.25837-22-catalin.marinas@arm.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
        <20200624175244.25837-22-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 Jun 2020 18:52:40 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> From: Steven Price <steven.price@arm.com>
> 
> Arm's Memory Tagging Extension (MTE) adds some metadata (tags) to
> every physical page, when swapping pages out to disk it is necessary to
> save these tags, and later restore them when reading the pages back.
> 
> Add some hooks along with dummy implementations to enable the
> arch code to handle this.
> 
> Three new hooks are added to the swap code:
>  * arch_prepare_to_swap() and
>  * arch_swap_invalidate_page() / arch_swap_invalidate_area().
> One new hook is added to shmem:
>  * arch_swap_restore_tags()
> 
> ...
>
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -631,6 +631,29 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> +static inline int arch_prepare_to_swap(struct page *page)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#ifndef __HAVE_ARCH_SWAP_INVALIDATE
> +static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> +{
> +}
> +
> +static inline void arch_swap_invalidate_area(int type)
> +{
> +}
> +#endif
> +
> +#ifndef __HAVE_ARCH_SWAP_RESTORE_TAGS
> +static inline void arch_swap_restore_tags(swp_entry_t entry, struct page *page)
> +{
> +}
> +#endif

Presumably these three __HAVE_ARCH_ macros are to be defined in asm/pgtable.h?

Acked-by: Andrew Morton <akpm@linux-foundation.org>

