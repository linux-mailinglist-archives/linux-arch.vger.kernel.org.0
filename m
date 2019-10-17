Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46809DA512
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 07:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390655AbfJQFV3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 01:21:29 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:52048 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbfJQFV3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 01:21:29 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x9H5LC01008669;
        Thu, 17 Oct 2019 14:21:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x9H5LC01008669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571289673;
        bh=FUz6mYMNfzQH4LKbt7ZIWdeQDoZUH5tR4M+NFCb3m7M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WB5263HZAkX/Dxgg+hP83hNOdFi3O0jU2yNKCIS8gUY3ZUc47nLPjXQpAQlqxH1dH
         0bXEIxzRJZ6x4ZLMT7fzZsIhpALI12f2DW1zdLaln00kdU6ryPEXC2pAlNGMqAeIN5
         ORhmIYdH3O73foJXfhI0mqGAixQfo6+FSliBqv50CyginS5N6ZlXoksC/X+mWhRTSv
         G97r00dW1gvGlw5E76mw9GAyYlBqs0Q0G2hXeB9bUmOyk+AZaTOfSZkeD1yiduukd5
         q15bc3qC0OKGpJrhY1LXwQn0HlJ8on3v7Bsy8HknrzLv8cANPh3VMQP+/HFAQqs0md
         i5j+xKGwtHLKQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id v10so745601vsc.7;
        Wed, 16 Oct 2019 22:21:13 -0700 (PDT)
X-Gm-Message-State: APjAAAXx4IH9G7rojwmOvY9aiXeNbDAX8ONjjXlVzX5WuuNqbZItmYU7
        s8Gqql1uunFWontRDk8/bTi34pBMvHIfBtxYywQ=
X-Google-Smtp-Source: APXvYqwss2/d9qZjuKbsfK108HUzp7lt5H+TbSdJkQ0bH/77sXYJJlIhXDQLLVepyYaZQ2ARnobj/mYwAfCKxxumbYQ=
X-Received: by 2002:a05:6102:97:: with SMTP id t23mr881042vsp.179.1571289672006;
 Wed, 16 Oct 2019 22:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
 <20191016231116.inv5stimz6fg7gof@box.shutemov.name> <CAHk-=wh9Jjb6iiU5dNhGTei_jTEoe7eFjxnyQ2DezbtgzdoskQ@mail.gmail.com>
 <20191017001613.watsu7vhqujufjxv@box.shutemov.name>
In-Reply-To: <20191017001613.watsu7vhqujufjxv@box.shutemov.name>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 17 Oct 2019 14:20:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT8968tYxePbS_RD0n52dLfs1vx+tdKc_64PwCzwGOgAw@mail.gmail.com>
Message-ID: <CAK7LNAT8968tYxePbS_RD0n52dLfs1vx+tdKc_64PwCzwGOgAw@mail.gmail.com>
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Pinski <apinski@cavium.com>,
        Michal Marek <michal.lkml@markovi.net>,
        mm-commits@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Ingo Molnar <mingo@elte.hu>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 17, 2019 at 9:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Wed, Oct 16, 2019 at 04:29:54PM -0700, Linus Torvalds wrote:
> > On Wed, Oct 16, 2019 at 4:11 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > Looks like it was fixed soon after the complain:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63567
> >
> > Ahh, so there are gcc versions which essentially do this wrong, and
> > I'm not seeing it because it was fixed.
> >
> > Ho humm. Considering that this was fixed in gcc five years ago, and we
> > already require gc-4.6, and did that two years ago, maybe we can just
> > raise the requirement a bit further.
> >
> > BUT.
> >
> > It's not clear which versions are ok with this. In your next email you said:
> >
> > > It would mean bumping GCC version requirements to 4.7.
> >
> > which I think would be reasonable, but is it actually ok in 4.7?
>
> I think, not. I don't have 4.7 around, but 4.9.3 has the issue if
> -std=gnu99 is used.
>
> > The bugzilla entry says "Target Milestone: 5.0", and I'm not sure how
> > to check what that "revision=216440" ends up actually meaning.
> >
> > I have a git tree of gcc, and in that one 216440 is commit
> > d303aeafa9b, but that seems to imply it only made it into 5.1:
> >
> >   [torvalds@i7 gcc]$ git name-rev --tags
> > d303aeafa9b46e06cd853696acb6345dff51a6b9
> >   d303aeafa9b46e06cd853696acb6345dff51a6b9 tags/gcc-5_1_0-release~3943
> >
> > so we'd have to jump forward a _lot_.
> >
> > That's a bit sad and annoying. I'd be ok with jumping to 4.7, but I'm
> > not sure we can jump to 5.1.
> >
> > Although maybe we should be a _lot_ more aggressive about gcc
> > versions, I'm on gcc-9.2.1 right now, and gcc-5.1 is from April 22,
> > 2015.
>
> 5.4.1 builds kernel fine for me with allmodconfig (minus retpoline which
> requires compiler support). Both -std=gnu99 and -std=gnu11.
>
> Note that GCC has changed their version scheme. 5.4.1 is bug-fix release
> of GCC-5.


I tested -std=gnu99 for ARM
with pre-built Linaro toolchains.


GCC 4.9.4 was NG,
GCC 5.3.1 was OK.



If we increase the minimal GCC version,
we might end up with dropping more architecture.

I can no longer get the toolchains for hexagon, unicore32.


https://mirrors.edge.kernel.org/pub/tools/crosstool/
provides hexagon compilers, but only for GCC 4.6.1



-- 
Best Regards
Masahiro Yamada
