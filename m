Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7859A7FF
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 23:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiHSVvJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 17:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiHSVvI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 17:51:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6BE0ED;
        Fri, 19 Aug 2022 14:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B330B82969;
        Fri, 19 Aug 2022 21:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F27C433D7;
        Fri, 19 Aug 2022 21:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660945862;
        bh=otkJxMUciAkV/iSop9AgWwjsmz2/mTQOowplWkEsqE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bsWzZSgDJq6T0nI0FlnIQaEfJzJLSFiYENmfQcb2Wyw+HCKrWj5o5cdOLTdszWZGq
         qm7aP8rCVgPj59JacSRno0v3TvrMsptcGOTBz2nGKzHJ0acwFOpDkrTRR4iFB7CgXS
         O+60Zr+Gt0Kt+K/uGrDX95jkRoIsDaiMsBoVU7P0=
Date:   Fri, 19 Aug 2022 14:51:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     quanyang.wang@windriver.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V2][PATCH] asm-generic: sections: refactor memory_intersects
Message-Id: <20220819145100.ad9d08094ab9f345563fc52b@linux-foundation.org>
In-Reply-To: <20220819081145.948016-1-quanyang.wang@windriver.com>
References: <20220819081145.948016-1-quanyang.wang@windriver.com>
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

On Fri, 19 Aug 2022 16:11:45 +0800 quanyang.wang@windriver.com wrote:

> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> There are two problems with the current code of memory_intersects:
> 
> First, it doesn't check whether the region (begin, end) falls inside
> the region (virt, vend), that is (virt < begin && vend > end).
> 
> The second problem is if vend is equal to begin, it will return true
> but this is wrong since vend (virt + size) is not the last address of
> the memory region but (virt + size -1) is. The wrong determination will
> trigger the misreporting when the function check_for_illegal_area calls
> memory_intersects to check if the dma region intersects with stext region.
> 
> The misreporting is as below (stext is at 0x80100000):
>  WARNING: CPU: 0 PID: 77 at kernel/dma/debug.c:1073 check_for_illegal_area+0x130/0x168
>  DMA-API: chipidea-usb2 e0002000.usb: device driver maps memory from kernel text or rodata [addr=800f0000] [len=65536]
>  Modules linked in:
>  CPU: 1 PID: 77 Comm: usb-storage Not tainted 5.19.0-yocto-standard #5
>  Hardware name: Xilinx Zynq Platform
>   unwind_backtrace from show_stack+0x18/0x1c
>   show_stack from dump_stack_lvl+0x58/0x70
>   dump_stack_lvl from __warn+0xb0/0x198
>   __warn from warn_slowpath_fmt+0x80/0xb4
>   warn_slowpath_fmt from check_for_illegal_area+0x130/0x168
>   check_for_illegal_area from debug_dma_map_sg+0x94/0x368
>   debug_dma_map_sg from __dma_map_sg_attrs+0x114/0x128
>   __dma_map_sg_attrs from dma_map_sg_attrs+0x18/0x24
>   dma_map_sg_attrs from usb_hcd_map_urb_for_dma+0x250/0x3b4
>   usb_hcd_map_urb_for_dma from usb_hcd_submit_urb+0x194/0x214
>   usb_hcd_submit_urb from usb_sg_wait+0xa4/0x118
>   usb_sg_wait from usb_stor_bulk_transfer_sglist+0xa0/0xec
>   usb_stor_bulk_transfer_sglist from usb_stor_bulk_srb+0x38/0x70
>   usb_stor_bulk_srb from usb_stor_Bulk_transport+0x150/0x360
>   usb_stor_Bulk_transport from usb_stor_invoke_transport+0x38/0x440
>   usb_stor_invoke_transport from usb_stor_control_thread+0x1e0/0x238
>   usb_stor_control_thread from kthread+0xf8/0x104
>   kthread from ret_from_fork+0x14/0x2c
> 
> Refactor memory_intersects to fix the two problems above.
> 
> ...

There must be tons of places in the kernel which check to see if two
regions overlap at all, I'm not sure why dma debug needs its own one?

> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -110,7 +110,10 @@ static inline bool memory_intersects(void *begin, void *end, void *virt,
>  {
>  	void *vend = virt + size;
>  
> -	return (virt >= begin && virt < end) || (vend >= begin && vend < end);
> +	if (virt < end && vend > begin)
> +		return true;
> +
> +	return false;
>  }

These things bend my brain, but all the cases I've mind-tested worked
out OK.

Now the forever question: is a -stable backport needed?  The bug
appears to be six years old, so I guess not.  Can you suggest why it
took this long?  Are you doing something unusual?


While we're in there, I can't resist fixing that typo...

--- a/include/asm-generic/sections.h~asm-generic-sections-refactor-memory_intersects-fix
+++ a/include/asm-generic/sections.h
@@ -97,7 +97,7 @@ static inline bool memory_contains(void
 /**
  * memory_intersects - checks if the region occupied by an object intersects
  *                     with another memory region
- * @begin: virtual address of the beginning of the memory regien
+ * @begin: virtual address of the beginning of the memory region
  * @end: virtual address of the end of the memory region
  * @virt: virtual address of the memory object
  * @size: size of the memory object
_

