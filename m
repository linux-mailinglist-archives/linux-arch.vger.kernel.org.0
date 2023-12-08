Return-Path: <linux-arch+bounces-765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC7F8097EA
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 01:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8531F213A7
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 00:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFA81FC2;
	Fri,  8 Dec 2023 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkcfCe2C"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CDE172B
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 16:53:04 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db401df7735so2058507276.3
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 16:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996783; x=1702601583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhWZE+QRUt+Z8lRUloVgvBF4+Y7IPBx9Q6LUmHNzq1c=;
        b=rkcfCe2CbupevsyPtC8BxPibduKqF2oeMzVt2UEQVdP/TefH3ZDW9KbjAvoYgtpFUK
         tDm4J2vHNiRK2BwBUgNhW3uh+sZ8mG+VUdVxGON87ERVbiD39qwODXJCj+/v2yscUmo5
         qYdph509uT4HkUoLQh/lp7e0iCBqASHsy9wLVZBRIQsSvqnN++gEhVNqfp9P+CusVvPc
         2BogCbkV+yFTMbTr7Fxrro3WS7/J9HD2dqK9BUOgeBlrondIMi7NAwPbHZ66rRq9djGj
         v6N5IBewPpAHC5/TwOz5aJPkweA1XuUU9ynjnXlcOddJeydoQASnYakLJmlxNGnyiJNb
         sZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996783; x=1702601583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhWZE+QRUt+Z8lRUloVgvBF4+Y7IPBx9Q6LUmHNzq1c=;
        b=huOeBPzmzi/P1K6ezgz7kGCo+JbbQtJHQIA1vy77Qyf57bzu6tnv5WfdvzDPLv+P8D
         AKuIJXlmuG6tCjkkcFAEY429ntM9WTBxZTuB5mc83ocbWikvpZfvwrl0XqkdhmTZuy++
         I/ZYvMbnQsVBQCLaPZYjlKrhGni2ORFoymIdF2UjCdFmw59kkNYUOgwcp7ccw0JWgsEr
         iD5y+DpwuYWSiD2tTrtF5x73lrAkGxgIPukgfJFk3zFOAyy3cLdgLZMSR+zmmE1pfE2b
         DGKR9lU2UdnQuGN7M2mCJzGJw/grzZcByF8o1IObDUUmkfnRihbCxY8LBJtGkV3JD9rh
         OrRA==
X-Gm-Message-State: AOJu0YwOTPEpsDFR+A+QM1Dvw0cMHGUgDkbroDPXDQNc1M4I+vd45Js+
	uYNzqoVAxZLb2WPWqWoQF5RLq06PEoQYS3L7vA==
X-Google-Smtp-Source: AGHT+IG/WlXn6UdTPbrF5U9FqP+ytikx+tXh9w8Zw5tJST0X4ys363R1oqfwyasI9bV95ky8FRJNiqWU1wpMiUkNaQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a25:e097:0:b0:db3:fa34:50b0 with SMTP
 id x145-20020a25e097000000b00db3fa3450b0mr38904ybg.4.1701996783271; Thu, 07
 Dec 2023 16:53:03 -0800 (PST)
Date: Thu,  7 Dec 2023 16:52:35 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-5-almasrymina@google.com>
Subject: [net-next v1 04/16] gve: implement queue api
From: Mina Almasry <almasrymina@google.com>
To: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

Define a struct that contains all of the memory needed for an RX
queue to function.

Implement the queue-api in GVE using this struct.

Currently the only memory is allocated at the time of queue start are
the RX pages in gve_rx_post_buffers_dqo(). That can be moved up to
queue_mem_alloc() time in the future.

For simplicity the queue API is only supported by the diorite queue
out-of-order (DQO) format without queue-page-lists (QPL). Support for
other GVE formats can be added in the future as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 drivers/net/ethernet/google/gve/gve_adminq.c |   6 +-
 drivers/net/ethernet/google/gve/gve_adminq.h |   3 +
 drivers/net/ethernet/google/gve/gve_dqo.h    |   2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 286 +++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |   5 +-
 5 files changed, 296 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 12fbd723ecc6..e515b7278295 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -348,7 +348,7 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
 /* Flushes all AQ commands currently queued and waits for them to complete.
  * If there are failures, it will return the first error.
  */
-static int gve_adminq_kick_and_wait(struct gve_priv *priv)
+int gve_adminq_kick_and_wait(struct gve_priv *priv)
 {
 	int tail, head;
 	int i;
@@ -591,7 +591,7 @@ int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_que
 	return gve_adminq_kick_and_wait(priv);
 }
 
