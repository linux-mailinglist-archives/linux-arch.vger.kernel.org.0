Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D418832ED22
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 15:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhCEO34 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 09:29:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49364 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhCEO3s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 09:29:48 -0500
Received: from zn.tnic (p200300ec2f0b9500a5847b5a228c2b11.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9500:a584:7b5a:228c:2b11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 378C51EC0521;
        Fri,  5 Mar 2021 15:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614954586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=756DJLydScKg6OQ7shRw8IU5LHdGM90c3wF/c6DK94s=;
        b=hB7qolct0HXVDkhC+NG1uce7LdVUT17tmjPoMVViUOt2acE0eZclGgP6iTc6kLwqmWh5zz
        WXVbm2MGRnH4V8aBErUPvI2qeTMbqEQUFgpMTGb/KqMEER4gscnxIleMXQj/axZ83IpEqn
        6P/a5HbB25LXW8wJeDLnwpqgIgh3j4k=
Date:   Fri, 5 Mar 2021 15:29:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v21 10/26] x86/mm: Update pte_modify for _PAGE_COW
Message-ID: <20210305142940.GC2685@zn.tnic>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-11-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217222730.15819-11-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 17, 2021 at 02:27:14PM -0800, Yu-cheng Yu wrote:
> @@ -787,16 +802,34 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  	 */
>  	val &= _PAGE_CHG_MASK;
>  	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
> +	val = fixup_dirty_pte(val);

Do I see it correctly that you can do here and below:

	/*
	 * Fix up potential shadow stack page flags because the RO, Dirty PTE is
	 * special.
	 */
	if (pte_dirty()) {
		pte_mkclean();
		pte_mkdirty();
	}

?

That fixup thing looks grafted and not like a normal flow to me.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
