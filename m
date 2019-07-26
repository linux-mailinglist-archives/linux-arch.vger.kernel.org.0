Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24DA764D6
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2019 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfGZLs2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jul 2019 07:48:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGZLs2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jul 2019 07:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bqXTk9cfjmpDzB1IkFMuceuI5x6lsUr/bZmC2zCRyT8=; b=aXkPCthzPcW+abXaQtzmMoIg92
        DvJjK/+NmjEBuD6QG0igW53oWsB+KWUhGSd9IUqc0Qx62DWBXw0JS1GPP+HVECkZwFresgzZ3BXYd
        BlXvn9iU0bQHeOspSDcIhI7eTYRBtQu12kPhk5Yq1UXseC3zj41yNU1P+O5zXu23DmyVtghIG6pNv
        B6QA8ZndI1sQtVdt+WIjRtebZuz8DfyyGp+QNT6tACSNr4PgHFfupimLAwlyxT73kK6vfV+tlHA+u
        zOst9LO0+4WSX5oNILxHdwS4l73IvkJvJGCd5nxiixUpjUIjUkmghmBAY9Nr/8e0XHfgNPCcnDFcC
        OrS3TD8g==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqyh9-0003BZ-4S; Fri, 26 Jul 2019 11:47:31 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hqyh6-0000tq-VT; Fri, 26 Jul 2019 08:47:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Ajay Gupta <ajayg@nvidia.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/7] docs: fix broken doc references due to renames
Date:   Fri, 26 Jul 2019 08:47:21 -0300
Message-Id: <430ed96cb234805d1deb216e8c8559da22cc6bac.1564140865.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564140865.git.mchehab+samsung@kernel.org>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some files got renamed but probably due to some merge conflicts,
a few references still point to the old locations.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Wolfram Sang <wsa@the-dreams.de> # I2C part
Reviewed-by: Jerry Hoemann <jerry.hoemann@hpe.com> # hpwdt.rst
---
 Documentation/RCU/rculist_nulls.txt                   |  2 +-
 Documentation/devicetree/bindings/arm/idle-states.txt |  2 +-
 Documentation/locking/spinlocks.rst                   |  4 ++--
 Documentation/memory-barriers.txt                     |  2 +-
 Documentation/translations/ko_KR/memory-barriers.txt  |  2 +-
 Documentation/watchdog/hpwdt.rst                      |  2 +-
 MAINTAINERS                                           | 10 +++++-----
 drivers/gpu/drm/drm_modes.c                           |  2 +-
 drivers/i2c/busses/i2c-nvidia-gpu.c                   |  2 +-
 drivers/scsi/hpsa.c                                   |  4 ++--
 10 files changed, 16 insertions(+), 16 deletions(-)

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
diff --git a/Documentation/locking/spinlocks.rst b/Documentation/locking/spinlocks.rst
index 098107fb7d86..e93ec6645238 100644
--- a/Documentation/locking/spinlocks.rst
+++ b/Documentation/locking/spinlocks.rst
@@ -82,7 +82,7 @@ itself.  The read lock allows many concurrent readers.  Anything that
 **changes** the list will have to get the write lock.
 
    NOTE! RCU is better for list traversal, but requires careful
-   attention to design detail (see Documentation/RCU/listRCU.txt).
+   attention to design detail (see Documentation/RCU/listRCU.rst).
 
 Also, you cannot "upgrade" a read-lock to a write-lock, so if you at _any_
 time need to do any changes (even if you don't do it every time), you have
@@ -90,7 +90,7 @@ to get the write-lock at the very beginning.
 
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
 
diff --git a/Documentation/watchdog/hpwdt.rst b/Documentation/watchdog/hpwdt.rst
index c165d92cfd12..c824cd7f6e32 100644
--- a/Documentation/watchdog/hpwdt.rst
+++ b/Documentation/watchdog/hpwdt.rst
@@ -63,7 +63,7 @@ Last reviewed: 08/20/2018
  and loop forever.  This is generally not what a watchdog user wants.
 
  For those wishing to learn more please see:
-	Documentation/kdump/kdump.rst
+	Documentation/admin-guide/kdump/kdump.rst
 	Documentation/admin-guide/kernel-parameters.txt (panic=)
 	Your Linux Distribution specific documentation.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2a525e22c0..51bdbd230174 100644
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
@@ -4190,7 +4190,7 @@ M:	Jens Axboe <axboe@kernel.dk>
 L:	cgroups@vger.kernel.org
 L:	linux-block@vger.kernel.org
 T:	git git://git.kernel.dk/linux-block
-F:	Documentation/cgroup-v1/blkio-controller.rst
+F:	Documentation/admin-guide/cgroup-v1/blkio-controller.rst
 F:	block/blk-cgroup.c
 F:	include/linux/blk-cgroup.h
 F:	block/blk-throttle.c
@@ -6317,7 +6317,7 @@ FLEXTIMER FTM-QUADDEC DRIVER
 M:	Patrick Havelange <patrick.havelange@essensium.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quadddec
+F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
 F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
 F:	drivers/counter/ftm-quaddec.c
 
@@ -6856,7 +6856,7 @@ R:	Sagi Shahar <sagis@google.com>
 R:	Jon Olson <jonolson@google.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-F:	Documentation/networking/device_drivers/google/gve.txt
+F:	Documentation/networking/device_drivers/google/gve.rst
 F:	drivers/net/ethernet/google
 
 GPD POCKET FAN DRIVER
@@ -12137,7 +12137,7 @@ M:	Thomas Hellstrom <thellstrom@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
-F:	Documentation/virt/paravirt_ops.txt
+F:	Documentation/virt/paravirt_ops.rst
 F:	arch/*/kernel/paravirt*
 F:	arch/*/include/asm/paravirt*.h
 F:	include/linux/hypervisor.h
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 74a5739df506..80fcd5dc1558 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1686,7 +1686,7 @@ static int drm_mode_parse_cmdline_options(char *str, size_t len,
  *
  * Additionals options can be provided following the mode, using a comma to
  * separate each option. Valid options can be found in
- * Documentation/fb/modedb.txt.
+ * Documentation/fb/modedb.rst.
  *
  * The intermediate drm_cmdline_mode structure is required to store additional
  * options from the command line modline like the force-enable/disable flag.
diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
index cfc76b5de726..5a1235fd86bb 100644
--- a/drivers/i2c/busses/i2c-nvidia-gpu.c
+++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
@@ -364,7 +364,7 @@ static void gpu_i2c_remove(struct pci_dev *pdev)
 /*
  * We need gpu_i2c_suspend() even if it is stub, for runtime pm to work
  * correctly. Without it, lspci shows runtime pm status as "D0" for the card.
- * Documentation/power/pci.txt also insists for driver to provide this.
+ * Documentation/power/pci.rst also insists for driver to provide this.
  */
 static __maybe_unused int gpu_i2c_suspend(struct device *dev)
 {
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

