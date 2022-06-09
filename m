Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E510544E90
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jun 2022 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiFIOSq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jun 2022 10:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240896AbiFIOSq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2022 10:18:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365681F2F01
        for <linux-arch@vger.kernel.org>; Thu,  9 Jun 2022 07:18:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F38B67373; Thu,  9 Jun 2022 16:18:39 +0200 (CEST)
Date:   Thu, 9 Jun 2022 16:18:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, vgupta@kernel.org, linux@armlinux.org.uk,
        arnd@arndb.de, bcain@quicinc.com, geert@linux-m68k.org,
        monstr@monstr.eu, dinguyen@kernel.org, shorne@gmail.com,
        mpe@ellerman.id.au, dalias@libc.org
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <20220609141838.GA1829@lst.de>
References: <20220606152150.GA31568@willie-the-truck> <20220608084841.GA17806@lst.de> <20220609135954.GC3064@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609135954.GC3064@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 09, 2022 at 02:59:54PM +0100, Will Deacon wrote:
> That makes sense to me (assuming an opt-out for archs that want it), but
> I'd like to make sure that these low-level helpers aren't generally
> available for e.g. driver modules to dip into directly; it's pretty common
> for folks to request that we EXPORT our cache maintenance routines because
> they're violating the DMA API someplace and so far we've been pretty good
> at asking them to fix their code instead.

Yes, they have absolutely no business being available to drivers
directly.
