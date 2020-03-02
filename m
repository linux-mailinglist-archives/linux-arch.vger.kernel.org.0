Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095E417679F
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 23:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCBWpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 17:45:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35583 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCBWpe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 17:45:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so432614pfa.2
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 14:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=GFD8ViXColObn8FM0PtoZqKUGLmCPza4UuJiavcTlUk=;
        b=WOFD+1Nf4ROrRkdcS2D5Dsei0yXLkev6qnAqaLDLHleCetNWzzamUGvlzp/253O8jh
         3r03SkffB+wUd+5cZAcVQv7IP2C7/s6hLTVHBBxDMhIH9Zl/ntMVEcd/f6KslWykbsLn
         tCMHnOUaFbey1oPEdx6KV21wnn0J36dc3JzMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=GFD8ViXColObn8FM0PtoZqKUGLmCPza4UuJiavcTlUk=;
        b=Bnl5R0Wl9YoB2GN/VI9wgjJMskRA20U2W30bSI8D+c8vdGXR1Z4TptR+zAH8DC5OaQ
         ITRCcbdrcbqOQsgrE4hTC4qjnrEsqHLm37IDjYvWBJv0UoVwSm+XnmGnt0ZSDP2dWAwL
         fptdIhbf4Mt1fqPP3p6eoe0LQb//gxre+Y3sk1Ihx2MJbqp9ffJKIuw+ig+oInKHBZS1
         XC8b7UR4ppvu93i4Vvc4L2hKCVdEDae7JCx+YXAPFq3nGzDRvRoeH1ZW3Z5MFM+nPNEg
         iFz9lGa4nqhbYHV5bqZRynW8aLmSyHVOMePUGNJkkUCYyzSa2pL/rsMt34hv1ixqtXj8
         NUpQ==
X-Gm-Message-State: ANhLgQ0xTvovQUVPtW2thbPMHSSrFwQ3qAoOsoJ2jGn/xTnA1AuwV1MN
        OibjkqDHxmTHTq8t0ktsW+2luA==
X-Google-Smtp-Source: ADFU+vu7n6pQF0dWmSqvn0KXxGvBVGm4fqd9FgIsTrDfyQROBoSJtdUzEcRBWZnkK1aK2uDhIh2uwA==
X-Received: by 2002:a63:4555:: with SMTP id u21mr1106380pgk.66.1583189132864;
        Mon, 02 Mar 2020 14:45:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a10sm21559754pgk.71.2020.03.02.14.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:45:31 -0800 (PST)
Date:   Mon, 2 Mar 2020 14:45:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, gregkh@linuxfoundation.org, sboyd@kernel.org,
        logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 4/7] init: main: add KUnit to kernel init
Message-ID: <202003021439.A6B6FD8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228012036.15682-5-brendanhiggins@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/27/20 7:20 PM, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
> 
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> [...]
> diff --git a/init/main.c b/init/main.c
> index ee4947af823f3..7875a5c486dc4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -104,6 +104,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/initcall.h>
>  
> +#include <kunit/test.h>
> +
>  static int kernel_init(void *);
>  
>  extern void init_IRQ(void);
> @@ -1444,6 +1446,8 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	do_basic_setup();
>  
> +	kunit_run_all_tests();
> +
>  	console_on_rootfs();
>  
>  	/*

I'm nervous about this happening before two key pieces of the kernel
setup, which might lead to weird timing-sensitive bugs or false
positives:
	async_synchronize_full()
	mark_readonly()

Now, I realize kunit tests _should_ be self-contained, but this seems
like a possible robustness problem. Is there any reason this can't be
moved after rcu_end_inkernel_boot() in kernel_init() instead?

-- 
Kees Cook
