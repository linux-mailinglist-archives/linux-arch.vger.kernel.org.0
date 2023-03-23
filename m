Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F082A6C6D0E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCWQMb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 23 Mar 2023 12:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjCWQMU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 12:12:20 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5D367F6;
        Thu, 23 Mar 2023 09:11:55 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id r5so27160371qtp.4;
        Thu, 23 Mar 2023 09:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN7wbSGHFU83V/SiO8li468XdAAir/xu6GqW7yuRv6w=;
        b=3/J1MHS7YM9ZHABngSpcpKGf4caCSGkLujk/MNsPHg21yKApiqUmQdBS5ZQyE/7uZi
         sWQTizPkbjaw2VH1xbLm0/WvLDD3C6XYJX7IqvfQN+55OuxND/k4h5N67An11p8QanrM
         DPB0DMtRA41W8uJCgMz5/v0PC0GVLOyL0Ze9qROnzL9QmyZTCadiQPreaJd7luvhFy4e
         r8Ipc74m7q6WlbT1NVHciFDYf95kEwYFdQGhzC7oj4JfElaN49kH1aFv53vnJcsA/He3
         7HtekscRRYoh8vuiWUIprQzB/hEVpVJAYHJu79lmUnzgJGayFZrFpsVUldOFGm3NIAWd
         Ey/A==
X-Gm-Message-State: AO0yUKWIJs/cYC92Is25EJaEqZvSx+pDV7K9huazbwg7nQ0K5Vx0G0g2
        fc118ClESMNFAnyZRgMxCCEsfzKA4ekUPTcJ
X-Google-Smtp-Source: AK7set9JsNM6yRzTPl4EXEdJDEbhZEctXB+e+RsTGLOml9N6BB4aOLPTCxxSCqAu/CQfWfOdG+EB7w==
X-Received: by 2002:a05:622a:1a07:b0:3d5:b5cd:d35e with SMTP id f7-20020a05622a1a0700b003d5b5cdd35emr7953266qtb.23.1679587914195;
        Thu, 23 Mar 2023 09:11:54 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x14-20020ac8538e000000b003e38d6c013dsm2535822qtp.60.2023.03.23.09.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 09:11:53 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id j7so25467553ybg.4;
        Thu, 23 Mar 2023 09:11:52 -0700 (PDT)
X-Received: by 2002:a05:6902:1548:b0:b56:1f24:7e9f with SMTP id
 r8-20020a056902154800b00b561f247e9fmr2636952ybu.12.1679587911906; Thu, 23 Mar
 2023 09:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-16-schnelle@linux.ibm.com> <20230316161442.GV9667@google.com>
 <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com> <97b5a5c3-d20f-4201-8deb-1d34e7edee6c@app.fastmail.com>
In-Reply-To: <97b5a5c3-d20f-4201-8deb-1d34e7edee6c@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Mar 2023 17:11:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkV0Ls+hXUB2+2h-2+6s-h5Ufep1BfC--VT27E4Hk=Ng@mail.gmail.com>
Message-ID: <CAMuHMdWkV0Ls+hXUB2+2h-2+6s-h5Ufep1BfC--VT27E4Hk=Ng@mail.gmail.com>
Subject: Re: [PATCH v3 15/38] leds: add HAS_IOPORT dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Thu, Mar 23, 2023 at 2:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 23, 2023, at 13:42, Niklas Schnelle wrote:
> > On Thu, 2023-03-16 at 16:14 +0000, Lee Jones wrote:
> >> On Tue, 14 Mar 2023, Niklas Schnelle wrote:
> >>
> >> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> >> > not being declared. We thus need to add HAS_IOPORT as dependency for
> >> > those drivers using them.
> >> >
> >> > Acked-by: Pavel Machek <pavel@ucw.cz>
> >> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> >> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> >> > ---
> >> >  drivers/leds/Kconfig | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> Applied, thanks
> >
> > Sorry should have maybe been more clear, without patch 1 of this series
> > this won't work as the HAS_IOPORT config option is new and will be
> > missing otherwise. There's currently two options of merging this,
> > either all at once or first only patch 1 and then the additional
> > patches per subsystem until finally the last patch can remove
> > inb()/outb() and friends when HAS_IOPORT is unset.
>
> It's probably too late now to squeeze patch 1 into linux-6.3
> as a late preparation patch for the rest of the series in 6.4.
>
> It would be good if you could respin that patch separately
> anyway, so I can add it to the asm-generic tree and make
> sure we get it ready for the next merge window.

Through an immutable branch, else all dependencies have to wait
for v6.5?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
