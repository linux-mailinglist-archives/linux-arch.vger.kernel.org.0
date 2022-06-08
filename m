Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49193542FA2
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiFHMCd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbiFHMCc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 08:02:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BC3250242
        for <linux-arch@vger.kernel.org>; Wed,  8 Jun 2022 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VuunZGS3bood5+cnTkevWyuNbw7aOWD0MLFaHEeIza0=; b=Io6uXUWKVzpHPz3mZZIiyrzxxh
        ISNjLVPn3p9vLP6RldSYvd+vN6+ntmfVfemRHsJNXEKp53QHPHuwkzOfMj4BCaf1KwEwWVlOI+9WD
        lWisdDng2Ahwz2hatM6kkfLdJn/qxFVUskHzey9tV5Fo05pA9EQlmIOdCXtveFHTmFyIntY9r9Itn
        pBUITE43FhtbFbj909WKR30JOwkY6n4XmjZaEodfPL4vvmtrsmbqrq0EHxBHHLuGIrpRKQ3R5PLyR
        U4hhroYzIuuN3zowXiI1HasDp4mjRt1LPTA2PxpoY3KkGq8+Yt40dM0fwuCQ489yIao65DQ6QovD4
        oHuqWvRw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32792)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nyuOH-0004hH-5a; Wed, 08 Jun 2022 13:02:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nyuOD-0001lw-9o; Wed, 08 Jun 2022 13:02:21 +0100
Date:   Wed, 8 Jun 2022 13:02:21 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, vgupta@kernel.org, arnd@arndb.de,
        bcain@quicinc.com, geert@linux-m68k.org, monstr@monstr.eu,
        dinguyen@kernel.org, shorne@gmail.com, mpe@ellerman.id.au,
        dalias@libc.org
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <YqCPzTeKpCf3JZQw@shell.armlinux.org.uk>
References: <20220606152150.GA31568@willie-the-truck>
 <20220608084841.GA17806@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608084841.GA17806@lst.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
> at leat.

Note that simply devolving the operations to this set is not optimal.
If you notice, both my email and the table that was copied from my
email makes two of the invalidate options dependent on the properties
of the CPU cache architecture.

While we could invalidate anyway at that point, this just fuels the
view that generic code == non-optimal, performance degrading code.
This is why the underlying interfaces on 32-bit ARM are not these
cache operations, but are instead based on buffer ownership
transitions - __dma_page_cpu_to_dev() and __dma_page_dev_to_cpu()
are the two things that are really needed.

There's also additional code that deals with the d-cache state
(which itself is architecture specific, which avoids useless
d-cache maintenance when page cache pages get mapped into userspace)
as well as the complexities of dealing with more than one level of
cache - where the order of the inner and outer cache maintenance
can't be expressed as per the simple functions you mention above.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
