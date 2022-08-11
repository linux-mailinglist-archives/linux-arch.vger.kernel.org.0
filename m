Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF8758F8E8
	for <lists+linux-arch@lfdr.de>; Thu, 11 Aug 2022 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiHKIRN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Aug 2022 04:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiHKIRK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2022 04:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2B61DB4;
        Thu, 11 Aug 2022 01:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2050661541;
        Thu, 11 Aug 2022 08:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CB6C43149;
        Thu, 11 Aug 2022 08:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660205827;
        bh=SWqReYFq/QtMkn1WkoyKVT8HJ02O10COqLcZPEesbgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JjG4ZQiEYfLperzvxK3ZDoo/PbAC6M+atROAwh4lwaR35iPMwxXfG5Hnt7kRoHL9K
         pH01FfH5MGr5EsOs477czDsj3rFHKV1BtydRg5Gx55Nb9cj49+wbL5BPXKJahC9M9u
         JSDheXUkDdQzSj9eMjrHv4xrGPI2PwrRTLnuJFlvFQxrMLDcPvbdYwLFEHcWpfTYPh
         sqivLzh4h4eGarkkZej9ht7x1tOn5sIWR6qByI8KN4AN4DxQsFTQoF2+aIKepFHDFV
         QivfX983CRdo+5be+jXeGKLVJrd2myd04PG/28dGeVWClRdg2XCDHn62J39vZmzhiX
         r09b8fU47GP6A==
Received: by mail-wr1-f49.google.com with SMTP id bv3so20445948wrb.5;
        Thu, 11 Aug 2022 01:17:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo3n/yka5FYYp8LuDJmJXQYtXGEpdr2+43V/u6ijx1RZh9vNz3sg
        zutLmqmeMIbfcxxKDrLrz/e2XnwFkTwm8BwXpPY=
X-Google-Smtp-Source: AA6agR6qZvmthof16QLhprS3Jl4HmQGtReowEcFD8kWNfLAJkn6JgRhDScSRpy4eSPyeos7EgC+YS+5NXetTMKZVEkE=
X-Received: by 2002:a5d:5a9d:0:b0:21b:8247:7ec4 with SMTP id
 bp29-20020a5d5a9d000000b0021b82477ec4mr18320750wrb.561.1660205825684; Thu, 11
 Aug 2022 01:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220811063105.2553381-1-quanyang.wang@windriver.com>
In-Reply-To: <20220811063105.2553381-1-quanyang.wang@windriver.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 11 Aug 2022 10:16:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHxeGjbYXhXpgRBM60Hobo+0K2JkjEtm+7kzDOYobSmNA@mail.gmail.com>
Message-ID: <CAMj1kXHxeGjbYXhXpgRBM60Hobo+0K2JkjEtm+7kzDOYobSmNA@mail.gmail.com>
Subject: Re: [PATCH] asm/sections: fix the determination of the end of the
 memory region
To:     quanyang.wang@windriver.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 11 Aug 2022 at 08:31, <quanyang.wang@windriver.com> wrote:
>
> From: Quanyang Wang <quanyang.wang@windriver.com>
>
> If using "vend >= begin" to judge if two memory regions intersects, vend
> should be the end of the memory region, so it should be "virt + size -1"
> instead of "virt + size".
> The wrong determination of the end triggers the misreporting as below when
> the dma debug function "check_for_illegal_area" calls memory_intersects to
> check if the dma region intersects with stext region.
>
> Calltrace (stext is at 0x80100000):
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
> Fixes: 979559362516 ("asm/sections: add helpers to check for section data")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  include/asm-generic/sections.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index d0f7bdd2fdf2..f7171b4f5bfd 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -108,7 +108,7 @@ static inline bool memory_contains(void *begin, void *end, void *virt,
>  static inline bool memory_intersects(void *begin, void *end, void *virt,
>                                      size_t size)
>  {
> -       void *vend = virt + size;
> +       void *vend = virt + size - 1;
>
>         return (virt >= begin && virt < end) || (vend >= begin && vend < end);

This test looks flawed to me for another reason as well: it only
checks whether the start /or/ the end of (virt, virt+size) falls
inside the area, so if the area is covered completely (in which case
the intersection of the two will be equal to the area), this will
return false erroneously.
