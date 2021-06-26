Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E013B4C43
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 05:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFZDob (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Jun 2021 23:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFZDob (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Jun 2021 23:44:31 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C523CC061766
        for <linux-arch@vger.kernel.org>; Fri, 25 Jun 2021 20:42:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i6so9045926pfq.1
        for <linux-arch@vger.kernel.org>; Fri, 25 Jun 2021 20:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DEu/zUGEil5W1i542Jddkvc9pkER3JRysmBpbGQkYys=;
        b=h/QRUEAVNrUKdOz23aXgH2qZADlVHaJeFs2MojeAXLKLDp3e1LOG9MjMdVwDqHGe3B
         YxK6GS2Dy3kNvMeygQwfdJ9jhAyjbJcbRBbtkjoa1UtJjxJw3AoZVAV1d2dS1+yv32o4
         7HJpXFhj83H1JRRR9SNpp6vFWF7KQea3GpBv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DEu/zUGEil5W1i542Jddkvc9pkER3JRysmBpbGQkYys=;
        b=Ve1skWGG3sKRmOH8YUWcZs9vorRmtyeK9jTKc2TgpFOapprdSHXCAkAbd4CqaPqQvk
         D13qZ4pH8cIsgXSDxLEaHhdIBBNIIl9BPtNQ2qXSC0RB6xiQSUV0/kBGpKXKBqOzszX5
         iQ4YqNOVCokfJPLiCRHYFvQSUT1hdaAF6wKlO/HOJsYr6FckehsFyFoNmtmS0Kg30UWw
         JUzFMCARqQjmGtgNPBsAkLXRKwZ6ia41Htv0kplB3s+i1UhiDokCJtXtcFJv8cacOJnJ
         /4FbpGv3fDJ/l2bd+jJhNk3CEPCW91xxmZWZThamm9RDR09avcFNqarVQfGI9xDe1jQS
         PIfw==
X-Gm-Message-State: AOAM533tz3PKlqz+Ru7rwyoK43zXC9L6HinT00OFGFkBPPb11T7V7pqS
        cdmVMcAUyeb3IFZUe4oAW++rbg==
X-Google-Smtp-Source: ABdhPJy7s7vbcIeT9sY4Mja7Fe9OP6nBus7t8ECrzqyO7z40aJkGpejLzHmj4n00fK93l9p5wqCq0A==
X-Received: by 2002:a62:6406:0:b029:302:bb9:1511 with SMTP id y6-20020a6264060000b02903020bb91511mr13668259pfb.26.1624678928256;
        Fri, 25 Jun 2021 20:42:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm6494689pjw.52.2021.06.25.20.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 20:42:07 -0700 (PDT)
Date:   Fri, 25 Jun 2021 20:42:06 -0700
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
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6/9] signal: Fold do_group_exit into get_signal fixing
 io_uring threads
Message-ID: <202106252038.389B963B6F@keescook>
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133>
 <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133>
 <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133>
 <875yy3850g.fsf_-_@disp2133>
 <874kdn6q87.fsf_-_@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kdn6q87.fsf_-_@disp2133>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 24, 2021 at 02:02:16PM -0500, Eric W. Biederman wrote:
> 
> Forld do_group_exit into get_signal as it is the last caller.
> 
> Move the group_exit logic above the PF_IO_WORKER exit, ensuring
> that if an PF_IO_WORKER catches SIGKILL every thread in
> the thread group will exit not just the the PF_IO_WORKER.
> 
> Now that the information is easily available only set PF_SIGNALED
> when it was a signal that caused the exit.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/sched/task.h |  1 -
>  kernel/exit.c              | 31 -------------------------------
>  kernel/signal.c            | 35 +++++++++++++++++++++++++----------
>  3 files changed, 25 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index ef02be869cf2..45525512e3d0 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -77,7 +77,6 @@ static inline void exit_thread(struct task_struct *tsk)
>  {
>  }
>  #endif
> -extern void do_group_exit(int);
>  
>  extern void exit_files(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 921519d80b56..635f434122b7 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -892,37 +892,6 @@ SYSCALL_DEFINE1(exit, int, error_code)
>  	do_exit((error_code&0xff)<<8);
>  }
>  
> -/*
> - * Take down every thread in the group.  This is called by fatal signals
> - * as well as by sys_exit_group (below).
> - */
> -void
> -do_group_exit(int exit_code)
> -{
> -	struct signal_struct *sig = current->signal;
> -
> -	BUG_ON(exit_code & 0x80); /* core dumps don't get here */
> -
> -	if (signal_group_exit(sig))
> -		exit_code = sig->group_exit_code;
> -	else if (!thread_group_empty(current)) {
> -		struct sighand_struct *const sighand = current->sighand;
> -
> -		spin_lock_irq(&sighand->siglock);
> -		if (signal_group_exit(sig))
> -			/* Another thread got here before we took the lock.  */
> -			exit_code = sig->group_exit_code;
> -		else {
> -			sig->group_exit_code = exit_code;
> -			sig->flags = SIGNAL_GROUP_EXIT;
> -			zap_other_threads(current);

Oh, now I see it: the "new code" in start_group_exit() is an open-coded
zap_other_threads()? That wasn't clear to me, but makes sense now.

> -		}
> -		spin_unlock_irq(&sighand->siglock);
> -	}
> -
> -	do_exit(exit_code);
> -	/* NOTREACHED */
> -}
>  
>  /*
>   * this kills every thread in the thread group. Note that any externally
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c79c010ca5f3..95a076af600a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2646,6 +2646,7 @@ bool get_signal(struct ksignal *ksig)
>  {
>  	struct sighand_struct *sighand = current->sighand;
>  	struct signal_struct *signal = current->signal;
> +	int exit_code;
>  	int signr;
>  
>  	if (unlikely(current->task_works))
> @@ -2848,8 +2849,6 @@ bool get_signal(struct ksignal *ksig)
>  		/*
>  		 * Anything else is fatal, maybe with a core dump.
>  		 */
> -		current->flags |= PF_SIGNALED;
> -
>  		if (sig_kernel_coredump(signr)) {
>  			if (print_fatal_signals)
>  				print_fatal_signal(ksig->info.si_signo);
> @@ -2857,14 +2856,33 @@ bool get_signal(struct ksignal *ksig)
>  			/*
>  			 * If it was able to dump core, this kills all
>  			 * other threads in the group and synchronizes with
> -			 * their demise.  If we lost the race with another
> -			 * thread getting here, it set group_exit_code
> -			 * first and our do_group_exit call below will use
> -			 * that value and ignore the one we pass it.
> +			 * their demise.  If  another thread makes it
> +			 * to do_coredump first, it will set group_exit_code
> +			 * which will be passed to do_exit.
>  			 */
>  			do_coredump(&ksig->info);
>  		}
>  
> +		/*
> +		 * Death signals, no core dump.
> +		 */
> +		exit_code = signr;
> +		if (signal_group_exit(signal)) {
> +			exit_code = signal->group_exit_code;
> +		} else {
> +			spin_lock_irq(&sighand->siglock);
> +			if (signal_group_exit(signal)) {
> +				/* Another thread got here before we took the lock.  */
> +				exit_code = signal->group_exit_code;
> +			} else {
> +				start_group_exit_locked(signal, exit_code);

And here's the "if we didn't already do start_group_exit(), do it here".
And that state is entirely captured via the SIGNAL_GROUP_EXIT flag.
Cool.

> +			}
> +			spin_unlock_irq(&sighand->siglock);
> +		}
> +
> +		if (exit_code & 0x7f)
> +			current->flags |= PF_SIGNALED;
> +
>  		/*
>  		 * PF_IO_WORKER threads will catch and exit on fatal signals
>  		 * themselves. They have cleanup that must be performed, so
> @@ -2873,10 +2891,7 @@ bool get_signal(struct ksignal *ksig)
>  		if (current->flags & PF_IO_WORKER)
>  			goto out;
>  
> -		/*
> -		 * Death signals, no core dump.
> -		 */
> -		do_group_exit(ksig->info.si_signo);
> +		do_exit(exit_code);
>  		/* NOTREACHED */
>  	}
>  	spin_unlock_irq(&sighand->siglock);
> -- 
> 2.20.1
> 

-- 
Kees Cook
