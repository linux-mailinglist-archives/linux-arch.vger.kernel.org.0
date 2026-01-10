Return-Path: <linux-arch+bounces-15736-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B53E8D0CD25
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 03:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA7A30843B2
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B921FE47B;
	Sat, 10 Jan 2026 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEcwGwAc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244624A046
	for <linux-arch@vger.kernel.org>; Sat, 10 Jan 2026 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011548; cv=none; b=sljq5e/WMMBB/4okY7seTnnq/N+0/ftkQ3IMO5IPor1MK7o/mifrnhAx+AwxhZrRsg4Zw/YUJuhxLx3fAMe9kSQHxeHG6sUCxMs5Wok5JMlYA8kEnXCTizA+jtlrC7OvpoZtEQMLG8Naghni1es/gokXlHBNkmRlV7g2D67qNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011548; c=relaxed/simple;
	bh=P4d8UqC2nKeC0YQ+a7bgME0cFVqMsz/ydYLiYy8NQ78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNSbzRK/tbaJcJ1pgR1wYdJ77l0BHbw815xSO0Y6b6MnCwxihcH3+P3P71vJj3TigjzO9dtCd/n+D63WObX58XwfeaQvxqZtXcgDVHFAzLsLg/+LknZUtjHLnSKpBy0+/SJpS5YKpKuqU9GhQeAq2DLYDl8JKsiY1yi6qUBWAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEcwGwAc; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-790647da8cbso54781597b3.1
        for <linux-arch@vger.kernel.org>; Fri, 09 Jan 2026 18:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768011543; x=1768616343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arzqbQXlNacdWL74Y2JXdnYTGjM1CMB+bcw7bQGNPJc=;
        b=IEcwGwAcy8SpujoBI6ZYumo5RItcS6LNZu5t0C6aTPGy5eaXbLkKV6RHUzCG2G2zYO
         E+lH83d4Tm58KORcQxVsibd+RgtAYzOMgqhu4763xmcbSMug6kXkqV7ogKaV+g4XD1Fl
         ugDmup+chut6/Q2SsY7QiZwVk/TRzryyDk3btP57Y/SAiOmRjZ/DmJ6XxiAElpDFvkuH
         DCZDliHbfti6NX+WZ2iAbZjj39hm/qheGQGMEOcS9dy4SjzQOBB9wYsOrjJQNY0NhNE2
         60N73RSCbERvMRCR6UdMq8jD368cB9xqfLfEK/0wSma87Rh3kIPiRAnfuMMaZ6dArLoG
         3XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768011543; x=1768616343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=arzqbQXlNacdWL74Y2JXdnYTGjM1CMB+bcw7bQGNPJc=;
        b=kwRNUq9x4lOyp4oAl8lQocg/Qgbp2bfOU/3kBMZAVL758nwpgp/KRmMeCoYr6oJmlU
         L2r3XMXLbhIMUs5sZCZnOmg9IBShRth63u/TD0i1R3/KReFBj47uNFqyffLP7SJuEnsJ
         9Mi5AEIBvZSSeIwgghScQeyY+WZIRupBYG0xRD7SxK5L6ZMwo7Bg5SKJHWpgmZ7K4Qrm
         eeZfAyCSDVtDYEiPOtFanTzrqOMcH+HKs7n5xGBXOvM7UEMrmpjNGldgkb1h+FoXyBAO
         ymEI0BJAIsO9d1KwtiQEMjJq6K1XEPw0+rjXW6y5vw7YLIXg1PucENqObxC9JarUuYZB
         c1ig==
X-Forwarded-Encrypted: i=1; AJvYcCWND12daX+11LIridaOG+g5s5kDZhSFRxFg/nqLsa1ENu3S9v+8E+kV/z8DP7lF2pU78RmTbF74fg4B@vger.kernel.org
X-Gm-Message-State: AOJu0YyipUbaFqVLP81nw6NXPd3A04FgztvA3HwfeWqKQoIhbBO7lD0X
	A83L0McQS5fPE1lKFVDDYmG9EC7umBD/nF8kAFubm1TXcLbMCavzCEbh
