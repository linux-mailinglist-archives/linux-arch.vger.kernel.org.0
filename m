Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C56436768
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhJUQSU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJUQST (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:18:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2CAC061764
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:16:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f5so736709pgc.12
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vP39j9ADitfQOHN+zI1j9ZwqqZWQBsDUBPCRK2KL/kw=;
        b=BxznGOQ/wzmBK7sBg1f0kltBGxiqMcUJY96yfRg5sDBfwda0Au3MEYhLIQYXBrAh29
         w8M8sjJCfbHisxxMGjvz0gTJArsePF8uLuWr80z78Ls2wpZtyTrzCUlOiB//HsTEHfGh
         Ji05YrCVxt9dwaOXBMkJofvsNIs4FxFgTspLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vP39j9ADitfQOHN+zI1j9ZwqqZWQBsDUBPCRK2KL/kw=;
        b=1tKL+mVBpdQ2Oq7TFblmK+DEny7frXADsIVXBno94fXA0zJ5GJFb4HEEgR1GBSUDNs
         C4AraaQJMCWUD8Ied3jdpsnCXN3+EEQpHPmwBZQsm9hcCRmkebO9qCx+nblQ4bN3RnRc
         HJII4di3PmcP8K09t42l8AU+ks27cgw4kDneBK6nNWPG0snLzRYQFiViVb0kPrq5ap9G
         hp7kSXJFG9FEd7Wsgu3UdzR3bMCFmzKRPPDnY/T7Ai257wfu8PrfbVmthDQjSTLiQTcZ
         OlsiADwgUo3920XRjrJ1OpcpXes0MD3nBZbK4W4I7x2VUIm10+Qpy7y0YWHgfNr2CMkw
         4dBw==
X-Gm-Message-State: AOAM533TdoKGgujDX9NvTcHV5CZRV2mKBITHVHcrnhAx0VTBJgP48wZN
        4A/Y+QXuvh1k/KDFFY4EbE10vg==
X-Google-Smtp-Source: ABdhPJy70NkI/iYHxiXKXmeWuvWywNZofk1XVFZpw6KXyv0Q/EsYUPnI6CkUR0hARZPpFGr3tLAeRA==
X-Received: by 2002:a62:188c:0:b0:44d:6660:212b with SMTP id 134-20020a62188c000000b0044d6660212bmr6691706pfy.8.1634832963309;
        Thu, 21 Oct 2021 09:16:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s62sm6005310pgc.5.2021.10.21.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:16:03 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:16:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, H Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH 10/20] signal/vm86_32: Properly send SIGSEGV when the
 vm86 state cannot be saved.
Message-ID: <202110210915.BF17C14980@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-10-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:56PM -0500, Eric W. Biederman wrote:
> Instead of pretending to send SIGSEGV by calling do_exit(SIGSEGV)
> call force_sigsegv(SIGSEGV) to force the process to take a SIGSEGV
> and terminate.
> 
> Update handle_signal to return immediately when save_v86_state fails
> and kills the process.  Returning immediately without doing anything
> except killing the process with SIGSEGV is also what signal_setup_done
> does when setup_rt_frame fails.  Plus it is always ok to return
> immediately without delivering a signal to a userspace handler when a
> fatal signal has killed the current process.

Do the tools/testing/selftests/x86 tests all pass after these changes? I
know Andy has a bunch of weird corner cases in there.

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: H Peter Anvin <hpa@zytor.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/x86/kernel/signal.c  | 6 +++++-
>  arch/x86/kernel/vm86_32.c | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index f4d21e470083..25a230f705c1 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -785,8 +785,12 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  	bool stepping, failed;
>  	struct fpu *fpu = &current->thread.fpu;
>  
> -	if (v8086_mode(regs))
> +	if (v8086_mode(regs)) {
>  		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
> +		/* Has save_v86_state failed and killed the process? */
> +		if (fatal_signal_pending(current))
> +			return;
> +	}
>  
>  	/* Are we from a system call? */
>  	if (syscall_get_nr(current, regs) != -1) {
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index 63486da77272..040fd01be8b3 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -159,7 +159,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
>  	user_access_end();
>  Efault:
>  	pr_alert("could not access userspace vm86 info\n");
> -	do_exit(SIGSEGV);
> +	force_sigsegv(SIGSEGV);
>  }
>  
>  static int do_vm86_irq_handling(int subfunction, int irqnumber);
> -- 
> 2.20.1
> 

-- 
Kees Cook
