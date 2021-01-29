Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A3308EE7
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhA2U6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbhA2U6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:58:13 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E60C06174A
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 12:57:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v19so7457103pgj.12
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 12:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+KMZZPkYrf5pIZgpahKbDaW5WeKXpZb6/M/9IMIgPI=;
        b=YBeGa0TNfWKOAatmKVgE1R03aJoq8o7J78BB/JsQbdwVvIZZWw925PEA1Pahy6DXmP
         vZURKN7a6QdKZOQy6V5w9/PzIan3CDkn36PdZi7PjO9Y5pkEP/F72yaEczao4YkCMdmS
         swa3grBP1yJhVkervL8gug5wQwOQPXLkWAC9bKDVZb/tnh211x7LdZut9BZ6WzLsamC2
         snTgzHLv5mCKOKAr2dkuxcJk0ykfTDZY55bkaFYRveBUOi9LS0eSkNTlrOrPdD1pFNVG
         oXmE7Y50Zxzh5rUmsyQ+pX1GmEgIbd5+PUiwsI9wiIGGAzXfzzqxi/mHEqIDMroVmeEn
         bLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+KMZZPkYrf5pIZgpahKbDaW5WeKXpZb6/M/9IMIgPI=;
        b=RR1KPBcssMB+IISvuQwxaD+yP7DwiDtxgvZIsbQ2O+k54O0ORBX1ZBqaZoYAYRxwbH
         mKTgLvod3I81C/dqxBSvwYMseVKF7NYcjgTZuvEd+LacJFS0rVEfBIJJ9gD/ScIOBTvZ
         Dtow3R6OwCrPTUBrezmluXS/7Z7YvwyUajq/QL7OHF26n7v6OvlhWQQWcbi5V0ViP2/L
         XdMLUxqmWLI4eEnoBV/zacD8KWpvThxqTdPKN4QjLIz+66NFYNQx0v14XunrUDFu31h7
         wXsK93TVEGVCLlUNeRbY/MCwbkOdWDLGbn3VKtFZAJITodWk2bJvHux2dSO/HbnMuI7x
         al7w==
X-Gm-Message-State: AOAM531BZx4cKsaH4A/mbkQnTIXXEczsEVtAUop+5wvS4pjw6kMN4eSM
        31iwmRjYWgu8qvQX6IMXk49JdVGAojXvrAAs5WOJvA==
X-Google-Smtp-Source: ABdhPJxzSzU/x8IRy4B0bmVj+vWK6CyVTQ6jzfU6zpNYmTDmQfpIavwyyYSkSrKFyKuPO6OdqBpebsRCpoCs0VA5yq0=
X-Received: by 2002:a65:4201:: with SMTP id c1mr6366899pgq.10.1611953851665;
 Fri, 29 Jan 2021 12:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-2-ndesaulniers@google.com> <20210129201712.GQ4020736@tucnak>
 <CAKwvOdkqcWOn6G7U6v37kc6gxZ=xbiZ1JtCd4XyCggMe=0v8iQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkqcWOn6G7U6v37kc6gxZ=xbiZ1JtCd4XyCggMe=0v8iQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 12:57:20 -0800
Message-ID: <CAKwvOdk0zxewEOaFuqK0aSMz3vKNzDOgmez=-Dae4+bodsSg5w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Kbuild: make DWARF version a choice
To:     Jakub Jelinek <jakub@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
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
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 12:19 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 29, 2021 at 12:17 PM Jakub Jelinek <jakub@redhat.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 11:43:17AM -0800, Nick Desaulniers wrote:
> > > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
> > > explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
> > > way that's forward compatible with existing configs, and makes adding
> > > future versions more straightforward.
> > >
> > > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Suggested-by: Fangrui Song <maskray@google.com>
> > > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  Makefile          |  6 +++---
> > >  lib/Kconfig.debug | 21 ++++++++++++++++-----
> > >  2 files changed, 19 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 95ab9856f357..20141cd9319e 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -830,9 +830,9 @@ ifneq ($(LLVM_IAS),1)
> > >  KBUILD_AFLAGS        += -Wa,-gdwarf-2
> > >  endif
> > >
> > > -ifdef CONFIG_DEBUG_INFO_DWARF4
> > > -DEBUG_CFLAGS += -gdwarf-4
> > > -endif
> > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > +DEBUG_CFLAGS += -gdwarf-$(dwarf-version-y)
> >
> > Why do you make DWARF2 the default?  That seems a big step back from what
> > the Makefile used to do before, where it defaulted to whatever DWARF version
> > the compiler defaulted to?
> > E.g. GCC 4.8 up to 10 defaults to -gdwarf-4 and GCC 11 will default to
> > -gdwarf-5.
> > DWARF2 is more than 27 years old standard, DWARF3 15 years old,
> > DWARF4 over 10 years old and DWARF5 almost 4 years old...
> > It is true that some tools aren't DWARF5 ready at this point, but with GCC
> > defaulting to that it will change quickly, but at least DWARF4 support has
> > been around for years.
>
> I agree with you; I also do not want to change the existing defaults
> in this series. That is a separate issue to address.

Thinking more about this over lunch...

I agree that DWARF v2 is quite old and I don't have a concrete reason
why the Linux kernel should continue to support it in 2021.

I agree that this patch takes away the compiler vendor's choice as to
what the implicit default choice is for dwarf version for the kernel.
(We, the Linux kernel, do so already for implicit default -std=gnuc*
as well).

I would not mind making this commit more explicit along the lines of:
"""
If you previously had not explicitly opted into
CONFIG_DEBUG_INFO_DWARF4, you will be opted in to
CONFIG_DEBUG_INFO_DWARF2 rather than the compiler's implicit default
(which changes over time).
"""
If you would rather see dwarf4 be the explicit default, that can be
done before or after this patch series, but to avoid further
"rope-a-dope" over getting DWARFv5 enabled, I suggest waiting until
after.

If Masahiro or Arvind (or whoever) feel differently about preserving
the previous "don't care" behavior related to DWARF version for
developers who had previously not opted in to
CONFIG_DEBUG_INFO_DWARF4, I can drop this patch, and resend v7 of
0002/0002 simply adding CONFIG_DEBUG_INFO_DWARF5 and making that and
CONFIG_DEBUG_INFO_DWARF4 depend on ! each other (I think).  But I'm
going to suggest we follow the Zen of Python: explicit is better than
implicit.  Supporting "I choose not to choose (my dwarf version)"
doesn't seem worthwhile to me, but could be convinced otherwise.
-- 
Thanks,
~Nick Desaulniers
