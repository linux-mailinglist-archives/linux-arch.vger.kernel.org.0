Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7326FCA5
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRMgm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 08:36:42 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRMgl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 08:36:41 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MHnZQ-1kEI5W0sgo-00EwgF; Fri, 18 Sep 2020 14:36:40 +0200
Received: by mail-qt1-f174.google.com with SMTP id c18so4778666qtw.5;
        Fri, 18 Sep 2020 05:36:39 -0700 (PDT)
X-Gm-Message-State: AOAM531P0vWhxtgLTyK/ASRNZLNtY2deNYX1PrkvlZCh/JM48cL9Dvn6
        T18/2j/SPvdHteGseUUOwrA0KNaOt5vmJGNzI50=
X-Google-Smtp-Source: ABdhPJzHuJZ/kDocyLlLrnh1ExNrKpMLkiEpPLdi9PahWckRQnAPVIMevhGijaQB/J930L15teODRXzI8m5Cr7Nw24M=
X-Received: by 2002:aed:2ce5:: with SMTP id g92mr19928608qtd.204.1600432598903;
 Fri, 18 Sep 2020 05:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-3-arnd@arndb.de>
 <20200908061528.GB13930@lst.de> <CAK8P3a22EiD-uMZQaBpHQYyy=MJ_7J-ih=6CtgH_9RXT6OOYvg@mail.gmail.com>
 <20200918074203.GU1551@shell.armlinux.org.uk>
In-Reply-To: <20200918074203.GU1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Sep 2020 14:36:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0HhfcM+bovy2pA4omhC5w6POqvf2Yx61_hQSwika2AEA@mail.gmail.com>
Message-ID: <CAK8P3a0HhfcM+bovy2pA4omhC5w6POqvf2Yx61_hQSwika2AEA@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: traps: use get_kernel_nofault instead of set_fs()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux- <kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uQ1rd98AYHFYnsPXe5sEe/Tx2b86dN9VTdMt61Zxci4xR1f6u9Q
 Jc23I9AKuaf4UPWMeRYcxl0y/tYsKix6NuDCa1AJsfZpOD0PCpSow/tBshCWbiIFTN9yGH7
 7qxsVPFnmaCs1Cf4cDvIk0Cb0CFCNeQWP2S27bXdNG4xvlQLRYPDfj/6YC2Dxu/bNOA3kXk
 vNDDT7JNV3birPxddl8KQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tPEtwy/3JPA=:EazmA3FpyPiDwBxPKg+o3Z
 JesvTBW0cDHRKN0QRoNwGwxkwA8EhckldC2H6hUH12TEH/mkTXBoEur1LIWWmjL1+iaJeAfVx
 mFSt9UE8nZoC9ocVSOJD88GyNbPUPJ0VZCSaRP76v3w/3EB95HCaWeLmW3+IBtm7NonCL8+qK
 e95OeX0c2JB47/Pkw704dF5g8vwH/MwuCh5it/MDoiGHBInauCMeW9EAkH5LUI4z8wj3AvsxG
 zxyzri8LI/LpejNNc9DYBHJeuauNVnHsjEkYX82pbB2RQqNqbQGaLns0IzCVr8OBhq/OpyInD
 dVIoH52N+wC8G5JGHxGbu/RwK3hVRCU5fS0tUAR86ULsF/jQAeD5PBIIc/M7qycmW2PHUIFgA
 VRJczQ9WiS0AmhYSwJ9Ox67HdjiC6Hh7XPxTgAxED1VqX2ytDdJ8DkLMmm25iN5YddIkkhj/y
 zmMsfhFb0G64V5Z9nQ0hGxeiuIVlu6A4RTmJYTpT5njc6LWJUXae8wMF0AbClZFO4XFQs7dCc
 BNYqWikmJ/w7gGO6VlWQFiNXTPv7Sa3Lk6lA2cQTtJiTgdpS8P0WnZ8LrPc9E2+xASr/Npuya
 smsRCLxqdynTNS7kWwnQFF3/1vl55GzkI8aCZj3bIqYVKriUVckPlVnln6K2WKuGnq29L0ZEt
 7MXWgLiIxtwdkk0WAIJdr/3lhwv67UtlYnR14bM+pyixV/21LPrEmgc+Xi9b47qPQD8IfKZMM
 eyDFWiFRRTqEQzhJ+uT4P1UGVwD4avKaPDUeuRdg5wWRZ9FVQ89Y+WKdK5R3ys0oR7zXyhJcx
 vjcMJpoQJK79Ab/i7yh5VWJJhrQS2hgcMlvttXrGKb+nwZPTdKlCEBWNvP7PTjyx+OlCc86
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 9:42 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Sep 17, 2020 at 07:29:37PM +0200, Arnd Bergmann wrote:
> > On Tue, Sep 8, 2020 at 8:15 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > I looked through the history now and the only code path I could
> > find that would arrive here this way is from bad_mode(), indicating
> > that there is probably a hardware bug or the contents of *regs are
> > corrupted.
>
> Yes, that's correct.  It isn't something entirely theoretical, although
> we never see it now, it used to happen in the distant past due to saved
> regs corruption.  If bad_mode() ever gets called, all bets are off and
> we're irrecoverably crashing.
>
> Note that in that case, while user_mode(regs) may return true or false,
> regs->ARM_sp and regs->ARM_lr are always the SVC mode stack and return
> address after regs has been stacked, and not the expected values for
> the parent context (which we have most likely long since destroyed.)

Ok, I have rewritten the patch and my changelog text accordingly, sending
an updated version now.

Thanks,

      Arnd
