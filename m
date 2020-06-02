Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35601EC191
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jun 2020 20:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFBSDs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jun 2020 14:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgFBSDr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2020 14:03:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A701C08C5C0
        for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2020 11:03:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a4so5433564pfo.4
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2020 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y1Y2fkE2q57cl3sVFwSCV2Rlv9H/o7RdqOXAJOzk5BI=;
        b=PxjxUeYNGDO7nTddPMYiH16uFfFjhvhXlC7DHTn2Gwug8w9r+bMImzNz39NlxB5UPp
         LgwcLmqrHUTSMexgkNWCMeryIJyQPTKKd2n7s06lhDTBUQJZ7jvQC+VHeC526lAKgHRI
         Hwyx+1bfTWqtXOoxgkAPqd07kmOEteBXyu/Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y1Y2fkE2q57cl3sVFwSCV2Rlv9H/o7RdqOXAJOzk5BI=;
        b=mEqQhL2TE3g5/NdqzrjKyw0je9rECSTNzUln/8l9l8L7Tp+g0TxS9DVW8zrNwRqCax
         wHN3L5+gg0MPLN/EQTN2HkGHh2ggiAAnEXxEUgGiC8M3RuoWyfNUGIEXPWTDiiLyNMzS
         tEAbeVGQqAw74tRumKmZylvoFA+FOpx81PwLfSoiIx3XVm002nvpAUMMfd4yyNGv5Vlo
         phuFMUr2HVO6qC28zj0uRvYrxmQ0K3rWPIIdHMuYbhfC31VD385PP8dbdB5+sRWw7vC6
         n0oU3UQVrOS5u2TmpCQ3wOHB1WZA+GaDCVpBL/CzJvbqPCoaKBsvZWAh9dwR54CG6B1G
         833w==
X-Gm-Message-State: AOAM531hD1md1jU5ngiCxbX8wK2GMtOBSMQ7hV7XL7K/QgwXVws9qSfY
        T5/39OPmS5wBHYXsSNTbDs/xNQ==
X-Google-Smtp-Source: ABdhPJzj7E3Rw5Brt6uT6kfU748sbin8+qytbSZ/kf72ZyhfLBgJc/YaDn8GH05YuWtNdSM8MF7q0Q==
X-Received: by 2002:aa7:8298:: with SMTP id s24mr27113500pfm.122.1591121025745;
        Tue, 02 Jun 2020 11:03:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u17sm2726262pgo.90.2020.06.02.11.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:03:44 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:03:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org
Subject: Re: Regression bisected to f2f84b05e02b (bug: consolidate
 warn_slowpath_fmt() usage)
Message-ID: <202006021052.E52618F@keescook>
References: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 01, 2020 at 07:48:04PM -0700, Matt Turner wrote:
> I bisected a regression on alpha to f2f84b05e02b (bug: consolidate
> warn_slowpath_fmt() usage) which looks totally innocuous.
> 
> Reverting it on master confirms that it somehow is the trigger. At or a
> little after starting userspace, I'll see an oops like this:
> 
> Unable to handle kernel paging request at virtual address 0000000000000000
> CPU 0
> kworker/u2:5(98): Oops -1
> pc = [<0000000000000000>]  ra = [<0000000000000000>]  ps = 0000    Not tainted
> pc is at 0x0

^^^^ so, the instruction pointer is NULL. The only way I can imagine
that happening would be from this line:

        worker->current_func(work);

> ra is at 0x0
> v0 = 0000000000000007  t0 = 0000000000000001  t1 = 0000000000000001
> t2 = 0000000000000000  t3 = fffffc00bfe68780  t4 = 0000000000000001
> t5 = fffffc00bf8cc780  t6 = 00000000026f8000  t7 = fffffc00bfe70000
> s0 = fffffc000250d310  s1 = fffffc000250d310  s2 = fffffc000250d310
> s3 = fffffc000250ca40  s4 = fffffc000250caa0  s5 = 0000000000000000
> s6 = fffffc000250ca40
> a0 = fffffc00024f0488  a1 = fffffc00bfe73d98  a2 = fffffc00bfe68800
> a3 = fffffc00bf881400  a4 = 0001000000000000  a5 = 0000000000000002
> t8 = 0000000000000000  t9 = 0000000000000000  t10= 0000000001321800
> t11= 000000000000ba4e  pv = fffffc000189ca00  at = 0000000000000000
> gp = fffffc000253e430  sp = 0000000043a83c2e
> Disabling lock debugging due to kernel taint
> Trace:
> [<fffffc000105c8ac>] process_one_work+0x25c/0x5a0

