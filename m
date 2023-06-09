Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBCF729FCB
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbjFIQNv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 12:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjFIQNq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 12:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC85E2D44;
        Fri,  9 Jun 2023 09:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E214659B1;
        Fri,  9 Jun 2023 16:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35ECC433EF;
        Fri,  9 Jun 2023 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686327224;
        bh=LhBOPmVWiuPUJIE5GrF/M4tdGkC4quufp7Koq2ZDGQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sg7lp6e/IiNPD5JZOY2U2ZfOH3jGxOK/5t1Fco/wfXnTnzJRbdGtIaN0kki2GKVag
         mYdVFhj91b2lEL9xr/NI8Bk6b7G2j3Pf3YjeSG1KkxytgyJmBCT/DuHNT4HuC38IN3
         VJ5dIKqZ7IxAXqy63dTCTzwljHXhuej2nJiZhhRmYFJN9k/QpQmZFGlws6i9fBXBBD
         LPXYdoTJGCxa25JIKc/sZuGaTNssbzn8FPFJeMVWDCPJBU9OLKRBR+RmTTmk91BcVv
         ICp+DoN7JCyd9LxGtesYVwQxhUDvnN0uNv/3h1CJmaglmet4taUfTfA8b/jNAAT0tj
         Eo1HhC5I2OExg==
Date:   Fri, 9 Jun 2023 09:13:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        will@kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org, sfr@canb.auug.org.au,
        mpe@ellerman.id.au, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, linux-parisc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 5/12] percpu: Add {raw,this}_cpu_try_cmpxchg()
Message-ID: <20230609161340.GA4019185@dev-arch.thelio-3990X>
References: <20230531132323.587480729@infradead.org>
 <f320f021-88c4-c5c9-0781-c82d0b88f67d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f320f021-88c4-c5c9-0781-c82d0b88f67d@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Konrad,

On Fri, Jun 09, 2023 at 06:10:38PM +0200, Konrad Dybcio wrote:
> 
> 
> On 31.05.2023 15:08, Peter Zijlstra wrote:
> > Add the try_cmpxchg() form to the per-cpu ops.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> +CC Nathan, llvm list
> 
> Hi all, this patch seems to break booting on Qualcomm ARM64 platforms
> when compiled with clang (GCC works fine) for some reason..:
> 
> next-20230605 - works
> next-20230606 - doesn't
> 
> grev -m 1 dc4e51fd9846 on next-20230606 - works again
> b4 shazam <this_msgid> -P 1-4 - still works
> b4 shazam <this_msgid> -P 5 - breaks
> 
> Confirmed on at least Qualcomm QCM2290, SM8250.
> 
> Checking the serial console, it hits a BUG_ON:
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at mm/vmalloc.c:1638!
> [    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted [snip]
> [    0.000000] Hardware name: Qualcomm Technologies, Inc. Robotics RB1 (DT)
> [    0.000000] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.000000] pc : alloc_vmap_area+0xafc/0xb08
> [    0.000000] lr : alloc_vmap_area+0x9e4/0xb08
> [    0.000000] sp : ffffa50137f53c20
> [    0.000000] x29: ffffa50137f53c60 x28: ffffa50137f30c18 x27: 0000000000000000
> [    0.000000] x26: 0000000000007fff x25: ffff800080000000 x24: 000000000000cfff
> [    0.000000] x23: ffffffffffff8000 x22: ffffa50137fef970 x21: fffffbfff0000000
> [    0.000000] x20: ffff022982003208 x19: ffff0229820031f8 x18: ffffa50137f64f70
> [    0.000000] x17: ffffa50137fef980 x16: ffffa501375e6d08 x15: 0000000000000001
> [    0.000000] x14: ffffa5013831e1a0 x13: ffffa50137f30c18 x12: 0000000000402dc2
> [    0.000000] x11: 0000000000000000 x10: ffff022982003018 x9 : ffffa5013831e188
> [    0.000000] x8 : ffffcb55ff003228 x7 : 0000000000000000 x6 : 0000000000000048
> [    0.000000] x5 : 0000000000000000 x4 : ffffa50137f53bd0 x3 : ffffa50136490000
> [    0.000000] x2 : 0000000000000001 x1 : ffffa5013831e190 x0 : ffff022982003208
> [    0.000000] Call trace:
> [    0.000000]  alloc_vmap_area+0xafc/0xb08
> [    0.000000]  __get_vm_area_node+0x108/0x1e8
> [    0.000000]  __vmalloc_node_range+0x1fc/0x728
> [    0.000000]  __vmalloc_node+0x5c/0x70
> [    0.000000]  init_IRQ+0x90/0x11c
> [    0.000000]  start_kernel+0x1ac/0x3bc
> [    0.000000]  __primary_switched+0xc4/0xcc
> [    0.000000] Code: f000e300 91062000 943bd9ba 17ffff8f (d4210000)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> 
> Compiled with clang 15.0.7 from Arch repos, with
> make ARCH=arm64 LLVM=1

Thanks a lot for testing with LLVM, submitting this report, and doing a
bisect. I sent a patch to fix this a couple of days ago and Peter pushed
it to -tip today, so it should be in the next -next release:

https://git.kernel.org/tip/093d9b240a1fa261ff8aeb7c7cc484dedacfda53

Cheers,
Nathan
