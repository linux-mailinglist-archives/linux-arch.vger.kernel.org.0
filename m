Return-Path: <linux-arch+bounces-5125-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4194491716D
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 21:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BF11C24F7B
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC3C17E44C;
	Tue, 25 Jun 2024 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psoAJjzz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589717D888
	for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2024 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345259; cv=none; b=mANXQBuJUAi+FiXI9X0FilTtwgfetUc/B+9+kDx/DirUTZwdAQNyVJEtmvZ9n3k4cV/bkAdV2Po3yxQCi5sAbdo4K9XUXMePb+/a/XXCNBc5YZypd30brKG/a+7K4pALYcVD6wDlq2qklWqoWIMFR/E1KDpWm/ND2MypCBkc00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345259; c=relaxed/simple;
	bh=qrKgsOxsj14mh4kFR7vc7khxOXoTDA/et/wvCAqykI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H/f/wvUGUi6atQi5gr9dIsEd8GVDa8GNwE8ezdmowtEGDUtsa8BjL8AeAHAXgHMvszAdgqXKdLnM70WGpe1Leo3QmOWTsQ4YCj8A5dK5S1IDw+7IoMJ3U2/k5+9jngcKYcnSRyF+KcvXzBBKwRQQShjxF5dgVJX6KCvCoKRPPUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psoAJjzz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02ba91b9f4so7704907276.1
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2024 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719345254; x=1719950054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSycXNjtP05nwGzlXIcSY1a4rPHqhpiA5ou9ei1qli8=;
        b=psoAJjzzzR7kVbEyuvFXFZw5UZq5P8MHA+OFCVmuh9Nz6QWbLis0AgyyL5uV4sH9Ez
         Cdu0MVds1pJBy+Ds5ndN5ug1O9OknIcFJSNhVLHrdO86+qyBDzLL3VpTFxkbvok4lSJq
         YI5LyyJDZz+TxP5zPMLdYURU+YA7KuGvN8VRRso27HXm/vIAPmomOFiEUXTCHGnQNUSt
         +jfP1ov7Nb+IJQZ3EF/CAOsTtZAo2nMTuSu5juOpNWyYTYVb2YNPbXu2Y5vtl6S8VyZn
         wUmPBgTuXHsWaTbCV5pg/jko8DM0wbJdvQZR5PeVy+81ZtE9RgolTzHxTVHa15VsgFZy
         HiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345254; x=1719950054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSycXNjtP05nwGzlXIcSY1a4rPHqhpiA5ou9ei1qli8=;
        b=eDRXgSXswN1v4qcRZT5eVLLt5umvQd2pEPVuVkseKrdsqjuJM3LnVwITKx7Z/hgi9n
         OxKxV5kaF9t1EIfkn2adq7yrmSIgx76OcwzoELr3UWP+nO8Pw5BkTVb7T1Culz2+gjR4
         rAbnFWJeDKXnN5ta5QxrQDilIyMhRCO111i8BIEWdjh0UmRkCEZQF25+cyHiMhByzJNe
         jz80x8R3nMxeHAXk2ThPetKQpHpTrGKmLo0gYUQ3y5Gx5OzWmtP2PnV4SSagiZC+FFBA
         4AE44s3kTZREfaebC/ZuPCQnYl226zFgJavpUpGMXVnGHjBqvPOsX7RmgIM913Vsgxeg
         RSzg==
X-Forwarded-Encrypted: i=1; AJvYcCXB+bQ4RkmV6tjG9STNLFdxDR0RBgQB0VpnJpFIBb2WCKJN/s5h/MS0TXehBo/c/hCIdF1/9wtbHczxow6kG9GUMFvSgpbbzXqIzg==
X-Gm-Message-State: AOJu0Yy9LMz20j6rPkNcLixP2ogP08BzHqD7AgQ20W8+WDmx5Mv1VhUS
	X/0EYc0caWC2fcTTDXS0LLYq8Nj4FhALhPZ3W5WSmSQkdQha0LAMu6KDAD81a/QNW8gknaQdMvU
	xTZKqn+dyVQzNge+Qahxbiw==
X-Google-Smtp-Source: AGHT+IFFoho5v61+D/e+OFYz5NKbjGxOKJ9BqeDa5WjyXWdH/rOBeJroi1UKxZFQvtqBIKokcCfuJ9X7EPu9MXp2zg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1106:b0:dff:36b3:5c1b with
 SMTP id 3f1490d57ef6-e02fa3ed485mr641700276.6.1719345254403; Tue, 25 Jun 2024
 12:54:14 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:53:50 +0000
In-Reply-To: <20240625195407.1922912-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625195407.1922912-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625195407.1922912-3-almasrymina@google.com>
Subject: [PATCH net-next v14 02/13] net: netdev netlink api to bind dma-buf to
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
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
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
index 959755be4d7f9..899ac0882a098 100644
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
@@ -579,6 +618,20 @@ operations:
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
index 43742ac5b00da..190a504a62358 100644
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
@@ -184,6 +202,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
 	NETDEV_CMD_PAGE_POOL_STATS_GET,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8350a0afa9ec7..9acd0d893765a 100644
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
@@ -130,6 +142,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
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
index 4db40fd5b4a9e..ca5a0983f2834 100644
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
index 05f9515d2c05c..2d726e65211dd 100644
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
index 43742ac5b00da..190a504a62358 100644
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
@@ -184,6 +202,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
 	NETDEV_CMD_PAGE_POOL_STATS_GET,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 
-- 
2.45.2.741.gdbec12cfda-goog


