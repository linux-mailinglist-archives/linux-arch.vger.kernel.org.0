Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D12308E4E
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhA2UUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhA2UUh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:20:37 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABBFC061573
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 12:19:57 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y205so6929481pfc.5
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 12:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8T48UJksYBBzMUWKPVavtIXowDuSQOy7SfNWHvVKVo=;
        b=rNZQoLZgqE0y69Li1l9Ns6pAG71/9Vpr2jQBKDj+iVJrGNZ66h2BkLJSEKvrHUcucT
         FYVnSnxHWQfGdMlFn4O5eNNc3pIW+YDU27bs1bD0JUmy1yh+ekBWPtAdyRIuiK9aYtUs
         r3SDaxrzKlFYOaaa/vwTAHvAtZznSxRSAFPXyzE5SyfOzDEdCsMTIwmlTfGYO9nx1LwQ
         3gFOCsTL3yLPWD+Eb0Ik7w7f/RtHe6vuODnrOuwpaWVZjQkJ6CoDoogdQ1Rn2kz8oqXI
         8e5IDV378RXcG8fMb0dGjkOhH5q0y3oo2FnihqLxOXivb4qTVOL7EPLOTBjCsiVMiTgd
         nipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8T48UJksYBBzMUWKPVavtIXowDuSQOy7SfNWHvVKVo=;
        b=EZkS5wLuq7df09s7YPb2IdTow+4+PbeFqwrL7xw4fS4v/UN6Eh+JZrAQojrFSlDQwg
         FOOfScsqyvHBQQ32tsfXHAcjEDg2YeYRZH63FTe2jEpOG2w6HZTLNBKtSql9dCXkOjUc
         S4c+siLtcWi2l/CystcAYrhPsfd5/Ejh8+769RsbRdScEAKMR2w4nITf45pOfT/5hOUC
         0hZakI4cg0ZXArCdkzne+uIvWNvi/QJQcrtKaTQ4XeumK04JbdpncZMPAbsXEeXlZ+8r
         Kndz9xV5fJ3Se5YxXp08ZJMy6RyAwqe+X4jcH8B7N1l5YufPSAZ9UkaQPOWCnidy17+h
         otcw==
X-Gm-Message-State: AOAM532BlFPAHtOjiqOmCm9Z1oBZr0fd2xX7Odu/hy11Ll1sYfVRfvCk
        L0mBxBnvwC/rAnR7sDjFB/ygj/aUC1HF5UPP7DbYOw==
X-Google-Smtp-Source: ABdhPJzk9uAolkT0GWDwaqqf6YweF1/GefIY4S7uJ8EEG8DUTy0XUtDIpr3G5bEf8kPY4/kBIS/YwV18CM/2+ruvBpk=
X-Received: by 2002:a63:9044:: with SMTP id a65mr111512pge.381.1611951596804;
 Fri, 29 Jan 2021 12:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-2-ndesaulniers@google.com> <20210129201712.GQ4020736@tucnak>
In-Reply-To: <20210129201712.GQ4020736@tucnak>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 12:19:46 -0800
Message-ID: <CAKwvOdkqcWOn6G7U6v37kc6gxZ=xbiZ1JtCd4XyCggMe=0v8iQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Kbuild: make DWARF version a choice
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 12:17 PM Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Fri, Jan 29, 2021 at 11:43:17AM -0800, Nick Desaulniers wrote:
> > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
> > explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
> > way that's forward compatible with existing configs, and makes adding
> > future versions more straightforward.
> >
> > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Suggested-by: Fangrui Song <maskray@google.com>
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  Makefile          |  6 +++---
> >  lib/Kconfig.debug | 21 ++++++++++++++++-----
> >  2 files changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 95ab9856f357..20141cd9319e 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -830,9 +830,9 @@ ifneq ($(LLVM_IAS),1)
> >  KBUILD_AFLAGS        += -Wa,-gdwarf-2
> >  endif
> >
> > -ifdef CONFIG_DEBUG_INFO_DWARF4
> > -DEBUG_CFLAGS += -gdwarf-4
> > -endif
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > +DEBUG_CFLAGS += -gdwarf-$(dwarf-version-y)
>
> Why do you make DWARF2 the default?  That seems a big step back from what
> the Makefile used to do before, where it defaulted to whatever DWARF version
> the compiler defaulted to?
> E.g. GCC 4.8 up to 10 defaults to -gdwarf-4 and GCC 11 will default to
> -gdwarf-5.
> DWARF2 is more than 27 years old standard, DWARF3 15 years old,
> DWARF4 over 10 years old and DWARF5 almost 4 years old...
> It is true that some tools aren't DWARF5 ready at this point, but with GCC
> defaulting to that it will change quickly, but at least DWARF4 support has
> been around for years.

I agree with you; I also do not want to change the existing defaults
in this series. That is a separate issue to address.

-- 
Thanks,
~Nick Desaulniers
