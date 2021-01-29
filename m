Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8812B308EFF
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhA2VGu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbhA2VGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 16:06:48 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6202C0613D6
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 13:06:07 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o16so7493632pgg.5
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 13:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnOtPGCrnLbOPAzZu8d1fRX/n06p6RDZZdjSy9Y6a3A=;
        b=OB/msvX2vSHixwSy0vhw9dmLvr1kLoG2MammDQhMcQt4kaemfXLZbve53KZO/uuvm6
         PulOWwEjZ/e/c6MA0CSewMDyrY0y0bONOIO+9nM/1XDuQevzaawvU67RWTadKGmeQCa6
         gpG18Y6dSJcD1tEFs/iVRF7oc8FagqzgLPbb4YTGZ7ZAa3j+LqRcTW5mDfBxRhIGFUxE
         GaUl0B1amcvckuKh6rVTYp1MlQs74t3hmS2xPywpQvOlMdBY9Ww43qQbMnC1+hAGIZLZ
         pT1BVNdWmi+qqUR7Itpo9u9lfNHF84EHTJ8K+t/EfAZFGkOghtybN9i3aubx804wBGt3
         IM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnOtPGCrnLbOPAzZu8d1fRX/n06p6RDZZdjSy9Y6a3A=;
        b=r7kuGJn7R6rihzNHyIreI6rOomFd27KS1GI75vMtep+ylxMzE91NHNf3ipq22Rt598
         B0A18aNVaaPs+JsBGTU8x58rlxLOQbDf9nPbW9qh+hJ/EdcWC3DxCNh0qBFbQiy/CLUE
         CnDoNajo1TvWW8Uo6u+c7hN62R2f6+mp13SfRTmj8nDVLWagx1I5jl3sG5aA3XzElPAV
         P73fBw4H/fcT0BujzQW50gSMnIWkGs9eIimhiJwXjHj9oL0M+fm16vfDqVGcgmRE97SP
         8NoaShutcxVnfNfNGoH4SQhdi79zuaJgSfHvPNp6/AT+jIqAH7ru1Z5H34vdb1Ph7tmM
         EX1Q==
X-Gm-Message-State: AOAM530IuVXopjciz7QLyfNqFfomH5uC+uy0nH1Bx12oUVlLMR+NXdrz
        7X8k57mGAP+GP6q5M9Dn+m7NQToHRPj4BF+DrLOCjA==
X-Google-Smtp-Source: ABdhPJz1PIBYkFiyjJTUHtgS9vTX5K2X+1oYvQjhyuCAAqgSjmaaWtvoq39YuxjfgalN4RiVsciyM4l5l7GKxIez3BI=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr6189245pfy.15.1611954367137; Fri, 29
 Jan 2021 13:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com> <20210129205702.GS4020736@tucnak>
In-Reply-To: <20210129205702.GS4020736@tucnak>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 13:05:56 -0800
Message-ID: <CAKwvOdmuSaf28dOdP8Yo6+RyiviMNKcq8JY=-qgbwjbPVwHmLw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
To:     Jakub Jelinek <jakub@redhat.com>, Nick Clifton <nickc@redhat.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 12:57 PM Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Fri, Jan 29, 2021 at 12:48:11PM -0800, Nick Desaulniers wrote:
> > > Should this be...?
> > >
> > > KBUILD_AFLAGS += -Wa,-gdwarf-5
> >
> > No; under the set of conditions Clang is compiling .c to .S with DWARF
> > v5 assembler directives. GAS will choke unless told -gdwarf-5 via
> > -Wa,-gdwarf-5 for .c source files, hence it is a C flag, not an A
>
> Wasn't that fixed in GAS?
> https://sourceware.org/bugzilla/show_bug.cgi?id=27195

```
diff --git a/Makefile b/Makefile
index bed8b3b180b8..de616e584706 100644
--- a/Makefile
+++ b/Makefile
@@ -835,17 +835,6 @@ dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)

-# If using clang without the integrated assembler, we need to explicitly tell
-# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
-# detect whether the version of GAS supports DWARF v5.
-ifdef CONFIG_CC_IS_CLANG
-ifneq ($(LLVM_IAS),1)
-ifeq ($(dwarf-version-y),5)
-DEBUG_CFLAGS   += -Wa,-gdwarf-5
-endif
-endif
-endif
-
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS   += $(call cc-option, -femit-struct-debug-baseonly) \
                   $(call cc-option,-fno-var-tracking)
```

$ make LLVM=1 -j72 defconfig
$ ./scripts/config -e DEBUG_INFO -e DEBUG_INFO_DWARF5
$ make LLVM=1 -j72
...
/tmp/init-d50d89.s: Assembler messages:
/tmp/init-d50d89.s:10: Error: file number less than one
/tmp/init-d50d89.s:11: Error: junk at end of line, first unrecognized
character is `m'

which is https://sourceware.org/bugzilla/show_bug.cgi?id=25611.

$ as --version | head -n1
GNU assembler (GNU Binutils for Debian) 2.35.1

Maybe GAS should not need to be told -gdwarf-5 to parse these?  Then
we would not need to pass -Wa,-gdwarf-5 via clang with
-no-integrated-as.
-- 
Thanks,
~Nick Desaulniers
