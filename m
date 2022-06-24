Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427C559DCB
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 17:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiFXPw6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 11:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiFXPwx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 11:52:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187524FC47;
        Fri, 24 Jun 2022 08:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 69E42CE2B19;
        Fri, 24 Jun 2022 15:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B711AC341C6;
        Fri, 24 Jun 2022 15:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656085959;
        bh=r0vcG585IDBUqw6bBZgghthUQvPMHU3og+OUJSpoboM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5pHRPynXsgQIAcEbUEuYgQ8TPpDLVSBjG7ThUKbF8Ha3AOPrltnugHto270cKrj9
         EL5PFNxU5PE/tRlBpw941B9L1o4b+bpWyChGC1YUdgIxI2rOBpD+RXe68+fzjn1P5f
         b3XZtrA9nFwSr11EXO0H8b1tm45+yppgUux59qFMDKF7nwdFO8WfDBLqFbFgb45E39
         w2HC0aVxcKz/P0LCK+Cu5mBV1bulCQ68du/B9vqPG2xvwgix45m1JolDibMLEXk7rT
         Ut0LQQTTY7aA31/eA8sWnRwtNR7YvMahN7RI9bNHp2C0njTVMKyVR79E+QhiYGaTt6
         T9Qq2bXE+1sxw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-scsi@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 1/3] scsi: BusLogic remove bus_to_virt
Date:   Fri, 24 Jun 2022 17:52:24 +0200
Message-Id: <20220624155226.2889613-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220624155226.2889613-1-arnd@kernel.org>
References: <20220624155226.2889613-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The BusLogic driver is the last remaining driver that relies on the
deprecated bus_to_virt() function, which in turn only works on a few
architectures, and is incompatible with both swiotlb and iommu support.

Before commit 391e2f25601e ("[SCSI] BusLogic: Port driver to 64-bit."),
the driver had a dependency on x86-32, presumably because of this
problem. However, the change introduced another bug that made it still
impossible to use the driver on any 64-bit machine.

This was in turn fixed in commit 56f396146af2 ("scsi: BusLogic: Fix
64-bit system enumeration error for Buslogic"), 8 years later, which
shows that there are not a lot of users.

Maciej is still using the driver on 32-bit hardware, and Khalid mentioned
that the driver works with the device emulation used in VirtualBox
and VMware. Both of those only emulate it for Windows 2000 and older
operating systems that did not ship with the better LSI logic driver.

Do a minimum fix that searches through the list of descriptors to find
one that matches the bus address. This is clearly as inefficient as
was indicated in the code comment about the lack of a bus_to_virt()
replacement. A better fix would likely involve changing out the entire
descriptor allocation for a simpler one, but that would be much
more invasive.

Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: Matt Wang <wwentao@vmware.com>
Tested-by: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: Address issues pointed out by Khalid Aziz
v2: Attempt to fix the driver instead of removing it
---
 drivers/scsi/BusLogic.c | 35 +++++++++++++++++++++++------------
 drivers/scsi/Kconfig    |  2 +-
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index a897c8f914cf..f2abffce2659 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2515,12 +2515,26 @@ static int blogic_resultcode(struct blogic_adapter *adapter,
 	return (hoststatus << 16) | tgt_status;
 }
 
+/*
+ * turn the dma address from an inbox into a ccb pointer
+ * This is rather inefficient.
+ */
+static struct blogic_ccb *
+blogic_inbox_to_ccb(struct blogic_adapter *adapter, struct blogic_inbox *inbox)
+{
+	struct blogic_ccb *ccb;
+
+	for (ccb = adapter->all_ccbs; ccb; ccb = ccb->next_all)
+		if (inbox->ccb == ccb->dma_handle)
+			break;
+
+	return ccb;
+}
 
 /*
   blogic_scan_inbox scans the Incoming Mailboxes saving any
   Incoming Mailbox entries for completion processing.
 */
-
 static void blogic_scan_inbox(struct blogic_adapter *adapter)
 {
 	/*
@@ -2540,17 +2554,14 @@ static void blogic_scan_inbox(struct blogic_adapter *adapter)
 	enum blogic_cmplt_code comp_code;
 
 	while ((comp_code = next_inbox->comp_code) != BLOGIC_INBOX_FREE) {
-		/*
-		   We are only allowed to do this because we limit our
-		   architectures we run on to machines where bus_to_virt(
-		   actually works.  There *needs* to be a dma_addr_to_virt()
-		   in the new PCI DMA mapping interface to replace
-		   bus_to_virt() or else this code is going to become very
-		   innefficient.
-		 */
-		struct blogic_ccb *ccb =
-			(struct blogic_ccb *) bus_to_virt(next_inbox->ccb);
-		if (comp_code != BLOGIC_CMD_NOTFOUND) {
+		struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter, next_inbox);
+		if (!ccb) {
+			/*
+			 * This should never happen, unless the CCB list is
+			 * corrupted in memory.
+			 */
+			blogic_warn("Could not find CCB for dma address %x\n", adapter, next_inbox->ccb);
+		} else if (comp_code != BLOGIC_CMD_NOTFOUND) {
 			if (ccb->status == BLOGIC_CCB_ACTIVE ||
 					ccb->status == BLOGIC_CCB_RESET) {
 				/*
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 6e3a04107bb6..689186f3a908 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -514,7 +514,7 @@ config SCSI_HPTIOP
 
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
-	depends on PCI && SCSI && VIRT_TO_BUS
+	depends on PCI && SCSI
 	help
 	  This is support for BusLogic MultiMaster and FlashPoint SCSI Host
 	  Adapters. Consult the SCSI-HOWTO, available from
-- 
2.29.2

