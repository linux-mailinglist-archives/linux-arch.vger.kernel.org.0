Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC248E97F
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jan 2022 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiANL4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jan 2022 06:56:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35104 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiANL4o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jan 2022 06:56:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9AFF61EFA;
        Fri, 14 Jan 2022 11:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A65FC36AE5;
        Fri, 14 Jan 2022 11:56:42 +0000 (UTC)
Date:   Fri, 14 Jan 2022 11:56:39 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, huangguangbin2@huawei.com
Subject: Re: [PATCH] asm-generic: Add missing brackets for io_stop_wc macro
Message-ID: <YeFk9w9AFJxkZziq@arm.com>
References: <20220114105857.126300-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114105857.126300-1-wangxiongfeng2@huawei.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 14, 2022 at 06:58:57PM +0800, Xiongfeng Wang wrote:
> After using io_stop_wc(), drivers reports following compile error when
> compiled on X86.
> 
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function ‘hns3_tx_push_bd’:
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:2058:12: error: expected ‘;’ before ‘(’ token
>     io_stop_wc();
>               ^
> It is because I missed to add the brackets after io_stop_wc macro. So
> let's add the missing brackets.
> 
> Fixes: d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")
> Reported-by: Guangbin Huang <huangguangbin2@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  include/asm-generic/barrier.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 3d503e74037f..fd7e8fbaeef1 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -285,7 +285,7 @@ do {									\
>   * write-combining memory accesses before this macro with those after it.
>   */
>  #ifndef io_stop_wc
> -#define io_stop_wc do { } while (0)
> +#define io_stop_wc() do { } while (0)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Arnd, do you plan to take this fix or you'd like me to?

Thanks.

-- 
Catalin
