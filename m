Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004D030EAFA
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 04:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhBDDc4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 22:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhBDDc4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 22:32:56 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72EFC0613ED
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 19:32:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g3so1024361plp.2
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 19:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gQHcS0Zulo4R/LyMo03/XNTnPCP/zAgLWckCskRb6ro=;
        b=vO7GGOQk7GWz57rv1m7I4tgRQZA/DtNc+hNWa6hL/eY/TBFRf+kB+IhSRiEmJ9nfMV
         96IIAZ1phNLDpmO0+/WM0C1pY6eblPyruKU6MpIzbi93C6nD/meXczT5y2qWdvogoI8H
         SRQ9eH1y40ODrZJBAddWBtP1BQ9jj6wQ9eyVfRdw3NXmp3LS8OLx/kOtOFvCw6SSA3eP
         cPQafOJD8qp0qAVKVtC6Ver9nAOZFi0dkYqW9kr+Kd6JP9Enx2pEHm5m4cRyyvqzBvoe
         GPG/wsfF0MsWeAkT0wIDTPBiKL8W87cx1cgrOuFYL9fZrAhLUY7m7IdwYeYOQDJdQwyb
         rIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gQHcS0Zulo4R/LyMo03/XNTnPCP/zAgLWckCskRb6ro=;
        b=Srjgx1C0cjYhylMr2/g1HlwOvJcq7/pzMMsGe+oF/XnsCe73fKV8jVZ4FWzeEJfIrV
         YDSxGiTx0hjihJC6ue7uNdjZpaiVlJf9aJNQuVCAqBv6qIInctju1MvNERE2VVi8/Jwy
         uKq3QJK1mIfGT6MFn2FJqNb974T/Ue1CZdaWa0T3G3+VL0nl3Dm06POHJ3UKcqMC1vNz
         Wr6z/kq8RJyqP6HOmwUIPlOEo31LBUf7xGOf0wYJIs7mUF0EdqwYi+OHQu0ZMfDquhVZ
         +jv1oS5oi5a5BUtmbZ6J+qfU6whUmLKoZdiwV6njxnpS/8V/9g6I+752t8J0LzfI0rjt
         XMhw==
X-Gm-Message-State: AOAM532Qv3mb9Mp/9Zyj1rnr1ATAqLDrllkQG2jxCzrhiFQfxiek5ev6
        X/nFzTPbSfY0e1Q0ibDCFXse3Q==
X-Google-Smtp-Source: ABdhPJyY/gyck+kKXk9IdTSfor9ljygAlz6hdpSd+uLcgV2hml00FEQyzNZY9sV9+qYnATce8eQ0Jg==
X-Received: by 2002:a17:90a:206:: with SMTP id c6mr6442140pjc.50.1612409535272;
        Wed, 03 Feb 2021 19:32:15 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:4d44:7b6c:ce63:a46c])
        by smtp.gmail.com with ESMTPSA id x21sm4296908pgi.75.2021.02.03.19.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:32:14 -0800 (PST)
Date:   Wed, 3 Feb 2021 19:32:10 -0800
From:   Fangrui Song <maskray@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
Message-ID: <20210204033210.ie2a5zuumtlb4jth@google.com>
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com>
 <20210130015222.GC2709570@localhost>
 <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-02-04, Masahiro Yamada wrote:
