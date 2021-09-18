Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA6410896
	for <lists+linux-arch@lfdr.de>; Sat, 18 Sep 2021 22:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbhIRUk3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Sep 2021 16:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhIRUk3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2021 16:40:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC9AC061574
        for <linux-arch@vger.kernel.org>; Sat, 18 Sep 2021 13:39:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g1so48886546lfj.12
        for <linux-arch@vger.kernel.org>; Sat, 18 Sep 2021 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IqNt5nWTQLqRGpQEMlOKbD7bENcF2xRoMQ119q1Za6w=;
        b=R20A3mmR/f2eCdYwZ91MeBVlRK1Cl7GDpXP9jzgowmeAZhB0iUEbJSANmcPv2ho+Kz
         n+Y8ej2Qaz/Ya3ljnRxCxZJK96mZnXYrPfIdIoaSHXYh+R3rSO+hWyDvWdZXcxYdC9/L
         8Z+1W4I/1BjwF94FFzKcjogQyO8J0I+bnV8EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IqNt5nWTQLqRGpQEMlOKbD7bENcF2xRoMQ119q1Za6w=;
        b=scH/2k5KZ6caTPQTyKyWOW79uJgGNR8lYB6NcCrVBfXDDtAFma3LCG2we9KJGjXQ89
         FW/J0wkOl9NKWRHnAqvdsKaKYsHZCFJnkMnod19mvBRVkmY1uShTdZydcTl5Cditc/jc
         L9FrKC/NxupxqSILRwAMjWe8sl462jbN6dJ7fkQ07N4uQ/rxNc6BVdaI9dQXyXnFFXjH
         tpul12PbabXtowQ666pAQ4/Z1ZBrb/IFJliMnc+lF4HA9QfnkWolaMWr+kUbCbBHIp9h
         6NtiSyWZ1agAIv2p+1C750SWY4fkcnR+MODeAZMum8mDtV93QLvyixrfqtRdjgKrLLKf
         HgRQ==
X-Gm-Message-State: AOAM533Uz82o5ekYQc6Bb8YydIGA2wEZm+1QjMx65V50n2d5pOfcYFa3
        2/4ySlPvlvJNaFRAPCgHKV/bsme8gtIkNBpNUco=
X-Google-Smtp-Source: ABdhPJzA9qttKmJ8lUqV2WXN8BPPWiXWh6o2emuTJGd7YQWvDkA/wCeZt5O6RcMNsN+gDREaQ+79mQ==
X-Received: by 2002:a2e:990d:: with SMTP id v13mr15188248lji.127.1631997542865;
        Sat, 18 Sep 2021 13:39:02 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id n4sm1098383lji.100.2021.09.18.13.39.01
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 13:39:02 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id i25so48852824lfg.6
        for <linux-arch@vger.kernel.org>; Sat, 18 Sep 2021 13:39:01 -0700 (PDT)
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr2450196lfv.474.1631997541433;
 Sat, 18 Sep 2021 13:39:01 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 13:38:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
Message-ID: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
Subject: Odd pci_iounmap() declaration rules..
To:     Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ulrich Teichert <krypton@ulrich-teichert.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

So I was looking at a patch by Ulrich that reportedly got the alpha
'Jensen' platform compile going again, and while it didn't work for
me, a slightly modified one did get it mostly working. See commit
cc9d3aaa5331 ("alpha: make 'Jensen' IO functions build again") for
entirely irrelevant details.

Anyway, that particular case doesn't really matter, but the Jensen
configuration is somewhat interesting in that it doesn't have
CONFIG_PCI (and alpha doesn't do CONFIG_PM), and it turns out that
breaks some other things.  Some of them are just random driver issues,
not a big deal.

But one particular case is odd: "pci_iounmap()" behavior is all kinds of crazy.

Now, to put that in perspective, look at pci_iomap(), and it's
actually fairly normal, and handled in
include/asm-generic/pci_iomap.h, with a fairly sane

  #ifdef CONFIG_PCI
  .. real declaration ..
  #elif defined(CONFIG_GENERIC_PCI_IOMAP)
  .. empty declaration ..
  #endif

although you can kind of see some oddity there if you look at the
declaration of the __pci_ioport_map() thing for the special case of
port remapping. Whatever. On the whole, you have that "declare for
PCI, otherwise have empty declarations so that non-PCI systems can
still build cleanly".

Now, alpha makes the mistake of making that GENERIC_PCI_IOMAP thing
conditional on having PCI at all:

        select GENERIC_PCI_IOMAP if PCI

which then means that the "non-PCI systems can still build cleanly"
doesn't actually end up working, but whatever.  It does point out that
maybe that

  #elif defined(CONFIG_GENERIC_PCI_IOMAP)

should perhaps just be a #else. Because it's kind of silly to only
have those empty declarations if PCI is _not_ enabled, but
GENERIC_PCI_IOMAP is enabled. Most architectures seem to just select
GENERIC_PCI_IOMAP unconditionally, and it also gets selected magically
for you if you pick GENERIC_IOMAP.

So it's all a bit illogical, and slightyl complicated, but it doesn't
seem to be a huge deal.

What is *entirely* illogical is the state of "pci_iounmap()", though.

You'd think that it would mirror pci_iomap(), wouldn't you? The two go
literally hand-in-hand and pair up, after all.

But no. Not at all.

pci_iounmap() is decared not in include/asm-generic/pci_iomap.h
together with pci_iomap(), but in include/asm-generic/iomap.h.

And it has a different #ifdef too, doing

  #ifdef CONFIG_PCI
  .. delcaration..
  #elif defined(CONFIG_GENERIC_IOMAP)
  .. empty implementation ..
  #endif

which makes _no_ sense. Except it seems to be paired with this one in
asm-generic/io.h (!!):

  #ifndef CONFIG_GENERIC_IOMAP
  .. declaration  for pci_iomap() ..

  #ifndef pci_iounmap
  #define pci_iounmap pci_iounmap
  static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
  {
        __pci_ioport_unmap(p);
  }
  #endif
  #endif /* CONFIG_GENERIC_IOMAP */

which really makes no sense at all.

So there's GENERIC_IOMAP, and there is GENERIC_PCI_IOMAP, and the
_former_ modifies the behavior of "pci_iounmap()", but the _latter_
(more logically) modifies the behavior of "pci_iomap()".

I think this may at least partly just be a mistake. See commit
97a29d59fc22 ("[PARISC] fix compile break caused by iomap: make
IOPORT/PCI mapping functions conditional") which added those two
different CONFIG_ tests. The different config option kind of makes
sense in the context of which header file the declaration was in, but
I think _that_ in turn was just an older confusing mistake.

I'd like to fix some of the alpha issues by just making alpha do

        select GENERIC_PCI_IOMAP

unconditionally, so that if PCI isn't enabled, it gets the default
empty implementation.

But that doesn't work right now, because of the crazy situation with
pci_iounmap().

I think the right fix would be to(),

 (a) move pci_iounmap() declaration to
include/asm-generic/pci_iomap.h, and use the sane GENERIC_PCI_IOMAP
config option for it (or even better, remove that #elif entirely and
make it just #else

 (b) if you want to make your own pci_iounmap(), you just implement
your own one, and don't play games in the header file.

Hmm? Comments? Added random people who have been involved in this
(commit 97a29d59fc22 is from James, replaced him with Helge instead).

                     Linus
