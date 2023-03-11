Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350736B5C02
	for <lists+linux-arch@lfdr.de>; Sat, 11 Mar 2023 13:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCKMyy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Mar 2023 07:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCKMyu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Mar 2023 07:54:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FB9FAD46;
        Sat, 11 Mar 2023 04:54:48 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 838581EC0674;
        Sat, 11 Mar 2023 13:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678539287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zybHWV8PE9KVm+sFWMv0UYUKNm9Tpjr7UOQFLCyy5YE=;
        b=BtmLwAFpkPLa/WArXaNCrHBKIkVBveX2pmmKS+AAxuWYpoSOD0oMespV4auQrNfdSSyBYh
        dfawy8RSb52e5PTjaba6jbvZistFL2o+WvYrpJeDz+ABZmRsfslwvbdXu5BgDduz7rQylT
        sC06QXcajrk8qGgnHUsUWsiGXZDuWHg=
Date:   Sat, 11 Mar 2023 13:54:42 +0100
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
        david@redhat.com, debug@rivosinc.com
Subject: Re: [PATCH v7 38/41] x86/fpu: Add helper for initing features
Message-ID: <ZAx6Egh6U5SCZEby@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-39-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-39-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:54PM -0800, Rick Edgecombe wrote:
> Subject: Re: [PATCH v7 38/41] x86/fpu: Add helper for initing features

"initializing"

> If an xfeature is saved in a buffer, the xfeature's bit will be set in
> xsave->header.xfeatures. The CPU may opt to not save the xfeature if it
> is in it's init state. In this case the xfeature buffer address cannot

"its"

> be retrieved with get_xsave_addr().
> 
> Future patches will need to handle the case of writing to an xfeature
> that may not be saved. So provide helpers to init an xfeature in an
> xsave buffer.
> 
> This could of course be done directly by reaching into the xsave buffer,
> however this would not be robust against future changes to optimize the
> xsave buffer by compacting it. In that case the xsave buffer would need
> to be re-arranged as well. So the logic properly belongs encapsulated
> in a helper where the logic can be unified.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> v2:
>  - New patch
> ---
>  arch/x86/kernel/fpu/xstate.c | 58 +++++++++++++++++++++++++++++-------
>  arch/x86/kernel/fpu/xstate.h |  6 ++++
>  2 files changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 13a80521dd51..3ff80be0a441 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -934,6 +934,24 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>  	return (void *)xsave + xfeature_get_offset(xcomp_bv, xfeature_nr);
>  }
>  
> +static int xsave_buffer_access_checks(int xfeature_nr)

Function name needs a verb.

> +{
> +	/*
> +	 * Do we even *have* xsave state?
> +	 */

That comment is superfluous.

> +	if (!boot_cpu_has(X86_FEATURE_XSAVE))

check_for_deprecated_apis: WARNING: arch/x86/kernel/fpu/xstate.c:942: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

> +		return 1;
> +
> +	/*
> +	 * We should not ever be requesting features that we

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

> +	 * have not enabled.
> +	 */
> +	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  /*
>   * Given the xsave area and a state inside, this function returns the
>   * address of the state.
> @@ -954,17 +972,7 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>   */
>  void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>  {
> -	/*
> -	 * Do we even *have* xsave state?
> -	 */
> -	if (!boot_cpu_has(X86_FEATURE_XSAVE))
> -		return NULL;
> -
> -	/*
> -	 * We should not ever be requesting features that we
> -	 * have not enabled.
> -	 */
> -	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
> +	if (xsave_buffer_access_checks(xfeature_nr))
>  		return NULL;
>  
>  	/*
> @@ -984,6 +992,34 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>  	return __raw_xsave_addr(xsave, xfeature_nr);
>  }
>  
> +/*
> + * Given the xsave area and a state inside, this function
> + * initializes an xfeature in the buffer.

s/this function initializes/initialize/

> + *
> + * get_xsave_addr() will return NULL if the feature bit is
> + * not present in the header. This function will make it so
> + * the xfeature buffer address is ready to be retrieved by
> + * get_xsave_addr().

So users of get_xsave_addr() would have to know that they would need to
call init_xfeature()?

I think the better approach would be:

void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr, bool init)

and then that @init controls whether get_xsave_addr() should init the
buffer.

And then you don't have to have a bunch of small functions here and
there and know when to call what but get_xsave_addr() would simply DTRT.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
