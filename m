Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8966C04BA
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 21:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCSUQk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Mar 2023 16:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCSUQj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Mar 2023 16:16:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407151B552;
        Sun, 19 Mar 2023 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wRqe5vhNuDvhiga63gy5h46j0EPNOE641nmmHAf6FaI=; b=pCUH/YZz/lU+SgEhgoEzLz+lLj
        /Qm5GtTRnpRcdY1BxLzMRD3AEnxa5FXFcW+vN1e4cvj8ONuA5cgs4/4VVIj0K/1OyyI2Xg4HJHJwr
        NpTE8hnH70C8TPXWhBxKDCUi7H8jD/PXMPEhjlpkrMGD7l+y3KWBFAYdoJpr9w2oyXl78pMo9A+B1
        QNCUZUDNAE97Uc+aeahPuGJG61pV+jsiGY5HRO3DIiY8sieV8LV4Sq0v3egSK8lAoJjTnqZd86dmj
        0Ws/GeNb2zzXk3IVFyD9/mRTYQoPQ1umqi1+NhDIDil+By5ywmrm7HyzlcSkmqB6bc2RdiQE41cNp
        FwjoJQ4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pdzSG-000MRs-5r; Sun, 19 Mar 2023 20:16:36 +0000
Date:   Sun, 19 Mar 2023 20:16:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 16/36] mips: Implement the new page table range API
Message-ID: <ZBdtpHnGFIpwpo6D@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-17-willy@infradead.org>
 <20230315105022.GA9850@alpha.franken.de>
 <ZBIrkW5EB/uHj4sm@casper.infradead.org>
 <20230317152920.GA11653@alpha.franken.de>
 <20230319184536.GA6491@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319184536.GA6491@alpha.franken.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 19, 2023 at 07:45:36PM +0100, Thomas Bogendoerfer wrote:
> On Fri, Mar 17, 2023 at 04:29:20PM +0100, Thomas Bogendoerfer wrote:
> > hmm, not sure if that would help. R4k style TLB has two PTEs mapped
> > per TLB entry. So by advancing per page __update_tlb() is called more
> > often than needed.
> 
> btw. how big is nr going to be ? There are MIPS SoCs out there, which
> just have 16 TLBs...

Oof.  The biggest we're going to see for now is one less than PTRS_PER_PMD
(that'd be a PMD-sized allocation that's mapped askew with 1 page in
one PMD and n-1 pages in the adjacent PMD).  That'd be 511 on x86 and
I presume something similar on MIPS.  More than 16, for sure.

Now, this isn't a new problem with this patchset.  With fault-around,
we already call set_pte_at() N times.  And we don't say which ones are
speculative entries vs the one actually faulted in.

But let's see if we can fix it.  What if we passed in the vmf?  That would
give you the actual faulting address, so you'd know to only put the PTE
into the Linux page tables and not go as far as putting it into the TLB.
Open to other ideas.
