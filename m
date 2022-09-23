Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19685E78EE
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 13:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiIWLAr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIWLAq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 07:00:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEA1AF0E9;
        Fri, 23 Sep 2022 04:00:43 -0700 (PDT)
Received: from p508fdb48.dip0.t-ipconnect.de ([80.143.219.72] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1obgQ5-00067T-Qn; Fri, 23 Sep 2022 13:00:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        palmer@rivosinc.com, liaochang1@huawei.com, jszhang@kernel.org,
        arnd@arndb.de, guoren@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V4 3/3] arch: crash: Remove duplicate declaration in smp.h
Date:   Fri, 23 Sep 2022 13:00:32 +0200
Message-ID: <5594014.Sb9uPGUboI@phil>
In-Reply-To: <20220921033134.3133319-4-guoren@kernel.org>
References: <20220921033134.3133319-1-guoren@kernel.org> <20220921033134.3133319-4-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am Mittwoch, 21. September 2022, 05:31:34 CEST schrieb guoren@kernel.org:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Remove crash_smp_send_stop declarations in arm64, x86 asm/smp.h which
> has been done in include/linux/smp.h.

nit: the commit message could reference the commit that brought in the
generic declarations, which was
	6f1f942cd5fb ("smp: kernel/panic.c - silence warnings")

other than that
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm64/include/asm/smp.h | 1 -
>  arch/x86/include/asm/crash.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index fc55f5a57a06..a108ac93fd8f 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -141,7 +141,6 @@ static inline void cpu_panic_kernel(void)
>   */
>  bool cpus_are_stuck_in_kernel(void);
>  
> -extern void crash_smp_send_stop(void);
>  extern bool smp_crash_stop_failed(void);
>  extern void panic_smp_self_stop(void);
>  
> diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
> index 8b6bd63530dc..6a9be4907c82 100644
> --- a/arch/x86/include/asm/crash.h
> +++ b/arch/x86/include/asm/crash.h
> @@ -7,6 +7,5 @@ struct kimage;
>  int crash_load_segments(struct kimage *image);
>  int crash_setup_memmap_entries(struct kimage *image,
>  		struct boot_params *params);
> -void crash_smp_send_stop(void);
>  
>  #endif /* _ASM_X86_CRASH_H */
> 




