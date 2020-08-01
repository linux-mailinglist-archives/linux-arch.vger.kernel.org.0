Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D2E2350AF
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 07:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHAFgD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Aug 2020 01:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHAFgC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Aug 2020 01:36:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA374C06174A
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 22:36:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k1so8327169pjt.5
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 22:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TiksbxZAq651HXyzgXud8H+oOdlAwciZhMVaJuNaJO0=;
        b=fM/bL01waNwSe4ZuLsFiF5lgrC0CZA3LVoNOKHEfJt+W4CsL008YBdKU0zkDxQHZw2
         If/SNkBwc6Tx0xWwSQyfs78u5lB0K3VImeoFLJnGn/imzBJdZ8I0C1jevEYAxqawGVjv
         sMOW37bYu6qq1l0NJXfCWFFmyxa0Wn9Rx1lL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TiksbxZAq651HXyzgXud8H+oOdlAwciZhMVaJuNaJO0=;
        b=WYUw16+MD8aFkzdLZFzm2mtKfmDdURXTPOrNaFPgl8nCxAKOE2rr5lNoEN37BfwPNQ
         izQvpPIvJoW/Q5i2G76RQ5X/1DlHYa3M64J6WIgE/xfuh66EDb+jFW/D6puwsGeO8H5q
         IFyUPtDOOYkcQvg6ZLApDsrfC5RCHHbUZpRtp0nVu1ns1RaAO7ZuqKDTfd9z5PayzhXe
         oAKY4u5VedvsJ5Y7w7WNxakNhz4+SUJOZsnKYWYtRfrOhzS/TWSvH60CGAPDtly3yMpb
         pZ237sN5BCMf+AjP7nFIRMfP5UW6qNkdOiXmJw5TvKv3f54F9JlKfhOqS2O8nBBUJs4j
         EO4w==
X-Gm-Message-State: AOAM533QGOIV938eNJyK+EqOKl9Fzn9wwyh3Uo5zo9xf4HJzJ9TD9GSC
        40VjUdxUkNB9pn6iezZi3F4Etg==
X-Google-Smtp-Source: ABdhPJxBoVsLIfUCbTZK4Pt16UaZpEaNpjnTwzZAWj8yK7T+WP153kIvw3NqlQm5VCwH7XEDaByGhQ==
X-Received: by 2002:a17:90a:d195:: with SMTP id fu21mr7200561pjb.100.1596260162387;
        Fri, 31 Jul 2020 22:36:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm11886481pgh.58.2020.07.31.22.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 22:36:01 -0700 (PDT)
Date:   Fri, 31 Jul 2020 22:36:00 -0700
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
Subject: Re: [PATCH v5 32/36] x86/boot/compressed: Reorganize zero-size
 section asserts
Message-ID: <202007312235.4A48157938@keescook>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-33-keescook@chromium.org>
 <20200801014755.GA2700342@rani.riverdale.lan>
 <20200801025325.GA2800311@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801025325.GA2800311@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 31, 2020 at 10:53:25PM -0400, Arvind Sankar wrote:
> On Fri, Jul 31, 2020 at 09:47:55PM -0400, Arvind Sankar wrote:
> > On Fri, Jul 31, 2020 at 04:08:16PM -0700, Kees Cook wrote:
> > > For readability, move the zero-sized sections to the end after DISCARDS
> > > and mark them NOLOAD for good measure.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  arch/x86/boot/compressed/vmlinux.lds.S | 42 +++++++++++++++-----------
> > >  1 file changed, 25 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > index 3c2ee9a5bf43..42dea70a5091 100644
> > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > @@ -42,18 +42,16 @@ SECTIONS
> > >  		*(.rodata.*)
> > >  		_erodata = . ;
> > >  	}
> > > -	.rel.dyn : {
> > > -		*(.rel.*)
> > > -	}
> > > -	.rela.dyn : {
> > > -		*(.rela.*)
> > > -	}
> > > -	.got : {
> > > -		*(.got)
> > > -	}
> > >  	.got.plt : {
> > >  		*(.got.plt)
> > >  	}
> > > +	ASSERT(SIZEOF(.got.plt) == 0 ||
> > > +#ifdef CONFIG_X86_64
> > > +	       SIZEOF(.got.plt) == 0x18,
> > > +#else
> > > +	       SIZEOF(.got.plt) == 0xc,
> > > +#endif
> > > +	       "Unexpected GOT/PLT entries detected!")
> > >  
> > >  	.data :	{
> > >  		_data = . ;
> > > @@ -85,13 +83,23 @@ SECTIONS
> > >  	ELF_DETAILS
> > >  
> > >  	DISCARDS
> > > -}
> > >  
> > > -ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > > -#ifdef CONFIG_X86_64
> > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> > > -#else
> > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > > -#endif
> > > +	/*
> > > +	 * Sections that should stay zero sized, which is safer to
> > > +	 * explicitly check instead of blindly discarding.
> > > +	 */
> > > +	.got (NOLOAD) : {
> > > +		*(.got)
> > > +	}
> > > +	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > >  
> > > -ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> > > +	/* ld.lld does not like .rel* sections being made "NOLOAD". */
> > > +	.rel.dyn : {
> > > +		*(.rel.*)
> > > +	}
> > > +	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> > > +	.rela.dyn : {
> > > +		*(.rela.*)
> > > +	}
> > > +	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> > > +}
> > > -- 
> > > 2.25.1
> > > 
> > 
> > There's no point in marking zero-size sections NOLOAD -- if the ASSERT's
> > passed, they won't be present in the file at all anyway.
> > 
> > The only section for which there might be a point is .got.plt, which is
> > non-empty on 32-bit, and only if it is first moved to the end. That
> > saves a few bytes.
> 
> Btw, you should move .got.plt also to the end anyway for readability,
> it's unused even if non-empty. And with the ASSERT being placed
> immediately after it, it's even more distracting from the actual section
> layout.

ld.bfd (if I'm remembering correctly) was extraordinarily upset about it
being at the end. I will retest and report back.

-- 
Kees Cook
