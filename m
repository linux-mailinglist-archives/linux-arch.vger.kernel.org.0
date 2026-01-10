Return-Path: <linux-arch+bounces-15734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CDD0CD07
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 211F2303CF74
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397D24E4AF;
	Sat, 10 Jan 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP3KPlyY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D01FE47B
	for <linux-arch@vger.kernel.org>; Sat, 10 Jan 2026 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011544; cv=none; b=SGS3oVN7ifYvAEa3RKm6LIdo6Q6lewVcnmw1isbfzJgvF6YbMoiIQoUXz+HZ1ybpO1nIzUy4D6JuGpDG8ZFhQsrlbVwf8Z7AcO0KpAn+ZjPdTKnB1/pIDZ5bOyQW42KU6wJ4RKGYRLzMpSflHP1MEqtUOyDYFmPZTzAbQ+L+lVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011544; c=relaxed/simple;
	bh=xiO09bVBGC8/K7L0bw2p16Wp9QD28tXsWfMmjzD/Ua4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OU9oysDECfxgPhKAH2pp1znPmdShIaPuZAlyzKbddnbEwPvkeeEyBWU6DzPONYK3W+Q6BKwgbL5Lx1Nb+6LbVFHPaI5kWdaR6M8KHlzcYxd4/GBVIM58aJVdkO8lLfUgF9uvy4BhBx+q8qAiUMr1M2RA08OlcAOE8KCCI/Pry2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP3KPlyY; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78fb5764382so53189637b3.0
        for <linux-arch@vger.kernel.org>; Fri, 09 Jan 2026 18:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768011541; x=1768616341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07Oq7s3cDlA8pW6W82CkM0efPRUiBJHxCtezHHHyhNs=;
        b=aP3KPlyY6zoY7wXyxuDu2CZQUwNdvvHc35TJGW5jxMrfnSDqkZXyLPcBG/23GZsOku
         +SzTOovsD4ZTn547tqu2cDRpKnMKEbIDBs9G+q1kBW30Ou0bCwPCBKToUtTe9K3DDMMC
         Ohuzeq6Bh6zK3AFt4y965A0yZlfbmg7XvB/lzx30Qv2e8kOJRUB/6V2PmCPEWYisTc9a
         ZIaCQRPoXgxxFE1wzWPANO6w1Yctt4oVjzagCSmI5wSSHgVhs/uT+h2mXpScaiKeOspL
         lIbXHhSREReuTlNknT2UKD+aui96R3GSDLqTRd51j+I4REL5tMJhMYS7npzTAvWIZJtj
         aSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768011541; x=1768616341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=07Oq7s3cDlA8pW6W82CkM0efPRUiBJHxCtezHHHyhNs=;
        b=pT4nZyEGFe1T5skd59/NLS+TG5pQ0KFxqQMnkaN7K7Foh6vd7ejj30LsRhLl4tggAJ
         TlMfHGQPXKCSnC9Ot/tHjedIHSD8rnvIATewzLRYErutD1LSLWmDtaRrS3pu2UUDCMWC
         29kU7eIkzcexX9d6fgHfWHHv4LN5RaWd114ftUTGSbZT/ORexAJbS+25Rt+rX/mY6u/M
         lvwxE96s4ycgCnc7tX5n4AMy40EdNFKUQrFwQfiUVWdzVx7ZiytIU9rYCaslCz/hVysc
         E/bxp66xmZSxMU8dbOXKSSK4E9jz4rLdbUREVX6r0g9BKSUsk40oXa6RhjYRf/9Mu2up
         aQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9U//vy5aZxPbfSmp3eOf2yD9Nnsp4zw2RiNbQ4obFB1LvEmfySkI/dW7QqIp1zOAgbiQ53Rws0XY@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4PYxzcoXPduqlIGRLRu5OtSxCBKhdaPtXs3iIbJfxxjVujtr
	71vX0AbkjLYaL7CStQ85p0jMgzBbLM58aDqVvaiPKd9Nc+gQr2p09BoI
X-Gm-Gg: AY/fxX7ILFw8J1w58PkNyGK5OFlqR7AGTah+dzQsjGgvB3qa+91ivv0I/tjKBSvoZlN
	+v/UF6MYU40+AOqd10rL3a3MjF234k6dvmAlQtb7c9M5t94d6/IaD532dTLQPuhCzx7M+latM3G
	Wh5KdgPDZP5OeP089Pgbuc4rv2IHuNlVD+j88IwfOMBt8TA9jjejY2HLcwGB4x0+h2pT2JlvtP6
	5W1MXVbdNuE5ghOC4h45ZPNgZvwBWmSakIYvMrMf+vwWWqozPd74PKEOQQBlV29SWM8gdWjXTY2
	lu2yF9vJbvN1m6Rx1ndUa3TpPQhaymugXEWpqIZg6n2MukLY/svU08wfODRBbAxlkt3/BIS+IoU
	Qtnii4xJed8AYxQqBC90wffjn34ek+uai4VU3SfM/SrE+g9Re1hLqz0WLqZbuG5EcM46f0CbE79
	rqB0cVc9oI
X-Google-Smtp-Source: AGHT+IGfZcTckoYQm0PZ8TzEz8YmdS7X/s2FUArN0KlH5v6g1oChNJ7JGYZdwCItZFhkXd+klVUdmg==
X-Received: by 2002:a05:690c:6704:b0:78c:5bb4:1d27 with SMTP id 00721157ae682-790b568d427mr107537007b3.38.1768011540680;
        Fri, 09 Jan 2026 18:19:00 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6713e5sm46527227b3.29.2026.01.09.18.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:19:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 09 Jan 2026 18:18:15 -0800
Subject: [PATCH net-next v9 1/5] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-1-8042930d00d7@meta.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
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
index ec4217d6c0b4..05a9a9e7abb9 100644
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


