Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ECA44C953
	for <lists+linux-arch@lfdr.de>; Wed, 10 Nov 2021 20:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhKJTsW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Nov 2021 14:48:22 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60816 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhKJTsV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Nov 2021 14:48:21 -0500
Received: by linux.microsoft.com (Postfix, from userid 1109)
        id 4B82E20ABAEE; Wed, 10 Nov 2021 11:45:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B82E20ABAEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636573533;
        bh=MBYtjWy87D0oujwOAGiYcyIO0cd4QZq20VJC/Hexl1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=aAWDSVORzwUL5eTyvcYXInAJhI6sbWjGIDb1nhsxs2e1VHPwyG7a1+fWFIImhbh3l
         zhP1qeWLgJdmjGtKJxgX0/AJ1aD6bFJsRrAdGqIYqkw8k6iJH7Tw53TQwJUqJ4NZ71
         29XXjGYw7XdsCpDwUX8g1PP/3Idwu0g6is8LHefU=
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
Subject: [PATCH v5 0/2] PCI: hv: Hyper-V vPCI for arm64
Date:   Wed, 10 Nov 2021 11:45:08 -0800
Message-Id: <1636573510-23838-1-git-send-email-sunilmut@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Current Hyper-V vPCI code only compiles and works for x86. There are some
hardcoded assumptions about the architectural IRQ chip and other arch
defines.

Add support for Hyper-V vPCI for arm64 by first breaking the current hard
coded dependency using a set of new interfaces and implementing those for
x86 first. That is in the first patch. The second patch adds support for
Hyper-V vPCI for arm64 by implementing the above mentioned interfaces. That
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

changes in v3 -> v4:
 - Removed the separate file for IRQ chip that was there in previous
   iterations and moved the IRQ chip implementation to pci-hyperv.c.
   Feedback by Michael Kelley and Marc Zyngier.
 - Addressed various comments from Marc Zyngier about structuring and
   layout.
 - Addressed comment from Marc Zyngier about IRQ affinity and other
   miscellaneous comments.

changes in v4 -> v5:
 - Fixed an issue with picking the right cpu for irq affinity, identified
   by Marc Zyngier.

Sunil Muthuswamy (2):
  PCI: hv: Make the code arch neutral by adding arch specific interfaces
  arm64: PCI: hv: Add support for Hyper-V vPCI

 arch/arm64/include/asm/hyperv-tlfs.h |   9 +
 arch/x86/include/asm/hyperv-tlfs.h   |  33 ++++
 arch/x86/include/asm/mshyperv.h      |   7 -
 drivers/pci/Kconfig                  |   2 +-
 drivers/pci/controller/Kconfig       |   2 +-
 drivers/pci/controller/pci-hyperv.c  | 281 ++++++++++++++++++++++++---
 include/asm-generic/hyperv-tlfs.h    |  33 ----
 7 files changed, 300 insertions(+), 67 deletions(-)


base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
-- 
2.25.1


