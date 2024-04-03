Return-Path: <linux-arch+bounces-3364-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9E8960C9
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 02:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F088E1C22547
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 00:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D66175AB;
	Wed,  3 Apr 2024 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3PwJ7a0V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC7FC0C
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103669; cv=none; b=SAYXqzi1+Rr6ohVxKDNSygxkihc2nr/Yrbm96Yyo8BViCyBoeRyWUA0QcPqPJ7lOujdKNb3rm2mn/wBZVSf6gFhdPe6KMNiqjspNRCqWVf7lm4wnJXXziHKSAUfiRyWgd8E25YcuFo56MivR7Qgbmh64X6tUiBHvcI+XrjWKIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103669; c=relaxed/simple;
	bh=3oGrkmCH5YusnqtWdd9vM/UCcmG1GvEKcryFEwgzMms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EwBG0+B4YVTKaCsxd2yvZ4psBZjHL4BHpnejddeN2IUKeZyX3XpXn+Cv0t+7IvVe/hp533zTFtgL7Rf9aqHJ/K8y0MKwwHQjsL9QJY0d+mZW9wYsKUqP3dqsUO5DNzTwa76bOPS9n20Q6mgsQIKH6buwXERWLJ5pRyk8E7QGZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3PwJ7a0V; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61514d1bc61so24813357b3.1
        for <linux-arch@vger.kernel.org>; Tue, 02 Apr 2024 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712103666; x=1712708466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXtxUBXD7iooLyZhC2sG2IzmQnskI70ikTtvKYSHue4=;
        b=3PwJ7a0V9lZiWTtYxtnfrhP9gngtC6Ilx42P0IiDyDrZ3d8FzRkAI6Hq7/5EfFwbJg
         UAljYtkV6PFuf6HgPXYoTRJfPUOKQoU9NlZqvcGP8SD2G0XCc5eKMJDrHBMixfcFQBDj
         CNN2o7yJcjlBMd7BzL34XvijOfRoZh0eFqwaBffkWHTwyfauSWm/Fugw3BCjz0Dvoqbr
         OWVSQtDn/8zck7gbcJV/9syJI35+t+9hKnup9H2mhYFBjJmxs6W3kYXXYv93lXkqLuat
         pE94JUggY3IWVK0TPvkZUxYNpkZRf7XWx1o6UgBdrnguxkZKgymGhf+bvwbrfo3fVitG
         PTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103666; x=1712708466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXtxUBXD7iooLyZhC2sG2IzmQnskI70ikTtvKYSHue4=;
        b=ZLL8jMeyHImYueaIbFeLyM2LRmHLw7x3Q3Ov49IFV7fHGRzpIQQy6rLXesdgUh7kOy
         CWh6s9/ecCJXVKG+cmffcCkYwfFqNgmJCHuJLSKvGX/k/I57D9+jTfd+Qh/VkHm1nrlW
         o8NLYNUC8s+iSUrV7lN4hm/XPo0VUOkSirCX3WA4PEYvMufmX++QQ84rBZcqWbW66iFw
         NON7FAeY6uslIXwDsrYGZ0Q6gO4IJXFmvRMbcpDzz+g1NzSPScyddMgPLk9NFolFdw5q
         ykPvFm6kQd6YjjbFjeBSPvPf2Fj0BKTpHN6OYGxxFDEV8qjs9Iio8weTWTITINMtF7IQ
         jVog==
X-Forwarded-Encrypted: i=1; AJvYcCVs9Jw5i5nAq/WcdEpuKyPkrZpnH0c+TP06fvNpeQGcTlvd/YrIGGl9uvPDz2TMiEhA7rhCVxn4KaDZI4I2N3EZSAxAeuxmD0nkxQ==
X-Gm-Message-State: AOJu0Yz5L5GZBIOKWryYU51gRaEMZOXQWppa+Bl5ko9kRTkqdcIhCpt0
	/951uTDJYZwbwiD55SnWjL0HxArLLkiCNHjmk7pF1KJko9uXSLba+B9O/m2ulVway9+KystasY6
	B1OYbrkqxvADTRoQEPH/7SA==
