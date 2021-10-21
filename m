Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF2343673B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJUQHV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQHV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:07:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5151BC0613B9
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:05:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g184so734475pgc.6
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RsNvPGrD9cksDt68U63qt7b8W0KqjQ4tLt/WyGuMQOA=;
        b=aSmxvt1L6IeHMxowfOIQkN0/UAd61pYxsvBYnkdGGkFS/hJHrbCET96u59gAzI7w2t
         byPFK3ihPlqKC8IJT3rk5Z3owDzg1UhQP/kkJn88qmN258FozBnrZTtNBxMkrkGcbL+5
         ePk1Cq9OnTsTQhvRLNk0HFUi5g61NVyaUpkS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RsNvPGrD9cksDt68U63qt7b8W0KqjQ4tLt/WyGuMQOA=;
        b=OMqQwQqYf8cwEdDFufPdIl3GRNtLgXyAAJMYxiPfOXzWkwXLMvV8eGLLKufDwEJW+/
         BRWy66uVaNZ9B2QDgKpbT72RgAUzPvdRNqRdSVI01G3Xq2VUBJgoX+94rFoVTNHg6Brh
         R1C4FVkf3ACZ175ozO/OGmcuPrPhzKoXTdsk4cTEGlaXFGoGBKJQomQThd7V/YpajN/W
         IykPYRlHskNsO00RuyygrhB9HW7Oj+++KxYItRVhQHA9NB/HmzYsNloC+/cK55+6a7sk
         SP42roNdyPQlanjH5K3V5/Dm5r/EL0rWDz7Ly4lLcrJ5rXBNSVtF+C4X1kDfuKOPdhiJ
         149g==
X-Gm-Message-State: AOAM533Ri9EnLjswkudIdo6KSBYFGfpBC9oOVm806SNeCRPbS60TRPVM
        sxQlrp5sTycKFgMebrrHup9yCw==
X-Google-Smtp-Source: ABdhPJz43+Zd/nVQi+yWQ7Snl3NXdCHZrKYktFQM3OopuqGhBUdDr44+vMuciIyBw0esTbtWegdS6A==
X-Received: by 2002:a05:6a00:1829:b0:44d:df1f:5624 with SMTP id y41-20020a056a00182900b0044ddf1f5624mr6272124pfa.27.1634832304771;
        Thu, 21 Oct 2021 09:05:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 73sm6259554pfv.125.2021.10.21.09.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:05:04 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:05:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 03/20] reboot: Remove the unreachable panic after do_exit
 in reboot(2)
Message-ID: <202110210903.64145A81@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-3-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-3-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:49PM -0500, Eric W. Biederman wrote:
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/reboot.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index f7440c0c7e43..d6e0f9fb7f04 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -359,7 +359,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  	case LINUX_REBOOT_CMD_HALT:
>  		kernel_halt();
>  		do_exit(0);
> -		panic("cannot halt");

This looks like it was here for robustness (i.e. panic if do_exit
somehow fails)? But since do_exit() is marked __no_return, it doesn't
make sense to keep it. If we wanted to keep _something_ here, maybe just
add unreachable() ?

Reviewed-by: Kees Cook <keescook@chromium.org>

>  
>  	case LINUX_REBOOT_CMD_POWER_OFF:
>  		kernel_power_off();
> -- 
> 2.20.1
> 

-- 
Kees Cook
