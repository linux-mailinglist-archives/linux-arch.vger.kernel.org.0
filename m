Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD9F3F36
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfKHFDq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:03:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40626 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHFDq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so3281335pgt.7
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdvEVhpO2tfoQPiqlAS/jN/jgmn7Yx7h2NCRcoLzN4w=;
        b=pJOzNoFXEctbYIRWrT2Z2uxo2HB2TXelw/XBXPSyC0Odt5rV1iA84wcWhWVEA4xpdp
         iWEweSB/Boc/P+nr2CTkvQnWX5ysc9nRAa0slGafX8zhgBn8+8E+E6f+GZeNRNX6m35d
         Mo8nUfP9aBBAhy8Ogbc0CfVlqMP0UBx3SbCeO8Rr3IKas3praKqi/+ihEKMOFAIB625I
         LVBbr4N3U5wnhj+am6in10K+DWj/TpCg5e3CwqpNOsI+b/jOvrV4VKcqrKoXG2YpUCLM
         5hcGS2h9aZMVfkKU5dF0N/ju9w5R9o3dDQDXjus8MWrQsFknJickr3sTVtWrgOF4eu+x
         VDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdvEVhpO2tfoQPiqlAS/jN/jgmn7Yx7h2NCRcoLzN4w=;
        b=ds7ivNAJDbOrkERPBLQ6NoBexhE1QHm14jWzK+Yr80bZ8dmoOULadVwU+OZqRQrQPn
         1FFiMjk9QaaX0rxBgX4NzTro9EKaEu3Fp6hI5vwU/b3RwoYlQAOLc1FClYheCylMfNA2
         9UGLvGXvw8ydt1LIpyJY+kqeiHPLw7X9Nc2u8rd6mNJH9y9FBYkm7zORp9Lxi12ATUAr
         dRQmr+s0F8pKLyZFT3mHYYwmn7I4eT2Xp4ofgDRSE+XFuCqgd05pS+NPMgQ6Y2QMuJvB
         BBd0zzFjAqA3alzkpLBEP5H/LUZ860fIh0qEEESMgMDDSMP6wF37G7pDlOM3F9gK5HP0
         hgFw==
X-Gm-Message-State: APjAAAW89m/4qjNzNI26wK/IEw4bRypESjAiK9rrdlGZx9ek6LsOBqT1
        26pej0kBy3NfinGVgn0SSU4mWMGvdsmAlQ==
X-Google-Smtp-Source: APXvYqy/CD86CR3QYFfDMXfHU0/q86BGE3aRpnoQSYAYQfJ5k/6cJHZRVLMovUEGHA+bgOYpOeJzVg==
X-Received: by 2002:aa7:959d:: with SMTP id z29mr9123004pfj.208.1573189424867;
        Thu, 07 Nov 2019 21:03:44 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id h9sm5718716pjh.8.2019.11.07.21.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:03:43 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 13335201ACFD69; Fri,  8 Nov 2019 14:03:42 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Conrad Meyer <cem@FreeBSD.org>,
        Hajime Tazaki <thehajime@gmail.com>,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Yuan Liu <liuyuan@google.com>
Subject: [RFC v2 17/37] lkl tools: host lib: virtio devices
Date:   Fri,  8 Nov 2019 14:02:32 +0900
Message-Id: <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

Add helpers for implementing host virtio devices. It uses the memory
mapped I/O helpers to interact with the Linux MMIO virtio transport
driver and offers support to setup and add a new virtio device,
dispatch requests from the incoming queues as well as support for
completing requests.

All added virtio devices are stored in lkl_virtio_devs as strings, per
the Linux MMIO virtio transport driver command line specification.

Signed-off-by: Conrad Meyer <cem@FreeBSD.org>
Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
Signed-off-by: Patrick Collins <pscollins@google.com>
Signed-off-by: Yuan Liu <liuyuan@google.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/include/lkl_host.h |   1 +
 tools/lkl/lib/Build          |   1 +
 tools/lkl/lib/virtio.c       | 631 +++++++++++++++++++++++++++++++++++
 tools/lkl/lib/virtio.h       |  93 ++++++
 4 files changed, 726 insertions(+)
 create mode 100644 tools/lkl/lib/virtio.c
 create mode 100644 tools/lkl/lib/virtio.h

diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
index 85e80eb4ad0d..81239e2b556f 100644
--- a/tools/lkl/include/lkl_host.h
+++ b/tools/lkl/include/lkl_host.h
@@ -18,6 +18,7 @@ extern struct lkl_host_operations lkl_host_ops;
  */
 int lkl_printf(const char *fmt, ...);
 
+extern char lkl_virtio_devs[4096];
 
 #ifdef __cplusplus
 }
diff --git a/tools/lkl/lib/Build b/tools/lkl/lib/Build
index 8d01982638f8..5fd1843b51d1 100644
--- a/tools/lkl/lib/Build
+++ b/tools/lkl/lib/Build
@@ -3,6 +3,7 @@ CFLAGS_config.o += -I$(srctree)/tools/perf/pmu-events
 liblkl-y += iomem.o
 liblkl-y += jmp_buf.o
 liblkl-y += utils.o
+liblkl-y += virtio.o
 liblkl-y += dbg.o
 liblkl-y += dbg_handler.o
 liblkl-y += ../../perf/pmu-events/jsmn.o
diff --git a/tools/lkl/lib/virtio.c b/tools/lkl/lib/virtio.c
new file mode 100644
index 000000000000..c5247665482d
--- /dev/null
+++ b/tools/lkl/lib/virtio.c
@@ -0,0 +1,631 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <lkl_host.h>
+#include <lkl/linux/virtio_ring.h>
+#include "iomem.h"
+#include "virtio.h"
+#include "endian.h"
+
+#define VIRTIO_DEV_MAGIC		0x74726976
+#define VIRTIO_DEV_VERSION		2
+
+#define VIRTIO_MMIO_MAGIC_VALUE		0x000
+#define VIRTIO_MMIO_VERSION		0x004
+#define VIRTIO_MMIO_DEVICE_ID		0x008
+#define VIRTIO_MMIO_VENDOR_ID		0x00c
+#define VIRTIO_MMIO_DEVICE_FEATURES	0x010
+#define VIRTIO_MMIO_DEVICE_FEATURES_SEL 0x014
+#define VIRTIO_MMIO_DRIVER_FEATURES	0x020
+#define VIRTIO_MMIO_DRIVER_FEATURES_SEL 0x024
+#define VIRTIO_MMIO_QUEUE_SEL		0x030
+#define VIRTIO_MMIO_QUEUE_NUM_MAX	0x034
+#define VIRTIO_MMIO_QUEUE_NUM		0x038
+#define VIRTIO_MMIO_QUEUE_READY		0x044
+#define VIRTIO_MMIO_QUEUE_NOTIFY	0x050
+#define VIRTIO_MMIO_INTERRUPT_STATUS	0x060
+#define VIRTIO_MMIO_INTERRUPT_ACK	0x064
+#define VIRTIO_MMIO_STATUS		0x070
+#define VIRTIO_MMIO_QUEUE_DESC_LOW	0x080
+#define VIRTIO_MMIO_QUEUE_DESC_HIGH	0x084
+#define VIRTIO_MMIO_QUEUE_AVAIL_LOW	0x090
+#define VIRTIO_MMIO_QUEUE_AVAIL_HIGH	0x094
+#define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
+#define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
+#define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
+#define VIRTIO_MMIO_CONFIG		0x100
+#define VIRTIO_MMIO_INT_VRING		0x01
+#define VIRTIO_MMIO_INT_CONFIG		0x02
+
+#define BIT(x) (1ULL << x)
+
+#define virtio_panic(msg, ...) do {					\
+		lkl_printf("LKL virtio error" msg, ##__VA_ARGS__);	\
+		lkl_host_ops.panic();					\
+	} while (0)
+
+struct virtio_queue {
+	uint32_t num_max;
+	uint32_t num;
+	uint32_t ready;
+	uint32_t max_merge_len;
+
+	struct lkl_vring_desc *desc;
+	struct lkl_vring_avail *avail;
+	struct lkl_vring_used *used;
+	uint16_t last_avail_idx;
+	uint16_t last_used_idx_signaled;
+};
+
+struct _virtio_req {
+	struct virtio_req req;
+	struct virtio_dev *dev;
+	struct virtio_queue *q;
+	uint16_t idx;
+};
+
+
+static inline uint16_t virtio_get_used_event(struct virtio_queue *q)
+{
+	return q->avail->ring[q->num];
+}
+
+static inline void virtio_set_avail_event(struct virtio_queue *q, uint16_t val)
+{
+	*((uint16_t *)&q->used->ring[q->num]) = val;
+}
+
+static inline void virtio_deliver_irq(struct virtio_dev *dev)
+{
+	dev->int_status |= VIRTIO_MMIO_INT_VRING;
+	/* Make sure all memory writes before are visible to the driver. */
+	__sync_synchronize();
+	lkl_trigger_irq(dev->irq);
+}
+
+static inline uint16_t virtio_get_used_idx(struct virtio_queue *q)
+{
+	return le16toh(q->used->idx);
+}
+
+static inline void virtio_add_used(struct virtio_queue *q, uint16_t used_idx,
+				   uint16_t avail_idx, uint16_t len)
+{
+	uint16_t desc_idx = q->avail->ring[avail_idx & (q->num - 1)];
+
+	used_idx = used_idx & (q->num - 1);
+	q->used->ring[used_idx].id = desc_idx;
+	q->used->ring[used_idx].len = htole16(len);
+}
+
+/*
+ * Make sure all memory writes before are visible to the driver before updating
+ * the idx.  We need it here even we already have one in virtio_deliver_irq()
+ * because there might already be an driver thread reading the idx and dequeuing
+ * used buffers.
+ */
+static inline void virtio_sync_used_idx(struct virtio_queue *q, uint16_t idx)
+{
+	__sync_synchronize();
+	q->used->idx = htole16(idx);
+}
+
+#define min_len(a, b) (a < b ? a : b)
+
+void virtio_req_complete(struct virtio_req *req, uint32_t len)
+{
+	int send_irq = 0;
+	struct _virtio_req *_req = container_of(req, struct _virtio_req, req);
+	struct virtio_queue *q = _req->q;
+	uint16_t avail_idx = _req->idx;
+	uint16_t used_idx = virtio_get_used_idx(_req->q);
+	int i;
+
+	/*
+	 * We've potentially used up multiple (non-chained) descriptors and have
+	 * to create one "used" entry for each descriptor we've consumed.
+	 */
+	for (i = 0; i < req->buf_count; i++) {
+		uint16_t used_len;
+
+		if (!q->max_merge_len)
+			used_len = len;
+		else
+			used_len = min_len(len,  req->buf[i].iov_len);
+
+		virtio_add_used(q, used_idx++, avail_idx++, used_len);
+
+		len -= used_len;
+		if (!len)
+			break;
+	}
+	virtio_sync_used_idx(q, used_idx);
+	q->last_avail_idx = avail_idx;
+
+	/*
+	 * Triggers the irq whenever there is no available buffer.
+	 */
+	if (q->last_avail_idx == le16toh(q->avail->idx))
+		send_irq = 1;
+
+	/*
+	 * There are two rings: q->avail and q->used for each of the rx and tx
+	 * queues that are used to pass buffers between kernel driver and the
+	 * virtio device implementation.
+	 *
+	 * Kernel maitains the first one and appends buffers to it. In rx queue,
+	 * it's empty buffers kernel offers to store received packets. In tx
+	 * queue, it's buffers containing packets to transmit. Kernel notifies
+	 * the device by mmio write (see VIRTIO_MMIO_QUEUE_NOTIFY below).
+	 *
+	 * The virtio device (here in this file) maintains the
+	 * q->used and appends buffer to it after consuming it from q->avail.
+	 *
+	 * The device needs to notify the driver by triggering irq here. The
+	 * LKL_VIRTIO_RING_F_EVENT_IDX is enabled in this implementation so
+	 * kernel can set virtio_get_used_event(q) to tell the device to "only
+	 * trigger the irq when this item in q->used ring is populated."
+	 *
+	 * Because driver and device are run in two different threads. When
+	 * driver sets virtio_get_used_event(q), q->used->idx may already be
+	 * increased to a larger one. So we need to trigger the irq when
+	 * virtio_get_used_event(q) < q->used->idx.
+	 *
+	 * To avoid unnessary irqs for each packet after
+	 * virtio_get_used_event(q) < q->used->idx, last_used_idx_signaled is
+	 * stored and irq is only triggered if
+	 * last_used_idx_signaled <= virtio_get_used_event(q) < q->used->idx
+	 *
+	 * This is what lkl_vring_need_event() checks and it evens covers the
+	 * case when those numbers wrap up.
+	 */
+	if (send_irq || lkl_vring_need_event(le16toh(virtio_get_used_event(q)),
+					     virtio_get_used_idx(q),
+					     q->last_used_idx_signaled)) {
+		q->last_used_idx_signaled = virtio_get_used_idx(q);
+		virtio_deliver_irq(_req->dev);
+	}
+}
+
+/*
+ * Grab the vring_desc from the queue at the appropriate index in the
+ * queue's circular buffer, converting from little-endian to
+ * the host's endianness.
+ */
+static inline
+struct lkl_vring_desc *vring_desc_at_le_idx(struct virtio_queue *q,
+					    __lkl__virtio16 le_idx)
+{
+	return &(q->desc[le16toh(le_idx) & (q->num - 1)]);
+}
+
+static inline
+struct lkl_vring_desc *vring_desc_at_avail_idx(struct virtio_queue *q,
+					       uint16_t idx)
+{
+	uint16_t desc_idx = q->avail->ring[idx & (q->num - 1)];
+
+	return vring_desc_at_le_idx(q, desc_idx);
+}
+
+/* Initialize buf to hold the same info as the vring_desc */
+static void add_dev_buf_from_vring_desc(struct virtio_req *req,
+					struct lkl_vring_desc *vring_desc)
+{
+	struct iovec *buf = &req->buf[req->buf_count++];
+
+	buf->iov_base = (void *)(uintptr_t)le64toh(vring_desc->addr);
+	buf->iov_len = le32toh(vring_desc->len);
+
+	if (!(buf->iov_base && buf->iov_len))
+		virtio_panic("bad vring_desc: %p %d\n",
+			     buf->iov_base, buf->iov_len);
+
+	req->total_len += buf->iov_len;
+}
+
+static struct lkl_vring_desc *get_next_desc(struct virtio_queue *q,
+					    struct lkl_vring_desc *desc,
+					    uint16_t *idx)
+{
+	uint16_t desc_idx;
+
+	if (q->max_merge_len) {
+		if (++(*idx) == le16toh(q->avail->idx))
+			return NULL;
+		desc_idx = q->avail->ring[*idx & (q->num - 1)];
+		return vring_desc_at_le_idx(q, desc_idx);
+	}
+
+	if (!(le16toh(desc->flags) & LKL_VRING_DESC_F_NEXT))
+		return NULL;
+	return vring_desc_at_le_idx(q, desc->next);
+}
+
+/*
+ * Below there are two distinctly different (per packet) buffer allocation
+ * schemes for us to deal with:
+ *
+ * 1. One or more descriptors chained through "next" as indicated by the
+ *    LKL_VRING_DESC_F_NEXT flag,
+ * 2. One or more descriptors from the ring sequentially, as many as are
+ *    available and needed. This is the RX only "mergeable_rx_bufs" mode.
+ *    The mode is entered when the VIRTIO_NET_F_MRG_RXBUF device feature
+ *    is enabled.
+ */
+static int virtio_process_one(struct virtio_dev *dev, int qidx)
+{
+	struct virtio_queue *q = &dev->queue[qidx];
+	uint16_t idx = q->last_avail_idx;
+	struct _virtio_req _req = {
+		.dev = dev,
+		.q = q,
+		.idx = idx,
+	};
+	struct virtio_req *req = &_req.req;
+	struct lkl_vring_desc *desc = vring_desc_at_avail_idx(q, _req.idx);
+
+	do {
+		add_dev_buf_from_vring_desc(req, desc);
+		if (q->max_merge_len && req->total_len > q->max_merge_len)
+			break;
+		desc = get_next_desc(q, desc, &idx);
+	} while (desc && req->buf_count < VIRTIO_REQ_MAX_BUFS);
+
+	if (desc && le16toh(desc->flags) & LKL_VRING_DESC_F_NEXT)
+		virtio_panic("too many chained bufs");
+
+	return dev->ops->enqueue(dev, qidx, req);
+}
+
+/* NB: we can enter this function two different ways in the case of
+ * netdevs --- either through a tx/rx thread poll (which the LKL
+ * scheduler knows nothing about) or through virtio_write called
+ * inside an interrupt handler, so to be safe, it's not enough to
+ * synchronize only the tx/rx polling threads.
+ *
+ * At the moment, it seems like only netdevs require the
+ * synchronization we do here (i.e. locking around operations on a
+ * particular virtqueue, with dev->ops->acquire_queue), since they
+ * have these two different entry points, one of which isn't managed
+ * by the LKL scheduler. So only devs corresponding to netdevs will
+ * have non-NULL acquire/release_queue.
+ *
+ * In the future, this may change. If you see errors thrown in virtio
+ * driver code by block/console devices, you should be suspicious of
+ * the synchronization going on here.
+ */
+void virtio_process_queue(struct virtio_dev *dev, uint32_t qidx)
+{
+	struct virtio_queue *q = &dev->queue[qidx];
+
+	if (!q->ready)
+		return;
+
+	if (dev->ops->acquire_queue)
+		dev->ops->acquire_queue(dev, qidx);
+
+	while (q->last_avail_idx != le16toh(q->avail->idx)) {
+		/*
+		 * Make sure following loads happens after loading
+		 * q->avail->idx.
+		 */
+		__sync_synchronize();
+		if (virtio_process_one(dev, qidx) < 0)
+			break;
+		if (q->last_avail_idx == le16toh(q->avail->idx))
+			virtio_set_avail_event(q, q->avail->idx);
+	}
+
+	if (dev->ops->release_queue)
+		dev->ops->release_queue(dev, qidx);
+}
+
+static inline uint32_t virtio_read_device_features(struct virtio_dev *dev)
+{
+	if (dev->device_features_sel)
+		return (uint32_t)(dev->device_features >> 32);
+
+	return (uint32_t)dev->device_features;
+}
+
+static inline void virtio_write_driver_features(struct virtio_dev *dev,
+						uint32_t val)
+{
+	uint64_t tmp;
+
+	if (dev->driver_features_sel) {
+		tmp = dev->driver_features & 0xFFFFFFFF;
+		dev->driver_features = tmp | (uint64_t)val << 32;
+	} else {
+		tmp = dev->driver_features & 0xFFFFFFFF00000000;
+		dev->driver_features = tmp | val;
+	}
+}
+
+static int virtio_read(void *data, int offset, void *res, int size)
+{
+	uint32_t val;
+	struct virtio_dev *dev = (struct virtio_dev *)data;
+
+	if (offset >= VIRTIO_MMIO_CONFIG) {
+		offset -= VIRTIO_MMIO_CONFIG;
+		if (offset + size > dev->config_len)
+			return -LKL_EINVAL;
+		memcpy(res, dev->config_data + offset, size);
+		return 0;
+	}
+
+	if (size != sizeof(uint32_t))
+		return -LKL_EINVAL;
+
+	switch (offset) {
+	case VIRTIO_MMIO_MAGIC_VALUE:
+		val = VIRTIO_DEV_MAGIC;
+		break;
+	case VIRTIO_MMIO_VERSION:
+		val = VIRTIO_DEV_VERSION;
+		break;
+	case VIRTIO_MMIO_DEVICE_ID:
+		val = dev->device_id;
+		break;
+	case VIRTIO_MMIO_VENDOR_ID:
+		val = dev->vendor_id;
+		break;
+	case VIRTIO_MMIO_DEVICE_FEATURES:
+		val = virtio_read_device_features(dev);
+		break;
+	case VIRTIO_MMIO_QUEUE_NUM_MAX:
+		val = dev->queue[dev->queue_sel].num_max;
+		break;
+	case VIRTIO_MMIO_QUEUE_READY:
+		val = dev->queue[dev->queue_sel].ready;
+		break;
+	case VIRTIO_MMIO_INTERRUPT_STATUS:
+		val = dev->int_status;
+		break;
+	case VIRTIO_MMIO_STATUS:
+		val = dev->status;
+		break;
+	case VIRTIO_MMIO_CONFIG_GENERATION:
+		val = dev->config_gen;
+		break;
+	default:
+		return -1;
+	}
+
+	*(uint32_t *)res = htole32(val);
+
+	return 0;
+}
+
+static inline void set_ptr_low(void **ptr, uint32_t val)
+{
+	uint64_t tmp = (uintptr_t)*ptr;
+
+	tmp = (tmp & 0xFFFFFFFF00000000) | val;
+	*ptr = (void *)(long)tmp;
+}
+
+static inline void set_ptr_high(void **ptr, uint32_t val)
+{
+	uint64_t tmp = (uintptr_t)*ptr;
+
+	tmp = (tmp & 0x00000000FFFFFFFF) | ((uint64_t)val << 32);
+	*ptr = (void *)(long)tmp;
+}
+
+static inline void set_status(struct virtio_dev *dev, uint32_t val)
+{
+	if ((val & LKL_VIRTIO_CONFIG_S_FEATURES_OK) &&
+	    (!(dev->driver_features & BIT(LKL_VIRTIO_F_VERSION_1)) ||
+	     !(dev->driver_features & BIT(LKL_VIRTIO_RING_F_EVENT_IDX)) ||
+	     dev->ops->check_features(dev)))
+		val &= ~LKL_VIRTIO_CONFIG_S_FEATURES_OK;
+	dev->status = val;
+}
+
+static int virtio_write(void *data, int offset, void *res, int size)
+{
+	struct virtio_dev *dev = (struct virtio_dev *)data;
+	struct virtio_queue *q = &dev->queue[dev->queue_sel];
+	uint32_t val;
+	int ret = 0;
+
+	if (offset >= VIRTIO_MMIO_CONFIG) {
+		offset -= VIRTIO_MMIO_CONFIG;
+
+		if (offset + size >= dev->config_len)
+			return -LKL_EINVAL;
+		memcpy(dev->config_data + offset, res, size);
+		return 0;
+	}
+
+	if (size != sizeof(uint32_t))
+		return -LKL_EINVAL;
+
+	val = le32toh(*(uint32_t *)res);
+
+	switch (offset) {
+	case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
+		if (val > 1)
+			return -LKL_EINVAL;
+		dev->device_features_sel = val;
+		break;
+	case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
+		if (val > 1)
+			return -LKL_EINVAL;
+		dev->driver_features_sel = val;
+		break;
+	case VIRTIO_MMIO_DRIVER_FEATURES:
+		virtio_write_driver_features(dev, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_SEL:
+		dev->queue_sel = val;
+		break;
+	case VIRTIO_MMIO_QUEUE_NUM:
+		dev->queue[dev->queue_sel].num = val;
+		break;
+	case VIRTIO_MMIO_QUEUE_READY:
+		dev->queue[dev->queue_sel].ready = val;
+		break;
+	case VIRTIO_MMIO_QUEUE_NOTIFY:
+		virtio_process_queue(dev, val);
+		break;
+	case VIRTIO_MMIO_INTERRUPT_ACK:
+		dev->int_status = 0;
+		break;
+	case VIRTIO_MMIO_STATUS:
+		set_status(dev, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_DESC_LOW:
+		set_ptr_low((void **)&q->desc, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_DESC_HIGH:
+		set_ptr_high((void **)&q->desc, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_AVAIL_LOW:
+		set_ptr_low((void **)&q->avail, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_AVAIL_HIGH:
+		set_ptr_high((void **)&q->avail, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_USED_LOW:
+		set_ptr_low((void **)&q->used, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_USED_HIGH:
+		set_ptr_high((void **)&q->used, val);
+		break;
+	default:
+		ret = -1;
+	}
+
+	return ret;
+}
+
+static const struct lkl_iomem_ops virtio_ops = {
+	.read = virtio_read,
+	.write = virtio_write,
+};
+
+char lkl_virtio_devs[4096];
+static char *devs = lkl_virtio_devs;
+static uint32_t lkl_num_virtio_boot_devs;
+
+void virtio_set_queue_max_merge_len(struct virtio_dev *dev, int q, int len)
+{
+	dev->queue[q].max_merge_len = len;
+}
+
+int virtio_dev_setup(struct virtio_dev *dev, int queues, int num_max)
+{
+	int qsize = queues * sizeof(*dev->queue);
+	int avail, mmio_size;
+	int i;
+	int num_bytes;
+	int ret;
+
+	dev->irq = lkl_get_free_irq("virtio");
+	if (dev->irq < 0)
+		return dev->irq;
+
+	dev->int_status = 0;
+	dev->device_features |= BIT(LKL_VIRTIO_F_VERSION_1) |
+		BIT(LKL_VIRTIO_RING_F_EVENT_IDX);
+	dev->queue = lkl_host_ops.mem_alloc(qsize);
+	if (!dev->queue)
+		return -LKL_ENOMEM;
+
+	memset(dev->queue, 0, qsize);
+	for (i = 0; i < queues; i++)
+		dev->queue[i].num_max = num_max;
+
+	mmio_size = VIRTIO_MMIO_CONFIG + dev->config_len;
+	dev->base = register_iomem(dev, mmio_size, &virtio_ops);
+	if (!dev->base) {
+		lkl_host_ops.mem_free(dev->queue);
+		return -LKL_ENOMEM;
+	}
+
+	if (!lkl_is_running()) {
+		avail = sizeof(lkl_virtio_devs) - (devs - lkl_virtio_devs);
+		num_bytes = snprintf(devs, avail,
+				     " virtio_mmio.device=%d@0x%"PRIxPTR":%d",
+				     mmio_size, (uintptr_t) dev->base,
+				     dev->irq);
+		if (num_bytes < 0 || num_bytes >= avail) {
+			lkl_put_irq(dev->irq, "virtio");
+			unregister_iomem(dev->base);
+			lkl_host_ops.mem_free(dev->queue);
+			return -LKL_ENOMEM;
+		}
+		devs += num_bytes;
+		dev->virtio_mmio_id = lkl_num_virtio_boot_devs++;
+	} else {
+		ret =
+		    lkl_sys_virtio_mmio_device_add((long)dev->base, mmio_size,
+						   dev->irq);
+		if (ret < 0) {
+			lkl_printf("can't register mmio device\n");
+			return -1;
+		}
+		dev->virtio_mmio_id = lkl_num_virtio_boot_devs + ret;
+	}
+
+	return 0;
+}
+
+int virtio_dev_cleanup(struct virtio_dev *dev)
+{
+	char devname[100];
+	long fd, ret;
+	long mount_ret;
+
+	if (!lkl_is_running())
+		goto skip_unbind;
+
+	mount_ret = lkl_mount_fs("sysfs");
+	if (mount_ret < 0)
+		return mount_ret;
+
+	if (dev->virtio_mmio_id >= virtio_get_num_bootdevs())
+		ret = snprintf(devname, sizeof(devname), "virtio-mmio.%d.auto",
+			       dev->virtio_mmio_id - virtio_get_num_bootdevs());
+	else
+		ret = snprintf(devname, sizeof(devname), "virtio-mmio.%d",
+			       dev->virtio_mmio_id);
+	if (ret < 0 || (size_t) ret >= sizeof(devname))
+		return -LKL_ENOMEM;
+
+	fd = lkl_sys_open("/sysfs/bus/platform/drivers/virtio-mmio/unbind",
+			  LKL_O_WRONLY, 0);
+	if (fd < 0)
+		return fd;
+
+	ret = lkl_sys_write(fd, devname, strlen(devname));
+	if (ret < 0)
+		return ret;
+
+	ret = lkl_sys_close(fd);
+	if (ret < 0)
+		return ret;
+
+	if (mount_ret == 0) {
+		ret = lkl_sys_umount("/sysfs", 0);
+		if (ret < 0)
+			return ret;
+	}
+
+skip_unbind:
+	lkl_put_irq(dev->irq, "virtio");
+	unregister_iomem(dev->base);
+	lkl_host_ops.mem_free(dev->queue);
+	return 0;
+}
+
+uint32_t virtio_get_num_bootdevs(void)
+{
+	return lkl_num_virtio_boot_devs;
+}
diff --git a/tools/lkl/lib/virtio.h b/tools/lkl/lib/virtio.h
new file mode 100644
index 000000000000..7427aa8fad79
--- /dev/null
+++ b/tools/lkl/lib/virtio.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_LIB_VIRTIO_H
+#define _LKL_LIB_VIRTIO_H
+
+#include <stdint.h>
+#include <lkl_host.h>
+
+#define PAGE_SIZE		4096
+
+/* The following are copied from skbuff.h */
+#if (65536/PAGE_SIZE + 1) < 16
+#define MAX_SKB_FRAGS 16UL
+#else
+#define MAX_SKB_FRAGS (65536/PAGE_SIZE + 1)
+#endif
+
+#define VIRTIO_REQ_MAX_BUFS	(MAX_SKB_FRAGS + 2)
+
+struct virtio_req {
+	uint16_t buf_count;
+	struct iovec buf[VIRTIO_REQ_MAX_BUFS];
+	uint32_t total_len;
+};
+
+struct virtio_dev;
+
+struct virtio_dev_ops {
+	int (*check_features)(struct virtio_dev *dev);
+	/**
+	 * enqueue - queues the request for processing
+	 *
+	 * Note that the curret implementation assumes that the requests are
+	 * processed synchronous and, as such, @virtio_req_complete must be
+	 * called by from this function.
+	 *
+	 * @dev - virtio device
+	 * @q	- queue index
+	 *
+	 * @returns a negative value if the request has not been queued for
+	 * processing in which case the virtio device is resposible for
+	 * restaring the queue processing by calling @virtio_process_queue at a
+	 * later time; 0 or a positive value means that the request has been
+	 * queued for processing
+	 */
+	int (*enqueue)(struct virtio_dev *dev, int q, struct virtio_req *req);
+	/*
+	 * Acquire/release a lock on the specified queue. Only implemented by
+	 * netdevs, all other devices have NULL acquire/release function
+	 * pointers.
+	 */
+	void (*acquire_queue)(struct virtio_dev *dev, int queue_idx);
+	void (*release_queue)(struct virtio_dev *dev, int queue_idx);
+};
+
+struct virtio_dev {
+	uint32_t device_id;
+	uint32_t vendor_id;
+	uint64_t device_features;
+	uint32_t device_features_sel;
+	uint64_t driver_features;
+	uint32_t driver_features_sel;
+	uint32_t queue_sel;
+	struct virtio_queue *queue;
+	uint32_t queue_notify;
+	uint32_t int_status;
+	uint32_t status;
+	uint32_t config_gen;
+
+	struct virtio_dev_ops *ops;
+	int irq;
+	void *config_data;
+	int config_len;
+	void *base;
+	uint32_t virtio_mmio_id;
+};
+
+int virtio_dev_setup(struct virtio_dev *dev, int queues, int num_max);
+int virtio_dev_cleanup(struct virtio_dev *dev);
+uint32_t virtio_get_num_bootdevs(void);
+/**
+ * virtio_req_complete - complete a virtio request
+ *
+ * @req - the request to be completed
+ * @len - the total size in bytes of the completed request
+ */
+void virtio_req_complete(struct virtio_req *req, uint32_t len);
+void virtio_process_queue(struct virtio_dev *dev, uint32_t qidx);
+void virtio_set_queue_max_merge_len(struct virtio_dev *dev, int q, int len);
+
+#define container_of(ptr, type, member) \
+	(type *)((char *)(ptr) - __builtin_offsetof(type, member))
+
+#endif /* _LKL_LIB_VIRTIO_H */
-- 
2.20.1 (Apple Git-117)

