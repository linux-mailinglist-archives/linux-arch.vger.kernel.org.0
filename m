Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916F05439E2
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiFHQ6T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242468AbiFHQzx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 12:55:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9685B3CC58D
        for <linux-arch@vger.kernel.org>; Wed,  8 Jun 2022 09:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30092B828C5
        for <linux-arch@vger.kernel.org>; Wed,  8 Jun 2022 16:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3028C34116;
        Wed,  8 Jun 2022 16:51:47 +0000 (UTC)
Date:   Wed, 8 Jun 2022 17:51:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, vgupta@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, bcain@quicinc.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <YqDToEW2LrlIsyVz@arm.com>
References: <20220606152150.GA31568@willie-the-truck>
 <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk>
 <CAMj1kXGyO0Dtws-qy=3=D-QhR9jV83n3g7CjJwy99YAMejh5Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGyO0Dtws-qy=3=D-QhR9jV83n3g7CjJwy99YAMejh5Fg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 06:15:13PM +0200, Ard Biesheuvel wrote:
> On Mon, 6 Jun 2022 at 17:36, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > On Mon, Jun 06, 2022 at 04:21:50PM +0100, Will Deacon wrote:
> > > Finally, on arm(64), the DMA mapping code tries to deal with buffers
> > > that are not cacheline aligned by issuing clean-and-invalidate
> > > operations for the overlapping portions at each end of the buffer. I
> > > don't think this makes a tonne of sense, as inevitably one of the
> > > writers (either the CPU or the DMA) is going to win and somebody is
> > > going to run into silent data loss. Having the caller receive
> > > DMA_MAPPING_ERROR in this case would probably be better.
> >
> > Sadly unavoidable - people really like passing unaligned buffers to the
> > DMA API, sometimes those buffers contain information that needs to be
> > preserved. I really wish it wasn't that way, because it would make life
> > a lot better, but it's what we've had to deal with over the years with
> > the likes of the SCSI subsystem (and e.g. it's sense buffer that was
> > embedded non-cacheline aligned into other structures that had to be
> > DMA'd to.)
> 
> As discussed in the thread related to Catalin's DMA granularity
> series, this is something I think we should be addressing with bounce
> buffering for inbound DMA. This would allow us to reduce the kmalloc
> alignment as well.

It depends on the size. My plan was to do bouncing only if the size is
below ARCH_DMA_MINALIGN. For larger buffers, kmalloc() gives us
alignment to a power of two (well, other than 96 and 192) and no
bouncing needed. If some buggy driver allocates a large structure only
to hope it can do DMA into unaligned parts of it while modifying the
adjacent bytes, we should just mark it as broken, we can't fix it.

However, if the driver doesn't modify the cache line while the DMA takes
place (only expecting it to be preserved), the fix from Will to clean on
__dma_map_area() is sufficient.

-- 
Catalin
