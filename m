Return-Path: <linux-arch+bounces-14973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4D4C7201B
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 04:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0F7EB2E078
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 03:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE12F2FF67E;
	Thu, 20 Nov 2025 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNp71wbV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75FD2F5A10
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609835; cv=none; b=oXQIYNlvvRhF+tOQ9emuGUNKdlMOwkV7uGs46DgIqV5mgO/F1tn29QDvOKmiQLk9WQzA6PBKRkZ/p4+emWCCS9IMM5IdOujopSiPdo3ax833T7OgYQDPnGUOCbo5mNLhL4MvmWjqFseMTX4yC+4e60fayl5L9eZXr9GefaAJ4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609835; c=relaxed/simple;
	bh=wuDktkvkmPPQMkrr7ULLpZaYVUd01D6PWmVFjXlkyqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5IH3e6ZFkf5MwBPMmpxstL+r2+9K2K2VkOcIL/bJ3MKy+ulcJdO3K0NGOvm8Pcxy0z1VIiyX6qpM8CftiMPICOWi9dVFNLysUeuIdbJh0eQ/XNWm/4X+bW4HEoDAQCiHbdtA3lKh43zWKQmWL/uUITYcmSRS2ystyiofJNBBEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNp71wbV; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640daf41b19so554415d50.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 19:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763609832; x=1764214632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZTyU8CT4iARbspCBMuLPPZbuWjZ7S1vt4fEqVtqV7I=;
        b=GNp71wbVJAfsI+xGI91OOvFT+BMpzV50+PagzJ7PVfotIJwvNsTlI+ir7yesWSWeJI
         SdTqXFDTSrud/6naeEBiQxx2uZDg68awdbq0YVNrInrOioeIyTrxcnFNIMikB/3kCyO8
         Y5cxwP2tG9YBAdlnCu8lm4M1LRGa+K9eiLbPJmu+MLcVLmsHbYMh3KbpuIiPaiyBuuGK
         BRCv2VlN5kipm5P7lb4cEIRr0tlh85FVLTzVlC80vlEAZ8EtXqg7hkS7n34+V+rxlaMw
         m+VOzp/7xYHt90eJA/+DnyKTby1fnyEjCVrccPgch3w0XyZq+p4sC3Xu7ywN3a2qzGsE
         voBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609832; x=1764214632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nZTyU8CT4iARbspCBMuLPPZbuWjZ7S1vt4fEqVtqV7I=;
        b=sH08k7EfVPRRT0ylQHG9+7ooTU8ql9eLq7T6PZFkQIW4dC0FMsfm4osa3XkV++22VD
         avdjC1+OpL+j2IIxQFXvziDHAdjokofJXSHC6jw9Fza9bmtn7qD27/beAuZo+B8DkIo8
         I+opPcRqmF2NIxbWtybix/n5UGfFEwnmyWwPzQQywR5siHXuM8IUykVQu6bcNu2aqu5r
         7tan4h3PMydsrZ96Ttx/sFNnoBa1KZsGFTaO3rSQ74mvkJ9+OYicUlhl/wQzixiCCEGn
         5oA1Lx0iLn8guqgyg9tQGG1r5b0EfFcW7fhWSRmdupHjtoiam8DonUR0J0zZg1PErzlV
         Ztdg==
X-Forwarded-Encrypted: i=1; AJvYcCULDRBeKK8VoOHd99WKl8w3y+AyNej/T3/gzfRTVga5+sUwt9g6OwMG6u2gMQuemefdfU9BgtSMq0RT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16tIBb7NZOo4LSoELIhDhQ0orGBevUOGXm/HuqHS9CRxLkSDn
	KZr0/V6XDuHWF+nwNPcCPNX/PTmL9l4h784fxeB6IcRfN2o5+woy7ysF
