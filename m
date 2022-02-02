Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25944A69CC
	for <lists+linux-arch@lfdr.de>; Wed,  2 Feb 2022 03:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbiBBCC2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 21:02:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46182 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbiBBCC2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 21:02:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE2A0B82FE6;
        Wed,  2 Feb 2022 02:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588E1C340FA;
        Wed,  2 Feb 2022 02:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643767344;
        bh=Lu17CtWHMQyIMd+r/gZ3QnCD3blDyX01IGU77gYzPwo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rVuAgKNepQhlXkSgJ4nOfKqdZ1m2QgRk9ZkvH8SvfvWkeorNEQdY83E2n5eXKfc79
         VCuJEViT4M9HIVIMPr3BsvqjoERHgklnIISy31sSuU4uK2OLJWs1IQstgOysSW8fQ3
         A4+TDqM4i+9dG2f1hGh94TQRtV9FMnT0rwP8iPWmKTMSzCFTVSM/jumBKMQgjTroNE
         +jwQ76K54dK8UrZ95Lj5eu9y4l1FTA2KToTqrC9gowaW+jPXRuZTVpoBs8+clZOz6I
         Yl2FZr99TUgkOSak2L7h6irEIbDEWdhFCcdReiCBHO2TFXtVzEQRwjOz0Twz2ZkMOl
         aMu8vburo8Amg==
Received: by mail-ua1-f43.google.com with SMTP id c36so16481553uae.13;
        Tue, 01 Feb 2022 18:02:24 -0800 (PST)
X-Gm-Message-State: AOAM533gOtoCWxjkxw3H551eW3dWJnj2JZR1x01so7aWkCrxNCCP8d8W
        g9ZTJWEKPD1ZzUgYkQXEwUpfci/uF2ujM3xPrps=
X-Google-Smtp-Source: ABdhPJzjbMxJZrbhxn6pmM0yG+DXrY57H4w+bp7CFApaAn/IyFQRMevzGEcLPsnqGd8f9H2BAFJtp6v6SwrSYMY64Dg=
X-Received: by 2002:a67:e0d9:: with SMTP id m25mr10551317vsl.51.1643767343232;
 Tue, 01 Feb 2022 18:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20220201150545.1512822-1-guoren@kernel.org> <20220201150545.1512822-16-guoren@kernel.org>
In-Reply-To: <20220201150545.1512822-16-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 2 Feb 2022 10:02:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSpz94OBM_Ob92MdGOHt7p2akPS0Jco9B0rC0XJToh0eg@mail.gmail.com>
Message-ID: <CAJF2gTSpz94OBM_Ob92MdGOHt7p2akPS0Jco9B0rC0XJToh0eg@mail.gmail.com>
Subject: Re: [PATCH V5 15/21] riscv: compat: Add hw capability check for elf
To:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 1, 2022 at 11:07 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Detect hardware COMPAT (32bit U-mode) capability in rv64. If not
> support COMPAT mode in hw, compat_elf_check_arch would return
> false by compat_binfmt_elf.c
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/elf.h |  3 ++-
>  arch/riscv/kernel/process.c  | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index aee40040917b..3a4293dc7229 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -40,7 +40,8 @@
>   * elf64_hdr e_machine's offset are different. The checker is
>   * a little bit simple compare to other architectures.
>   */
> -#define compat_elf_check_arch(x) ((x)->e_machine == EM_RISCV)
> +extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
> +#define compat_elf_check_arch  compat_elf_check_arch
>
>  #define CORE_DUMP_USE_REGSET
>  #define ELF_EXEC_PAGESIZE      (PAGE_SIZE)
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 1a666ad299b4..758847cba391 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -83,6 +83,38 @@ void show_regs(struct pt_regs *regs)
>                 dump_backtrace(regs, NULL, KERN_DEFAULT);
>  }
>
> +#ifdef CONFIG_COMPAT
> +static bool compat_mode_support __read_mostly;
> +
> +bool compat_elf_check_arch(Elf32_Ehdr *hdr)
> +{
> +       if (compat_mode_support && (hdr->e_machine == EM_RISCV))
> +               return true;
> +       else
> +               return false;
> +}
> +
> +static int compat_mode_detect(void)
Forgot __init, here

> +{
> +       unsigned long tmp = csr_read(CSR_STATUS);
> +
> +       csr_write(CSR_STATUS, (tmp & ~SR_UXL) | SR_UXL_32);
> +
> +       if ((csr_read(CSR_STATUS) & SR_UXL) != SR_UXL_32) {
> +               pr_info("riscv: 32bit compat mode detect failed\n");
> +               compat_mode_support = false;
> +       } else {
> +               compat_mode_support = true;
> +               pr_info("riscv: 32bit compat mode detected\n");
> +       }
> +
> +       csr_write(CSR_STATUS, tmp);
> +
> +       return 0;
> +}
> +arch_initcall(compat_mode_detect);
> +#endif
> +
>  void start_thread(struct pt_regs *regs, unsigned long pc,
>         unsigned long sp)
>  {
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
