Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BAB24DEDF
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgHURtI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgHURtG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 13:49:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF63EC061574
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 10:49:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so1441749pfn.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/GMuE4utOPjO8y1lqv+OxzSdgWvuN+Qw8CbwkSqlnRQ=;
        b=eCrDRDas+JgyG8vEvUBUgIPw2N0eqtQG+RYzV7XhtoynuOnlhuZrdDQKbyFFclHrPn
         41Z9Xw1JtPUYek4ggdgXpKsZFiJa3q15fhr1kziwDYEDNpfhigdXs7VY5AbnexGH6F6H
         IR7D2Fb0exwgeUNMSrGrEH3RoaO/zxNkwt0yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GMuE4utOPjO8y1lqv+OxzSdgWvuN+Qw8CbwkSqlnRQ=;
        b=Vj2hiK8ImqYOU8d2XPWAwArDy/DFs8Vkfo7n8vYcKYLxMJI6yiON1p0OStpo5xaYey
         NN60UMIsRZCMq3z8ki52vZ4AioaqpKvmaQrKo9cpTnRZDsPcWLYMEMlMACevS84yiYde
         bwnhwFg3FSGDSOwqz37vgf7YqBhujzq7+J27WPPFd2ahcgcBLmgin7XwKQst0+mjzsv/
         URDj+85H0VrrIciZ0xGPOC2o8qd6qJCEp+xycNSNq+xgf96K5Cfdgpa7RXXNg0h1EONn
         Lq7P2hYRmaATsYBUWRQL82F0DAZn4Xb6orsNGbcElTSjWIC0XCp+j/YQB3b+g8KikT4R
         ViLw==
X-Gm-Message-State: AOAM530AjOqzr4CGcnBpxdVKvpcsXSIxCYFACjUydJfcRftDj1svTOzU
        6BYXOMtuO85HU/RFKe8H15v5bA==
X-Google-Smtp-Source: ABdhPJzUl78taPwahfjnA2wW/6wLLpPTFwhGbButfOHh+DcCELkk9TL4PVM8Ve4ZrX5sUSPgeYg/vQ==
X-Received: by 2002:a63:cf03:: with SMTP id j3mr3144186pgg.14.1598032144842;
        Fri, 21 Aug 2020 10:49:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c10sm3107533pfc.62.2020.08.21.10.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:49:03 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:49:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 29/36] x86/build: Enforce an empty .got.plt section
Message-ID: <202008211047.9088D8571C@keescook>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-30-keescook@chromium.org>
 <20200801021248.GB2700342@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801021248.GB2700342@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 31, 2020 at 10:12:48PM -0400, Arvind Sankar wrote:
> On Fri, Jul 31, 2020 at 04:08:13PM -0700, Kees Cook wrote:
> > The .got.plt section should always be zero (or filled only with the
> > linker-generated lazy dispatch entry). Enforce this with an assert and
> > mark the section as NOLOAD. This is more sensitive than just blindly
> > discarding the section.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/kernel/vmlinux.lds.S | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index 0cc035cb15f1..7faffe7414d6 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -414,8 +414,20 @@ SECTIONS
> >  	ELF_DETAILS
> >  
> >  	DISCARDS
> > -}
> >  
> > +	/*
> > +	 * Make sure that the .got.plt is either completely empty or it
> > +	 * contains only the lazy dispatch entries.
> > +	 */
> > +	.got.plt (NOLOAD) : { *(.got.plt) }
> > +	ASSERT(SIZEOF(.got.plt) == 0 ||
> > +#ifdef CONFIG_X86_64
> > +	       SIZEOF(.got.plt) == 0x18,
> > +#else
> > +	       SIZEOF(.got.plt) == 0xc,
> > +#endif
> > +	       "Unexpected GOT/PLT entries detected!")
> > +}
> >  
> >  #ifdef CONFIG_X86_32
> >  /*
> > -- 
> > 2.25.1
> > 
> 
> Is this actually needed? vmlinux is a position-dependent executable, and
> it doesn't get linked with any shared libraries, so it should never have
> a .got or .got.plt at all I think? Does it show up as an orphan without
> this?

Yup, I see this:

/usr/bin/ld.bfd: warning: orphan section `.got.plt' from `arch/x86/kernel/head_64.o' being placed in section `.got.plt'


-- 
Kees Cook
