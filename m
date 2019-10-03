Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E14CACB8
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 19:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfJCR15 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Oct 2019 13:27:57 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:31723 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfJCR1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 13:27:55 -0400
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-03.nifty.com with ESMTP id x93HOMtO024256;
        Fri, 4 Oct 2019 02:24:22 +0900
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x93HODVW006126;
        Fri, 4 Oct 2019 02:24:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x93HODVW006126
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570123454;
        bh=LJ8ChLvuFkxOnRaAfzcwPHpVO6iA3brJ5hpU1BX1eNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJoEtvR8gerE47Ilqm+9qHWrT5ejo7mmyCPWUxRwjrQvhDoKpmFyNhYPZB4P/3lQn
         m488NTZCmfDrSSxvZNiBb4vzFF6bfUzr8wWSvzqs6bipD4/fBJJN6aRgVAL+k7ASSn
         +GsIyXeenTGPRExtiYn25nAM5HOkCRpBUW/qksdN3Mj2p0pGQ5G2gU+aOnUp/Cj4Ux
         xxFHclgj2gvSgXwDfv4le3HKJm6T7xR6cGQt4SD4Jz7wUIugAB3BPkYNcNyxJ3jTg9
         lmGKs4KldhJ3f1ziivjjmo+VDN5TZEfwPFd2BYBKf/OfFUss37s7QKJA6ZjbndzKXI
         fZIWQl7F8eHkA==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id u31so1184450uah.0;
        Thu, 03 Oct 2019 10:24:13 -0700 (PDT)
X-Gm-Message-State: APjAAAX39GdNDrAv1m1XPuAjZBhuYpCZNBh0URvJFTXpMAWwUGBeQboo
        KNtb5DGQHQ8q4Gkv0Cpk9AYJ1vD1aM29Qr5UmXU=
X-Google-Smtp-Source: APXvYqxcbafJe04SN1qeT5pWEmiFMIsMMij9Z6/1CaqUF5SYJfUPY3akBZRbK+HKr3EEke1jiD5zOefK+INWk5Gr9hA=
X-Received: by 2002:a9f:21f6:: with SMTP id 109mr3156310uac.109.1570123452512;
 Thu, 03 Oct 2019 10:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
 <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com> <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
In-Reply-To: <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 4 Oct 2019 02:23:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATSoOD0g=Aarui6Y26E_YB035NsaPpHxqtBNyw0K0UXVw@mail.gmail.com>
Message-ID: <CAK7LNATSoOD0g=Aarui6Y26E_YB035NsaPpHxqtBNyw0K0UXVw@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 4, 2019 at 2:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 2, 2019 at 7:11 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Macrofying the 'inline' is a horrid mistake that makes incorrect code work.
> > It would eternally prevent people from writing portable, correct code.
> > Please do not encourage to hide problems.
>
> Honestly, if the alternative to hiding problems is "use a macro", then
> I'd rather hide the problems and just make "inline" means "inline".
>
> If "inline" means "it's just a hint, use macros", then inline is useless.

For clarification,
I am not saying "use macros" at all.


I just want to annotate __always_inline for the case
"2. code that if not inlined is somehow not correct."



> If "inline" means "using this means that there are known compiler
> bugs, but we don't know where they trigger", then inline is _worse_
> than useless.
>
> I do not see the big advantage of letting the compiler say "yeah, I'm
> not going to do that, Dave".
>
> And I see a *huge* disadvantage when people are ignoring compiler
> bugs, and are saying "use a macro". Seriously.


Again, not saying "use a macro".



>
> Right now we see the obvious compiler bugs that cause build breakages.
> How many non-obvious compiler bugs do we have? And how sure are you
> that our code is "correct" after fixing a couple of obvious cases?
>
> As to "portable", nobody cares. We're a kernel. We aren't portable,
> and never were.
>
> If this is purely about the fact that x86 is different from other
> architectures, then let's remove the "compiler can do stupid things"
> option on x86 too. It was never clear that it was a huge advantage.
>
>                Linus



-- 
Best Regards
Masahiro Yamada
