Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98BC2EBA77
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 08:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbhAFH2g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 02:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAFH2g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 02:28:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74122C061357
        for <linux-arch@vger.kernel.org>; Tue,  5 Jan 2021 23:27:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id 6so3817496ejz.5
        for <linux-arch@vger.kernel.org>; Tue, 05 Jan 2021 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGW/hKcgThQrkDmp4/Nq73y8NgwE8XDkGF7zvIldMrM=;
        b=A2KNk3AHTmJlI18STPME1Sa6t9gc1Ftvw7b31H8Vj39YjusgeaU0c1ypsqit52yWFF
         3eQGLVMgPfhF0tcCbEJmm3HsNCJ0zZ8NG3JRTyPKW7OXNUZNMMniS0bT/7ndVqBa7b3q
         FNEjNtzso2oFjWRDBWdctZ8/UBVolbVcrg/o27xs67qQd0Kl0+7v6and6KXS4zT0IDGo
         L8nHoW7UNQO5cliDlHgM3DAezmy7JMyVE7cZk2uzueStSK5Zefr34N8UH/sgVW6YOIjG
         mkROA3nUh248uHrjhIU+cLDXpa2DbIJKN7YqY8L5/rgwpwStSYsD7b1Mvy7MEYO2VlnD
         LaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGW/hKcgThQrkDmp4/Nq73y8NgwE8XDkGF7zvIldMrM=;
        b=tQceectKzpvDX2q6ZTP/ZeHQEgr8vQqTd8YdUqGo2MRkSYRwySKmLTpHQc2vNmCtIC
         2xhkXUi/Md6KcWUWCMZVEgntGcUizT3+Adh76G4YwQRMuquvn3CFudZVsdIn8qthupNI
         x139XTXSGjiakkN52apYR1L9l7+JhAtB4liRI+CE/c/+Ig5Qnbv12wmCS6iAuA8oOmGV
         fMUQJHqH8lEXgfwycDIZd8vjJVA4F1spazUhhjwew1VJ7+BVG58kXX0RF587wF0hPya1
         F9CmsB1zfTUxGbRN6WtI+oraeJIjF178fYAfKMUo4WN6ft1+/gNRjONSX/bCmd4XbJhk
         GUOQ==
X-Gm-Message-State: AOAM531gyH0VX5aC9HKRflo7A9vd89Q0INyqdozWpyb7adxRueQdq9rB
        vLDeiMnuZl7hIM+G4FZw3rC1IvQD1khQ1xOjN2o3kA==
X-Google-Smtp-Source: ABdhPJwYjz8N2N+aC7hTbxtGQy//7rOVk9vuZpXjappd1ywiMkx0G+q8sv1KN8h2TqqcyRgEkKycqJpY3pGZKSJx6nY=
X-Received: by 2002:a17:906:3a55:: with SMTP id a21mr2057000ejf.516.1609918074173;
 Tue, 05 Jan 2021 23:27:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608963094.git.syednwaris@gmail.com> <CACRpkdYZwMy5faNhUyiNnvdnMOf4ac7XWqjnf3f4jCJeE=p2Lw@mail.gmail.com>
 <CAMpxmJW46Oh2h7RrBNo5vACfYnWy63rZOO=Va=ppUDeaj5GpBg@mail.gmail.com> <20210105143921.GL4077@smile.fi.intel.com>
In-Reply-To: <20210105143921.GL4077@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 6 Jan 2021 08:27:43 +0100
Message-ID: <CAMpxmJXX5tPBvHRBkgCBK22vUc_FOo2ENUagqOF-opzakkyjrA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Introduce the for_each_set_clump macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 5, 2021 at 3:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jan 05, 2021 at 03:19:13PM +0100, Bartosz Golaszewski wrote:
> > On Sun, Dec 27, 2020 at 10:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Sat, Dec 26, 2020 at 7:41 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > >
> > > > Since this patchset primarily affects GPIO drivers, would you like
> > > > to pick it up through your GPIO tree?
> > >
> > > Actually Bartosz is handling the GPIO patches for v5.12.
> > > I tried to merge the patch series before but failed for
> > > various reasons.
>
> > My info on this is a bit outdated - didn't Linus Torvalds reject these
> > patches from Andrew Morton's PR? Or am I confusing this series with
> > something else?
>
> Linus T. told that it can be done inside GPIO realm. This version tries
> (badly in my opinion) to achieve that.
>

I'm seeing William and Arnd have some unaddressed issues with patch 1
(with using __builtin_unreachable()).

Admittedly I didn't follow the previous iterations too much so I may
miss some history behind it. Why do the first two patches go into lib
if this is supposed to be gpiolib-only?

Bartosz
