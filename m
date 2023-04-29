Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E7D6F235B
	for <lists+linux-arch@lfdr.de>; Sat, 29 Apr 2023 08:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjD2GeM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Apr 2023 02:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjD2GeL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Apr 2023 02:34:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070872125;
        Fri, 28 Apr 2023 23:34:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a69f686345so5691505ad.2;
        Fri, 28 Apr 2023 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682750049; x=1685342049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSfv5t4C9cwppYox3U6KqaeYRJrwwcdMCKh0TKYZTfY=;
        b=jgX+OXrrHnH45akqNjdlWaQFYstsdbpondQ+fh3Msi1/HhjpsmZdFC+yLXih7hP/pU
         wgdNac4fjcTdjuh5YzDwrfXcFY7nTNG7NTG9OKleR4+VqZlwQQ+dJnUPCKUlMotuGhtK
         liEvH+GopRM8uHPlGBNbhx8erNYSKJLuBi7f6XaVH16Z1cWL+j0LVG8QPiLpBIa6TEeI
         zTS1Ra3qCsaeMXU1RmMnIP9HaQN5+5m2TcVeWF6195N9W4Nk/IP8if39MUVzKA4I+Dwp
         Z2dkFPBFVLF+hUJPQOTD2SFsOLbcA622JvdIeH4gIN3JC30Fskg+YIN5y8gJoIVRkgR5
         I3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682750049; x=1685342049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSfv5t4C9cwppYox3U6KqaeYRJrwwcdMCKh0TKYZTfY=;
        b=a/UMIrkjFZvPLW8ia71Q/p9Im8ovIt7o5Q56hij2CjixjcaB0oT2j2ygxOj+y6YhRY
         ukqh4irMGGlTexaqwZmO4LltSBY3+2ijurQMwrnXzRw+8JBE/bEtOy2K6cf17oX/seKX
         b5OtnOGUAHrSXLKVkjRMr+5zdAnQdogqZr0O2Az51giIgHhLIAfjGWgHo6zvFigsEQ0K
         7DGCFiJRcSJ2yf39ZkJ5PYGJjDvkvvbXED2UeyETKhGgglUopYzqzjLG5Qm1znZ+lx25
         d3gG3ZtAamHOGRlJGBxqaZ46KEog9/HWi2sHz1ZTAJW9i13dleSkw3ZU5Xujo90WH21p
         L7eA==
X-Gm-Message-State: AC+VfDwWVs7Pf4YHljI8Ywf34zgETse1A76C3NnIVlAEql0k0UN4dxY6
        CsNnc2VbGQCVdug0srHaDyE=
X-Google-Smtp-Source: ACHHUZ7be5oOxy4XCSWaxNypq0CFCL78WwmFg5MLeuSZBRyfSzU6QkTnWKQW9hhiXBkCoxg5Uid8wg==
X-Received: by 2002:a17:903:2798:b0:1a9:7262:fe55 with SMTP id jw24-20020a170903279800b001a97262fe55mr7208130plb.13.1682750049387;
        Fri, 28 Apr 2023 23:34:09 -0700 (PDT)
Received: from wheely.local0.net (14-202-4-83.tpgi.com.au. [14.202.4.83])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902748a00b001a258041049sm14142470pll.32.2023.04.28.23.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 23:34:08 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
Date:   Sat, 29 Apr 2023 16:33:48 +1000
Message-Id: <20230429063348.125544-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This option was created in commit 554b0004d0ec4 ("vtime: Add
HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.

The cputime_t type has since been removed, so this doesn't have any
meaning. Remove it.

Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: Michal Simek <monstr@monstr.eu>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi,

Could we tidy this? I don't know what tree it can go in, timers,
sched, asm-generic, probably doesn't matter.

The only thing this actually does is gate VIRT_CPU_ACCOUNTING_GEN and
NO_HZ_FULL so if your arch has some other issue that requires this
then the documentation needs to change. Any concerns from the archs?
I.e., 32-bit that does *not* define HAVE_VIRT_CPU_ACCOUNTING_GEN
which looks to be:

arc
hexagon
loongarch 32-bit with SMP
m68k
microblaze
mips 32-bit with SMP
nios2
openrisc
parisc 32-bit
riscv 32-bit
sh
sparc 32-bit
um 32-bit
x86 32-bit

Thanks,
Nick
--
 arch/Kconfig           | 11 -----------
 arch/arm/Kconfig       |  1 -
 arch/csky/Kconfig      |  1 -
 arch/loongarch/Kconfig |  1 -
 arch/mips/Kconfig      |  1 -
 arch/powerpc/Kconfig   |  1 -
 arch/xtensa/Kconfig    |  1 -
 init/Kconfig           |  1 -
 kernel/time/Kconfig    |  2 --
 9 files changed, 20 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23e0cad..b77b41d25e40 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -869,17 +869,6 @@ config HAVE_VIRT_CPU_ACCOUNTING_IDLE
 config ARCH_HAS_SCALED_CPUTIME
 	bool
 
-config HAVE_VIRT_CPU_ACCOUNTING_GEN
-	bool
-	default y if 64BIT
-	help
-	  With VIRT_CPU_ACCOUNTING_GEN, cputime_t becomes 64-bit.
-	  Before enabling this option, arch code must be audited
-	  to ensure there are no races in concurrent read/write of
-	  cputime_t. For example, reading/writing 64-bit cputime_t on
-	  some 32-bit arches may require multiple accesses, so proper
-	  locking is needed to protect against concurrent accesses.
-
 config HAVE_IRQ_TIME_ACCOUNTING
 	bool
 	help
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b218f665..9c05f25db4e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -123,7 +123,6 @@ config ARM
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 00379a843c37..dd1decc2a22d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -73,7 +73,6 @@ config CSKY
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_CONTEXT_TRACKING_USER
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f44f6ea54e46..7dc71c89bfae 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -122,7 +122,6 @@ config LOONGARCH
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_TIF_NOHZ
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
 	select MMU_GATHER_MERGE_VMAS if MMU
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c2f5498d207f..d84cb8bbee53 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -87,7 +87,6 @@ config MIPS
 	select HAVE_SPARSE_SYSCALL_NR
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
 	select MODULES_USE_ELF_REL if MODULES
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index acffffbd5d77..185195f349d9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -271,7 +271,6 @@ config PPC
 	select HAVE_STATIC_CALL			if PPC32
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 3c6e5471f025..04f1399d9ce8 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -47,7 +47,6 @@ config XTENSA
 	select HAVE_PERF_EVENTS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
diff --git a/init/Kconfig b/init/Kconfig
index 32c24950c4ce..835fb5e78a8f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -504,7 +504,6 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
 	depends on HAVE_CONTEXT_TRACKING_USER
-	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	depends on GENERIC_CLOCKEVENTS
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING_USER
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index bae8f11070be..d4325dae1f03 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -121,8 +121,6 @@ config NO_HZ_FULL
 	# We need at least one periodic CPU for timekeeping
 	depends on SMP
 	depends on HAVE_CONTEXT_TRACKING_USER
-	# VIRT_CPU_ACCOUNTING_GEN dependency
-	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select NO_HZ_COMMON
 	select RCU_NOCB_CPU
 	select VIRT_CPU_ACCOUNTING_GEN
-- 
2.40.1