X-Google-Smtp-Source: AGHT+IHoaW+htRqZm8yPKrycRs7l5wFzQqTxKosjj/zq3wYGjjEBoSynJ7xr0b8IxFqU+0S52tGWH9KU7a/j6/BQOw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:a9d:b0:615:c92:d3ab with SMTP
 id ci29-20020a05690c0a9d00b006150c92d3abmr1126296ywb.4.1712103665733; Tue, 02
 Apr 2024 17:21:05 -0700 (PDT)
Date: Tue,  2 Apr 2024 17:20:40 -0700
In-Reply-To: <20240403002053.2376017-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403002053.2376017-4-almasrymina@google.com>
Subject: [RFC PATCH net-next v8 03/14] net: netdev netlink api to bind dma-buf
 to a net device
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
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Florian Westphal <fw@strlen.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Aleksander Lobakin <aleksander.lobakin@intel.com>, Michael Lass <bevan@bi-co.net>, 
	Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

API takes the dma-buf fd as input, and binds it to the netdevice. The
user can specify the rx queues to bind the dma-buf to.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v7:
- Use flags: [ admin-perm ] instead of a CAP_NET_ADMIN check.

Changes in v1:
- Add rx-queue-type to distingish rx from tx (Jakub)
- Return dma-buf ID from netlink API (David, Stan)

Changes in RFC-v3:
- Support binding multiple rx rx-queues

---
 Documentation/netlink/specs/netdev.yaml | 53 +++++++++++++++++++++++++
 include/uapi/linux/netdev.h             | 19 +++++++++
 net/core/netdev-genl-gen.c              | 19 +++++++++
 net/core/netdev-genl-gen.h              |  2 +
 net/core/netdev-genl.c                  |  6 +++
 tools/include/uapi/linux/netdev.h       | 19 +++++++++
 6 files changed, 118 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 76352dbd2be4..275d1faa87a6 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -268,6 +268,45 @@ attribute-sets:
         name: napi-id
         doc: ID of the NAPI instance which services this queue.
         type: u32
+  -
+    name: queue-dmabuf
+    attributes:
+      -
+        name: type
+        doc: rx or tx queue
+        type: u8
+        enum: queue-type
+      -
+        name: idx
+        doc: queue index
+        type: u32
+
+  -
+    name: bind-dmabuf
+    attributes:
+      -
+        name: ifindex
+        doc: netdev ifindex to bind the dma-buf to.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: queues
+        doc: receive queues to bind the dma-buf to.
+        type: nest
+        nested-attributes: queue-dmabuf
+        multi-attr: true
+      -
+        name: dmabuf-fd
+        doc: dmabuf file descriptor to bind.
+        type: u32
+      -
+        name: dmabuf-id
+        doc: id of the dmabuf binding
+        type: u32
+        checks:
+          min: 1
+
 
   -
     name: qstats
@@ -457,6 +496,20 @@ operations:
           attributes:
             - ifindex
         reply: *queue-get-op
