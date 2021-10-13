Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13142B8C8
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 09:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbhJMHSr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbhJMHSl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 03:18:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E269C061762
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:16:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c4so1187018pls.6
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qi2kcK7gbHZUycBDWjYwOBh1qqhZS2gpMfLgpt9Uq+g=;
        b=DBeVwPHI8FJhK4IF5VHgTTJLctjt6LXWmLThZ2yFnKb+4pyEOAe0Ui9MkqyggUzG0q
         28MfwGk11htf2S4E1fmmF13OlhLumeXU3HW0grwDrGEkj60K3HN3BkQgDptITaIdv9Uy
         kua2TuyZ53AjYkbvnu6ABjlxXEF9G7ygD+r9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qi2kcK7gbHZUycBDWjYwOBh1qqhZS2gpMfLgpt9Uq+g=;
        b=nzn4x/nhD9R9tnatyLmeKx04JQbEgJZanLVns+m01DRnqs40GjO3CX1oT2j0rKXOKF
         Azt7yIuxYZKTcQM+XzUTWWb4L+N3MLZ7cV5629zBjNp++OBfOAlYq5Mqbia4+jsVBBLP
         rKxxENugv0ApmD/dZ2a0gGK+OBwemqKX/W8zfohkSG9cHhhdt0CNSLpZeEyrid9TZ2GR
         OYiustJnuaHjM7nJYWm/JbGAIB+5x/9spz6X0RpRxfslXbrwdGVGE9FOY+H2mj5mqH2F
         TGnU1s36Nn51jqFnskRfKYYssQn/7xVEZbUrKlBUDvzs16ur/Pq9Kcup+sGe8iGJ3da8
         OlEg==
X-Gm-Message-State: AOAM5317rd8kpQ1nRWrVOQ1cYcNO1dYztVKtD8gToPwi6qReAC2++sFd
        9LgsFBfsEkrU7tZBaWOFUzXhGg==
X-Google-Smtp-Source: ABdhPJyAOXrKW60jwbhdhdic11/bHUj22V/uWz/NG4QXRJ4qpgyk4BVyCru7dvuvTxCLWVGzDuPokg==
X-Received: by 2002:a17:90a:8807:: with SMTP id s7mr11433275pjn.226.1634109393567;
        Wed, 13 Oct 2021 00:16:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q14sm4820727pjm.17.2021.10.13.00.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 00:16:33 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:16:32 -0700
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
Subject: Re: [PATCH v1 10/10] lkdtm: Fix execute_[user]_location()
Message-ID: <202110130012.4608FFD38E@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <c551f3f4b803d1a4a184b0fa94475d405ba436d8.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c551f3f4b803d1a4a184b0fa94475d405ba436d8.1633964380.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 11, 2021 at 05:25:37PM +0200, Christophe Leroy wrote:
> execute_location() and execute_user_location() intent
> to copy do_nothing() text and execute it at a new location.
> However, at the time being it doesn't copy do_nothing() function
> but do_nothing() function descriptor which still points to the
> original text. So at the end it still executes do_nothing() at
> its original location allthough using a copied function descriptor.
> 
> So, fix that by really copying do_nothing() text and build a new
> function descriptor by copying do_nothing() function descriptor and
> updating the target address with the new location.
> 
> Also fix the displayed addresses by dereferencing do_nothing()
> function descriptor.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/misc/lkdtm/perms.c | 45 +++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index da16564e1ecd..1d03cd44c21d 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -44,19 +44,42 @@ static noinline void do_overwritten(void)
>  	return;
>  }
>  
> +static void *setup_function_descriptor(funct_descr_t *fdesc, void *dst)
> +{
> +	int err;
> +
> +	if (!__is_defined(HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR))
> +		return dst;
> +
> +	err = copy_from_kernel_nofault(fdesc, do_nothing, sizeof(*fdesc));
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	fdesc->addr = (unsigned long)dst;
> +	barrier();
> +
> +	return fdesc;
> +}
> +
>  static noinline void execute_location(void *dst, bool write)
>  {
> -	void (*func)(void) = dst;
> +	void (*func)(void);
> +	funct_descr_t fdesc;
> +	void *do_nothing_text = dereference_symbol_descriptor(do_nothing);
>  
> -	pr_info("attempting ok execution at %px\n", do_nothing);
> +	pr_info("attempting ok execution at %px\n", do_nothing_text);
>  	do_nothing();
>  
>  	if (write == CODE_WRITE) {
> -		memcpy(dst, do_nothing, EXEC_SIZE);
> +		memcpy(dst, do_nothing_text, EXEC_SIZE);
>  		flush_icache_range((unsigned long)dst,
>  				   (unsigned long)dst + EXEC_SIZE);
>  	}
> -	pr_info("attempting bad execution at %px\n", func);
> +	func = setup_function_descriptor(&fdesc, dst);
> +	if (IS_ERR(func))
> +		return;

I think this error case should complain with some details. :) Maybe:

	pr_err("FAIL: could not build function descriptor for %px\n", dst);

> +
> +	pr_info("attempting bad execution at %px\n", dst);

And then leave this pr_info() as it was, before the
setup_function_descriptor() call.

>  	func();
>  	pr_err("FAIL: func returned\n");
>  }
> @@ -66,16 +89,22 @@ static void execute_user_location(void *dst)
>  	int copied;
>  
>  	/* Intentionally crossing kernel/user memory boundary. */
> -	void (*func)(void) = dst;
> +	void (*func)(void);
> +	funct_descr_t fdesc;
> +	void *do_nothing_text = dereference_symbol_descriptor(do_nothing);
>  
> -	pr_info("attempting ok execution at %px\n", do_nothing);
> +	pr_info("attempting ok execution at %px\n", do_nothing_text);
>  	do_nothing();
>  
> -	copied = access_process_vm(current, (unsigned long)dst, do_nothing,
> +	copied = access_process_vm(current, (unsigned long)dst, do_nothing_text,
>  				   EXEC_SIZE, FOLL_WRITE);
>  	if (copied < EXEC_SIZE)
>  		return;
> -	pr_info("attempting bad execution at %px\n", func);
> +	func = setup_function_descriptor(&fdesc, dst);
> +	if (IS_ERR(func))
> +		return;
> +
> +	pr_info("attempting bad execution at %px\n", dst);

Same here.

>  	func();
>  	pr_err("FAIL: func returned\n");
>  }
> -- 
> 2.31.1
> 

-- 
Kees Cook
