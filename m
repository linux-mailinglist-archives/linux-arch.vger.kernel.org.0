Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651C9436765
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUQRY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhJUQRY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:17:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6531EC0613B9
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:15:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s1so738669plg.12
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BnP3QIjaR7JnabL4Ln7V26GIHfumLzivJQweHaSc0TY=;
        b=UBKO7odzSPY8clMHdQmGPBJ+ZxoNV2g6Yb6uDXVIZfwmaI1U55bkabRNRsh+BmuTzy
         Q/cP/XunCz/WKkEz6QDvY1kE8YqvVgF0YBumI3W/ovL+ELAwUf5lida08f566HsMG4GF
         Ftg7LzdrVIvFSmkqKjhWVGXItAnkAA07iJIbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BnP3QIjaR7JnabL4Ln7V26GIHfumLzivJQweHaSc0TY=;
        b=7Woqc6lRGotWwgssD9/ClAfd+mx9vNix36G2C56YKmp17vdZxHcMdgFgSyk/gmgX+y
         C5SrZ3s8sMporp4ZpTL90VXNTbhTmy7I8NrIu3qLi1/jU8aTYrqeZR1eip0//sVkdNA0
         BZsEznZy+TbJ+7rLnJYklHiHYBYlevPXlOdx8CYZbGeOHkmVk3fCy9+yHnv9ivUL5MTq
         m3GvLeFnm3JyddGv4pM/VtBSrzSNsklCyFO7H6EUg25Z2kmPKSeYoKmBYhb0tdxOaWmq
         dVUD8MOv+PrEfFgqFu97jN/1l4mvrxxaVhPRJO3BBEB+7155gpbiJzV82RrLpws3lmZf
         DIjQ==
X-Gm-Message-State: AOAM5304iPapSP11v90fiV1tkbyVx1IGCZ9iH/uiQP5STkY3YL7hC/0S
        dbso9DpoYtqIMzm2Eo+San1y9A==
X-Google-Smtp-Source: ABdhPJykgSiYSFIaI8VWViajINK0UvEIyr8C/qc98WFBSnIZbY7yo5tECp223FmUgtnvEXPDO6U6rg==
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id p23-20020a1709028a9700b0013e6e77af59mr6092858plo.4.1634832907872;
        Thu, 21 Oct 2021 09:15:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u24sm5865109pgo.73.2021.10.21.09.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:15:07 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:15:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, H Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH 09/20] signal/vm86_32: Replace open coded BUG_ON with an
 actual BUG_ON
Message-ID: <202110210914.59245E29CF@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-9-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:55PM -0500, Eric W. Biederman wrote:
> The function save_v86_state is only called when userspace was
> operating in vm86 mode before entering the kernel.  Not having vm86
> state in the task_struct should never happen.  So transform the hand
> rolled BUG_ON into an actual BUG_ON to make it clear what is
> happening.

If this is actually not a state userspace can put itself into:

Reviewed-by: Kees Cook <keescook@chromium.org>

Otherwise, this should be a WARN+kill.

> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: H Peter Anvin <hpa@zytor.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/x86/kernel/vm86_32.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index e5a7a10a0164..63486da77272 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -106,10 +106,8 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
>  	 */
>  	local_irq_enable();
>  
> -	if (!vm86 || !vm86->user_vm86) {
> -		pr_alert("no user_vm86: BAD\n");
> -		do_exit(SIGSEGV);
> -	}
> +	BUG_ON(!vm86 || !vm86->user_vm86);
> +
>  	set_flags(regs->pt.flags, VEFLAGS, X86_EFLAGS_VIF | vm86->veflags_mask);
>  	user = vm86->user_vm86;
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
