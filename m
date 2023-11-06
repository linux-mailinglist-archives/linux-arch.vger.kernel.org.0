Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7DD7E18B5
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjKFCoa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjKFCo3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:44:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDB9191
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03390793fso4609967276.3
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238665; x=1699843465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=myyimfrqgp1IZWG/ujCwmnkNglmXYrRvMz92cYVRHqQ=;
        b=Pm9R3xL6bn9UQe2wumfaDV9vJnA5rdu7IRShE1NvhDHl/1ZeblbkO6Z+hOfYIoJ/PN
         IV+7AjyubuXQOJ7ZOVo8SnCEFRppgWULsAd8QtEhI8bdd233GmwL4U3jcFX0A30H+KUF
         7Px/ZGnSNXxdiJPTHeGa3Wh8jHPl4IL6gCRBwbgcmeKQfg+9kiNzbkIoNrx/yAeQGdrF
         7DTryPhfGvrAUua8viYVq8L/rrLWH+TILrvs3LzKKwSyRsfTEAD/ZWA7jJgg7302Stjs
         lTRNsftAFdpxIuaXKnVKvmeMHVMHz8M+x3Mh9I2jTzMxvkErQaeHRNs7dLvBp6ujiJjG
         00nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238665; x=1699843465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myyimfrqgp1IZWG/ujCwmnkNglmXYrRvMz92cYVRHqQ=;
        b=H6MqipwHRx/HRWv35VUp3AHQVNzKjyB06+UU5GROSfhxvWxlffvBlJZ78vpkQgZXTG
         KIFQq1aZ08Cdkcvp0xPLSt4uMZvBGJAnhBfqpIh01V9zS3j8M7QUnAJhyABTXf6ioA62
         hZI1S0IifogpFsBjHk+iADkU/JRYxLQgI+UEr712dmSpkQS36+1fUOEz6JJamWVfeYED
         wl0jAF/Q5bX7kpJgMIH3L87nTh8V65MzJLTAl7DTv2/KDKobgT3TT0XJznCKWk9+5Ltp
         y6bBw4E0PDcIcjdY0dnhfEtf2A/dTHAzwR9u/fEhlkMAe5h3cTadwKLwKkb5LgIdoR54
         RYqQ==
X-Gm-Message-State: AOJu0YwH+fmB2BF261BdIZfrrvxY4lxZsZ20WX6EyRFgw0dzJ40DZgY3
        xM1hD7ZFaNyJF1a560FOkQrB+b3byNQBI3bFmA==
X-Google-Smtp-Source: AGHT+IGWp48Z8KmELXQxvxVV5DLFXiq5qCBokj5aX+KpMHAL69lZpLvJunFDekA59GS1FqFlT9Q2Vt+r+UX/F4+7uQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:db11:0:b0:d9a:47ea:69a5 with SMTP
 id g17-20020a25db11000000b00d9a47ea69a5mr527645ybf.1.1699238664884; Sun, 05
 Nov 2023 18:44:24 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:44:02 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-4-almasrymina@google.com>
Subject: [RFC PATCH v3 03/12] net: netdev netlink api to bind dma-buf to a net device
From:   Mina Almasry <almasrymina@google.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Cc:     Mina Almasry <almasrymina@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

API takes the dma-buf fd as input, and binds it to the netdevice. The
user can specify the rx queues to bind the dma-buf to.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v3:
- Support binding multiple rx rx-queues

---
 Documentation/netlink/specs/netdev.yaml | 28 +++++++++++++++
 include/uapi/linux/netdev.h             | 10 ++++++
 net/core/netdev-genl-gen.c              | 14 ++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  6 ++++
 tools/include/uapi/linux/netdev.h       | 10 ++++++
 tools/net/ynl/generated/netdev-user.c   | 42 ++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h   | 47 +++++++++++++++++++++++++
 8 files changed, 158 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 14511b13f305..2141c5f5c33e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -86,6 +86,24 @@ attribute-sets:
              See Documentation/networking/xdp-rx-metadata.rst for more details.
         type: u64
         enum: xdp-rx-metadata
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
+        type: u32
+        multi-attr: true
+      -
+        name: dmabuf-fd
+        doc: dmabuf file descriptor to bind.
+        type: u32
 
 operations:
   list:
@@ -120,6 +138,16 @@ operations:
       doc: Notification about device configuration being changed.
       notify: dev-get
       mcgrp: mgmt
