Return-Path: <linux-arch+bounces-7129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE3970D2C
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 07:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B9F2813A1
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C41AD9E0;
	Mon,  9 Sep 2024 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5d9kbNw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92F1AD3FD
	for <linux-arch@vger.kernel.org>; Mon,  9 Sep 2024 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725860610; cv=none; b=KQrJ6lIFib7wDqoVWhDkVktVmaRbc1dN/AUInoSehXI8Ut8doo8kZk8tGVfdP9SSO5OW8NBPetLJnELdPDz+GukZMBJTJRFXpQSycvvxJHykRSvXgS+ENRFsIAOBDoLIH0DW5wV1w71P7H06rgi0rIr3RMHWK6CtHEfeA31ToG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725860610; c=relaxed/simple;
	bh=ifkk5EzOQnvX7N0pj7xFyfgeQQygVm1rE0XeuABHrqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OAap/5meDcmyC2UY8/AAEDDLnfCNkF9gEpRPxNQvHwmBZqCBzyfUb6iRWHfYE7AjSaOZJzqvsrnmWC1aOm2PRKTirt5qVyv8VicDAeC3LjeeUP63dKXJPevo18oYKGmInwl0b0sFXcXjGuGRcBfPiPGLzyOb3v20+psDtEFA0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5d9kbNw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d475205628so119548657b3.0
        for <linux-arch@vger.kernel.org>; Sun, 08 Sep 2024 22:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725860606; x=1726465406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6CrK96qJP4z3b0FDzKM+/eICeW01UPDJxn1zoMHr9yY=;
        b=a5d9kbNwdXiCQbq7DjyOkRduY4lwRlWMHxQCjsVOXTYIv8VgDQsn3pbzMIeVKUj7Zh
         GeYKL8wFoWwy2BJk9w4jf6ShaUOJLbQYpCusSL6ltur9jECYJbm6rMdVPG/AzneKWpb1
         XdYsqqMwL456RWqcGXnoAeIIC6EQ7TEy829ODkxhVBsjH7YVaIyCwQJ/C+16ZEYkOnnm
         PixTvYmiWIGfLJNNPwCMMzJawU7wstHxl0joH0TI8uELhdwGYcDhF3hX2M+sOo1Oekbg
         A8mrRQypKgDay9idu4MHqYGX1BtYuo+pdmYR9qYHsRs1jAkJf0QFp9sb4lX8Q1gkOBlS
         yrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725860606; x=1726465406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CrK96qJP4z3b0FDzKM+/eICeW01UPDJxn1zoMHr9yY=;
        b=cNNJGEAWa5H6HvoIv3trOIrhDoGPQba8YkJp3424YjckVZcLLJTyqZGnNw0nv6SNmX
         Lo2/YC8ltpL9jdwWnNALRxGK4q6rrhFhmdEyETHfHvYiybNhbiCnqVRpIYRaZv+NZLgT
         MFEhfdGLP5zlzke9PhLjICB9y4YS+gW6htFuo7HdI/zcbB5pJm4TNx3aqSjaFolKKhd0
         FOTIosNJsx4XPdC7kFfz/9uK12N0Wotymg0lOnY2/jbO9SdkQ6YibLwaTL2x4B2Msenk
         kPTlwNvbCygzON2A/S5p8QHdwD/bhHGxKxAtkP9oLC3CC9sLheTzPHoScAqbHt+tsNfA
         wyMw==
X-Forwarded-Encrypted: i=1; AJvYcCVeDnZ05Sx3VVhBNpZd9AqTXWOiX+u/IAu8nfqoGMnmJtQ3XDtbHbfuXVDJos6CzrI2gxGHXsbOMI78@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzturCA7UD3SMYXNEZ2NvZIU5VjTgD3HA6pUA23PJ8uECEGT3
	7Pj9jTE/RrPJyeem4LBKczvl5+VZl7PHUk6JC80cnv2oNtke1XFEzcA/NqUYJEaEiRyn/I8B2hV
	VJEyTuYqAwVDaMZf1KrXOgg==
X-Google-Smtp-Source: AGHT+IGwQgjuvNyD+Z4vlmdws3yK/iqd/mq/O3+Dp4Tm5KrdXVTdk9Si6mlTifCHDFeMeeeKzuzLtTC/snqQIS+9nw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a0d:e4c2:0:b0:68d:cbd6:e28 with SMTP
 id 00721157ae682-6db4516321bmr3046067b3.6.1725860605736; Sun, 08 Sep 2024
 22:43:25 -0700 (PDT)
Date: Mon,  9 Sep 2024 05:43:07 +0000
In-Reply-To: <20240909054318.1809580-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240909054318.1809580-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240909054318.1809580-3-almasrymina@google.com>
Subject: [PATCH net-next v25 02/13] net: netdev netlink api to bind dma-buf to
 a net device
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

API takes the dma-buf fd as input, and binds it to the netdevice. The
user can specify the rx queues to bind the dma-buf to.

Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>

---

