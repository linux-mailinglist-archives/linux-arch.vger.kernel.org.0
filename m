Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11F1CDFB2
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgEKPwO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 11:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKPwO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 May 2020 11:52:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B52C061A0C;
        Mon, 11 May 2020 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fgR2V/CO/9l3sT2m4IZfICSNwcHm5fI2cusmiGpz5bc=; b=Q3uhuAi8Znj5rCKf4UbH4yK66i
        R5rhxZT8aqzxuwdJ5y1oEivI3AsYvThrlFC3Q5WXrTvn/fRFQqzGrkJfk5ODEfG/zzW7+0cPqC8/r
        dbBWA2t2lHXCYO1njHg/KronsAe3pDXSvfJNx3h1AHe34N3ok2U8uiLP3mYk8tJDMJByKnWsMDcaf
        OdrcSV1SJGDHsSjb89RfXrrrnymtdouseL/A0QLzCOHfVMzLjt/sBWBMIV3gU0LjYvc3Zj+anqTCK
        XnV+TtcYan0RNagJ3Nskkv8wqmfAOFv7V35uYN9fRfCd00/N1aHqzLBnnC7lo9s5nvByBOntGcLbs
        I7F7ftnQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYAiq-0003Lw-Nh; Mon, 11 May 2020 15:52:04 +0000
Date:   Mon, 11 May 2020 08:52:04 -0700
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
Message-ID: <20200511155204.GW16070@bombadil.infradead.org>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508192000.GB2957@hirez.programming.kicks-ass.net>
 <20200508213407.GT8135@suse.de>
 <20200509092516.GC2957@hirez.programming.kicks-ass.net>
 <20200510011157.GU16070@bombadil.infradead.org>
 <20200511073134.GD2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511073134.GD2957@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 11, 2020 at 09:31:34AM +0200, Peter Zijlstra wrote:
> On Sat, May 09, 2020 at 06:11:57PM -0700, Matthew Wilcox wrote:
> > Iterating an XArray (whether the entire thing
> > or with marks) is RCU-safe and faster than iterating a linked list,
> > so this should solve the problem?
> 
> It can hardly be faster if you want all elements -- which is I think the
> case here. We only call into this if we change an entry, and then we
> need to propagate that change to all.

Of course it can be faster.  Iterating an array is faster than iterating
a linked list because caches.  While an XArray is a segmented array
(so slower than a plain array), it's plainly going to be faster than
iterating a linked list.

