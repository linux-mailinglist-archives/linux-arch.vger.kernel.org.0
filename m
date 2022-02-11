Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACB34B1AC9
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 01:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346575AbiBKA46 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 19:56:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbiBKA45 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 19:56:57 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741955F86
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 16:56:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso7341612pjg.0
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 16:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ij/kmXjVco913jFIkkr0+ao7hUYo8HGlc/rK4hm1cYU=;
        b=M5RXsM8hcmF2OyubtKqmtKo9RQPAPFPtvpfZEQCB2c6Yh3rjKFo51PskthrNNxXsr7
         zbR6px5umZ8O8jrv0grWJWpisBdpRGU+wZ/a6x9Q+B7hMAGf18yBfGQq4BkRaDUVXnWe
         yd1fF+V2U67gyXSd8Lol6Adn51X6EmhwjU59k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ij/kmXjVco913jFIkkr0+ao7hUYo8HGlc/rK4hm1cYU=;
        b=NxAPP2y3N2E7PDgXE7VNwwyv1WlPhfKP/ldTDc2FjtBi/OG233EDwwhlpATSWMYBPg
         nTp1K7hlOT4QLxbQtA81L9hbdPBbiBl/HWhWdbItUnwfCUCEKK+WYjGt33iPSFWTF/hZ
         l/MsGWFIVT8aA/2LOdTmmXfrRMcZdqR35XOiGdK7gPOcveWC0QxXGLDY0VjWfld8sjRo
         J+xPzf97ihFtqdVvH5I0VabEKPAF796ef5TDwOGVgHbKZEYKchBKJlKMqyB7/nHdT+mb
         guk4B+w5FvNQ21RVCqKpJlG4+8vReRlLk9wOX/6ZwjBFuN4e1E9s5qyLyY/AP8cJp8AN
         4Adw==
X-Gm-Message-State: AOAM530n7Dt1KldV5/lnDZiB8UcPZujrNtYW0NE7EuTTe5WgQaEMjE2z
        ybCo8O2jDgdbOS5ZsfkaDcvudg==
X-Google-Smtp-Source: ABdhPJxO7mzzG+kyJMfp7NkXFdu5xyqbCDL1T1A1JqI341m3kYcbAuWEHEe++omXhqTKNFgkrZ2BTQ==
X-Received: by 2002:a17:902:cf02:: with SMTP id i2mr9960280plg.146.1644541016958;
        Thu, 10 Feb 2022 16:56:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a14sm1718704pgw.27.2022.02.10.16.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:56:56 -0800 (PST)
Date:   Thu, 10 Feb 2022 16:56:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 08/12] asm-generic: Refactor
 dereference_[kernel]_function_descriptor()
Message-ID: <202202101655.13C794F0F@keescook>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <93a2006a5d90292baf69cb1c34af5785da53efde.1634457599.git.christophe.leroy@csgroup.eu>
 <8735kr814c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735kr814c.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 09:30:43PM +1100, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > diff --git a/kernel/extable.c b/kernel/extable.c
> > index b0ea5eb0c3b4..1ef13789bea9 100644
> > --- a/kernel/extable.c
> > +++ b/kernel/extable.c
> > @@ -159,12 +160,32 @@ int kernel_text_address(unsigned long addr)
> >  }
> >  
> >  /*
> > - * On some architectures (PPC64, IA64) function pointers
> > + * On some architectures (PPC64, IA64, PARISC) function pointers
> >   * are actually only tokens to some data that then holds the
> >   * real function address. As a result, to find if a function
> >   * pointer is part of the kernel text, we need to do some
> >   * special dereferencing first.
> >   */
> > +#ifdef CONFIG_HAVE_FUNCTION_DESCRIPTORS
> > +void *dereference_function_descriptor(void *ptr)
> > +{
> > +	func_desc_t *desc = ptr;
> > +	void *p;
> > +
> > +	if (!get_kernel_nofault(p, (void *)&desc->addr))
> > +		ptr = p;
> > +	return ptr;
> > +}
> 
> This needs an EXPORT_SYMBOL_GPL(), otherwise the build breaks after
> patch 10 with CONFIG_LKDTM=m.

Oh good catch!

(There have been a few cases of LKDTM=m being the only thing needed a
symbol, so I've pondered giving it a namespace or constructing a little
ifdef wrapper... but this seems ok to export...)

-- 
Kees Cook
