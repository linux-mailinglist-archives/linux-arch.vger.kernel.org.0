Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3A5FF985
	for <lists+linux-arch@lfdr.de>; Sat, 15 Oct 2022 11:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJOJrB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Oct 2022 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJOJrA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2022 05:47:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9535018D;
        Sat, 15 Oct 2022 02:46:58 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e79c329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e79c:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 884F61EC0531;
        Sat, 15 Oct 2022 11:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665827212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mOCTkWac8uVSFd/Mt41ebNXstiZYPl5RE7hElNiS0dc=;
        b=sPD2w+UBotPMH9OxZPAJ/j+ni1w6/2Kpg4ADVQvVkKo4cdA6FiKWUKduZYVfg6cj4lBKyh
        OSwthJeo7BAUzmiVrhLmYdZqgLJNw2z+3BzEvRGCCBLrsvPcyhYvykaTOHWL5jGLWADOjI
        by67HoeKwb/J+fBMhTUX2PSHADzlCO4=
Date:   Sat, 15 Oct 2022 11:46:49 +0200
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 05/39] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Message-ID: <Y0qBiSXdZepd7Is9@zn.tnic>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-6-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-6-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:02PM -0700, Rick Edgecombe wrote:
> Both XSAVE state components are supervisor states, even the state
> controlling user-mode operation. This is a departure from earlier features
> like protection keys where the PKRU state a normal user (non-supervisor)
^^^^^

A verb is missing in that sentence.

> +	"x87 floating point registers"			,
> +	"SSE registers"					,
> +	"AVX registers"					,
> +	"MPX bounds registers"				,
> +	"MPX CSR"					,
> +	"AVX-512 opmask"				,
> +	"AVX-512 Hi256"					,
> +	"AVX-512 ZMM_Hi256"				,
> +	"Processor Trace (unused)"			,
> +	"Protection Keys User registers"		,
> +	"PASID state"					,
> +	"Control-flow User registers"			,
> +	"Control-flow Kernel registers (unused)"	,
> +	"unknown xstate feature"			,
> +	"unknown xstate feature"			,
> +	"unknown xstate feature"			,
> +	"unknown xstate feature"			,
> +	"AMX Tile config"				,
> +	"AMX Tile data"					,
> +	"unknown xstate feature"			,

What Kees said. :)

> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_YMM,       struct ymmh_struct);
> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_BNDREGS,   struct mpx_bndreg_state);
> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_BNDCSR,    struct mpx_bndcsr_state);
> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_OPMASK,    struct avx_512_opmask_state);
> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_ZMM_Hi256, struct avx_512_zmm_uppers_state);
> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_PKRU,      struct pkru_state);
> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_PASID,     struct ia32_pasid_state);
> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_XTILE_CFG, struct xtile_cfg);
> +	XCHECK_SZ(&chked, sz, nr, XFEATURE_CET_USER,  struct cet_user_state);

That looks silly. I wonder if you could do:

	switch (nr) {
	case XFEATURE_YMM:	XCHECK_SZ(sz, XFEATURE_YMM, struct ymmh_struct);	  return;
	case XFEATURE_BNDREGS:	XCHECK_SZ(sz, XFEATURE_BNDREGS, struct mpx_bndreg_state); return;
	case ...
	...
	default:
		/* that falls into the WARN etc */

and then you get rid of the if check in the macro itself and leave the
macro be a dumb, unconditional one.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
