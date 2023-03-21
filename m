Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5E6C306F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 12:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCULbK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCULbK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 07:31:10 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF06930DD;
        Tue, 21 Mar 2023 04:31:05 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1peaCj-0003H6-00; Tue, 21 Mar 2023 12:31:01 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0EE4EC1B11; Tue, 21 Mar 2023 12:30:16 +0100 (CET)
Date:   Tue, 21 Mar 2023 12:30:15 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 16/36] mips: Implement the new page table range API
Message-ID: <20230321113015.GA11292@alpha.franken.de>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-17-willy@infradead.org>
 <20230315105022.GA9850@alpha.franken.de>
 <ZBIrkW5EB/uHj4sm@casper.infradead.org>
 <20230317152920.GA11653@alpha.franken.de>
 <20230319184536.GA6491@alpha.franken.de>
 <ZBdtpHnGFIpwpo6D@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBdtpHnGFIpwpo6D@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 19, 2023 at 08:16:36PM +0000, Matthew Wilcox wrote:
> On Sun, Mar 19, 2023 at 07:45:36PM +0100, Thomas Bogendoerfer wrote:
> > On Fri, Mar 17, 2023 at 04:29:20PM +0100, Thomas Bogendoerfer wrote:
> > > hmm, not sure if that would help. R4k style TLB has two PTEs mapped
> > > per TLB entry. So by advancing per page __update_tlb() is called more
> > > often than needed.
> > 
> > btw. how big is nr going to be ? There are MIPS SoCs out there, which
> > just have 16 TLBs...
> 
> Oof.  The biggest we're going to see for now is one less than PTRS_PER_PMD
> (that'd be a PMD-sized allocation that's mapped askew with 1 page in
> one PMD and n-1 pages in the adjacent PMD).  That'd be 511 on x86 and
> I presume something similar on MIPS.  More than 16, for sure.

biggest TLB I could find is 256 entries, which can map 512 pages.

> Now, this isn't a new problem with this patchset.  With fault-around,
> we already call set_pte_at() N times.  And we don't say which ones are
> speculative entries vs the one actually faulted in.

ic

> But let's see if we can fix it.  What if we passed in the vmf?  That would
> give you the actual faulting address, so you'd know to only put the PTE
> into the Linux page tables and not go as far as putting it into the TLB.
> Open to other ideas.

that would help to optimize the case. But update_mmu_cache_range needs to
do __update_tlb() for every page to avoid stale data in TLB. If I understood
correctly only the way how TLB updates are done changed, so there shouldn't
be performance regressions. And optimizing like moving the looping over
the pages into __update_tlb() could be done in a second step.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