+    -
+      name: bind-rx
+      doc: Bind dmabuf to netdev
+      attribute-set: bind-dmabuf
+      do:
+        request:
+          attributes:
+            - ifindex
+            - dmabuf-fd
+            - queues
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 2943a151d4f1..2cd367c498c7 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -64,11 +64,21 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_BIND_DMABUF_IFINDEX = 1,
+	NETDEV_A_BIND_DMABUF_QUEUES,
+	NETDEV_A_BIND_DMABUF_DMABUF_FD,
+
+	__NETDEV_A_BIND_DMABUF_MAX,
+	NETDEV_A_BIND_DMABUF_MAX = (__NETDEV_A_BIND_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_BIND_RX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index ea9231378aa6..58300efaf4e5 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -15,6 +15,13 @@ static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_BIND_RX - do */
+static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_BIND_DMABUF_DMABUF_FD + 1] = {
+	[NETDEV_A_BIND_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_BIND_DMABUF_DMABUF_FD] = { .type = NLA_U32, },
+	[NETDEV_A_BIND_DMABUF_QUEUES] = { .type = NLA_U32, },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -29,6 +36,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.dumpit	= netdev_nl_dev_get_dumpit,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_RX,
+		.doit		= netdev_nl_bind_rx_doit,
+		.policy		= netdev_bind_rx_nl_policy,
+		.maxattr	= NETDEV_A_BIND_DMABUF_DMABUF_FD,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 7b370c073e7d..5aaeb435ec08 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -13,6 +13,7 @@
 
 int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fe61f85bcf33..59d3d512d9cc 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -129,6 +129,12 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
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
index 2943a151d4f1..2cd367c498c7 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -64,11 +64,21 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_BIND_DMABUF_IFINDEX = 1,
+	NETDEV_A_BIND_DMABUF_QUEUES,
+	NETDEV_A_BIND_DMABUF_DMABUF_FD,
+
+	__NETDEV_A_BIND_DMABUF_MAX,
+	NETDEV_A_BIND_DMABUF_MAX = (__NETDEV_A_BIND_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_BIND_RX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index b5ffe8cd1144..d5f4c6d4c2b2 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -18,6 +18,7 @@ static const char * const netdev_op_strmap[] = {
 	[NETDEV_CMD_DEV_ADD_NTF] = "dev-add-ntf",
 	[NETDEV_CMD_DEV_DEL_NTF] = "dev-del-ntf",
 	[NETDEV_CMD_DEV_CHANGE_NTF] = "dev-change-ntf",
+	[NETDEV_CMD_BIND_RX] = "bind-rx",
 };
 
 const char *netdev_op_str(int op)
@@ -72,6 +73,17 @@ struct ynl_policy_nest netdev_dev_nest = {
 	.table = netdev_dev_policy,
 };
 
+struct ynl_policy_attr netdev_bind_dmabuf_policy[NETDEV_A_BIND_DMABUF_MAX + 1] = {
+	[NETDEV_A_BIND_DMABUF_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+	[NETDEV_A_BIND_DMABUF_QUEUES] = { .name = "queues", .type = YNL_PT_U32, },
+	[NETDEV_A_BIND_DMABUF_DMABUF_FD] = { .name = "dmabuf-fd", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest netdev_bind_dmabuf_nest = {
+	.max_attr = NETDEV_A_BIND_DMABUF_MAX,
+	.table = netdev_bind_dmabuf_policy,
+};
+
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
 /* NETDEV_CMD_DEV_GET - do */
@@ -197,6 +209,36 @@ void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp)
 	free(rsp);
 }
 
+/* ============== NETDEV_CMD_BIND_RX ============== */
+/* NETDEV_CMD_BIND_RX - do */
+void netdev_bind_rx_req_free(struct netdev_bind_rx_req *req)
+{
+	free(req->queues);
+	free(req);
+}
+
+int netdev_bind_rx(struct ynl_sock *ys, struct netdev_bind_rx_req *req)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NETDEV_CMD_BIND_RX, 1);
+	ys->req_policy = &netdev_bind_dmabuf_nest;
+
+	if (req->_present.ifindex)
+		mnl_attr_put_u32(nlh, NETDEV_A_BIND_DMABUF_IFINDEX, req->ifindex);
+	if (req->_present.dmabuf_fd)
+		mnl_attr_put_u32(nlh, NETDEV_A_BIND_DMABUF_DMABUF_FD, req->dmabuf_fd);
+	for (unsigned int i = 0; i < req->n_queues; i++)
+		mnl_attr_put_u32(nlh, NETDEV_A_BIND_DMABUF_QUEUES, req->queues[i]);
+
+	err = ynl_exec(ys, nlh, NULL);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
 static const struct ynl_ntf_info netdev_ntf_info[] =  {
 	[NETDEV_CMD_DEV_ADD_NTF] =  {
 		.alloc_sz	= sizeof(struct netdev_dev_get_ntf),
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 4fafac879df3..3cf9096d733a 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -87,4 +87,51 @@ struct netdev_dev_get_ntf {
 
 void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
 
+/* ============== NETDEV_CMD_BIND_RX ============== */
+/* NETDEV_CMD_BIND_RX - do */
+struct netdev_bind_rx_req {
+	struct {
+		__u32 ifindex:1;
+		__u32 dmabuf_fd:1;
+	} _present;
+
+	__u32 ifindex;
+	__u32 dmabuf_fd;
+	unsigned int n_queues;
+	__u32 *queues;
+};
+
+static inline struct netdev_bind_rx_req *netdev_bind_rx_req_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_bind_rx_req));
+}
+void netdev_bind_rx_req_free(struct netdev_bind_rx_req *req);
+
+static inline void
+netdev_bind_rx_req_set_ifindex(struct netdev_bind_rx_req *req, __u32 ifindex)
+{
+	req->_present.ifindex = 1;
+	req->ifindex = ifindex;
+}
+static inline void
+netdev_bind_rx_req_set_dmabuf_fd(struct netdev_bind_rx_req *req,
+				 __u32 dmabuf_fd)
+{
+	req->_present.dmabuf_fd = 1;
+	req->dmabuf_fd = dmabuf_fd;
+}
+static inline void
+__netdev_bind_rx_req_set_queues(struct netdev_bind_rx_req *req, __u32 *queues,
+				unsigned int n_queues)
+{
+	free(req->queues);
+	req->queues = queues;
+	req->n_queues = n_queues;
+}
+
+/*
+ * Bind dmabuf to netdev
+ */
+int netdev_bind_rx(struct ynl_sock *ys, struct netdev_bind_rx_req *req);
+
 #endif /* _LINUX_NETDEV_GEN_H */
-- 
2.42.0.869.gea05f2083d-goog

