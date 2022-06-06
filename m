Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4C53EAEB
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbiFFQQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241486AbiFFQQo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 12:16:44 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0417F835
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QhWp9akVIxlaEL08vhdpPypZcNAlFt1Z4L68CfsevR4=; b=emsdIock+SezFC8V/h9vElo8Hz
        Ro0oZOMHGKzDrKgnOgJuh37R9bfY+aJ+Id1YEVdBP0GmqS0ZIra0f2BznlkD55JueDg3+6ycjMA1+
        zzNI0MyjD3Oam1SetSFIB36P9wqVps/gXvdl+jqswI49i3ZCFyh13f6RvV8B50ce5KI995IMjNc00
        1MouPWXi6xnquKc+PJ02fhyFI0vyStctkkiMWbrgIjKauWeWtwddvH8XwAPMycAiu5m/wta1ZL/ja
        i1uK1TTX+TgKnphLj4/qeaD6xGvhrUzAK+Ljwzf/GEvO+M1BH2jvR2a1F5EZYUtamZ0G3q/Q+IRoC
        7jQFaCrg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60974)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nyFPB-0002En-Cy; Mon, 06 Jun 2022 17:16:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nyFP9-0008My-2i; Mon, 06 Jun 2022 17:16:35 +0100
Date:   Mon, 6 Jun 2022 17:16:35 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, mark.rutland@arm.com,
        hch@lst.de, vgupta@kernel.org, arnd@arndb.de, bcain@quicinc.com,
        geert@linux-m68k.org, monstr@monstr.eu, dinguyen@kernel.org,
        shorne@gmail.com, mpe@ellerman.id.au, dalias@libc.org
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <Yp4oY12TC2a0ZpPx@shell.armlinux.org.uk>
References: <20220606152150.GA31568@willie-the-truck>
 <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk>
 <1a8cc7af-87ac-b0e7-7fb9-d11a5eebef55@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8cc7af-87ac-b0e7-7fb9-d11a5eebef55@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 05:02:50PM +0100, Robin Murphy wrote:
> On 2022-06-06 16:35, Russell King (Oracle) wrote:
> > On Mon, Jun 06, 2022 at 04:21:50PM +0100, Will Deacon wrote:
> > >    (1) What if the DMA transfer doesn't write to every byte in the buffer?
> > 
> > The data that is in RAM gets pulled into the cache and is visible to
> > the CPU - but if DMA doesn't write to every byte in the buffer, isn't
> > that a DMA failure? Should a buffer that suffers DMA failure be passed
> > to the user?
> 
> No, partial DMA writes can sometimes effectively be expected behaviour, see
> the whole SWIOTLB CVE fiasco for the most recent discussion on that:
> 
> https://lore.kernel.org/lkml/1812355.tdWV9SEqCh@natalenko.name/

So we have a CVE'd security hole that was never reported to
maintainers...

> > >    (2) What if the buffer has a virtual alias in userspace (e.g. because
> > >        the kernel has GUP'd the buffer?
> > 
> > Then userspace needs to avoid writing to cachelines that overlap the
> > buffer to avoid destroying the action of the DMA. It shouldn't be doing
> > this anyway (what happens if userspace writes to the same location that
> > is being DMA'd to... who wins?)
> > 
> > However, you're right that invalidating in this case could expose data
> > that userspace shouldn't see, and I'd suggest in this case that DMA
> > buffers should be cleaned in this circumstance before they're exposed
> > to userspace - so userspace only ever gets to see the data that was
> > there at the point they're mapped, or is subsequently written to
> > afterwards by DMA.
> > 
> > I don't think there's anything to be worried about if the invalidation
> > reveals stale data provided the stale data is not older than the data
> > that was there on first mapping.
> 
> Indeed as above that may actually be required. I think cleaning the caches
> on dma_map_* is the most correct thing to do.

It's also the most expensive thing to do as it can push up the slow
on-bus traffic to memory quite a bit, especially when big buffers
are involved.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