X-Gm-Gg: AY/fxX5Zt4pUG2ktMoXYtsHdOm/0P/qqKwn78ds/rrTPrtImDbqWEQGTMebyxLEgg9A
	BpC1v7IzYDHe3ZCOFHPkgQCSLX/XUQnI75nF0v/z88Ti8XUH6X8lThlAZ8GZ3y7SwQdggdKUpap
	ndrzeSGesWRxOjEdvDGKxhDFf5VSxwa1nerAlFq/tkVLFEeoRPCLUlcND0ItSk8TiwTSQqhSbIV
	3Tq1V67i5Hm7LOFpTzkI/sBBSiim9CkHYaHiP5g8h5VPrLOfaA8MhQp2/xgDjDoz9HWzhHu+RDv
	wvC4UVRxrhDMqp8jL1cSumkunWUkJCKA3SOXy1b7Q8Qu3z3usPqk+FXwbOdMhxNhpfcvPkufM/M
	FscmRSqBQb6FLMrwsWRo/DDhiLlDiont8rKR//5j8MrMq0UcWt7c4i46OLkO3oPyfOMOAPsshrT
	kYzGSdYiWbaA==
X-Google-Smtp-Source: AGHT+IHLsLyVl2pa2JrSVd4sJ2IpcPmz1uN7KAItpcWVK3gHr7UzOLhB8xFQ0R4gUz+9ez73pmt2tA==
X-Received: by 2002:a05:690e:11cb:b0:63f:b444:da92 with SMTP id 956f58d0204a3-64716b1f9e3mr10153697d50.31.1768011542884;
        Fri, 09 Jan 2026 18:19:02 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d4c9sm5232466d50.14.2026.01.09.18.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:19:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 09 Jan 2026 18:18:17 -0800
Subject: [PATCH net-next v9 3/5] net: devmem: implement autorelease token
 management
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
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

Add support for autorelease toggling of tokens using a static branch to
control system-wide behavior. This allows applications to choose between
two memory management modes:

1. Autorelease on: Leaked tokens are automatically released when the
   socket closes.

2. Autorelease off: Leaked tokens are released during dmabuf unbind.

The autorelease mode is requested via the NETDEV_A_DMABUF_AUTORELEASE
attribute of the NETDEV_CMD_BIND_RX message. Having separate modes per
binding is disallowed and is rejected by netlink. The system will be
"locked" into the mode that the first binding is set to. It can only be
changed again once there are zero bindings on the system.

Disabling autorelease offers ~13% improvement in CPU utilization.

Static branching is used to limit the system to one mode or the other.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v9:
- Add missing stub for net_devmem_dmabuf_binding_get() when NET_DEVMEM=n
- Add wrapper around tcp_devmem_ar_key accesses so that it may be
  stubbed out when NET_DEVMEM=n
- only dec rx binding count for rx bindings in free (v8 did not exclude
  TX bindings)

Changes in v8:
- Only reset static key when bindings go to zero, defaulting back to
  disabled (Stan).
- Fix bad usage of xarray spinlock for sleepy static branch switching,
  use mutex instead.
- Access pp_ref_count via niov->desc instead of niov directly.
- Move reset of static key to __net_devmem_dmabuf_binding_free() so that
  the static key can not be changed while there are outstanding tokens
  (free is only called when reference count reaches zero).
- Add net_devmem_dmabuf_rx_bindings_count because tokens may be active
  even after xa_erase(), so static key changes must wait until all
  RX bindings are finally freed (not just when xarray is empty). A
  counter is a simple way to track this.
- socket takes reference on the binding, to avoid use-after-free on
  sk_devmem_info.binding in the case that user releases all tokens,
  unbinds, then issues SO_DEVMEM_DONTNEED again (with bad token).
- removed some comments that were unnecessary

Changes in v7:
- implement autorelease with static branch (Stan)
- use netlink instead of sockopt (Stan)
- merge uAPI and implementation patches into one patch (seemed less
  confusing)

