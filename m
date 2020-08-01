Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB44D2350A2
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 07:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgHAFdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Aug 2020 01:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgHAFdB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Aug 2020 01:33:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B35C06174A
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 22:33:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w126so15311771pfw.8
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 22:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gffroDgUnFtt8A2AavQiebLwAg263HkbnMzJiVCWfkA=;
        b=lsTcCKnkfydw+Ii8km9p3UWo/dSvLz89JhsnBhbJ4TPkaTaq195uGU+xPmB7hbteXr
         QbKhXniVeEqsmfnOWWFUyZByl8X7XD7jRWvMO3yDVpNDz2RSQD9haATYARnEusPPiuFO
         9IoC96nIOOdr105GbzwVhN642SplbwKbAHC+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gffroDgUnFtt8A2AavQiebLwAg263HkbnMzJiVCWfkA=;
        b=RjjkIR/xa70OeoiJHz46osC4mwwkbz+uYJ7i9attWbkagr5PeDCS4wphY0vptwFN80
         T3BI1EmhAo1sDsgXwzw8eZieOX1GYf9jSJtnKtaMKLneHopzsSzCRpSC1QniFA53PXLF
         A4q8qZCC3ebh0HMPSdgA5YFy1UKvs/WsolqEuJHU2Iheb6FuZ90L/Cmi6A1U7/Iqljrw
         NSK+RbUre6TiKYI6nLmEWvvBkAqy5o4yDOv/IYJ1Q1VcgSsV/JBIw14Ny25HyWfN3W2K
         Cyrpm0UDjzqDzSujDueskQHLx9rZndpzFg4hKWt7h/gUiyTwLOorIXVMdGVgNITCZZah
         8SUQ==
X-Gm-Message-State: AOAM530R2LveVkXPfNl5lhM6XfN3g+54qsH8dr6q4KCa3LEf5bFIRlmG
        hPLuUIq4rMf2HCaauXXvyTe7vQ==
X-Google-Smtp-Source: ABdhPJwGtAMiLQ/CKOHffEnCRbIQ0jCrPXCRbE9RQyNgzuKoph7XnnkSnRWsaFmBUt+EPnWoPJLUcA==
X-Received: by 2002:a65:5604:: with SMTP id l4mr6920746pgs.268.1596259980678;
        Fri, 31 Jul 2020 22:33:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm12228821pfr.61.2020.07.31.22.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 22:32:59 -0700 (PDT)
Date:   Fri, 31 Jul 2020 22:32:58 -0700
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
Message-ID: <202007312231.60719F7C4@keescook>
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

When I switched from DISCARD to 0-assert, I tested all of these, but given
so many combinations, perhaps I made a mistake. I will double-check and
report back.

-- 
Kees Cook
