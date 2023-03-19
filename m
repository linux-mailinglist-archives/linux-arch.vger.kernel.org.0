Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2926C03D2
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCSSpw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Mar 2023 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCSSpv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Mar 2023 14:45:51 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8759011150;
        Sun, 19 Mar 2023 11:45:49 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pdy2J-0000Vs-00; Sun, 19 Mar 2023 19:45:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9B5CAC1B09; Sun, 19 Mar 2023 19:45:36 +0100 (CET)
Date:   Sun, 19 Mar 2023 19:45:36 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 16/36] mips: Implement the new page table range API
Message-ID: <20230319184536.GA6491@alpha.franken.de>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-17-willy@infradead.org>
 <20230315105022.GA9850@alpha.franken.de>
 <ZBIrkW5EB/uHj4sm@casper.infradead.org>
 <20230317152920.GA11653@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317152920.GA11653@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 17, 2023 at 04:29:20PM +0100, Thomas Bogendoerfer wrote:
> On Wed, Mar 15, 2023 at 08:33:21PM +0000, Matthew Wilcox wrote:
> > On Wed, Mar 15, 2023 at 11:50:22AM +0100, Thomas Bogendoerfer wrote:
> > > On Wed, Mar 15, 2023 at 05:14:24AM +0000, Matthew Wilcox (Oracle) wrote:
> > > > Rename _PFN_SHIFT to PFN_PTE_SHIFT.  Convert a few places
> > > > to call set_pte() instead of set_pte_at().  Add set_ptes(),
> > > > update_mmu_cache_range(), flush_icache_pages() and flush_dcache_folio().
> > > 
> > > /local/tbogendoerfer/korg/linux/mm/memory.c: In function ‘set_pte_range’:
> > > /local/tbogendoerfer/korg/linux/mm/memory.c:4290:2: error: implicit declaration of function ‘update_mmu_cache_range’ [-Werror=implicit-function-declaration]
> > >   update_mmu_cache_range(vma, addr, vmf->pte, nr);
> > > 
> > > update_mmu_cache_range() is missing in this patch.
> > 
> > Oops.  And mips was one of the arches I did a test build for!
> > 
> > Looks like we could try to gain some efficiency by passing 'nr' to
> > __update_tlb(), but as far as I can tell, that's only called for r3k and
> > r4k, so maybe it's not worth optimising at this point?
> 
> hmm, not sure if that would help. R4k style TLB has two PTEs mapped
> per TLB entry. So by advancing per page __update_tlb() is called more
> often than needed.

btw. how big is nr going to be ? There are MIPS SoCs out there, which
just have 16 TLBs...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
