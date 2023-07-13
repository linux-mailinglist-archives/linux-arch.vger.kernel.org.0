Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39AE752C0E
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jul 2023 23:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGMVW2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jul 2023 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGMVW2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jul 2023 17:22:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737BB2D54;
        Thu, 13 Jul 2023 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fxcF2LxM1o1X1zKtJxvwKJctPKOxt8kJ6pn0SPqkKNk=; b=bxbOZaBfewQCzYAp/0OvSpKnk7
        IHH2kLe95oKbphdIW/l/btaONo6dfsstnFOBdXvKLUf475O71ULPmAO51FRcsMKLWeLbBUDcEr8VK
        YpZo9rEsPImdJl+F/OnVbNJZsc7vkH5QFfLdPjo5LBazLDaMfMFKeO5cYtmbfjDDuP3/X9CADyOzc
        Hx1HWHSIhwcpjYqUl2jh0q/+CYaf8luyCaIPIQ4cyH2KYwV9h0+qz3SIHfaqZNEizFe3L4T55CYyr
        2/scqQiv/a5AZBn3iVNDFqTV/xIPSwWAiZL5OVkRwRf2wDYMwYKItGOQnhmC2AGEs1PL2hAkS4B7O
        dYvyOjlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qK3lV-000RuB-Jj; Thu, 13 Jul 2023 21:22:21 +0000
Date:   Thu, 13 Jul 2023 22:22:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v5 00/38] New page table range API
Message-ID: <ZLBrDdtQpML+7vXx@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
 <ZK1My5hQYC2Kb6G1@casper.infradead.org>
 <56ca93af-67dc-9d10-d27e-00c8d7c20f1b@linux.ibm.com>
 <ZK//Qnfhx+ihtvlO@casper.infradead.org>
 <75932f85-67c7-8065-9fa0-77d76db19e7b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75932f85-67c7-8065-9fa0-77d76db19e7b@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 13, 2023 at 10:27:21PM +0200, Christian Borntraeger wrote:
> 
> 
> Am 13.07.23 um 15:42 schrieb Matthew Wilcox:
> > On Thu, Jul 13, 2023 at 12:42:44PM +0200, Christian Borntraeger wrote:
> > > 
> > > 
> > > Am 11.07.23 um 14:36 schrieb Matthew Wilcox:
> > > > On Tue, Jul 11, 2023 at 11:07:06AM +0200, Christian Borntraeger wrote:
> > > > > Am 10.07.23 um 22:43 schrieb Matthew Wilcox (Oracle):
> > > > > > This patchset changes the API used by the MM to set up page table entries.
> > > > > > The four APIs are:
> > > > > >        set_ptes(mm, addr, ptep, pte, nr)
> > > > > >        update_mmu_cache_range(vma, addr, ptep, nr)
> > > > > >        flush_dcache_folio(folio)
> > > > > >        flush_icache_pages(vma, page, nr)
> > > > > > 
> > > > > > flush_dcache_folio() isn't technically new, but no architecture
> > > > > > implemented it, so I've done that for them.  The old APIs remain around
> > > > > > but are mostly implemented by calling the new interfaces.
> > > > > > 
> > > > > > The new APIs are based around setting up N page table entries at once.
> > > > > > The N entries belong to the same PMD, the same folio and the same VMA,
> > > > > > so ptep++ is a legitimate operation, and locking is taken care of for
> > > > > > you.  Some architectures can do a better job of it than just a loop,
> > > > > > but I have hesitated to make too deep a change to architectures I don't
> > > > > > understand well.
> > > > > > 
> > > > > > One thing I have changed in every architecture is that PG_arch_1 is now a
> > > > > > per-folio bit instead of a per-page bit.  This was something that would
> > > > > > have to happen eventually, and it makes sense to do it now rather than
> > > > > > iterate over every page involved in a cache flush and figure out if it
> > > > > > needs to happen.
> > > > > 
> > > > > I think we do use PG_arch_1 on s390 for our secure page handling and
> > > > > making this perf folio instead of physical page really seems wrong
> > > > > and it probably breaks this code.
> > > > 
> > > > Per-page flags are going away in the next few years, so you're going to
> > > > need a new design.  s390 seems to do a lot of unusual things.  I wish
> > > > you'd talk to the rest of us more.
> > > 
> > > I understand you point from a logical point of view, but a 4k page frame
> > > is also a hardware defined memory region. And I think not only for us.
> > > How do you want to implement hardware poisoning for example?
> > > Marking the whole folio with PG_hwpoison seems wrong.
> > 
> > For hardware poison, we can't use the page for any other purpose any more.
> > So one of the 16 types of pointer is for hardware poison.  That doesn't
> > seem like it's a solution that could work for secure/insecure pages?
> > 
> > But what I'm really wondering is why you need to transition pages
> > between secure/insecure on a 4kB boundary.  What's the downside to doing
> > it on a 16kB or 64kB boundary, or whatever size has been allocated?
> 
> The export and import for more pages will be more expensive, but I assume that
> we would then also use the larger chunks (e.g. for paging). The more interesting
> problem is that the guest can make a page shared/non-shared on a 4kb granularity.
> 
> Stupid question: can folios be split into folio,single page,folio when needed?

If that's a stupid question, you're going to find the answer utterly
moronic ...

Yes, we have split_folio() today.  However, it can fail if somebody else
has a reference to it, and if it does succeed, we don't really have a
join_folio() operation (we have khugepaged which walks around looking
for small folios it can replace with large folios, but that's not really
what you want).

In the MM of, let's say, 2025, I do intend to support what we might
call a hole in a folio, precisely for hwpoison and it's beginning to
sound a bit like it might work for you too.  So you'd do something like
... 

Allocate a 256MB folio for your VM (probably one of many allocations
you'd do to give your VM some memory).  That sets 65536 page pointers
to the same value.  Then you "secure" all 256MB of it so the
VM can use it all.  Then the VM wants the host to read/write a 16kB
chunk of that, so you allocate a "struct insecure_mem" and set four
of the page pointers to point to that instead (it probably contains
a copy of the original page pointer).  We'd mark the folio as containing
a hole so that the MM knows something unusual is going on.  When you're
done reading/writing the memory, you re-secure it, set the page pointers
back to point to the original folio and free the struct insecure_mem.

Would something like that work for you?  Details TBD, of course.

