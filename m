Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462AE55F672
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 08:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiF2GWA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 02:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiF2GWA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 02:22:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDEF1E3DA;
        Tue, 28 Jun 2022 23:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7yGusf/8BpHfB7jofxMw85tVuHPTi4bAH8G5H2jvBjY=; b=h3tAd+nNN81Dil4eXw2Lk4CyNH
        1475Vuy94bgqSj2tu5/1Xr1gZBM2KPknL6JamvXFdmFANrhSnUNOxMiUStNCzqyfBbttb80rJi566
        DVlH1oD5tJgtAmhEidd4yafSARpW45WIOCWo6aEhVwxyQXijFQI8BaFSYdwwRjF/FcXRSqfarrS4w
        yMHV9DjHfI9xh/1Wx6/1z+DAEu5EHm1h+9Cz1lixjewEncE5xNCDuhFMiqMKmak/YED18c9DEiTkF
        shw99ZN5InGSE/X3yex04M0RucunRXqykifZ7stOcSWbnTFGj/qcYAa7QU52JML8NJVd3Ta4itXpg
        3vrA5osg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6R5C-009kw7-RG; Wed, 29 Jun 2022 06:21:50 +0000
Date:   Tue, 28 Jun 2022 23:21:50 -0700
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
Message-ID: <YrvvfpW4MmQiM47H@infradead.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
 <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
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

On Wed, Jun 29, 2022 at 11:09:00AM +1200, Michael Schmitz wrote:
> And all SCSI buffers are allocated using kmalloc? No way at all for user
> space to pass unaligned data?

Most that you will see actually comes from the page allocator.  But
the block layer has a dma_alignment limit, and when userspace sends
I/O that is not properly aligned it will be bounce buffered before
it it sent to the driver.