Can you verify where this     ^^^^^^^^^^^^^^   is?

> [<fffffc000105cc4c>] worker_thread+0x5c/0x7d0
> [<fffffc0001066c88>] kthread+0x188/0x1f0
> [<fffffc0001011b48>] ret_from_kernel_thread+0x18/0x20
> [<fffffc0001066b00>] kthread+0x0/0x1f0
> [<fffffc000105cbf0>] worker_thread+0x0/0x7d0
> 
> Code:
>  00000000
>  00000000
>  00063301
>  000012e2
>  00001111
>  0005ffde
> 
> It seems to cause a hard lock on an SMP system, but not on a system with
> a single CPU. Similarly, if I boot the SMP system (2 CPUs) with
> maxcpus=1 the oops doesn't happen. Until I tested on a non-SMP system
> today I suspected that it was unaffected, but I saw the oops there too.
> With the revert applied, I don't see a warning or an oops.
> 
> Any clues how this patch could have triggered the oops?

I cannot begin to imagine. :P Compared to other things I've seen like
this in the past maybe it's some kind of effect from the code size
changing the location/alignment or timing of something else?

Various questions ranging in degrees of sanity:

Does alpha use work queues for WARN?

Which work queue is getting a NULL function? (And then things like "if
WARN was much slower or much faster, is there a race to something
setting itself to NULL?")

Was there a WARN before the above Oops?

Does WARN have side-effects on alpha?

Does __WARN_printf() do something bad that warn_slowpath_null() doesn't?

Does making incremental changes narrow anything down? (e.g. instead of
this revert, remove the __warn() call in warn_slowpath_fmt() that was
added? (I mean, that'll be quite broken for WARN, but will it not oops?)

Does alpha have hardware breakpoints? When I had to track down a
corruption in the io scheduler, I ended up setting breakpoints on the
thing that went crazy (in this case, I assume the work queue function
pointer) to figure out what touched it.

... I can't think of anything else.

-Kees

> 
> Here's the revert, with a trivial conflict resolved, that I've used in
> testing:
> 
> From fdbdd0f606f0f412ee06c1152e33a22ca17102bc Mon Sep 17 00:00:00 2001
> From: Matt Turner <mattst88@gmail.com>
> Date: Sun, 24 May 2020 20:46:00 -0700
> Subject: [PATCH] Revert "bug: consolidate warn_slowpath_fmt() usage"
> 
> This reverts commit f2f84b05e02b7710a201f0017b3272ad7ef703d1.
> ---
>  include/asm-generic/bug.h |  3 ++-
>  kernel/panic.c            | 15 +++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 384b5c835ced..a4a311d4b4b0 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -82,7 +82,8 @@ struct bug_entry {
>  extern __printf(4, 5)
>  void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
>  		       const char *fmt, ...);
> -#define __WARN()		__WARN_printf(TAINT_WARN, NULL)
> +extern void warn_slowpath_null(const char *file, const int line);
> +#define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
>  #define __WARN_printf(taint, arg...)					\
>  	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
>  #else
> diff --git a/kernel/panic.c b/kernel/panic.c
> index b69ee9e76cb2..c8ed8046b484 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -603,20 +603,19 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
>  {
>  	struct warn_args args;
> -	pr_warn(CUT_HERE);
> -
> -	if (!fmt) {
> -		__warn(file, line, __builtin_return_address(0), taint,
> -		       NULL, NULL);
> -		return;
> -	}
> -
>  	args.fmt = fmt;
>  	va_start(args.args, fmt);
>  	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
>  	va_end(args.args);
>  }
>  EXPORT_SYMBOL(warn_slowpath_fmt);
> +
> +void warn_slowpath_null(const char *file, int line)
> +{
> +	pr_warn(CUT_HERE);
> +	__warn(file, line, __builtin_return_address(0), TAINT_WARN, NULL, NULL);
> +}
> +EXPORT_SYMBOL(warn_slowpath_null);
>  #else
>  void __warn_printk(const char *fmt, ...)
>  {
> -- 
> 2.26.2



-- 
Kees Cook
