Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869CA436800
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUQjC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhJUQjB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:39:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B979BC061764
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:36:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q187so830329pgq.2
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LwiRYg1y4Y8JWXKUDo5VZzWCK2qWa9LX3G8ahjYL1QI=;
        b=NG2DzhWPPBdyjZ0xmjUFmnFYPeDp25D/LYC4tK7zK2xGNcCduAUfV/B2ozl2wOewxv
         zXaWilNIbDGOVUS+GUekv/HwNgoUNaoHIDgPpUCtaxtWyqMsso76Sj4y5H+NFbs7fRy9
         5wQQ5z10+g+krkDUOT4rQfTjQIJ7dbdeTKUJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LwiRYg1y4Y8JWXKUDo5VZzWCK2qWa9LX3G8ahjYL1QI=;
        b=6HQdFzHzOTcQ4nu7CwO1TEPn/BnbiHESg97VmX87zUBfCPIW9mnqyIrXJ3CIJw6y+l
         vsP3brRaK81Dt77GGpU0DXiUTVWB6nMwvn9JkTUpW/FYsHuJYiS7OVcTYKmgL+0WQ5o8
         kBl3OXempFEcnS5WPxTMBc1IA+2iDZVHNrg0+HS46qtpgbJrBR1ylQYKl54Kz55unJe2
         gZIBVCwgYHRf54GX/2UwvGzj/2r2rZt6CCccHiOarQvTM8uy7mGCGvsZwGrpe3vQiGUO
         etAC9S51rjO08lpt47XMhuoH0AQ6hh+Dh1MhC71bdroJQEiJYsZUjJ32cFLbEUupdSza
         xvBQ==
X-Gm-Message-State: AOAM531uZyz/MO6ly/W68Fw+DOL3/KzEK6X0w2xOr9UUeLMB0mKB40YY
        rECESsz1afkL3qtu5snX7w1DOw==
X-Google-Smtp-Source: ABdhPJy+CpVEJPriOUdjPMXRaEHgvG6mresSqJvdlyA+La/Sr8UkEd1ZTMxOvye8CpNtXlRW7nlekA==
X-Received: by 2002:a05:6a00:1709:b0:44d:faf3:ef2d with SMTP id h9-20020a056a00170900b0044dfaf3ef2dmr6724544pfc.43.1634834205230;
        Thu, 21 Oct 2021 09:36:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s17sm5745776pge.50.2021.10.21.09.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:36:44 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:36:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 17/20] signal/x86: In emulate_vsyscall force a signal
 instead of calling do_exit
Message-ID: <202110210936.F0EA287E@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-17-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-17-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:03PM -0500, Eric W. Biederman wrote:
> Directly calling do_exit with a signal number has the problem that
> all of the side effects of the signal don't happen, such as
> killing all of the threads of a process instead of just the
> calling thread.
> 
> So replace do_exit(SIGSYS) with force_fatal_sig(SIGSYS) which
> causes the signal handling to take it's normal path and work
> as expected.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/x86/entry/vsyscall/vsyscall_64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 1b40b9297083..0b6b277ee050 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -226,7 +226,8 @@ bool emulate_vsyscall(unsigned long error_code,
>  	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
>  		warn_bad_vsyscall(KERN_DEBUG, regs,
>  				  "seccomp tried to change syscall nr or ip");
> -		do_exit(SIGSYS);
> +		force_fatal_sig(SIGSYS);
> +		return true;
>  	}
>  	regs->orig_ax = -1;
>  	if (tmp)

This looks correct to me, but please double-check the x86 selftests if
you haven't already.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
