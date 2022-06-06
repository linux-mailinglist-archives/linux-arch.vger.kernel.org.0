Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98C53E81E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiFFPWH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 11:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbiFFPWC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 11:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E140E16ABFA
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 08:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B054614F8
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 15:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D100CC385A9;
        Mon,  6 Jun 2022 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654528917;
        bh=H45XJSaI9Mge/1jvZGk2FB2Ax4wGIpAul9wyofb4eD8=;
        h=Date:From:To:Cc:Subject:From;
        b=sewHuMblTT4L5NfDTG8uPOWrcAd5186bz2/pQJXdmMWWZwh3Q9BzFx0YlzlvPZupl
         z20SjVxvktLjmHFxWE+xFZUfOCvqp9/rtBbxJquVUHugwZteAipO/6r0tpTSAsH3Hb
         30hfXeZ/SbcKPOoKLIXMKfVZRs0dFLKlUEThVP9ssFGPrAfFFF8BBecPdr1fAwjJ9z
         1Vto+DLkXD19Os/z17nj7TzN5RwBllqgSPnRniLZ1Chrket9tZlnxMpisrcuWsm4Pq
         dtSaHQ3zIY2lZ1hXCKQsIvVvO81LWD5fQiV4JmKNtg7ATop+kWIMaOdix/XqIa45eS
         NFmkU1bRFW3lw==
Date:   Mon, 6 Jun 2022 16:21:50 +0100
From:   Will Deacon <will@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     catalin.marinas@arm.com, maz@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, hch@lst.de, vgupta@kernel.org,
        linux@armlinux.org.uk, arnd@arndb.de, bcain@quicinc.com,
        geert@linux-m68k.org, monstr@monstr.eu, dinguyen@kernel.org,
        shorne@gmail.com, mpe@ellerman.id.au, dalias@libc.org
Subject: Cache maintenance for non-coherent DMA in arch_sync_dma_for_device()
Message-ID: <20220606152150.GA31568@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[CC'ing a bunch of arch maintainers who are not "obviously" immune to
 this issue; please can you check your archs?]

Hi folks,

Some off-list discussions about the arm64 implementation of
arch_sync_dma_for_device() have left me unsure about the following
architectures in this area:

arc
arm
arm64
hexagon
m68k
microblaze
nios2
openrisc
powerpc
sh

The background is that when using the streaming DMA API to map a buffer
prior to inbound non-coherent DMA (i.e. DMA_FROM_DEVICE), it is often
necessary to remove any dirty CPU cache lines so that they can't get
evicted during the transfer and corrupt the buffer contents written by
the DMA. The architectures listed above appear to achieve this using
*invalidation*, which tends to imply discarding of the CPU cache lines
rather than writing them back, and this consequently raises two related
questions:

  (1) What if the DMA transfer doesn't write to every byte in the buffer?
  (2) What if the buffer has a virtual alias in userspace (e.g. because
      the kernel has GUP'd the buffer?

In both cases, stale data (possibly containing random values written
prior to the initial clearing of the page) can be read from the buffer.
In case (1), this applies to the unwritten bytes after the transfer has
completed and in case (2) it applies to the user alias of the whole
buffer during the narrow window between arch_sync_dma_for_device() and
the DMA writes landing in memory.

The simplest fix (diff for arm64 below) seems to be changing the
invalidation in this case to be a "clean" in arm(64)-speak so that any
dirty lines are written back, therefore limiting the stale data to the
initial buffer contents. In doing so, this makes the FROM_DEVICE and
BIDIRECTIONAL cases identical which makes some intuitive sense if you
think of FROM_DEVICE as first doing a TO_DEVICE of any dirty CPU cache
lines. One interesting thing I noticed is that the csky implementation
additionally zeroes the buffer prior to the clean, but this seems to be
overkill.

An alternative solution would be to ensure that newly allocated pages
are clean rather than just zeroed; although this would then handle any
variants of case (2) (e.g. where userspace can access a buffer with
non-cacheable attributes), it's likely to have an intolerable
performance cost.

Finally, on arm(64), the DMA mapping code tries to deal with buffers
that are not cacheline aligned by issuing clean-and-invalidate
operations for the overlapping portions at each end of the buffer. I
don't think this makes a tonne of sense, as inevitably one of the
writers (either the CPU or the DMA) is going to win and somebody is
going to run into silent data loss. Having the caller receive
DMA_MAPPING_ERROR in this case would probably be better.

Thoughts? I haven't tried to reproduce the problem above in practice and
this code has been like this since the dawn of time, so we could also
elect to leave it as-is...

Will

--->8

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 0ea6cc25dc66..21c907987080 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -218,8 +218,6 @@ SYM_FUNC_ALIAS(__dma_flush_area, __pi___dma_flush_area)
  */
 SYM_FUNC_START(__pi___dma_map_area)
        add     x1, x0, x1
-       cmp     w2, #DMA_FROM_DEVICE
-       b.eq    __pi_dcache_inval_poc
        b       __pi_dcache_clean_poc
 SYM_FUNC_END(__pi___dma_map_area)
 SYM_FUNC_ALIAS(__dma_map_area, __pi___dma_map_area)

