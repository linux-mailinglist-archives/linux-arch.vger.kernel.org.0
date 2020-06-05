Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1C1EF4FD
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jun 2020 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgFEKIT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Jun 2020 06:08:19 -0400
Received: from foss.arm.com ([217.140.110.172]:53160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgFEKIT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jun 2020 06:08:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C5CC2B;
        Fri,  5 Jun 2020 03:08:18 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9B0C3F52E;
        Fri,  5 Jun 2020 03:08:15 -0700 (PDT)
Date:   Fri, 5 Jun 2020 11:08:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 1/7] mm: Add functions to track page directory
 modifications
Message-ID: <20200605100813.GA31371@gaia>
References: <20200515140023.25469-1-joro@8bytes.org>
 <20200515140023.25469-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515140023.25469-2-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Joerg,

On Fri, May 15, 2020 at 04:00:17PM +0200, Joerg Roedel wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5a323422d783..022fe682af9e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2078,13 +2078,54 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
>  	return (unlikely(p4d_none(*p4d)) && __pud_alloc(mm, p4d, address)) ?
>  		NULL : pud_offset(p4d, address);
>  }
> +
> +static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
> +				     unsigned long address,
> +				     pgtbl_mod_mask *mod_mask)
> +
> +{
> +	if (unlikely(pgd_none(*pgd))) {
> +		if (__p4d_alloc(mm, pgd, address))
> +			return NULL;
> +		*mod_mask |= PGTBL_PGD_MODIFIED;
> +	}
> +
> +	return p4d_offset(pgd, address);
> +}
> +
>  #endif /* !__ARCH_HAS_5LEVEL_HACK */
>  
> +static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
> +				     unsigned long address,
> +				     pgtbl_mod_mask *mod_mask)
> +{
> +	if (unlikely(p4d_none(*p4d))) {
> +		if (__pud_alloc(mm, p4d, address))
> +			return NULL;
> +		*mod_mask |= PGTBL_P4D_MODIFIED;
> +	}
> +
> +	return pud_offset(p4d, address);
> +}

This patch causes a kernel panic on arm64 (and possibly powerpc, I
haven't tried). arm64 still uses the 5level-fixup.h and pud_alloc()
checks for the empty p4d with pgd_none() instead of p4d_none().

The patch below fixes it:

-----------------------8<-----------------------------------
From 8fb5f4c1e0983bb501c8ec71f9bb9dd344b80e87 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 5 Jun 2020 10:56:03 +0100
Subject: [PATCH] mm: Use pgd_none() in pud_alloc_track() with
 __ARCH_HAS_5LEVEL_HACK

Commit d8626138009b ("mm: add functions to track page directory
modifications") introduced the pud_alloc_track() function checking for
an empty p4d using p4d_none(). However, when __ARCH_HAS_5LEVEL_HACK is
defined, the pud_alloc() counterpart checks for an empty p4d using
pgd_none(). Since p4d_none() is always 0 in this case, no pud would be
allocated and the kernel panics during boot on arm64 (at least).

Until all architectures are moved away from the 5level-fixup.h, define a
pud_alloc_track() that matches the __ARCH_HAS_5LEVEL_HACK pud_alloc().

Fixes: d8626138009b ("mm: add functions to track page directory modifications")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fda41eb7f1c8..9d3761a1fad5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2106,8 +2106,6 @@ static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
 	return p4d_offset(pgd, address);
 }
 
-#endif /* !__ARCH_HAS_5LEVEL_HACK */
-
 static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
 				     unsigned long address,
 				     pgtbl_mod_mask *mod_mask)
@@ -2121,6 +2119,23 @@ static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
 	return pud_offset(p4d, address);
 }
 
+#else /* __ARCH_HAS_5LEVEL_HACK */
+
+static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
+				     unsigned long address,
+				     pgtbl_mod_mask *mod_mask)
+{
+	if (unlikely(pgd_none(*p4d))) {
+		if (__pud_alloc(mm, p4d, address))
+			return NULL;
+		*mod_mask |= PGTBL_P4D_MODIFIED;
+	}
+
+	return pud_offset(p4d, address);
+}
+
+#endif /* !__ARCH_HAS_5LEVEL_HACK */
+
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
 	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
