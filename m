Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952D6543738
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243040AbiFHPV0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 11:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244942AbiFHPT6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 11:19:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663081A825
        for <linux-arch@vger.kernel.org>; Wed,  8 Jun 2022 08:14:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 638F36732D; Wed,  8 Jun 2022 17:14:51 +0200 (CEST)
Date:   Wed, 8 Jun 2022 17:14:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
        linux-arch@vger.kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com,
        vgupta@kernel.org, arnd@arndb.de, bcain@quicinc.com,
        geert@linux-m68k.org, monstr@monstr.eu, dinguyen@kernel.org,
        shorne@gmail.com, mpe@ellerman.id.au, dalias@libc.org
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <20220608151451.GA14424@lst.de>
References: <20220606152150.GA31568@willie-the-truck> <20220608084841.GA17806@lst.de> <YqCPzTeKpCf3JZQw@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqCPzTeKpCf3JZQw@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 08, 2022 at 01:02:21PM +0100, Russell King (Oracle) wrote:
> Note that simply devolving the operations to this set is not optimal.
> If you notice, both my email and the table that was copied from my
> email makes two of the invalidate options dependent on the properties
> of the CPU cache architecture.

Yes, but that is nothing we can't do with a little optional arch
tunable.  The whole point is that most architectures simply copy
and paste in the best case or get it wrong.  So I'd have a nicely
working piece of generic code which is a win even if we still need
to override it in one or two places.
