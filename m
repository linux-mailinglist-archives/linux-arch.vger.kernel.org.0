Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD4660F1
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2019 22:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfGKUze (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Jul 2019 16:55:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39043 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfGKUze (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 16:55:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id w190so4790318qkc.6;
        Thu, 11 Jul 2019 13:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkUbgSgUpCwj2ldYWoCFso4Iwo3JgBB3YyrLSeP+omU=;
        b=DUfo4uyqN1fv3EBEUcJTNj1w1y4JHX605pmOQZgRtHBvEKoXKZ9QFIHgIxnL08VTos
         wDrRSD9wQ7vL/t5CmVl6AYoml6zzy0WwgfAhvFkKTacnbl6nugt2/R1qNI90pCFUBJMh
         R0cvuO409KifiHGb12c4rWHbdWsiFOXqXkKv1+Yzjj/ik5h9z73aiEaveiaP4o7t+BMe
         dMqaMX7OapRwbmGcOZeQwbNGVQ7C+guNT0VNVpm+OxhNOG8etmXY/Nd1dBHqDVx8k5dq
         kvTSE2tWDf3wJYPACE6v7HoWvoiQAXTT8Ug1xUTSTpE41/naElBjTkdnrrfPrm6m9Xkd
         TBxg==
X-Gm-Message-State: APjAAAV756IYOdSEL3oHRr/H39GjiWbdrEh570WyiBBgCy30yYrSfkYa
        ObKMl5+jCcwRYHLbYgrmkSWfi/JA5uZNVBJ0rO8=
X-Google-Smtp-Source: APXvYqwQU5LP7lDrmvENc8aGoi4MJ9DUgGa6g4gLLDo+V/u6iJpXHHHv1e+jDggnBJ3vpelagEiDSMznJ+7Vli7iWvE=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr3532512qkb.286.1562878533166;
 Thu, 11 Jul 2019 13:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190710130206.1670830-1-arnd@arndb.de> <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
 <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com> <CAKwvOdkubvsRCnJKCaesB=PF=DgXfsBzwzR8kyE9NzWPU8Gehg@mail.gmail.com>
In-Reply-To: <CAKwvOdkubvsRCnJKCaesB=PF=DgXfsBzwzR8kyE9NzWPU8Gehg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Jul 2019 22:55:16 +0200
Message-ID: <CAK8P3a3TfQnQsXzmktedsKaY7Tihue_PbLhLoD1z1jZBMTxWMg@mail.gmail.com>
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 11, 2019 at 7:14 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, Jul 11, 2019 at 5:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > clang does not like an inline assembly with a "=q" contraint for
> > a 64-bit output:
>
> Seems like starting in GCC 7, GCC may not like it either:
> https://godbolt.org/z/UyBUfh
> it simply warns then proceeds with code gen.  Another difference may
> come from when GCC vs Clang perform dead code elimination (DCE) vs
> semantic analysis.

Right, I also had the idea to work around it with a set of
__builtin_choos_expr()
instead of the switch()/case but did not complete that patch as the percpu
code is rather complex and this would touch lots of code.

       Arnd
