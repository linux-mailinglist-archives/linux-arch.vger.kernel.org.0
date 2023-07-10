Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5903C74DF2A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGJUY1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjGJUYX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:24:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4CB198;
        Mon, 10 Jul 2023 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G0ut9Msx8avXgkOpqAa+A7Dar6d8OWfnht1FICkF8CU=; b=FOqO3cdm12VAe6nUmn7GX8ljm1
        IVWHYgztJseuOAdpb0Kl7UTesY1zGNKYMs5e5EBFqrZ0ooTqGXwH4QeLUQbdv8JXL7fENKqEe6VjM
        SQXo/iyUUboIV1vXsJOTyGvNvvsYwJ5gWy8hUjxBQylojeQqUVVDk4Ovc3cmoCOmdphg5mAVEP7Uf
        kRZ+dXmJA1uRht41tVmc5AzHGP5F+rFYYcIAo7BH8Z6T/u7Q9ThfhPZILyYI1SpBKAx3x4ScvmVJX
        IrVLMuAKMIcKwmG/6tZECnJSU/lD3HpvUDf7IhlthMI3jSUs6ymuZ6XM25REdQ3J2tYwnjueQOVet
        T7JE38Vg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxQd-00Etrn-OE; Mon, 10 Jul 2023 20:24:15 +0000
Date:   Mon, 10 Jul 2023 21:24:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 20/36] powerpc: Implement the new page table range API
Message-ID: <ZKxo79JYjEvMGAW3@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-21-willy@infradead.org>
 <1743d96f-8efe-0127-2cae-7368ce0eb2e6@csgroup.eu>
 <c7f08247-8bcd-184c-5e06-91f91257f1f6@csgroup.eu>
 <ZBPizB6TmDp0psOl@casper.infradead.org>
 <eb8ad2f2-06ae-4daf-5163-11b950e640ad@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8ad2f2-06ae-4daf-5163-11b950e640ad@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 18, 2023 at 09:19:04AM +0000, Christophe Leroy wrote:
> void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> 		pte_t pte, unsigned int nr)
> {
> 	pgprot_t prot;
> 	unsigned long pfn;
> 	/*
> 	 * Make sure hardware valid bit is not set. We don't do
> 	 * tlb flush for this update.
> 	 */
> 	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
> 
> 	/* Note: mm->context.id might not yet have been assigned as
> 	 * this context might not have been activated yet when this
> 	 * is called.
> 	 */
> 	pte = set_pte_filter(pte);
> 
> 	prot = pte_pgprot(pte);
> 	pfn = pte_pfn(pte);
> 	/* Perform the setting of the PTE */
> 	for (;;) {
> 		__set_pte_at(mm, addr, ptep, pfn_pte(pfn, prot), 0);
> 		if (--nr == 0)
> 			break;
> 		ptep++;
> 		pfn++;
> 		addr += PAGE_SIZE;
> 	}
> }

I'd rather the per-arch code were as similar to each other and the
generic implementation as possible.  Fewer bugs that way and easier
for other people to make changes that have to touch every architecture
in the future.
