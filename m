Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3F26D6776
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjDDPfU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjDDPfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 11:35:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCC83C04;
        Tue,  4 Apr 2023 08:35:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrWyq6t9tz67QSs;
        Tue,  4 Apr 2023 23:34:27 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Apr
 2023 16:35:14 +0100
Date:   Tue, 4 Apr 2023 16:35:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] asm-generic/io.h: suppress endianness warnings for
 readq() and writeq()
Message-ID: <20230404163513.00003b9f@huawei.com>
In-Reply-To: <20230109131153.991322-1-vladimir.oltean@nxp.com>
References: <20230109131153.991322-1-vladimir.oltean@nxp.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon,  9 Jan 2023 15:11:52 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> Commit c1d55d50139b ("asm-generic/io.h: Fix sparse warnings on
> big-endian architectures") missed fixing the 64-bit accessors.
> 
> Arnd explains in the attached link why the casts are necessary, even if
> __raw_readq() and __raw_writeq() do not take endian-specific types.
> 
> Link: https://lore.kernel.org/lkml/9105d6fc-880b-4734-857d-e3d30b87ccf6@app.fastmail.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Found this when about to send an equivalent patch. Not seeing this in linux-next yet
and would be good to clean the resulting warnings up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/asm-generic/io.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 4c44a29b5e8e..d78c3056c98f 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -236,7 +236,7 @@ static inline u64 readq(const volatile void __iomem *addr)
>  
>  	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
>  	__io_br();
> -	val = __le64_to_cpu(__raw_readq(addr));
> +	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
>  	__io_ar(val);
>  	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
>  	return val;
> @@ -287,7 +287,7 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
>  {
>  	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
>  	__io_bw();
> -	__raw_writeq(__cpu_to_le64(value), addr);
> +	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
>  	__io_aw();
>  	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
>  }

