Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C339C96A1
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 04:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfJCCLH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 22:11:07 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:48087 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfJCCLG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2019 22:11:06 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x932AlhR006363;
        Thu, 3 Oct 2019 11:10:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x932AlhR006363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570068648;
        bh=nkhw/a1oO0nPQOF4FHctSBWATyaUekhzHUNLh8TfmdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U9Oi20ce/mJfbr+vphEd72H8PgoTVD9Fw38AS044QGcxorUEKgusj76nWtoQN+Mvx
         Q0WkDIpdbuBWBK/ofkFggvSOl9/z8zsZyqN2cWF0ArHgOqDepSuR7KpRi/2bqOUUjW
         m1OrML5IM/r54+hYlTxg7+wJqtEZA+4V3mlz2yZyUYymVk1gG1cbtXFIMb5CegbnsJ
         3bNqNTR1J9egjTheAiaxfWOYjyj/MW/bZaGvSdjvehH47uM2uoRhgpMOY3ow/U/l/a
         SmcJxKVvbTMLs/AHgKxQ2d7070t8r51T8z3aTbBbi9IunZDYvxdDB7yVVe1zkU3XcL
         DXxNi39SNJYRg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id m22so603854vsl.9;
        Wed, 02 Oct 2019 19:10:48 -0700 (PDT)
X-Gm-Message-State: APjAAAVTGHHYlBvtoIfIN3n4WamG7PI4pmYPIECnEr/XwhgPSaSe40g4
        hSlXWlPyt2uPKi2AtxVjn8rkxOrieHr+MDH2mJE=
X-Google-Smtp-Source: APXvYqwhStUT9XoBxKv1GG3lSyu6FtZbM6kKxm6u1LXlJXJeaStZRhpChAJ3SpGfaP4xJZUvm3NWPnHGp4CHsjr+4Xc=
X-Received: by 2002:a67:1e87:: with SMTP id e129mr3884016vse.179.1570068647121;
 Wed, 02 Oct 2019 19:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com> <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Oct 2019 11:10:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
Message-ID: <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
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

On Thu, Oct 3, 2019 at 5:46 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 2, 2019 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > >
> > > Then use the C preprocessor to force the inlining.  I'm sorry it's not
> > > as pretty as static inline functions.
> >
> > Which makes us lose the baby^H^H^H^Htype checking performed
> > on function parameters, requiring to add more ugly checks.
>
> I'm 100% agreed on this.
>
> If the inline change is being pushed by people who say "you should
> have used macros instead if you wanted inlining", then I will just
> revert that stupid commit that is causing problems.
>
> No, the preprocessor is not the answer.
>
> That said, code that relies on inlining for _correctness_ should use
> "__always_inline" and possibly even have a comment about why.
>
> But I am considering just undoing commit 9012d011660e ("compiler:
> allow all arches to enable CONFIG_OPTIMIZE_INLINING") entirely.

No, please do not.

Macrofying the 'inline' is a horrid mistake that makes incorrect code work.
It would eternally prevent people from writing portable, correct code.
Please do not encourage to hide problems.


> The
> advantages are questionable, and when the advantages are balanced
> against actual regressions and the arguments are "use macros", that
> just shows how badly thought out this was.
>
>                 Linus



-- 
Best Regards
Masahiro Yamada
