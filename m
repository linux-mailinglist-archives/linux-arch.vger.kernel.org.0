Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE5F42B87F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 09:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhJMHLW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhJMHLU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 03:11:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB45C061746
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:09:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id np13so1457591pjb.4
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9B8532Yqv4ro9UPpSECsrKFDalIVcpozoR3xlP35mOo=;
        b=mOSmWjnWgLyjFNwZ0JklI8sCKMnMMWbDMjBEiqgViAMnDbbLoqtyhfRZSXhu78BZva
         fZi0/vUzbbm9hey6oND+v9LEaQMLMU+ZNQpseYV/sBelGJ8lZ6Uni5v40eDIb3NjnOvq
         Fz3mNpV5Hm0WMOjWDkkg0bltm0biFBS/mCHk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9B8532Yqv4ro9UPpSECsrKFDalIVcpozoR3xlP35mOo=;
        b=N37iuo7soK4iTNOt9BaLcWap6ozyMDXqNVKtaWnwO0fA0n1dRuOOi7N4Jst2zIpmHu
         s+A75MPF++0AKx9KnbdwXRW7HcN3LgUjrG1aFqs+GSAA2LfYZlY5ycsUaJpKUtzfd5fP
         B/gW7g9T4B8NmNohFlmYCDdYTdvhsk0UgKpuyJJkAewujrfbH7EShQNnUaonU3hJ+Tq4
         R/8y3sqLgPQzcwfsHbXInuwXlcFrRTY79epqD3gJYYLSEhA+chMw0j/G+PAQvV7SoFnp
         9t0wovxXY/Q0GMMMMB8FqmiEXZvuqi/z+tBIzyVf31IZ1vBoIhdaWTdMiWn6vd/B3d9U
         J5vw==
X-Gm-Message-State: AOAM530I0HNdroXpfCAVSvfVP//WEBlhvY9rCaKLXqm1TLeIrf6hyrmu
        r+9nO2M6LvHnlApJn32j7Z8LIw==
X-Google-Smtp-Source: ABdhPJwNfT+PN9/6KcLorXFjdNFizJJQ4LNC6e+5MQ9vFZUDGTpFiM1qVaKprUL29bSaC2DkxYGXsw==
X-Received: by 2002:a17:90a:6542:: with SMTP id f2mr8159904pjs.159.1634108957279;
        Wed, 13 Oct 2021 00:09:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p2sm4697310pja.51.2021.10.13.00.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 00:09:16 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:09:16 -0700
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
Subject: Re: [PATCH v1 09/10] lkdtm: Fix lkdtm_EXEC_RODATA()
Message-ID: <202110130008.EC5E957D4A@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <7da92e59e148bd23564d63bdd8bcfaba0ba6d1f1.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da92e59e148bd23564d63bdd8bcfaba0ba6d1f1.1633964380.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 11, 2021 at 05:25:36PM +0200, Christophe Leroy wrote:
> Behind a location, lkdtm_EXEC_RODATA() executes a real function,
> not a copy of do_nothing().
> 
> So do it directly instead of using execute_location().

I don't understand this. Why does the next patch not fix this?

-Kees

> 
> And fix displayed addresses by dereferencing the function descriptors.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/misc/lkdtm/perms.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 442d60ed25ef..da16564e1ecd 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -153,7 +153,14 @@ void lkdtm_EXEC_VMALLOC(void)
>  
>  void lkdtm_EXEC_RODATA(void)
>  {
> -	execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
> +	pr_info("attempting ok execution at %px\n",
> +		dereference_symbol_descriptor(do_nothing));
> +	do_nothing();
> +
> +	pr_info("attempting bad execution at %px\n",
> +		dereference_symbol_descriptor(lkdtm_rodata_do_nothing));
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
