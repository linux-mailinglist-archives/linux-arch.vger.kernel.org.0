Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1682460C128
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 03:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiJYBkp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 21:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiJYBk1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 21:40:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A78AA3DC;
        Mon, 24 Oct 2022 18:20:23 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MxDZR6vvJzJn1m;
        Tue, 25 Oct 2022 09:17:35 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 09:20:20 +0800
Message-ID: <f0785930-8f2a-9d09-4dbf-545d11994cbe@huawei.com>
Date:   Tue, 25 Oct 2022 09:20:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V6 01/11] riscv: elf_kexec: Fixup compile warning
To:     <guoren@kernel.org>, <arnd@arndb.de>, <palmer@rivosinc.com>,
        <tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
        <conor.dooley@microchip.com>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <mark.rutland@arm.com>,
        <zouyipeng@huawei.com>, <bigeasy@linutronix.de>,
        <David.Laight@aculab.com>, <chenzhongjin@huawei.com>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
References: <20221002012451.2351127-1-guoren@kernel.org>
 <20221002012451.2351127-2-guoren@kernel.org>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <20221002012451.2351127-2-guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



在 2022/10/2 9:24, guoren@kernel.org 写道:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> If CRYTPO or CRYPTO_SHA256 or KEXE_FILE is not enabled, then:
> 
> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1
> O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/
> 
> ../arch/riscv/kernel/elf_kexec.c: In function 'elf_kexec_load':
> ../arch/riscv/kernel/elf_kexec.c:185:23: warning: variable
> 'kernel_start' set but not used [-Wunused-but-set-variable]
>   185 |         unsigned long kernel_start;
>       |                       ^~~~~~~~~~~~
> 
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/riscv/kernel/elf_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index 0cb94992c15b..4b9264340b78 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -198,7 +198,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
>  	if (ret)
>  		goto out;
>  	kernel_start = image->start;
> -	pr_notice("The entry point of kernel at 0x%lx\n", image->start);
> +	pr_notice("The entry point of kernel at 0x%lx\n", kernel_start);
>  
>  	/* Add the kernel binary to the image */
>  	ret = riscv_kexec_elf_load(image, &ehdr, &elf_info,

LGTM

Reviewed-by: Liao Chang <liaochang1@huawei.com>

-- 
BR,
Liao, Chang
