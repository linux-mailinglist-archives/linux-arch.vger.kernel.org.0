Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7183538512
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfFGHbb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 03:31:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47234 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGHbb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 03:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z4s1HU+Ta9EFcVv62Up/dxFFdolam58FxKGBkLAELZE=; b=PrfN5Q8zV0PMbJwOh2nSW0qEu
        whA3bMeZqjYW6FVebCOMZ+jOWcBf+KwA1YjMeNgOsUt0oXjsFsVtbgVjMkkSB2lXZiVsntQd5nIpO
        GW/QhqhGfYGi3P0N9Kz2wphjaFQrHbOZos1aDDyNXV9IIbRjza8ZimXKp7rc3KXCR2qUaIUDiJx4D
        5rSOUPZEafMrNVJUJROE8lISqEQD1e32yciSw6rgIUWvfgxL1u89OkOz+Hdjo60eCuPyV4oJuq5ZI
        jCvlk67LYXzyPmh1q9o9aYoPPzyR0KFRwE/m9d1Eb5wGETSQGDQ/SGHQzPTldrqSlG+aLohd+cQ4E
        nfdyfn8hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hZ9Kx-0002HQ-Ah; Fri, 07 Jun 2019 07:30:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4942202CD6B2; Fri,  7 Jun 2019 09:30:52 +0200 (CEST)
Date:   Fri, 7 Jun 2019 09:30:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 15/27] mm: Handle shadow stack page fault
Message-ID: <20190607073052.GO3419@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-16-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200646.3951-16-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 06, 2019 at 01:06:34PM -0700, Yu-cheng Yu wrote:

> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 75d9d68a6de7..ffcc0be7cadc 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1188,4 +1188,12 @@ static inline bool arch_has_pfn_modify_check(void)
>  #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>  #endif
>  
> +#ifndef CONFIG_ARCH_HAS_SHSTK
> +#define pte_set_vma_features(pte, vma) pte
> +#define arch_copy_pte_mapping(vma_flags) false

static inline pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma)
{
	return pte;
}

static inline bool arch_copy_pte_mapping(unsigned long vm_flags)
{
	return false;
}

Please, this way we retain function prototype checking.

> +#else
> +pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma);
> +bool arch_copy_pte_mapping(vm_flags_t vm_flags);
> +#endif
