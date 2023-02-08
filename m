Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59AB68EDD9
	for <lists+linux-arch@lfdr.de>; Wed,  8 Feb 2023 12:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBHLXv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Feb 2023 06:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBHLXv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2023 06:23:51 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4FB74B;
        Wed,  8 Feb 2023 03:23:20 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 9D4FA20008;
        Wed,  8 Feb 2023 11:23:09 +0000 (UTC)
Message-ID: <ba99ed28-61e4-4acd-ce17-338f5a49ef26@ghiti.fr>
Date:   Wed, 8 Feb 2023 12:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: API for setting multiple PTEs at once
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
Content-Language: en-US
In-Reply-To: <Y+K0O35jNNzxiXE6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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


riscv stores its pfn at PAGE_PFN_SHIFT instead of PAGE_SHIFT, se we need 
to reimplement set_ptes. But I have been playing with your patchset and 
we never fall into the case where set_ptes is called with nr > 1, any 
idea why? I booted a large ubuntu defconfig and launched 
will_it_scale.page_fault4.

I'll come up with the proper implementation of set_ptes anyway soon.

Thanks,

Alex


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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