Changes in v6:
- remove sk_devmem_info.autorelease, using binding->autorelease instead
- move binding->autorelease check to outside of
  net_devmem_dmabuf_binding_put_urefs() (Mina)
- remove overly defensive net_is_devmem_iov() (Mina)
- add comment about multiple urefs mapping to a single netmem ref (Mina)
- remove overly defense netmem NULL and netmem_is_net_iov checks (Mina)
- use niov without casting back and forth with netmem (Mina)
- move the autorelease flag from per-binding to per-socket (Mina)
- remove the batching logic in sock_devmem_dontneed_manual_release()
  (Mina)
- move autorelease check inside tcp_xa_pool_commit() (Mina)
- remove single-binding restriction for autorelease mode (Mina)
- unbind always checks for leaked urefs

Changes in v5:
- remove unused variables
- introduce autorelease flag, preparing for future patch toggle new
  behavior

Changes in v3:
- make urefs per-binding instead of per-socket, reducing memory
  footprint
- fallback to cleaning up references in dmabuf unbind if socket leaked
  tokens
- drop ethtool patch

Changes in v2:
- always use GFP_ZERO for binding->vec (Mina)
- remove WARN for changed binding (Mina)
- remove extraneous binding ref get (Mina)
- remove WARNs on invalid user input (Mina)
- pre-assign niovs in binding->vec for RX case (Mina)
- use atomic_set(, 0) to initialize sk_user_frags.urefs
- fix length of alloc for urefs
---
 Documentation/netlink/specs/netdev.yaml |  12 ++++
 include/net/netmem.h                    |   1 +
 include/net/sock.h                      |   7 ++-
 include/uapi/linux/netdev.h             |   1 +
 net/core/devmem.c                       | 104 ++++++++++++++++++++++++++++----
 net/core/devmem.h                       |  27 ++++++++-
 net/core/netdev-genl-gen.c              |   5 +-
 net/core/netdev-genl.c                  |  10 ++-
 net/core/sock.c                         |  57 +++++++++++++++--
 net/ipv4/tcp.c                          |  76 ++++++++++++++++++-----
 net/ipv4/tcp_ipv4.c                     |  11 +++-
 net/ipv4/tcp_minisocks.c                |   3 +-
 tools/include/uapi/linux/netdev.h       |   1 +
 13 files changed, 269 insertions(+), 46 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 596c306ce52b..7cbe9e7b9ee5 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -562,6 +562,17 @@ attribute-sets:
         type: u32
         checks:
           min: 1
+      -
+        name: autorelease
+        doc: |
+          Token autorelease mode. If true (1), leaked tokens are automatically
+          released when the socket closes. If false (0), leaked tokens are only
+          released when the dmabuf is unbound. Once a binding is created with a
+          specific mode, all subsequent bindings system-wide must use the same
+          mode.
+
+          Optional. Defaults to false if not specified.
+        type: u8
 
 operations:
   list:
@@ -769,6 +780,7 @@ operations:
             - ifindex
             - fd
             - queues
+            - autorelease
         reply:
           attributes:
             - id
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 9e10f4ac50c3..80d2263ba4ed 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -112,6 +112,7 @@ struct net_iov {
 	};
 	struct net_iov_area *owner;
 	enum net_iov_type type;
