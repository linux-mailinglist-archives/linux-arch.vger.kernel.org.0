Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECDD4A57E3
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiBAHiK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 02:38:10 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:43801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiBAHiJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 02:38:09 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mk0a0-1mURRH1SY4-00kRXu; Tue, 01 Feb 2022 08:38:07 +0100
Received: by mail-oi1-f169.google.com with SMTP id v67so31649622oie.9;
        Mon, 31 Jan 2022 23:38:06 -0800 (PST)
X-Gm-Message-State: AOAM532N9ip1dCa9ckyzxDsUhmIm9KBYNMWYqmjOas1B3C5kzDKGHmlg
        wZ+HI7LjqzoRur71jfwoBAlpDLF4c46yYImO2W4=
X-Google-Smtp-Source: ABdhPJwoAJXauxOlZ1TxRJZjpbgTXhT/BjZ6VY3RAg/96c46TCKIEYOphf3tKWPRy+ZIq5Ssv3EeqyOOpFvjD7WxsWE=
X-Received: by 2002:aca:2b16:: with SMTP id i22mr389475oik.128.1643701085749;
 Mon, 31 Jan 2022 23:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20220131225250.409564-1-ndesaulniers@google.com> <202201311550.31EF589B2@keescook>
In-Reply-To: <202201311550.31EF589B2@keescook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Feb 2022 08:37:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3-WqWUCps131vS1W9T6sN8yQ3GAaja8JP0GYCQjP68Qg@mail.gmail.com>
Message-ID: <CAK8P3a3-WqWUCps131vS1W9T6sN8yQ3GAaja8JP0GYCQjP68Qg@mail.gmail.com>
Subject: Re: [PATCH] docs/memory-barriers.txt: volatile is not a barrier() substitute
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Len Baker <len.baker@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Gmy/OLhhRhW8zXgYaS+K13GMv7b02GK61cdOOM+6a0V9RpMTBRD
 9AZf23HLzhtQNorolU+10ZvdPFllQLfhoASYc+LIDhid4oeCN8ZtIlX/Y/sDVK1ntnzBVOB
 DklZH71DY5yvshzSPsPgmh6p9SsaBupSLM52BdsClj6SFiuFYJWAIGgdh6vaAsr91guMuxK
 gPCJ6vD1ntRemqEbfnLFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DLjwZiIMbCI=:o7mkkKsFobMnUtaepxHD+S
 gaPs5kUQoIw4JQR7okiaEspEjxPX38TflIee5BdHC7wA0yP5ys131QpZJ4vX93uFP8ZAzDWah
 N03ZNmUpv4mewOe7vAr+ClRbmalcgK99hY5tf4M31dJkjmsD2MUq79r6TySUQnHkrOU1ZeZWu
 gzNSGVj2RBc66X8VkbjRNYAAmWsrUjzSZtUywWprwz0fxgeYowt6YyKct4rD/29Pu3Vnyb7ws
 sz3TYaCBtRMGictyhP9+BSsSJlJSdVU4xsOpT9WnHgWYABaTeoqXFG4+bLNbN7RUS25JuvTrb
 Dazubzl/dWUTJzNhL5uyy0thxc6Zs8Il2GrSGKe3F52pGViEE3duJj9UARByGWCpQe5plcZcS
 SN4ruQlGeT62iBvIMI8K6lK5BzgBmMqoo40Ms3v44X/1bnPOJ9W6QkQ97jSM0kkKqlpU3xMPY
 aqSzZ1Oqw2rd68Oev01F3A6mKndzwWGC0oJ/ve6wT09nsmuxku68s4/as/QWOGO1hHvGGEBln
 tz5kPQX0bCn6DPkWc4QLUZ7OMlaMHkWVGZwXvVP5SEnMk2bFgJLehlQC35zqUXEwn9+BQs4FR
 6XNaOW/AAAz3IyYCBQbPsmjaRtm6PZDb5wYDeKL/E6vNOBw7S9pg1gNdmTPJhIdjjNCeL9g+n
 qGgzu0vzN1PkFUlLksoeCnlmnkq8+6OgRYGqD0rSMZYlH99vJZCcHDgM0yASH2njET1/BHSRJ
 QQjdm1f5dpbptxjUkwKHOaA9B58tJRPJ22xqjC38NhgcWPWOFCWhmqP30pBuVXNQ7ySaQtHdZ
 LZvN2iF9OUTbb9yIHNUpcf6LfQwZACUQrpOVj1WYoo0mjArkfA=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 1, 2022 at 12:53 AM Kees Cook <keescook@chromium.org> wrote:

> > +
> > +According to `the GCC docs on inline asm
> > +https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile`_:
> > +
> > +  asm statements that have no output operands and asm goto statements,
> > +  are implicitly volatile.
>
> Does this mean "volatile" _is_ needed when there are operands, etc?

It depends on what you want to express. The idea here is to give a way to
gcc for optimizing out anything with an output, like x86 rdtsc() when the
result is not used, which is sensible. If there is no output, such as in
writel(), you don't need 'volatile' because gcc can assume that an
inline asm without outputs has side-effects already.

A case where you need to add volatile is for (void)readl(ADDR),
which is an operation that has an output as well as a side-effect.

          Arnd
