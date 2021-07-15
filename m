Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D943CA59B
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGOSkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhGOSkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 14:40:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E46CC06175F;
        Thu, 15 Jul 2021 11:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7prIAEwV0cctqSh3YVeApTqrgra5AsWW5297d2iBdT4=; b=qEmHpWL6yFMcmQxcBuuT/B1bT
        H88tCTSF4SWBdeodMucSuUcT2RH+tWtYAWzN+SCG6evK3VQqgjQm6/GkZ1JusaoQIaNk8qdKiDB28
        fjjIWIrfbRmcN1JNUptbTvSuQaM2CBfjJuDluaLPeQcCHDxTPMgWfySmjUtwEhmehv02l4RGnEaT2
        VToSeHoHCqRk4L9Sagcl1ecBfgjwXKLqQ20aOt0E0Vb2FE4C4VBxjzRnw7sQijpHA/xUYMN0QEJpM
        mp2RS3DgFb9tr1NGEoNs0xIFCsrMOg0sLWldT+y1cMD3Tq6mHlZOCqBRz2ektLeaEVjlXMyXdoGMO
        DRhRSTKpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46196)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m46Ei-0001FT-4l; Thu, 15 Jul 2021 19:37:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m46Eh-0002Ox-U6; Thu, 15 Jul 2021 19:37:27 +0100
Date:   Thu, 15 Jul 2021 19:37:27 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm: Rename PMD_ORDER to PMD_TABLE_ORDER
Message-ID: <20210715183727.GP22278@shell.armlinux.org.uk>
References: <20210715134612.809280-1-willy@infradead.org>
 <20210715134612.809280-2-willy@infradead.org>
 <20210715164740.GN22278@shell.armlinux.org.uk>
 <YPB6Lu2YiAWC7rDc@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPB6Lu2YiAWC7rDc@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 15, 2021 at 07:10:54PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 15, 2021 at 05:47:41PM +0100, Russell King (Oracle) wrote:
> > On Thu, Jul 15, 2021 at 02:46:10PM +0100, Matthew Wilcox (Oracle) wrote:
> > > This is the order of the page table allocation, not the order of a PMD.
> > > -#define PMD_ORDER	3
> > > +#define PMD_TABLE_ORDER	3
> > >  #else
> > >  #define PG_DIR_SIZE	0x4000
> > > -#define PMD_ORDER	2
> > > +#define PMD_TABLE_ORDER	2
> > 
> > I think PMD_ENTRY_ORDER would make more sense here - this is the
> > power-of-2 of an individual PMD entry, not of the entire table.
> 
> But ... we have two kinds of PMD entries.  We have the direct entry that
> points to a 1-16MB sized chunk of memory, and we have the table entry that
> points to a 4k-32k chunk of memory that contains PTEs.  So I don't think
> calling it 'entry' order actually disambiguates anything.  That's why
> I went with 'table' -- I can't think of anything else to call it!
> PMD_PTE_ARRAY_ORDER doesn't seem like an improvement to me ...

There may be two kinds of PMD entries, but that isn't relevant here.
Going back to the original terminology, 1 << PMD_ORDER here is the
size of each PMD entry. It doesn't have anything to do with how much
memory is being mapped by each entry.

I think what is confusing you is stuff like:

        add     r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ORDER)

r4 is the base address of the page tables, and r0 is the address of
the entry we want to manipulate for "KERNEL_OFFSET" - which is the
virtual address. 1 << SECTION_SHIFT is how much memory each entry
maps (and this is fixed here - there's no variability as you suggest
above.)

Effectively, the calculation above is:

	index = KERNEL_OFFSET >> SECTION_SHIFT;
	pmd_entry_size = 1 << PMD_ORDER;
	r0 = base + index * pmd_entry_size;

but in a single instruction as we can be sure that KERNEL_OFFSET will
have zeros as the low bits after shifting by SECTION_SHIFT - PMD_ORDER.

Hope this helps to explain what this PMD_ORDER is actually doing here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
