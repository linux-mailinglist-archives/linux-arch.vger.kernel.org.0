Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232AA6A99A9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 15:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCCOjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 09:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCCOi6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 09:38:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C22B10439;
        Fri,  3 Mar 2023 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AbaAvafZP1xfr+wB9hanYwLc2el3IrC2XvoYQ5U1N/E=; b=RreymLWFImULYU86P3aG/AZq2o
        JjRhu70Xaa07I+8iwn6nQrXLpOLD349x+44DHxiz3eM9dM89yGnHIUIMkhNTk3oYNhTUqncgNN9up
        JegIbhTXAkPI5e1yORpXwabhGxWHwK/Y1SUZUnu1VJgRA6FIqrXwqSPJ/CkJbKY5OKxrJDOjLL+Qv
        vxyUCmsb/4IzDDtbGClAqKNKOfvPoTakvnpuOQXJaL+Zc48ozdlj3x0pTamPwEFPtrB0BLDNXngFV
        X6F/OP/caX+SsIR34y6pAT4i4eTADKSgwBoX0rUkhgB9zy08/hNJhNNQ9iUNO+20l0cjYVMxAdx4C
        kbkKmktw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pY6YT-003BQ2-It; Fri, 03 Mar 2023 14:38:41 +0000
Date:   Fri, 3 Mar 2023 14:38:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 14/34] microblaze: Implement the new page table range
 API
Message-ID: <ZAIGcXB77IoFw+IR@casper.infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-15-willy@infradead.org>
 <ZAHRsPm89stqHDE5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAHRsPm89stqHDE5@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 03, 2023 at 12:53:36PM +0200, Mike Rapoport wrote:
> On Tue, Feb 28, 2023 at 09:37:17PM +0000, Matthew Wilcox (Oracle) wrote:
> > +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> > +		pte_t *ptep, pte_t pte, unsigned int nr)
> >  {
> > -	*ptep = pte;
> > +	for (;;) {
> > +		set_pte(ptep, pte);
> > +		if (--nr == 0)
> > +			break;
> > +		ptep++;
> > +		pte_val(pte) += 1 << PFN_SHIFT_OFFSET;
> 
> This is the same as
> 
> 		pte_val(pte) += PAGE_SIZE;
> 
> isn't it?

Looks like it.  Based on this:

$ git grep PFN_SHIFT_OFFSET arch/microblaze/
arch/microblaze/include/asm/pgtable.h:#define PFN_SHIFT_OFFSET  (PAGE_SHIFT)
arch/microblaze/include/asm/pgtable.h:#define pte_pfn(x)                (pte_val(x) >> PFN_SHIFT_OFFSET)

I only looked at the definition of pte_pfn(); I didn't look to see how
PFN_SHIFT_OFFSET was defined.  I don't see the need to change it from
what I have though?
