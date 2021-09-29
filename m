Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F5241C74B
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344695AbhI2OxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 10:53:17 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53756
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344742AbhI2OxQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 10:53:16 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 491F44025C
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927094;
        bh=/TquUrfUmr5oNmyuO1+Qsp/eD8gniIfYD04SJchk9B4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=l64xjmVD9Me1aQvDrLSL5/3KuStRLNN/GJqX33pJnIviY41iMVPuuKlQzaPGAPf5t
         Gh1e71BREzfxpb5yIGPnmhZCdxJEqds4mDHU9A2EvjzRtDIaaXs7NJIMSdHa1ILBgC
         ywh9fAxziQHZ2TATcAf+RUJ/soub4Q9Y9mVHbgut9mgoQZU9FLTQ+lj4HGrkGS220p
         uRR/jS8lIc3FsxekKiqAMZJljRivDYgWUKL+axoBt1d04heUGoQTMcE+XcuyztsGlc
         eFoNom2i+aE39YF0Re5JwiWzEnLKM0+igemByAiIGMcN39inUobt9ViTl451NQgwI6
         c31ELpX2pZbTQ==
Received: by mail-wr1-f69.google.com with SMTP id r15-20020adfce8f000000b0015df1098ccbso698346wrn.4
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/TquUrfUmr5oNmyuO1+Qsp/eD8gniIfYD04SJchk9B4=;
        b=pUfPLs6qcxL8R1bb51+SOrJ0SeVfvaZIYkponByQKngUwYJJvv4jPRCo+3iggZa/Dk
         MyfCPUp17CcREcWj2cTsevkmyAq5c6Brdloc1Dw8/x33hToRVr1Zz9hdKvxySjCMNJnu
         wCWRfgyoFernCjplnwKkwqJZMGrEWad95+Yl8/TM/+V8wE/tDQEI6NeV+K1A/e6wRcs9
         j7dUH/2BMlnyGeC+cA/3N7ZFQLe25ggkgeI3tWh+d4IqEG42JW534omhViyOvaCz/zpD
         hKKT+vHNNyDJrypVLWo5hlaAabh0LfPw6bHZC28W787kg0LDPLMZGYzfnn2Hyva6RNDn
         KD8Q==
X-Gm-Message-State: AOAM533e3AVOWyDbZ6PS5jx0+lKT7a2G+Fmv0WZ2+MZsj3Ckj6D/qsvJ
        oYGeg/UBty/PD1LpGssj6DxaOW3ffEylLvAh9pnupWeqBssFf6o5qHi6OrU1pk3RruMmoaGV4P8
        zKGni1s1SwpASdhHRTCfnyrNyUQUzEeQCJPePZvs=
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr11084970wmq.52.1632927093816;
        Wed, 29 Sep 2021 07:51:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy9Wf93oel0uFuiz+G/bu4P6jRU9wFw42uTqgvwTyHqxhPmb9DM6m0bHj2SXFqePSIfq7jLA==
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr11084945wmq.52.1632927093654;
        Wed, 29 Sep 2021 07:51:33 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id q7sm129478wrc.55.2021.09.29.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:51:33 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 00/10] Introduce sv48 support without relocatable kernel 
Date:   Wed, 29 Sep 2021 16:51:03 +0200
Message-Id: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset allows to have a single kernel for sv39 and sv48 without           
being relocatable.                                                               
                                                                                 
The idea comes from Arnd Bergmann who suggested to do the same as x86,           
that is mapping the kernel to the end of the address space, which allows         
the kernel to be linked at the same address for both sv39 and sv48 and           
then does not require to be relocated at runtime.                                
                                                                                 
This implements sv48 support at runtime. The kernel will try to                  
boot with 4-level page table and will fallback to 3-level if the HW does not     
support it. Folding the 4th level into a 3-level page table has almost no        
cost at runtime.                                                                 
                                                                                 
Tested on:                                                                       
  - qemu rv64 sv39: OK                                                           
  - qemu rv64 sv48: OK                                                           
  - qemu rv64 sv39 + kasan: OK                                                   
  - qemu rv64 sv48 + kasan: OK                                                   
  - qemu rv32: OK                                                                
  - Unmatched: OK                                                                
                                                                                 
Changes in v2:                                                                   
  - Rebase onto for-next                                                         
  - Fix KASAN                                                                    
  - Fix stack canary                                                             
  - Get completely rid of MAXPHYSMEM configs                                     
  - Add documentation

Alexandre Ghiti (10):
  riscv: Allow to dynamically define VA_BITS
  riscv: Get rid of MAXPHYSMEM configs
  asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
  riscv: Implement sv48 support
  riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
  riscv: Explicit comment about user virtual address space size
  riscv: Improve virtual kernel memory layout dump
  Documentation: riscv: Add sv48 description to VM layout
  riscv: Initialize thread pointer before calling C functions
  riscv: Allow user to downgrade to sv39 when hw supports sv48

 Documentation/riscv/vm-layout.rst             |  36 ++
 arch/riscv/Kconfig                            |  35 +-
 arch/riscv/configs/nommu_k210_defconfig       |   1 -
 .../riscv/configs/nommu_k210_sdcard_defconfig |   1 -
 arch/riscv/configs/nommu_virt_defconfig       |   1 -
 arch/riscv/include/asm/csr.h                  |   3 +-
 arch/riscv/include/asm/fixmap.h               |   1 +
 arch/riscv/include/asm/kasan.h                |   2 +-
 arch/riscv/include/asm/page.h                 |  10 +
 arch/riscv/include/asm/pgalloc.h              |  40 +++
 arch/riscv/include/asm/pgtable-64.h           | 108 +++++-
 arch/riscv/include/asm/pgtable.h              |  30 +-
 arch/riscv/include/asm/sparsemem.h            |   6 +-
 arch/riscv/kernel/cpu.c                       |  23 +-
 arch/riscv/kernel/head.S                      |   4 +-
 arch/riscv/mm/context.c                       |   4 +-
 arch/riscv/mm/init.c                          | 323 +++++++++++++++---
 arch/riscv/mm/kasan_init.c                    |  91 +++--
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +
 include/asm-generic/pgalloc.h                 |  24 +-
 include/linux/sizes.h                         |   1 +
 21 files changed, 615 insertions(+), 131 deletions(-)

-- 
2.30.2

