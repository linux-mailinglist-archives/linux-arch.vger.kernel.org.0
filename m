Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2516442DEB0
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhJNP42 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 11:56:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44752 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNP41 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 11:56:27 -0400
Received: by linux.microsoft.com (Postfix, from userid 1109)
        id AA62B20B9CE1; Thu, 14 Oct 2021 08:54:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA62B20B9CE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1634226862;
        bh=YB4I9rUAK3vcnSkYOnr2ykSIPEEhXjSjXcsDdSboAQo=;
        h=From:To:Cc:Subject:Date:From;
        b=hS8fnk9MmAXTyDVelMauVGvEOmFVK0iOhQ0n/OU73QTdoMaUoF3GKWYcOF8f/ueMl
         SC+kx7Zc8sTZQmRSBZHC70LT1SJJUze7w4mR7NJ12C5NWD1/WUxwGkPXZj5Ysk4RqM
         7cu2YpyLYkIBctMPDMLriNI79ATRVi+XmICTV2GI=
From:   Sunil Muthuswamy <sunilmut@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, maz@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, arnd@arndb.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v3 0/2] PCI: hv: Hyper-V vPCI for ARM64
Date:   Thu, 14 Oct 2021 08:53:12 -0700
Message-Id: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Current Hyper-V vPCI code only compiles and works for x64. There are some
hardcoded assumptions about the architectural IRQ chip and other arch
defines.

Add support for Hyper-V vPCI for ARM64 by first breaking the current hard
coded dependency using a set of new interfaces and implementing those for
X64 first. That is in the first patch. The second patch adds support for
Hyper-V vPCI for ARM64 by implementing the above mentioned interfaces. That
is done by introducing a Hyper-V vPCI specific MSI IRQ domain & chip for
allocating SPI vectors.

changes in v1 -> v2:
 - Moved the irqchip implementation to drivers/pci as suggested
   by Marc Zyngier
 - Addressed Multi-MSI handling issues identified by Marc Zyngier
 - Addressed lock/synchronization primitive as suggested by Marc
   Zyngier
 - Addressed other code feedback from Marc Zyngier

changes in v2 -> v3:
 - Addressed comments from Bjorn Helgaas about patch formatting and
   verbiage
 - Using 'git send-email' to ensure that the patch series is correctly
   threaded. Feedback by Bjorn Helgaas
 - Fixed Hyper-V vPCI build break for module build, reported by Boqun Feng

Sunil Muthuswamy (2):
  PCI: hv: Make the code arch neutral by adding arch specific interfaces
  arm64: PCI: hv: Add support for Hyper-V vPCI

 MAINTAINERS                                 |   2 +
 arch/arm64/include/asm/hyperv-tlfs.h        |   9 +
 arch/x86/include/asm/hyperv-tlfs.h          |  33 +++
 arch/x86/include/asm/mshyperv.h             |   7 -
 drivers/pci/Kconfig                         |   2 +-
 drivers/pci/controller/Kconfig              |   2 +-
 drivers/pci/controller/Makefile             |   2 +-
 drivers/pci/controller/pci-hyperv-irqchip.c | 267 ++++++++++++++++++++
 drivers/pci/controller/pci-hyperv-irqchip.h |  20 ++
 drivers/pci/controller/pci-hyperv.c         |  58 +++--
 include/asm-generic/hyperv-tlfs.h           |  33 ---
 11 files changed, 373 insertions(+), 62 deletions(-)
 create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.c
 create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.h


base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
-- 
2.25.1

