Return-Path: <linux-arch+bounces-14508-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4884C33A19
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 02:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAAF464C6C
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 01:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C0C255F31;
	Wed,  5 Nov 2025 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbKiRJKa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBEA23C512
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305807; cv=none; b=euztt7U7eb/YNo7BeX+BYDf7FQFcB3EAHPkIXVKlQlMHmrCs6RUXz3ODNNs/5s77FFFeou0HepUKCBSaY74nr/24XDNvuqaeX8RdERCyUSnTG2khCGbTKow1TzBQHb/ZXmZryFof+oLvGkDw3hJ3UWZS3LhmxcPf1iH0ipCJzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305807; c=relaxed/simple;
	bh=OvzNhBXxuWUIF6RvKnWgwOVCFYbwugbVchWt/Nz0HFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/prt1awwiBgHpyS1f6JpBuWGOK5qsF0pPOGCTop5dmN5eY7kjwoU0AwRKwcF50G/y4uYH1TmJEzl6eRev62Rv26Wwg6WXtGIS3iwR/wvxKdTAPv3/JILzCagxHV5A6b1eCVAp10PYPoSiPD8yW7PyLmsZ5JWVqmxmrmf/C+oSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbKiRJKa; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7864cef1976so6946747b3.0
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 17:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305804; x=1762910604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+SHvc7nB9HHEDm3HUCX6qil9+t5RGl5tlTHjTzf/d8=;
        b=bbKiRJKaCxxCePZ3MFJn14tbhBMXlMebKzsToyhvXUnlWvzLKWy9Ubg3yBBhnBKIcq
         8ZshJNuCT1wcMTMMr2dEFKAkKKU+H33EKMe3Lsh+Fgy8m9rBL/fmKoNgZ5Rbh2UwTx8F
         9f7ojtB+BrfUXQevhivZARAjJfSISBdNWuzgIY0IkqSfAs7qOzWbLIWg6oa6Y9yxgAT2
         TTIouHeHrtH2g2ca40JQEiK0okNcM9dxpWgec5el7ndxmLLZ6hEBSkb25rkezMEjJ+xt
         KBYLg5rIq7aH1puTak7ss07+5q5+fx/YgK5gxuRLPTKBm1BLmMAsPahiQD7PlzMcR3GG
         0P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305804; x=1762910604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+SHvc7nB9HHEDm3HUCX6qil9+t5RGl5tlTHjTzf/d8=;
        b=O0qiQ7KNtTUa3Kh9CEc3tg9DvjTHUsvi9fRTc1IUNrn1K76y7KUUK1iaRwqrSdGE4y
         5wQI0hpHLVNzbckU7xpbgDtFXfBvWeuBXnDFKuXC7j36BTI/KCjc86JHobwq0cStSIRW
         c3TowayqsWPayZsdIhv5T/zQCxEgorbQCIcpxm+cMfs4lerKsFpNpufBTFY0090rMgCh
         wEuqbUzSraDjTItKfYmXRlpFzrHINffBw0uKiHx4upE1Iv/d0iCAhVNcFiNlthVajyQ9
         vPI+kEgmuz8V5YOQMBfFgAFpWvg9DM+FBZS7RJ6Ulxuh5i6vY+TjQclh+AlxuHN3/qMh
         afSA==
X-Forwarded-Encrypted: i=1; AJvYcCWY2h5C0KO2EKxZxrhgjuZz/+2SaVeTc7kRnUvPluWbDNHghmjvQLP9g8BT1f0/tHXkncBww8/JGZ3K@vger.kernel.org
X-Gm-Message-State: AOJu0YxrVAB5R1g0+2UQ+i4js3vYDB5m30Y/lQN/ZqyBzWQAp84lisTI
	suCJ9j/HAylPUVOVd5Ug7J7WVJqRDXefF6WZgJXFSmdTdLbQfVV/gpt3
X-Gm-Gg: ASbGncsQmycS2zbdeC0MRLvWZlSRex+VbIKob6qwydiMkwoEQUAM/dX3wzjaORBsd0/
	AY/J0oHe0bVDE2ZLWDdoMQt1FzCUXPVWKJeP7s8QYnhEJwBA2jqMhP8rs1Og3dprHV0ih8Dax8u
	SSq/lUKRRQD5HuLdQrg9/WNcTzJMat9xGYLAagtRIOGgZZc1LowL+2iy5Y3jKA/BbxhKOf7A9Ld
	r2+UQ1n7mI4KHNZAvgVncvXgYGlWe5vma0fbE5AsgblrrjLWqRc+l1CmtR2/wtNnuYhzH7IXfpS
	SU0LldnoNvJ/8CS1vtrrmY/szbqyhpAGr5ety2BtTOayj5A49SyXPBbMFou3j7qwuxI7l9QZzDN
	dpZZNU8mtJW5ycTIqPeuu+7X58N8aDGIHmK42okjidByaVWzMbnSPoubuebdXw8wU+1Cc9dBQT1
	/xpkCD57yov+I=
X-Google-Smtp-Source: AGHT+IFeyI0Qmv/W+8x9HEVce2BJ1U7rPbvYiu9qefbETDwwR8GfWjNVDPJZ55xAV6KEJZjaAcCOAw==
X-Received: by 2002:a05:690e:1c0b:b0:63f:af0f:aaf with SMTP id 956f58d0204a3-63fd31161f5mr1195839d50.1.1762305804005;
        Tue, 04 Nov 2025 17:23:24 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63fc92f0a66sm1316651d50.0.2025.11.04.17.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:23 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 17:23:20 -0800
Subject: [PATCH net-next v6 1/6] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-1-ea98cf4d40b3@meta.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
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
index 101150d761af..2ada54fb63d7 100644
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


