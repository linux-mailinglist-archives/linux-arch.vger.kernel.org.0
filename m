Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8258D3CB7AD
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbhGPNHQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jul 2021 09:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbhGPNHK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2021 09:07:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB46BC06175F
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 06:04:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ca14so12938790edb.2
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3EFuCzIh+SeYBpu5UbN36zCvdsMMMavFs1jTakKetLg=;
        b=ZBXdVovlUDWINuH3DenX3yyikHJDRDr2XC5in3PvcE/lwDz61zADYJvdyMUF81uMM6
         XXbcSnjd4cAuovnUKeTRhuLnTGBeV+3C1LcTnX7G2y5kQhmoAQxNnywDdbAL1NXKhVEV
         tcn92roRGng/i79mMnA5uSiT8iQ3UWR6q2CRSTj59A7OzhhwVdyrLXrFPuP2i+EzUap2
         vtsh+A9s1FWLrzYzpRAlaof+1YGrboe85JIclqPon69R9psy5WHKQ89b8FvEk2AR9t7a
         28OTWr6cxiUP23tLSHX9hSN/nEQnGoAkGRQWRp4uL2NyqmsNEEdEGC1Y/MQBFrt1Rb+l
         rRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EFuCzIh+SeYBpu5UbN36zCvdsMMMavFs1jTakKetLg=;
        b=Tq78/FdfCrlqsXc/HTADJxG7ekMV4PMo1TmVlOpUSsgYToDmvvcZGIV/DPniDvBZMf
         GClv8ZN78ts6PHWHtFB5Ne1u+3uAJLML+gYlUF2Y7ITKXWnxJTeSBCw+lpbVKyHlGKwF
         h3ZRJ9iZo6ILhqQ1DRXIV0nJSE1pczUoYG1xFbX6Dm5hOyyTzAP/dI4GCq6k4iBotyVg
         ahiKDqpsJMZZt8JMrbY8RtlsUV45S01ppURncmdjRKqp36AyPkkWlTuWOEjAEec5Dj0R
         lz9VqNk2Lq2t7rRpb6g1t/W+g/iekO3XpB99iBCzJMKE61sF8mpduU80/tuK/ICuAis6
         pqvQ==
X-Gm-Message-State: AOAM530j6OcmdK9spEZyB34yN/kmi7meubCE8rjtz36EUf9HB5VOkRTz
        l51sPmEhjgqoRUAQn1BPZWIco8DDDgbPMjd/IqAOuQ==
X-Google-Smtp-Source: ABdhPJwF2Vd4OfydUmikO1TlQyiVvg2oS4gN+IeEt5NyFgOSmf6VbmP1pv5jgrwgpt/3hNuw0iZgnsBVM/vCmRXOk+w=
X-Received: by 2002:aa7:d2ca:: with SMTP id k10mr15018511edr.379.1626440653392;
 Fri, 16 Jul 2021 06:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <YO3txvw87MjKfdpq@localhost.localdomain> <YO8ioz4sHwcUAkdt@localhost.localdomain>
 <CADYN=9+ZO1XHu2YZYy7s+6_qAh1obi2wk+d4A3vKmxtkoNvQLg@mail.gmail.com> <YPFa/tIF38eTJt1B@localhost.localdomain>
In-Reply-To: <YPFa/tIF38eTJt1B@localhost.localdomain>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 16 Jul 2021 15:04:01 +0200
Message-ID: <CADYN=9LVpCYc48sY63372EyfA9sepKj=LmwfOwyLqo=V45Uq=Q@mail.gmail.com>
Subject: Re: [PATCH v2] Decouple build from userspace headers
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, hch@infradead.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 16 Jul 2021 at 12:10, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Fri, Jul 16, 2021 at 11:03:41AM +0200, Anders Roxell wrote:
> > On Wed, 14 Jul 2021 at 19:45, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
>
> > In file included from
> > /home/anders/src/kernel/testing/crypto/aegis128-neon-inner.c:7:
> > /home/anders/src/kernel/testing/arch/arm64/include/asm/neon-intrinsics.h:33:10:
> > fatal error: arm_neon.h: No such file or directory
> >    33 | #include <arm_neon.h>
> >       |          ^~~~~~~~~~~~
>
> > If I revert this patch I can build it.
>
> Please, see followup fixes or grab new -mm.
> https://lore.kernel.org/lkml/YO8ioz4sHwcUAkdt@localhost.localdomain/

I tried to apply that patch but I got the same build error.

Cheers,
Anders
