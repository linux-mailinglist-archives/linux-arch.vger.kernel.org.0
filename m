Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F786B97DA
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 15:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCNOYj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 14 Mar 2023 10:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCNOYi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 10:24:38 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169CBD32F;
        Tue, 14 Mar 2023 07:24:07 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id x33so4755118uaf.12;
        Tue, 14 Mar 2023 07:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678803795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHk/e8nmrChnVOh0v2KNpG9SPtXK48kelECMBXBBkqg=;
        b=ohOyp7N9eAMOPS1ECS0RikSqJLkGMixztwHS1SYLIkXkTS6DoJedVTRV5mPsBNNi7G
         RQizATru5UOMJ758yyKfrXDKb1fuSnqAwntDO9q1rrR84gSxK5ZBK+BWoLQapPer+HXL
         vJDB+c2ZlnDgbQ3XF1poOgINUf1wVYeKAxwiQ1B07K+dSNH1lwlo4fes0AaqlAmLdjh/
         EHqRXmySC/9hFzhYVuhcIkNGIlQqnzN0BCsFfnJwaJR57aVSEh22WwxWqpPitmipcabD
         QYd9dV2mnC0OmZAbBd7+fIO96yp2WPSxnUAAsAIaKi4qUtXfQC/3LVB2xjwh6TdDoYbh
         vr0w==
X-Gm-Message-State: AO0yUKVCJrh4J3Ye8id7Nwby6q+qOZIFMge00EG6MlvwI+lNUjhQqBaK
        4vVhNa92KC9IpS4DAz4XsM2XvbwPnK66LA==
X-Google-Smtp-Source: AK7set/Ow8ABEmeiqCUpzJDllW4qWq8ZVakyvIFFE3NsuTRp/qBQDbMedOpOD1K+DkRqhazcxraO0g==
X-Received: by 2002:a1f:ab08:0:b0:432:2c6f:f246 with SMTP id u8-20020a1fab08000000b004322c6ff246mr1831026vke.3.1678803795152;
        Tue, 14 Mar 2023 07:23:15 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 10-20020a1f110a000000b004320e55b10csm375434vkr.39.2023.03.14.07.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 07:23:15 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id e19so7917915vsu.4;
        Tue, 14 Mar 2023 07:23:15 -0700 (PDT)
X-Received: by 2002:a05:6902:145:b0:ac2:a7a7:23c3 with SMTP id
 p5-20020a056902014500b00ac2a7a723c3mr17221159ybh.12.1678803452128; Tue, 14
 Mar 2023 07:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com> <20230314121216.413434-4-schnelle@linux.ibm.com>
In-Reply-To: <20230314121216.413434-4-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Mar 2023 15:17:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXapUNn2-_+WWULq1ELLJEzVgJ7CZ-OJpbTSy-=JjZVA@mail.gmail.com>
Message-ID: <CAMuHMdXXapUNn2-_+WWULq1ELLJEzVgJ7CZ-OJpbTSy-=JjZVA@mail.gmail.com>
Subject: Re: [PATCH v3 03/38] char: impi, tpm: depend on HAS_IOPORT
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
        openipmi-developer@lists.sourceforge.net,
        linux-integrity@vger.kernel.org
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

Hi Niklas,

On Tue, Mar 14, 2023 at 1:12 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add this dependency and ifdef
> sections of code using inb()/outb() as alternative access methods.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch!

> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -34,6 +34,7 @@ config TTY_PRINTK_LEVEL
>  config PRINTER
>         tristate "Parallel printer support"
>         depends on PARPORT
> +       depends on HAS_IOPORT

This looks wrong to me.
drivers/char/lp.c uses the parport API, no direct I/O port access.

>         help
>           If you intend to attach a printer to the parallel port of your Linux
>           box (as opposed to using a serial printer; if the connector at the

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
