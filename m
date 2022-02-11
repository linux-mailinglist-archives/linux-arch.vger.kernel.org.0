Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18E4B1AFA
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 02:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346675AbiBKBJY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 20:09:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiBKBJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 20:09:22 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0308B40
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 17:09:22 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id u16so7708378pfg.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 17:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5F/YGzVmxucCV2w+SE7XEhbRoXDDpQToobLbIhWaHYc=;
        b=O7Cni19xFycNNK4IUy1daQ4E99VFUDXm8NRv0PVumWB3oOLgQHBSvi4/VQ3YmmUfKM
         i1ZA07f5QkAcyXONb8QxwlzHG2SF5Dcy4mwDq1Qo6muqtRFYHUYCLe1JM3RnvTyI3INV
         RyyyWu81uFVEx/hxuyhPODN9C1WQGzlVWJIMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5F/YGzVmxucCV2w+SE7XEhbRoXDDpQToobLbIhWaHYc=;
        b=OkKrqdD+L6gD3ryoydGAhnhaIgB/JjFZW2BgChv+jPnFE5aYbshxsYtESFS9Qdvu9X
         Jojnzx2i1MTzg6fbEJbQHOVX8PUFwFWd4xcR8GGoJAuTU7yQB5poVT9QRMyR3sr4IIg7
         JirW/7Wtuvyq5cRbNjkcr3tBpFgQ17UC0910XSLyUZuGwHwFn2XJQcmgj/z2VIrBnYwI
         H5MFjDVu66S1tOcTzE7obHYt6sPnGauoq36zq+/7GeBqjvkw1nNkiWVYpl7ydbos2rKS
         XzPQ2uZlLleAbp2jfoa+X7mRuQfezhbExFM2RNe/3QAiJruu36K0FGhxpIQLZ0NgoZUL
         JErw==
X-Gm-Message-State: AOAM533TJapamGlQQiDTVZZgV/9mGAfe9L0puPvzLu4lW3xeH3WinzCj
        vWHa+mNZQWuzclui4yb2s9xGZg==
X-Google-Smtp-Source: ABdhPJwvw0DfYnLU4ASZ7YxnRfLhjmjJWmRRXYFhu4Zcr1DUaXzi6LQObbQCgkweT4gdbKfWrpGQUQ==
X-Received: by 2002:aa7:9486:: with SMTP id z6mr10192650pfk.76.1644541762433;
        Thu, 10 Feb 2022 17:09:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 10sm24234252pfm.56.2022.02.10.17.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 17:09:22 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:09:21 -0800
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
Subject: Re: [PATCH v3 12/12] lkdtm: Add a test for function descriptors
 protection
Message-ID: <202202101703.993CA9BC@keescook>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <67f9545c9ad15048bfe0104278ef9595d051dbc8.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f9545c9ad15048bfe0104278ef9595d051dbc8.1634457599.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 17, 2021 at 02:38:25PM +0200, Christophe Leroy wrote:
> Add WRITE_OPD to check that you can't modify function
> descriptors.
> 
> Gives the following result when function descriptors are
> not protected:
> 
> 	lkdtm: Performing direct entry WRITE_OPD
> 	lkdtm: attempting bad 16 bytes write at c00000000269b358
> 	lkdtm: FAIL: survived bad write
> 	lkdtm: do_nothing was hijacked!
> 
> Looks like a standard compiler barrier() is not enough to force
> GCC to use the modified function descriptor. Had to add a fake empty
> inline assembly to force GCC to reload the function descriptor.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/misc/lkdtm/core.c  |  1 +
>  drivers/misc/lkdtm/lkdtm.h |  1 +
>  drivers/misc/lkdtm/perms.c | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index fe6fd34b8caf..de092aa03b5d 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -148,6 +148,7 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(WRITE_RO),
>  	CRASHTYPE(WRITE_RO_AFTER_INIT),
>  	CRASHTYPE(WRITE_KERN),
> +	CRASHTYPE(WRITE_OPD),
>  	CRASHTYPE(REFCOUNT_INC_OVERFLOW),
>  	CRASHTYPE(REFCOUNT_ADD_OVERFLOW),
>  	CRASHTYPE(REFCOUNT_INC_NOT_ZERO_OVERFLOW),
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index c212a253edde..188bd0fd6575 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -105,6 +105,7 @@ void __init lkdtm_perms_init(void);
>  void lkdtm_WRITE_RO(void);
>  void lkdtm_WRITE_RO_AFTER_INIT(void);
>  void lkdtm_WRITE_KERN(void);
> +void lkdtm_WRITE_OPD(void);
>  void lkdtm_EXEC_DATA(void);
>  void lkdtm_EXEC_STACK(void);
>  void lkdtm_EXEC_KMALLOC(void);
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 1cf24c4a79e9..2c6aba3ff32b 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -44,6 +44,11 @@ static noinline void do_overwritten(void)
>  	return;
>  }
>  
> +static noinline void do_almost_nothing(void)
> +{
> +	pr_info("do_nothing was hijacked!\n");
> +}
> +
>  static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
>  {
>  	if (!have_function_descriptors())
> @@ -144,6 +149,23 @@ void lkdtm_WRITE_KERN(void)
>  	do_overwritten();
>  }
>  
> +void lkdtm_WRITE_OPD(void)
> +{
> +	size_t size = sizeof(func_desc_t);
> +	void (*func)(void) = do_nothing;
> +
> +	if (!have_function_descriptors()) {
> +		pr_info("XFAIL: Platform doesn't use function descriptors.\n");
> +		return;
> +	}
> +	pr_info("attempting bad %zu bytes write at %px\n", size, do_nothing);
> +	memcpy(do_nothing, do_almost_nothing, size);
> +	pr_err("FAIL: survived bad write\n");

Non-function-descriptor architectures would successfully crash at the
memcpy too, right? (i.e. for them this is just repeating WRITE_KERN)

I'm pondering the utility of the XFAIL vs just letting is succeed, but I
think it more accurate to say "hey, no OPD" as you have it.

> +
> +	asm("" : "=m"(func));
> +	func();
> +}
> +
>  void lkdtm_EXEC_DATA(void)
>  {
>  	execute_location(data_area, CODE_WRITE);
> -- 
> 2.31.1
> 

One tiny suggestion, since I think you need to respin for the
EXPORT_SYMBOL_GPL() anyway. Please update the selftests too:

diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 6b36b7f5dcf9..243c781f0780 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -44,6 +44,7 @@ ACCESS_NULL
 WRITE_RO
 WRITE_RO_AFTER_INIT
 WRITE_KERN
+WRITE_OPD
 REFCOUNT_INC_OVERFLOW
 REFCOUNT_ADD_OVERFLOW
 REFCOUNT_INC_NOT_ZERO_OVERFLOW

(Though for the future I've been considering making the selftests an
opt-out list so the "normal" stuff doesn't need to keep getting added
there.)

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
