Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651D625ED27
	for <lists+linux-arch@lfdr.de>; Sun,  6 Sep 2020 09:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIFHY2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Sep 2020 03:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIFHY0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Sep 2020 03:24:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0BEC061573;
        Sun,  6 Sep 2020 00:24:25 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z22so13787929ejl.7;
        Sun, 06 Sep 2020 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tXMiLtKX1CVIBd5uJ7b5aMxZLokTxvClgRBNmQrzapA=;
        b=BB6hDfiwXqMAUdNYT2xsR71INyutoDM4abdc7WssoypEC7cvIlq13DNAgHvK6T7GdY
         Jzi/oyql1X0gJuttAMnMhJkncL8eIm3hoICztGz5SWDIDsjANRYzR53+qKT8TV6fFUko
         vZfGQBkJ4ilgbno7HM5vmieKqDJUPnTH4bRDCjh4ee/CcuPwRMnyLKe+nHp5U4r4veiv
         NmGKKVYRmcbdNPaw9bbszQTWGJLICm3bve0Xf87WBYOUxz8SzsZVH1ZnDyH+U9zo7eOT
         sDrq8gvVGT6l95wy13MrqAaXbEHURodxIwpApfovElirb97TAR3S0XTlnE0u/ifw36A/
         raTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tXMiLtKX1CVIBd5uJ7b5aMxZLokTxvClgRBNmQrzapA=;
        b=qZrjKkSBMBaWOjmfoJ431q8LHl+OLhU4uHSgIjQAfuVCctF/K7QdND0OUYgt4AzaFA
         fSzAaYw9PcbomOp7nb71OCKcELvSyWilaznw1Q2d0ePHcpAGIVoN38ZKMazOVOMi59tw
         xr/TZ4hb1aOM4lAl/AWdBpFJVhch/lmCdSSnh3hdfMR4MxVaHPqFqh6wO4wenhpVArXa
         1MUVLA6ovwf1/1++gGli0n8KtdR5gyjE7jt2VeUIgCqTsEoVJ6tMr2WWbj5hunUmKG0r
         F3BBETsqJgi7dqXSkIbNesPNK54tQdsAF7gsT+dX/bkQcyusTl9ap0jCOLHMCY2GL91E
         qGAA==
X-Gm-Message-State: AOAM532UWsh1SqS+PBiz/94b2d0QOF9lQvQ/+bhDMenR4cU+QWLAewxB
        aN4AsoRBm8sTI93OaM3MiBk=
X-Google-Smtp-Source: ABdhPJyMlRzN6CqTCfXWY8T1ss4MS9wwNhu1bmJ0xGkO+sRHLhAhEBA9wHjVy8Q0kgH/DWZ5Y85DcA==
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr16076951ejb.493.1599377064196;
        Sun, 06 Sep 2020 00:24:24 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a5sm2709217edl.6.2020.09.06.00.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 00:24:22 -0700 (PDT)
Date:   Sun, 6 Sep 2020 09:24:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] Warn on orphan section placement
Message-ID: <20200906072419.GA886844@gmail.com>
References: <20200902025347.2504702-1-keescook@chromium.org>
 <CAKwvOd=r8X1UeBRgYMcjUoQX_nbOEbXCQYGX6n7kMnJhGXis=Q@mail.gmail.com>
 <20200904055825.GA2779622@gmail.com>
 <202009041117.5EAC7C242@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009041117.5EAC7C242@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> On Fri, Sep 04, 2020 at 07:58:25AM +0200, Ingo Molnar wrote:
> > 
> > * Nick Desaulniers <ndesaulniers@google.com> wrote:
> > 
> > > On Tue, Sep 1, 2020 at 7:53 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > Hi Ingo,
> > > >
> > > > The ever-shortening series. ;) Here is "v7", which is just the remaining
> > > > Makefile changes to enable orphan section warnings, now updated to
> > > > include ld-option calls.
> > > >
> > > > Thanks for getting this all into -tip!
> > > 
> > > For the series,
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > > 
> > > As the recent ppc vdso boogaloo exposed, what about the vdsos?
> > > * arch/x86/entry/vdso/Makefile
> > > * arch/arm/vdso/Makefile
> > > * arch/arm64/kernel/vdso/Makefile
> > > * arch/arm64/kernel/vdso32/Makefile
> > 
> > Kees, will these patches DTRT for the vDSO builds? I will be unable to test 
> > these patches on that old system until tomorrow the earliest.
> 
> I would like to see VDSO done next, but it's entirely separate from
> this series. This series only touches the core kernel build (i.e. via the
> interactions with scripts/link-vmlinux.sh) or the boot stubs. So there
> is no impact on VDSO linking.

Great!

I also double checked that things still build fine with ancient LD.

> > I'm keeping these latest changes in WIP.core/build for now.
> 
> They should be safe to land in -next, which is important so we can shake
> out any other sneaky sections that all our existing testing hasn't
> found. :)

OK, cool - I've graduated them over into tip:core/build. :-)

Thanks,

	Ingo
