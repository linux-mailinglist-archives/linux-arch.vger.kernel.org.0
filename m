Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2186464A64F
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 18:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiLLRyP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 12:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiLLRyO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 12:54:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA22BBB1;
        Mon, 12 Dec 2022 09:54:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E14EB80DE3;
        Mon, 12 Dec 2022 17:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03284C433D2;
        Mon, 12 Dec 2022 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670867651;
        bh=bY7EznKOlvKF57kav1/EOPRkTTovAkvgGO10ZJYhYcQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NEporkZyXqNlMag6C+Ps4PX6ja8kKKVrOxDL6x7PvrW29OHC5W7xSZmu9SXEhpBDY
         r1u0NtAsgcxkxPcQGQjTp4P081cKY5afiq3hBpyqb8ksluhHUS5it/MZoiatczV6JH
         ErPOt/bfTUkHCttuiZxR8DlXZ1p2iBR1iFmUONW/rnl3CRTN/Xym7Q/ukReNxEOkBz
         agZsF0SFjFWHfrcnfKp4uW7qiDrRYv7ZSPw/I/MO5A+rLqbj5QVp2tGHlePHBBrWHd
         2jow0BX/dlgEayePuD8xDV4UPierEokD1T+CIpif0qvZJIIHKb7v8eCOnKD+rhSP6j
         +rOk2OjxV9xEg==
Received: by mail-ua1-f47.google.com with SMTP id n9so3390356uao.13;
        Mon, 12 Dec 2022 09:54:10 -0800 (PST)
X-Gm-Message-State: ANoB5pmr8+DrwN2OmCxKyMaTxt4A5sXh/Npx/EsNSZz9QB5m0aDV9Ob5
        OaR3+GRiUwjWjREdMQv/ceBOoECXAZz0MSaWRw==
X-Google-Smtp-Source: AA0mqf573L42dMXtmZJVUUuskEYLV16yalBiJSgkJa1EEtoeIRtYyXQ3qTxa95wj6G+9q09neTNW9b+h3tdGkRXlLMY=
X-Received: by 2002:ab0:3a96:0:b0:419:678:cf31 with SMTP id
 r22-20020ab03a96000000b004190678cf31mr35543884uaw.63.1670867649788; Mon, 12
 Dec 2022 09:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20221212143102.175065-1-alexghiti@rivosinc.com>
In-Reply-To: <20221212143102.175065-1-alexghiti@rivosinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Dec 2022 11:53:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJz4uf+956oC4BfZGdjb+rfAZqduexLw3=D5HHjtyBC+g@mail.gmail.com>
Message-ID: <CAL_JsqJz4uf+956oC4BfZGdjb+rfAZqduexLw3=D5HHjtyBC+g@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 12, 2022 at 8:31 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
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
> v2:
> - Add a comment on why RISCV64 does not need to set initrd_start/end that
>   early in the boot process, as asked by Rob
>
> Note that this patch is rebased on top of:
> [PATCH v1 1/1] riscv: mm: call best_map_size many times during linear-mapping
>
>  arch/riscv/include/asm/page.h | 16 ++++++++++++++++
>  arch/riscv/mm/init.c          | 25 +++++++++++++++++++------
>  arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
>  drivers/of/fdt.c              |  7 ++++++-
>  4 files changed, 57 insertions(+), 7 deletions(-)

[...]

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 7b571a631639..012554445054 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -895,8 +895,13 @@ static void __early_init_dt_declare_initrd(unsigned long start,
>          * enabled since __va() is called too early. ARM64 does make use
>          * of phys_initrd_start/phys_initrd_size so we can skip this
>          * conversion.
> +        * On RISCV64, the usage of __va() before the linear mapping exists
> +        * is wrong and RISCV64 rightly calls reserve_initrd_mem after it is
> +        * available where it actually resets the translation that is done
> +        * here and re-computes it.

No, I want a single comment that covers both cases (and the next arch
we add here). Something like this:

__va() is not yet available this early on some platforms. In that
case, the platform uses phys_initrd_start/phys_initrd_size instead and
does the VA conversion itself.

Rob
