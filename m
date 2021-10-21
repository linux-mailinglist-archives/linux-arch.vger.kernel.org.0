Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084A2436759
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJUQPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUQPF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:15:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627B9C061348
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:12:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso3501970pjm.4
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVa0QlPsmk1S9582aT+D2KdhqOv4MmkayJnl6+1fImU=;
        b=gvHs+h8DMR0QRBb8oh3QQwHgWfOrO5UCrxtOePcyiPBZKqHJrm5Z/7a83vkdagXqIV
         CFuuVSDejwuj2p7SL6hMqv9tDwHI74DVztq2wtlB24DIPTAYPk0nBADf+OmdcZJGCMq5
         nzxj3ujLkNSAVRjaFol9gJAib5ABohl1ARwms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVa0QlPsmk1S9582aT+D2KdhqOv4MmkayJnl6+1fImU=;
        b=WGT5+cUJDX833tuWqGtQ8p73QVtxC/kuUY3AgzC+UN95Ru9RKM8EoUQ7ldk31UXWTe
         8MRKBVW4GlyFa7X6of9FXqAIdZ6udX9LUA32sJeDWUIM5/LQXAipwaAqomx58TrDij81
         m1/yhuVjDajTMHiyZgHGXfn4/6LcQZkwfbZQ2/w5quSKErox1Os7nJLmNfRCQ75YYrk/
         dG7fi5/3e+fC1+3GhgWmqZ5i89Kqj1rN9f6YSBj/qwMNVdD+AautvdGKb0RnRC64EZ+l
         2e0RQ6YUkwhkzO1nIGTiPgbz+ZXknhbg1YTXhuoQM/2j41v2RrpY8NegD5QK4YuVz6q+
         miGA==
X-Gm-Message-State: AOAM532MRMuYB915sQ6OMKAbB4PE+lBWFIOGHC+OsXdp8gjQACWER3zK
        TBJ6rCfo+qHtMBtsje32U7tf9w==
X-Google-Smtp-Source: ABdhPJzWO9ec41mfE8gVa7DoM1QkoyDBmwyjeVhaCmlSvxR4EETHixc4n+KE2dwyCxRE1rNUYITvSw==
X-Received: by 2002:a17:902:db0a:b0:13e:e968:e144 with SMTP id m10-20020a170902db0a00b0013ee968e144mr6108237plx.43.1634832768420;
        Thu, 21 Oct 2021 09:12:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm7846927pfu.12.2021.10.21.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:12:48 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:12:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH 08/20] signal/sparc: In setup_tsb_params convert open
 coded BUG into BUG
Message-ID: <202110210910.7861F4041@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-8-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:54PM -0500, Eric W. Biederman wrote:
> The function setup_tsb_params has exactly one caller tsb_grow.  The
> function tsb_grow passes in a tsb_bytes value that is between 8192 and
> 1048576 inclusive, and is guaranteed to be a power of 2.  The function
> setup_tsb_params verifies this property with a switch statement and
> then prints an error and causes the task to exit if this is not true.
> 
> In practice that print statement can never be reached because tsb_grow
> never passes in a bad tsb_size.  So if tsb_size ever gets a bad value
> that is a kernel bug.
> 
> So replace the do_exit which is effectively an open coded version of
> BUG() with an actuall call to BUG().  Making it clearer that this
> is a case that can never, and should never happen.
> 
> Cc: David Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/sparc/mm/tsb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
> index 0dce4b7ff73e..912205787161 100644
> --- a/arch/sparc/mm/tsb.c
> +++ b/arch/sparc/mm/tsb.c
> @@ -266,7 +266,7 @@ static void setup_tsb_params(struct mm_struct *mm, unsigned long tsb_idx, unsign
>  	default:
>  		printk(KERN_ERR "TSB[%s:%d]: Impossible TSB size %lu, killing process.\n",
>  		       current->comm, current->pid, tsb_bytes);
> -		do_exit(SIGSEGV);
> +		BUG();
>  	}
>  	tte |= pte_sz_bits(page_sz);

Given the other uses of BUG() here, this seems okay.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
