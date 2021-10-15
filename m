Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0523742FD6F
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 23:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbhJOVdn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbhJOVdm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2021 17:33:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4507C061764
        for <linux-arch@vger.kernel.org>; Fri, 15 Oct 2021 14:31:35 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so9702023pgc.6
        for <linux-arch@vger.kernel.org>; Fri, 15 Oct 2021 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kKloKGIwGWmZY9+Er8BC6aPtcIV5M1fZmtHmnCWa8iU=;
        b=JeYYnn823k8n2zSxtjokkfqoZ5ilS26HSi3+OKWmuzF1ap1aszmc7JLPZWsF4HCG0w
         31EKzOJ0R9W8h1AKhQ/AK6BIP9nPFEBX8Fhn+ihNhFPlklATnjeMva6cxWbMA+SX6L+t
         CU/dKvCcEPU/V6JRuGbgX3x4m1PI5C82Th35I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kKloKGIwGWmZY9+Er8BC6aPtcIV5M1fZmtHmnCWa8iU=;
        b=ukbdD+5LZBA6PaTDjEeMncy0X1dCRvtIUt7pBcc7ywXpUi9PEvMff5ry2oTC4CcyM1
         zYF5Jw/MXSdX/BdSFPF5gja7lj+75GTHVMPhLKXDx7s5jb5XlxnJUNAl5DMQXjwfUJxy
         QHZMYNe2bSJELkCR/EjbW2r/3rXgpXozmiC+9nbaaJ73+I+LURQ/GU6yqHGO9Bmz5XkI
         GS7W6pbEZrNpO0SYZykOnxsk55buRdEWHSo67KP67R25fhdl/ZLmStF81/jtDRkji4R3
         kW4YYSLzTnat98YdEyrxeyC92qfzIrEliVhcxWtb0VflDy2Olq2OxzWSxhNOL7DVUc1L
         rKfA==
X-Gm-Message-State: AOAM533mGvz6zqWro+UCUf2N4wUWzbB2LA68SDCQAlUxxuLCAo+IdOOh
        ju+4BMfN8wT9RnMS2DF3kItohw==
X-Google-Smtp-Source: ABdhPJwdYjbf9GZPBypn6MBgVe8w8NzMTcIJZgnbet0In82Ohn0MIUwTdtq337oO2srKIC8IRC508w==
X-Received: by 2002:a05:6a00:992:b0:44d:8981:37f6 with SMTP id u18-20020a056a00099200b0044d898137f6mr9473913pfg.76.1634333495151;
        Fri, 15 Oct 2021 14:31:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gf23sm6006874pjb.26.2021.10.15.14.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:31:34 -0700 (PDT)
Date:   Fri, 15 Oct 2021 14:31:33 -0700
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
Subject: Re: [PATCH v2 12/13] lkdtm: Fix execute_[user]_location()
Message-ID: <202110151428.187B1CF@keescook>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <cbee30c66890994e116a8eae8094fa8c5336f90a.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbee30c66890994e116a8eae8094fa8c5336f90a.1634190022.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 07:50:01AM +0200, Christophe Leroy wrote:
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
>  drivers/misc/lkdtm/perms.c     | 25 +++++++++++++++++++++----
>  include/asm-generic/sections.h |  5 +++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 5266dc28df6e..96b3ebfcb8ed 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -44,19 +44,32 @@ static noinline void do_overwritten(void)
>  	return;
>  }
>  
> +static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
> +{
> +	memcpy(fdesc, do_nothing, sizeof(*fdesc));
> +	fdesc->addr = (unsigned long)dst;
> +	barrier();
> +
> +	return fdesc;
> +}

How about collapsing the "have_function_descriptors()" check into
setup_function_descriptor()?

static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
{
	if (__is_defined(HAVE_FUNCTION_DESCRIPTORS)) {
		memcpy(fdesc, do_nothing, sizeof(*fdesc));
		fdesc->addr = (unsigned long)dst;
		barrier();
		return fdesc;
	} else {
		return dst;
	}
}

> +
>  static noinline void execute_location(void *dst, bool write)
>  {
>  	void (*func)(void) = dst;
> +	func_desc_t fdesc;
> +	void *do_nothing_text = dereference_function_descriptor(do_nothing);
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
>  	pr_info("attempting bad execution at %px\n", func);
> +	if (have_function_descriptors())
> +		func = setup_function_descriptor(&fdesc, dst);
>  	func();
>  	pr_err("FAIL: func returned\n");
>  }
> @@ -67,15 +80,19 @@ static void execute_user_location(void *dst)
>  
>  	/* Intentionally crossing kernel/user memory boundary. */
>  	void (*func)(void) = dst;
> +	func_desc_t fdesc;
> +	void *do_nothing_text = dereference_function_descriptor(do_nothing);
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
>  	pr_info("attempting bad execution at %px\n", func);
> +	if (have_function_descriptors())
> +		func = setup_function_descriptor(&fdesc, dst);
>  	func();
>  	pr_err("FAIL: func returned\n");
>  }


> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index 76163883c6ff..d225318538bd 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -70,6 +70,11 @@ typedef struct {
>  } func_desc_t;
>  #endif
>  
> +static inline bool have_function_descriptors(void)
> +{
> +	return __is_defined(HAVE_FUNCTION_DESCRIPTORS);
> +}
> +
>  /* random extra sections (if any).  Override
>   * in asm/sections.h */
>  #ifndef arch_is_kernel_text

This hunk seems like it should live in a separate patch.

-- 
Kees Cook