+	atomic_t uref;
 };
 
 struct net_iov_area {
diff --git a/include/net/sock.h b/include/net/sock.h
index aafe8bdb2c0f..9d3d5bde15e9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -352,7 +352,7 @@ struct sk_filter;
   *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
   *	@sk_scm_unused: unused flags for scm_recv()
   *	@ns_tracker: tracker for netns reference
-  *	@sk_user_frags: xarray of pages the user is holding a reference on.
+  *	@sk_devmem_info: the devmem binding information for the socket
   *	@sk_owner: reference to the real owner of the socket that calls
   *		   sock_lock_init_class_and_name().
   */
@@ -584,7 +584,10 @@ struct sock {
 	struct numa_drop_counters *sk_drop_counters;
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
-	struct xarray		sk_user_frags;
+	struct {
+		struct xarray				frags;
+		struct net_devmem_dmabuf_binding	*binding;
+	} sk_devmem_info;
 
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 	struct module		*sk_owner;
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e0b579a1df4f..1e5c209cb998 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -207,6 +207,7 @@ enum {
 	NETDEV_A_DMABUF_QUEUES,
 	NETDEV_A_DMABUF_FD,
 	NETDEV_A_DMABUF_ID,
+	NETDEV_A_DMABUF_AUTORELEASE,
 
 	__NETDEV_A_DMABUF_MAX,
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 05a9a9e7abb9..05c16df657c7 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -11,6 +11,7 @@
 #include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
+#include <linux/skbuff_ref.h>
 #include <linux/types.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
@@ -28,6 +29,19 @@
 
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
+/* If the user unbinds before releasing all tokens, the static key must not
+ * change until all tokens have been released (to avoid calling the wrong
+ * SO_DEVMEM_DONTNEED handler). We prevent this by making static key changes
+ * and binding alloc/free atomic with regards to each other, using the
+ * devmem_ar_lock. This works because binding free does not occur until all of
+ * the outstanding token's references on the binding are dropped.
+ */
+static DEFINE_MUTEX(devmem_ar_lock);
+
+DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
+EXPORT_SYMBOL(tcp_devmem_ar_key);
+static int net_devmem_dmabuf_rx_bindings_count;
+
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
 bool net_is_devmem_iov(struct net_iov *niov)
@@ -60,6 +74,14 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 
 	size_t size, avail;
 
+	if (binding->direction == DMA_FROM_DEVICE) {
+		mutex_lock(&devmem_ar_lock);
+		net_devmem_dmabuf_rx_bindings_count--;
+		if (net_devmem_dmabuf_rx_bindings_count == 0)
+			static_branch_disable(&tcp_devmem_ar_key);
+		mutex_unlock(&devmem_ar_lock);
+	}
+
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
 
@@ -116,6 +138,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
 	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
 }
 
+static void
+net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *binding)
+{
+	int i;
+
+	for (i = 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
+		struct net_iov *niov;
+		netmem_ref netmem;
+
+		niov = binding->vec[i];
+		netmem = net_iov_to_netmem(niov);
+
+		/* Multiple urefs map to only a single netmem ref. */
+		if (atomic_xchg(&niov->uref, 0) > 0)
+			WARN_ON_ONCE(!napi_pp_put_page(netmem));
+	}
+}
+
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
 	struct netdev_rx_queue *rxq;
@@ -143,6 +183,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
+	net_devmem_dmabuf_binding_put_urefs(binding);
 	net_devmem_dmabuf_binding_put(binding);
 }
 
@@ -179,8 +220,10 @@ struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
-		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
-		       struct netlink_ext_ack *extack)
+		       unsigned int dmabuf_fd,
+		       struct netdev_nl_sock *priv,
+		       struct netlink_ext_ack *extack,
+		       bool autorelease)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
@@ -231,14 +274,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		goto err_detach;
 	}
 
