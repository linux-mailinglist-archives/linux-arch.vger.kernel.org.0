Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB39634973
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 22:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiKVVhf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 16:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiKVVhb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 16:37:31 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34EC63CC;
        Tue, 22 Nov 2022 13:37:30 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id bp12so7706011ilb.9;
        Tue, 22 Nov 2022 13:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYuFRqLNqtbjraOouiWkagMjg88w0HPqis6czLPeub4=;
        b=D8/mjfekfwlrsf+YtMzgxXgQAEvkd3CS2YOq8+H9SuHaVbLTJ3mstnHz3OtvPSczZg
         ms7FqJKoUfUn8UuPVO0e+GWAbqISNRR0LU9mDPIG35xQYcvWVBmeB3JSEUwKbSurgniU
         9h4M5sIZrBaCMkXmG21BnHHDUdZeRHUTf6Xv51F27Hco0zayL88KZqTiAya3H0sMSgnW
         t5M8WqwGtIJr3MMtjNBcJR7odlU6rEiyJpwhuOVylYj7DbRQhG/0jdRewfVhdbf36KKN
         PfobR3vawN/uLiHetO5N0kwXOb+jkossl8hGYuJIVLPGXuHbyUYSConas6pG5P1lMG40
         8PiQ==
X-Gm-Message-State: ANoB5pmNjiT53VlIHHq56CtKbrbUElj4dmAOIznN5uYukHcVBcwP9F/x
        odssACahtQw+7GBr454tCg==
X-Google-Smtp-Source: AA0mqf7q2sbxK3tUm65CzOZyUynrHlmB0F9b9om4Gd847uJg297ZztoQje/lG3t10QRLf01ocxNSkw==
X-Received: by 2002:a92:b741:0:b0:302:39d5:937e with SMTP id c1-20020a92b741000000b0030239d5937emr2930451ilm.37.1669153049468;
        Tue, 22 Nov 2022 13:37:29 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g5-20020a05663810e500b0034294118e1bsm5724889jae.126.2022.11.22.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 13:37:29 -0800 (PST)
Received: (nullmailer pid 618630 invoked by uid 1000);
        Tue, 22 Nov 2022 21:37:31 -0000
Date:   Tue, 22 Nov 2022 15:37:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] riscv: Use PUD/P4D/PGD pages for the linear mapping
Message-ID: <20221122213731.GB583854-robh@kernel.org>
References: <20221122084141.1849421-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122084141.1849421-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 22, 2022 at 09:41:41AM +0100, Alexandre Ghiti wrote:
> During the early page table creation, we used to set the mapping for
> PAGE_OFFSET to the kernel load address: but the kernel load address is
> always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> PAGE_OFFSET is).
> 
> But actually we don't have to establish this mapping (ie set va_pa_offset)
> that early in the boot process because:
> 
> - first, setup_vm installs a temporary kernel mapping and among other
>   things, discovers the system memory,
> - then, setup_vm_final creates the final kernel mapping and takes
>   advantage of the discovered system memory to create the linear
>   mapping.
> 
> During the first phase, we don't know the start of the system memory and
> then until the second phase is finished, we can't use the linear mapping at
> all and phys_to_virt/virt_to_phys translations must not be used because it
> would result in a different translation from the 'real' one once the final
> mapping is installed.
> 
> So here we simply delay the initialization of va_pa_offset to after the
> system memory discovery. But to make sure noone uses the linear mapping
> before, we add some guard in the DEBUG_VIRTUAL config.
> 
> Finally we can use PUD/P4D/PGD hugepages when possible, which will result
> in a better TLB utilization.
> 
> Note that we rely on the firmware to protect itself using PMP.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> 
> Note that this patch is rebased on top of:
> [PATCH v1 1/1] riscv: mm: call best_map_size many times during linear-mapping
> 
>  arch/riscv/include/asm/page.h | 16 ++++++++++++++++
>  arch/riscv/mm/init.c          | 25 +++++++++++++++++++------
>  arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
>  drivers/of/fdt.c              |  5 ++++-
>  4 files changed, 55 insertions(+), 7 deletions(-)

[...]

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 7b571a631639..04e3ecb51722 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -895,8 +895,11 @@ static void __early_init_dt_declare_initrd(unsigned long start,
>  	 * enabled since __va() is called too early. ARM64 does make use
>  	 * of phys_initrd_start/phys_initrd_size so we can skip this
>  	 * conversion.
> +	 * On RISCV64, the usage of __va() before the linear mapping exists
> +	 * is wrong.

I assume the 'does make use of phys_initrd_start/phys_initrd_size so we 
can skip this conversion' comment applies to RiscV too. Or you just 
don't care if initrd addresses are not setup?

Please rework the comment removing what platforms can skip this. Which 
platforms skip it is obvious from the code. 'Why' is not, so that's what 
the comment is for.


>  	 */
> -	if (!IS_ENABLED(CONFIG_ARM64)) {
> +	if (!IS_ENABLED(CONFIG_ARM64) &&
> +	    !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
>  		initrd_start = (unsigned long)__va(start);
>  		initrd_end = (unsigned long)__va(end);
>  		initrd_below_start_ok = 1;
> -- 
> 2.37.2
> 
