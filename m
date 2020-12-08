Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9972D3055
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 17:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgLHQ5M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 11:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgLHQ5L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 11:57:11 -0500
X-Gm-Message-State: AOAM5323WPJTvM6NiM3KhThKK95sHjoVMCgGZdMcCNRYtI/+c087nc5T
        s9An5cgP2lkMPkJiSDZJmgXGzc22w4nzHNT4j3w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607446591;
        bh=B1Ufsz/HjvgeN7kz3QDMw7S3GkByLm0NCuUVzAQn1Nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rKCUm2Ck4ZHiGtV3Faw/xe/XwRxizs0Y1E8mPa2BPGo+iAQuGAACvB1lE17EvxzKg
         sdJSkWu621PR6JmuUkZx6X8EHHlXlnOsdG0rDzeO7AVEOFzr87aOubmE2c7gzWt3aK
         eNJx8xYeGVKWGGDahCTTMnavuRRk2BKfmjTZ/05LYvPKiXmaLW2bTmwopmaLfdSvc0
         23Vwwr+wxXb8d34MTPd7sKBTslRqgRAlCPdSJcelZFlAj4eFwgUY33mKDeCsiWNeEd
         r4UMsDp/eQJwFwFv7h6XQMlireK6JR/Smu8K5arF+Eg7NP6qod4JmTEKKPd5LR/6hD
         7j/SxXQTXGltQ==
X-Google-Smtp-Source: ABdhPJxgNl1Gj/l80SMEy+MnjbFlb4NpqPf4LKadCXveKp8gHoY+X2lTRnRws8sedD5yQTo7/pGCxoCJogqbCbMdTLQ=
X-Received: by 2002:a9d:be1:: with SMTP id 88mr17705895oth.210.1607446590334;
 Tue, 08 Dec 2020 08:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
 <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
 <CAK8P3a0AyciKoHzrgtaLxP9boo8WqZCe8YfPBzGPQ14PW_2KgQ@mail.gmail.com> <CABCJKudbCD3s0RcSVzbnn4MV=DadKOxOxar3jfiPWucX4JGxCg@mail.gmail.com>
In-Reply-To: <CABCJKudbCD3s0RcSVzbnn4MV=DadKOxOxar3jfiPWucX4JGxCg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 8 Dec 2020 17:56:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a32HwzZYDK3i68fY0JLGCj18RH1iDMq70OZpTrsopyCcw@mail.gmail.com>
Message-ID: <CAK8P3a32HwzZYDK3i68fY0JLGCj18RH1iDMq70OZpTrsopyCcw@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 8, 2020 at 5:53 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> > A small update here: I see this behavior with every single module
> > build, including 'tinyconfig' with one module enabled, and 'defconfig'.
>
> The .o file here is a thin archive of the bitcode files for the
> module. We compile .lto.o from that before modpost, because we need an
> ELF binary to process, and then reuse the .lto.o file when linking the
> final module.
>
> At no point should we link the .o file again, especially not with
> .lto.o, because that would clearly cause every symbol to be
> duplicated, so I'm not sure what goes wrong here. Here's the relevant
> part of scripts/Makefile.modfinal:
>
> ifdef CONFIG_LTO_CLANG
> # With CONFIG_LTO_CLANG, reuse the object file we compiled for modpost to
> # avoid a second slow LTO link
> prelink-ext := .lto
> ...
> $(modules): %.ko: %$(prelink-ext).o %.mod.o scripts/module.lds FORCE
>         +$(call if_changed,ld_ko_o)

Ah, it's probably a local problem now, as I had a merge conflict against
linux-next in this Makefile and I must have resolved the conflict incorrectly.

        Arnd
