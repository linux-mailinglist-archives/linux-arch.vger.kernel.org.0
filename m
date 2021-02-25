Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5CD3254A0
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 18:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBYRlo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 12:41:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45787 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhBYRlo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 12:41:44 -0500
Received: from 1-171-225-221.dynamic-ip.hinet.net ([1.171.225.221] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lFKdJ-0007hu-1X; Thu, 25 Feb 2021 17:41:01 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH 1/3] PCI: Introduce quirk hook after driver shutdown callback
Date:   Fri, 26 Feb 2021 01:40:38 +0800
Message-Id: <20210225174041.405739-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It can be useful to apply quirk after device shutdown callback, like
putting device into a different power state.

This will be used by later patches.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci-driver.c          | 2 ++
 drivers/pci/quirks.c              | 7 +++++++
 include/asm-generic/vmlinux.lds.h | 3 +++
 include/linux/pci.h               | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ec44a79e951a..7941f6190815 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -498,6 +498,8 @@ static void pci_device_shutdown(struct device *dev)
 	 */
 	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
 		pci_clear_master(pci_dev);
+
+	pci_fixup_device(pci_fixup_shutdown, pci_dev);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..1f94fafc6920 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -93,6 +93,8 @@ extern struct pci_fixup __start_pci_fixups_suspend[];
 extern struct pci_fixup __end_pci_fixups_suspend[];
 extern struct pci_fixup __start_pci_fixups_suspend_late[];
 extern struct pci_fixup __end_pci_fixups_suspend_late[];
+extern struct pci_fixup __start_pci_fixups_shutdown[];
+extern struct pci_fixup __end_pci_fixups_shutdown[];
 
 static bool pci_apply_fixup_final_quirks;
 
@@ -143,6 +145,11 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 		end = __end_pci_fixups_suspend_late;
 		break;
 
+	case pci_fixup_shutdown:
+		start = __start_pci_fixups_shutdown;
+		end = __end_pci_fixups_shutdown;
+		break;
+
 	default:
 		/* stupid compiler warning, you would think with an enum... */
 		return;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c54adce8f6f6..aba43fc2f7b1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -472,6 +472,9 @@
 		__start_pci_fixups_suspend_late = .;			\
 		KEEP(*(.pci_fixup_suspend_late))			\
 		__end_pci_fixups_suspend_late = .;			\
+		__start_pci_fixups_shutdown = .;			\
+		KEEP(*(.pci_fixup_shutdown))				\
+		__end_pci_fixups_shutdown = .;				\
 	}								\
 									\
 	/* Built-in firmware blobs */					\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..7cbe9b21e049 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1923,6 +1923,7 @@ enum pci_fixup_pass {
 	pci_fixup_suspend,	/* pci_device_suspend() */
 	pci_fixup_resume_early, /* pci_device_resume_early() */
 	pci_fixup_suspend_late,	/* pci_device_suspend_late() */
+	pci_fixup_shutdown,	/* pci_device_shutdown() */
 };
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
@@ -2028,6 +2029,9 @@ enum pci_fixup_pass {
 #define DECLARE_PCI_FIXUP_SUSPEND_LATE(vendor, device, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend_late,		\
 		suspend_late##hook, vendor, device, PCI_ANY_ID, 0, hook)
+#define DECLARE_PCI_FIXUP_SHUTDOWN(vendor, device, hook)		\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_shutdown,			\
+		shutdown##hook, vendor, device, PCI_ANY_ID, 0, hook)
 
 #ifdef CONFIG_PCI_QUIRKS
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
-- 
2.30.0

