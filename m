Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC670F4AF
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjEXLDE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEXLDD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 07:03:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF562A3;
        Wed, 24 May 2023 04:03:01 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QR7Sl6jPdzTktn;
        Wed, 24 May 2023 18:57:59 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 19:02:58 +0800
Message-ID: <2d609a02-1877-bb4d-a0ef-6ba7c838b7e4@huawei.com>
Date:   Wed, 24 May 2023 19:02:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/4] vmlinux.lds.h: use correct .init.data.* section
 name
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>
References: <20230523165502.2592-1-jszhang@kernel.org>
 <20230523165502.2592-4-jszhang@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230523165502.2592-4-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/5/24 0:55, Jisheng Zhang wrote:
> If building with -fdata-sections on riscv, LD_ORPHAN_WARN will warn
> similar as below:
> 
> riscv64-linux-gnu-ld: warning: orphan section `.init.data.efi_loglevel'
> from `./drivers/firmware/efi/libstub/printk.stub.o' being placed in
> section `.init.data.efi_loglevel'
> 
> I believe this is caused by a a typo:
> init.data.* should be .init.data.*

Fixes tag?

266ff2a8f51f kbuild: Fix asm-generic/vmlinux.lds.h for 
LD_DEAD_CODE_DATA_ELIMINATION

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>


> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   include/asm-generic/vmlinux.lds.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index d1f57e4868ed..371026ca7221 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -688,7 +688,7 @@
>   /* init and exit section handling */
>   #define INIT_DATA							\
>   	KEEP(*(SORT(___kentry+*)))					\
> -	*(.init.data init.data.*)					\
> +	*(.init.data .init.data.*)					\
>   	MEM_DISCARD(init.data*)						\
>   	KERNEL_CTORS()							\
>   	MCOUNT_REC()							\
