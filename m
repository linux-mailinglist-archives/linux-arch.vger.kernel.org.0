Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0BC30EC5B
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 07:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhBDGOR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 01:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhBDGOP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 01:14:15 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC28C061573
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 22:13:35 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e12so1204863pls.4
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 22:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncXEJ1dZpoFNtJ7RLMyE5p7WlT1xC95XJWCpTzmVYWE=;
        b=XPBT5TFm7JgmY9O9VISnJGEkGoPrAlzNb9PchDy7LZiduD7wP1ehIzarhoSUk0UvaB
         FBjNqlEb6tjBq25k4rdQHtYxcBNVHDAZ/Z0ETVd0tZ7xogpZ83BbQ3yG++6S/b/P2Vvu
         4RupnOrIdn4bf8yyktL2+fhZlIz/LNAG9m+TcEINqoCdyIkT91ZYgTO/I3tJcsF+Dr8f
         sX53Ujseq68ZclyDHO086NvofeGGmd7QI/bTQ3UoN7F15nLXDoj9+vCBn4YYlsYreoiQ
         GIOGSfavRdbmTty94m4EAlbV361SEPjuOVQkXQFEWB2yPHuQhLXLMzrNv96/GunrvQs9
         Il5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncXEJ1dZpoFNtJ7RLMyE5p7WlT1xC95XJWCpTzmVYWE=;
        b=XGosIM6IqUnfU0hp9FIVYhOTp3N8uj/bTxQNOEP0YQZJ2t7Dfj9GM3CJs9H5Pvrm/G
         dUGwQemOMa3yCkBQG61YVfBSNaCgcAS//4cD/SPod9TBJfyBj7F2VhPOPy71pKUxzqa1
         vLF0SO3zg568NJTTBKs2+rBgxX7RA+OOmpyzsJMbyTN0CD0kvRyO9HRHw18rZ8H83X+h
         veat3wUFBd5/0C2ps9KUBhZ9NrQDbqM08Ymu1msTF83FOzLW2hfJSz/csR23gFHshVmC
         i7OocHuK4AQmzh4fHrst+4Hxutl5gK0NJX03CHRn3CvjXno10xZxK2CtGUbHTGJ2CcKj
         b3gg==
X-Gm-Message-State: AOAM530MCsHnW0y3z1MxcQaAJq1dAKeomwWesV/DImBwoFogrUaOiiF9
        Q5rQTGUr9XnFUwqu2RSyLE1ZhWQNXXsj1k4UGkM6+Q==
X-Google-Smtp-Source: ABdhPJyKDThP0trUUIdsz6iIijzlmPEakH+sB7moIhqkBdUBvPAWclyV2e4vceezFD0v56p2N6y41FMPXMzREaczZYM=
X-Received: by 2002:a17:902:ed94:b029:de:8844:a650 with SMTP id
 e20-20020a170902ed94b02900de8844a650mr6808235plj.56.1612419214450; Wed, 03
 Feb 2021 22:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210130015222.GC2709570@localhost>
In-Reply-To: <20210130015222.GC2709570@localhost>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Feb 2021 22:13:22 -0800
Message-ID: <CAKwvOdkJMfhSBDNsUXbmgF970=766eJZF1E0=8QKCwsEAED1tQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 5:52 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> > the default. Does so in a way that's forward compatible with existing
> > configs, and makes adding future versions more straightforward.
> >
> > GCC since ~4.8 has defaulted to this DWARF version implicitly.
> >
> > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Suggested-by: Fangrui Song <maskray@google.com>
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> One comment below:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >  Makefile          |  5 ++---
> >  lib/Kconfig.debug | 16 +++++++++++-----
> >  2 files changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 95ab9856f357..d2b4980807e0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
> >  KBUILD_AFLAGS        += -Wa,-gdwarf-2
>
> It is probably worth a comment somewhere that assembly files will still
> have DWARF v2.

Such a comment should have gone on
commit b8a9092330da ("Kbuild: do not emit debug info for assembly with
LLVM_IAS=1")

It's also more complicated than "assembly files will still have DWARF
v4," due to the LLVM_IAS check.

Further, such a comment would be inappropriate for patch 1 of the
series, which simply changes a Kconfig option into a choice.  I will
add a note to the commit message of patch 2, and carry your reviewed
by tag.  Please nack v8 (which I plan to send imminently) if you
disagree.
-- 
Thanks,
~Nick Desaulniers
