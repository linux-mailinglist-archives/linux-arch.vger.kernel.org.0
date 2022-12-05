Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FAB642584
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLEJNm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 04:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLEJNZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 04:13:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86D8B7B;
        Mon,  5 Dec 2022 01:13:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60507B80D8B;
        Mon,  5 Dec 2022 09:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A280EC433C1;
        Mon,  5 Dec 2022 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670231602;
        bh=BxyB9UbcH7VMa4LZtCngzzb08+kauzvcdH5JV40PM6o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ewk8yMS+YVNKhle2v6S8qXC/9kE/yOPobcpuNGnGZ+I7WFAZeGrxiQJEtzX3wI8sr
         8g9/fNnprw5Rg47kBQIUPWlxKZ4H/0/4AjVEsaV9zuVes49nYheTc7KBpLOk38zodQ
         izkG4nJobxvVEDRfvjatgUMwDD5+Mu4dp6a3aUHDRDbalaqSBmfMTsb9xMIhMoVIf9
         Nganxkt67B8I+SY5Gp4az3B5Kx55WJ7bAG+7vEH/DifQRdZanypMH2jBHAnHHdVe31
         MqSZesfugHGzQL8U4EdI/D+p51iB/0w2++1jGLcxfFWUiAJMmoSXuAkBIvxOEMftQ7
         eUzKJUJo58eBg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH -next V8 02/14] riscv: elf_kexec: Fixup compile warning
In-Reply-To: <20221103075047.1634923-3-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
 <20221103075047.1634923-3-guoren@kernel.org>
Date:   Mon, 05 Dec 2022 10:13:19 +0100
Message-ID: <87iliq9psg.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

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

This patch shouldn't be part of the generic entry series. It's just a
generic fix! Please have this as a separate patch.