>On Sat, Jan 30, 2021 at 10:52 AM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
>> > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
>> > the default. Does so in a way that's forward compatible with existing
>> > configs, and makes adding future versions more straightforward.
>> >
>> > GCC since ~4.8 has defaulted to this DWARF version implicitly.
>> >
>> > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
>> > Suggested-by: Fangrui Song <maskray@google.com>
>> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
>> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
>> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>>
>> One comment below:
>>
>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>>
>> > ---
>> >  Makefile          |  5 ++---
>> >  lib/Kconfig.debug | 16 +++++++++++-----
>> >  2 files changed, 13 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index 95ab9856f357..d2b4980807e0 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
>> >  KBUILD_AFLAGS        += -Wa,-gdwarf-2
>>
>> It is probably worth a comment somewhere that assembly files will still
>> have DWARF v2.
>
>I agree.
>Please noting the reason will be helpful.
>
>Could you summarize Jakub's comment in short?
>https://patchwork.kernel.org/project/linux-kbuild/patch/20201022012106.1875129-1-ndesaulniers@google.com/#23727667
>
>
>
>
>
>
>One more question.
>
>
>Can we remove -g option like follows?
>
>
> ifdef CONFIG_DEBUG_INFO_SPLIT
> DEBUG_CFLAGS   += -gsplit-dwarf
>-else
>-DEBUG_CFLAGS   += -g
> endif

GCC 11/Clang 12 -gsplit-dwarf no longer imply -g2
(https://reviews.llvm.org/D80391). May be worth checking whether
-gsplit-dwarf is used without a debug info enabling option.

>
>
>
>
>In the current mainline code,
>-g is the only debug option
>if CONFIG_DEBUG_INFO_DWARF4 is disabled.
>
>
>The GCC manual says:
>https://gcc.gnu.org/onlinedocs/gcc-10.2.0/gcc/Debugging-Options.html#Debugging-Options
>
>
>-g
>
>    Produce debugging information in the operating system’s
>    native format (stabs, COFF, XCOFF, or DWARF).
>    GDB can work with this debugging information.
>
>
>Of course, we expect the -g option will produce
>the debug info in the DWARF format.
>
>
>
>
>
>With this patch set applied, it is very explicit.
>
>Only the format type, but also the version.
>
>The compiler will be given either
>-gdwarf-4 or -gdwarf-5,
>making the -g option redundant, I think.

-gdwarf-N does imply -g2 but personally I'd not suggest remove it if it
already exists. The non-orthogonality is the reason Clang has
-fdebug-default-version (https://reviews.llvm.org/D69822).

>
>
>
>
>
>
>
>
>>
>> >  endif
>> >
>> > -ifdef CONFIG_DEBUG_INFO_DWARF4
>> > -DEBUG_CFLAGS += -gdwarf-4
>> > -endif
>> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
>> > +DEBUG_CFLAGS += -gdwarf-$(dwarf-version-y)
>> >
>> >  ifdef CONFIG_DEBUG_INFO_REDUCED
>> >  DEBUG_CFLAGS += $(call cc-option, -femit-struct-debug-baseonly) \
>> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> > index e906ea906cb7..94c1a7ed6306 100644
>> > --- a/lib/Kconfig.debug
>> > +++ b/lib/Kconfig.debug
>> > @@ -256,13 +256,19 @@ config DEBUG_INFO_SPLIT
>> >         to know about the .dwo files and include them.
>> >         Incompatible with older versions of ccache.
>> >
>> > +choice
>> > +     prompt "DWARF version"
>> > +     help
>> > +       Which version of DWARF debug info to emit.
>> > +
>> >  config DEBUG_INFO_DWARF4
>> > -     bool "Generate dwarf4 debuginfo"
>> > +     bool "Generate DWARF Version 4 debuginfo"
>> >       help
>> > -       Generate dwarf4 debug info. This requires recent versions
>> > -       of gcc and gdb. It makes the debug information larger.
>> > -       But it significantly improves the success of resolving
>> > -       variables in gdb on optimized code.
>> > +       Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
>> > +       It makes the debug information larger, but it significantly
>> > +       improves the success of resolving variables in gdb on optimized code.
>> > +
>> > +endchoice # "DWARF version"
>> >
>> >  config DEBUG_INFO_BTF
>> >       bool "Generate BTF typeinfo"
>> > --
>> > 2.30.0.365.g02bc693789-goog
>> >
>
>
>
>-- 
>Best Regards
>Masahiro Yamada
