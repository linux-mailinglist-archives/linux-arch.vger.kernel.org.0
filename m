Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7786AB13A
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 16:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCEP2z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 10:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCEP2x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 10:28:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1CCB74D;
        Sun,  5 Mar 2023 07:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xNsREuPqCjUzI76ZNq/RWClQATGAeDXUSMCAtkKEC20=; b=I0enYYq8L52f98/wTKN4rWWw2d
        /HSNb9zqyTfNFnxO+L92D/JnfNEPMarTdtw/OUd3skeCGm3Vx74LJSjVY21taXAIyLmRqV1hT6Wgt
        CVEzlX0JtXH7c1Pq5HIMTcA2GrFQ5veat3KJNvFdi+98jQoPImSSSMP0tOI7eWP5nwWyNgcg1Ykh/
        BFfga+BBP8Y688TUQEG/OtU7AohVYpv3XPWGftd7XPvMkvi8RLWymeD41v1y10ZY0jrWbSc3NVFmQ
        PJAEwJp+JMevUILJK4+UUGBwmbLXGmaX4uQJNy8+FCIPlKRUK89MFZVgEndkZ4Wjqs286q1PFp+vp
        qfiEsIPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYqI2-004ZJe-6p; Sun, 05 Mar 2023 15:28:46 +0000
Date:   Sun, 5 Mar 2023 15:28:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v3 13/34] m68k: Implement the new page table range API
Message-ID: <ZAS1Lq6//oO/0PXe@casper.infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-14-willy@infradead.org>
 <CAMuHMdW5TtUeZDmtHvxw+DxqUADC-OCW=tHE2Gptcoie62T+4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW5TtUeZDmtHvxw+DxqUADC-OCW=tHE2Gptcoie62T+4w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 05, 2023 at 11:16:13AM +0100, Geert Uytterhoeven wrote:
> > +               while (nr--) {
> > +                       __asm__ __volatile__("nop\n\t"
> > +                                            ".chip 68040\n\t"
> > +                                            "cpushp %%bc,(%0)\n\t"
> > +                                            ".chip 68k"
> > +                                            : : "a" (paddr + nr * PAGE_SIZE));
> 
> As gcc (9.5.0) keeps on calculating "paddr + nr * PAGE_SIZE"
> inside the loop (albeit using a shift instead of a multiplication),
> please use "paddr" here, followed by "paddr += PAGE_SIZE;".

Thanks.  So this?

+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -235,13 +235,14 @@ static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
        } else if (CPU_IS_040_OR_060) {
                unsigned long paddr = __pa(vaddr);
 
-               while (nr--) {
+               do {
                        __asm__ __volatile__("nop\n\t"
                                             ".chip 68040\n\t"
                                             "cpushp %%bc,(%0)\n\t"
                                             ".chip 68k"
-                                            : : "a" (paddr + nr * PAGE_SIZE));
-               }
+                                            : : "a" (paddr));
+                       paddr += PAGE_SIZE;
+               } while (--nr);
        } else {
                unsigned long _tmp;
                __asm__ __volatile__("movec %%cacr,%0\n\t"

Also, I noticed that I broke sun3.  It puts the PFN in bits 0-n instead
of 12-n.  New patch coming soon.
