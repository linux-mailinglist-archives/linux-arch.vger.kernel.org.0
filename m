Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07172746B91
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 10:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjGDIKK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 4 Jul 2023 04:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjGDIKH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 04:10:07 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0E11AB;
        Tue,  4 Jul 2023 01:10:03 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-c5ce57836b8so522648276.1;
        Tue, 04 Jul 2023 01:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688458202; x=1691050202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZaghZGIezMc1/PkmeAtxZOh9fnJXXLlPyB7qIylXMg=;
        b=Z1ixxmIhB0U1L1L3bzXFXtdQ1KCUGV+6qKIFBQEtfhB5aKrJP0UbNk5Car7KRuLOf3
         9Ffseu65MbFkjyJGQDqJ5W/BeXUTxd3e1FGjrjrz0A5gOp1HDulwmQuwCL3jRD+dI4Fq
         NsG7j64TZCCWXPcGeulrwP1bDee1FaSVggrF3z84SvlA+oGZSPkfF01rljcNnsQmq+r/
         0vB8cRwpGmy9QIDYtH/7TcbVLWQ/Icsa6VKk23vlcTYTci40yjT8Nr7L7fhmbA59D0zj
         sxyZO8nLhCXmAtkBkxxi9YEILWIcAA2iKdq+0Ah0bRLQLvIH01gaWT4ZwQtvuNG4vEUd
         B4cQ==
X-Gm-Message-State: ABy/qLaUc60jZSRrvieT4r5hWTw3GVuM4IA9Ce2s3Wnvgwj/eJXvVyyu
        p04KIbcvuGScck37FVHCRdwCFg/wyU23TQ==
X-Google-Smtp-Source: APBJJlGoN3ZvP01aca/ywxaZlXZSm8xv9annihVBORAZo/QcThiji0GcCL0m9PNHVHTU6KrcTdZn5g==
X-Received: by 2002:a25:d10:0:b0:c5d:f2af:5a24 with SMTP id 16-20020a250d10000000b00c5df2af5a24mr791407ybn.14.1688458202598;
        Tue, 04 Jul 2023 01:10:02 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id i1-20020a25b201000000b00c4788bfe468sm1761021ybj.1.2023.07.04.01.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 01:10:01 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-c5ce57836b8so522612276.1;
        Tue, 04 Jul 2023 01:10:01 -0700 (PDT)
X-Received: by 2002:a25:ad18:0:b0:c12:179f:b78e with SMTP id
 y24-20020a25ad18000000b00c12179fb78emr11890369ybi.28.1688458200854; Tue, 04
 Jul 2023 01:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230522105049.1467313-1-schnelle@linux.ibm.com> <20230522105049.1467313-4-schnelle@linux.ibm.com>
In-Reply-To: <20230522105049.1467313-4-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 10:09:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBgh8NTBmZkqoR+ZZM=C=bREVM1KCk4xNC-4BWjSAHOw@mail.gmail.com>
Message-ID: <CAMuHMdXBgh8NTBmZkqoR+ZZM=C=bREVM1KCk4xNC-4BWjSAHOw@mail.gmail.com>
Subject: Re: [PATCH v5 03/44] char: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        linux-m68k <linux-m68k@lists.linux-m68k.org>
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

Thanks for your patch, which is now commit 1fbb0b203574bb16 ("char:
add HAS_IOPORT dependencies") upstream.

> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig

> @@ -340,7 +341,7 @@ config NVRAM
>
>  config DEVPORT
>         bool "/dev/port character device"
> -       depends on ISA || PCI
> +       depends on HAS_IOPORT
>         default y
>         help
>           Say Y here if you want to support the /dev/port device. The /dev/port

FTR, this change makes DEVPORT show up on Atari with ATARI_ROM_ISA=y.
I guess it doesn't matter much, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
