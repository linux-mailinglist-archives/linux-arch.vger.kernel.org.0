Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3D5695FF0
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 10:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjBNJ4r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 04:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjBNJ4L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 04:56:11 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEE724CB5;
        Tue, 14 Feb 2023 01:55:53 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id AB0771BF20A;
        Tue, 14 Feb 2023 09:55:43 +0000 (UTC)
Message-ID: <0bf59207-838b-2a0b-a95e-925a6bbf1913@ghiti.fr>
Date:   Tue, 14 Feb 2023 10:55:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: API for setting multiple PTEs at once
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, linux-arch@vger.kernel.org
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
References: <Y9wnr8SGfGGbi/bk@casper.infradead.org>
 <Y+K0O35jNNzxiXE6@casper.infradead.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Y+K0O35jNNzxiXE6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Matthew,

On 2/7/23 21:27, Matthew Wilcox wrote:
> On Thu, Feb 02, 2023 at 09:14:23PM +0000, Matthew Wilcox wrote:
>> For those of you not subscribed, linux-mm is currently discussing
>> how best to handle page faults on large folios.  I simply made it work
>> when adding large folio support.  Now Yin Fengwei is working on
>> making it fast.
> OK, here's an actual implementation:
>
> https://lore.kernel.org/linux-mm/20230207194937.122543-3-willy@infradead.org/
>
> It survives a run of xfstests.  If your architecture doesn't store its
> PFNs at PAGE_SHIFT, you're going to want to implement your own set_ptes(),
> or you'll see entirely the wrong pages mapped into userspace.  You may
> also wish to implement set_ptes() if it can be done more efficiently
> than __pte(pteval(pte) + PAGE_SIZE).
>
> Architectures that implement things like flush_icache_page() and
> update_mmu_cache() may want to propose batched versions of those.
> That's alpha, csky, m68k, mips, nios2, parisc, sh,
> arm, loongarch, openrisc, powerpc, riscv, sparc and xtensa.
> Maintainers BCC'd, mailing lists CC'd.
>
> I'm happy to collect implementations and submit them as part of a v6.


Please find below the riscv implementation for set_ptes:

diff --git a/arch/riscv/include/asm/pgtable.h 
b/arch/riscv/include/asm/pgtable.h
index ebee56d47003..10bf812776a4 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -463,6 +463,20 @@ static inline void set_pte_at(struct mm_struct *mm,
         __set_pte_at(mm, addr, ptep, pteval);
  }

+#define set_ptes set_ptes
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+                           pte_t *ptep, pte_t pte, unsigned int nr)
+{
+       for (;;) {
+               set_pte_at(mm, addr, ptep, pte);
+               if (--nr == 0)
+                       break;
+               ptep++;
+               addr += PAGE_SIZE;
+               pte = __pte(pte_val(pte) + (1 << _PAGE_PFN_SHIFT));
+       }
+}
+
  static inline void pte_clear(struct mm_struct *mm,
         unsigned long addr, pte_t *ptep)
  {


Thanks,

Alex

