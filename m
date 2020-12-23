Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46682E10F6
	for <lists+linux-arch@lfdr.de>; Wed, 23 Dec 2020 01:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLWA5z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Dec 2020 19:57:55 -0500
Received: from mail.loongson.cn ([114.242.206.163]:46482 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbgLWA5z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Dec 2020 19:57:55 -0500
Received: from ambrosehua-HP-xw6600-Workstation (unknown [196.245.9.36])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr8vWleJfyMEDAA--.4294S2;
        Wed, 23 Dec 2020 08:57:02 +0800 (CST)
Date:   Wed, 23 Dec 2020 08:56:52 +0800
From:   Huang Pei <huangpei@loongson.cn>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Bibo Mao <maobibo@loongson.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: optimise pte dirty/accessed bit setting by
 demand based pte insertion
Message-ID: <20201223005651.bviywoihdzzlm3z6@ambrosehua-HP-xw6600-Workstation>
References: <20201220045535.848591-1-npiggin@gmail.com>
 <20201220045535.848591-4-npiggin@gmail.com>
 <alpine.LSU.2.11.2012211000260.1880@eggly.anvils>
 <1608606460.clzumasfvm.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608606460.clzumasfvm.astroid@bobo.none>
User-Agent: NeoMutt/20171215
X-CM-TRANSID: AQAAf9Dxr8vWleJfyMEDAA--.4294S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4xXr4fXFy5GrWxuFykZrb_yoW5XFyfpF
        WrGan0yan8JF1xtw4Iyw17ZFySvrWfXFZ8XFn0gryjv39xWF97tr4I9ayY9FyDCr4kCa1j
        vF13Xa4DZF4DuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVCF1wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, 
On Tue, Dec 22, 2020 at 01:24:53PM +1000, Nicholas Piggin wrote:
> Excerpts from Hugh Dickins's message of December 22, 2020 4:21 am:
> > Hi Nick,
> > 
> > On Sun, 20 Dec 2020, Nicholas Piggin wrote:
> > 
> >> Similarly to the previous patch, this tries to optimise dirty/accessed
> >> bits in ptes to avoid access costs of hardware setting them.
> >> 
> >> This tidies up a few last cases where dirty/accessed faults can be seen,
> >> and subsumes the pte_sw_mkyoung helper -- it's not just architectures
> >> with explicit software dirty/accessed bits that take expensive faults to
> >> modify ptes.
> >> 
> >> The vast majority of the remaining dirty/accessed faults on kbuild
> >> workloads after this patch are from NUMA migration, due to
> >> remove_migration_pte inserting old/clean ptes.
> > 
> > Are you sure about this patch? It looks wrong to me: because isn't
> > _PAGE_ACCESSED (young) already included in the vm_page_prot __S001 etc?
> > 
> > I haven't checked all instances below, but in general, that's why the
> > existing code tends not to bother to mkyoung, but does sometimes mkold
> > (admittedly confusing).
> 
> There might have been one or two cases where it didn't come directly
> from vm_page_prot, but it was a few rebases and updates ago. I did see
> one or two places where powerpc was taking faults. Good point though I 
> can test again and see, and I might split the patch.
> 
> > 
> > A quick check on x86 and powerpc looks like they do have _PAGE_ACCESSED
> > in there; and IIRC that's true, or ought to be true, of all architectures.
> > 
> > Maybe not mips, which I see you have singled out: I remember going round
> > this loop a few months ago with mips, where strange changes were being
> > proposed to compensate for not having that bit in their vm_page_prot.
> > I didn't follow through to see how that ended up, but I did suggest
> > mips needed to follow the same convention as the other architectures.
> 
> Yeah the main thing is to try get all architectures doing the same thing
> and get rid of that sw_mkyoung too. Given the (Intel) x86 result of the
> heavy micro-fault, I don't think anybody is special and we should 
> require them to follow the same behaviour unless it's proven that one
> needs something different.
> 
> If we can get all arch to set accessed in vm_page_prot and get rid of 
> most of these mkyoung()s then all the better. And it actually looks like
> MIPS may be changing direction:
> 
> https://lore.kernel.org/linux-arch/20200919074731.22372-1-huangpei@loongson.cn/
> 
> What's the chances of that going upstream for the next merge window? It
> seems like the right thing to do.

Any comment on V4:

https://lore.kernel.org/linux-arch/20201019081257.32127-1-huangpei@loongson.cn/

> 
> Thanks,
> Nick

Thanks,
Huang Pei

