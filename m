Return-Path: <linux-arch+bounces-15818-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C6CD2BB88
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 06:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADF3A3038CD4
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 05:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78434C12B;
	Fri, 16 Jan 2026 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEzDqk8S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0134A791
	for <linux-arch@vger.kernel.org>; Fri, 16 Jan 2026 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539802; cv=none; b=rOpMuS4A6t5w2hnHNcP50D9rRQfMbz3OU7xlq7Q7Cd+oaCrJ65lxvBYx2qwZVXmK8Zjt5HF2O2wuq6x+o0pnpd/8MCsYWPqQa4sGGouWgBVfPUSCH3t9kEOst9QVHVZInkvJ1gfqmLaHAvpQeZzLt/lg9euCRCvZ35Gkqd6qu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539802; c=relaxed/simple;
	bh=QnAdtI5+4DFmxFeKdHgtB5jd0gU6PEbg0bZ2tI0AuZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jell5ChC/67N5ytURL6PNMFNR1mVxM3IUW3RgkaWJzVz35fICfUec2C7i5NH2lEwfqsGfL12QZiKMRS/MKZyJMOga7LUuYzaByVRy4FCp4rxp9cpiOUzwxanKRi8qT24kAmwCEBC7pS+GZyXB6fjRPhkIkaRkfr7tyn38Vqo4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEzDqk8S; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78fc4425b6bso15849407b3.1
        for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 21:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768539798; x=1769144598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpPfAIHBzai3/e/zMri/UCW5j7V8nMCJkbV5OCQGhRA=;
        b=SEzDqk8S9FbFi4okuM3QhTEkgb1CvBaR8TdX18wRjKo3y/8v+5mIWiVLIRsTys8hQ+
         Fxp29xgE5cu9G3CTO1dnoKauUbaJ6Fsxvp1yfjRf8DFi/5+iAa46PLKBxJh51Y9VkGox
         gJ/IqdV/BucrfCk+Lh5nOQGK2Y41f1XyPzodQ6iCoT8i5pbxo9y8lZ0z9y8Ya2V9SPxP
         FsNUTItvBPFo+XRoX8QfbbjxH3INN+I/j29YOREy248d5eTLufj2nHJzPxm+w9OPOSCX
         BGzzp3I6cKfuy0weAzH2e+9xe6ZQ8MmQD+idbQBfpdsS7g0Fy/25U8+unSGMCc49GhoP
         iZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768539798; x=1769144598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZpPfAIHBzai3/e/zMri/UCW5j7V8nMCJkbV5OCQGhRA=;
        b=qAIyhIPdIX/RJCRcuRY/FBfgCfhq1RYQdXTjevywfbFRPOSOT6v23q9Gbt0HvvhRKT
         LGKvHWf2wpvBTWWPz62sQhnXkgaDPzUYjp+QN/wjmJvBIe+q6UoksFHi/Dhmk7+VCmef
         n0PtdbkbgtiFo4OwWPlZpzZj1NXqKkUkbmqMkZ7AdnsELK/DlSuNLqZY0G1UWOGvOf9i
         iSjfxHXP+oBdOZRj56S3sgr3hw7vK3hZx5vTOIvdf9oCUtFX9izqIZ5P0V1aIF2kVd6T
         BqKTZ2NhxP2FBuMnYajN2EEP9dTb1A9QNZtaa+WlfFcFipzVB2EtclwuL2jK65s7X7RP
         0iWg==
X-Forwarded-Encrypted: i=1; AJvYcCUUKgsKTu6KtEYifFys2FX3ILHOOSLSofeZMFJle2VPtB28snlWLXABTZbAL+aP2zW2IOkTiHa0jb3I@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNo7aLvdyvdcxlc5o2xMyOEjofV/sU3RlFg2Ndt+taJXxkcDB
	vquAvUNS1JH4/kl1OAhLs4gRLWsZEvDf741AM7Gi9L0rjwMXZTDfJ1BM
X-Gm-Gg: AY/fxX4kXDt76KDwEC905f6Xm2kHhCWIX/WQFE4KsAe/99zH6DmHibLfFmYqNzI3vYy
	uHjEe7yLrpzi7J/rqb6X3APG2ikteDzOrdYMxInClpX+KWy2FMvE96cZdDtFTwqzPubOh6Mw93l
	L2rdmMAVzjr6SxBEaFR41ZCK3Dfg4QlMsaERepIQKe8UjUig+7QKHmt+ZBWwbIavfEFZyr9M9YG
	ejJRnht4vl3lX3IBrUZcsNtHp57jmBtUDSwClzV4sjWyehatIlYQERlo8HYvugA7Q4J9Z3RmqhJ
	Ukp9au7LqC20dvOke/tewWKXTSrB9JPEDECjwszRTiLB+sLme/hxwjrjHyuOz6tGE3qdrLJfBMZ
	zYYhVB/Ymu0yO9T14EgFMZO3JYyZ40NhbptoU273HqXPd8H62Wt+fPprrMFiSPjNaaCs/w7g1ok
	hvF+DFuVy4
X-Received: by 2002:a05:690c:6f10:b0:793:afdd:e63e with SMTP id 00721157ae682-793c544d6ddmr17343937b3.33.1768539798065;
        Thu, 15 Jan 2026 21:03:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c72aesm5327037b3.11.2026.01.15.21.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 21:03:17 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 15 Jan 2026 21:02:12 -0800
Subject: [PATCH net-next v10 1/5] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-1-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
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
index 185ed2a73d1c..9dee697a28ee 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -85,7 +85,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
-	kvfree(binding->tx_vec);
+	kvfree(binding->vec);
 	kfree(binding);
 }
 
@@ -246,10 +246,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -263,7 +263,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
-		goto err_tx_vec;
+		goto err_vec;
 	}
 
 	virtual = 0;
@@ -309,7 +309,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -329,8 +329,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -379,7 +379,7 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
-	if (!binding || !binding->tx_vec) {
+	if (!binding || !binding->vec) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -430,7 +430,7 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
 	*off = virt_addr % PAGE_SIZE;
 	*size = PAGE_SIZE - *off;
 
-	return binding->tx_vec[virt_addr / PAGE_SIZE];
+	return binding->vec[virt_addr / PAGE_SIZE];
 }
 
 /*** "Dmabuf devmem memory provider" ***/
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 2534c8144212..94874b323520 100644
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


