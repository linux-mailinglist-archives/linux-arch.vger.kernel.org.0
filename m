Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE113385A7
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 07:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhCLGN1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 01:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhCLGNR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Mar 2021 01:13:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76DC061574;
        Thu, 11 Mar 2021 22:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tuWZsMs6exFN5R6PkELmsSGZweW8Hs198xcKIgwMDDA=; b=lKgmtNx16rBafs3JaCtnDBNN9n
        O6UTTPm8K5kiDBxz+uzhjX6F1WZt2hyW3UAnwhOvUrqVrnmF7hF+i8TPsB5DhA0o4luVKIdfpVhFR
        bbuqXexPcd8BzIUJlU/DvHgi1/NLRyzh3xCmi2lbbwmHQoggTDF9+ywnL+oW68Jj/SyoI0hx/ETdA
        VsnXK3dD9LZz1qYVvd8y/ukyPeeWJmLayh4EmttPXTgLOO9OHgThs/BEdmSq4lRPJ687QsTfelOfE
        Lfw7lu0Nf96lvw/b0gosuhPWwhaeWc6mb4nFT/70JDWVr7DnqlC2w9+Bs4SHVw0U7v9agtc+l0/gi
        +R2nkieQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKb2m-009kSg-Af; Fri, 12 Mar 2021 06:13:05 +0000
Date:   Fri, 12 Mar 2021 06:13:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] kthread: cfi: disable callback pointer check with
 modules
Message-ID: <20210312061304.GA2321497@infradead.org>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-7-samitolvanen@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:08PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, a callback function passed to
> __kthread_queue_delayed_work from a module points to a jump table
> entry defined in the module instead of the one used in the core
> kernel, which breaks function address equality in this check:
> 
>   WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
> 
> Disable the warning when CFI and modules are enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/kthread.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 1578973c5740..af5fee350586 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -963,7 +963,13 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
>  	struct timer_list *timer = &dwork->timer;
>  	struct kthread_work *work = &dwork->work;
>  
> -	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
> +	/*
> +	 * With CFI, timer->function can point to a jump table entry in a module,

you keep spewing this comment line that has exactly 81 characters and
thus badly messes up read it with a normal termina everywhere.

Maybe instead of fixing that in ever duplication hide the whole check in
a well documented helper (which would have to be a macro due to the
typing involved).
