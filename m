Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4105652868
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 22:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiLTV3U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 16:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiLTV3P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 16:29:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC841EAE0;
        Tue, 20 Dec 2022 13:29:14 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5517F1EC0559;
        Tue, 20 Dec 2022 22:29:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671571753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v9/xoJRbxbZ1eXDTI+dOLyl7gGf5dXshSBt7FGH5iiI=;
        b=ImWmLIAx5W2cB0d7M46w8fkIgLrn6ZbI/6eifVkfLTeSmEEK+ZGphTyC4UW7vXNHQdneB6
        Lb6L/ZD1476fVEdqgYBXF7JrJ1LciLjQ3aoInU54tbbSEAdysBUKMBJzy5KKp+hlDrqvjR
        dm6dBunVddAsbid5FvKiQscE/xm5C60=
Date:   Tue, 20 Dec 2022 22:29:13 +0100
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
Subject: Re: [PATCH v4 10/39] x86/mm: Introduce _PAGE_COW
Message-ID: <Y6IpKb6pPvYy43NO@zn.tnic>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-11-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-11-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:37PM -0800, Rick Edgecombe wrote:
> There are six bits left available to software in the 64-bit PTE after
> consuming a bit for _PAGE_COW. No space is consumed in 32-bit kernels
> because shadow stacks are not enabled there.
> 
> This is a prepratory patch. Changes to actually start marking _PAGE_COW

Unknown word [prepratory] in commit message.
Suggestions: ['preparatory',

> will follow once other pieces are in place.

And regardless, you don't really need this sentence at all, AFAICT.

...

> +/*
> + * Normally COW memory can result in Dirty=1,Write=0 PTs. But in the case
							^^^

PTEs.

> + * of X86_FEATURE_USER_SHSTK, the software COW bit is used, since the
> + * Dirty=1,Write=0 will result in the memory being treated as shaodw stack
> + * by the HW. So when creating COW memory, a software bit is used
> + * _PAGE_BIT_COW. The following functions pte_mkcow() and pte_clear_cow()
> + * take a PTE marked conventially COW (Dirty=1) and transition it to the

Unknown word [conventially] in comment.
Suggestions: ['conventionally', ...

> + * shadow stack compatible version of COW (Cow=1).
> + */
> +

^ Superfluous newline.

> +static inline pte_t pte_mkcow(pte_t pte)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pte;
> +
> +	pte = pte_clear_flags(pte, _PAGE_DIRTY);
> +	return pte_set_flags(pte, _PAGE_COW);
> +}
> +
> +static inline pte_t pte_clear_cow(pte_t pte)
> +{
> +	/*
> +	 * _PAGE_COW is unnecessary on !X86_FEATURE_USER_SHSTK kernels.

I'm guessing this "unnecessary" is supposed to mean that on kernels not
supporting shadow stack, a COW page uses the old bit flags?

I.e., Dirty=1,Write=0?

Might as well write it this way to be perfectly clear.

> +	 * See the _PAGE_COW definition for more details.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pte;
> +
> +	/*
> +	 * PTE is getting copied-on-write, so it will be dirtied
> +	 * if writable, or made shadow stack if shadow stack and
> +	 * being copied on access. Set they dirty bit for both

"Set the dirty bit.."

> +	 * cases.
> +	 */
> +	pte = pte_set_flags(pte, _PAGE_DIRTY);
> +	return pte_clear_flags(pte, _PAGE_COW);
> +}

Rest looks ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
