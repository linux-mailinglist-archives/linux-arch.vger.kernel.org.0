Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17D1CC5EC
	for <lists+linux-arch@lfdr.de>; Sun, 10 May 2020 03:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgEJBMW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 May 2020 21:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726565AbgEJBMW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 May 2020 21:12:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A858C061A0C;
        Sat,  9 May 2020 18:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X7BNwZm/qeSoH9rk5fDt+Xdu9teDBRzeq1dYQOdzLtQ=; b=sIcN8Hg6HHavcmr49SGf56f5l5
        cGi+tKsydbSSSzCjWR/1pHj2ymlF3jcWYTC7vk+JghdQUSyROOh9UubwC6c0zHZkQG6ai1pkI+2Ma
        V6ipDtighug9Y32X8MvqrdHVOFND8L2TdBI2i7g84zgCvtl9ot/a1hme67GC5uPdWKoE9FYZ8MQyu
        B3grFCxDZ+7aGj7shhExulokE6uClW2/hoAFiDx+Ayb9tDRNTvHEYuDHtxPCMJTCKpwgTsmKJ1QcF
        qbWrcUfYDp2hx5vDhXGC9xkmE+2FiwRn3Musd1aFQlEOtnuNp+KcxXSSopMDQ61GtAgRzCe/LUq6b
        HZF01I8Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXaVZ-0008UL-UC; Sun, 10 May 2020 01:11:57 +0000
Date:   Sat, 9 May 2020 18:11:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200510011157.GU16070@bombadil.infradead.org>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508192000.GB2957@hirez.programming.kicks-ass.net>
 <20200508213407.GT8135@suse.de>
 <20200509092516.GC2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509092516.GC2957@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 09, 2020 at 11:25:16AM +0200, Peter Zijlstra wrote:
> On Fri, May 08, 2020 at 11:34:07PM +0200, Joerg Roedel wrote:
> > On Fri, May 08, 2020 at 09:20:00PM +0200, Peter Zijlstra wrote:
> > > The only concern I have is the pgd_lock lock hold times.
> > > 
> > > By not doing on-demand faults anymore, and consistently calling
> > > sync_global_*(), we iterate that pgd_list thing much more often than
> > > before if I'm not mistaken.
> > 
> > Should not be a problem, from what I have seen this function is not
> > called often on x86-64.  The vmalloc area needs to be synchronized at
> > the top-level there, which is by now P4D (with 4-level paging). And the
> > vmalloc area takes 64 entries, when all of them are populated the
> > function will not be called again.
> 
> Right; it's just that the moment you do trigger it, it'll iterate that
> pgd_list and that is potentially huge. Then again, that's not a new
> problem.
> 
> I suppose we can deal with it if/when it becomes an actual problem.
> 
> I had a quick look and I think it might be possible to make it an RCU
> managed list. We'd have to remove the pgd_list entry in
> put_task_struct_rcu_user(). Then we can play games in sync_global_*()
> and use RCU iteration. New tasks (which can be missed in the RCU
> iteration) will already have a full clone of the PGD anyway.

One of the things on my long-term todo list is to replace mm_struct.mmlist
with an XArray containing all mm_structs.  Then we can use one mark
to indicate maybe-swapped and another mark to indicate ... whatever it
is pgd_list indicates.  Iterating an XArray (whether the entire thing
or with marks) is RCU-safe and faster than iterating a linked list,
so this should solve the problem?
