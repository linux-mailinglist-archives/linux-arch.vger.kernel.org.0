Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F42181CBFC3
	for <lists+linux-arch@lfdr.de>; Sat,  9 May 2020 11:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgEIJZi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 May 2020 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgEIJZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 May 2020 05:25:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6288C061A0C;
        Sat,  9 May 2020 02:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bA5nO5V8ZyRNYM2NOJh3nHt5mHB7m7A6hzO/Xb8C0mA=; b=LqHS/VLYuKSWgHx/3b4w+O5Hre
        mznk17I+H+n7V4tjG+K4HbsbQurnpIFGfHXy5NQYxvY8nEkRe2DplXdtbl947B6niE2R2Q+RoDAp8
        1jmbn0GDUrM1YeuwmzFIJHDKbVSRucfX9eMz29/dmS3lWpqODgM/Aqe8ipHw5RfjPwmHexiU+vtTS
        jZo4P11lUQ6EEyFE6V4xaiwdK0lRNTIlo9OCvFQh6BL3FF7uMzmCL1Jqs0CDO0MFWLqe6qqhg47KH
        w9QIu+x1SzOCiwvZXhc8kpcO85+YQOy7ujwb58mxLpGiVj3d5mCQP5DS55jczRX4P4e02mhXgznn9
        8onTSIOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXLjT-0007YB-Ts; Sat, 09 May 2020 09:25:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33E48301EFB;
        Sat,  9 May 2020 11:25:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23A77203AA832; Sat,  9 May 2020 11:25:16 +0200 (CEST)
Date:   Sat, 9 May 2020 11:25:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
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
Message-ID: <20200509092516.GC2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508192000.GB2957@hirez.programming.kicks-ass.net>
 <20200508213407.GT8135@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508213407.GT8135@suse.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 08, 2020 at 11:34:07PM +0200, Joerg Roedel wrote:
> Hi Peter,
> 
> thanks for reviewing this!
> 
> On Fri, May 08, 2020 at 09:20:00PM +0200, Peter Zijlstra wrote:
> > The only concern I have is the pgd_lock lock hold times.
> > 
> > By not doing on-demand faults anymore, and consistently calling
> > sync_global_*(), we iterate that pgd_list thing much more often than
> > before if I'm not mistaken.
> 
> Should not be a problem, from what I have seen this function is not
> called often on x86-64.  The vmalloc area needs to be synchronized at
> the top-level there, which is by now P4D (with 4-level paging). And the
> vmalloc area takes 64 entries, when all of them are populated the
> function will not be called again.

Right; it's just that the moment you do trigger it, it'll iterate that
pgd_list and that is potentially huge. Then again, that's not a new
problem.

I suppose we can deal with it if/when it becomes an actual problem.

I had a quick look and I think it might be possible to make it an RCU
managed list. We'd have to remove the pgd_list entry in
put_task_struct_rcu_user(). Then we can play games in sync_global_*()
and use RCU iteration. New tasks (which can be missed in the RCU
iteration) will already have a full clone of the PGD anyway.

But like said, something for later I suppose.
