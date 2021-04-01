Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5DA3512B8
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhDAJvC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 05:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhDAJus (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 05:50:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C4C0613E6;
        Thu,  1 Apr 2021 02:50:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 11so1063936pfn.9;
        Thu, 01 Apr 2021 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rfhvrhvTSo4JLkNVbcKkmfjeWHgVESw491Efee+3BA=;
        b=DgZNbxa2Nf9HfWBlDfyrAYIIyoODQOGfK33DUNfoe/5yf/0CPsXXiUeOU1zdlWL3DY
         Lj1pM/R2SN13dSDU0P+q8KSQvr299Q8/szD0H0xnneBKoZpxONZ0yNLM0F68VdN6VFNt
         YABDidfiKPZxkLjJgPGsSWkPKR44UcG06kYu3+XppXpgMgo+/OlNwY+aw4JBiAF3Y19H
         50TG32w/hAKgMqvgDUIuIeEvE4ILakado5t9ECcby1HvAtcUqGVCuf7jCArDD+pJB3JY
         li4K1RPo6fCDbYQmCSUB1QzQ2ddSEo8qY8rEo3zaSJ0wMF0iAH9l7THDgq7nab3SksqI
         3wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rfhvrhvTSo4JLkNVbcKkmfjeWHgVESw491Efee+3BA=;
        b=KfXgwwyG11tqNlQhS0tE5mL22qjFXQmzSbtAAgAXdOw5MDj0b3KzAlPfJY5/lJ1YJO
         6p85ujrdaBfOkFRQT/YY1Ho8zNM/MzYTif/KhRwwo5G/ot8ip0HdS0PAM8Xk4oD4aFHT
         oMHkNXtrImbe8g0eia9jGHMpsUOK23Xh8TeGIT8E63SIjEAA31dgVubhgkG9FzfDZqB9
         O1lziya8UwFDnhKSWWdx2bD7CnTZ9ZXM686Yk/u55xng6ZyLSrQjRdqwifT7G+rP4VwA
         HLjYNZLw+JzR/qqNTFiJz/5wEGF61GjLlzNJB2ucW+s4JuJfnMi1Boxb2yBRrnZlzkU3
         SyzQ==
X-Gm-Message-State: AOAM531BQwYQPM3R0EDadJIy/cu9yKXvrYb0HrnjetPT8zsS5zGrKLS3
        fiEzkL8dfFj0iaN5AmCnj33bYqhhmxO/G7lHB6U=
X-Google-Smtp-Source: ABdhPJz7j2nNz9qv2IrtVW/D1sczbGytNy6sUXKazkSOyi/BCDvfs085s+kcA1f8g4roqF80H2yZItYyeLaoK65/of8=
X-Received: by 2002:a62:7c43:0:b029:1ef:20ce:ba36 with SMTP id
 x64-20020a627c430000b02901ef20ceba36mr6887135pfc.40.1617270647711; Thu, 01
 Apr 2021 02:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com> <CAHp75VdzRXPsQ7Jvivm5UU+mfkgQ_0rmnegp04v-v9fwrjdrqg@mail.gmail.com>
 <CAK8P3a2EGc4BS7UTyC6=ySgLEoyqbswh1Gh_=M21NmhRThssYQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2EGc4BS7UTyC6=ySgLEoyqbswh1Gh_=M21NmhRThssYQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Apr 2021 12:50:31 +0300
Message-ID: <CAHp75VdTndAD1gyLE_e8m9AaxrRMCNpYEu22+tWe1xrAz8oKBw@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] lib/find_bit: fast path for small bitmaps
To:     Arnd Bergmann <arnd@arndb.de>
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 1, 2021 at 12:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 1, 2021 at 11:16 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Apr 1, 2021 at 3:36 AM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > Bitmap operations are much simpler and faster in case of small bitmaps
> > > which fit into a single word. In linux/bitmap.c we have a machinery that
> > > allows compiler to replace actual function call with a few instructions
> > > if bitmaps passed into the function are small and their size is known at
> > > compile time.
> > >
> > > find_*_bit() API lacks this functionality; but users will benefit from it
> > > a lot. One important example is cpumask subsystem when
> > > NR_CPUS <= BITS_PER_LONG.
> >
> > Cool, thanks!
> >
> > I guess it's assumed to go via Andrew's tree.
> >
> > But after that since you are about to be a maintainer of this, I think
> > it would make sense to send PRs directly to Linus. I would recommend
> > creating an official tree (followed by an update in the MAINTAINERS)
> > and connecting it to Linux next (usually done by email to Stephen).
>
> It depends on how often we expect to see updates to this. I have not
> followed the changes as closely as I should have, but I can also
> merge them through the asm-generic tree for this time so Andrew
> has to carry fewer patches for this.
>
> I normally don't have a lot of material for asm-generic either, half
> the time there are no pull requests at all for a given release. I would
> expect future changes to the bitmap implementation to only need
> an occasional bugfix, which could go through either the asm-generic
> tree or through mm and doesn't need another separate pull request.
>
> If it turns out to be a tree that needs regular updates every time,
> then having a top level repository in linux-next would be appropriate.

Agree. asm-generic may serve for this. My worries are solely about how
much burden we add on Andrew's shoulders.

-- 
With Best Regards,
Andy Shevchenko
