Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAA135123A
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhDAJ3Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 05:29:25 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58049 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhDAJ3M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 05:29:12 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZTVu-1l5R442Tfa-00WXbO; Thu, 01 Apr 2021 11:29:10 +0200
Received: by mail-ot1-f44.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so1578861otn.1;
        Thu, 01 Apr 2021 02:29:10 -0700 (PDT)
X-Gm-Message-State: AOAM531X1hlVm1C9ie4Z40gt/SkIsQSb70MCnuGEZqHdPbWM2VR/WgDA
        MZdLI+eo/RuPZnR5DNt5pP4UW0CoZFamW+44oTg=
X-Google-Smtp-Source: ABdhPJx3QsdoGUsw9pHERckr3f5KeRsspxanWz7xZVoNUPIClyIXxiSoe95afl7728tbFkutzVy8X1AghVyQZnowz7E=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr6210224otk.305.1617269349103;
 Thu, 01 Apr 2021 02:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com> <CAHp75VdzRXPsQ7Jvivm5UU+mfkgQ_0rmnegp04v-v9fwrjdrqg@mail.gmail.com>
In-Reply-To: <CAHp75VdzRXPsQ7Jvivm5UU+mfkgQ_0rmnegp04v-v9fwrjdrqg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 1 Apr 2021 11:28:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2EGc4BS7UTyC6=ySgLEoyqbswh1Gh_=M21NmhRThssYQ@mail.gmail.com>
Message-ID: <CAK8P3a2EGc4BS7UTyC6=ySgLEoyqbswh1Gh_=M21NmhRThssYQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] lib/find_bit: fast path for small bitmaps
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:F++a8GMABKVEPdySZrUnxiUUPOgM4EtC7DjMKJdw+Ms7eTAy49b
 pUxu4d/nm1Vxv9UAV5LlF4z3pbaKutNbhWmftjr2/V2+P4voffkpav3IoXIIQ7TkVPvxc8/
 YMgudxGSyOJQlI1UtaEElZfU6SqnGxnqoAK8veHkCMaCdwAwTFJABcyh9iEvCQHRCBvIYjH
 zkDpdvFJ5+BbEeRTlBRVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ty5hi0VrPLo=:pz8rtaQK2hOPItwSD6pNce
 sQPqr+A6pw+MliM3wbRYr+uD2Cts0vdrOWznMwBYVBny6neaEl3Uq6wTowLI+LwvFMA7V+Htq
 5tEl+iXX8+EJSH5gjgdsme4HcA/EVLdk1ZE1o/eWLKWj5Sk1TgaqZkVKDaCY0ZCxIAPBnVLNM
 wwBuY5MRfoljUTTPE6xtAPKTnYP1Ad5j/V9j0iBCjw7nFAGyIAE7rHgHiKJldlZvT7nYHIspH
 NkLU/wTrJPa36MWq1v2fR3CTUAwj1/s05V4Qi8V+j76hnbpIiVj2ZlmFJLegmal5a7MAIFINe
 p4XdGY5rDAVRpQQalim0mmQg0bOsUd+B2UHGIAn3Kn/wj7WyCEsBcdXnAUh72c3BeomBtfM0c
 olQtU1LSq7rFk51ETEcB+1Eky9ZYJLK5d9SsM1xRAn/ooVAeWQCTGUS42t4PzKykJd+u0Qgi6
 Y90F2oRfDHv1fQkoC4crINxVL3cGlUj8sCgtago68EVfqbHjpD8gCBYJ3VCvUON0zvq94nNNH
 N4sEEkVDmRCIncpeWqREYWwdnRPamqN4Q9uGG8QoustwrhVbPOmC/QEyFm8+QOdlYN3RNyFVV
 Ucs/mvFd5BMn3rPCx4Rb9ywe85zBh/Gmiw
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 1, 2021 at 11:16 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 1, 2021 at 3:36 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Bitmap operations are much simpler and faster in case of small bitmaps
> > which fit into a single word. In linux/bitmap.c we have a machinery that
> > allows compiler to replace actual function call with a few instructions
> > if bitmaps passed into the function are small and their size is known at
> > compile time.
> >
> > find_*_bit() API lacks this functionality; but users will benefit from it
> > a lot. One important example is cpumask subsystem when
> > NR_CPUS <= BITS_PER_LONG.
>
> Cool, thanks!
>
> I guess it's assumed to go via Andrew's tree.
>
> But after that since you are about to be a maintainer of this, I think
> it would make sense to send PRs directly to Linus. I would recommend
> creating an official tree (followed by an update in the MAINTAINERS)
> and connecting it to Linux next (usually done by email to Stephen).

It depends on how often we expect to see updates to this. I have not
followed the changes as closely as I should have, but I can also
merge them through the asm-generic tree for this time so Andrew
has to carry fewer patches for this.

I normally don't have a lot of material for asm-generic either, half
the time there are no pull requests at all for a given release. I would
expect future changes to the bitmap implementation to only need
an occasional bugfix, which could go through either the asm-generic
tree or through mm and doesn't need another separate pull request.

If it turns out to be a tree that needs regular updates every time,
then having a top level repository in linux-next would be appropriate.

        Arnd
