Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317C1259BF1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbgIARIy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbgIAPSA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 11:18:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9456C061244
        for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2020 08:17:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so233777plp.1
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2020 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jN9lhIYk+vgw0Ck0cVCcWxfdMAHspCt08b10OTqq50Y=;
        b=QNwyUWGqs9owKFllSjci/t28I81jLcjvgiBtzPpNMRmB+M2e4JBvG3SftYAgE8DETw
         A5b6HYulpcZeseDvZnxy5DImevpZ81cF8dcEq9K+/+/1l71Pmted5STlCijieeHbus5d
         vU2UHyXJC6TyBYorxv12caOk04LJayZkpsHkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jN9lhIYk+vgw0Ck0cVCcWxfdMAHspCt08b10OTqq50Y=;
        b=TatT4iK0E2tMOXaHGaVpW0CHIefwQtr3BpjA7ZUsgIsp1p8jFuhhZpb+6ei+W68NNV
         gC+CXkTgeU+l9sW1PnzkwwxUjEwNuHsFYb8KR3XxLsS+Sftm4yKqX8iqEoGuSImLNn2Z
         wY6h5ARZmCbuE4GiLsNE6RVyW3Bxb3PCTTKlxyampKP8455FYXNBfMUGtgmv3kybSTZd
         sUIxGk9i4dxqDOxv7ppp5Rt86x2mFFLAsMM9MX151hkhB5Pip6R/Hap4o69cQOmoi1AA
         6y+H+Xaebab8PwbXKPzBpShSH2V9QQwp6SiW4qAZb3M2PZSznlY03v5vk55oAowXoaFs
         M7cA==
X-Gm-Message-State: AOAM533D2xZr+8Qsc1MfijEKfsaE9C0epY/EtfDI0yaLNDJV1L7fOB0/
        mFjKqmu07Lu7cbwLiB1eLQKo8g==
X-Google-Smtp-Source: ABdhPJzj6yhyG4RDEF44EWGGFa00f7t2qp0yXpcOrOBamPDLCZ2Fwy8Mo8dB/mLaqQdQJtP1wf76Hg==
X-Received: by 2002:a17:90a:8a0d:: with SMTP id w13mr2008556pjn.218.1598973476573;
        Tue, 01 Sep 2020 08:17:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12sm2324629pfr.217.2020.09.01.08.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 08:17:55 -0700 (PDT)
Date:   Tue, 1 Sep 2020 08:17:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/29] Warn on orphan section placement
Message-ID: <202009010816.80F4692@keescook>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <202008311240.9F94A39@keescook>
 <20200901071133.GA3577996@gmail.com>
 <20200901075937.GA3602433@gmail.com>
 <20200901081647.GB3602433@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901081647.GB3602433@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 01, 2020 at 10:16:47AM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > 
> > > * Kees Cook <keescook@chromium.org> wrote:
> > > 
> > > > On Fri, Aug 21, 2020 at 12:42:41PM -0700, Kees Cook wrote:
> > > > > Hi Ingo,
> > > > > 
> > > > > Based on my testing, this is ready to go. I've reviewed the feedback on
> > > > > v5 and made a few small changes, noted below.
> > > > 
> > > > If no one objects, I'll pop this into my tree for -next. I'd prefer it
> > > > go via -tip though! :)
> > > > 
> > > > Thanks!
> > > 
> > > I'll pick it up today, it all looks very good now!
> > 
> > One thing I found in testing is that it doesn't handler older LD 
> > versions well enough:
> > 
> >   ld: unrecognized option '--orphan-handling=warn'

Oh! Uhm, yikes. Thanks for noticing this.

> > Could we just detect the availability of this flag, and emit a warning 
> > if it doesn't exist but otherwise not abort the build?

Yeah, I'll respin those patches.

> > This is with:
> > 
> >   GNU ld version 2.25-17.fc23

(At best, this is from 2015 ... but yes, min binutils in 2.23.)

> 
> I've resolved this for now by not applying the 5 patches that add the 
> actual orphan section warnings:
> 
>   arm64/build: Warn on orphan section placement
>   arm/build: Warn on orphan section placement
>   arm/boot: Warn on orphan section placement
>   x86/build: Warn on orphan section placement
>   x86/boot/compressed: Warn on orphan section placement
> 
> The new asserts plus the actual fixes/enhancements are enough changes 
> to test for now in any case. :-)

Yup! I'll respin the enabling patches. Thanks again!

-- 
Kees Cook
