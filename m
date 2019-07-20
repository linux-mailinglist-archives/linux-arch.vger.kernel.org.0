Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C279A6EE8A
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jul 2019 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfGTJMX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Jul 2019 05:12:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45571 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGTJMX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jul 2019 05:12:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id x22so28667881qtp.12
        for <linux-arch@vger.kernel.org>; Sat, 20 Jul 2019 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9vzWV8Ca5ZiwBPqlX5aD97Lzj7PenGNrz85lKl2vuo=;
        b=H9qV5v12Wqel771w5xTXj+jziGxBFfS/uTmnakG2aeCUovo0UsALCPBQ2pOpL0ljPw
         dWAanbnmRfnE2Ltk9hiNcAfVyqWBuR6N+fa/ZnxsMQN9frYsbsgLFK6UY5X7H6kGvFOI
         v7gITakCnzoG6CEuL43YokrFmuiEXGHgbTFKiSSXTidlrMPylvV2olPM0th82hnsCUV9
         4ieTy5DpsKNkPCaaliCHPT3NEEs1xcEBSS11gyunIbK6Wjmr5yGE18WXV+G1uicw6QAv
         w8lvQ76SRqHzN+7NygzwyoIlmobDne94K5se2ZEGXszG7ITM5zFP1FavwLDUQ9L3Hzoi
         M3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9vzWV8Ca5ZiwBPqlX5aD97Lzj7PenGNrz85lKl2vuo=;
        b=ULnDbsQTH92CaJo/UlF9HzhjE7+xFwzOWuDETiIk91ZR6MnmM9VN/mCGyxc69sgwTs
         G6+eJRJK/r22yQgt2R71lKcAvTSt/sxquVsUqlrJxGnW2QHlcIT0ms0p0ccoqhzrXjYb
         8pvhZ8FgxPaDy2qE2TJL/zqq/VSU71eqdCbtrMwU1JhR58ptayDjkkGxvRtwjqgx9YhT
         8/NRvWUigJ05l5FPXMgYfusYHuFdgYE/3eqA8r7kbv0IxCYVmpSf/sf+W/l9nUaUjMdO
         Ly+jgKBt8ONX19Poh+PK+xe49HhezCkTNeCi16ldQKhHSlJIJy6oA/PnKXBsJzcEy0Fd
         q/UA==
X-Gm-Message-State: APjAAAX1gfqNcseZAZbHlaKkWG1oMdnD9ERblc8cPfMZCe63EA4TGo6y
        ZihIubmjfv+y7rgbfiF/d7894qJHOlbXPtwS4EM=
X-Google-Smtp-Source: APXvYqwJ4BFSC+qGqZdtK/SwiFSTKqxi9AS9364/sZanXQ6+jrool4Px1bNT16XjF59ECzEG25/bsi2CR2aVtDMcrlM=
X-Received: by 2002:a0c:9214:: with SMTP id a20mr42018745qva.195.1563613941752;
 Sat, 20 Jul 2019 02:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com> <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Sat, 20 Jul 2019 10:12:10 +0100
Message-ID: <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 17 Jul 2019 at 08:57, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 17 Jul 2019, Masahiro Yamada wrote:
> > On Wed, Jul 17, 2019 at 4:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > So instead of dealing with attempts to duct tape gold support without
> > > understanding the root cause and without support from the gold folks, fail
> > > the build when gold is detected.
> > >
> >
> > The code looks OK in the build system point of view.
> >
> > Please let me confirm this, just in case:
> > For now, we give up all architectures, not only x86, right?
>
> Well, that's the logical consequence of a statement which says: don't use
> gold for the kernel.
>
> > I have not not heard much from other arch maintainers.
>
> Cc'ed linux-arch for that matter.
>
> Thanks,
>
>         tglx

Hi

I've done a bit more digging, I had a second machine that was building
Linus's tree just fine with ld.gold

I tried forcing ld.bfd on the problem machine and got this:

ld.bfd: arch/x86/boot/compressed/head_64.o: warning: relocation in
read-only section `.head.text'
ld.bfd: warning: creating a DT_TEXTREL in object

I had a look at the differences in the kernel configs and noticed this:

CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0

Unsetting CONFIG_RANDOMIZE_BASE=y gets things working for me with ld.gold again

In light of this - can we drop this patch?

Cheers

Mike