X-Gm-Gg: ASbGncu9KiK0GIKMRx3cokohw5Jvlcm/1JBdnCOwanmyNwEtXbUyx9/RSJh6qL0BFre
	mGyQNY8nobG8enCTuv8FB98oCxqFgnqaGmMJW3gmbFDGcUy9PQMSd7IAWn+qd3EepTG982ipFP3
	zf+99NYdvRA2MAa99kvB8FrcX92vvZGWTT3SzVT2QOBFQdgYC8ZumozcTRlcip2CS3w9DTPqYk2
	0b7/RT4YWJ8lSnLo3pXEPQ1V/Er1SN9KsWWv9uVwiY9EvAm9bN66KTO89WifP8ySlUhn27Um1Y9
	HrDmjpWj0DwcdtNLiBDYXJ+MYlwNcEgbk7A4vCAejqCJXKXzz+wPdADsGJqYo3ZnLtCgD+0HeUk
	LfX7chQbnYsuGATgW6zrsoaSE2nAPkValk/i9hTpdUQoA44rb1R/QVI5z1R/VkU/h/mUegub3b7
	6bsnyZJZU/iX9ixdPlqXse
X-Google-Smtp-Source: AGHT+IF6XnzoA3Fp2yvsn96tIgCF3KkDZHwgr96TFqQEESgZBGU4z3LvWvX/N+AZH+r8JfoIVeqOHw==
X-Received: by 2002:a05:690e:168a:b0:63f:b605:b7f2 with SMTP id 956f58d0204a3-642f8df31e4mr616438d50.10.1763609831701;
        Wed, 19 Nov 2025 19:37:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-642f71ae739sm452236d50.25.2025.11.19.19.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:37:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 19 Nov 2025 19:37:08 -0800
Subject: [PATCH net-next v7 1/5] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-1-1abc8467354c@meta.com>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rename the 'tx_vec' field in struct net_devmem_dmabuf_binding to 'vec'.
This field holds pointers to net_iov structures. The rename prepares for
reusing 'vec' for both TX and RX directions.

No functional change intended.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/devmem.c | 22 +++++++++++-----------
 net/core/devmem.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 1d04754bc756..4dee2666dd07 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -75,7 +75,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
-	kvfree(binding->tx_vec);
+	kvfree(binding->vec);
 	kfree(binding);
 }
 
@@ -232,10 +232,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	if (direction == DMA_TO_DEVICE) {
-		binding->tx_vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
-						 sizeof(struct net_iov *),
-						 GFP_KERNEL);
-		if (!binding->tx_vec) {
+		binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+					      sizeof(struct net_iov *),
+					      GFP_KERNEL);
+		if (!binding->vec) {
 			err = -ENOMEM;
 			goto err_unmap;
 		}
@@ -249,7 +249,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
-		goto err_tx_vec;
+		goto err_vec;
 	}
 
 	virtual = 0;
@@ -295,7 +295,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -315,8 +315,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
 	gen_pool_destroy(binding->chunk_pool);
-err_tx_vec:
-	kvfree(binding->tx_vec);
+err_vec:
+	kvfree(binding->vec);
 err_unmap:
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
 					  direction);
@@ -363,7 +363,7 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
-	if (!binding || !binding->tx_vec) {
+	if (!binding || !binding->vec) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -414,7 +414,7 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
 	*off = virt_addr % PAGE_SIZE;
 	*size = PAGE_SIZE - *off;
 
-	return binding->tx_vec[virt_addr / PAGE_SIZE];
+	return binding->vec[virt_addr / PAGE_SIZE];
 }
 
 /*** "Dmabuf devmem memory provider" ***/
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 0b43a648cd2e..1ea6228e4f40 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -63,7 +63,7 @@ struct net_devmem_dmabuf_binding {
 	 * address. This array is convenient to map the virtual addresses to
 	 * net_iovs in the TX path.
 	 */
-	struct net_iov **tx_vec;
+	struct net_iov **vec;
 
 	struct work_struct unbind_w;
 };

-- 
2.47.3


