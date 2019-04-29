Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497A0EB60
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2019 22:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfD2UKG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Apr 2019 16:10:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UKF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 16:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8bbZyLRBS7B6cXqeb9isQNcVt7Ubs7Me5nvL1c8Ic38=; b=Bjpos/jnVGsgKNA3/A6QH5Fqv
        3jAKzcTPg0LS0aG86fuHqbtUIILUir1hz6rBxB7r7d76Spl89Z8Gcv+dWrFTZI8otdOJIsCuWdGla
        IsGgipLBTNfUaQmfJpybjgj5KZPwYQMNLsrgt41VqbtxdI1uyxgXqxQP/r9t7HTkpv2YTFFQFtjFj
        c2/0WcjJjGr9y26IbUvGg3xsoMGxctAbpUyTmBJ8sWn5pt9/i7RgwGrSJulwzheWOBCwI233+GC5V
        1ZhCLQYcffZvx8ZmGnTglQNAETu+5+3vvAuU+/8uDKGmOPm7ZReqSqA9LrrZIJhi2Lo2GoGhgj1Ek
        g78xqD4+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLCb7-0007U6-Fw; Mon, 29 Apr 2019 20:09:57 +0000
Date:   Mon, 29 Apr 2019 13:09:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Meelis Roos <mroos@linux.ee>,
        Christopher Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190429200957.GB27158@infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com>
 <25cabb7c-9602-2e09-2fe0-cad3e54595fa@linux.ee>
 <20190428081353.GB30901@infradead.org>
 <3908561D78D1C84285E8C5FCA982C28F7E9140BA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7E9140BA@ORSMSX104.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 29, 2019 at 04:58:09PM +0000, Luck, Tony wrote:
> > ia64 has a such a huge number of memory model choices.  Maybe we
> > need to cut it down to a small set that actually work.
> 
> SGI systems had extremely discontiguous memory (they used some high
> order physical address bits in the tens/hundreds of terabyte range for the
> node number ... so there would be a few GBytes of actual memory then
> a huge gap before the next node had a few more Gbytes).
> 
> I don't know of anyone still booting upstream on an SN2, so if we start doing
> serious hack and slash the chances are high that SN2 will be broken (if it isn't
> already).

When I wrote this, I thought of

!NUMA:  flat mem
NUMA:	sparsemem
SN2:	discontig

based on Meelis report.  But now that you mention it, I bet SN2 has
already died slow death from bitrot.  It is so different in places, and
it doesn't seem like anyone care - if people want room sized SGI
machines the Origin is much more sexy (hello Thomas!) :)

So maybe it it time to mark SN2 broken and see if anyone screams?

Without SN2 the whole machvec mess could basically go away - the
only real difference between the remaining machvecs is which iommu
if any we set up.
