Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A533A70F4C4
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjEXLFP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjEXLFM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 07:05:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B931B9;
        Wed, 24 May 2023 04:04:58 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QR7ZS4FLmzLm9b;
        Wed, 24 May 2023 19:02:56 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 19:04:24 +0800
Message-ID: <93960845-2af5-ac2b-c562-d8c89ad961a4@huawei.com>
Date:   Wed, 24 May 2023 19:04:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 4/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Guo Ren <guoren@kernel.org>, Bin Meng <bmeng@tinylab.org>
References: <20230523165502.2592-1-jszhang@kernel.org>
 <20230523165502.2592-5-jszhang@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230523165502.2592-5-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
> From: Zhangjin Wu <falcon@tinylab.org>
> 
> Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for RISC-V, allowing
> the user to enable dead code elimination. In order for this to work,
> ensure that we keep the alternative table by annotating them with KEEP.
> 
> This boots well on qemu with both rv32_defconfig & rv64 defconfig, but
> it only shrinks their builds by ~1%, a smaller config is thereforce
> customized to test this feature:
> 
>            | rv32                   | rv64
>    --------|------------------------|---------------------
>     No DCE | 4460684                | 4893488
>        DCE | 3986716                | 4376400
>     Shrink |  473968 (~10.6%)       |  517088 (~10.5%)
> 
> The config used above only reserves necessary options to boot on qemu
> with serial console, more like the size-critical embedded scenes:
> 
>    - rv64 config: https://pastebin.com/crz82T0s
>    - rv32 config: rv64 config + 32-bit.config
> 
> Here is Jisheng's original commit-msg:
> When trying to run linux with various opensource riscv core on
> resource limited FPGA platforms, for example, those FPGAs with less
> than 16MB SDRAM, I want to save mem as much as possible. One of the
> major technologies is kernel size optimizations, I found that riscv
> does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION, which
> passes -fdata-sections, -ffunction-sections to CFLAGS and passes the
> --gc-sections flag to the linker.
> 
> This not only benefits my case on FPGA but also benefits defconfigs.
> Here are some notable improvements from enabling this with defconfigs:
> 
> nommu_k210_defconfig:
>     text    data     bss     dec     hex
> 1112009  410288   59837 1582134  182436     before
>   962838  376656   51285 1390779  1538bb     after
> 
> rv32_defconfig:
>     text    data     bss     dec     hex
> 8804455 2816544  290577 11911576 b5c198     before
> 8692295 2779872  288977 11761144 b375f8     after
> 
> defconfig:
>     text    data     bss     dec     hex
> 9438267 3391332  485333 13314932 cb2b74     before
> 9285914 3350052  483349 13119315 c82f53     after
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> Co-developed-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Tested-by: Bin Meng <bmeng@tinylab.org>

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> ---
>   arch/riscv/Kconfig              | 1 +
>   arch/riscv/kernel/vmlinux.lds.S | 6 +++---
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8f55aa4aae34..62e84fee2cfd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -115,6 +115,7 @@ config RISCV
>   	select HAVE_KPROBES if !XIP_KERNEL
>   	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>   	select HAVE_KRETPROBES if !XIP_KERNEL
> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>   	select HAVE_MOVE_PMD
>   	select HAVE_MOVE_PUD
>   	select HAVE_PCI
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index e5f9f4677bbf..492dd4b8f3d6 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -85,11 +85,11 @@ SECTIONS
>   	INIT_DATA_SECTION(16)
>   
>   	.init.pi : {
> -		*(.init.pi*)
> +		KEEP(*(.init.pi*))
>   	}
>   
>   	.init.bss : {
> -		*(.init.bss)	/* from the EFI stub */
> +		KEEP(*(.init.bss*))	/* from the EFI stub */
>   	}
>   	.exit.data :
>   	{
> @@ -112,7 +112,7 @@ SECTIONS
>   	. = ALIGN(8);
>   	.alternative : {
>   		__alt_start = .;
> -		*(.alternative)
> +		KEEP(*(.alternative))
>   		__alt_end = .;
>   	}
>   	__init_end = .;
