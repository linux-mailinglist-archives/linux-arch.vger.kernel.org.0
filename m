Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB22542FD79
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 23:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbhJOVfH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 17:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbhJOVfG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2021 17:35:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC88AC061765
        for <linux-arch@vger.kernel.org>; Fri, 15 Oct 2021 14:32:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d23so9704694pgh.8
        for <linux-arch@vger.kernel.org>; Fri, 15 Oct 2021 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YNBNEYisZ+541asH+L6t1hZlJ/Xn9d3ughoW3yhbnMY=;
        b=f8kTQ/Y/ACr3yL4eMWtqbWU2xm18S+76EHKyee4Vqqv4SV8J6qk5BuskJbEb6Ql/TJ
         c9EbbOivEp4/Vy74Zv5n8MvM1vLyBEeJPN8m+5olTn2ub0SZO8xZlaRygBBGEjyk6s6j
         dW6pUEjVARu6NrsLidMTQLR5wt2C5k6t+XvQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YNBNEYisZ+541asH+L6t1hZlJ/Xn9d3ughoW3yhbnMY=;
        b=WKBJIlbqDV14Fn4aFKZwxq5V/0dfo2Gqu85UAAq7qLA4iZmBt9zXQqD/NY5BGmWIKS
         ZpymcYIJBjJxvNR5OcJr6K17dc110psMEOwM4HUFhW7RtD9Qj7rDfsvNGZ1lNzR2HYlz
         pa6k1t39PKQ/nhTbcWPCrIaSZrJ5W+ytSAflbPpKitOJV5JOmzFyml98b0ypLJfd9UCr
         PIAJwpRVpd8GTdSAO0rejcFfoU6KeCTG57Gm7UMlik9FyMsEPQw9Zj7aQID7kqjOuOw1
         qrn7gFvwGU0HTfIejyfurF1LpkK83ZmkE5UY26vzzT/kReSij/sGYtGc5g5dt60v4fFj
         XhTQ==
X-Gm-Message-State: AOAM532yxazbWjNF1QQyPXqHF1D3iCJJekqqRxp7N19emsPvhAxD6qfa
        C/SDQvoqiCnIxE6FLrlkne9ANQ==
X-Google-Smtp-Source: ABdhPJzAyN+K8Hifn5n3pJa0D9tsRyoaRMolZRmu5TyHtvN6ydh9MAL1iJXdAj5PTEgi34yjsZ8kvg==
X-Received: by 2002:a63:ef58:: with SMTP id c24mr10773001pgk.299.1634333579455;
        Fri, 15 Oct 2021 14:32:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t126sm5787900pfc.80.2021.10.15.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:32:59 -0700 (PDT)
Date:   Fri, 15 Oct 2021 14:32:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 11/13] lkdtm: Fix lkdtm_EXEC_RODATA()
Message-ID: <202110151432.D8203C19@keescook>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <44946ed0340013a52f8acdee7d6d0781f145cd6b.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44946ed0340013a52f8acdee7d6d0781f145cd6b.1634190022.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 07:50:00AM +0200, Christophe Leroy wrote:
> Behind its location, lkdtm_EXEC_RODATA() executes
> lkdtm_rodata_do_nothing() which is a real function,
> not a copy of do_nothing().
> 
> So executes it directly instead of using execute_location().
> 
> This is necessary because following patch will fix execute_location()
> to use a copy of the function descriptor of do_nothing() and
> function descriptor of lkdtm_rodata_do_nothing() might be different.
> 
> And fix displayed addresses by dereferencing the function descriptors.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I still don't understand this -- it doesn't look needed at all given the
changes in patch 12. (i.e. everything is using
dereference_function_descriptor() now)

Can't this patch be dropped?

-Kees

> ---
>  drivers/misc/lkdtm/perms.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 035fcca441f0..5266dc28df6e 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -153,7 +153,14 @@ void lkdtm_EXEC_VMALLOC(void)
>  
>  void lkdtm_EXEC_RODATA(void)
>  {
> -	execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
> +	pr_info("attempting ok execution at %px\n",
> +		dereference_function_descriptor(do_nothing));
> +	do_nothing();
> +
> +	pr_info("attempting bad execution at %px\n",
> +		dereference_function_descriptor(lkdtm_rodata_do_nothing));
> +	lkdtm_rodata_do_nothing();
> +	pr_err("FAIL: func returned\n");
>  }
>  
>  void lkdtm_EXEC_USERSPACE(void)
> -- 
> 2.31.1
> 

-- 
Kees Cook
