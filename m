Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC86C0E2F
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 11:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCTKF6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCTKFd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 06:05:33 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79601244B3;
        Mon, 20 Mar 2023 03:04:49 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 400B920FAEE0;
        Mon, 20 Mar 2023 03:03:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 400B920FAEE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679306623;
        bh=m8jjVQgvGPJQeoOJeABcx5K8xClDg9B7AC1Hcldbrs8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MUoybISV2S+ERAmGjzyKq7Wdl8ucOSzVHudOtGJVcZepbSFWVn1W9upTtGRLgyA+k
         lUdlObmhHMu870qd0yXxcBF6RwRxdfcy8Mef1FPL7upOnzKmm9y2Kr/Udy9DhA7gHo
         uIeYdlneVs5pRJyWI9RXcS9yVCYrwt5oxiHyd3O4=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 5/5] x86/Kconfig: Add HYPERV_VTL_MODE
Date:   Mon, 20 Mar 2023 03:03:38 -0700
Message-Id: <1679306618-31484-6-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add HYPERV_VTL_MODE Kconfig flag for VTL mode.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/Kconfig         | 24 ++++++++++++++++++++++++
 arch/x86/hyperv/Makefile |  1 +
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 453f462f6c9c..c3faaaea1e31 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -782,6 +782,30 @@ menuconfig HYPERVISOR_GUEST
 
 if HYPERVISOR_GUEST
 
+config HYPERV_VTL_MODE
+	bool "Enable Linux to boot in VTL context"
+	depends on X86_64 && HYPERV
+	default n
+	help
+	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
+	  enlightenments offered to host and guest partitions which enables
+	  the creation and management of new security boundaries within
+	  operating system software.
+
+	  VSM achieves and maintains isolation through Virtual Trust Levels
+	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
+	  being more privileged than lower levels. VTL0 is the least privileged
+	  level, and currently only other level supported is VTL2.
+
+	  Select this option to build a Linux kernel to run at a VTL other than
+	  the normal VTL0, which currently is only VTL2.  This option
+	  initializes the x86 platform for VTL2, and adds the ability to boot
+	  secondary CPUs directly into 64-bit context as required for VTLs other
+	  than 0.  A kernel built with this option must run at VTL2, and will
+	  not run as a normal guest.
+
+	  If unsure, say N
+
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	depends on HAVE_STATIC_CALL
diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 5d2de10809ae..3a1548054b48 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
+obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
 
 ifdef CONFIG_X86_64
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
-- 
2.34.1

