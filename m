Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C47542A30
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiFHJBY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiFHJBI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 05:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED11C39181A;
        Wed,  8 Jun 2022 01:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C170615CE;
        Wed,  8 Jun 2022 08:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C275FC341C8;
        Wed,  8 Jun 2022 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654676402;
        bh=rDMX5BalcedoM4G0RTFNbUxPOQoghsgu/8OBAke+GR0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W/h6WxvlBEsPXQ7LLxZr5QO/u8vafOvVrOKwRNodyKrcwdtYx8uewJ8cCA65YcEMg
         alacQ3aEaCFnYucv14vBpxrln7eE0w+IUl9Ml0Q/7LYCRVNvGSHDuVNBRGtIoi0BHD
         Qr5ufM1dsDnPItR2irIQVGVoxerv51UkVHYmpLW+0WsyY7wVvJ+J6YNWoxtfegtWYz
         FamoyOjC7VQXl4xIUHow5CF1p1P7Wxh0bzVc5DDARXrzB/D9DtH7DJLq2uy7QMFIxO
         8gV+qq78/NW5yn20jf56zStPrE0wosJLKD6MRBsnwDN5kNQhLX1HrDNepJvQufi2cH
         3p2+fMos1M1jw==
Received: by mail-yb1-f178.google.com with SMTP id i39so7216895ybj.9;
        Wed, 08 Jun 2022 01:20:02 -0700 (PDT)
X-Gm-Message-State: AOAM531wI2heu6yNv41f62rWPN0YV807Sr2dgw09++hKPk0eJygCQpXX
        b1xqkxMlmKdXFI6c/C1frVIZfl6a5q9NAIsFztg=
X-Google-Smtp-Source: ABdhPJw5adnNWBE7ztmmPDIsnyIjJmMrgIr8fa8e/0DIxEnxDLg4p0rx65KL8vLCz2hbQ8e4xmPnl5Ru880ilknwmmg=
X-Received: by 2002:a25:d6d7:0:b0:663:efa3:3fd2 with SMTP id
 n206-20020a25d6d7000000b00663efa33fd2mr4459955ybg.480.1654676401784; Wed, 08
 Jun 2022 01:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org> <20220606084109.4108188-6-arnd@kernel.org>
 <d39fc9bb-07c1-ad74-1e89-d2aa80578cd4@gonehiking.org>
In-Reply-To: <d39fc9bb-07c1-ad74-1e89-d2aa80578cd4@gonehiking.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 8 Jun 2022 10:19:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3dfTNS4m-SVa1UH+ncT7ZOcMBRaEc7TiO9R19J3KNSxg@mail.gmail.com>
Message-ID: <CAK8P3a3dfTNS4m-SVa1UH+ncT7ZOcMBRaEc7TiO9R19J3KNSxg@mail.gmail.com>
Subject: Re: [PATCH 5/6] scsi: remove stale BusLogic driver
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 6, 2022 at 6:35 PM Khalid Aziz <khalid@gonehiking.org> wrote:
> On 6/6/22 02:41, Arnd Bergmann wrote: From: Arnd Bergmann<arnd@arndb.de>
>
> I would say no to removing BusLogic driver. Virtualbox is another
> consumer of this driver. This driver is very old but I would rather fix
> the issues than remove it until we do not have any users.

Maciej already offered to help fix the driver, so I think it will be ok.

On the other hand, it sounds like VirtualBox users should not actually try to
use the BusLogic driver with modern Linux guests. From what I can tell
from the documentation [1], VirtualBox only provides this emulation because it
was shipped with early versions of VMware and is supported by Windows 2000
and earlier, but not actually on any modern Windows guest. The VMware
documentation in turn explicitly says that BusLogic does not work with 64-bit
guests [2], presumably this applies to both Windows and Linux guests.

        Arnd

[1] https://www.virtualbox.org/manual/ch05.html#harddiskcontrollers
[2] https://kb.vmware.com/s/article/2010470
