Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE2C599749
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347724AbiHSI0i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347591AbiHSI0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA8BE2C50;
        Fri, 19 Aug 2022 01:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC33361720;
        Fri, 19 Aug 2022 08:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B64C433B5;
        Fri, 19 Aug 2022 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660897595;
        bh=RYj2grvMG9j2SUGz8E/c2XrUD5h+FZEHF8YqnB+FTAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fIdFU/7ZgYJbONIhoQmqexHzedb9Bpj7zZoHo57Ay4NsEXTsXSB8skHujQR9G/8KZ
         6hm9oNI3t8wFIUS/Xb6OH7Kqm+TeVjXap8q03EUA1Jl0dd7F2xZAkl5Nh8OaD/D0mC
         i0QSP7gPTz/27V6D1zeeLmUfv6zf6U0JxZu4dDHecVndbI6rP0EhWTP1lCqgh8rlgu
         txt5TnruH489GkE8Af76LTHh0yzpw0P6+O20IIWgtWR7LKiS94mrodCMYjVKMZkdQe
         +3ZQkbXbmV+lGyMgyyupScClEYjUhG9sJfc9wnrX89HOdMzkLgBZojDg4tfj86eNoT
         /uHpKXCIdN4vg==
Received: by mail-wr1-f48.google.com with SMTP id u14so4316669wrq.9;
        Fri, 19 Aug 2022 01:26:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo2IiAOQ8blkDLCJuv9w4Q5IPJwI8jkhL+6thvPX1IWKnSbCaGC0
        eEU9xk+PGJJNc4ZIWGWT0Ge5yB5tqtm5pZuWwjw=
X-Google-Smtp-Source: AA6agR7pEY5ldzvjKu98k8qf/5NTMXshYKyJ8n2/LsNzZw3Db43jkXvlCVhaBACaSxkWHn+HNsRgpa4ZR4Q1q2auq/4=
X-Received: by 2002:adf:ebd2:0:b0:222:cd3f:cf9 with SMTP id
 v18-20020adfebd2000000b00222cd3f0cf9mr3548689wrn.598.1660897593447; Fri, 19
 Aug 2022 01:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220819081145.948016-1-quanyang.wang@windriver.com>
In-Reply-To: <20220819081145.948016-1-quanyang.wang@windriver.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 Aug 2022 10:26:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGA7O5g4PgO7jm32ZpaV3V=Hcx17DhcAHuBd_2KZbrPRQ@mail.gmail.com>
Message-ID: <CAMj1kXGA7O5g4PgO7jm32ZpaV3V=Hcx17DhcAHuBd_2KZbrPRQ@mail.gmail.com>
Subject: Re: [V2][PATCH] asm-generic: sections: refactor memory_intersects
To:     quanyang.wang@windriver.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 19 Aug 2022 at 10:12, <quanyang.wang@windriver.com> wrote:
>
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
> Fixes: 979559362516 ("asm/sections: add helpers to check for section data")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
> V1 ---> V2:
> Add the consideration of the condition that one falls inside another
> which is noticed by Ard.
> ---
>  include/asm-generic/sections.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index d0f7bdd2fdf23..c51b3e7925cdf 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -110,7 +110,10 @@ static inline bool memory_intersects(void *begin, void *end, void *virt,
>  {
>         void *vend = virt + size;
>
> -       return (virt >= begin && virt < end) || (vend >= begin && vend < end);
> +       if (virt < end && vend > begin)
> +               return true;
> +
> +       return false;
>  }
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
