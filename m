Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6FF308ECC
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhA2UuR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhA2UtD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:49:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116A0C061574
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 12:48:23 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b17so5957167plz.6
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WItJXETBomgA8w/2ueBIV7kTCBbgxOWkatab0l8rCFY=;
        b=FWGTJwlE42dDQ0SnnZkdoS6s6/HTp5h+AvF467f8GVYxX7NWFdv/2Qt148CE4vgNUy
         rzDp3VDnl4WtcgvJ8KGX0lT2ATT5hsSYlX9JmduMTpd6cSfskjOCJm1yY7/XRePGjMaQ
         F7Txz6uN45eJMfz7dEGIrP7uAb4YnHAuHnCEaCe2jb1ctNZRtJBKqh07AsFPAM4psU2U
         bPrfPftUUgpP1XjqBHOWZhQ9fXLqq+3DL+svX8W8V0fenqBhXmXrsKuLGXlNiYMQRJp0
         S/VCN+tdHaoRcgnWeu7wp3UAObg+iZj4MEMn5yX+bueQEcEaTigD8XoVuI330F5ZGqRA
         To/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WItJXETBomgA8w/2ueBIV7kTCBbgxOWkatab0l8rCFY=;
        b=FoqO9/d4rWWTje7bPAE9qjkK3BwixoHl+4qLC3UnfOEdA6jFEgaX3lJEtBieiHoChd
         80e9ABJDvI5kUUYO43aDSNehXF/xXe3zKjL+19cOkyxpUFTjOG6ArC2ia2RhP9lwXT15
         4CDDsgzGnvlN9trFOKmi7+cDVxmWpI8eUWnmXnS8a5WfaYqN13PYldjiTbh6snGb5shK
         qdRg/2nvfHmUQOR+wKHwOTC+yFAi8iv3y2/McDrT7hFLR7NTqlvHkaJ3aItYhWBDpVLY
         LoW3X6C8kxUTe+MvfIQ8q0JHTGdwAoio6lK/NM88J7QZL99OtF4KxyMdPdVP9XLEi/Tj
         RALg==
X-Gm-Message-State: AOAM530wVTX33F6U3TuGjH9e1aWwfKg71mj9rbDvE2GROiZrk1JGprx8
        k8Fgvh2bY1z/AmbaFSZQGKOruwKx/2q90m6/ccV0CQ==
X-Google-Smtp-Source: ABdhPJz/oEHQsvQq9kakf4eeXpxhMWl7oHN8vlSh0hSRJLA7aPhAd1jhFz+wnfVmU7P43aXOoobGtid/MkCrbS821Jk=
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr6157190pjn.25.1611953302456;
 Fri, 29 Jan 2021 12:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
In-Reply-To: <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 12:48:11 -0800
Message-ID: <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
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

On Fri, Jan 29, 2021 at 12:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 8:43 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > diff --git a/Makefile b/Makefile
> > index 20141cd9319e..bed8b3b180b8 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -832,8 +832,20 @@ endif
> >
> >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> >
> > +# If using clang without the integrated assembler, we need to explicitly tell
> > +# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
> > +# detect whether the version of GAS supports DWARF v5.
> > +ifdef CONFIG_CC_IS_CLANG
> > +ifneq ($(LLVM_IAS),1)
> > +ifeq ($(dwarf-version-y),5)
> > +DEBUG_CFLAGS   += -Wa,-gdwarf-5
>
> I noticed double "-g -gdwarf-5 -g -gdwarf-5" (a different issue) and
> that's why I looked again into the top-level Makefile.

That's...unexpected.  I don't see where that could be coming from.
Can you tell me please what is the precise command line invocation of
make and which source file you observed this on so that I can
reproduce?

> Should this be...?
>
> KBUILD_AFLAGS += -Wa,-gdwarf-5

No; under the set of conditions Clang is compiling .c to .S with DWARF
v5 assembler directives. GAS will choke unless told -gdwarf-5 via
-Wa,-gdwarf-5 for .c source files, hence it is a C flag, not an A
flag. A flags are for .S assembler sources, not .c sources.
-- 
Thanks,
~Nick Desaulniers
