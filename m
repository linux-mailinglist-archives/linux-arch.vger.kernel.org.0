Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102FA6413D7
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiLCC5a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiLCC5a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:57:30 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCABE98A0
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:57:28 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so6723863pjg.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYhtF06rN01RiKVEwYrT8rPN0UmjLM22d78NkfSy5+o=;
        b=K2FfUaFyurPTkWOam4j+V72ut4fmD7TRNO64G3a4dBllPRstKCKXLTONhpMSIHWNfh
         LU0I4KJfF6+4lY1r3y7ihKn16vV3SDNcKKijAo6PGaXpzrMiVHhu40kJavVZbq6IYVBF
         n65aP1y46hMojSq8pi5plIXamOGD1p/1n4EWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYhtF06rN01RiKVEwYrT8rPN0UmjLM22d78NkfSy5+o=;
        b=VZQYoVf4JBWO1dcilTnjIGvcIiDWQdexyGllSK2a+jMd7wfZj2NVUu0nceo9TymlR6
         +OiJrAmZwB4sfEV53RNn6rwOQNHB7to5YOq/Q/Y17uriydE6kLa/UXSB0+zPBi8rs2JM
         RHJdh53lPLgUFjFzPhq7uJU2rqvZz+aI1pATACTCILfAT3DD+/aDJEbo0Bhvda+fg11+
         b5N0O0IqH+SZ2b6llufAhGbG2rQODSCkAHQqTbWANCXH5dYUcMPyughDjw92ZObAtuUi
         qIa04Vgf/8jcxy6SXiczFyT3girGorQLjSQbNlhR30+NwrE0gokx0YLw3ytUWe+R8nlY
         RaqQ==
X-Gm-Message-State: ANoB5pmS3SRWWZI+p5sfL1TjMa6t1GZ8H0Z9yQbZKy4K4ZdgsRj85evg
        sDMS8I4pOZJV6q94Ed1oFbiokw==
X-Google-Smtp-Source: AA0mqf4ghrT/87SBIW4BkPBsnLTei7c1aVwVG1GGksav+yaMNE43gjtLSRrT7w5HIU312oIjd2vtlA==
X-Received: by 2002:a17:902:7604:b0:189:c380:7c8d with SMTP id k4-20020a170902760400b00189c3807c8dmr3103679pll.136.1670036248021;
        Fri, 02 Dec 2022 18:57:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q100-20020a17090a17ed00b002196b5a0efesm4692751pja.47.2022.12.02.18.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:57:27 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:57:26 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Subject: Re: [PATCH v4 39/39] x86/shstk: Add ARCH_SHSTK_STATUS
Message-ID: <202212021857.938659D@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-40-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-40-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:36:06PM -0800, Rick Edgecombe wrote:
> CRIU and GDB need to get the current shadow stack and WRSS enablement
> status. This information is already available via /proc/pid/status, but
> this is incovienent for CRIU because it involves parsing the text output
> in an area of the code where this is difficult. Provide a status
> arch_prctl(), ARCH_SHSTK_STATUS for retrieving the status. Have arg2 be a
> userspace address, and make the new arch_prctl simply copy the features
> out to userspace.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Requested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> 
> v4:
>  - New patch
> 
>  Documentation/x86/shstk.rst       | 6 ++++++
>  arch/x86/include/asm/shstk.h      | 4 ++--
>  arch/x86/include/uapi/asm/prctl.h | 1 +
>  arch/x86/kernel/process_64.c      | 1 +
>  arch/x86/kernel/shstk.c           | 8 +++++++-
>  5 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/x86/shstk.rst b/Documentation/x86/shstk.rst
> index 0d7d1ccfff06..b3eb87046c27 100644
> --- a/Documentation/x86/shstk.rst
> +++ b/Documentation/x86/shstk.rst
> @@ -77,6 +77,11 @@ arch_prctl(ARCH_SHSTK_UNLOCK, unsigned long features)
>      Unlock features. 'features' is a mask of all features to unlock. All
>      bits set are processed, unset bits are ignored. Only works via ptrace.
>  
> +arch_prctl(ARCH_SHSTK_STATUS, unsigned long addr)
> +    Copy the currently enabled features to the address passed in addr. The
> +    features are described using the bits passed into the others in
> +    'features'.
> +
>  The return values are as following:
>      On success, return 0. On error, errno can be::
>  
> @@ -84,6 +89,7 @@ The return values are as following:
>          -EOPNOTSUPP if the feature is not supported by the hardware or
>           disabled by kernel parameter.
>          -EINVAL arguments (non existing feature, etc)
> +        -EFAULT if could not copy information back to userspace
>  
>  The feature's bits supported are::
>  
> diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
> index c82f22fd5e6d..23bfb63c597d 100644
> --- a/arch/x86/include/asm/shstk.h
> +++ b/arch/x86/include/asm/shstk.h
> @@ -15,7 +15,7 @@ struct thread_shstk {
>  	u64	size;
>  };
>  
> -long shstk_prctl(struct task_struct *task, int option, unsigned long features);
> +long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
>  void reset_thread_features(void);
>  int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
>  			     unsigned long stack_size,
> @@ -31,7 +31,7 @@ static inline bool shstk_enabled(void)
>  }
>  #else
>  static inline long shstk_prctl(struct task_struct *task, int option,
> -			     unsigned long features) { return -EINVAL; }
> +			     unsigned long arg2) { return -EINVAL; }
>  static inline void reset_thread_features(void) {}
>  static inline int shstk_alloc_thread_stack(struct task_struct *p,
>  					   unsigned long clone_flags,
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 0c95688cf58e..abe3fe6db6d2 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -31,6 +31,7 @@
>  #define ARCH_SHSTK_DISABLE		0x5002
>  #define ARCH_SHSTK_LOCK			0x5003
>  #define ARCH_SHSTK_UNLOCK		0x5004
> +#define ARCH_SHSTK_STATUS		0x5005
>  
>  /* ARCH_SHSTK_ features bits */
>  #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 2be6e01fb144..5dcf5426241b 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -922,6 +922,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>  	case ARCH_SHSTK_DISABLE:
>  	case ARCH_SHSTK_LOCK:
>  	case ARCH_SHSTK_UNLOCK:
> +	case ARCH_SHSTK_STATUS:
>  		return shstk_prctl(task, option, arg2);
>  	default:
>  		ret = -EINVAL;
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 95579f7bace3..05f8dcc19dbc 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -448,8 +448,14 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
>  	return alloc_shstk(addr, aligned_size, size, set_tok);
>  }
>  
> -long shstk_prctl(struct task_struct *task, int option, unsigned long features)
> +long shstk_prctl(struct task_struct *task, int option, unsigned long arg2)
>  {
> +	unsigned long features = arg2;
> +
> +	if (option == ARCH_SHSTK_STATUS) {
> +		return put_user(task->thread.features, (unsigned long __user *)arg2);
> +	}

Doesn't need the braces, but that's fine by me.

Reviewed-by: Kees Cook <keescook@chromium.org>

> +
>  	if (option == ARCH_SHSTK_LOCK) {
>  		task->thread.features_locked |= features;
>  		return 0;
> -- 
> 2.17.1
> 

-- 
Kees Cook
