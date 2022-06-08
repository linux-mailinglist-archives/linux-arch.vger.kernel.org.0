Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA4542B7D
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 11:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiFHJZu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiFHJZ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 05:25:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2E4D9205
        for <linux-arch@vger.kernel.org>; Wed,  8 Jun 2022 01:48:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9500668AA6; Wed,  8 Jun 2022 10:48:42 +0200 (CEST)
Date:   Wed, 8 Jun 2022 10:48:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arch@vger.kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com,
        hch@lst.de, vgupta@kernel.org, linux@armlinux.org.uk,
        arnd@arndb.de, bcain@quicinc.com, geert@linux-m68k.org,
        monstr@monstr.eu, dinguyen@kernel.org, shorne@gmail.com,
        mpe@ellerman.id.au, dalias@libc.org
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <20220608084841.GA17806@lst.de>
References: <20220606152150.GA31568@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606152150.GA31568@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 04:21:50PM +0100, Will Deacon wrote:
> The simplest fix (diff for arm64 below) seems to be changing the
> invalidation in this case to be a "clean" in arm(64)-speak so that any
> dirty lines are written back, therefore limiting the stale data to the
> initial buffer contents. In doing so, this makes the FROM_DEVICE and
> BIDIRECTIONAL cases identical which makes some intuitive sense if you
> think of FROM_DEVICE as first doing a TO_DEVICE of any dirty CPU cache
> lines. One interesting thing I noticed is that the csky implementation
> additionally zeroes the buffer prior to the clean, but this seems to be
> overkill.

Btw, one thing I'd love to (and might need some help from the arch
maintainers) is to change how the dma cache maintainance hooks work.

Right now they are high-level and these kinds of decisions need to
be take in the arch code.  I'd prefer to move over to the architectures
providing very low-level helpers to:

  - writeback
  - invalidate
  - invalidate+writeback

Note arch/arc/mm/dma.c has a ver nice documentation of what we need to
based on a mail from Russell, and we should keep it uptodate with any
changes to the status quo and probably move it to common documentation
at leat.

> Finally, on arm(64), the DMA mapping code tries to deal with buffers
> that are not cacheline aligned by issuing clean-and-invalidate
> operations for the overlapping portions at each end of the buffer. I
> don't think this makes a tonne of sense, as inevitably one of the
> writers (either the CPU or the DMA) is going to win and somebody is
> going to run into silent data loss. Having the caller receive
> DMA_MAPPING_ERROR in this case would probably be better.

Yes, the mapping are supposed to be cache line aligned or at least
have padding around them.  But due to the later case we can't really
easily verify this in dma-debug.
