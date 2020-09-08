Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED32621B1
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgIHVIC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 17:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgIHVH4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 17:07:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F22EC061757
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 14:07:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so330393pfg.2
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wm1YZJP5IHcZuymW2XEKoD0pUveQe7CoNm7r9bi/W1k=;
        b=a7GjBHohAGSJ4PnMwooOuv5ACDnGE0C26cMuDHZo5+wvUiXv0xO8J2AUkV5JHb2FOP
         ldjjgjbqwFWCWq9Zw5W0LDK9PPh+xyYdY8hA2Wm743DJYsOoYFFThh9hJZBSdXRUCfFd
         cvOqVo7OMhMtAPX/2sp6Mz72uNjnDoYA9p//eZpjffoGYl/RG2xg8YzDi7C2OcRP5Eml
         H1IcomixFJ6jH0HEQSWDpcx4jVmZUZKnlbr7q8YvW0FORqPMCHn3losN4VKggIRBYbX6
         PtF8QxirnS7Espc0n9SSG2KH2rmz6/CIoNi2jCnfqCKNNgM5GJGJNXvMfd4DY5Oii+fR
         uTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wm1YZJP5IHcZuymW2XEKoD0pUveQe7CoNm7r9bi/W1k=;
        b=qTLTiUh/fFBh6C/WhfpDKjQ839pNav64ixHK/aJELr1qxqmfs1U1jbiDLTdGJnnGeI
         5QayqvdsSr7C/C0E1UyUvQC16LIZCsRJxXVemOqK+jfdeXd8kRLkVCpIxCUiRT/WAC/5
         s2rRtVACvD8q6YLN1/14yHWXR8Mvh1gUlJGE9ndELCnEmv0weCE7m9MeOWBuX0lwiYKb
         tS6ZqrVjuCEYkeJqN8/lQMh/vjwjpOQhCMDgJj6vg1WlFgfneEhMFNyHn/jAr7pxWp6E
         +rUzFDTlVqvZDpjuDW71jggIsY7mZxOkzeMf6atg2JWZAP4P0kj2LDlQt4mD2Uk9DjOY
         4Y7Q==
X-Gm-Message-State: AOAM530+1ZmuDBrY6ddLy0y4Wb43OMODDWpeUm3N/Bitl1KqEQB+HnKG
        okj85zdg1gIolL7ifbbWLLZLEg==
X-Google-Smtp-Source: ABdhPJz6/bLvTnKJTjhD++qFUgr8FkqyQitq4tmijOh19Mp/UXDDqyF/xILPr1db4moWKg5d5d7hXA==
X-Received: by 2002:a17:902:c38a:: with SMTP id g10mr511116plg.23.1599599275319;
        Tue, 08 Sep 2020 14:07:55 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id m188sm323916pfd.56.2020.09.08.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:07:54 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:07:48 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2 13/28] kbuild: lto: merge module sections
Message-ID: <20200908210748.GB1060586@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-14-samitolvanen@google.com>
 <CAK7LNARnh-7a8Lq-y2u72cnk2uxSuWxjaZ8Y-JHCYu5gwt7Ekg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARnh-7a8Lq-y2u72cnk2uxSuWxjaZ8Y-JHCYu5gwt7Ekg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 08, 2020 at 12:25:54AM +0900, Masahiro Yamada wrote:
> On Fri, Sep 4, 2020 at 5:31 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > LLD always splits sections with LTO, which increases module sizes. This
> > change adds a linker script that merges the split sections in the final
> > module.
> >
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  Makefile               |  2 ++
> >  scripts/module-lto.lds | 26 ++++++++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >  create mode 100644 scripts/module-lto.lds
> >
> > diff --git a/Makefile b/Makefile
> > index c69e07bd506a..bb82a4323f1d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -921,6 +921,8 @@ CC_FLAGS_LTO_CLANG += -fvisibility=default
> >  # Limit inlining across translation units to reduce binary size
> >  LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
> >  KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
> > +
> > +KBUILD_LDS_MODULE += $(srctree)/scripts/module-lto.lds
> >  endif
> >
> >  ifdef CONFIG_LTO
> > diff --git a/scripts/module-lto.lds b/scripts/module-lto.lds
> > new file mode 100644
> > index 000000000000..cbb11dc3639a
> > --- /dev/null
> > +++ b/scripts/module-lto.lds
> > @@ -0,0 +1,26 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
> > + * -ffunction-sections, which increases the size of the final module.
> > + * Merge the split sections in the final binary.
> > + */
> > +SECTIONS {
> > +       __patchable_function_entries : { *(__patchable_function_entries) }
> > +
> > +       .bss : {
> > +               *(.bss .bss.[0-9a-zA-Z_]*)
> > +               *(.bss..L*)
> > +       }
> > +
> > +       .data : {
> > +               *(.data .data.[0-9a-zA-Z_]*)
> > +               *(.data..L*)
> > +       }
> > +
> > +       .rodata : {
> > +               *(.rodata .rodata.[0-9a-zA-Z_]*)
> > +               *(.rodata..L*)
> > +       }
> > +
> > +       .text : { *(.text .text.[0-9a-zA-Z_]*) }
> > +}
> > --
> > 2.28.0.402.g5ffc5be6b7-goog
> >
> 
> 
> After I apply https://patchwork.kernel.org/patch/11757323/,
> is it possible to do like this ?
> 
> 
> #ifdef CONFIG_LTO
> SECTIONS {
>      ...
> };
> #endif
> 
> in scripts/module.lds.S

Yes, that should work. I'll change this in v3 after your change is
applied.

Sami
