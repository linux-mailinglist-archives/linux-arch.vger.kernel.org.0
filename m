Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8DD5F3604
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 21:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJCTCG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 15:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJCTCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 15:02:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E9F2C12E
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 12:02:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x6so5220664pll.11
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jpaG3SrEmgSBAm16nhnpNwprOxeW2H3keLquV2/wBXQ=;
        b=gEE5lkKG7BExD++0qu/8MiwYA2SzP1xrc3xdMYGJ1kuzuMHTVOAP1I1fgKeMZMdIgO
         fjwcaKbKXaJuAOkAhjE9NgnG53BafRqFmKTVcg0QW8EknJ2kwabXqVFJxiVqBom2y3t3
         IMeZGnsbBh1FGNURLn+pM7KSOLcfZzJycr5do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jpaG3SrEmgSBAm16nhnpNwprOxeW2H3keLquV2/wBXQ=;
        b=0xnuBNgvn9bhGc3KHeJBYfR3NJ2/z2jAKoqTz7X1I3DkC2P0sVG5BNASgcsAwbqzXV
         b7Z2Lj8Z1x6/jw2WLudiOVfKx4AbOeWPtRgdkDRW/l0qdeKRdYFchKCGk4vUgRo+lu1c
         gJpNcojtYuU8d/LOp4ojdv//H36Y+qjtvvLwuqa7/UGidLsI8MFGArEyuF4Yuaegtc1G
         cglI3OwnfGitBXPNGhfibAhGTD1agURj8j1a6TQYx12/ru0UyPlvGZQ2QKyowwdmDKEm
         O4cDaYx94w+7qUqEKv57LblybjC98pCUj9SobJvoxgverXdNNMqU1trOca+PwWluRg8b
         gXiQ==
X-Gm-Message-State: ACrzQf1t2dpCMefdQ5JHEfFNddbSAS4j1ptE8oErt8IiuoiccOgvqm9O
        7M/2G3YBpHcRPJdJx+5lfLR+Gw==
X-Google-Smtp-Source: AMsMyM7iEJ6ZXFVkmMaqs2OMbOTsAAmyiAUm7DQD5ClE0HPGFpaU7EluMkgUVp/2nJ+cWAmuLqN/dA==
X-Received: by 2002:a17:902:d2c6:b0:17f:592b:35dd with SMTP id n6-20020a170902d2c600b0017f592b35ddmr6935870plc.172.1664823721399;
        Mon, 03 Oct 2022 12:02:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s17-20020a170903215100b00173411a4385sm7536367ple.43.2022.10.03.12.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:02:00 -0700 (PDT)
Date:   Mon, 3 Oct 2022 12:01:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
Message-ID: <202210031141.0E0DE2CAEE@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-24-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-24-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:20PM -0700, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Add three new arch_prctl() handles:
> 
>  - ARCH_CET_ENABLE/DISABLE enables or disables the specified
>    feature. Returns 0 on success or an error.
> 
>  - ARCH_CET_LOCK prevents future disabling or enabling of the
>    specified feature. Returns 0 on success or an error
> 
> The features are handled per-thread and inherited over fork(2)/clone(2),
> but reset on exec().
> 
> This is preparation patch. It does not impelement any features.

typo: "implement"

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> [tweaked with feedback from tglx]
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> 
> v2:
>  - Only allow one enable/disable per call (tglx)
>  - Return error code like a normal arch_prctl() (Alexander Potapenko)
>  - Make CET only (tglx)
> 
>  arch/x86/include/asm/cet.h        | 20 ++++++++++++++++
>  arch/x86/include/asm/processor.h  |  3 +++
>  arch/x86/include/uapi/asm/prctl.h |  6 +++++
>  arch/x86/kernel/process.c         |  4 ++++
>  arch/x86/kernel/process_64.c      |  5 +++-
>  arch/x86/kernel/shstk.c           | 38 +++++++++++++++++++++++++++++++
>  6 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/include/asm/cet.h
>  create mode 100644 arch/x86/kernel/shstk.c
> 
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> new file mode 100644
> index 000000000000..0fa4dbc98c49
> --- /dev/null
> +++ b/arch/x86/include/asm/cet.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_CET_H
> +#define _ASM_X86_CET_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +
> +struct task_struct;
> +
> +#ifdef CONFIG_X86_SHADOW_STACK
> +long cet_prctl(struct task_struct *task, int option,
> +		      unsigned long features);
> +#else
> +static inline long cet_prctl(struct task_struct *task, int option,
> +		      unsigned long features) { return -EINVAL; }
> +#endif /* CONFIG_X86_SHADOW_STACK */
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_X86_CET_H */
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 356308c73951..a92bf76edafe 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -530,6 +530,9 @@ struct thread_struct {
>  	 */
>  	u32			pkru;
>  
> +	unsigned long		features;
> +	unsigned long		features_locked;

Should these be wrapped in #ifdef CONFIG_X86_SHADOW_STACK (or
CONFIG_X86_CET) ?

