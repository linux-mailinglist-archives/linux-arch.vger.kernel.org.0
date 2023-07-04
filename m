Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7927F746B7D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 10:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjGDIHD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 4 Jul 2023 04:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGDIHA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 04:07:00 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1A4E59;
        Tue,  4 Jul 2023 01:06:59 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5728df0a7d9so66371597b3.1;
        Tue, 04 Jul 2023 01:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688458018; x=1691050018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69rbrhXB4oWUM7pAO59rDdo5f0XmrS1v1x4eD2FmWm4=;
        b=KCmmjc3CHaoaRBp/bGL9KQ2ITgrjyRHOqUmAcoeVWjbCH0Qahf5oFBq1K3HxIJcuDT
         qiKZU5DaV02g8e1676A4xmwpFQFjRp2/704Cxv2kHktLQ+BdJIjcD1vxQQ5kC6Wa219p
         ZZfbeWWQUPb9WG0ktLIkoH2v6c6cvWvTB+47S+XbURTIVUf0/nymij7BSWxq4poB0tFl
         EG/ww9b8VhWms7v1l1VN5CPczJpZjyNsQMjoGwPknWXf0MdcvXeK2FUS03HUQse5Hjz9
         WqU8a+cKpspQqnD2AHi/cAF/b3/JE6xyVl2fDuMRJ82NKd2X3fwE1nj9sTxsoR7qU7I0
         nZEQ==
X-Gm-Message-State: ABy/qLYGmzsL+hwjX3xVJYdwprssYMFrDXmIggcD37VyJpvKtMmDC2yo
        DtlvhIE8FEbOy7n3TUcOl+GUJ4fIa0wozw==
X-Google-Smtp-Source: APBJJlGxmg6GiLNGGzmZ8z7ANYYhRXI3vGLSx4smTWQWmnxUW28QZH4iuzYbBVR3WPtmcjj8ISuBNg==
X-Received: by 2002:a0d:d545:0:b0:57a:fb9:73c2 with SMTP id x66-20020a0dd545000000b0057a0fb973c2mr3087077ywd.27.1688458018589;
        Tue, 04 Jul 2023 01:06:58 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id t201-20020a8183d2000000b005731dbd4928sm5456450ywf.69.2023.07.04.01.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 01:06:57 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-c5e67d75e0cso210032276.2;
        Tue, 04 Jul 2023 01:06:57 -0700 (PDT)
X-Received: by 2002:a5b:d4c:0:b0:bd5:ddcd:bc9e with SMTP id
 f12-20020a5b0d4c000000b00bd5ddcdbc9emr11705615ybr.17.1688458017342; Tue, 04
 Jul 2023 01:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230522105049.1467313-1-schnelle@linux.ibm.com> <20230522105049.1467313-31-schnelle@linux.ibm.com>
In-Reply-To: <20230522105049.1467313-31-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 10:06:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAkRB9z2cqq6XBDKi-8zLyKxdw_PaT_TwLj78S5B6J8g@mail.gmail.com>
Message-ID: <CAMuHMdUAkRB9z2cqq6XBDKi-8zLyKxdw_PaT_TwLj78S5B6J8g@mail.gmail.com>
Subject: Re: [PATCH v5 30/44] rtc: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On Mon, May 22, 2023 at 12:51 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch, which is now commit 8bb12adb214b2d7c ("rtc:
add HAS_IOPORT dependencies") upstream.

> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1193,7 +1195,7 @@ config RTC_DRV_MSM6242
>
>  config RTC_DRV_BQ4802
>         tristate "TI BQ4802"
> -       depends on HAS_IOMEM
> +       depends on HAS_IOMEM && HAS_IOPORT
>         help
>           If you say Y here you will get support for the TI
>           BQ4802 RTC chip.

This driver can use either iomem or ioport.
By adding a dependency on HAS_IOPORT, it can no longer be used
on platforms that provide HAS_IOMEM only.

Probably the driver should be refactored to make it use only
the accessors that are available.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
