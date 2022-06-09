Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC1544E48
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jun 2022 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiFIOAE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jun 2022 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiFIOAD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2022 10:00:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F52AB31
        for <linux-arch@vger.kernel.org>; Thu,  9 Jun 2022 07:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B31261D82
        for <linux-arch@vger.kernel.org>; Thu,  9 Jun 2022 14:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCC2C34114;
        Thu,  9 Jun 2022 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654783201;
        bh=wFEEErPzbQZz60HyAjH+iwWoCZRlnnUiPDJsm4HBkD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOP+Y+tJj6YIsGWI+tUcwQqKUuV2NUS48RJN+/KJkqM0iqCqZs5D3txFM2NSA1BnB
         X/nUbAAnRRjUtyUGuINOYUqSM+SSTROLyex6GQaz0dlfmmqvgzZA+48h9pxkLMnKOY
         VOICPfseLjLAnyKDC1vh5gRu80Pd4H8YNQZUR/masQ0UkbJyEAZ+HOszb2MPR9iusR
         wpzHbJfXANJBkJu+tiR81XrOCZHs52fuGfQilsCKxL2FyCu2uJ/0iWV23taRSS4h2y
         HlB1KNZG2yCWKrzUJ3DnPhvhQDi0wp6xUWywJXngH54eyIdCWabmfHegt8Iz/XEeKa
         CwRTK8IMmbdEA==
Date:   Thu, 9 Jun 2022 14:59:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com,
        vgupta@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        bcain@quicinc.com, geert@linux-m68k.org, monstr@monstr.eu,
        dinguyen@kernel.org, shorne@gmail.com, mpe@ellerman.id.au,
        dalias@libc.org
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <20220609135954.GC3064@willie-the-truck>
References: <20220606152150.GA31568@willie-the-truck>
 <20220608084841.GA17806@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608084841.GA17806@lst.de>
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

On Wed, Jun 08, 2022 at 10:48:41AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 06, 2022 at 04:21:50PM +0100, Will Deacon wrote:
> > The simplest fix (diff for arm64 below) seems to be changing the
> > invalidation in this case to be a "clean" in arm(64)-speak so that any
> > dirty lines are written back, therefore limiting the stale data to the
> > initial buffer contents. In doing so, this makes the FROM_DEVICE and
> > BIDIRECTIONAL cases identical which makes some intuitive sense if you
> > think of FROM_DEVICE as first doing a TO_DEVICE of any dirty CPU cache
> > lines. One interesting thing I noticed is that the csky implementation
> > additionally zeroes the buffer prior to the clean, but this seems to be
> > overkill.
> 
> Btw, one thing I'd love to (and might need some help from the arch
> maintainers) is to change how the dma cache maintainance hooks work.
> 
> Right now they are high-level and these kinds of decisions need to
> be take in the arch code.  I'd prefer to move over to the architectures
> providing very low-level helpers to:
> 
>   - writeback
>   - invalidate
>   - invalidate+writeback
> 
> Note arch/arc/mm/dma.c has a ver nice documentation of what we need to
> based on a mail from Russell, and we should keep it uptodate with any
> changes to the status quo and probably move it to common documentation
> at leat

That makes sense to me (assuming an opt-out for archs that want it), but
I'd like to make sure that these low-level helpers aren't generally
available for e.g. driver modules to dip into directly; it's pretty common
for folks to request that we EXPORT our cache maintenance routines because
they're violating the DMA API someplace and so far we've been pretty good
at asking them to fix their code instead.

> > Finally, on arm(64), the DMA mapping code tries to deal with buffers
> > that are not cacheline aligned by issuing clean-and-invalidate
> > operations for the overlapping portions at each end of the buffer. I
> > don't think this makes a tonne of sense, as inevitably one of the
> > writers (either the CPU or the DMA) is going to win and somebody is
> > going to run into silent data loss. Having the caller receive
> > DMA_MAPPING_ERROR in this case would probably be better.
> 
> Yes, the mapping are supposed to be cache line aligned or at least
> have padding around them.  But due to the later case we can't really
> easily verify this in dma-debug.

Damn, I hadn't considered padding. That probably means that the csky
implementation that I mentioned (which zeroes the buffer) is buggy...

Will
