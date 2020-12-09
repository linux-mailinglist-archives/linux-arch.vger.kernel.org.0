Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581B72D3E38
	for <lists+linux-arch@lfdr.de>; Wed,  9 Dec 2020 10:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgLIJIH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Dec 2020 04:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgLIJIG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Dec 2020 04:08:06 -0500
X-Gm-Message-State: AOAM530ZsrA9/HV2DjgowpAhL63/YKhv1cpqkFMFoorvLErNIuzL0PMy
        K9uG8docXIrYzLqGY0EfpKbcUvToPUL1fOaVtJ0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607504846;
        bh=TwxFShO4SPchdzTy7qkGiE4yd1wyqCRwfixyq9lhU7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NCiGOimI+QFWkGlUZtp54uaMVti9IldC3/6tybv4aAngGynp5QeKYtDn1Ea3viG6k
         PHX9S56SX/HXW1fK8ZZPDRO9lfAqFCkkwCspMmK4HLO1QobtGZ5EyAk89vzjh5SjYW
         Jq+5FoSKSVewsuicy5V8hjtOrYy9DBikIUbvEgJQw6qYx9sgVDRQUY/zCFp1d4TBua
         +613pyJgYP/eaY+At6PuGkeuo87wBR32bvjtoW3pYFP29c05B7kjAHoci1oedOldtN
         APm58L0Fsb+80x7Uy6lX7NzNPMFQwWi5WJ4Cm+uNh6KtiftBjCvyV8ZlzR0+ZlQj5o
         EWaXpF140L0UA==
X-Google-Smtp-Source: ABdhPJxKs07aufMIXKvOvasJWP2Wd8H56Ov3ybUuW6F/PQlQb2wWFCBMjJs8uH8yTwkOwJT1cWw+0emvCRgVQRHX1pw=
X-Received: by 2002:aca:44d:: with SMTP id 74mr1079063oie.4.1607504845146;
 Wed, 09 Dec 2020 01:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
 <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
 <CABCJKueCHo2RYfx_A21m+=d1gQLR9QsOOxCsHFeicCqyHkb-Kg@mail.gmail.com>
 <CAK8P3a1Xfpt7QLkvxjtXKcgzcWkS8g9bmxD687+rqjTafTzKrg@mail.gmail.com>
 <CAK8P3a3O65m6Us=YvCP3QA+0kqAeEqfi-DLOJa+JYmBqs8-JcA@mail.gmail.com> <CAFP8O3L35sj117VJeE3pUPE2H4++z2g48Gfd-8Ca=CUtP1LVWw@mail.gmail.com>
In-Reply-To: <CAFP8O3L35sj117VJeE3pUPE2H4++z2g48Gfd-8Ca=CUtP1LVWw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 9 Dec 2020 10:07:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1aCiDta9_4-M6tstR+eX53ZaO65wdmoTXdZo2bBQmAWg@mail.gmail.com>
Message-ID: <CAK8P3a1aCiDta9_4-M6tstR+eX53ZaO65wdmoTXdZo2bBQmAWg@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 9, 2020 at 6:23 AM 'F=C4=81ng-ru=C3=AC S=C3=B2ng' via Clang Bui=
lt Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On Tue, Dec 8, 2020 at 1:02 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Dec 8, 2020 at 9:59 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > Attaching the config for "ld.lld: error: Never resolved function from
> > >   blockaddress (Producer: 'LLVM12.0.0' Reader: 'LLVM 12.0.0')"
> >
> > And here is a new one: "ld.lld: error: assignment to symbol
> > init_pg_end does not converge"
>
> This is interesting. I changed the symbol assignment to a separate
> loop in https://reviews.llvm.org/D66279
> Does raising the limit help? Sometimes the kernel linker script can be
> rewritten to be more friendly to the linker...

If that requires rebuilding lld, testing it is beyond what I can help with
right now. Hopefully someone can reproduce it with my .config.

       Arnd
