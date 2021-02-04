Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F8030FE1A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhBDUWf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbhBDUWe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:22:34 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBBFC06121E
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:10:17 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z21so2904407pgj.4
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fX9wt//YV7HFh+TVdRSpEAtZyx53HBAsOKvt4WgJ1Yo=;
        b=YhJdPmg114YYnBjPK56CdbPVOocSGUyd5YcpH2lUejbpSb8ZonyhNOWwaQ5ULTIMZe
         T4rUfyImzEk3QwZ8qqLMepFEgoV3QdcC5Ji6AoJgtbWLHd7Wauiit5qqBpMgUzRN5YLz
         VO3JCGV1FKBKLBmmwah7xbCtIWEqnZjquY9T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fX9wt//YV7HFh+TVdRSpEAtZyx53HBAsOKvt4WgJ1Yo=;
        b=Ntbcu/fCZFy8GsHSMFay05PF4lChRyLvnBu3MzMKNeAmGNQrTeOodSc5Z8oVP/fD2a
         mnSZHSLBERMMeXANVWw/UvREr7bVzt6EDh1Jjft0h2ED2EMa/TssJRoQAKblCzpP8Pyk
         lJhOjyVdWzf5upB9vt0GDOtmuLg5NkYCfrQhUFQJaj4OqOiWbl1tmsCx/RMU3gelrV1l
         hMKF3J5yz8lc6sRVXXUmhJkQYRDSTPcglpMpk4HNecRgHgoMNw52ueZlF70HzlPyS7r6
         PcmLLIgJQUFe53UpCf0oeRtgnTbekvXqQAaZCGmJt6NGmkxfixT6Lh2bABXZD3Nehr4M
         sKnA==
X-Gm-Message-State: AOAM530dC1BfOt096u4thIFt8L8LyRgIggYbRIey3jULlnqzIY2Qm6R0
        TN/VOgbJZvPULLOmioZfZbHBoQ==
X-Google-Smtp-Source: ABdhPJx8q7E42vMiKJ5H+OzoA5nBqxDaKo1jGIPOHJSoXBYTbJwcMykIxeUyy77tQHbt1f3nUrCNTw==
X-Received: by 2002:a63:cf06:: with SMTP id j6mr650745pgg.195.1612469417277;
        Thu, 04 Feb 2021 12:10:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bv21sm6698862pjb.15.2021.02.04.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:10:16 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:10:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v19 07/25] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Message-ID: <202102041209.B1A0FF3D@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-8-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:29PM -0800, Yu-cheng Yu wrote:
> The x86 family of processors do not directly create read-only and Dirty
> PTEs.  These PTEs are created by software.  One such case is that kernel
> read-only pages are historically setup as Dirty.
> 
> New processors that support Shadow Stack regard read-only and Dirty PTEs as
> shadow stack pages.  This results in ambiguity between shadow stack and
> kernel read-only pages.  To resolve this, removed Dirty from kernel read-
> only pages.

Does this have any other side-effects?

Otherwise, sure:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/x86/include/asm/pgtable_types.h | 6 +++---
>  arch/x86/mm/pat/set_memory.c         | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 394757ee030a..b8b79d618bbc 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -194,10 +194,10 @@ enum page_cache_mode {
>  #define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
>  #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
>  #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
> -#define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
> -#define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
> +#define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|   0|   0|___G)
> +#define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|   0|   0|___G)
>  #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
> -#define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|___D|   0|___G)
> +#define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|   0|   0|___G)
>  #define __PAGE_KERNEL_LARGE	 (__PP|__RW|   0|___A|__NX|___D|_PSE|___G)
>  #define __PAGE_KERNEL_LARGE_EXEC (__PP|__RW|   0|___A|   0|___D|_PSE|___G)
>  #define __PAGE_KERNEL_WP	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __WP)
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 16f878c26667..6bebb95a6988 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -1932,7 +1932,7 @@ int set_memory_nx(unsigned long addr, int numpages)
>  
>  int set_memory_ro(unsigned long addr, int numpages)
>  {
> -	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW), 0);
> +	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW | _PAGE_DIRTY), 0);
>  }
>  
>  int set_memory_rw(unsigned long addr, int numpages)
> -- 
> 2.21.0
> 

-- 
Kees Cook
