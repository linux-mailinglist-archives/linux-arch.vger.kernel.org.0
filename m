Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3355F67D
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiF2GZs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 02:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiF2GZr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 02:25:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3C23BF1;
        Tue, 28 Jun 2022 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGxicrNA0Ky21SHQ+zvPyQeSEbMbEJ671RYnbrPw0JA=; b=qbFJAtMX0xKPZ1ARuRDdID37q4
        owWkofTOSGtlKKGTJhARtkYpPKzHltLGhkndQA87MkODaY6KyO3cK4q808MkXZcOU40psAis3jQba
        hIlFNsykvnaIIUvqvKn2j1RZrQIeveQo7JYMztumkKhMbvD1zMb+mAEHnE6ESPqZza5WuXR5gF7PV
        n41lGSXcUPlvzAaeQHQhfM7f39UWgRCFoNb11FKul4UW/Ow1CvhldL3c1YOUP0JDldI562o45tZwg
        o0wAWuANXSfL/2mp0QfYSlqVUMbLFqDf0nTTu2Vp3DOLQ3j8ak5hAwUNMCSyw4o2Ir79RVMA1BFMh
        i++X3W8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6R8w-009lUE-5F; Wed, 29 Jun 2022 06:25:42 +0000
Date:   Tue, 28 Jun 2022 23:25:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Message-ID: <YrvwZi9NQSpFjStX@infradead.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
 <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 29, 2022 at 09:38:00AM +1200, Michael Schmitz wrote:
> That's one of the 'liberties' I alluded to. The reason I left these in is
> that I'm none too certain what device feature the DMA API uses to decide a
> device isn't cache-coherent.

The DMA API does not look at device features at all.  It needs to be
told so by the platform code.  Once an architecture implements the
hooks to support non-coherent DMA all devices are treated as
non-coherent by default unless overriden by the architecture either
globally (using the global dma_default_coherent variable) or per-device
(using the dev->dma_coherent field, usually set by arch_setup_dma_ops).

> If it's dev->coherent_dma_mask, the way I set
> up the device in the a3000 driver should leave the coherent mask unchanged.
> For the Zorro drivers, devices are set up to use the same storage to store
> normal and coherent masks - something we most likely want to change. I need
> to think about the ramifications of that.

No, the coherent mask is slightly misnamed amd not actually related.
