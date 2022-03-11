Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31934D5832
	for <lists+linux-arch@lfdr.de>; Fri, 11 Mar 2022 03:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbiCKCjZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Mar 2022 21:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiCKCjY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2022 21:39:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24EA108763;
        Thu, 10 Mar 2022 18:38:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D373600BE;
        Fri, 11 Mar 2022 02:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC43C340FC;
        Fri, 11 Mar 2022 02:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646966301;
        bh=Jl8zmUlue4qqSpvupSe770nwEDFbxuYU+7Bv15ArLNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lSDH6JbZLjCrBKwhP5l06T0OkCO9oN/A8aEEjauCFSKrSGqZSLjhPkfyba8lYXT8b
         qYNbLTfBYoaFYS9/EdstBjbcmkW1UfcrGbXKAA3XzivX2N/X7M8/MG2dJGhgzUj1xe
         JwIgADZuHHJQV+vkPugE9tLJ05ZgR4K+s7Tqg3OYy0S0d/gkDWxZGRTQdcVyEyVTta
         XcdW+bJU/6F0zGvwFWhD4c7+eaOFthHqbXVWvY103F1BoVPLPmpdBFX9VrRB9dX0cQ
         RFdNXU0aoXtMTFwXmsyOd8jEdA/NcC/+rOGDrpxxb7LrGBkBTS5gvraGhc0yhF8ir3
         59IUblFQhb99Q==
Received: by mail-vs1-f48.google.com with SMTP id u124so8098304vsb.10;
        Thu, 10 Mar 2022 18:38:21 -0800 (PST)
X-Gm-Message-State: AOAM531r+0RCSa1uP+4DxvpwfnmVIeolCIthRU6hs16y0vps/+RpTX7N
        HjMThTmSp9v4Mq//k9W35qDGb7jrYRzugH1eYPA=
X-Google-Smtp-Source: ABdhPJzYUvUjuAFq8XvtZ71Qsvionf8y5EprAZIyEokbvQbCG5RE3xULelpIsGE/d8q0ktAquLt4SKjjcxqaZOgU8Ls=
X-Received: by 2002:a05:6102:806:b0:31e:2206:f1c with SMTP id
 g6-20020a056102080600b0031e22060f1cmr3912870vsb.59.1646966300562; Thu, 10 Mar
 2022 18:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20220227162831.674483-1-guoren@kernel.org> <20220227162831.674483-14-guoren@kernel.org>
In-Reply-To: <20220227162831.674483-14-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 11 Mar 2022 10:38:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSJFMg1YJ=dbaNyemNV4sc_3P=+_PrS=RD_Y2_xz3TzPA@mail.gmail.com>
Message-ID: <CAJF2gTSJFMg1YJ=dbaNyemNV4sc_3P=+_PrS=RD_Y2_xz3TzPA@mail.gmail.com>
Subject: Re: [PATCH V7 13/20] riscv: compat: process: Add UXL_32 support in start_thread
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
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Mon, Feb 28, 2022 at 12:30 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> If the current task is in COMPAT mode, set SR_UXL_32 in status for
> returning userspace. We need CONFIG _COMPAT to prevent compiling
> errors with rv32 defconfig.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  arch/riscv/kernel/process.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 03ac3aa611f5..54787ca9806a 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -97,6 +97,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>         }
>         regs->epc = pc;
>         regs->sp = sp;
> +
FIxup:

+ #ifdef CONFIG_COMPAT
> +       if (is_compat_task())
> +               regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
> +       else
> +               regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
+ #endif

We still need "#ifdef CONFIG_COMPAT" here, because for rv32 we can't
set SR_UXL at all. SR_UXL is BIT[32, 33].

>  }
>
>  void flush_thread(void)
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
