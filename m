Return-Path: <linux-arch+bounces-6353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA9957D58
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 08:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3331C23149
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 06:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE1161311;
	Tue, 20 Aug 2024 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSyOJaZY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649F159565
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133906; cv=none; b=GGn16Ci0j0n2G6ngUeyDkpqdUXjLBOxWNuKSs0JZ/bjvEXCDZ8du7186F5bq32itCRG+jSgLlqg1ZasZAWXkL5tIy52uOLNXs8Ium7Luz14gi4LMGPF4VwQcZChCAorivGYXApbcDXeGpEHHFHV+Ui0ItcWFwS0NgANYgGMwDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133906; c=relaxed/simple;
	bh=Pl4h61R4IBDP7FfAd4qRKvoQODEVYXgtnDl3/27H3qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLqtOoZGMR7PYJMqGoC+s2ucYxX7ufyM7pbTtyROYv8myVquoyGcCLOQ3fY8pVmL+vJpL7BZHGkps+ZNfY/gcc6hZnkH0Pw7AkarROQLl+Zk1EpIPU/rsN++GEvYVfK7aTzqlKB+aT3uot1bCir+zO6Ea5ri/ik8fSQMoOZCAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSyOJaZY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b8d96aa5ebso39640787b3.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 23:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724133902; x=1724738702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylptq2yPMnNkBct3hUY+O89Fed9ZwdvTYcqzblefUAs=;
        b=qSyOJaZYb4G/577/f/oTeOuTI+p35dVNVFZjRO1WUNKofSetqdGcoereRWI5wuOWSD
         KHTql4FssoIlJ6to5xZIbUZkTYFJjBbEGWe+Nj/IUtEFGFR1bLTQpE37Za3ZwJyozW1t
         2ozGo5feDeYlI6eQ9z4ItX1DSPKbRr5eDYZnqqdoSrd+Y0gXgDX7QUQr4Iz+dZ5d4AmG
         LYbbv6YnOu2dTwBF17FGp0R6XCbVK3NJoebb12kdaGgGz0GpJaul9GcF1waL7WEwhe91
         4BvgCwRXpfX6uSjhoFOdR/2KUdoa3uMlGb3OvfwKUdoed23LxMebnFi9eHg2eopUVggc
         575Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724133902; x=1724738702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylptq2yPMnNkBct3hUY+O89Fed9ZwdvTYcqzblefUAs=;
        b=DhrPivQQWg8Rbt6P6zvtpwCnmu2TaVXUMuhWO16OizOFaXeu3aAlyWOiGdlUey8kw4
         mF9bDNMzn2U/1g1i0BlihQ9+Y3QZKoSH2iQbinN9i53+4sFcay7bO6Qu07eaN1SDiT9O
         RBlqC5Lipz0qQmUlZot6L5yUPNY34Jt1d2ypR9t6fR2QgduatFtaoz2wywuN8yhL8aim
         uz14C6SX4fF7NXlKEtLpbVXbD2VEZ90Y8OaKyAdSvPQtqZK8vXLJAGBpz8zTykr4vMMr
         RYO8MS22csp958t3PVPFqbR6k4xuLztjAW3Bh/ER4v6lxUKPiW1wiXtbth3/psGU9l26
         W0mg==
X-Forwarded-Encrypted: i=1; AJvYcCX3MZl7mqufJYbWILI5e9GfHu3sXFmnC9ZiI9FX0F1GL6uxYF+2dbxl2Pqd9QWwX40eNOafTm7lC7K6JNhysc1I0vmusyJc3oG27A==
X-Gm-Message-State: AOJu0YxfJAve8MxZhGPfbfwMRBO5iNlvwN5x0vSetWnQCNph6lEmVYu9
	ZilHiWhzX/r1L/Q+6lP3p7y7Wi9VPl8Hi5lcofb3RSEDr6T8VmPK75G3obK1RY6XX8zL3keQ4wE
	Cj9bYWjLNk5Eayz9yTOurXg==
X-Google-Smtp-Source: AGHT+IFsiQkXqqDxiY7lT1YVsVNrpTCyM3cmeuEv2PxAg7SaVnRNUOQqWV3MQoDzZ+aLkID9xoKputp8sYhujLRgpw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:4988:b0:62c:ea0b:a447 with
 SMTP id 00721157ae682-6b1b749fc3cmr10181847b3.2.1724133901629; Mon, 19 Aug
 2024 23:05:01 -0700 (PDT)
Date: Tue, 20 Aug 2024 06:04:45 +0000
In-Reply-To: <20240820060456.1485518-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240820060456.1485518-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820060456.1485518-3-almasrymina@google.com>
Subject: [PATCH net-next v21 02/13] net: netdev netlink api to bind dma-buf to
 a net device
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"

API takes the dma-buf fd as input, and binds it to the netdevice. The
user can specify the rx queues to bind the dma-buf to.

Suggested-by: Stanislav Fomichev <sdf@google.com>
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
index 05f9515d2c05..2d726e65211d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -721,6 +721,12 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
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
2.46.0.184.g6999bdac58-goog


