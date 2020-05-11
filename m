Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83A91CE115
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 19:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgEKRCe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 13:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbgEKRCd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2020 13:02:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A3FC061A0C;
        Mon, 11 May 2020 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hy07Ws6ek9XvAGJzrptGNVmN+sgjs2KIi/oCXeVqo9E=; b=c3U4wuy0ttwAXhwRpOyq47EcOS
        R6BOJ5hTKfV9cW8xiSDAIUq0HXFikJF4ynwAq2vypi9olfTDqkb8ufZMT5CdzATb4pwn0Qk9J7SPT
        7BH7P/aQYee+IokeeKf35kRg9Wmd7JuXGNX9J+h1igQwb86BgPLoijcEkBNddzK2nN5fn85jy8Vyt
        +SJyixpxAMl+sc5RquVfvSaqZYi5y8y8ukaTlE7TPPhj7mPTbxr6gjm9iNY3oHOE346HsINHrmgF9
        px9am0ZSFLIKDsibuJ5+DooCPkne6W5heGMWIZYD5BJEurvKKcpF722OXItxoehCgllZpODKHto9m
        mF7LkNEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYBol-0002Do-R6; Mon, 11 May 2020 17:02:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC87C304123;
        Mon, 11 May 2020 19:02:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBF5329D8226A; Mon, 11 May 2020 19:02:12 +0200 (CEST)
Date:   Mon, 11 May 2020 19:02:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20200511170212.GI2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508192000.GB2957@hirez.programming.kicks-ass.net>
 <20200508213407.GT8135@suse.de>
 <20200509092516.GC2957@hirez.programming.kicks-ass.net>
 <20200510011157.GU16070@bombadil.infradead.org>
 <20200511073134.GD2957@hirez.programming.kicks-ass.net>
 <20200511155204.GW16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511155204.GW16070@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 11, 2020 at 08:52:04AM -0700, Matthew Wilcox wrote:
> On Mon, May 11, 2020 at 09:31:34AM +0200, Peter Zijlstra wrote:
> > On Sat, May 09, 2020 at 06:11:57PM -0700, Matthew Wilcox wrote:
> > > Iterating an XArray (whether the entire thing
> > > or with marks) is RCU-safe and faster than iterating a linked list,
> > > so this should solve the problem?
> > 
> > It can hardly be faster if you want all elements -- which is I think the
> > case here. We only call into this if we change an entry, and then we
> > need to propagate that change to all.
> 
> Of course it can be faster.  Iterating an array is faster than iterating
> a linked list because caches.  While an XArray is a segmented array
> (so slower than a plain array), it's plainly going to be faster than
> iterating a linked list.

Fair enough, mostly also because the actual work (setting a single PTE)
doesn't dominate in this case.
