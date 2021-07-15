Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AFA3CAD46
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 21:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbhGOT42 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346301AbhGOTvQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 15:51:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED02C0251B1;
        Thu, 15 Jul 2021 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fMdK5kwbGT8Ucs5zmQxr/NzmYbZf7pMhdeOpiEPMJ0A=; b=Tf/modV75F/lM+05pVz6LFMq2e
        fSW6cVLxK8tmbhYa2Hd6+nfQD0TbDxbu4c4dskRDLhcz/ZYhzpj4yomIRueL06/OutQnuyzccFFU6
        kG9qAgrQoj6P5kmH0fI8Rr68nMux2MjqA1PQF7XD8THV40XbKDh6i3DwhJ99CL2dx1Vs6I0gfPshY
        xB/VwKxt0kDpblWkR6EuAn3bqMHBYip9pn6M+4KUm07JZ/lf48hfLkBjkwa9faBfPBog/nIhj2tX7
        6CTMF+V/NYCfQr+I67RNVY4iLyhaVSiN+kdMJoGit6jGK612ZVA+fGppzB4rZDn5TPCN8aK273aPm
        Wnv1H0jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m46qE-003ga4-Hi; Thu, 15 Jul 2021 19:16:50 +0000
Date:   Thu, 15 Jul 2021 20:16:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm: Rename PMD_ORDER to PMD_TABLE_ORDER
Message-ID: <YPCJftSTUBEnq2lI@casper.infradead.org>
References: <20210715134612.809280-1-willy@infradead.org>
 <20210715134612.809280-2-willy@infradead.org>
 <20210715164740.GN22278@shell.armlinux.org.uk>
 <YPB6Lu2YiAWC7rDc@casper.infradead.org>
 <20210715183727.GP22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715183727.GP22278@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 15, 2021 at 07:37:27PM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 15, 2021 at 07:10:54PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 15, 2021 at 05:47:41PM +0100, Russell King (Oracle) wrote:
> > > On Thu, Jul 15, 2021 at 02:46:10PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > This is the order of the page table allocation, not the order of a PMD.
> > > > -#define PMD_ORDER	3
> > > > +#define PMD_TABLE_ORDER	3
> > > >  #else
> > > >  #define PG_DIR_SIZE	0x4000
> > > > -#define PMD_ORDER	2
> > > > +#define PMD_TABLE_ORDER	2
> > > 
> > > I think PMD_ENTRY_ORDER would make more sense here - this is the
> > > power-of-2 of an individual PMD entry, not of the entire table.
> > 
> > But ... we have two kinds of PMD entries.  We have the direct entry that
> > points to a 1-16MB sized chunk of memory, and we have the table entry that
> > points to a 4k-32k chunk of memory that contains PTEs.  So I don't think
> > calling it 'entry' order actually disambiguates anything.  That's why
> > I went with 'table' -- I can't think of anything else to call it!
> > PMD_PTE_ARRAY_ORDER doesn't seem like an improvement to me ...
> 
> There may be two kinds of PMD entries, but that isn't relevant here.
> Going back to the original terminology, 1 << PMD_ORDER here is the
> size of each PMD entry. It doesn't have anything to do with how much
> memory is being mapped by each entry.

Oh.  Oh!  So, 'order' is usually a shift that is _added on to_ the
PAGE_SHIFT in order to find how many bytes are in question.  See
include/asm-generic/getorder.h.

Now, PMD_SHIFT is already in use, but perhaps what is meant here is
PMD_ENTRY_SHIFT?

> I think what is confusing you is stuff like:
> 
>         add     r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ORDER)
> 
> r4 is the base address of the page tables, and r0 is the address of
> the entry we want to manipulate for "KERNEL_OFFSET" - which is the
> virtual address. 1 << SECTION_SHIFT is how much memory each entry
> maps (and this is fixed here - there's no variability as you suggest
> above.)

(the variability I intended above was more to accommodate architectural
differences; I hate to use x86-specific numbers like 4KiB and 2MiB)

> Effectively, the calculation above is:
> 
> 	index = KERNEL_OFFSET >> SECTION_SHIFT;
> 	pmd_entry_size = 1 << PMD_ORDER;
> 	r0 = base + index * pmd_entry_size;
> 
> but in a single instruction as we can be sure that KERNEL_OFFSET will
> have zeros as the low bits after shifting by SECTION_SHIFT - PMD_ORDER.
> 
> Hope this helps to explain what this PMD_ORDER is actually doing here.

Thank you, yes, I was terminally confused.
