Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B794104A7
	for <lists+linux-arch@lfdr.de>; Sat, 18 Sep 2021 09:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbhIRHSM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Sep 2021 03:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhIRHSL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2021 03:18:11 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F5C061574;
        Sat, 18 Sep 2021 00:16:48 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id z62so11567788vsz.9;
        Sat, 18 Sep 2021 00:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBMwTm9bQKnfYASrbxx38SJrYYT3hAkMfMk4IqojBdk=;
        b=IpXTrtRZVxWl72jTLq0wa/c4tc9tOSSLxN+yjX4AWDqHshiijA8g8EVb8tK3Lv5mF3
         JZnh7Bg3gFi8PyasFWX+rwW7/P0jJTpuZud2zI7A1AwWdypGMsYZa0K2VGjbvEJXBUmy
         YDLtohj1ynnBRankSL7P0hj+dHefLxMcblihv50JzDiWVAJTuWsWqLEurGglWsRu2IYI
         OIDlyt6a4dMfpLNxKsHzd9SASAEmrPdblfeXH6nwd4LFUFBNLgahycBP/3xGELSw0+B+
         tIFZQCE940ns8SA85OmA+DV9RAFiYKan05ETjBFEUsmz/BX7wcO8/j5nsMB9QjvY8vvt
         B6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBMwTm9bQKnfYASrbxx38SJrYYT3hAkMfMk4IqojBdk=;
        b=b+QKbFlIfIRnv3Nn7eW+5EXFDR1WPwRpXEl2i4oX1xWw4dR+ukLl7+ObALoeM4HRdn
         v/ryBrrJV4e+ijQ17J3/JPt9DgO/4yqk6dWIsaqSlvXtbMw81tJhS+q4yJ8kShns78mw
         Y+lEYb3bB/zih6D18lvFGK9yxfydAOJV68wP+zNVQNBKtkDRmJlp4VErw3fPAvSoGxHV
         dlX5ntrckCRNBZjui/9SjcwxlEVcKjKhdDbXmS6s/7Ns/5QFfgkhDQjcMgdK5mxyU42g
         XhKE8krd07+j52EClPy6rRVKykU92VdZdstId2wOZ16TLyIvnD/0C329M5UIIddWG3o/
         kYkA==
X-Gm-Message-State: AOAM530JCAIy2ZAtduMzbpeMazfM/qbzvVeoENx9WGnA4snRV+0qn1U9
        L/jfAc/3tEwlwXxiZaeO/Oipt9wqdRjtFacQkuE=
X-Google-Smtp-Source: ABdhPJxE9F778fqN7slVNSiTv3N3dxgOm35SMym19UNDMFj24FYdpmjAiQc83t25MwM8g3+uA+w6/3YvCdH8iuCOrKY=
X-Received: by 2002:a05:6102:2757:: with SMTP id p23mr311890vsu.61.1631949407304;
 Sat, 18 Sep 2021 00:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-18-chenhuacai@loongson.cn> <CAK8P3a0HfWmBgp6ZagVALDoeoJsJaU9h9tLKHM0-5GZGtnT-hg@mail.gmail.com>
In-Reply-To: <CAK8P3a0HfWmBgp6ZagVALDoeoJsJaU9h9tLKHM0-5GZGtnT-hg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 18 Sep 2021 15:16:35 +0800
Message-ID: <CAAhV-H5dAubLUrcfr2nQi3kjAcDJfQ+st_TGAac1mQ-suKuUHQ@mail.gmail.com>
Subject: Re: [PATCH V3 17/22] LoongArch: Add some library functions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Fri, Sep 17, 2021 at 4:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > diff --git a/arch/loongarch/lib/strncpy_user.S b/arch/loongarch/lib/strncpy_user.S
> > new file mode 100644
> > index 000000000000..b42d81045929
> > --- /dev/null
> > +++ b/arch/loongarch/lib/strncpy_user.S
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/errno.h>
> > +#include <asm/asm.h>
> > +#include <asm/asmmacro.h>
> > +#include <asm/export.h>
> > +#include <asm/regdef.h>
> > +
> > +#define _ASM_EXTABLE(from, to)                 \
> > +       .section __ex_table, "a";               \
> > +       PTR     from, to;                       \
> > +       .previous
> > +
> > +/*
> > + * long __strncpy_from_user(char *to, const char *from, long len)
> > + *
> > + * a0: to
> > + * a1: from
> > + * a2: len
> > + */
> > +SYM_FUNC_START(__strncpy_from_user)
> > +       move    a3, zero
> > +
>
> I just removed most custom __strncpy_from_user/__strnlen_user
> implementations from architectures, and I think you should remove
> these as well. Your current version probably does not work any more
> with v5.15-rc1, and it is neither efficient nor robust.
I'm very sorry for this. You have talked about these functions in V1,
and I do removed them in the Makefile, but kept the source files...

Huacai
>
>         Arnd
