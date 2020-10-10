Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE2289C97
	for <lists+linux-arch@lfdr.de>; Sat, 10 Oct 2020 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgJJAK7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 20:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgJJABF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 20:01:05 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFDAC0613D8
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 17:01:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 33so11097873edq.13
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyEG6unrPY9TR7tF+FNQAaLApT1kctBGIfqP3l5IFb4=;
        b=mijmHtCMvGsgDu4uYd7w3AkGuavHKsRtISq1sPYHXYFaJw1WU+TYM2fX64XYscUKFv
         oU1cjxRYTJM1zp/QWqADJjTuB9hPhK+ZKhKINQnaiff6eqCzhX5w5wrxbRlGrJ0vyWiv
         ro3O+Z6DBIysL9dvjFawfl9YpJ7VnqXVeFq0auogXHWgzG/yIY2Ex8Vg0F1RLU4QxqSG
         bPLvghG+BsOIiRJ7zUxm1IgTps9IY/HH1VRZFA09lds3Gl17NZfWxvoZiUPcmFwlV7So
         V3Y3SV5Dt+Y35HFON8xSJwLyPjVkAmtWcAvVa4XffcGawnjsCdKwV9RsaQRB1eOPndHI
         e4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyEG6unrPY9TR7tF+FNQAaLApT1kctBGIfqP3l5IFb4=;
        b=bDCsz8Byvmvi/u4bWX1dglMoq7PXEywbuexaWTt7hBL3Uir5uGdeNEMR2VkYhplyb9
         hJ99qvg7uwThuU+byYC81ecNUP8W0iyssmku3h4u3S8RQCDMf1BQsFRrS9+JYyHbHwPY
         4Qxj8hseaHHNGrM/HbwPAd7jqoua0kW64FxZkCiLnyHuO4KiNPQ5fr0bjoJQXSDEMDxu
         ULRntYmZtLVyjr4KU8ToM+JJHcARM9HJDmJumnBoZPIjdfuzbDUIARbhVu6G0ZWJvU7L
         5d7R2S2nUo+/KlsC9PXZF3U8Ej2ISZjHKrU52TLf1R/mjuVpEh7D4xnpRkLALI7wloXN
         zcQw==
X-Gm-Message-State: AOAM531aKhlRu5D4RRWhDZQOcQcKN3nl+QoCQWixqP3BmgrK78lGKWtL
        7qz+QGassF7fADOIH5f2+IzM1oI9pDR3w1E2G9ZPnw==
X-Google-Smtp-Source: ABdhPJygCrm7pkL/BYEq335cylOsmwx8yyljt1uWu6UwT8l62xqSHabdTtXkuhnBI7dZHTHKXqo8112Hls6msX6/ovk=
X-Received: by 2002:a50:dec9:: with SMTP id d9mr1852468edl.145.1602288062227;
 Fri, 09 Oct 2020 17:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
 <20201009153512.1546446a@gandalf.local.home> <20201009210548.GB1448445@google.com>
 <20201009193759.13043836@oasis.local.home>
In-Reply-To: <20201009193759.13043836@oasis.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 9 Oct 2020 17:00:51 -0700
Message-ID: <CABCJKueGW5UeH1++ES7ZRDcAnZ6hV-tFVwt6usjcZUnR95YQPQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/29] Add support for Clang LTO
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 9, 2020 at 4:38 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 9 Oct 2020 14:05:48 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > Ah yes, X86_DECODER_SELFTEST seems to be broken in tip/master. If you
> > prefer, I have these patches on top of mainline here:
> >
> >   https://github.com/samitolvanen/linux/tree/clang-lto
> >
> > Testing your config with LTO on this tree, it does build and boot for
> > me, although I saw a couple of new objtool warnings, and with LLVM=1,
> > one warning from llvm-objdump.
>
> Thanks, I disabled X86_DECODER_SELFTEST and it now builds.
>
> I forced the objdump mcount logic with the below patch, which produces:
>
> CONFIG_FTRACE_MCOUNT_RECORD=y
> CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=y
>
> But I don't see the __mcount_loc sections being created.
>
> I applied patches 1 - 6.

Patch 6 is missing the part where we actually pass --mcount to
objtool, it's in patch 11 ("kbuild: lto: postpone objtool"). I'll fix
this in v6. In the meanwhile, please apply patches 1-11 to test the
objtool change. Do you have any thoughts about the approach otherwise?

Sami
