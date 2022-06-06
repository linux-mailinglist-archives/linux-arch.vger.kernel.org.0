Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E299E53EB1C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbiFFQN1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241505AbiFFQN0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 12:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588AF10053D
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 09:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E925B60C84
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 16:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7434FC385A9;
        Mon,  6 Jun 2022 16:13:20 +0000 (UTC)
Date:   Mon, 6 Jun 2022 17:13:16 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        maz@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com,
        hch@lst.de, vgupta@kernel.org, arnd@arndb.de, bcain@quicinc.com,
        geert@linux-m68k.org, monstr@monstr.eu, dinguyen@kernel.org,
        shorne@gmail.com, mpe@ellerman.id.au, dalias@libc.org
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <Yp4nnOmsk36CPyPR@arm.com>
References: <20220606152150.GA31568@willie-the-truck>
 <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 04:35:07PM +0100, Russell King wrote:
> On Mon, Jun 06, 2022 at 04:21:50PM +0100, Will Deacon wrote:
> > Finally, on arm(64), the DMA mapping code tries to deal with buffers
> > that are not cacheline aligned by issuing clean-and-invalidate
> > operations for the overlapping portions at each end of the buffer. I
> > don't think this makes a tonne of sense, as inevitably one of the
> > writers (either the CPU or the DMA) is going to win and somebody is
> > going to run into silent data loss. Having the caller receive
> > DMA_MAPPING_ERROR in this case would probably be better.
> 
> Sadly unavoidable - people really like passing unaligned buffers to the
> DMA API, sometimes those buffers contain information that needs to be
> preserved. I really wish it wasn't that way, because it would make life
> a lot better, but it's what we've had to deal with over the years with
> the likes of the SCSI subsystem (and e.g. it's sense buffer that was
> embedded non-cacheline aligned into other structures that had to be
> DMA'd to.)

As Will said, you either corrupt the DMA buffer or the kernel data
sharing the cache line, you can't really win. Current behaviour favours
the kernel data and somehow hopes that there won't be any write to the
cache line by the CPU before the DMA transfer completes. If this hope
holds, the fix to clean (instead of invalidate) in __dma_map_area()
should be sufficient, no need for boundary checks and alignment.

-- 
Catalin
