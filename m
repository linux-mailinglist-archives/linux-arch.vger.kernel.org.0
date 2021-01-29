Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A994A308F80
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhA2Vds (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:33:48 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:41231 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhA2Vdk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 16:33:40 -0500
Received: by mail-qk1-f177.google.com with SMTP id n15so10221050qkh.8;
        Fri, 29 Jan 2021 13:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cv/H+UXVfiojhZIcXbfkk/ErDokGpMJ0LpJMoYEpdpA=;
        b=huVNdh3jcnf0KmkJ55zC+lEvxzqk+evPXJj0uifN5rEcLXg2IU+kN6nGGiS8lPzYZ/
         K2QcZL9ozrbEs0PyIsgrq4/rMA1zdKFfJIcxsNhUF5D61onWFFtYmXaD5TIPPGeZXpL4
         4lBPbtY03LqPk+/rzrrvFoD0i6QAivoVLIxTJLop4465Y0Zdp6X8B+SIr5KdqaHxM5T8
         frf9SZ3YEVPIDZ10shgMqzmvr6h8iWbZHNA0bAFegrR45N239L/rJ9yQkJ3lI8bgHs4c
         K3ZqcJy0mmyHcr16B/xi3QQuCjS/k0whJaqPVlZ1ts6z1hBTvLrg2bgt3TzYtwzDBY39
         oBmQ==
X-Gm-Message-State: AOAM5308Lr0xmZetzqMhmkPlQ4M/qp5JHby2NBDmo2WFvH77kSQLhJpt
        6ibD5X3I5JrUh+RS9BcQVs8=
X-Google-Smtp-Source: ABdhPJx38FOKkKrR/8bSQlb4ZqyvdC9V3/F3orMVsaN66OTF1wjQO8dpZFyVji5GNbdwQ0E1nF4RKw==
X-Received: by 2002:a37:cd5:: with SMTP id 204mr5672284qkm.410.1611955955712;
        Fri, 29 Jan 2021 13:32:35 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 22sm7068680qke.123.2021.01.29.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:32:34 -0800 (PST)
Date:   Fri, 29 Jan 2021 16:32:32 -0500
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v6 1/2] Kbuild: make DWARF version a choice
Message-ID: <YBR+8KLWnjnMfP6i@rani.riverdale.lan>
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-2-ndesaulniers@google.com>
 <20210129201712.GQ4020736@tucnak>
 <CAKwvOdkqcWOn6G7U6v37kc6gxZ=xbiZ1JtCd4XyCggMe=0v8iQ@mail.gmail.com>
 <CAKwvOdk0zxewEOaFuqK0aSMz3vKNzDOgmez=-Dae4+bodsSg5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdk0zxewEOaFuqK0aSMz3vKNzDOgmez=-Dae4+bodsSg5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 12:57:20PM -0800, Nick Desaulniers wrote:
> On Fri, Jan 29, 2021 at 12:19 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 12:17 PM Jakub Jelinek <jakub@redhat.com> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 11:43:17AM -0800, Nick Desaulniers wrote:
> > > > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
> > > > explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
> > > > way that's forward compatible with existing configs, and makes adding
> > > > future versions more straightforward.
> > > >
> > > > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Suggested-by: Fangrui Song <maskray@google.com>
> > > > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > > > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > ---
> > > >  Makefile          |  6 +++---
> > > >  lib/Kconfig.debug | 21 ++++++++++++++++-----
> > > >  2 files changed, 19 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 95ab9856f357..20141cd9319e 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -830,9 +830,9 @@ ifneq ($(LLVM_IAS),1)
> > > >  KBUILD_AFLAGS        += -Wa,-gdwarf-2
> > > >  endif
> > > >
> > > > -ifdef CONFIG_DEBUG_INFO_DWARF4
> > > > -DEBUG_CFLAGS += -gdwarf-4
> > > > -endif
> > > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > > +DEBUG_CFLAGS += -gdwarf-$(dwarf-version-y)
> > >
> > > Why do you make DWARF2 the default?  That seems a big step back from what
> > > the Makefile used to do before, where it defaulted to whatever DWARF version
> > > the compiler defaulted to?
> > > E.g. GCC 4.8 up to 10 defaults to -gdwarf-4 and GCC 11 will default to
> > > -gdwarf-5.
> > > DWARF2 is more than 27 years old standard, DWARF3 15 years old,
> > > DWARF4 over 10 years old and DWARF5 almost 4 years old...
> > > It is true that some tools aren't DWARF5 ready at this point, but with GCC
> > > defaulting to that it will change quickly, but at least DWARF4 support has
> > > been around for years.
> >
> > I agree with you; I also do not want to change the existing defaults
> > in this series. That is a separate issue to address.
> 
> Thinking more about this over lunch...
> 
> I agree that DWARF v2 is quite old and I don't have a concrete reason
> why the Linux kernel should continue to support it in 2021.
> 
> I agree that this patch takes away the compiler vendor's choice as to
> what the implicit default choice is for dwarf version for the kernel.
> (We, the Linux kernel, do so already for implicit default -std=gnuc*
> as well).
> 
> I would not mind making this commit more explicit along the lines of:
> """
> If you previously had not explicitly opted into
> CONFIG_DEBUG_INFO_DWARF4, you will be opted in to
> CONFIG_DEBUG_INFO_DWARF2 rather than the compiler's implicit default
> (which changes over time).
> """
> If you would rather see dwarf4 be the explicit default, that can be
> done before or after this patch series, but to avoid further
> "rope-a-dope" over getting DWARFv5 enabled, I suggest waiting until
> after.
> 
> If Masahiro or Arvind (or whoever) feel differently about preserving
> the previous "don't care" behavior related to DWARF version for
> developers who had previously not opted in to
> CONFIG_DEBUG_INFO_DWARF4, I can drop this patch, and resend v7 of
> 0002/0002 simply adding CONFIG_DEBUG_INFO_DWARF5 and making that and
> CONFIG_DEBUG_INFO_DWARF4 depend on ! each other (I think).  But I'm
> going to suggest we follow the Zen of Python: explicit is better than
> implicit.  Supporting "I choose not to choose (my dwarf version)"
> doesn't seem worthwhile to me, but could be convinced otherwise.
> -- 
> Thanks,
> ~Nick Desaulniers

Given what Jakub is saying, i.e. it was previously impossible to get
dwarf2 with gcc, and you get dwarf4 whether or not DEBUG_INFO_DWARF4 was
actually selected, we should make the default choice DEBUG_INFO_DWARF4
with the new menu to avoid surprising users. We should probably just
drop DWARF2 and make the menu in this patch have only DWARF4, and then
add DWARF5 as the second choice. The menu is still a good thing for
future-proofing even if it only has two options currently.

Thanks.
