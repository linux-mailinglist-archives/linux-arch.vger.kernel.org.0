Return-Path: <linux-arch+bounces-763-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0758097DE
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 01:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AADB1C20C74
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3FFED8;
	Fri,  8 Dec 2023 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKnwUW+O"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15FC172D
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 16:53:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db3ef4c7094so2057012276.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996781; x=1702601581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1r8ZXlyktFk/hR6LvKbeClNyv61T/bWHclepM8Rp88=;
        b=nKnwUW+ODKImfMaS+HQrnvNEyZvj4JFMXrS8bZ2Yj2CEkAWfRhNkOcAbSNZryzCV40
         IEP3lXnGr0DPXlGGLhlUv9I9HMPS4JPnRE7WCrvUzpjlrtvyTGHZ21wStkG0XrDx2NMW
         UxP6Ekq10yozd0+HCZ2rraY2EqsiLLQf7nZUnVP6fq27YMRIRrL3OzLJnG1+wUA+pcXO
         vd6SaMDoFYSUNiRcyaZnRvWOhdHS3Y3Lw/f3oaqITRv1LXh3YNJumLBbszFEM4o6mo34
         MaFYf2i0lX6QKtI2a/1XI8KLfwQUm79xAeSyNffz3LXeA1Otv48DStwIYBlBzvrjFvl2
         oJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996781; x=1702601581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1r8ZXlyktFk/hR6LvKbeClNyv61T/bWHclepM8Rp88=;
        b=WGVnvOmgaCrqWC/+f/ZJPuR/a+bPCEyCZx7V7wQnSSAsZafHa6e3kk/tmEqyqCbbbv
         u6qn/DsK2E/otCcED8gszKqytimz2qhVjtdUT/6wMknj3lPdQRrSKzyrU5Q7fOlncBgo
         rVnBXRrnVYY9bUdsaRvLEO0GpcCwoPdtUsmAlW2HwxlRWut2TClYB9a3Upv8FHZjU3Dm
         IbyrV+HAIABXRbqu+ijzGZg5bRpLlXyg2/VkAPJvMjsHpVNrYvOitIDxHS1fR7vwh7xh
         D4nWNmfD6jcP2O4dMYSz5VnSBduXYQQGFQXXbaua6WPdcnUGuBQGNO/BlkaOsUHIeDbX
         vFNA==
X-Gm-Message-State: AOJu0YyVXJocDGCDLuhSf+j5LPfAea6wKHblr+qBjWraZVVNUPcUHACF
	/t196NrOjTpKzqiFI4kiLcqn1X1mR7kUfJ3wJg==
X-Google-Smtp-Source: AGHT+IEj1VqfFnBiOaXdk3C7zQ8oyWSVZPqGPRw04iIGc/p6HTi+O3QytptJH8qJW9Cs/Vxkfvehw/gsxCl4ycls9Q==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a25:cc4b:0:b0:db5:3bdf:ff55 with SMTP
 id l72-20020a25cc4b000000b00db53bdfff55mr39860ybf.6.1701996781080; Thu, 07
 Dec 2023 16:53:01 -0800 (PST)
Date: Thu,  7 Dec 2023 16:52:34 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-4-almasrymina@google.com>
Subject: [net-next v1 03/16] queue_api: define queue api
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

This API enables the net stack to reset the queues used for devmem.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/netdevice.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1b935ee341b4..316f7dee86ce 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1432,6 +1432,20 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ *
+ * void *(*ndo_queue_mem_alloc)(struct net_device *dev, int idx);
+ *	Allocate memory for an RX queue. The memory returned in the form of
+ *	a void * can be passed to ndo_queue_mem_free() for freeing or to
+ *	ndo_queue_start to create an RX queue with this memory.
+ *
+ * void	(*ndo_queue_mem_free)(struct net_device *dev, void *);
+ *	Free memory from an RX queue.
+ *
+ * int (*ndo_queue_start)(struct net_device *dev, int idx, void *);
+ *	Start an RX queue at the specified index.
+ *
+ * int (*ndo_queue_stop)(struct net_device *dev, int idx, void **);
+ *	Stop the RX queue at the specified index.
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1673,6 +1687,16 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+	void *			(*ndo_queue_mem_alloc)(struct net_device *dev,
+						       int idx);
+	void			(*ndo_queue_mem_free)(struct net_device *dev,
+						      void *queue_mem);
+	int			(*ndo_queue_start)(struct net_device *dev,
+						   int idx,
+						   void *queue_mem);
+	int			(*ndo_queue_stop)(struct net_device *dev,
+						  int idx,
+						  void **out_queue_mem);
 };
 
 /**
-- 
2.43.0.472.g3155946c3a-goog


