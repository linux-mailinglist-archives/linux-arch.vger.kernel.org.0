Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F027053EA5E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbiFFPgO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbiFFPfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 11:35:20 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B00248390
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7B/JJ9G6exg2mKN4mJwxHxfwWUxBAOVPospVf1dB7dM=; b=o/jeQ8RKUlIlqyYbnttngK56mg
        9wBBS4qoAClmwiEerUWCqz6L9XY+UycMT5iSqqtd+f0AxUu8Qzv0tRfeVSo8ZOKi3AowIk7R66x++
        dI2UCDztlQrsWreBjElqaUyoCxUwOsMlT8T/rSYXSoEN1Z8XVDUYTLJXdfrwSCutkBgpwYJ/Ked6R
        436jdPNuUqxIq68wSoZAUuGAChKf11kuSbnqClKLp4EmjDVk3RXDXuN31zRvnrfLCr2Wyg5UnXlJ9
        yunbmMkKBjgZ0SW3YkCV3OYOGnEn+qau3Aj+vwDeUSdvu6Ao/7lxWdXISG0xXRQaAiH6/1+XzQXva
        ZkpYZpoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60972)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nyEl6-0002CO-4E; Mon, 06 Jun 2022 16:35:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nyEl1-0008Kj-7H; Mon, 06 Jun 2022 16:35:07 +0100
Date:   Mon, 6 Jun 2022 16:35:07 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arch@vger.kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com,
        hch@lst.de, vgupta@kernel.org, arnd@arndb.de, bcain@quicinc.com,
        geert@linux-m68k.org, monstr@monstr.eu, dinguyen@kernel.org,
        shorne@gmail.com, mpe@ellerman.id.au, dalias@libc.org
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk>
References: <20220606152150.GA31568@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606152150.GA31568@willie-the-truck>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 04:21:50PM +0100, Will Deacon wrote:
>   (1) What if the DMA transfer doesn't write to every byte in the buffer?

The data that is in RAM gets pulled into the cache and is visible to
the CPU - but if DMA doesn't write to every byte in the buffer, isn't
that a DMA failure? Should a buffer that suffers DMA failure be passed
to the user?

>   (2) What if the buffer has a virtual alias in userspace (e.g. because
>       the kernel has GUP'd the buffer?

Then userspace needs to avoid writing to cachelines that overlap the
buffer to avoid destroying the action of the DMA. It shouldn't be doing
this anyway (what happens if userspace writes to the same location that
is being DMA'd to... who wins?)

However, you're right that invalidating in this case could expose data
that userspace shouldn't see, and I'd suggest in this case that DMA
buffers should be cleaned in this circumstance before they're exposed
to userspace - so userspace only ever gets to see the data that was
there at the point they're mapped, or is subsequently written to
afterwards by DMA.

I don't think there's anything to be worried about if the invalidation
reveals stale data provided the stale data is not older than the data
that was there on first mapping.

> Finally, on arm(64), the DMA mapping code tries to deal with buffers
> that are not cacheline aligned by issuing clean-and-invalidate
> operations for the overlapping portions at each end of the buffer. I
> don't think this makes a tonne of sense, as inevitably one of the
> writers (either the CPU or the DMA) is going to win and somebody is
> going to run into silent data loss. Having the caller receive
> DMA_MAPPING_ERROR in this case would probably be better.

Sadly unavoidable - people really like passing unaligned buffers to the
DMA API, sometimes those buffers contain information that needs to be
preserved. I really wish it wasn't that way, because it would make life
a lot better, but it's what we've had to deal with over the years with
the likes of the SCSI subsystem (and e.g. it's sense buffer that was
embedded non-cacheline aligned into other structures that had to be
DMA'd to.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
