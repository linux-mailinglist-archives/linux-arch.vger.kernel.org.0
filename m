Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D858841C764
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344680AbhI2Oza (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 10:55:30 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60066
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344769AbhI2Oz3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 10:55:29 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B6BAF402D9
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 14:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927227;
        bh=omlMO8oiSqY28NQ++6IIM/VRVI4+XjHYuKkKGp3z8ks=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nGjrYot8lS3zpvPCzcNpJLQGDmGXtVv/I2FxJmggjvWfsLST8c/8DBgtPNoLDRWFY
         mMGgynJgA67F3KWJQsxFSC8pYZGj1pXog0xjWKO/AOp0WBmUT4T1t4gL3t7qitttR+
         vDYaQAcaxpt+F6/jlAo6uTWlnamaEkDOAfoKA3r8DZsra9SZ9gRvqFGJxQdK2IVKV0
         0G2r9Nb0eiEqDpdkLR5I2UeAzHC98UVBDrTeO8M4v54RSb7NxXqkO1CvDWu1CiEW4x
         cqULk8f6UqbLn2EzObNnGgi1HQVlz9k+Iy2AvKx9zxwR3nkG+xZVQhzlESjpscndlf
         1cPAjj1LrUKmQ==
Received: by mail-wm1-f70.google.com with SMTP id 129-20020a1c1987000000b0030cd1616fbfso2826750wmz.3
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omlMO8oiSqY28NQ++6IIM/VRVI4+XjHYuKkKGp3z8ks=;
        b=TUQ1IEj2PNHrDK0PkRCnUFMLtvs+/zqRlvC70aa56GUpzIWgOSUODz9l+62wuEffO5
         xcbAkn5deriDCDXvr2b0W3GeJf2z4J173Oll6ZoJCRRr0yU5nL8sHPoe2SydRnZiDFzr
         RcREVnvyPZfWSKojyOyT0sh+sXiG3dXBCGUN0deUy9ZKLTCVCgQKKQU1c8Yj5S7BTfdO
         GqJbEf4L8V1CSKki5ByTMih+FFVMk4qjEx1l3yMBHkNLS2vd0PGPF9RfRbDJVulKW45/
         2lq08rQEEaccOEpydba5VWm7ZS6N+hkoQn2cMFBV1/BJBsRetfcx9Zc3Nhefa+epmiL+
         BW6w==
X-Gm-Message-State: AOAM5318bYyhIswCaR1YhAKTN2FEykcaZ1HTADamfDhGlh0l85FM0b8a
        ez6hY2KUBYOl6aB+2BVv6bZq/cKY4gZPZmSRmUGWHCA2AZbnfTeuBLa77qpHsB2eL6rw+h2O9Ea
        lWUmzUo8vVMSxneuPfdEmuPlH9PkAfuVW2ygXk/Y=
X-Received: by 2002:a1c:7e48:: with SMTP id z69mr6608682wmc.95.1632927216590;
        Wed, 29 Sep 2021 07:53:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBhGuwR2gfKW7D8wbmoyhXANv5cqBb/OGcSoZL3FS07cfNAhL/0WXAeYKVFArK/uWwhbyh2g==
X-Received: by 2002:a1c:7e48:: with SMTP id z69mr6608661wmc.95.1632927216369;
        Wed, 29 Sep 2021 07:53:36 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id g1sm2428205wmk.2.2021.09.29.07.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:53:36 -0700 (PDT)
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
Subject: [PATCH v2 02/10] riscv: Get rid of MAXPHYSMEM configs
Date:   Wed, 29 Sep 2021 16:51:05 +0200
Message-Id: <20210929145113.1935778-3-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CONFIG_MAXPHYSMEM_* were actually never used, even the nommu defconfigs
selecting the MAXPHYSMEM_2GB had no effects on PAGE_OFFSET since it was
preempted by !MMU case right before.

In addition, I suspect that commit 2bfc6cd81bd1 ("riscv: Move kernel
mapping outside of linear mapping") which moved the kernel to
0xffffffff80000000 broke the MAXPHYSMEM_2GB config which defined
PAGE_OFFSET at the same address.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/Kconfig                            | 23 ++-----------------
 arch/riscv/configs/nommu_k210_defconfig       |  1 -
 .../riscv/configs/nommu_k210_sdcard_defconfig |  1 -
 arch/riscv/configs/nommu_virt_defconfig       |  1 -
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ee61ecae3ae0..13e9c4298fbc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -147,10 +147,9 @@ config MMU
 
 config PAGE_OFFSET
 	hex
-	default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
+	default 0xC0000000 if 32BIT
 	default 0x80000000 if 64BIT && !MMU
-	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
-	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
+	default 0xffffffe000000000 if 64BIT
 
 config ARCH_FLATMEM_ENABLE
 	def_bool !NUMA
@@ -256,24 +255,6 @@ config MODULE_SECTIONS
 	bool
 	select HAVE_MOD_ARCH_SPECIFIC
 
-choice
-	prompt "Maximum Physical Memory"
-	default MAXPHYSMEM_1GB if 32BIT
-	default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
-	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
-
-	config MAXPHYSMEM_1GB
-		depends on 32BIT
-		bool "1GiB"
-	config MAXPHYSMEM_2GB
-		depends on 64BIT && CMODEL_MEDLOW
-		bool "2GiB"
-	config MAXPHYSMEM_128GB
-		depends on 64BIT && CMODEL_MEDANY
-		bool "128GiB"
-endchoice
-
-
 config SMP
 	bool "Symmetric Multi-Processing"
 	help
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index b16a2a12c82a..dae9179984cc 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -30,7 +30,6 @@ CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
 CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
-CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0"
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 61f887f65419..03f91525a059 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -22,7 +22,6 @@ CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
 CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
-CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0 rootdelay=2 root=/dev/mmcblk0p1 ro"
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index e046a0babde4..f224be697785 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -27,7 +27,6 @@ CONFIG_SLOB=y
 # CONFIG_SLAB_MERGE_DEFAULT is not set
 # CONFIG_MMU is not set
 CONFIG_SOC_VIRT=y
-CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
 CONFIG_CMDLINE_FORCE=y
-- 
2.30.2

