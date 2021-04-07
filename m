Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A737E356A88
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 12:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351689AbhDGKyt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 06:54:49 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:39262 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351677AbhDGKys (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 06:54:48 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 137As8HD019478;
        Wed, 7 Apr 2021 19:54:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 137As8HD019478
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617792849;
        bh=GHNPkbKKRD5a2nOrnlcUrTtHVkd1LKSTOkdi37JpDHU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hglKVWsWPoSPlcAkB7IWZyL8TfhVMtb1jwzW+vYGb7wNj/VqvKxpqzmj/NdEW4qXA
         FQLoPxx0FMcuz1+W0NNdg3pzarv/8JmbjLR+Jnpfx16p6+iczYBPXDbke9C5/dHRsD
         GOHDAgpezkdzPQDaKKGQaBPcvJ93VNMiky+g9E4W3rkoMdQWC1d0/2nUH7E3/g7KZx
         3/xGroEPRtvv0S5Rq39a4spV5mp40qOcuD2x9oDdM2hr15OZyxmE5QNrmp8LVvxLIM
         UAtEqygWYCjWXMu7pNQ1WuyOQhO143xps5qMp+CaY8ET8CbzwNa9p1AAuO8PQawhNy
         6GjPJmCpAnTqA==
X-Nifty-SrcIP: [209.85.215.179]
Received: by mail-pg1-f179.google.com with SMTP id t140so12730227pgb.13;
        Wed, 07 Apr 2021 03:54:08 -0700 (PDT)
X-Gm-Message-State: AOAM531JOiy2I9USoPy4H1GkaaaI/CBKCkTjPwxvko7aE3pW7iPQ2Van
        fNBAlmmw5Jps+VA3q46t536s89VBYpZzacESjrk=
X-Google-Smtp-Source: ABdhPJwENjk1RFkDexdOz06v/RR2+j+tqRdYw68oYExSazKnvcKp/fepcg8daUq2vXTHGwayMzbgSMqHF6Ipvgk8tME=
X-Received: by 2002:aa7:8d84:0:b029:1f8:3449:1bc6 with SMTP id
 i4-20020aa78d840000b02901f834491bc6mr2286908pfr.76.1617792847926; Wed, 07 Apr
 2021 03:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <CAMuHMdWGnr1wK3yZdLovxmVQT1yc2DR+J6FwQyCLxQS-Bp29Rw@mail.gmail.com>
 <YG1jSj7BiDscHBhz@kroah.com> <20210407080229.GF1463@shell.armlinux.org.uk>
 <YG1oQRc1ayGEI+4G@kroah.com> <20210407081436.GG1463@shell.armlinux.org.uk> <YG1vTx5XtgMeA9kX@kroah.com>
In-Reply-To: <YG1vTx5XtgMeA9kX@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 19:53:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATeAoBukc+D873b6E=Muw1scc-OWCncx5X6iXMrJjhzeQ@mail.gmail.com>
Message-ID: <CAK7LNATeAoBukc+D873b6E=Muw1scc-OWCncx5X6iXMrJjhzeQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] kbuild: unify the install.sh script usage
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Wed, Apr 7, 2021 at 5:37 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 07, 2021 at 09:14:36AM +0100, Russell King - ARM Linux admin wrote:
> > On Wed, Apr 07, 2021 at 10:07:29AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 07, 2021 at 09:02:29AM +0100, Russell King - ARM Linux admin wrote:
> > > > On Wed, Apr 07, 2021 at 09:46:18AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Wed, Apr 07, 2021 at 09:18:11AM +0200, Geert Uytterhoeven wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > Thanks for your series!
> > > > > >
> > > > > > On Wed, Apr 7, 2021 at 7:34 AM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > Almost every architecture has copied the "install.sh" script that
> > > > > > > originally came with i386, and modified it in very tiny ways.  This
> > > > > > > patch series unifies all of these scripts into one single script to
> > > > > > > allow people to understand how to correctly install a kernel, and fixes
> > > > > > > up some issues regarding trying to install a kernel to a path with
> > > > > > > spaces in it.
> > > > > > >
> > > > > > > Note that not all architectures actually seem to have any type of way to
> > > > > > > install a kernel, they must rely on external scripts or tools which
> > > > > > > feels odd as everything should be included here in the main repository.
> > > > > > > I'll work on trying to figure out the missing architecture issues
> > > > > > > afterward.
> > > > > >
> > > > > > I'll bite ;-)
> > > > > >
> > > > > > Does anyone actually use these scripts (outside of x86)?
> > > >
> > > > Yes, every time I build a kernel. My kernel build system involves
> > > > typing "kbuild <flags> <dirname> <machines...>" and the kernel gets
> > > > built in ../build/<dirname>. When the build completes, it gets
> > > > installed into ~/systems/<dirname>, tar'd up, and copied to the
> > > > destination machines, unpacked, installed as appropriate, and
> > > > the machine rebooted if requested.
> > > >
> > > > The installation step is done via the ~/bin/installkernel script.
> > >
> > > So you don't use install.sh at all except to invoke your local script.
> >
> > It depends where the kernel is being built; it has been used in the
> > past (one will notice that the arm32 version is not a direct copy of
> > the x86 version, and never was - it was modified from day 1.) It's
> > placement and naming of the files in /boot is still used today, which
> > is slightly different from the x86 version.
>
> The placement depends on the caller to the script, so that's not an
> issue here.  The name for the output does differ from x86, but the
> "common" script handles all of that (or it should, if not I messed up.)
>
> Attached below is the common scripts/install.sh that this patch series
> produces at the end of it, if you want to check to see if I missed
> anything for your arch.
>
> thanks,
>
> greg k-h



Thanks for nice cleanups!

I will give some nit-picking comments to individual patches.
Overall, this series looks nice.


-- 
Best Regards
Masahiro Yamada
