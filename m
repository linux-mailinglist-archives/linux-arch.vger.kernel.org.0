Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B16BAF63
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCOLhO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 15 Mar 2023 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjCOLhF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:37:05 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3AE9EFB;
        Wed, 15 Mar 2023 04:36:56 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id op8so16015896qvb.11;
        Wed, 15 Mar 2023 04:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678880215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Dh9RfBVfufckGOxFsJtj6xeJ0iEcugscI3TEV8zxpY=;
        b=GfCPc69Aur30v3YKuHqrCJJojWH4ELZ0fSJuQDr86C8opMJACIw2QxEbfIIzcBAvBl
         lpV0VOPBFOFMAtGtvUSLAnJW1n76Xjb1PqCLBrwXOp9CjNLIXgf1MGwjPKUWEbgyzTH4
         dYkKFxqXvCWgtB83nuumhKv8ZHrptT7R/usDJoIUHkACEXqFqA2ndxGVNI4BjSoENb9B
         YeJbtM7O9A2wsSPWOKttKefgZOZRkBLqK1t9oKfddYwM2XJxtzNqvJF4KHkmMZWW9JMC
         MYZ5Q3qu2h9CGCY1G87+A4/6PM8LJhXARfIXl6ShdDQs0+/+OFEOCV49TQXue03BY4+F
         La5w==
X-Gm-Message-State: AO0yUKV9tmk31kXvgcjn9G+pmkw44GMo+y5EYMgGS6yQIYE71FT6dD1m
        1G99kXgBIOohbPzVvNgAzpdKGCoVYeOX/map
X-Google-Smtp-Source: AK7set9aCTesaiE+jQUrhDZiju1MXoyoItoELO1KteTsES08mTYHc1wYeW0Plup7v0eWfbbJWCOF7w==
X-Received: by 2002:a05:6214:224a:b0:56b:f061:c3c6 with SMTP id c10-20020a056214224a00b0056bf061c3c6mr26478482qvc.33.1678880215178;
        Wed, 15 Mar 2023 04:36:55 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id t202-20020a3746d3000000b0074341cb30d0sm3539878qka.62.2023.03.15.04.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 04:36:54 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-544787916d9so34713087b3.13;
        Wed, 15 Mar 2023 04:36:54 -0700 (PDT)
X-Received: by 2002:a81:ac62:0:b0:544:8bc1:a179 with SMTP id
 z34-20020a81ac62000000b005448bc1a179mr582287ywj.4.1678880213966; Wed, 15 Mar
 2023 04:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-3-schnelle@linux.ibm.com> <CAMuHMdVry2YViJ5oFgo9i+uStWbhy7mXKWdWvCX=qgAu1-_Y1w@mail.gmail.com>
 <c7315ca2-3ebf-7f3b-da64-9a74a995b0ae@opensource.wdc.com>
In-Reply-To: <c7315ca2-3ebf-7f3b-da64-9a74a995b0ae@opensource.wdc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Mar 2023 12:36:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVajEYsw8HrKw0GwV+09gbtkhjVMuKZ6RSBvq6got=jAg@mail.gmail.com>
Message-ID: <CAMuHMdVajEYsw8HrKw0GwV+09gbtkhjVMuKZ6RSBvq6got=jAg@mail.gmail.com>
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Damien,

On Wed, Mar 15, 2023 at 10:12 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> On 3/15/23 17:39, Geert Uytterhoeven wrote:
> > On Tue, Mar 14, 2023 at 1:12 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> >> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> >> not being declared. We thus need to add HAS_IOPORT as dependency for
> >> those drivers using them.
> >>
> >> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> >> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/ata/Kconfig
> >> +++ b/drivers/ata/Kconfig
> >> @@ -342,6 +342,7 @@ endif # HAS_DMA
> >>
> >>  config ATA_SFF
> >>         bool "ATA SFF support (for legacy IDE and PATA)"
> >> +       depends on HAS_IOPORT
> >>         default y
> >>         help
> >>           This option adds support for ATA controllers with SFF
> >
> > ATA_SFF is a dependency for lots of (S)ATA drivers.
> > (at least) The following don't use I/O port access:
> >
> >     CONFIG_SATA_RCAR (arm/arm64)
> >     CONFIG_PATA_FALCON (m68k/atari and m68k/q40)
> >     CONFIG_PATA_GAYLE (m68k/amiga)
> >     CONFIG_PATA_BUDDHA (m68k/amiga)
> >
> > (at least) The following can use either MMIO or I/O port accesses:
> >
> >     CONFIG_PATA_PLATFORM (m68k/mac)
>
> But for these arch/platforms, would there be any reason to not have HAS_IOPORT ?
> It is supported right now, so we should have HAS_IOPORT for them.

That's the point: on Amiga and Atari, HAS_IOPORT is optional, and
not related to IDE support. On Mac, it is never present.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
