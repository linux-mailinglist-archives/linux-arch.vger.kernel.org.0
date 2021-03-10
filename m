Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5540833335F
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 03:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhCJCyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 21:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhCJCyl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 21:54:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6201FC061760
        for <linux-arch@vger.kernel.org>; Tue,  9 Mar 2021 18:54:30 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id j12so10931705pfj.12
        for <linux-arch@vger.kernel.org>; Tue, 09 Mar 2021 18:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YBxARwCSnvP/MPs48fuZLZiuQ0mo/90Nc+1kxldAXvY=;
        b=mgPjitELPEW/P5qmpcLVfVoA0D6sHZbihRmkHn2T6K9SBG4Ha/LJO/otu10peacMhr
         LuL0fRZdQLwP7M9wEDrTpBtLj8K8tudZNldX6kZxxwpgoOUxKITkywSl2jzbDDQ+LlzB
         pAfWpubnARGarXUbdueVAOGEZZwgdwg38kjUrvpm8UlRyhUcHqhOLh/KTMLubon7Kb4n
         SDBddPEB0kPjpJ49JkLLyjwoA35CMpN5HTgdd0VAg06YzUz21lg3gZ8E6/aU6kC48WxF
         Iv+Fz7wjENWwmVReUBuT2iyV4vRqfYBaKfQMpvTe0Mkt1040FtnGxaGlyV9nF1Rgq6o4
         4rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YBxARwCSnvP/MPs48fuZLZiuQ0mo/90Nc+1kxldAXvY=;
        b=tNnG0Rf6LJ2+8kcumzD13SEz0WrJnFkfz0WavtXUV0KNQvdf+Yb1nLnRplnxKwncDC
         9fcFwxBiu5NZRzf1mGYk59Czv+7Gzi1+ED38wV8Foa3ZdVWyEyCNFLi81Vm/avXh5kXp
         1uupV9ztejZUXDZdnphwb7GVd8P5+oX7R/bQ1Ny9zW6ZofP7bxIQ4/iYmjzOefG3xz7Y
         ral+H8btfxufEd0LQ/HDAAp0CBS2sV5C2qUVKc6ZaIURnwkMsYC7H1NsuQTLPFP+IXKY
         Mq0+r+uoQtL5FbjYoTui+iz5uKClTILYMacisOvM1AU/47QwgA5QjBw3IgoZo46lREGv
         46NQ==
X-Gm-Message-State: AOAM532BbTvOjNU5UmmnRolgyRN1syLF6WpkVaprH7dfqL1aVTQwGc2j
        fLvmafOXa/+JPbaCeUPtzLedRg==
X-Google-Smtp-Source: ABdhPJw9djyUJKGf+CL7k+IvlqXvhXmzFMbBeiDmFCthoAskqXlsDt4pmgMsgrh8nJwik7OuxQCByg==
X-Received: by 2002:a62:b410:0:b029:1a4:7868:7e4e with SMTP id h16-20020a62b4100000b02901a478687e4emr891769pfn.62.1615344869693;
        Tue, 09 Mar 2021 18:54:29 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v1sm4250210pjt.1.2021.03.09.18.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:54:28 -0800 (PST)
Date:   Tue, 09 Mar 2021 18:54:28 -0800 (PST)
X-Google-Original-Date: Tue, 09 Mar 2021 18:54:03 PST (-0800)
Subject:     Re: [PATCH 0/3] Move kernel mapping outside the linear mapping
In-Reply-To: <20210225080453.1314-1-alex@ghiti.fr>
CC:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-cf5d29ec-e941-4579-8c42-2c11799a8f2f@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 Feb 2021 00:04:50 PST (-0800), alex@ghiti.fr wrote:
> I decided to split sv48 support in small series to ease the review.
>
> This patchset pushes the kernel mapping (modules and BPF too) to the last
> 4GB of the 64bit address space, this allows to:
> - implement relocatable kernel (that will come later in another
>   patchset) that requires to move the kernel mapping out of the linear
>   mapping to avoid to copy the kernel at a different physical address.
> - have a single kernel that is not relocatable (and then that avoids the
>   performance penalty imposed by PIC kernel) for both sv39 and sv48.
>
> The first patch implements this behaviour, the second patch introduces a
> documentation that describes the virtual address space layout of the 64bit
> kernel and the last patch is taken from my sv48 series where I simply added
> the dump of the modules/kernel/BPF mapping.
>
> I removed the Reviewed-by on the first patch since it changed enough from
> last time and deserves a second look.
>
> Alexandre Ghiti (3):
>   riscv: Move kernel mapping outside of linear mapping
>   Documentation: riscv: Add documentation that describes the VM layout
>   riscv: Prepare ptdump for vm layout dynamic addresses
>
>  Documentation/riscv/index.rst       |  1 +
>  Documentation/riscv/vm-layout.rst   | 61 ++++++++++++++++++++++
>  arch/riscv/boot/loader.lds.S        |  3 +-
>  arch/riscv/include/asm/page.h       | 18 ++++++-
>  arch/riscv/include/asm/pgtable.h    | 37 +++++++++----
>  arch/riscv/include/asm/set_memory.h |  1 +
>  arch/riscv/kernel/head.S            |  3 +-
>  arch/riscv/kernel/module.c          |  6 +--
>  arch/riscv/kernel/setup.c           |  3 ++
>  arch/riscv/kernel/vmlinux.lds.S     |  3 +-
>  arch/riscv/mm/fault.c               | 13 +++++
>  arch/riscv/mm/init.c                | 81 +++++++++++++++++++++++------
>  arch/riscv/mm/kasan_init.c          |  9 ++++
>  arch/riscv/mm/physaddr.c            |  2 +-
>  arch/riscv/mm/ptdump.c              | 67 +++++++++++++++++++-----
>  15 files changed, 258 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/riscv/vm-layout.rst

This generally looks good, but I'm getting a bunch of checkpatch warnings and 
some conflicts, do you mind fixing those up (and including your other kasan 
patch, as that's likely to conflict)?
