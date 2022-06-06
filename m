Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89F453EC54
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiFFPCF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 11:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbiFFPCF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 11:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C660644E9;
        Mon,  6 Jun 2022 08:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B020C614BF;
        Mon,  6 Jun 2022 15:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D169C3411F;
        Mon,  6 Jun 2022 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654527722;
        bh=q53e8R7rif+9VorkencnO96O5zseGyAcQ5tiTh4wb5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Apz8+ZKOfRfLg28N7czbQCp5u1APChOU6nUGQX9FaMmYF1sAaX/E+Ib6PkoNMTzP7
         8jDO0yt1/l7zDqKQc6tX4/clq/6HkX/3W3KZ8nM3wihQ+jMlDOK9ZA4eyqtiXknfW8
         nDehGJBGcME9NWhLnKjuKwi1RHsvWVfiUTSGjzwMBXLmNypEOY8dRiUMaB2ZPKhMqN
         +sCEMynb2DFl+FqYA+WAgVaik3iEnEQyHuNJCcowrCU57ufs9pWJIioY3E4DJJPNzW
         kpZWUqqFJEO2bKuHGgUG6lR6HDAoCyo7pL/NzPacNwyF3UCEA3Cxsbw6IvBn5Rr2+E
         lkYasSc/0weOA==
Received: by mail-yb1-f180.google.com with SMTP id a64so26124912ybg.11;
        Mon, 06 Jun 2022 08:02:02 -0700 (PDT)
X-Gm-Message-State: AOAM532H7slSnILqDUuT68S0daa3jaBXMJTfMmCiLc97ck0ID3SMi7Im
        ROIBG7R+um0wGCbY179Wlh+pDKh738zc5oi623U=
X-Google-Smtp-Source: ABdhPJzbUSlIedBRNZiWpM9ElJ4TvjZNZhTiqJfwPbhlO6M7rgoOI9pHprJDL1o+SM/GSywwOf+ElbD7ZGPkUhXAozo=
X-Received: by 2002:a25:db8a:0:b0:65c:b04a:f612 with SMTP id
 g132-20020a25db8a000000b0065cb04af612mr24920915ybf.106.1654527721136; Mon, 06
 Jun 2022 08:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org> <Yp3ID86TBFxl7qyL@kroah.com>
In-Reply-To: <Yp3ID86TBFxl7qyL@kroah.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 6 Jun 2022 17:01:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15RuR3VOPLPV3SfdBAGuoyor6o7JMs3kC5dNB5nfDuKA@mail.gmail.com>
Message-ID: <CAK8P3a15RuR3VOPLPV3SfdBAGuoyor6o7JMs3kC5dNB5nfDuKA@mail.gmail.com>
Subject: Re: [PATCH 0/6] phase out CONFIG_VIRT_TO_BUS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 6, 2022 at 11:25 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I'll take patches 1 and 2 right now through my staging tree if that's
> ok.

Yes, that's perfect, as there are no actual interdependencies with the
other drivers -- applying the last patch first would just hide the driver
I'm removing here.

Thanks,

      Arnd
