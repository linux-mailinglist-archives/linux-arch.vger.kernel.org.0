Return-Path: <linux-arch+bounces-3202-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA06F88D1A1
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 23:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517E51F803EB
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88B13E40A;
	Tue, 26 Mar 2024 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x6D+IDhp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360B13DDDC
	for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493461; cv=none; b=mNL2CVdFR0lBfK94vjZd9p+NjNBalT46GZ8mGYvRUf7Zg4/LmJd34Lk9jQZ2CL2bTT8xkt3xpDQj4omMzUVGXIVDrxVrJFs/mRhkhd4mLfNzwsy7Lrq0LmjgSFKcQYiartErcS4dGFymB0D8QriA45DZ9BpUINciDZv4L2D0QVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493461; c=relaxed/simple;
	bh=HwXV7niH/WxHc7jazaZuD951dDYxvnrXLKJ5aOXzXpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ko5J0+043R1ZfR0JV3jWP4hJPsI2yyGdg1XAbNf/1H0NCIhOL8oYvoiyKTCl92QgNfl7EQL2h2F615X423nEGxt6TpxzBV4yOX8GGU++Jisr4pOpqt+HJBnH8kthyT3MORZrScAx8fZPJ/59oskVKOo0xsMcT3AyiHHhLzRYdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x6D+IDhp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd041665bso112363447b3.0
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 15:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711493457; x=1712098257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7wPvg5SzHg3djrLO0jF0y6HKK/VaWsWbJGTmJoXohw=;
        b=x6D+IDhpGqjgzwRWj5fpWKi+7i3QZkp1IEDjB1Qht3yOOKH/VaiTKAYKk0R5I603OM
         t8L7+P2cVN7YCO2ENWLslUaz3Wt5Ub8UGxiK1CnEQt7A+qRozSX3M31IgguKAY6jZJw+
         LSzyZ74AWYo8T8vPppF0g51kCPRajl4ZAM2YZ0CcWsFmFjHpGZ1UK+1/djvdkW4KvwJe
         97+MTstmMPVNj/zWYAY902/7tbetoYKV2/LacWPHJzEkDO33w0Jf8bzOrAjAP2nrbNOx
         LiQz1FQl1cprHZuOKN0V5HnKIDSqzQfN556rGH7/lhFMvzDRbqvzJSzc7y5HA0+T+wSy
         8vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493457; x=1712098257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7wPvg5SzHg3djrLO0jF0y6HKK/VaWsWbJGTmJoXohw=;
        b=QVbs+pb5Sxv7axe/XQrr4tIOmEURdxr7uVPazUnAQfi6vtyum0xMRqzTDosY6APvLM
         48C/u0Nt9Aa3cL5vJJUqGHBaLDoUbxBAbRiCgO9iwrW/Yg7LFhu4eANj7eZW5IWfRQdR
         S2F8F7co4fs7hm8Sl48b3IPjADTFTqt9M3h00UnVSS4FaZKtLFLLC5dkPhgzbe9UlL9H
         b6qIB+WJn3WeRq6ILG1YbWAClk/jM3MZJ063SLV4lV56mLLWP3rIbFDDKTjBjJZuyHW1
         2BRhZ3rYu26JJox2x7EAD8dDiSpzBwz37MqPzMxvXgE53+rNMuxb5X1B0jkWpNsLD/rE
         R0+g==
X-Forwarded-Encrypted: i=1; AJvYcCXjqhuZPIvnGrEk8AcANfAGaieeKZbFKdp/9a509qd/nyCE63JUePH8KxxIt5KYY96xPlsDbSBPfkE19/p4I+fYtIsZCmeNSZuskw==
X-Gm-Message-State: AOJu0Yx91Dmo1uCJ370QKk2If9wDz10y1tj549jPGcNt3jQfHtscFczT
	N+FnTQkPFl1m8nDmjdt/9PW/AVmBLvk4sDkFyHLCZKQl3f/JbPxJM3JRD8lTZV/UmHQ5qJlbes8
	GakNYLWAni6NiY7sqKwzbgw==
X-Google-Smtp-Source: AGHT+IGoJ91B2ro4NgPyk1e74NGmWSPhPzZUW0Q71qZOWUIfAfkK/24SBynuxXqxxickdOKVfZBEkC7HXTaNllUdCA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:c51e:bdd0:7cc8:695c])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:220a:b0:dcc:f01f:65e1 with
 SMTP id dm10-20020a056902220a00b00dccf01f65e1mr3555213ybb.8.1711493457318;
 Tue, 26 Mar 2024 15:50:57 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:50:32 -0700
In-Reply-To: <20240326225048.785801-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326225048.785801-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326225048.785801-2-almasrymina@google.com>
Subject: [RFC PATCH net-next v7 01/14] queue_api: define queue api
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

This API enables the net stack to reset the queues used for devmem TCP.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/netdevice.h   |  3 +++
 include/net/netdev_queues.h | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e41d30ebaca6..3d3af8f7f9c9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1956,6 +1956,7 @@ enum netdev_reg_state {
  *	@sysfs_rx_queue_group:	Space for optional per-rx queue attributes
  *	@rtnl_link_ops:	Rtnl_link_ops
  *	@stat_ops:	Optional ops for queue-aware statistics
+ *	@queue_mgmt_ops:	Optional ops for queue management
  *
  *	@gso_max_size:	Maximum size of generic segmentation offload
  *	@tso_max_size:	Device (as in HW) limit on the max TSO request size
@@ -2338,6 +2339,8 @@ struct net_device {
 
 	const struct netdev_stat_ops *stat_ops;
 
+	const struct netdev_queue_mgmt_ops *queue_mgmt_ops;
+
 	/* for setting kernel sock attribute on TCP connection setup */
 #define GSO_MAX_SEGS		65535u
 #define GSO_LEGACY_MAX_SIZE	65536u
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..337df0860ae6 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -60,6 +60,33 @@ struct netdev_stat_ops {
 			       struct netdev_queue_stats_tx *tx);
 };
 
+/**
+ * struct netdev_queue_mgmt_ops - netdev ops for queue management
+ *
+ * @ndo_queue_mem_alloc: Allocate memory for an RX queue. The memory returned
+ *			 in the form of a void* can be passed to
+ *			 ndo_queue_mem_free() for freeing or to ndo_queue_start
+ *			 to create an RX queue with this memory.
+ *
+ * @ndo_queue_mem_free:	Free memory from an RX queue.
+ *
+ * @ndo_queue_start:	Start an RX queue at the specified index.
+ *
+ * @ndo_queue_stop:	Stop the RX queue at the specified index.
+ */
+struct netdev_queue_mgmt_ops {
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
+};
+
 /**
  * DOC: Lockless queue stopping / waking helpers.
  *
-- 
2.44.0.396.g6e790dbe36-goog


