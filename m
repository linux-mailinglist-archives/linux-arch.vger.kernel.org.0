Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC003182F65
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 12:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgCLLjr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 07:39:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:19045 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLLjq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 07:39:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 04:39:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="266305925"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2020 04:39:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 978B8193; Thu, 12 Mar 2020 13:39:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] asm-generic: Provide generic {get,put}_unaligned_{l,b}e24()
Date:   Thu, 12 Mar 2020 13:39:41 +0200
Message-Id: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
implementation. Provide generic helpers once for all.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nvme/host/rdma.c                     |  8 -------
 drivers/nvme/target/rdma.c                   |  6 -----
 drivers/usb/gadget/function/storage_common.h |  5 ----
 include/asm-generic/unaligned.h              | 25 ++++++++++++++++++++
 include/target/target_core_backend.h         |  6 -----
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e85c5cacefd..2845118e6e40 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -142,14 +142,6 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
 static const struct blk_mq_ops nvme_rdma_mq_ops;
 static const struct blk_mq_ops nvme_rdma_admin_mq_ops;
 
-/* XXX: really should move to a generic header sooner or later.. */
-static inline void put_unaligned_le24(u32 val, u8 *p)
-{
-	*p++ = val;
-	*p++ = val >> 8;
-	*p++ = val >> 16;
-}
-
 static inline int nvme_rdma_queue_idx(struct nvme_rdma_queue *queue)
 {
 	return queue - queue->ctrl->queues;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a65877..8fcede75e02a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -143,12 +143,6 @@ static int num_pages(int len)
 	return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
 }
 
-/* XXX: really should move to a generic header sooner or later.. */
-static inline u32 get_unaligned_le24(const u8 *p)
-{
-	return (u32)p[0] | (u32)p[1] << 8 | (u32)p[2] << 16;
-}
-
 static inline bool nvmet_rdma_need_data_in(struct nvmet_rdma_rsp *rsp)
 {
 	return nvme_is_write(rsp->req.cmd) &&
diff --git a/drivers/usb/gadget/function/storage_common.h b/drivers/usb/gadget/function/storage_common.h
index e5e3a2553aaa..bdeb1e233fc9 100644
--- a/drivers/usb/gadget/function/storage_common.h
+++ b/drivers/usb/gadget/function/storage_common.h
@@ -172,11 +172,6 @@ enum data_direction {
 	DATA_DIR_NONE
 };
 
-static inline u32 get_unaligned_be24(u8 *buf)
-{
-	return 0xffffff & (u32) get_unaligned_be32(buf - 1);
-}
-
 static inline struct fsg_lun *fsg_lun_from_dev(struct device *dev)
 {
 	return container_of(dev, struct fsg_lun, dev);
diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 374c940e9be1..dd9f9695d1ba 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -33,4 +33,29 @@
 # error need to define endianess
 #endif
 
+/* 24-bit unaligned access is special for now, that's why explicitly here */
+static inline u32 get_unaligned_le24(const u8 *p)
+{
+	return (u32)p[0] | (u32)p[1] << 8 | (u32)p[2] << 16;
+}
+
+static inline void put_unaligned_le24(const u32 val, u8 *p)
+{
+	*p++ = val;
+	*p++ = val >> 8;
+	*p++ = val >> 16;
+}
+
+static inline u32 get_unaligned_be24(const u8 *buf)
+{
+	return (u32)p[0] << 16 | (u32)p[1] << 8 | (u32)p[2];
+}
+
+static inline void put_unaligned_be24(const u32 val, u8 *p)
+{
+	*p++ = val >> 16;
+	*p++ = val >> 8;
+	*p++ = val;
+}
+
 #endif /* __ASM_GENERIC_UNALIGNED_H */
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index 51b6f50eabee..1b752d8ea529 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -116,10 +116,4 @@ static inline bool target_dev_configured(struct se_device *se_dev)
 	return !!(se_dev->dev_flags & DF_CONFIGURED);
 }
 
-/* Only use get_unaligned_be24() if reading p - 1 is allowed. */
-static inline uint32_t get_unaligned_be24(const uint8_t *const p)
-{
-	return get_unaligned_be32(p - 1) & 0xffffffU;
-}
-
 #endif /* TARGET_CORE_BACKEND_H */
-- 
2.25.1

