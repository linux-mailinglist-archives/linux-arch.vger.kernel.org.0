Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0556D68612
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2019 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfGOJMN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jul 2019 05:12:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfGOJMN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 05:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G74tw8/WRevpQR45VkSXUw895ku/QpK/SEIzWOOpE7M=; b=GIS8ohvL4nhs8885qyPsS4p/H
        C/eZqHfFt6ngpx+bTOTkjUp4sw1so4Dk6MilrU5r9T1MB9hKY3BvPeSiNoyAfISpZJykRgMJKE8bP
        tBcMBorFQvtMmtdN8JCujcCAus/rZoLknbrGsxNnF6kAaomADv5cEhV4y5vdofLDEILdmOJm+Kspw
        Odam9/SbL1M+FHigZGZDcs9GlF9c7bcQUA3AXXLuMoLJw97xN35yxet/a4SkIa+U5+Nctc0gPKugY
        V4I9DaKZfA3uv6F0LmBAc/hY3ojc8fubKl4Da7W3swYIUc2IFy80uUi+nXlwCyJFVqV750ACWI361
        OYNjOzwJg==;
Received: from [189.27.46.152] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmx1n-0005vg-N8; Mon, 15 Jul 2019 09:12:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmx1l-0001dt-Jf; Mon, 15 Jul 2019 06:12:09 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org
Subject: [PATCH] docs: fix broken doc links due to renames
Date:   Mon, 15 Jul 2019 06:12:08 -0300
Message-Id: <93185ad3a67685429c84fceb94d20fb500c0aedb.1563181814.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some files got renamed but the patch was incomplete, as it forgot
to update the documentation reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---

This patch is against current linus/master branch.

 Documentation/RCU/rculist_nulls.txt                   | 2 +-
 Documentation/devicetree/bindings/arm/idle-states.txt | 2 +-
 Documentation/locking/spinlocks.txt                   | 4 ++--
 Documentation/memory-barriers.txt                     | 2 +-
 Documentation/translations/ko_KR/memory-barriers.txt  | 2 +-
 MAINTAINERS                                           | 6 +++---
 drivers/scsi/hpsa.c                                   | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.txt b/Documentation/RCU/rculist_nulls.txt
index 8151f0195f76..23f115dc87cf 100644
--- a/Documentation/RCU/rculist_nulls.txt
+++ b/Documentation/RCU/rculist_nulls.txt
@@ -1,7 +1,7 @@
 Using hlist_nulls to protect read-mostly linked lists and
 objects using SLAB_TYPESAFE_BY_RCU allocations.
 
-Please read the basics in Documentation/RCU/listRCU.txt
+Please read the basics in Documentation/RCU/listRCU.rst
 
 Using special makers (called 'nulls') is a convenient way
 to solve following problem :
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index 326f29b270ad..2d325bed37e5 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -703,4 +703,4 @@ cpus {
     https://www.devicetree.org/specifications/
 
 [6] ARM Linux Kernel documentation - Booting AArch64 Linux
-    Documentation/arm64/booting.txt
+    Documentation/arm64/booting.rst
diff --git a/Documentation/locking/spinlocks.txt b/Documentation/locking/spinlocks.txt
index ff35e40bdf5b..430b641ae072 100644
--- a/Documentation/locking/spinlocks.txt
+++ b/Documentation/locking/spinlocks.txt
@@ -74,7 +74,7 @@ itself.  The read lock allows many concurrent readers.  Anything that
 _changes_ the list will have to get the write lock.
 
    NOTE! RCU is better for list traversal, but requires careful
-   attention to design detail (see Documentation/RCU/listRCU.txt).
+   attention to design detail (see Documentation/RCU/listRCU.rst).
 
 Also, you cannot "upgrade" a read-lock to a write-lock, so if you at _any_
 time need to do any changes (even if you don't do it every time), you have
@@ -82,7 +82,7 @@ to get the write-lock at the very beginning.
 
    NOTE! We are working hard to remove reader-writer spinlocks in most
    cases, so please don't add a new one without consensus.  (Instead, see
-   Documentation/RCU/rcu.txt for complete information.)
+   Documentation/RCU/rcu.rst for complete information.)
 
 ----
 
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 045bb8148fe9..1adbb8a371c7 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -548,7 +548,7 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 
 	[*] For information on bus mastering DMA and coherency please read:
 
-	    Documentation/PCI/pci.rst
+	    Documentation/driver-api/pci/pci.rst
 	    Documentation/DMA-API-HOWTO.txt
 	    Documentation/DMA-API.txt
 
diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index a33c2a536542..2774624ee843 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -569,7 +569,7 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 
 	[*] 버스 마스터링 DMA 와 일관성에 대해서는 다음을 참고하시기 바랍니다:
 
-	    Documentation/PCI/pci.rst
+	    Documentation/driver-api/pci/pci.rst
 	    Documentation/DMA-API-HOWTO.txt
 	    Documentation/DMA-API.txt
 
diff --git a/MAINTAINERS b/MAINTAINERS
index f5533d1bda2e..51ad84a3f4e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -899,7 +899,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7124.c
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
 
 ANALOG DEVICES INC AD7606 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
@@ -6828,7 +6828,7 @@ R:	Sagi Shahar <sagis@google.com>
 R:	Jon Olson <jonolson@google.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-F:	Documentation/networking/device_drivers/google/gve.txt
+F:	Documentation/networking/device_drivers/google/gve.rst
 F:	drivers/net/ethernet/google
 
 GPD POCKET FAN DRIVER
@@ -12077,7 +12077,7 @@ M:	Juergen Gross <jgross@suse.com>
 M:	Alok Kataria <akataria@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
-F:	Documentation/virtual/paravirt_ops.txt
+F:	Documentation/virtual/paravirt_ops.rst
 F:	arch/*/kernel/paravirt*
 F:	arch/*/include/asm/paravirt*.h
 F:	include/linux/hypervisor.h
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 43a6b5350775..eaf6177ac9ee 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7798,7 +7798,7 @@ static void hpsa_free_pci_init(struct ctlr_info *h)
 	hpsa_disable_interrupt_mode(h);		/* pci_init 2 */
 	/*
 	 * call pci_disable_device before pci_release_regions per
-	 * Documentation/PCI/pci.rst
+	 * Documentation/driver-api/pci/pci.rst
 	 */
 	pci_disable_device(h->pdev);		/* pci_init 1 */
 	pci_release_regions(h->pdev);		/* pci_init 2 */
@@ -7881,7 +7881,7 @@ static int hpsa_pci_init(struct ctlr_info *h)
 clean1:
 	/*
 	 * call pci_disable_device before pci_release_regions per
-	 * Documentation/PCI/pci.rst
+	 * Documentation/driver-api/pci/pci.rst
 	 */
 	pci_disable_device(h->pdev);
 	pci_release_regions(h->pdev);
-- 
2.21.0


