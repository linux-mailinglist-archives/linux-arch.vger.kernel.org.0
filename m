Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E97C6FFC
	for <lists+linux-arch@lfdr.de>; Thu, 12 Oct 2023 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378867AbjJLOFI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Oct 2023 10:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379069AbjJLOFH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Oct 2023 10:05:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00EBB;
        Thu, 12 Oct 2023 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ZBo794QmPX3OSdLUZmZOt9sFww07PNz5cEeadQ3oMTs=; b=JnYKQQ0WWPVh7MTBsIeRXAwbLL
        3Mwulrlk764uN7k72IIbGXPlnVNdxd3DuP4FTtyqiQnYS/iJYcdNTemsLwfEgOqlceI9dvtMMyEHs
        tfsBcDwsfLzDTytRS+2uDlOzsYKG5vky7nyWiDPxhzrcUkNDlNEsbpRfSRlD91Ay1avH0/H8No0jf
        H6IApE3ZYsLteuzasQpZf0ILGJ8UT1mtlrE1sUqLngnW6ErDWU11lQn0s0bwMhqjlgdDLhALloRuP
        FdW1bavmsQroJdnauzfu0g4F4zr+DwIUpGvdzdq6oMChW9V6z73MZ7kHeFDwH58leQykL0PKBuaHJ
        SyuSi4IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqwJA-00HHti-AI; Thu, 12 Oct 2023 14:05:00 +0000
Date:   Thu, 12 Oct 2023 15:05:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v6 06/38] mm: Add default definition of set_ptes()
Message-ID: <ZSf9DNSvgbT9DLmk@casper.infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
 <20230802151406.3735276-7-willy@infradead.org>
 <4c63ee3634ccfed7d687fcbdd9db60663bce481f.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c63ee3634ccfed7d687fcbdd9db60663bce481f.camel@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 12, 2023 at 02:53:05PM +0100, David Woodhouse wrote:
> > +       arch_enter_lazy_mmu_mode();
> > +       for (;;) {
> > +               set_pte(ptep, pte);
> > +               if (--nr == 0)
> > +                       break;
> > +               ptep++;
> > +               pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> > +       }
> > +       arch_leave_lazy_mmu_mode();
> 
> This breaks the Xen PV guest.
> 
> In move_ptes() in mm/mremap.c we arch_enter_lazy_mmu_mode() and then
> loop calling set_pte_at(). Which now (or at least in a few commits time
> when you wire it up for x86 in commit a3e1c9372c9b959) ends up in your
> implementation of set_ptes(), calls arch_enter_lazy_mmu_mode() again,
> and:
> 
> [    0.628700] ------------[ cut here ]------------
> [    0.628718] kernel BUG at arch/x86/kernel/paravirt.c:144!

Easy fix ... don't do that ;-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..f3da8836f689 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -231,9 +231,11 @@ static inline pte_t pte_next_pfn(pte_t pte)
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pte, unsigned int nr)
 {
+	bool multiple = nr > 1;
 	page_table_check_ptes_set(mm, ptep, pte, nr);
 
-	arch_enter_lazy_mmu_mode();
+	if (multiple)
+		arch_enter_lazy_mmu_mode();
 	for (;;) {
 		set_pte(ptep, pte);
 		if (--nr == 0)
@@ -241,7 +243,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		ptep++;
 		pte = pte_next_pfn(pte);
 	}
-	arch_leave_lazy_mmu_mode();
+	if (multiple)
+		arch_leave_lazy_mmu_mode();
 }
 #endif
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)

I think long-term, we should make lazy_mmu_mode nestable.  But this is
a reasonable quick fix.
