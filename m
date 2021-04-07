Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7684356517
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346473AbhDGHSr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 03:18:47 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:37652 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhDGHSd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 03:18:33 -0400
Received: by mail-vs1-f51.google.com with SMTP id 2so8215220vsh.4;
        Wed, 07 Apr 2021 00:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNIWCvfs0ZW4eVgsk+0zdu8i1BkoDuHPkcI6NnFD88o=;
        b=gsQC9RPM63DO358lomakf4DbH2WZfVVo9SyciFu+0xqndIdhpu5FrRBvpC7eC6kPJZ
         OP9ACkDWCXHZhZ4XO+rP9w4NWCtD6WkT0fKqsptMMP0ZVPXxoJkS0yxSAd3ixkQgP2om
         CmyCb7nyYIONWTo68WMY+VmHt43EIXXM/Qyniz6VGzL1ihWOTR3RgnH1lsHHAze4AIaa
         hw1CClXHnQbuUwdakC0BBBaTPlDPJE5zysWU4GA3hqXKr/9DrUDRllsCpMAukquSZMOF
         dP9cfG96dIwdkfv1hdeDEnZra7V+pkktKa776ZQK+xCZlEdEkhBa7R2c32fFI4rfTtBp
         ZKUQ==
X-Gm-Message-State: AOAM5336vEhhMaP74Fyr4MHG+u9crT+F347ujIYb4dSo2AdUjscQsF0n
        F8jdsrDG+Qfq6Ij+VAaTowpKLGuzG479fedd9Q4=
X-Google-Smtp-Source: ABdhPJyftQlnHFXdM0yzdSgYYSKctCxPQ9kcTX65FNLj2mQMzON5fJBl/zAARa/sp8zjhgK4//xwDDnuTn6hpklj5ZM=
X-Received: by 2002:a67:7d02:: with SMTP id y2mr1034896vsc.18.1617779902678;
 Wed, 07 Apr 2021 00:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Apr 2021 09:18:11 +0200
Message-ID: <CAMuHMdWGnr1wK3yZdLovxmVQT1yc2DR+J6FwQyCLxQS-Bp29Rw@mail.gmail.com>
Subject: Re: [PATCH 00/20] kbuild: unify the install.sh script usage
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Greg,

Thanks for your series!

On Wed, Apr 7, 2021 at 7:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Almost every architecture has copied the "install.sh" script that
> originally came with i386, and modified it in very tiny ways.  This
> patch series unifies all of these scripts into one single script to
> allow people to understand how to correctly install a kernel, and fixes
> up some issues regarding trying to install a kernel to a path with
> spaces in it.
>
> Note that not all architectures actually seem to have any type of way to
> install a kernel, they must rely on external scripts or tools which
> feels odd as everything should be included here in the main repository.
> I'll work on trying to figure out the missing architecture issues
> afterward.

I'll bite ;-)

Does anyone actually use these scripts (outside of x86)?
I assume the architectures that have them, only have them because they
were copied from x86 while doing the initial ports ("oh, a file I don't
have to modify at all.").
But installing the kernel can be very platform-specific.
Do you need the vmlinux, vmlinux.gz, Image, zImage, uImage, ...?
With separate or appended DTB?

Even on x86, the script will bail out with "Cannot find LILO." if you're
using Grub.

Anyway, having less of them is good.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
