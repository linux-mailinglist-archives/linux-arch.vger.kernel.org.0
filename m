Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F2C3511AE
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhDAJO4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 05:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbhDAJOa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 05:14:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7EC061788;
        Thu,  1 Apr 2021 02:14:29 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y32so1158119pga.11;
        Thu, 01 Apr 2021 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bE+3StyieI+JnnmidrTP6v/tlTUOVerVAIsvH6KU4Fo=;
        b=tsaEXYOZNKbUuCLjcv6dTYHbFF8L64sGeLkKR/qXoCwopd4JIm6/oxbtyG02U6MLQc
         oTRSCtiJwK5ZiAqLV1Vicebu9tI4GmAf6Yqb0u37N1PYVOIJtauJEIzwbPNrKCvmH9SX
         4CQx6UtAOsq6nP+J2Q6vmEn0gVASQ+mSGJ9WIgYU/RMIoNIRQyLsEglSYCEZRF3P6+9/
         KlMpXkMzmHV4zcyJOJ5J5+ciVZ5+Uv1pyVoLF8/AxBvsFXNje0iNjmJDcHeKhn/onjxp
         jKsOEkdAZzfhOvSxS3T6pHNqJfm5RhWn6iP1jC6DiKJu+TbEuWBTVatGviaYdV8Lawd7
         /Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bE+3StyieI+JnnmidrTP6v/tlTUOVerVAIsvH6KU4Fo=;
        b=PS2pvtNn6+MWsSzJ+HZaBcIxcN7oWj08x2WFQn1oBSyTg2lsrz8ilv6/KozAHOqJlv
         ASQiNht/F0a5h+aFlnwpYtytSNLUZ/HlbCfX3rX28HKDcI3SAQKEiKU0Tuy15uAQB5Nr
         8sef+7oGIaM6C9rMYApav5QdMZqtzhHo/usenyxOiYZuecHQHTNOAch9WYmcYOFBJtoa
         aZq95BIjARXnrnJxPilNZbx966Wxa2GFnRgr3mbj+3V2xxZ0/ZTSW3GeYKa3HeBI1w8u
         soNZxBpbBs2NCjBB4CdOYFbGhPQjO1L7VoTFEeg1UhiQzIZ7E4IdAKvVZKwr21qqLK6G
         uy6A==
X-Gm-Message-State: AOAM5328uVYB6AutDKrmXlVh1TnIuoW/y5RTlPUKiLu1eYS1Avf5iqNE
        g2kUOMRPw5HnTivetX8F/OWUjtCP0l8+iYWXnTI4SikgXcE=
X-Google-Smtp-Source: ABdhPJybehL8R1uULhOes3o60kx0G6pc+GWY3/3tKxi4VnLNBbrCgIvHyDBkgSsRRYQKjZMXfDuUiB73snt/DkEHpjc=
X-Received: by 2002:a63:3e4b:: with SMTP id l72mr6538577pga.203.1617268468685;
 Thu, 01 Apr 2021 02:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com>
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Apr 2021 12:14:12 +0300
Message-ID: <CAHp75VdzRXPsQ7Jvivm5UU+mfkgQ_0rmnegp04v-v9fwrjdrqg@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] lib/find_bit: fast path for small bitmaps
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
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

On Thu, Apr 1, 2021 at 3:36 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> Bitmap operations are much simpler and faster in case of small bitmaps
> which fit into a single word. In linux/bitmap.c we have a machinery that
> allows compiler to replace actual function call with a few instructions
> if bitmaps passed into the function are small and their size is known at
> compile time.
>
> find_*_bit() API lacks this functionality; but users will benefit from it
> a lot. One important example is cpumask subsystem when
> NR_CPUS <= BITS_PER_LONG.

Cool, thanks!

I guess it's assumed to go via Andrew's tree.

But after that since you are about to be a maintainer of this, I think
it would make sense to send PRs directly to Linus. I would recommend
creating an official tree (followed by an update in the MAINTAINERS)
and connecting it to Linux next (usually done by email to Stephen).


> v6 is mostly a resend. The only change comparing to v5 is a fix of
> small_const_nbits() synchronization patch.
>
> v1: https://www.spinics.net/lists/kernel/msg3804727.html
> v2: https://www.spinics.net/lists/linux-m68k/msg16945.html
> v3: https://www.spinics.net/lists/kernel/msg3837020.html
> v4: https://patchwork.kernel.org/project/linux-sh/cover/20210316015424.1999082-1-yury.norov@gmail.com/
> v5: https://lore.kernel.org/linux-arch/20210321215457.588554-1-yury.norov@gmail.com/T/
> v6: - sync small_const_nbits() properly (patch 6).
>     - Rasmus' ack added.
>
> Yury Norov (12):
>   tools: disable -Wno-type-limits
>   tools: bitmap: sync function declarations with the kernel
>   tools: sync BITMAP_LAST_WORD_MASK() macro with the kernel
>   arch: rearrange headers inclusion order in asm/bitops for m68k and sh
>   lib: extend the scope of small_const_nbits() macro
>   tools: sync small_const_nbits() macro with the kernel
>   lib: inline _find_next_bit() wrappers
>   tools: sync find_next_bit implementation
>   lib: add fast path for find_next_*_bit()
>   lib: add fast path for find_first_*_bit() and find_last_bit()
>   tools: sync lib/find_bit implementation
>   MAINTAINERS: Add entry for the bitmap API
>
>  MAINTAINERS                             |  16 ++++
>  arch/m68k/include/asm/bitops.h          |   6 +-
>  arch/sh/include/asm/bitops.h            |   5 +-
>  include/asm-generic/bitops/find.h       | 108 +++++++++++++++++++++---
>  include/asm-generic/bitops/le.h         |  38 ++++++++-
>  include/asm-generic/bitsperlong.h       |  12 +++
>  include/linux/bitmap.h                  |   8 --
>  include/linux/bitops.h                  |  12 ---
>  lib/find_bit.c                          |  68 ++-------------
>  tools/include/asm-generic/bitops/find.h |  85 +++++++++++++++++--
>  tools/include/asm-generic/bitsperlong.h |   3 +
>  tools/include/linux/bitmap.h            |  18 ++--
>  tools/lib/bitmap.c                      |   4 +-
>  tools/lib/find_bit.c                    |  56 +++++-------
>  tools/scripts/Makefile.include          |   1 +
>  15 files changed, 284 insertions(+), 156 deletions(-)
>
> --
> 2.25.1
>


--
With Best Regards,
Andy Shevchenko
