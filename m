Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B135FF2CF
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiJNRMz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiJNRMy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 13:12:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE6F8E782;
        Fri, 14 Oct 2022 10:12:53 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 864DA1EC0731;
        Fri, 14 Oct 2022 19:12:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665767567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+EYBcfkVNy99Prgg508di+96dEqLLAK9qFDJ8Xcfxdg=;
        b=b22IDJ7VlnTcVzaDIlOVqru2/dYLiTv0JFljcboinwtN21OTqd5okpwv6ZA6heznM/CbCw
        5fxuDDzM103FZ/4e7f16Ctfe2epR2FIGi+sklkTfwoLxbh57cvMIozN9RlYhlKSUSsOaXi
        7rlcQcZVUlBm+B9APq8gNrIXtrniSNU=
Date:   Fri, 14 Oct 2022 19:12:41 +0200
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
Subject: Re: [PATCH v2 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Message-ID: <Y0mYib7ygyxbiZ2K@zn.tnic>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-5-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-5-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:01PM -0700, Rick Edgecombe wrote:
>  static __always_inline void setup_cet(struct cpuinfo_x86 *c)
>  {
> -	u64 msr = CET_ENDBR_EN;
> +	bool kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);

So I'd love it if we can get rid of that HAS_KERNEL_IBT thing and use
the usual ifdeffery with Kconfig symbols. I wouldn't like for yet
another HAS_XXX feature checking method to proliferate as this is the
only one:

$ git grep -E "\WHAS_" arch/x86/
arch/x86/include/asm/ibt.h:18: * When all the above are satisfied, HAS_KERNEL_IBT will be 1, otherwise 0.
arch/x86/include/asm/ibt.h:22:#define HAS_KERNEL_IBT    1
arch/x86/include/asm/ibt.h:92:#define HAS_KERNEL_IBT    0
arch/x86/include/asm/ibt.h:114:#define ENDBR_INSN_SIZE          (4*HAS_KERNEL_IBT)
arch/x86/include/asm/idtentry.h:8:#define IDT_ALIGN     (8 * (1 + HAS_KERNEL_IBT))
arch/x86/kernel/cpu/common.c:601:       bool kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);
arch/x86/kernel/cpu/common.c:1942:      if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))

>  __noendbr void cet_disable(void)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_IBT))
> -		wrmsrl(MSR_IA32_S_CET, 0);
> +	if (!(cpu_feature_enabled(X86_FEATURE_IBT) ||
> +	      cpu_feature_enabled(X86_FEATURE_SHSTK)))
> +		return;
> +
> +	wrmsrl(MSR_IA32_S_CET, 0);
> +	wrmsrl(MSR_IA32_U_CET, 0);
>  }
>  
> +

Stray newline.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