-static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
+int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 {
 	struct gve_rx_ring *rx = &priv->rx[queue_index];
 	union gve_adminq_command cmd;
@@ -691,7 +691,7 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_qu
 	return gve_adminq_kick_and_wait(priv);
 }
 
-static int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queue_index)
+int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queue_index)
 {
 	union gve_adminq_command cmd;
 	int err;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 5865ccdccbd0..265beed965dc 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -411,6 +411,7 @@ union gve_adminq_command {
 
 static_assert(sizeof(union gve_adminq_command) == 64);
 
+int gve_adminq_kick_and_wait(struct gve_priv *priv);
 int gve_adminq_alloc(struct device *dev, struct gve_priv *priv);
 void gve_adminq_free(struct device *dev, struct gve_priv *priv);
 void gve_adminq_release(struct gve_priv *priv);
@@ -424,7 +425,9 @@ int gve_adminq_deconfigure_device_resources(struct gve_priv *priv);
 int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
 int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
 int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues);
+int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index);
 int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 queue_id);
+int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queue_id);
 int gve_adminq_register_page_list(struct gve_priv *priv,
 				  struct gve_queue_page_list *qpl);
 int gve_adminq_unregister_page_list(struct gve_priv *priv, u32 page_list_id);
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index c36b93f0de15..3eed26a0ed7d 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -46,6 +46,8 @@ int gve_clean_tx_done_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 			  struct napi_struct *napi);
 void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx);
 void gve_rx_write_doorbell_dqo(const struct gve_priv *priv, int queue_idx);
