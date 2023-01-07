Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F76660DF8
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jan 2023 11:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjAGKkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 Jan 2023 05:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjAGKkt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Jan 2023 05:40:49 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E784435939;
        Sat,  7 Jan 2023 02:40:47 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g10so2677891wmo.1;
        Sat, 07 Jan 2023 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7wsnRffu5O2RWgyv3GZ3K8cLeYYuVq6dZD0H2Sa32E=;
        b=ZLxygyA9kLt9+RMfDbWEaTfO6aYKJ113bhDgVMRWwq+CqNgPufmOTCjuVZ+r9LkSQF
         TlFH4dlUugnM3xwRicIx+ni1A6QtYpvbkcGMzIkOEFa5tyZhwsrdc2Gk7wULwUa1T/TD
         k3mW7KKISxXn1Z3ujcubF278OW8DVEveZuiowjPSwzAR5ePpY6gj9GBpPMbv5w0wPNFe
         pMCi+EH+X2fGAuR4dMac2XNWHrOC/ZOmtfZvqMDPP91zVNtn/0GxU5Cnk/AMgT+uc8yX
         pF8IEuW6wBJOVfwmp9zFTtNzdk5LmSQRHTsmJKj1R/Vr1dQQicljNxp3p9qsPwGgIuWa
         CevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7wsnRffu5O2RWgyv3GZ3K8cLeYYuVq6dZD0H2Sa32E=;
        b=qyp6pnPTwm5VAR3P6v3vW2w+Q2IStFV7AiFhUyYM4OKzDmrBU+5rn3zHO7hxSCOEWC
         h+FNEO3/G+EG2DPh+LDHknJX0izsoCZmSU1mJoNW33SfYrlo3JVTGa6ac3sCBFjmTSG2
         1c1rumLJOKy21t/bGdO9gA3940OVUf35axuicI6USLzqkLuSu5QlIq834hqTF8TPfUeM
         UicyaI66JRRhNVOXaX0Eq3eAx5QssV9FAzdrAuCIhGRXaXhtEYlY0HG2PShF6msH2QMs
         7VHpnwPlxGFzh/k29gEpqhjmv7XhJnxWzFzR78UikMAdL0/j3LAxwNxVpxSQU8QMIwuW
         ZHiQ==
X-Gm-Message-State: AFqh2kpFoZwrUyMIeEiRg0hj4vsbbDj0ikAc2YZsy40Tne6F8jDlmIuM
        oovAcftJJFoPN22BmQH8Lvs=
X-Google-Smtp-Source: AMrXdXuq+EWlBkcohRlbrPONGYn5FEPQFIlh1f/oLALicT3AP+m1ni8UQ+QudfRzNpxDC72kSlEnnw==
X-Received: by 2002:a05:600c:2d07:b0:3d3:5841:e8b4 with SMTP id x7-20020a05600c2d0700b003d35841e8b4mr40607615wmf.35.1673088046544;
        Sat, 07 Jan 2023 02:40:46 -0800 (PST)
Received: from gmail.com (1F2EF507.nat.pool.telekom.hu. [31.46.245.7])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b003d01b84e9b2sm5377974wms.27.2023.01.07.02.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 02:40:43 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 7 Jan 2023 11:40:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Liam Ni <zhiguangni01@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] x86/boot: Check if the input parameter (buffer) of the
 function is a null pointer
Message-ID: <Y7lMKhXSQvwvLq7L@gmail.com>
References: <20221206125929.12237-1-zhiguangni01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206125929.12237-1-zhiguangni01@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Liam Ni <zhiguangni01@gmail.com> wrote:

> If the variable buffer is a null pointer, it may cause the kernel to crash.
> 
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>  arch/x86/boot/cmdline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/cmdline.c b/arch/x86/boot/cmdline.c
> index 21d56ae83cdf..d0809f66054c 100644
> --- a/arch/x86/boot/cmdline.c
> +++ b/arch/x86/boot/cmdline.c
> @@ -39,7 +39,7 @@ int __cmdline_find_option(unsigned long cmdline_ptr, const char *option, char *b
>  		st_bufcpy	/* Copying this to buffer */
>  	} state = st_wordstart;
>  
> -	if (!cmdline_ptr)
> +	if (!cmdline_ptr || buffer == NULL)
>  		return -1;      /* No command line */

Can this ever happen?

Thanks,

	Ingo
