Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0D25FC75
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgIGO7j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 10:59:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbgIGO7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 10:59:30 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MvbJw-1kVJnJ0F6M-00sd6v; Mon, 07 Sep 2020 16:59:15 +0200
Received: by mail-qv1-f41.google.com with SMTP id cv8so6437570qvb.12;
        Mon, 07 Sep 2020 07:59:14 -0700 (PDT)
X-Gm-Message-State: AOAM5303Aw8zwrEiN6wbMgq60Z+UeFPpXVnEnxjwC3H+IYLa0laaBb4l
        lGnj8zQ9Yq0PhnZzsiUnN3iL7bfE6j3nEbI0mEQ=
X-Google-Smtp-Source: ABdhPJxK1PtMWzEME0I00NTfpJLnk7HuwRPMEDH7xtuIg967ceNyZJazvdlwZ8DAo/8dECMPk3V86IWyRilTpXPzPg8=
X-Received: by 2002:a0c:e892:: with SMTP id b18mr18804075qvo.4.1599490753860;
 Mon, 07 Sep 2020 07:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200904165216.1799796-1-hch@lst.de> <CAK8P3a3t8a0gD2HsoPsMi7whtNb7BdzPN6-oo6ABnqkbQJoBfA@mail.gmail.com>
 <20200905071735.GB13228@lst.de> <CAK8P3a3BN-Afy4Gj+mGjxiKODUBZwjh+XRbXqQKV-uEhyhOTfA@mail.gmail.com>
 <20200907060356.GA18655@lst.de>
In-Reply-To: <20200907060356.GA18655@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Sep 2020 16:58:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a22X84VVX=WwrQoqgThuhs55P9z+rYoG=kzbJCmJLJb8Q@mail.gmail.com>
Message-ID: <CAK8P3a22X84VVX=WwrQoqgThuhs55P9z+rYoG=kzbJCmJLJb8Q@mail.gmail.com>
Subject: Re: remove set_fs for riscv
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MpHuRRnIlDGyisIWkrrnggB7EpmlguB++P2XWvEgZlq2hPXhw6x
 09V150d9+qUN0RxMK9BSU+WHRO7+lqM5tfYBCPlpk2GrJANFlWkmgCnqmukvdshsd6mov0O
 Rv6/wAXn5FspfePeEBrFP0x0j0skVvsKJ7sLQlUN6flhNaVEpwr0OV7HTiNS2uj1AF1dXSc
 zK4/yUJH1SXunzztqKK7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jHRPJ+HvdNs=:7ERbVbdo3nq5sJDNMrnkOi
 JLgHJzh2QwS4SeejvpFJr3ItdRGmsG60XtoybqFMiLtPsHpL+IeTHA1A0tbUEDKjbO4LdeFOe
 MBHgKFSokPxUzTcS3YZYE1eOslPU/v3Rwf/SqvV86LQHZvr8pGgQtkQOabjujrTnAppaP9vc+
 6Mjx5FnMjkikknIRtNe1G/B//pq+or1G114RGm27YAbxd5PM71UZtV5hbRCp7+Hp5PtZD39vg
 RTws6TNEgdQEVQnaJRtpsQoxQ6kQ5ild4sEradrBbD/kzsdXqpqUss9sqfaeqFFfFlYHlkwmU
 cTITBo861lojJ/Xfa6rGBwnkj2mQR3EmIs42Bf16o+yG4OwQzQdHqs8b44bsmbztKhOS80AET
 q3HRoGJT8irpx+sDQer+OjtN8/ZkuD8Ve8q/v8DWDauwuBMwWuYkzyn9XV4WPqk+/sEPEW0fK
 NM81snU9zIWM5z6L5Aj0YEOs1SNedrNFEB2LaBbuREyJkuIR1SEZHenRkUk6PgbCx9bnplEih
 ofct3xo8jEvN/e7kLClBLcTdqHIQNSlKCvaXcZ7sCgh9H4UnyQlC4inPoWLFm8+AtohtSw3i1
 rsrHhwahOrJd0RlJ0F70z0GQyn+iwX0sjSPEGKpBXF/z1Qzcuk4Xbo1IzKVZGjqSplZ4t5o80
 CaGPAph8hTL6tGiCIJWjqSr9yuvgbQjChAUct0Dtjso52NfVGLE7/S1r9Jt1nUeggpywh6+qk
 LoM9hmSUnLn72ILAiV/uTCvUx293ypmiUxG0v40IlvaYrpVECa+5OBOzv1ORgAvLpbCGjXYxS
 FHmINsXUChXOO9HxZ0jcI28RNPgt5OAr9x79th5uzMZOSi/zWzb76eRFXpkJ7zBtAM1zm4pU5
 jFItJnY+cVzkT3U5pcZakjOA1owQ/D6yvNQWxIoDwH/wWcBw5NdtXLBmpklQo3bvExvqXG8oq
 ckmpoo70uZnUv7BZMoIp+eAPO76+0pm4yNXQlijssXYfdBq0Z+kaN
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 7, 2020 at 8:03 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Sep 07, 2020 at 12:14:59AM +0200, Arnd Bergmann wrote:
> > I've had a first pass at this now, see
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=arm-kill-set_fs
> >
> > There are a couple of things in there that ended up uglier than I was
> > hoping for, and it's completely untested beyond compilation. Is this
> > roughly what you had in mind? I can do some testing then and post
> > it to the Arm mailing list.
>
> Looks sensible.  The OABI hacks a are a little ugly, but so would be
> every other alternative.

Ok, thanks for taking a look. I've now managed to run the patched
kernel with OABI user space and tested the modified syscalls with
LTP. The 0-day bot found a regression that I have fixed.

I'll send out the series for review next.

> Note that you don't need to add a TASK_SIZE_MAX definition to arm if you
> base it on my series as that provides a default one.

I've rebased on that patch now and taken out those definitions.

> I also think with these changes arm/nommu should be able to use
> UACCESS_MEMCPY.

Probably yes, but I'd leave the current version for now. The Arm
implementation already supports combinations of range check
and domain settings, with the NOMMU targets using neither, but
sharing the same implementation as the others.

      Arnd
