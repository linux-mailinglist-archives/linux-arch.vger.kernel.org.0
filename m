Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7567939E
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jan 2023 10:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjAXJFA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Jan 2023 04:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjAXJE7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jan 2023 04:04:59 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2C3E088
        for <linux-arch@vger.kernel.org>; Tue, 24 Jan 2023 01:04:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d14so9483071wrr.9
        for <linux-arch@vger.kernel.org>; Tue, 24 Jan 2023 01:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i1juhkmhpvx2lT4x4u+c5+9s9S4X54bhJYPvzt6ZWnE=;
        b=8R7UGXzogpSZH3Cp+NSSbVCzzvNbQcxPAtX9ECF9aLa/JCykl+NcPb3t87f5F09V9T
         GlKkIG22mHuVpzNgOc5H81+jPFAEQrCnF6t6ztL/4c6kzf1nt6f5q8JpIx5qFKQnLxzQ
         vS1KF/8gU3eJylhbeMxZoN3xd/Cxl/agoR5NJSvUG+L9vIeFR3jVjb4JdBtB9kMCZi/k
         ZTC42UPjHAw3DZe3NYlMzhNOVX/mXw4aXZu3GX9wp/x6GOHuN05aX2g5j4gmEz/eqUqr
         v9m2xdFf3T/xSN3o1YMKqlfxtFaR5rm5DkgEWhLmz5R3Un6nlmPhfD+xDdKvmi84TW9w
         rXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1juhkmhpvx2lT4x4u+c5+9s9S4X54bhJYPvzt6ZWnE=;
        b=axBNYjiNGchdw1/MinRkPK0oMZFMFFDrP22EmMEtDxPRpqcbzBvFuUzm2PWf7sZZO5
         lYCsJk+Kc6al+16ahAW1lA5k/cUweuGGF9hvYi6+/Iyd4qdIiRNiFj4Ykil+vlJZwChq
         2Nmz3+Aa5kvZoEYf3LaEq6VpUlDd8TKTF5pgB69Cf7sklcD1AsfDRax4+6VwXQDpNl/i
         QarzBN+/1qUOnRY4R74PFtBqrZt+jTaD5K0iO7byTAmEZ8tetO5MRx3muc2DC5eIXFdo
         EE2Esn5yJ2SwO67TnqeNZlLzIhOjNuSMiAepmc9NMu2T2Vs5VQY4L4Xc0n/GQtnyEmZS
         hm3w==
X-Gm-Message-State: AFqh2kqaLs29yjJoo7rMTgFVRHqO69Z5lElQLFqyAvDoT+6ke8NRROog
        7KgEljhOHM6/yNbGrw7ElMITZ6QoFLVcVwqPQ70Ryg==
X-Google-Smtp-Source: AMrXdXslWzyBPl6qN6lfBta/ufChiJMu2Y2CiUL1C94ZCECbF4eI9FFmR8w/ZsdDLVJkOVp28ufLm8pcdg8HVQLMWtk=
X-Received: by 2002:a5d:5190:0:b0:2bd:d6bc:e35c with SMTP id
 k16-20020a5d5190000000b002bdd6bce35cmr1227921wrv.144.1674551093678; Tue, 24
 Jan 2023 01:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20230123112803.817534-1-alexghiti@rivosinc.com> <Y88F808GULoKFOVJ@spud>
In-Reply-To: <Y88F808GULoKFOVJ@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 24 Jan 2023 10:04:42 +0100
Message-ID: <CAHVXubh=SQ0fS2FCpdB-TD5n=DHUHAaRqDazHWDMv3fWqwpjcA@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Conor,

On Mon, Jan 23, 2023 at 11:11 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Jan 23, 2023 at 12:28:02PM +0100, Alexandre Ghiti wrote:
> > During the early page table creation, we used to set the mapping for
> > PAGE_OFFSET to the kernel load address: but the kernel load address is
> > always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> > pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> > PAGE_OFFSET is).
> >
> > But actually we don't have to establish this mapping (ie set va_pa_offset)
> > that early in the boot process because:
> >
> > - first, setup_vm installs a temporary kernel mapping and among other
> >   things, discovers the system memory,
> > - then, setup_vm_final creates the final kernel mapping and takes
> >   advantage of the discovered system memory to create the linear
> >   mapping.
> >
> > During the first phase, we don't know the start of the system memory and
> > then until the second phase is finished, we can't use the linear mapping at
> > all and phys_to_virt/virt_to_phys translations must not be used because it
> > would result in a different translation from the 'real' one once the final
> > mapping is installed.
> >
> > So here we simply delay the initialization of va_pa_offset to after the
> > system memory discovery. But to make sure noone uses the linear mapping
> > before, we add some guard in the DEBUG_VIRTUAL config.
> >
> > Finally we can use PUD/P4D/PGD hugepages when possible, which will result
> > in a better TLB utilization.
> >
> > Note that we rely on the firmware to protect itself using PMP.
> >
> > Acked-by: Rob Herring <robh@kernel.org> # DT bits
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> No good on !MMU unfortunately Alex:
> ../arch/riscv/mm/init.c:222:2: error: use of undeclared identifier 'riscv_pfn_base'
>         riscv_pfn_base = PFN_DOWN(phys_ram_base);
>         ^
>
> Reproduces with nommu_virt_defconfig.

Thanks, fixed locally, I'll push the v5 soon.

Thanks again,

Alex

>
> Thanks,
> Conor.
