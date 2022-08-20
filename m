Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1F659AA73
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 03:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiHTB0a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 21:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiHTB0a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 21:26:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90D108918;
        Fri, 19 Aug 2022 18:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A35666192F;
        Sat, 20 Aug 2022 01:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC76EC433D6;
        Sat, 20 Aug 2022 01:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660958788;
        bh=wZDZtzkUwqxG1wWU3cUt/qF4N4cQ/GD2qYzT2IrE6A8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jeMeO6p2fyPEDLfHRpacUUjK+xt/bFxhhdDXyuzD/xjD7KLDa4ANsKSEyqAWkz6tN
         xbYhMNt/Xno7l0rmMICwnPgFRkQXVRoRsa4cVyT2DoWL1cNvDcPLQ2zPjdgQkFSxTX
         OWoE8hh6dkRW6oUtu3FB2pKr5IrfRyX3ENymWpkA=
Date:   Fri, 19 Aug 2022 18:26:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     quanyang wang <quanyang.wang@windriver.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [V2][PATCH] asm-generic: sections: refactor memory_intersects
Message-Id: <20220819182626.0791628d6f3fcf53fa413a43@linux-foundation.org>
In-Reply-To: <a22358ce-8eb3-cd34-47e1-363ce37e0ae7@windriver.com>
References: <20220819081145.948016-1-quanyang.wang@windriver.com>
        <20220819145100.ad9d08094ab9f345563fc52b@linux-foundation.org>
        <a22358ce-8eb3-cd34-47e1-363ce37e0ae7@windriver.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 20 Aug 2022 08:24:52 +0800 quanyang wang <quanyang.wang@windriver.com> wrote:

> Hi Andrew,
> 
> On 2022/8/20 05:51, Andrew Morton wrote:
> > On Fri, 19 Aug 2022 16:11:45 +0800 quanyang.wang@windriver.com wrote:
> >
> >> From: Quanyang Wang <quanyang.wang@windriver.com>
> >>
> >> There are two problems with the current code of memory_intersects:
> >>
> >> First, it doesn't check whether the region (begin, end) falls inside
> >> the region (virt, vend), that is (virt < begin && vend > end).
> >>
> >> The second problem is if vend is equal to begin, it will return true
> >> but this is wrong since vend (virt + size) is not the last address of
> >> the memory region but (virt + size -1) is. The wrong determination will
> >> trigger the misreporting when the function check_for_illegal_area calls
> >> memory_intersects to check if the dma region intersects with stext region.
> >>
> >> The misreporting is as below (stext is at 0x80100000):
> >>   WARNING: CPU: 0 PID: 77 at kernel/dma/debug.c:1073 check_for_illegal_area+0x130/0x168
> >>   DMA-API: chipidea-usb2 e0002000.usb: device driver maps memory from kernel text or rodata [addr=800f0000] [len=65536]
> >>   Modules linked in:
> >>   CPU: 1 PID: 77 Comm: usb-storage Not tainted 5.19.0-yocto-standard #5
> >>   Hardware name: Xilinx Zynq Platform
> >>    unwind_backtrace from show_stack+0x18/0x1c
> >>    show_stack from dump_stack_lvl+0x58/0x70
> >>    dump_stack_lvl from __warn+0xb0/0x198
> >>    __warn from warn_slowpath_fmt+0x80/0xb4
> >>    warn_slowpath_fmt from check_for_illegal_area+0x130/0x168
> >>    check_for_illegal_area from debug_dma_map_sg+0x94/0x368
> >>    debug_dma_map_sg from __dma_map_sg_attrs+0x114/0x128
> >>    __dma_map_sg_attrs from dma_map_sg_attrs+0x18/0x24
> >>    dma_map_sg_attrs from usb_hcd_map_urb_for_dma+0x250/0x3b4
> >>    usb_hcd_map_urb_for_dma from usb_hcd_submit_urb+0x194/0x214
> >>    usb_hcd_submit_urb from usb_sg_wait+0xa4/0x118
> >>    usb_sg_wait from usb_stor_bulk_transfer_sglist+0xa0/0xec
> >>    usb_stor_bulk_transfer_sglist from usb_stor_bulk_srb+0x38/0x70
> >>    usb_stor_bulk_srb from usb_stor_Bulk_transport+0x150/0x360
> >>    usb_stor_Bulk_transport from usb_stor_invoke_transport+0x38/0x440
> >>    usb_stor_invoke_transport from usb_stor_control_thread+0x1e0/0x238
> >>    usb_stor_control_thread from kthread+0xf8/0x104
> >>    kthread from ret_from_fork+0x14/0x2c
> >>
> >> Refactor memory_intersects to fix the two problems above.
> >>
> >> ...
> > There must be tons of places in the kernel which check to see if two
> > regions overlap at all, I'm not sure why dma debug needs its own one?
> >
> >> --- a/include/asm-generic/sections.h
> >> +++ b/include/asm-generic/sections.h
> >> @@ -110,7 +110,10 @@ static inline bool memory_intersects(void *begin, void *end, void *virt,
> >>   {
> >>   	void *vend = virt + size;
> >>   
> >> -	return (virt >= begin && virt < end) || (vend >= begin && vend < end);
> >> +	if (virt < end && vend > begin)
> >> +		return true;
> >> +
> >> +	return false;
> >>   }
> > These things bend my brain, but all the cases I've mind-tested worked
> > out OK.
> >
> > Now the forever question: is a -stable backport needed?  The bug
> > appears to be six years old, so I guess not.  Can you suggest why it
> > took this long?  Are you doing something unusual?
> 
> Before the commit 1d7db834a027e ("dma-debug: use memory_intersects() 
> directly") , memory_intersects is called only by printk_late_init:
> 
> printk_late_init -> init_section_intersects ->memory_intersects.
> 
> There are few places memory_intersects is called.
> 
> When the commit 1d7db834a027e ("dma-debug: use memory_intersects() 
> directly") is merged and CONFIG_DMA_API_DEBUG is enabled,
> 
> DMA subsystem uses it to check illegal area and trigger the calltrace above.
> 

OK, thanks.  I'll add the cc:stable.  It will get backported further
back than 1d7db834a027e, but that shouldn't be harmful and might even
be helpful.