+    -
+      name: bind-rx
+      doc: Bind dmabuf to netdev
+      attribute-set: bind-dmabuf
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - dmabuf-fd
+            - queues
+        reply:
+          attributes:
+            - dmabuf-id
     -
       name: napi-get
       doc: Get information about NAPI instances configured on the system.
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index bb65ee840cda..c5b959a0ed6c 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -136,6 +136,24 @@ enum {
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_DMABUF_TYPE = 1,
+	NETDEV_A_QUEUE_DMABUF_IDX,
+
+	__NETDEV_A_QUEUE_DMABUF_MAX,
+	NETDEV_A_QUEUE_DMABUF_MAX = (__NETDEV_A_QUEUE_DMABUF_MAX - 1)
+};
+
+enum {
+	NETDEV_A_BIND_DMABUF_IFINDEX = 1,
+	NETDEV_A_BIND_DMABUF_QUEUES,
+	NETDEV_A_BIND_DMABUF_DMABUF_FD,
+	NETDEV_A_BIND_DMABUF_DMABUF_ID,
+
+	__NETDEV_A_BIND_DMABUF_MAX,
+	NETDEV_A_BIND_DMABUF_MAX = (__NETDEV_A_BIND_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QSTATS_IFINDEX = 1,
 	NETDEV_A_QSTATS_QUEUE_TYPE,
@@ -162,6 +180,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
 	NETDEV_CMD_PAGE_POOL_STATS_GET,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8d8ace9ef87f..bbaaa1b36b5b 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -27,6 +27,11 @@ const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFIND
 	[NETDEV_A_PAGE_POOL_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_page_pool_ifindex_range),
 };
 
+const struct nla_policy netdev_queue_dmabuf_nl_policy[NETDEV_A_QUEUE_DMABUF_IDX + 1] = {
+	[NETDEV_A_QUEUE_DMABUF_TYPE] = NLA_POLICY_MAX(NLA_U8, 1),
+	[NETDEV_A_QUEUE_DMABUF_IDX] = { .type = NLA_U32, },
+};
+
 /* NETDEV_CMD_DEV_GET - do */
 static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
@@ -58,6 +63,13 @@ static const struct nla_policy netdev_queue_get_dump_nl_policy[NETDEV_A_QUEUE_IF
 	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_BIND_RX - do */
+static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_BIND_DMABUF_DMABUF_FD + 1] = {
+	[NETDEV_A_BIND_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_BIND_DMABUF_DMABUF_FD] = { .type = NLA_U32, },
+	[NETDEV_A_BIND_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_dmabuf_nl_policy),
+};
+
 /* NETDEV_CMD_NAPI_GET - do */
 static const struct nla_policy netdev_napi_get_do_nl_policy[NETDEV_A_NAPI_ID + 1] = {
 	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
@@ -129,6 +141,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_QUEUE_IFINDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_RX,
+		.doit		= netdev_nl_bind_rx_doit,
+		.policy		= netdev_bind_rx_nl_policy,
+		.maxattr	= NETDEV_A_BIND_DMABUF_DMABUF_FD,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 	{
 		.cmd		= NETDEV_CMD_NAPI_GET,
 		.doit		= netdev_nl_napi_get_doit,
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 4db40fd5b4a9..ca5a0983f283 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -13,6 +13,7 @@
 
 /* Common nested types */
 extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1];
+extern const struct nla_policy netdev_queue_dmabuf_nl_policy[NETDEV_A_QUEUE_DMABUF_IDX + 1];
 
 int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
@@ -26,6 +27,7 @@ int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
 int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
 			       struct netlink_callback *cb);
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 7004b3399c2b..67711d29d0d4 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -674,6 +674,12 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
+/* Stub */
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
 				       unsigned long event, void *ptr)
 {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index bb65ee840cda..c5b959a0ed6c 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -136,6 +136,24 @@ enum {
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_DMABUF_TYPE = 1,
+	NETDEV_A_QUEUE_DMABUF_IDX,
+
+	__NETDEV_A_QUEUE_DMABUF_MAX,
+	NETDEV_A_QUEUE_DMABUF_MAX = (__NETDEV_A_QUEUE_DMABUF_MAX - 1)
+};
+
+enum {
+	NETDEV_A_BIND_DMABUF_IFINDEX = 1,
+	NETDEV_A_BIND_DMABUF_QUEUES,
+	NETDEV_A_BIND_DMABUF_DMABUF_FD,
+	NETDEV_A_BIND_DMABUF_DMABUF_ID,
+
+	__NETDEV_A_BIND_DMABUF_MAX,
+	NETDEV_A_BIND_DMABUF_MAX = (__NETDEV_A_BIND_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QSTATS_IFINDEX = 1,
 	NETDEV_A_QSTATS_QUEUE_TYPE,
@@ -162,6 +180,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
 	NETDEV_CMD_PAGE_POOL_STATS_GET,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 
-- 
2.44.0.478.gd926399ef9-goog