-	if (direction == DMA_TO_DEVICE) {
-		binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
-					      sizeof(struct net_iov *),
-					      GFP_KERNEL);
-		if (!binding->vec) {
-			err = -ENOMEM;
-			goto err_unmap;
-		}
+	binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+				      sizeof(struct net_iov *),
+				      GFP_KERNEL | __GFP_ZERO);
+	if (!binding->vec) {
+		err = -ENOMEM;
+		goto err_unmap;
 	}
 
 	/* For simplicity we expect to make PAGE_SIZE allocations, but the
@@ -292,25 +333,62 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			niov = &owner->area.niovs[i];
 			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
+			atomic_set(&niov->uref, 0);
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
-			if (direction == DMA_TO_DEVICE)
-				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+			binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
 	}
 
+	mutex_lock(&devmem_ar_lock);
+
+	if (direction == DMA_FROM_DEVICE) {
+		if (net_devmem_dmabuf_rx_bindings_count > 0) {
+			bool mode;
+
+			mode = static_key_enabled(&tcp_devmem_ar_key);
+
+			/* When bindings exist, enforce that the mode does not
+			 * change.
+			 */
+			if (mode != autorelease) {
+				NL_SET_ERR_MSG_FMT(extack,
+						   "System already configured with autorelease=%d",
+						   mode);
+				err = -EINVAL;
+				goto err_unlock_mutex;
+			}
+		} else if (autorelease) {
+			/* First binding with autorelease enabled sets the
+			 * mode.  If autorelease is false, the key is already
+			 * disabled by default so no action is needed.
+			 */
+			static_branch_enable(&tcp_devmem_ar_key);
+		}
+
+		net_devmem_dmabuf_rx_bindings_count++;
+	}
+
 	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
 			      binding, xa_limit_32b, &id_alloc_next,
 			      GFP_KERNEL);
 	if (err < 0)
-		goto err_free_chunks;
+		goto err_dec_binding_count;
+
+	mutex_unlock(&devmem_ar_lock);
 
 	list_add(&binding->list, &priv->bindings);
 
 	return binding;
 
+err_dec_binding_count:
+	if (direction == DMA_FROM_DEVICE)
+		net_devmem_dmabuf_rx_bindings_count--;
+
+err_unlock_mutex:
+	mutex_unlock(&devmem_ar_lock);
 err_free_chunks:
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 1ea6228e4f40..8c586f30e371 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -12,9 +12,13 @@
 
 #include <net/netmem.h>
 #include <net/netdev_netlink.h>
+#include <linux/jump_label.h>
 
 struct netlink_ext_ack;
 
+/* static key for TCP devmem autorelease */
+extern struct static_key_false tcp_devmem_ar_key;
+
 struct net_devmem_dmabuf_binding {
 	struct dma_buf *dmabuf;
 	struct dma_buf_attachment *attachment;
@@ -61,7 +65,7 @@ struct net_devmem_dmabuf_binding {
 
 	/* Array of net_iov pointers for this binding, sorted by virtual
 	 * address. This array is convenient to map the virtual addresses to
-	 * net_iovs in the TX path.
+	 * net_iovs.
 	 */
 	struct net_iov **vec;
 
@@ -88,7 +92,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
-		       struct netlink_ext_ack *extack);
+		       struct netlink_ext_ack *extack, bool autorelease);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
@@ -138,6 +142,11 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 	schedule_work(&binding->unbind_w);
 }
 
+static inline bool net_devmem_autorelease_enabled(void)
+{
+	return static_branch_unlikely(&tcp_devmem_ar_key);
+}
+
 void net_devmem_get_net_iov(struct net_iov *niov);
 void net_devmem_put_net_iov(struct net_iov *niov);
 
@@ -155,6 +164,12 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding, size_t addr,
 #else
 struct net_devmem_dmabuf_binding;
 
+static inline bool
+net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
+{
+	return false;
+}
+
 static inline void
 net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 {
@@ -174,7 +189,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd,
 		       struct netdev_nl_sock *priv,
-		       struct netlink_ext_ack *extack)
+		       struct netlink_ext_ack *extack,
+		       bool autorelease)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -241,6 +257,11 @@ net_devmem_iov_binding(const struct net_iov *niov)
 {
 	return NULL;
 }
+
+static inline bool net_devmem_autorelease_enabled(void)
+{
+	return false;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index ba673e81716f..01b7765e11ec 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -86,10 +86,11 @@ static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE
 };
 
 /* NETDEV_CMD_BIND_RX - do */
