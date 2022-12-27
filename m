Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962A9656A01
	for <lists+linux-arch@lfdr.de>; Tue, 27 Dec 2022 12:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiL0LmU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Dec 2022 06:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiL0LmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Dec 2022 06:42:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F96064DE;
        Tue, 27 Dec 2022 03:42:18 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1109D1EC0662;
        Tue, 27 Dec 2022 12:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672141337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IObKGFkbThA5XjeCQxbGLlGThS93RX3ZjzOBl+thopA=;
        b=GvDHNzZI/cN/OBt2Mat7mWXyEqSSLZlu0VOcMIikO73MgHSCvKJo7kuh67djuy0k5dpaZ1
        fKiNN4Rukvk/O9+WwDucMJDP1Z9eavRa4fdkUqt8toBKBqDx8YrN6x6ju6JNhIaOHVl1yH
        yhYbyiessZSJOZ6FFfM+euljP04sMIk=
Date:   Tue, 27 Dec 2022 12:42:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v4 11/39] x86/mm: Update pte_modify for _PAGE_COW
Message-ID: <Y6raFBB+oVx+2WXl@zn.tnic>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-12-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-12-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:38PM -0800, Rick Edgecombe wrote:
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
> +	pteval_t _page_chg_mask_no_dirty = _PAGE_CHG_MASK & ~_PAGE_DIRTY;
>  	pteval_t val = pte_val(pte), oldval = val;
> +	pte_t pte_result;
>  
>  	/*
>  	 * Chop off the NX bit (if present), and add the NX portion of
>  	 * the newprot (if present):
>  	 */
> -	val &= _PAGE_CHG_MASK;
> -	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
> +	val &= _page_chg_mask_no_dirty;
> +	val |= check_pgprot(newprot) & ~_page_chg_mask_no_dirty;
>  	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
> -	return __pte(val);
> +
> +	pte_result = __pte(val);
> +
> +	/*
> +	 * Dirty bit is not preserved above so it can be done

Just for my own understanding: are you saying here that
flip_protnone_guard() might end up setting _PAGE_DIRTY in val...

> +	 * in a special way for the shadow stack case, where it
> +	 * needs to set _PAGE_COW. pte_mkcow() will do this in
> +	 * the case of shadow stack.
> +	 */
> +	if (pte_dirty(pte_result))
> +		pte_result = pte_mkcow(pte_result);

... and in that case we need to turn it into a _PAGE_COW setting?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
