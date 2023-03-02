Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE116A8291
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 13:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCBMse (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 07:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBMsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 07:48:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B418B2B;
        Thu,  2 Mar 2023 04:48:32 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBA871EC04F0;
        Thu,  2 Mar 2023 13:48:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677761310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4MfiBkMkz5ebUfMAXrylF6PkikHE4wLk3HTn0lHaOb8=;
        b=R49PSVoU67TzEd1On6SpyLZ5WN+gqAjISYxKzodjcp2/ghuXDA5b8QNG5KBnMO6cXj5YsF
        WpCPRF0NmdOGSrDnKXws+eFjaG91CTVWNqlrOkaSjyjNIHM7nBkjL7+VWFZt1SHGYHoUg0
        xc2yxp3B4WH91qCi1Cnu2Lbg6fCdzg4=
Date:   Thu, 2 Mar 2023 13:48:21 +0100
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
        david@redhat.com, debug@rivosinc.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v7 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Message-ID: <ZACbFc55bcVYRXpG@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-15-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-15-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:30PM -0800, Rick Edgecombe wrote:
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 0646ad00178b..56b374d1bffb 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -21,7 +21,8 @@
>  #define _PAGE_BIT_SOFTW2	10	/* " */
>  #define _PAGE_BIT_SOFTW3	11	/* " */
>  #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
> -#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
> +#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
> +#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
>  #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
>  #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
>  #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
> @@ -34,6 +35,15 @@
>  #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
>  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>  
> +/*
> + * Indicates a Saved Dirty bit page.
> + */
> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +#define _PAGE_BIT_SAVED_DIRTY		_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
> +#else
> +#define _PAGE_BIT_SAVED_DIRTY		0
> +#endif
> +
>  /* If _PAGE_BIT_PRESENT is clear, we use these: */
>  /* - if the user mapped it with PROT_NONE; pte_present gives true */
>  #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
> @@ -117,6 +127,25 @@
>  #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
>  #endif
>  
> +/*
> + * The hardware requires shadow stack to be Write=0,Dirty=1. However,
> + * there are valid cases where the kernel might create read-only PTEs that
> + * are dirty (e.g., fork(), mprotect(), uffd-wp(), soft-dirty  tracking). In
> + * this case, the _PAGE_SAVED_DIRTY bit is used instead of the HW-dirty bit,
> + * to avoid creating a wrong "shadow stack" PTEs. Such PTEs have
> + * (Write=0,SavedDirty=1,Dirty=0) set.
> + *
> + * Note that on processors without shadow stack support, the 

.git/rebase-apply/patch:154: trailing whitespace.
 * Note that on processors without shadow stack support, the 
warning: 1 line adds whitespace errors.

Hm, apparently git checks for that too - not only trailing empty lines.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