-static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1] = {
+static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_AUTORELEASE + 1] = {
 	[NETDEV_A_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
 	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
+	[NETDEV_A_DMABUF_AUTORELEASE] = { .type = NLA_U8, },
 };
 
 /* NETDEV_CMD_NAPI_SET - do */
@@ -188,7 +189,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.cmd		= NETDEV_CMD_BIND_RX,
 		.doit		= netdev_nl_bind_rx_doit,
 		.policy		= netdev_bind_rx_nl_policy,
-		.maxattr	= NETDEV_A_DMABUF_FD,
+		.maxattr	= NETDEV_A_DMABUF_AUTORELEASE,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 470fabbeacd9..c742bb34865e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -939,6 +939,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
 	unsigned long *rxq_bitmap;
+	bool autorelease = false;
 	struct device *dma_dev;
 	struct sk_buff *rsp;
 	int err = 0;
@@ -952,6 +953,10 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
 	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
 
+	if (info->attrs[NETDEV_A_DMABUF_AUTORELEASE])
+		autorelease =
+			!!nla_get_u8(info->attrs[NETDEV_A_DMABUF_AUTORELEASE]);
+
 	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
@@ -1002,7 +1007,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
-					 dmabuf_fd, priv, info->extack);
+					 dmabuf_fd, priv, info->extack,
+					 autorelease);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_rxq_bitmap;
@@ -1097,7 +1103,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 
 	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
-					 dmabuf_fd, priv, info->extack);
+					 dmabuf_fd, priv, info->extack, false);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_netdev;
diff --git a/net/core/sock.c b/net/core/sock.c
index f6526f43aa6e..6355c2ccfb8a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -87,6 +87,7 @@
 
 #include <linux/unaligned.h>
 #include <linux/capability.h>
+#include <linux/dma-buf.h>
 #include <linux/errno.h>
 #include <linux/errqueue.h>
 #include <linux/types.h>
@@ -151,6 +152,7 @@
 #include <uapi/linux/pidfd.h>
 
 #include "dev.h"
+#include "devmem.h"
 
 static DEFINE_MUTEX(proto_list_mutex);
 static LIST_HEAD(proto_list);
@@ -1081,6 +1083,44 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 #define MAX_DONTNEED_TOKENS 128
 #define MAX_DONTNEED_FRAGS 1024
 
+static noinline_for_stack int
+sock_devmem_dontneed_manual_release(struct sock *sk,
+				    struct dmabuf_token *tokens,
+				    unsigned int num_tokens)
+{
+	struct net_iov *niov;
+	unsigned int i, j;
+	netmem_ref netmem;
+	unsigned int token;
+	int num_frags = 0;
+	int ret = 0;
+
+	if (!sk->sk_devmem_info.binding)
+		return -EINVAL;
+
+	for (i = 0; i < num_tokens; i++) {
+		for (j = 0; j < tokens[i].token_count; j++) {
+			size_t size = sk->sk_devmem_info.binding->dmabuf->size;
+
+			token = tokens[i].token_start + j;
+			if (token >= size / PAGE_SIZE)
+				break;
+
+			if (++num_frags > MAX_DONTNEED_FRAGS)
+				return ret;
+
+			niov = sk->sk_devmem_info.binding->vec[token];
+			if (atomic_dec_and_test(&niov->uref)) {
+				netmem = net_iov_to_netmem(niov);
+				WARN_ON_ONCE(!napi_pp_put_page(netmem));
+			}
+			ret++;
+		}
+	}
+
+	return ret;
+}
+
 static noinline_for_stack int
 sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
 				 unsigned int num_tokens)
@@ -1089,32 +1129,33 @@ sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
 	int ret = 0, num_frags = 0;
 	netmem_ref netmems[16];
 
-	xa_lock_bh(&sk->sk_user_frags);
+	xa_lock_bh(&sk->sk_devmem_info.frags);
 	for (i = 0; i < num_tokens; i++) {
 		for (j = 0; j < tokens[i].token_count; j++) {
 			if (++num_frags > MAX_DONTNEED_FRAGS)
 				goto frag_limit_reached;
 
 			netmem_ref netmem = (__force netmem_ref)__xa_erase(
-				&sk->sk_user_frags, tokens[i].token_start + j);
+				&sk->sk_devmem_info.frags,
+				tokens[i].token_start + j);
 
 			if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
 				continue;
 
 			netmems[netmem_num++] = netmem;
 			if (netmem_num == ARRAY_SIZE(netmems)) {
-				xa_unlock_bh(&sk->sk_user_frags);
+				xa_unlock_bh(&sk->sk_devmem_info.frags);
 				for (k = 0; k < netmem_num; k++)
 					WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 				netmem_num = 0;
-				xa_lock_bh(&sk->sk_user_frags);
+				xa_lock_bh(&sk->sk_devmem_info.frags);
 			}
 			ret++;
 		}
 	}
 
 frag_limit_reached:
