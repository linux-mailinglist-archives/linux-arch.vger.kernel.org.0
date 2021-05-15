Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F9E381AEF
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 22:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhEOUMo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 16:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhEOUMm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 May 2021 16:12:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D9026121E;
        Sat, 15 May 2021 20:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621109489;
        bh=KGVNwawW8npQ64DMYLeLHsXJrejNvMH6jfAnNO6Flaw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i0OdoOqqwigdqqTYDpx3l3apcdLe23+2p7LaZMybDEqnZZ2ifXQplJDsw9pcGHsZC
         SX2a9lhCIInl1FPm9TkC1mRi3rg+JxtSj5pwtIFHsF3AKNtODVDY1TZBLOC1+IDaNi
         xOtPtLeN68lACsd8QQnvGzcsRVUmNP/Bc3z+fCFgUuzAiwK/UYGq/CR6qDLyZvNzfb
         PApSv6aH9oQMXVAcRmPq47qmXgM6h3Am/6EhjwNRvUQUGF7TlwDdZdiZx+NQy561NZ
         Chd2DlBi7PG/IdF4i9IICs+YvJtrD6WVtdk6Z/a/8Az1MArP0VSpM5PYX5hvyqQ9qj
         rseuYpaHMJc8w==
Received: by mail-wr1-f54.google.com with SMTP id d11so2402320wrw.8;
        Sat, 15 May 2021 13:11:28 -0700 (PDT)
X-Gm-Message-State: AOAM5337Yg2e/oN01jP3cD1pUzAHzSoM9OXpETFHJp6zqb8Caze88DyO
        NWC+W8jy7frMlClRbweMq320Fv6merGHcY1s6YA=
X-Google-Smtp-Source: ABdhPJw5vZVwtL/1Xv3i7ea7c+0zq/xvTP2jhE+MqK4pi6SXbi+KkgW3fdP2vafzotWziyKlMhPI0G0Y3n3s+bzWj5g=
X-Received: by 2002:adf:fe04:: with SMTP id n4mr9290331wrr.361.1621109487649;
 Sat, 15 May 2021 13:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-4-arnd@kernel.org>
 <3d70eb2a-2969-197e-63e8-f3e0a6a8ddd8@physik.fu-berlin.de>
 <CAK8P3a1oO_moABCtNqLkM9ccVh9c=andfz+qiSucTCXcqJkYVA@mail.gmail.com> <71b5d15d-7bd2-aa08-cc0a-3caccf9c66c8@physik.fu-berlin.de>
In-Reply-To: <71b5d15d-7bd2-aa08-cc0a-3caccf9c66c8@physik.fu-berlin.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 15 May 2021 22:10:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1VOgW+oT9cGGYyLEt4jr+zrZyA6fz66AdSZuSgoq5xaQ@mail.gmail.com>
Message-ID: <CAK8P3a1VOgW+oT9cGGYyLEt4jr+zrZyA6fz66AdSZuSgoq5xaQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] sh: remove unaligned access for sh4a
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 15, 2021 at 5:36 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/14/21 2:22 PM, Arnd Bergmann wrote:
> >> My Renesas SH4-Boards actually run an sh4a-Kernel, not an sh4-Kernel:
> >>
> >> root@tirpitz:~> uname -a
> >> Linux tirpitz 5.11.0-rc4-00012-g10c03c5bf422 #161 PREEMPT Mon Jan 18 21:10:17 CET 2021 sh4a GNU/Linux
> >> root@tirpitz:~>
> >>
> >> So, if this change reduces performance on sh4a, I would rather not merge it.
> >
> > It only makes a difference in very specific scenarios in which unaligned
> > accesses are done in a fast path, e.g. when forwarding network packet
> > at a high rate on a big-endian kernel (little-endian kernels wouldn't run into
> > this on IP headers). If you have a use case for this machine on which the
> > you can show a performance regression, I can add a patch on top to put
> > the optimized sh4a get_unaligned_le32() back. Dropping this patch
> > altogether would make the series much more complex because most of
> > the associated code gets removed in the end.
>
> Hmm, okay. But why does code which sits below arch/sh have to be removed anyway?
>
> I don't fully understand why it poses any maintenance burden/

What  I'm removing is the part that lets architectures override the
generic version.

> > As I mentioned, supporting "movua" in the compiler likely has a much
> > larger impact on performance, as it would also help in user space, and
> > it should improve the networking case on little-endian kernels by replacing
> > the four separate byte loads/shift pairs with a movua plus a byteswap.
>
> The problem is that - at least in Debian - we use the sh4 baseline while the kernel
> supports both sh4 and sh4a, so we can't use any of these instructions in userland at
> the moment.

I tried building an sh7785lcr_defconfig with and without the patch,
and found that
the only affected files are:

- in-kernel nfs client
- crc32c/sha1/sha256 hash functions
- device probing for libata, scsi-core, scsi-disk, hid, r8168
  (should not matter after boot)
- msdos partition parsing

Any nfs client performance difference is probably not even measurable even
at gigabit ethernet speed.
I see that the hash functions are notably different, but I don't know if the
output from the new generic code is actually better or worse than the
original. If you do think this is important, please try the version from

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
unaligned-sh4a

against the version without the last change in that series. If you can find
a relevant test case that exercises it, you may want to add a custom
implementation of the hash functions as well.

       Arnd
