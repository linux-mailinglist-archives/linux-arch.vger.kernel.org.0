Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052443CA51E
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbhGOSPn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 14:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbhGOSPm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 14:15:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B55C06175F;
        Thu, 15 Jul 2021 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1wkBxUEbT0DVYtgLY8bo8fqQViCHE6yFAYwJFSkVK9o=; b=XNCqO8BCe71uTviFBhVmUUycKI
        JDvtIxhdi/4acLD11VtR8tfkf/b+XqqtnxWrL2q7aIVcS+ulQtP7QPQav33pp8FMiNRDgz1KIEgiz
        TNMnVp42zr/0wUo4S+Sw8zx1eV8WdkompgFrC8YIL9R6g+DvccShLFfWZd8zWV4mw7OYn4EPiXare
        10S7AayZ19gJAaKczF9p6BrO5OMNiC9WCUUy6ZaMzyIECGttgTpIUkLHtJ7xVFueE68NR0UTFuda5
        5khceIUdQP2lyJo+SmEP/frd2FNQCrWsawtt4gGUuk2nbP11BlQnmgSrK4tcjMBZg+qvI/04SaxgE
        zog6uMLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m45p0-003blr-HW; Thu, 15 Jul 2021 18:11:16 +0000
Date:   Thu, 15 Jul 2021 19:10:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm: Rename PMD_ORDER to PMD_TABLE_ORDER
Message-ID: <YPB6Lu2YiAWC7rDc@casper.infradead.org>
References: <20210715134612.809280-1-willy@infradead.org>
 <20210715134612.809280-2-willy@infradead.org>
 <20210715164740.GN22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715164740.GN22278@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 15, 2021 at 05:47:41PM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 15, 2021 at 02:46:10PM +0100, Matthew Wilcox (Oracle) wrote:
> > This is the order of the page table allocation, not the order of a PMD.
> > -#define PMD_ORDER	3
> > +#define PMD_TABLE_ORDER	3
> >  #else
> >  #define PG_DIR_SIZE	0x4000
> > -#define PMD_ORDER	2
> > +#define PMD_TABLE_ORDER	2
> 
> I think PMD_ENTRY_ORDER would make more sense here - this is the
> power-of-2 of an individual PMD entry, not of the entire table.

But ... we have two kinds of PMD entries.  We have the direct entry that
points to a 1-16MB sized chunk of memory, and we have the table entry that
points to a 4k-32k chunk of memory that contains PTEs.  So I don't think
calling it 'entry' order actually disambiguates anything.  That's why
I went with 'table' -- I can't think of anything else to call it!
PMD_PTE_ARRAY_ORDER doesn't seem like an improvement to me ...
