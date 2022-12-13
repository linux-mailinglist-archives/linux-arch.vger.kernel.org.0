Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611E164B9EE
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 17:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiLMQiT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 11:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiLMQiM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 11:38:12 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EDBB1C1;
        Tue, 13 Dec 2022 08:38:11 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id v19-20020a9d5a13000000b0066e82a3872dso179821oth.5;
        Tue, 13 Dec 2022 08:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjI88ca8YV9FnmaROJGLMTJcQPCidHIJLaiq64mk2fw=;
        b=m3Jb7Ck9qvL2P7CZfRH2ZpZswqxc1pN4FPSIBihVQ7AD2pxIhbmjHgw+8tynuXCsxi
         cMuSxki1r9yMBLNnVhGyv3IlNObYlqNPfgBhwUAa2nNi8Gsu56Zd6rWoQlD+A4pb0uJl
         VJQ7O8KuPmLK198CExWxKqDhHHuk/wWYU4w+NyL8spHZDZyfkUtX9DXwjptdJKB3Mdhu
         uDOAV5H2IyQp+sso/sxrK2ByDlHNfd2o3/YKa9kNo+x+Sr+S16wosdlRJIXSP//WG1p/
         MgaBuiV0NDr5pEw+dN7cQs53I2q/IO1/5eL6CCX9xQc6FUkwrPmFNn+wHYyHG88dU8Sc
         Ep4w==
X-Gm-Message-State: ANoB5plQ6q9qKn/KJ2u7CBo1/M9jlUj6vfXNZqSmaeAACNq6ROpuscQ7
        cLnVOgSwT9n+b5hlntgr87wxnaFtlw==
X-Google-Smtp-Source: AA0mqf6yiROdGm5NNVlBvSvfqyiQxqC2PPbW0NBL/ngLGZuGz3DsBVC5/iz0eZWQfegxhqTjTmY0Cw==
X-Received: by 2002:a9d:6006:0:b0:670:6246:8106 with SMTP id h6-20020a9d6006000000b0067062468106mr10467047otj.4.1670949490580;
        Tue, 13 Dec 2022 08:38:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y6-20020a056830208600b0066ea5d4f349sm1361066otq.18.2022.12.13.08.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:38:10 -0800 (PST)
Received: (nullmailer pid 2018850 invoked by uid 1000);
        Tue, 13 Dec 2022 16:38:09 -0000
Date:   Tue, 13 Dec 2022 10:38:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] riscv: Use PUD/P4D/PGD pages for the linear mapping
Message-ID: <20221213163809.GA2016314-robh@kernel.org>
References: <20221213060204.27286-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213060204.27286-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 13, 2022 at 07:02:04AM +0100, Alexandre Ghiti wrote:
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
> v3:
> - Change the comment about initrd_start VA conversion so that it fits
>   ARM64 and RISCV64 (and others in the future if needed), as suggested
>   by Rob
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
>  drivers/of/fdt.c              | 11 ++++++-----

Acked-by: Rob Herring <robh@kernel.org> # DT bits

>  4 files changed, 57 insertions(+), 11 deletions(-)