-	xa_unlock_bh(&sk->sk_user_frags);
+	xa_unlock_bh(&sk->sk_devmem_info.frags);
 	for (k = 0; k < netmem_num; k++)
 		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 
@@ -1145,7 +1186,11 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 		return -EFAULT;
 	}
 
-	ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+	if (net_devmem_autorelease_enabled())
+		ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+	else
+		ret = sock_devmem_dontneed_manual_release(sk, tokens,
+							  num_tokens);
 
 	kvfree(tokens);
 	return ret;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d5319ebe2452..a8a4af552909 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -260,6 +260,7 @@
 #include <linux/memblock.h>
 #include <linux/highmem.h>
 #include <linux/cache.h>
+#include <linux/dma-buf.h>
 #include <linux/err.h>
 #include <linux/time.h>
 #include <linux/slab.h>
@@ -492,7 +493,8 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
-	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
+	xa_init_flags(&sk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
+	sk->sk_devmem_info.binding = NULL;
 }
 EXPORT_IPV6_MOD(tcp_init_sock);
 
@@ -2424,11 +2426,12 @@ static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_pool *p)
 
 	/* Commit part that has been copied to user space. */
 	for (i = 0; i < p->idx; i++)
-		__xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_ENTRY,
-			     (__force void *)p->netmems[i], GFP_KERNEL);
+		__xa_cmpxchg(&sk->sk_devmem_info.frags, p->tokens[i],
+			     XA_ZERO_ENTRY, (__force void *)p->netmems[i],
+			     GFP_KERNEL);
 	/* Rollback what has been pre-allocated and is no longer needed. */
 	for (; i < p->max; i++)
-		__xa_erase(&sk->sk_user_frags, p->tokens[i]);
+		__xa_erase(&sk->sk_devmem_info.frags, p->tokens[i]);
 
 	p->max = 0;
 	p->idx = 0;
@@ -2436,14 +2439,18 @@ static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_pool *p)
 
 static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
 {
+	/* Skip xarray operations if autorelease is disabled (manual mode) */
+	if (!net_devmem_autorelease_enabled())
+		return;
+
 	if (!p->max)
 		return;
 
-	xa_lock_bh(&sk->sk_user_frags);
+	xa_lock_bh(&sk->sk_devmem_info.frags);
 
 	tcp_xa_pool_commit_locked(sk, p);
 
-	xa_unlock_bh(&sk->sk_user_frags);
+	xa_unlock_bh(&sk->sk_devmem_info.frags);
 }
 
 static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
@@ -2454,24 +2461,41 @@ static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
 	if (p->idx < p->max)
 		return 0;
 
-	xa_lock_bh(&sk->sk_user_frags);
+	xa_lock_bh(&sk->sk_devmem_info.frags);
 
 	tcp_xa_pool_commit_locked(sk, p);
 
 	for (k = 0; k < max_frags; k++) {
-		err = __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
+		err = __xa_alloc(&sk->sk_devmem_info.frags, &p->tokens[k],
 				 XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL);
 		if (err)
 			break;
 	}
 
-	xa_unlock_bh(&sk->sk_user_frags);
+	xa_unlock_bh(&sk->sk_devmem_info.frags);
 
 	p->max = k;
 	p->idx = 0;
 	return k ? 0 : err;
 }
 