+void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
+		       bool free_page);
 
 static inline void
 gve_tx_put_doorbell_dqo(const struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 619bf63ec935..5b23d811afd3 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -22,6 +22,7 @@
 #include "gve_dqo.h"
 #include "gve_adminq.h"
 #include "gve_register.h"
+#include "gve_utils.h"
 
 #define GVE_DEFAULT_RX_COPYBREAK	(256)
 
@@ -1702,6 +1703,287 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+struct gve_per_rx_queue_mem_dqo {
+	struct gve_rx_buf_state_dqo *buf_states;
+	u32 num_buf_states;
+
+	struct gve_rx_compl_desc_dqo *complq_desc_ring;
+	dma_addr_t complq_bus;
+
+	struct gve_rx_desc_dqo *bufq_desc_ring;
+	dma_addr_t bufq_bus;
+
+	struct gve_queue_resources *q_resources;
+	dma_addr_t q_resources_bus;
+
+	size_t completion_queue_slots;
+	size_t buffer_queue_slots;
+};
+
+static int gve_rx_queue_stop(struct net_device *dev, int idx,
+			     void **out_per_q_mem)
+{
+	struct gve_per_rx_queue_mem_dqo *per_q_mem;
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_notify_block *block;
+	struct gve_rx_ring *rx;
+	int ntfy_idx;
+	int err;
+
+	rx = &priv->rx[idx];
+	ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
+	block = &priv->ntfy_blocks[ntfy_idx];
+
+	if (priv->queue_format != GVE_DQO_RDA_FORMAT)
+		return -EOPNOTSUPP;
+
+	if (!out_per_q_mem)
+		return -EINVAL;
+
+	/* Stopping queue 0 while other queues are running is unfortunately
+	 * fails silently for GVE at the moment. Disable the queue-api for
+	 * queue 0 until this is resolved.
+	 */
+	if (idx == 0)
+		return -ERANGE;
+
+	per_q_mem = kvcalloc(1, sizeof(*per_q_mem), GFP_KERNEL);
+	if (!per_q_mem)
+		return -ENOMEM;
+
+	napi_disable(&block->napi);
+	err = gve_adminq_destroy_rx_queue(priv, idx);
+	if (err)
+		goto err_napi_enable;
+
+	err = gve_adminq_kick_and_wait(priv);
+	if (err)
+		goto err_create_rx_queue;
+
+	gve_remove_napi(priv, ntfy_idx);
+
+	per_q_mem->buf_states = rx->dqo.buf_states;
+	per_q_mem->num_buf_states = rx->dqo.num_buf_states;
+
+	per_q_mem->complq_desc_ring = rx->dqo.complq.desc_ring;
+	per_q_mem->complq_bus = rx->dqo.complq.bus;
+
+	per_q_mem->bufq_desc_ring = rx->dqo.bufq.desc_ring;
+	per_q_mem->bufq_bus = rx->dqo.bufq.bus;
+
+	per_q_mem->q_resources = rx->q_resources;
+	per_q_mem->q_resources_bus = rx->q_resources_bus;
+
+	per_q_mem->buffer_queue_slots = rx->dqo.bufq.mask + 1;
+	per_q_mem->completion_queue_slots = rx->dqo.complq.mask + 1;
+
+	*out_per_q_mem = per_q_mem;
+
+	return 0;
+
+err_create_rx_queue:
+	/* There is nothing we can do here if these fail. */
+	gve_adminq_create_rx_queue(priv, idx);
+	gve_adminq_kick_and_wait(priv);
+
+err_napi_enable:
+	napi_enable(&block->napi);
+	kvfree(per_q_mem);
+
+	return err;
+}
+
+static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_mem)
+{
+	struct gve_per_rx_queue_mem_dqo *gve_q_mem;
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_rx_buf_state_dqo *bs;
+	struct device *hdev;
+	size_t size;
+	int i;
+
+	priv = netdev_priv(dev);
+	gve_q_mem = (struct gve_per_rx_queue_mem_dqo *)per_q_mem;
+	hdev = &priv->pdev->dev;
+
+	if (!gve_q_mem)
+		return;
+
+	if (priv->queue_format != GVE_DQO_RDA_FORMAT)
+		return;
+
+	for (i = 0; i < gve_q_mem->num_buf_states; i++) {
+		bs = &gve_q_mem->buf_states[i];
+		if (bs->page_info.page)
+			gve_free_page_dqo(priv, bs, true);
+	}
+
+	if (gve_q_mem->q_resources)
+		dma_free_coherent(hdev, sizeof(*gve_q_mem->q_resources),
+				  gve_q_mem->q_resources,
+				  gve_q_mem->q_resources_bus);
+
+	if (gve_q_mem->bufq_desc_ring) {
+		size = sizeof(gve_q_mem->bufq_desc_ring[0]) *
+		       gve_q_mem->buffer_queue_slots;
+		dma_free_coherent(hdev, size, gve_q_mem->bufq_desc_ring,
+				  gve_q_mem->bufq_bus);
+	}
+
+	if (gve_q_mem->complq_desc_ring) {
+		size = sizeof(gve_q_mem->complq_desc_ring[0]) *
+		       gve_q_mem->completion_queue_slots;
+		dma_free_coherent(hdev, size, gve_q_mem->complq_desc_ring,
+				  gve_q_mem->complq_bus);
+	}
+
+	kvfree(gve_q_mem->buf_states);
+
+	kvfree(per_q_mem);
+}
+
+static void *gve_rx_queue_mem_alloc(struct net_device *dev, int idx)
+{
+	struct gve_per_rx_queue_mem_dqo *gve_q_mem;
+	struct gve_priv *priv = netdev_priv(dev);
+	struct device *hdev = &priv->pdev->dev;
+	size_t size;
+
+	if (priv->queue_format != GVE_DQO_RDA_FORMAT)
+		return NULL;
+
+	/* See comment in gve_rx_queue_stop() */
+	if (idx == 0)
+		return NULL;
+
+	gve_q_mem = kvcalloc(1, sizeof(*gve_q_mem), GFP_KERNEL);
+	if (!gve_q_mem)
+		goto err;
+
+	gve_q_mem->buffer_queue_slots =
+		priv->options_dqo_rda.rx_buff_ring_entries;
+	gve_q_mem->completion_queue_slots = priv->rx_desc_cnt;
+
+	gve_q_mem->num_buf_states =
+		min_t(s16, S16_MAX, gve_q_mem->buffer_queue_slots * 4);
+
+	gve_q_mem->buf_states = kvcalloc(gve_q_mem->num_buf_states,
+					 sizeof(gve_q_mem->buf_states[0]),
+					 GFP_KERNEL);
+	if (!gve_q_mem->buf_states)
+		goto err;
+
+	size = sizeof(struct gve_rx_compl_desc_dqo) *
+		gve_q_mem->completion_queue_slots;
+	gve_q_mem->complq_desc_ring = dma_alloc_coherent(hdev, size,
+							 &gve_q_mem->complq_bus,
+							 GFP_KERNEL);
+	if (!gve_q_mem->complq_desc_ring)
+		goto err;
+
+	size = sizeof(struct gve_rx_desc_dqo) * gve_q_mem->buffer_queue_slots;
+	gve_q_mem->bufq_desc_ring = dma_alloc_coherent(hdev, size,
+						       &gve_q_mem->bufq_bus,
+						       GFP_KERNEL);
+	if (!gve_q_mem->bufq_desc_ring)
+		goto err;
+
+	gve_q_mem->q_resources = dma_alloc_coherent(hdev,
+						    sizeof(*gve_q_mem->q_resources),
+						    &gve_q_mem->q_resources_bus,
+						    GFP_KERNEL);
+	if (!gve_q_mem->q_resources)
+		goto err;
+
+	return gve_q_mem;
+
+err:
+	gve_rx_queue_mem_free(dev, gve_q_mem);
+	return NULL;
+}
+
+static int gve_rx_queue_start(struct net_device *dev, int idx, void *per_q_mem)
+{
+	struct gve_per_rx_queue_mem_dqo *gve_q_mem;
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_rx_ring *rx = &priv->rx[idx];
+	struct gve_notify_block *block;
+	int ntfy_idx;
+	int err;
+	int i;
+
+	if (priv->queue_format != GVE_DQO_RDA_FORMAT)
+		return -EOPNOTSUPP;
+
+	/* See comment in gve_rx_queue_stop() */
+	if (idx == 0)
+		return -ERANGE;
+
+	gve_q_mem = (struct gve_per_rx_queue_mem_dqo *)per_q_mem;
+	ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
+	block = &priv->ntfy_blocks[ntfy_idx];
+
+	netif_dbg(priv, drv, priv->dev, "starting rx ring DQO\n");
+
+	memset(rx, 0, sizeof(*rx));
+	rx->gve = priv;
+	rx->q_num = idx;
+	rx->dqo.bufq.mask = gve_q_mem->buffer_queue_slots - 1;
+	rx->dqo.complq.num_free_slots = gve_q_mem->completion_queue_slots;
+	rx->dqo.complq.mask = gve_q_mem->completion_queue_slots - 1;
+	rx->ctx.skb_head = NULL;
+	rx->ctx.skb_tail = NULL;
+
+	rx->dqo.num_buf_states = gve_q_mem->num_buf_states;
+
+	rx->dqo.buf_states = gve_q_mem->buf_states;
+
+	/* Set up linked list of buffer IDs */
+	for (i = 0; i < rx->dqo.num_buf_states - 1; i++)
+		rx->dqo.buf_states[i].next = i + 1;
+
+	rx->dqo.buf_states[rx->dqo.num_buf_states - 1].next = -1;
+	rx->dqo.recycled_buf_states.head = -1;
+	rx->dqo.recycled_buf_states.tail = -1;
+	rx->dqo.used_buf_states.head = -1;
+	rx->dqo.used_buf_states.tail = -1;
+
+	rx->dqo.complq.desc_ring = gve_q_mem->complq_desc_ring;
+	rx->dqo.complq.bus = gve_q_mem->complq_bus;
+
+	rx->dqo.bufq.desc_ring = gve_q_mem->bufq_desc_ring;
+	rx->dqo.bufq.bus = gve_q_mem->bufq_bus;
+
+	rx->q_resources = gve_q_mem->q_resources;
+	rx->q_resources_bus = gve_q_mem->q_resources_bus;
+
+	gve_rx_add_to_block(priv, idx);
+
+	err = gve_adminq_create_rx_queue(priv, idx);
+	if (err)
+		return err;
+
+	err = gve_adminq_kick_and_wait(priv);
+	if (err)
+		goto err_destroy_rx_queue;
+
+	/* TODO, pull the memory allocations in this to gve_rx_queue_mem_alloc()
+	 */
+	gve_rx_post_buffers_dqo(&priv->rx[idx]);
+
+	napi_enable(&block->napi);
+	gve_set_itr_coalesce_usecs_dqo(priv, block, priv->rx_coalesce_usecs);
+
+	return 0;
+
+err_destroy_rx_queue:
+	/* There is nothing we can do if these fail. */
+	gve_adminq_destroy_rx_queue(priv, idx);
+	gve_adminq_kick_and_wait(priv);
+
+	return err;
+}
+
 int gve_adjust_queues(struct gve_priv *priv,
 		      struct gve_queue_config new_rx_config,
 		      struct gve_queue_config new_tx_config)
@@ -1900,6 +2182,10 @@ static const struct net_device_ops gve_netdev_ops = {
 	.ndo_bpf		=	gve_xdp,
 	.ndo_xdp_xmit		=	gve_xdp_xmit,
 	.ndo_xsk_wakeup		=	gve_xsk_wakeup,
+	.ndo_queue_mem_alloc	=	gve_rx_queue_mem_alloc,
+	.ndo_queue_mem_free	=	gve_rx_queue_mem_free,
+	.ndo_queue_start	=	gve_rx_queue_start,
+	.ndo_queue_stop		=	gve_rx_queue_stop,
 };
 
 static void gve_handle_status(struct gve_priv *priv, u32 status)
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index f281e42a7ef9..e729f04d3f60 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -21,9 +21,8 @@ static int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
 	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
 }
 
-static void gve_free_page_dqo(struct gve_priv *priv,
-			      struct gve_rx_buf_state_dqo *bs,
-			      bool free_page)
+void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
+		       bool free_page)
 {
 	page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
 	if (free_page)
-- 
2.43.0.472.g3155946c3a-goog


