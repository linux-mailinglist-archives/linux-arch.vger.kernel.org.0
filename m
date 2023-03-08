Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818BB6B0435
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 11:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCHK2U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 05:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCHK2R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 05:28:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1869ECC;
        Wed,  8 Mar 2023 02:28:11 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A29E81EC0104;
        Wed,  8 Mar 2023 11:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678271289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QUSal8yLRZqvOQ34incj8gT6TWJsFqJ8/OvBTCTsShk=;
        b=qKM1WjO9F9dXO6k5BZ17YhP7pKauIgrnWTcEAhizPLCqjIUDtUBoqz9Vv7RlAmfM7ENNcX
        Np7CELn8CU+Qrg3p56Rww0dIFPR7Hx8s81XMMztPWSMC3ak4lXSGrlcQPEiXxVGph6KZkV
        fp3eA1tDCcaGYqrcE+cPk4ynDNL4gOU=
Date:   Wed, 8 Mar 2023 11:27:56 +0100
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
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Message-ID: <ZAhjLAIm91rJ2Lpr@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-29-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-29-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:44PM -0800, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Add three new arch_prctl() handles:
> 
>  - ARCH_SHSTK_ENABLE/DISABLE enables or disables the specified
>    feature. Returns 0 on success or an error.

"... or a negative value on error."

>  - ARCH_SHSTK_LOCK prevents future disabling or enabling of the
>    specified feature. Returns 0 on success or an error

ditto.

What is the use case of the feature locking?

I'm under the simple assumption that once shstk is enabled for an app,
it remains so. I guess my question is rather, what's the use case for
enabling shadow stack and then disabling it later for an app...?

> The features are handled per-thread and inherited over fork(2)/clone(2),
> but reset on exec().
> 
> This is preparation patch. It does not implement any features.

That belongs under the "---" line I guess.

> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> [tweaked with feedback from tglx]
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> v4:
>  - Remove references to CET and replace with shadow stack (Peterz)
> 
> v3:
>  - Move shstk.c Makefile changes earlier (Kees)
>  - Add #ifdef around features_locked and features (Kees)
>  - Encapsulate features reset earlier in reset_thread_features() so
>    features and features_locked are not referenced in code that would be
>    compiled !CONFIG_X86_USER_SHADOW_STACK. (Kees)
>  - Fix typo in commit log (Kees)
>  - Switch arch_prctl() numbers to avoid conflict with LAM
> 
> v2:
>  - Only allow one enable/disable per call (tglx)
>  - Return error code like a normal arch_prctl() (Alexander Potapenko)
>  - Make CET only (tglx)
> ---
>  arch/x86/include/asm/processor.h  |  6 +++++
>  arch/x86/include/asm/shstk.h      | 21 +++++++++++++++
>  arch/x86/include/uapi/asm/prctl.h |  6 +++++
>  arch/x86/kernel/Makefile          |  2 ++
>  arch/x86/kernel/process_64.c      |  7 ++++-
>  arch/x86/kernel/shstk.c           | 44 +++++++++++++++++++++++++++++++
>  6 files changed, 85 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/include/asm/shstk.h
>  create mode 100644 arch/x86/kernel/shstk.c

...

> +long shstk_prctl(struct task_struct *task, int option, unsigned long features)
> +{
> +	if (option == ARCH_SHSTK_LOCK) {
> +		task->thread.features_locked |= features;
> +		return 0;
> +	}
> +
> +	/* Don't allow via ptrace */
> +	if (task != current)
> +		return -EINVAL;
> +
> +	/* Do not allow to change locked features */
> +	if (features & task->thread.features_locked)
> +		return -EPERM;
> +
> +	/* Only support enabling/disabling one feature at a time. */
> +	if (hweight_long(features) > 1)
> +		return -EINVAL;
> +
> +	if (option == ARCH_SHSTK_DISABLE) {
> +		return -EINVAL;
> +	}

{} braces left over from some previous version. Can go now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