+static void tcp_xa_pool_inc_pp_ref_count(struct tcp_xa_pool *tcp_xa_pool,
+					 skb_frag_t *frag)
+{
+	struct net_iov *niov;
+
+	niov = skb_frag_net_iov(frag);
+
+	if (net_devmem_autorelease_enabled()) {
+		atomic_long_inc(&niov->desc.pp_ref_count);
+		tcp_xa_pool->netmems[tcp_xa_pool->idx++] =
+			skb_frag_netmem(frag);
+	} else {
+		if (atomic_inc_return(&niov->uref) == 1)
+			atomic_long_inc(&niov->desc.pp_ref_count);
+	}
+}
+
 /* On error, returns the -errno. On success, returns number of bytes sent to the
  * user. May not consume all of @remaining_len.
  */
@@ -2533,6 +2557,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		 * sequence of cmsg
 		 */
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+			struct net_devmem_dmabuf_binding *binding = NULL;
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 			struct net_iov *niov;
 			u64 frag_offset;
@@ -2568,13 +2593,35 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 					      start;
 				dmabuf_cmsg.frag_offset = frag_offset;
 				dmabuf_cmsg.frag_size = copy;
-				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
-							 skb_shinfo(skb)->nr_frags - i);
-				if (err)
+
+				binding = net_devmem_iov_binding(niov);
+
+				if (!sk->sk_devmem_info.binding) {
+					net_devmem_dmabuf_binding_get(binding);
+					sk->sk_devmem_info.binding = binding;
+				}
+
+				if (sk->sk_devmem_info.binding != binding) {
+					err = -EFAULT;
 					goto out;
+				}
+
+				if (net_devmem_autorelease_enabled()) {
+					err = tcp_xa_pool_refill(sk,
+								 &tcp_xa_pool,
+								 skb_shinfo(skb)->nr_frags - i);
+					if (err)
+						goto out;
+
+					dmabuf_cmsg.frag_token =
+						tcp_xa_pool.tokens[tcp_xa_pool.idx];
+				} else {
+					dmabuf_cmsg.frag_token =
+						net_iov_virtual_addr(niov) >> PAGE_SHIFT;
+				}
+
 
 				/* Will perform the exchange later */
-				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
 				dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
 
 				offset += copy;
@@ -2587,8 +2634,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->desc.pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+				tcp_xa_pool_inc_pp_ref_count(&tcp_xa_pool, frag);
 
 				sent += copy;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f8a9596e8f4d..7b1b5a17002f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -89,6 +89,9 @@
 
 #include <crypto/md5.h>
 
+#include <linux/dma-buf.h>
+#include "../core/devmem.h"
+
 #include <trace/events/tcp.h>
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -2492,7 +2495,7 @@ static void tcp_release_user_frags(struct sock *sk)
 	unsigned long index;
 	void *netmem;
 
-	xa_for_each(&sk->sk_user_frags, index, netmem)
+	xa_for_each(&sk->sk_devmem_info.frags, index, netmem)
 		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem));
 #endif
 }
@@ -2503,7 +2506,11 @@ void tcp_v4_destroy_sock(struct sock *sk)
 
 	tcp_release_user_frags(sk);
 
-	xa_destroy(&sk->sk_user_frags);
+	xa_destroy(&sk->sk_devmem_info.frags);
+	if (sk->sk_devmem_info.binding) {
+		net_devmem_dmabuf_binding_put(sk->sk_devmem_info.binding);
+		sk->sk_devmem_info.binding = NULL;
+	}
 
 	trace_tcp_destroy_sock(sk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd5462154f97..2aec977f5c12 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -662,7 +662,8 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
 
-	xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
+	xa_init_flags(&newsk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
+	newsk->sk_devmem_info.binding = NULL;
 
 	return newsk;
 }
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e0b579a1df4f..1e5c209cb998 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -207,6 +207,7 @@ enum {
 	NETDEV_A_DMABUF_QUEUES,
 	NETDEV_A_DMABUF_FD,
 	NETDEV_A_DMABUF_ID,
+	NETDEV_A_DMABUF_AUTORELEASE,
 
 	__NETDEV_A_DMABUF_MAX,
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)

-- 
2.47.3


