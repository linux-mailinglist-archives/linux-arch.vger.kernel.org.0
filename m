Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456DE290F4A
	for <lists+linux-arch@lfdr.de>; Sat, 17 Oct 2020 07:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406783AbgJQFeT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Oct 2020 01:34:19 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:29575 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392694AbgJQFeT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Oct 2020 01:34:19 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2020 01:34:17 EDT
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-07.nifty.com with ESMTP id 09H1l3wP011554;
        Sat, 17 Oct 2020 10:47:03 +0900
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 09H1kmka028705;
        Sat, 17 Oct 2020 10:46:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 09H1kmka028705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1602899209;
        bh=/0ovXshOhxLJmlzp2NpX2ArKIwhaV5c9daLvgg85jsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0stKPxzpCuJojIl84Bap+GcFlN95iCk5b1y2Ur4dn5CdBNku5y5qT9INLgCiIwZbR
         u659+Dn0zDhJhfB00RQrtwl+GiV+V3Fc0z2w1nJQCnnCFIr3kdOXTCHnjUUdbmQWVX
         MeVRXjDPKXXlLt5HQpZqGtPC4zi5Bc0I69hTqKExGEOKVHgflFjMSqgfS95N/yRwdw
         3HSTGv73eD9p3poujLcVuwZTjCTUcUx/6XOHFj4eUTvk7kwCfYwPrPQ5RCZCsCKl8W
         ShFHdzRceMHi71f7Ynv4a6eTuTsHkRS66eSRjfdBS8bt/oD9kKSwq4sdlQLYtaEhMS
         sV4o2EHMMXyvQ==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id j8so2445957pjy.5;
        Fri, 16 Oct 2020 18:46:48 -0700 (PDT)
X-Gm-Message-State: AOAM53029u4e0L72SlQ7fFqcaf2+fYVaIh0XIsIEoWzXqjSYjbrKtj6v
        5we8vt/HB83sSqh91N2BiOn+zn7EMNVU79MNwYc=
X-Google-Smtp-Source: ABdhPJwnDvT6VOCCvby8Z+dRxKHlAcETSIANPUgxy4yeQxdCEUHUrDGlLwfVIqt5UgjHFKL6uGwJ8RIXqDyJ0U/afPU=
X-Received: by 2002:a17:90a:aa91:: with SMTP id l17mr6700984pjq.198.1602899207791;
 Fri, 16 Oct 2020 18:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-8-samitolvanen@google.com> <202010141541.E689442E@keescook>
In-Reply-To: <202010141541.E689442E@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 17 Oct 2020 10:46:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCaf2s94L1xYENYDYp07sTWxpnr4V_SKXfDFQKBB5drA@mail.gmail.com>
Message-ID: <CAK7LNASCaf2s94L1xYENYDYp07sTWxpnr4V_SKXfDFQKBB5drA@mail.gmail.com>
Subject: Re: [PATCH v6 07/25] treewide: remove DISABLE_LTO
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 15, 2020 at 7:43 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 12, 2020 at 05:31:45PM -0700, Sami Tolvanen wrote:
> > This change removes all instances of DISABLE_LTO from
> > Makefiles, as they are currently unused, and the preferred
> > method of disabling LTO is to filter out the flags instead.
> >
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Hi Masahiro,
>
> Since this is independent of anything else and could be seen as a
> general cleanup, can this patch be taken into your tree, just to
> separate it from the list of dependencies for this series?
>
> -Kees
>
> --
> Kees Cook



Yes, this is stale code because GCC LTO was not pulled.

Applied to linux-kbuild.

I added the following historical background.



Note added by Masahiro Yamada:
DISABLE_LTO was added as preparation for GCC LTO, but GCC LTO was
not pulled into the mainline. (https://lkml.org/lkml/2014/4/8/272)




-- 
Best Regards
Masahiro Yamada
