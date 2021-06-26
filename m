Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F9B3B4C35
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 05:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFZDh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Jun 2021 23:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhFZDh2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Jun 2021 23:37:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85F0C061767
        for <linux-arch@vger.kernel.org>; Fri, 25 Jun 2021 20:35:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v12so5702345plo.10
        for <linux-arch@vger.kernel.org>; Fri, 25 Jun 2021 20:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aUhvmz2IAighG804GQ35EBkkFq5G6bi3JzTCxCLPv0E=;
        b=jQhfIeYg/XK/RbrcxRHqUnVapM962lRzN/PRvFhV2DZYDFbKdC7vhV1PUaQsJn6C2u
         wc+lSbUOtv47V7AjIimm25dFBpNDIJF/gjwNyux0Zp3DXmVZ+9n9jYRDF4LhGOCQBu/7
         W3DUA2b9WyKlpfNECqM9x3zozs9kmMB/qRga4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aUhvmz2IAighG804GQ35EBkkFq5G6bi3JzTCxCLPv0E=;
        b=p0ocqxbC5VuIUMPOPAZt+6ldonbfyP9Sm73Bl4jn5wKVhnjbjmawJdjYoLGGgG7XmX
         EWWgVY0cDM4jylmRa8wO/9yuYkAyDK4B3UWJogk3uxlLnukVG0o0BLjjLjvTUXQ38jSn
         YbZ+euSYRUxGdjqWuLrVP7b4+jswbr8Rfyx+fW7k5nlDGaeQkuRmA1uchNq4NFlfy+DV
         N3XXxUdtpRZTAusyIvbhFB3UTjiHx3HLN0Vz2VQW+YiU+pN34h1ftV1Goz8hGHD0EFdY
         05x9w6NOZ0z/PHhSiiJtm8pBju4ePT/pqK4tcEl9MjPyk/1DSnonfJ8omyrVSlVuU/nZ
         p+pg==
X-Gm-Message-State: AOAM533/n+O14jXDdCiTv1eTbHUJn7NEQYA0USjk1W5D7kmTDFNHHjbX
        uia2V7nWVikvaRFyN4V60u3OWBi6cMZUgw==
X-Google-Smtp-Source: ABdhPJzmqBYRC7fkJSowdBtNlnsxPIiIDINa/zg9UgQCV7lhXUeX0LJKM1GTh/RC2pyQQdZfZQtQYA==
X-Received: by 2002:a17:90a:4d88:: with SMTP id m8mr24251849pjh.169.1624678506089;
        Fri, 25 Jun 2021 20:35:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c24sm7160497pfd.167.2021.06.25.20.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 20:35:05 -0700 (PDT)
Date:   Fri, 25 Jun 2021 20:35:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/9] signal/group_exit: Use start_group_exit in place of
 do_group_exit
Message-ID: <202106252026.E8C5393@keescook>
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133>
 <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133>
 <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133>
 <875yy3850g.fsf_-_@disp2133>
 <87a6nf6q97.fsf_-_@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6nf6q97.fsf_-_@disp2133>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 24, 2021 at 02:01:40PM -0500, Eric W. Biederman wrote:
> 
> Make thread exiting uniform by causing all threads to pass through
> get_signal when they are exiting.  This simplifies the analysis
> of sychronization during exit and guarantees that all full set
> of registers will be available for ptrace to examine for
> threads that stop at PTRACE_EVENT_EXIT.

Yeah, cool. I do like making the process lifetime more sensible here. It
always threw me that do_exit*() just stopped execution. :)

For future me, can you add a comment on start_group_exit() that mentions
where final process death happens?

> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/exit.c    | 4 ++--
>  kernel/seccomp.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index fd1c04193e18..921519d80b56 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -931,8 +931,8 @@ do_group_exit(int exit_code)
>   */
>  SYSCALL_DEFINE1(exit_group, int, error_code)
>  {
> -	do_group_exit((error_code & 0xff) << 8);
> -	/* NOTREACHED */
> +	start_group_exit((error_code & 0xff) << 8);
> +	/* get_signal will call do_exit */
>  	return 0;

"0" feels weird here, but I can't think of any better "fail closed"
error code here.

>  }
>  
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 5301eca670a0..b1c06fd1b205 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1250,7 +1250,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  			if (action == SECCOMP_RET_KILL_THREAD)
>  				do_exit(SIGSYS);
>  			else
> -				do_group_exit(SIGSYS);
> +				start_group_exit(SIGSYS);

This could use a similar comment to the syscall's comment, just so I
don't panic when I read this code in like 3 years. ;)

Otherwise, yeah, looks good.

-Kees

>  		}
>  		return -1;
>  	}
> -- 
> 2.20.1
> 

-- 
Kees Cook
