Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573EB2FE0F6
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 05:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbhAUDys (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 22:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbhAUCfw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 21:35:52 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8230EC061575;
        Wed, 20 Jan 2021 18:35:12 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e22so1153062iog.6;
        Wed, 20 Jan 2021 18:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9Y9DUxx2myNtOWxI8K8XFn16xIEClBVha4uIv+X/2uY=;
        b=G9zQ7C/dYMxCwX6DVkBH3ICgyCY4aGmrIFquM4790TChdjhRqne0p9WhLI4S47G5OB
         3FzeRHSYojNH+F5GIAzkJQx4pfSYPvYyfUO29pQP+tKxI5TBIKjz8ep3qlBaekXmi69j
         90alngIigKBTBT80wJg2a3CSo+hhrrZOIglAIFq5qEcOiNmNO+70qysaj1mnOLkiJpK0
         3Zz7Kd6mJHUHC8LfzK8gZ/9AsARZP5FUsxtKELbbhnQXbd9YoS7m74b9kZUwafkmz+SO
         3MWpZddeBq6ciIwx1CycV+3v9Oz6qyguw5Kerpd3ct7ej99+UYHNaijM0XJ1+NQnr5DG
         fXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9Y9DUxx2myNtOWxI8K8XFn16xIEClBVha4uIv+X/2uY=;
        b=ev857kMl4ar69G7EZDIBtjvEplnfsCzCjwIiolSaCnVxEMmlOoHQzia36UVvjLRzss
         GUubY/37hVFTFIew2C9n+EHpW4Q3TZ334s8SlPknGs7EuFd3ANKa2IMu2y9CrMxlEr8n
         FDf7U31Uxx0bnONiHDIzMkxHEtg+x6cEQO2HWbFnSaUSiJgEJKmE8SKMvcWOayyu2Nl/
         Udoz/Xcp7daqgtnYcdIV1SAOG5tpcW1QXJ9SI+uBs6hRVLkrfryLT4XhGQEJYQAwg8+y
         Ee3Yss2aMgQgbm42xhefICr9XHbiJMRaGkTDwA9Ee9L4eeKQNHtwrHUVvkOXMMyZLB3k
         oZyQ==
X-Gm-Message-State: AOAM5309wtG69H8JvBE8V27IqAkN7uWV8g4+O+ijs3ZjTbMiFLl9EcY2
        MsD8SNMNbkh4adz21gjsE5CI0xFXcpqhej/xSRrmKCQ1/PHwEA==
X-Google-Smtp-Source: ABdhPJybd2r+DInglVk4ksQjnieup8BbWJTKCidmKe5EfE3N1syRZJU8VeDL8JZY3HBjB4NkHv2KTHhKrdLOU8S/cnM=
X-Received: by 2002:a05:6602:2f93:: with SMTP id u19mr8996301iow.110.1611196511863;
 Wed, 20 Jan 2021 18:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-3-ndesaulniers@google.com> <20210120204025.GA548985@ubuntu-m3-large-x86>
In-Reply-To: <20210120204025.GA548985@ubuntu-m3-large-x86>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 21 Jan 2021 03:35:00 +0100
Message-ID: <CA+icZUXycvAE4uVDcaVQfeiSCaHCxP8ZBUMccHxXES1E7RNjRw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] Kbuild: make DWARF version a choice
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
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

On Wed, Jan 20, 2021 at 9:40 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Jan 15, 2021 at 01:06:15PM -0800, Nick Desaulniers wrote:
> > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
> > explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
> > way that's forward compatible with existing configs, and makes adding
> > future versions more straightforward.
> >
> > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Suggested-by: Fangrui Song <maskray@google.com>
> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  Makefile          | 13 ++++++-------
> >  lib/Kconfig.debug | 21 ++++++++++++++++-----
> >  2 files changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index d49c3f39ceb4..4eb3bf7ee974 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -826,13 +826,12 @@ else
> >  DEBUG_CFLAGS += -g
> >  endif
> >
> > -ifneq ($(LLVM_IAS),1)
> > -KBUILD_AFLAGS        += -Wa,-gdwarf-2
> > -endif
>
> Aren't you regressing this with this patch? Why is the hunk from 3/3
> that adds
>
> ifdef CONFIG_CC_IS_CLANG
> ifneq ($(LLVM_IAS),1)
>
> not in this patch?
>

Nice catch Nathan.

Just FYI:

The patch...

"kbuild: Remove $(cc-option,-gdwarf-4) dependency from DEBUG_INFO_DWARF4"

... has now entered kbuild-next.
( This patch is included in this patch-series. )

So should we point to this one and add a comment?
Thinking of a next version of this DWARF5 support patch-series.

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?h=kbuild&id=3f4d8ce271c7082be75bacbcbd2048aa78ce2b44

> > -ifdef CONFIG_DEBUG_INFO_DWARF4
> > -DEBUG_CFLAGS += -gdwarf-4
> > -endif
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > +DEBUG_CFLAGS += -gdwarf-$(dwarf-version-y)
> > +# Binutils 2.35+ required for -gdwarf-4+ support.
> > +dwarf-aflag  := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> > +KBUILD_AFLAGS        += $(dwarf-aflag)
> >
> >  ifdef CONFIG_DEBUG_INFO_REDUCED
> >  DEBUG_CFLAGS += $(call cc-option, -femit-struct-debug-baseonly) \
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index dd7d8d35b2a5..e80770fac4f0 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -256,13 +256,24 @@ config DEBUG_INFO_SPLIT
> >         to know about the .dwo files and include them.
> >         Incompatible with older versions of ccache.
> >
> > +choice
> > +     prompt "DWARF version"
> > +     help
> > +       Which version of DWARF debug info to emit.
> > +
> > +config DEBUG_INFO_DWARF2
> > +     bool "Generate DWARF Version 2 debuginfo"
> > +     help
> > +       Generate DWARF v2 debug info.
> > +
> >  config DEBUG_INFO_DWARF4
> > -     bool "Generate dwarf4 debuginfo"
> > +     bool "Generate DWARF Version 4 debuginfo"
> >       help
> > -       Generate dwarf4 debug info. This requires recent versions
> > -       of gcc and gdb. It makes the debug information larger.
> > -       But it significantly improves the success of resolving
> > -       variables in gdb on optimized code.
> > +       Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> > +       It makes the debug information larger, but it significantly
> > +       improves the success of resolving variables in gdb on optimized code.
> > +
> > +endchoice # "DWARF version"
> >
> >  config DEBUG_INFO_BTF
> >       bool "Generate BTF typeinfo"
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