v16:
- Use subset-of: queue queue-id instead of queue-dmabuf (Jakub).
- Rename attribute 'bind-dmabuf' to more generic 'dmabuf' (Jakub).
- Use 'dmabuf' everywhere instead of mix of 'dma-buf' and 'dmabuf'
  (Donald).
- Remove repetitive 'dmabuf' naming that appeared in some places
  (Jakub).
- Reordered where the new operations went so I don't break the enum UAPI
  (Jakub).

v7:
- Use flags: [ admin-perm ] instead of a CAP_NET_ADMIN check.

Changes in v1:
- Add rx-queue-type to distingish rx from tx (Jakub)
- Return dma-buf ID from netlink API (David, Stan)

Changes in RFC-v3:
- Support binding multiple rx rx-queues

---
 Documentation/netlink/specs/netdev.yaml | 47 +++++++++++++++++++++++++
 include/uapi/linux/netdev.h             | 11 ++++++
 net/core/netdev-genl-gen.c              | 19 ++++++++++
 net/core/netdev-genl-gen.h              |  2 ++
 net/core/netdev-genl.c                  |  6 ++++
 tools/include/uapi/linux/netdev.h       | 11 ++++++
 6 files changed, 96 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 959755be4d7f..4930e8142aa6 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -457,6 +457,39 @@ attribute-sets:
           Number of times driver re-started accepting send
           requests to this queue from the stack.
         type: uint
+  -
+    name: queue-id
+    subset-of: queue
+    attributes:
+      -
+        name: id
+      -
+        name: type
+  -
+    name: dmabuf
+    attributes:
+      -
+        name: ifindex
+        doc: netdev ifindex to bind the dmabuf to.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: queues
+        doc: receive queues to bind the dmabuf to.
+        type: nest
+        nested-attributes: queue-id
+        multi-attr: true
+      -
+        name: fd
+        doc: dmabuf file descriptor to bind.
+        type: u32
+      -
+        name: id
+        doc: id of the dmabuf binding
+        type: u32
+        checks:
+          min: 1
 
 operations:
   list:
@@ -619,6 +652,20 @@ operations:
             - rx-bytes
             - tx-packets
             - tx-bytes
+    -
+      name: bind-rx
+      doc: Bind dmabuf to netdev
+      attribute-set: dmabuf
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - fd
+            - queues
+        reply:
+          attributes:
+            - id
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 43742ac5b00d..91bf3ecc5f1d 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -173,6 +173,16 @@ enum {
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
 };
 
+enum {
+	NETDEV_A_DMABUF_IFINDEX = 1,
+	NETDEV_A_DMABUF_QUEUES,
+	NETDEV_A_DMABUF_FD,
+	NETDEV_A_DMABUF_ID,
+
+	__NETDEV_A_DMABUF_MAX,
+	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
@@ -186,6 +196,7 @@ enum {
 	NETDEV_CMD_QUEUE_GET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
+	NETDEV_CMD_BIND_RX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8350a0afa9ec..6b7fe6035067 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -27,6 +27,11 @@ const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFIND
 	[NETDEV_A_PAGE_POOL_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_page_pool_ifindex_range),
 };
 
+const struct nla_policy netdev_queue_id_nl_policy[NETDEV_A_QUEUE_TYPE + 1] = {
+	[NETDEV_A_QUEUE_ID] = { .type = NLA_U32, },
+	[NETDEV_A_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+};
+
 /* NETDEV_CMD_DEV_GET - do */
 static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
@@ -74,6 +79,13 @@ static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE
 	[NETDEV_A_QSTATS_SCOPE] = NLA_POLICY_MASK(NLA_UINT, 0x1),
 };
 
+/* NETDEV_CMD_BIND_RX - do */
+static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1] = {
+	[NETDEV_A_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
+	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -151,6 +163,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_QSTATS_SCOPE,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_RX,
+		.doit		= netdev_nl_bind_rx_doit,
+		.policy		= netdev_bind_rx_nl_policy,
+		.maxattr	= NETDEV_A_DMABUF_FD,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 4db40fd5b4a9..67c34005750c 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -13,6 +13,7 @@
 
 /* Common nested types */
 extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1];
+extern const struct nla_policy netdev_queue_id_nl_policy[NETDEV_A_QUEUE_TYPE + 1];
 
 int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
@@ -30,6 +31,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a17d7eaeb001..699c34b9b03c 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -723,6 +723,12 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
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
index 43742ac5b00d..91bf3ecc5f1d 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -173,6 +173,16 @@ enum {
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
 };
 
+enum {
+	NETDEV_A_DMABUF_IFINDEX = 1,
+	NETDEV_A_DMABUF_QUEUES,
+	NETDEV_A_DMABUF_FD,
+	NETDEV_A_DMABUF_ID,
+
+	__NETDEV_A_DMABUF_MAX,
+	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
@@ -186,6 +196,7 @@ enum {
 	NETDEV_CMD_QUEUE_GET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
+	NETDEV_CMD_BIND_RX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.46.0.469.g59c65b2a67-goog


