Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDF53F737
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbiFGHaT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 03:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbiFGH37 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 03:29:59 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C589753E33;
        Tue,  7 Jun 2022 00:29:52 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id hf10so12032907qtb.7;
        Tue, 07 Jun 2022 00:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vvSp91df5DXi30Fd3pExmyOkjiZTMAg5zYSvB9bVbM=;
        b=eiLVg12zzPiX72BjdOPhRaANtE+XgsbxcszNXFToB/g+H0ddcx5Kv7z31zVrPMQvC5
         34JoXFomujkj3W7R19Z68M8H8ykwBW5rwf7MOPq5LBKmKw7woSlay3VbOGD5VDDlNOnJ
         GCj3cG97x7xbZ9nMftvX6Oca2yeFk85W1AGH1nPTLTZr7UycofpqYMzKaurrE14YVaB8
         rJ8RycPKTxyZjGnkNiMbPIHFXFn9yrbUNctajckt780aBp0xgdmGGUGJoAmLTeeD6g18
         w7DiyzfUwBNMAtmYGEw9jwoF/OTI+KeBJrlUkMBX+rpt3xMOzvTRe6j5vf0rTc4CvQ7m
         3m3g==
X-Gm-Message-State: AOAM531hkkBCDypBgorofVpvwAgqmZEEAuXldx40jzwuvr0F5wSAKH6R
        4mY1FW8bQpe3kqjTfIePlvjR08JyKZRvCQ==
X-Google-Smtp-Source: ABdhPJy6/LxYiJvYw6lGXpLiwInrJxNS2/wS/j/jDf1hCzWVUK1aU4p+sy/+LTZGnAZILTzM8KYJ+g==
X-Received: by 2002:a05:622a:1903:b0:2f3:ddac:436d with SMTP id w3-20020a05622a190300b002f3ddac436dmr20876961qtc.25.1654586990718;
        Tue, 07 Jun 2022 00:29:50 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006a6a6f148e6sm8902896qkl.17.2022.06.07.00.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 00:29:50 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id e184so29684808ybf.8;
        Tue, 07 Jun 2022 00:29:49 -0700 (PDT)
X-Received: by 2002:a25:7307:0:b0:65c:b98a:f592 with SMTP id
 o7-20020a257307000000b0065cb98af592mr28407064ybc.380.1654586989616; Tue, 07
 Jun 2022 00:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org> <20220606084109.4108188-7-arnd@kernel.org>
In-Reply-To: <20220606084109.4108188-7-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Jun 2022 09:29:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXi2LkrWSs9=D9tSfhz+YDHB+638F6JdmgQ7V8Gj1ehqQ@mail.gmail.com>
Message-ID: <CAMuHMdXi2LkrWSs9=D9tSfhz+YDHB+638F6JdmgQ7V8Gj1ehqQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] arch/*/: remove CONFIG_VIRT_TO_BUS
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 6, 2022 at 11:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All architecture-independent users of virt_to_bus() and bus_to_virt()
> have been fixed to use the dma mapping interfaces or have been
> removed now.  This means the definitions on most architectures, and the
> CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
>
> The only exceptions to this are a few network and scsi drivers for m68k
> Amiga and VME machines and ppc32 Macintosh. These drivers work correctly
> with the old interfaces and are probably not worth changing.
>
> On alpha and parisc, virt_to_bus() were still used in asm/floppy.h.
> alpha can use isa_virt_to_bus() like x86 does, and parisc can just
> open-code the virt_to_phys() here, as this is architecture specific
> code.
>
> I tried updating the bus-virt-phys-mapping.rst documentation, which
> started as an email from Linus to explain some details of the Linux-2.0
> driver interfaces. The bits about virt_to_bus() were declared obsolete
> backin 2000, and the rest is not all that relevant any more, so in the
> end I just decided to remove the file completely.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/Kconfig                             |   1 -
>  arch/m68k/include/asm/virtconvert.h           |   4 +-

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
