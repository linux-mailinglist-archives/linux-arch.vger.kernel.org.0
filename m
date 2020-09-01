Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A5C25A1D8
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 01:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIAXSJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 19:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIAXSI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 19:18:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7A4C061244
        for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2020 16:18:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so1341278plt.3
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2020 16:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4iyrZMhsm50EAs3g2KnI7xhSNv02uS5mIc/bNi5tMhA=;
        b=h1W3rhK11Ac2ULHxITQVWk+mYa5KEEodEYvcXH6ZBK0sVGUcKUNSYh5WpmAqVdJ4uM
         laH+r/2+ofVbyxPYxM/BYCZTO3d1jcstILzzhKlZMC4jxxBsADHZmsJZMYMsDLc0Xqts
         f/ywKAW1F2cWVr+Ovsyf3pu5q6m5rdIcz38XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4iyrZMhsm50EAs3g2KnI7xhSNv02uS5mIc/bNi5tMhA=;
        b=qelXVFDw6tDfFX+PA4Cw9syb/q5sFpJVWQQwBMxqX1/+DfR/dLaiTnmPnH+ptOx89U
         uOeRgdIAKsNrO5gnln/h6ZAeKMUH4SPdI16okHP7HVbLApr9e4rNuQArAwnGuT9xS/6J
         CH1EoWipAaM0S4FqLygoksvLn7AsZ/4L7ZBjnXNFH880aLo/Uk+Z5t4yR3GKkjRPhT2l
         sIp3jMqbfBCbQStU+l9BF+8sU7J598MsylQzScNmE1r/+5sXqafw3gJBlgFsP7915Ijz
         pereTeyrxrT4bceKtEZF7MkTZWxQUAaanFHbUJ9L3oPn8IJv5tGgWzAHAtyw/hKPNG+d
         fSeg==
X-Gm-Message-State: AOAM532xS/YKUudjUbdst6FIwg4KUTGqA/e+mgU1wblwCMqW/VQ+T8tr
        noLk0vuoQxiYp0PYFx+SB7NUzg==
X-Google-Smtp-Source: ABdhPJygBwAH2kY44WcP2KmDZ++JT1L7dvXf2P1Gp3pBp8hQP0G/2rd4h4BS1PltNzQUpbBUJyzvFQ==
X-Received: by 2002:a17:902:7404:: with SMTP id g4mr2271545pll.176.1599002287789;
        Tue, 01 Sep 2020 16:18:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l22sm3506944pfc.27.2020.09.01.16.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 16:18:06 -0700 (PDT)
Date:   Tue, 1 Sep 2020 16:18:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/29] Warn on orphan section placement
Message-ID: <202009011616.E6DC7D54EF@keescook>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <202008311240.9F94A39@keescook>
 <20200901071133.GA3577996@gmail.com>
 <20200901075937.GA3602433@gmail.com>
 <20200901081647.GB3602433@gmail.com>
 <202009010816.80F4692@keescook>
 <CAKwvOdnn3wxYdJomvnveyD_njwRku3fABWT_bS92duihhywLJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnn3wxYdJomvnveyD_njwRku3fABWT_bS92duihhywLJQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 01, 2020 at 11:02:02AM -0700, Nick Desaulniers wrote:
> On Tue, Sep 1, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Sep 01, 2020 at 10:16:47AM +0200, Ingo Molnar wrote:
> > > > This is with:
> > > >
> > > >   GNU ld version 2.25-17.fc23
> >
> > (At best, this is from 2015 ... but yes, min binutils in 2.23.)
> 
> Ah, crap! Indeed arch/powerpc/Makefile wraps this in ld-option.

Yeah, I totally missed that too. :)

> Uh oh, the ppc vdso uses cc-ldoption which was removed! (I think by
> me; let me send patches)  How is that not an error?  Yes, guilty,
> officer.
> commit 055efab3120b ("kbuild: drop support for cc-ldoption").
> Did I not know how to use grep, or?  No, it is
> commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
> that is wrong.

Eek, yeah, the vdso needs fixing; whoops. Lucky for my series, I only need
ld-option! ;)

(Doing test builds now...)

-- 
Kees Cook