Also, just named "features"? Is this expected to be more than CET?

> +
>  	/* Floating point and extended processor state */
>  	struct fpu		fpu;
>  	/*
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 500b96e71f18..028158e35269 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -20,4 +20,10 @@
>  #define ARCH_MAP_VDSO_32		0x2002
>  #define ARCH_MAP_VDSO_64		0x2003
>  
> +/* Don't use 0x3001-0x3004 because of old glibcs */
> +
> +#define ARCH_CET_ENABLE			0x4001
> +#define ARCH_CET_DISABLE		0x4002
> +#define ARCH_CET_LOCK			0x4003
> +
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 58a6ea472db9..034880311e6b 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -367,6 +367,10 @@ void arch_setup_new_exec(void)
>  		task_clear_spec_ssb_noexec(current);
>  		speculation_ctrl_update(read_thread_flags());
>  	}
> +
> +	/* Reset thread features on exec */
> +	current->thread.features = 0;
> +	current->thread.features_locked = 0;

Same ifdef question here.

>  }
>  
>  #ifdef CONFIG_X86_IOPL_IOPERM
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 1962008fe743..8fa2c2b7de65 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -829,7 +829,10 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>  	case ARCH_MAP_VDSO_64:
>  		return prctl_map_vdso(&vdso_image_64, arg2);
>  #endif
> -
> +	case ARCH_CET_ENABLE:
> +	case ARCH_CET_DISABLE:
> +	case ARCH_CET_LOCK:
> +		return cet_prctl(task, option, arg2);
>  	default:
>  		ret = -EINVAL;
>  		break;

I remain annoyed that prctl interfaces didn't use -ENOTSUP for "unknown
option". :P

> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> new file mode 100644
> index 000000000000..e3276ac9e9b9
> --- /dev/null
> +++ b/arch/x86/kernel/shstk.c

I think the Makefile addition should be moved from "x86/cet/shstk:
Add user-mode shadow stack support" to here, yes? Otherwise, there is a
bisectability randconfig-with-CONFIG_X86_SHADOW_STACK risk here (nothing
will implement "cet_prctl").

> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * shstk.c - Intel shadow stack support
> + *
> + * Copyright (c) 2021, Intel Corporation.
> + * Yu-cheng Yu <yu-cheng.yu@intel.com>
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/bitops.h>
> +#include <asm/prctl.h>
> +
> +long cet_prctl(struct task_struct *task, int option, unsigned long features)
> +{
> +	if (option == ARCH_CET_LOCK) {
> +		task->thread.features_locked |= features;
> +		return 0;
> +	}
> +
> +	/* Don't allow via ptrace */
> +	if (task != current)
> +		return -EINVAL;

... but locking _is_ allowed via ptrace? If that intended, it should be
explicitly mentioned in the commit log and in a comment here.

Also, perhaps -ESRCH ?

> +
> +	/* Do not allow to change locked features */
> +	if (features & task->thread.features_locked)
> +		return -EPERM;
> +
> +	/* Only support enabling/disabling one feature at a time. */
> +	if (hweight_long(features) > 1)
> +		return -EINVAL;

Perhaps -E2BIG ?

> +	if (option == ARCH_CET_DISABLE) {
> +		return -EINVAL;
> +	}
> +
> +	/* Handle ARCH_CET_ENABLE */
> +	return -EINVAL;
> +}
> -- 
> 2.17.1
> 

-- 
Kees Cook
