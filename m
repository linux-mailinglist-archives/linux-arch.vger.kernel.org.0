Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE94D4F3F
	for <lists+linux-arch@lfdr.de>; Sat, 12 Oct 2019 13:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfJLLNg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Oct 2019 07:13:36 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53079 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfJLLNg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Oct 2019 07:13:36 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x9CBDFgi027307;
        Sat, 12 Oct 2019 20:13:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x9CBDFgi027307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570878796;
        bh=QIQWbVFMywEGzrVFv7ncajs828mx8ZAypZawE3JRNnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wUiDd5ikCr1JT2Yxc8XHCJxQQ7iwviMZJG/IOTrYxVuuQgdsur+sx2xBB1eYo4rtM
         eCGR7bnd6kLscEH67zamCqWXt+fz9Je68JdOf2+hENU7TUExvoT0MAUDOVPtrURzy1
         XPV3jPwpXdocP6ipUYDc1c03IGGsTzouSN2ST4Hzn1QcZ1srv9uRu2rK3OrNvuJb0v
         03yTUSstvsDe/N0H/7l8aVQHpF+eJwbweZRrBVDQW7PlhC+d1zIr7vMJ+g+xixUHXr
         PnE+gRyY0wrQUOnIXmcaaBvjC7VNmt/D8wUq054V4+zVxB/lY2JVdHM2GV6epkxRHO
         OA47ecmgP6HIQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id z14so7882474vsz.13;
        Sat, 12 Oct 2019 04:13:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVEEZkfFUK/zsOLqK1PTDOkFKykKnadpV6/fHcCQo1QGZgdocPI
        hzWDpi2iTZDrnqqPpIaKC9A7heKaPrIFbqqFeWg=
X-Google-Smtp-Source: APXvYqyHih4e2WFxheL/lFIrBr+Hi15Wq9iIMdigECIIy1lpDBTMCXi9oA2x4W/bhPi3v/iXQqldXfzc3OYYnDPyYQM=
X-Received: by 2002:a67:ff86:: with SMTP id v6mr11732128vsq.181.1570878794590;
 Sat, 12 Oct 2019 04:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
 <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
 <20191003163606.iqzcxvghaw7hdqb5@willie-the-truck> <35643c7e-94e9-e410-543b-a7de17b59a32@gmx.net>
In-Reply-To: <35643c7e-94e9-e410-543b-a7de17b59a32@gmx.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 12 Oct 2019 20:12:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASgwA_Z-FeqrnB4Uyk3XShGVpgRHVL2FBbzJoU7ytJBxA@mail.gmail.com>
Message-ID: <CAK7LNASgwA_Z-FeqrnB4Uyk3XShGVpgRHVL2FBbzJoU7ytJBxA@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 12, 2019 at 7:21 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Hi,
>
> Am 03.10.19 um 18:36 schrieb Will Deacon:
> > On Wed, Oct 02, 2019 at 01:39:40PM -0700, Linus Torvalds wrote:
> >> On Wed, Oct 2, 2019 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>>> Then use the C preprocessor to force the inlining.  I'm sorry it's not
> >>>> as pretty as static inline functions.
> >>> Which makes us lose the baby^H^H^H^Htype checking performed
> >>> on function parameters, requiring to add more ugly checks.
> >> I'm 100% agreed on this.
> >>
> >> If the inline change is being pushed by people who say "you should
> >> have used macros instead if you wanted inlining", then I will just
> >> revert that stupid commit that is causing problems.
> >>
> >> No, the preprocessor is not the answer.
> >>
> >> That said, code that relies on inlining for _correctness_ should use
> >> "__always_inline" and possibly even have a comment about why.
> >>
> >> But I am considering just undoing commit 9012d011660e ("compiler:
> >> allow all arches to enable CONFIG_OPTIMIZE_INLINING") entirely. The
> >> advantages are questionable, and when the advantages are balanced
> >> against actual regressions and the arguments are "use macros", that
> >> just shows how badly thought out this was.
> > It's clear that opinions are divided on this issue, but you can add
> > an enthusiastic:
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > if you go ahead with the revert. I'm all for allowing the compiler to
> > make its own inlining decisions, but not when the potential for
> > miscompilation isn't fully understood and the proposed alternatives turn
> > the source into an unreadable mess. Perhaps we can do something different
> > for 5.5 (arch opt-in? clang only? invert the logic? work to move functions
> > over to __always_inline /before/ flipping the CONFIG option? ...?)
>
> what's the status on this?
>
> In need to prepare my pull requests for 5.5 and all recent kernelci
> targets (including linux-next) with bcm2835_defconfig are still broken.
>
> Stefan


Russell King already applied the fix-up patch.

https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8908/1

So, (I hope) the breakage of bcm2835 will be solved in mainline soon.





-- 
Best Regards
Masahiro Yamada
