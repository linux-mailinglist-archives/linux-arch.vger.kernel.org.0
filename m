Return-Path: <linux-arch+bounces-14976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC6C72046
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 04:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DC1534D0FC
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 03:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFCE3043BF;
	Thu, 20 Nov 2025 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRSwAeEm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5C1CEADB
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609838; cv=none; b=TuiBLbLicaqV1SLJIxSDODcMVM47LosXQOr5kwvP1KYK5NyMn3o5t0wdhlvuU4jzVdos80qxBBorboH6Wau+mNOTy+fsFiWpM/mZleq/p+2iFv7pSn3/eJnfDF02x1J6Zz5YJPNfvp/jDpFWpROFHuAKg9AtooWGh3ADyiiECwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609838; c=relaxed/simple;
	bh=vxB8S1FZQSfGZXaNzpx1kiwtceVGQ0Ep5vIJSMeFQeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhKAN8gjkIJKFYBT7kAlRvbQlu8vg9KfiAYklLOwd2tk+XgSw7UaTKwOlOefihqlgsdE1iJURYrP8tZ7yj0dOBpqb5VyNAsBDUcXAlLbpAU/jS6fao+k1pMs4V2XocYIezQqxH221Mhf5JBFi5mBHabD0NagaWaX6swzVxJQUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRSwAeEm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-786635a8ce4so3672417b3.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 19:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763609834; x=1764214634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4e9rqZc0SkOIbNN+4QKzR0fy1wKkUXfCc1ZVSCdFrg=;
        b=TRSwAeEmGkQEbj+jZRAT7vGao5YxQ5A6hrRSYzCf/mOF4zDX37uwMPfeAjGX/RFK0c
         nUuyk+7rPn7vduWhl9qhJeHe6D3QmxC03FlVwJE4sYdC+Ba7DZKaiSBTlcGsxEPX3a9u
         UsHqH30haTsGr07SRNtC7HkwCvOQWULnnC71cyY4jGVzFF61KQH85bPmdx8A63E1RTd5
         KNXi0PuTXlmYnYoM/wUTeRj1hNCcAE6wj0EnCudJf9JqNWSVlLI08V18o9WXVzJq9niO
         bVPScmn37uUYB2q36gex7JnNIZnQBDDONpqjrAV5jLDrjXr+UwKSN39f62RWwbJbj2aC
         WL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609834; x=1764214634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E4e9rqZc0SkOIbNN+4QKzR0fy1wKkUXfCc1ZVSCdFrg=;
        b=Dok9V//E+17ei7FmpO8ov42G8RmgUqotFRENRnnwZxjwezkpTrpndlGEbThFatRvOo
         GV1SmG50bwv9IomJvfx/OdEKHzvRVed3Z0qF45lRKsdyz+zdTIUtYLEDcikiUZayfF2V
         1/2RgpNmwQGhMaMWFrFB7KdZhHaNzIFsHSZnsmy7D5udNww2SWwn7o5YtdNW1KnB6NEE
         N+Cy17/DVZhWbDKjl3ptaf96Yiw7YXcP4Q+ArExNKFUe1QE+MDSFPavXeodBx5Sc3v1U
         Ck23utTI0eiiEL31/gQCIxbYvQbL0gO9mQ9mOOadgq28d0TKJlGLNAKBA11yyksruUqM
         e+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlS9qxXsGvHIQiYArLkRmHJ6HoEYz20oxZx19xibDHFFsUspIds0KiuSpkbJ0cYS6B5zurMPSijOfT@vger.kernel.org
X-Gm-Message-State: AOJu0YzxegN4mSlcINQ9eQVVIzcj0lgYclR5amBu3Er/xCMzfPmmCeVD
	GjKTaxIotDhtFDhiCdY0qZkbXJD9nJ5PqbgDFrQzRFiMcT6FmG+HR8XO
X-Gm-Gg: ASbGncvgM0qOT2SW2XkMw0lOUMJHVlPKCSC6VtNzEiMv+Q5rM0P0g/FN8eHRAdiJpAx
	G0X7LFwJ3dzcEzfFIlxHZLaNMSBXWEGRDyPUisG588bJjtmJkH75xWNSK9sV5rDu2AI+xMMVeq7
	52aaVYmqoWn87Y63CATj8KZfZa4Bz92S3G89l/1nVI+Ll9Qon2eDFCQwAPPctzg8bMDUUBNv+Qw
	oTLE+qKCzykI9OsHbHOyWkLwGbCjk7o8icg/gLt6LDeb2SXC5hcO8IFWkXyOT1WA5o0Lcc4N7mG
	EZindAy/RMtbviVGr2l9QNsE96utOQlBX1MyjXme2C5EDONYFs2EW6aNNik6xS/cZuqegapdjBu
	BKdtjjC8GeBzi9FwXFid9ky7GCBtxPILqsxYL/yi5OWmLUekANQba9W3WkCnaq38+PeCBmfJWBW
	AM9MOuKE+m2Q09XSst7KU5idjFMn+4Jp8=
X-Google-Smtp-Source: AGHT+IGxALLY8prG6JAVW5E/uGEtHfK5CSs8zal/mbFUfzItp6K39nfM2KQWttIuCn2w0Hkx9cfa3Q==
X-Received: by 2002:a05:690e:16a0:b0:63d:bfad:6c7 with SMTP id 956f58d0204a3-642f7e385ffmr1032542d50.58.1763609833574;
        Wed, 19 Nov 2025 19:37:13 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993cedesm4099427b3.41.2025.11.19.19.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:37:13 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 19 Nov 2025 19:37:10 -0800
Subject: [PATCH net-next v7 3/5] net: devmem: implement autorelease token
 management
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-3-1abc8467354c@meta.com>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
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
 include/net/sock.h                      |   7 +-
 include/uapi/linux/netdev.h             |   1 +
 net/core/devmem.c                       | 109 +++++++++++++++++++++++++++-----
 net/core/devmem.h                       |  11 +++-
 net/core/netdev-genl-gen.c              |   5 +-
 net/core/netdev-genl.c                  |  13 +++-
 net/core/sock.c                         |  57 +++++++++++++++--
 net/ipv4/tcp.c                          |  78 ++++++++++++++++++-----
 net/ipv4/tcp_ipv4.c                     |  13 +++-
 net/ipv4/tcp_minisocks.c                |   3 +-
 tools/include/uapi/linux/netdev.h       |   1 +
 13 files changed, 262 insertions(+), 49 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 82bf5cb2617d..913fccca4c4e 100644
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
@@ -767,6 +778,7 @@ operations:
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
index a5f36ea9d46f..797b21148945 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -350,7 +350,7 @@ struct sk_filter;
   *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
   *	@sk_scm_unused: unused flags for scm_recv()
   *	@ns_tracker: tracker for netns reference
-  *	@sk_user_frags: xarray of pages the user is holding a reference on.
+  *	@sk_devmem_info: the devmem binding information for the socket
   *	@sk_owner: reference to the real owner of the socket that calls
   *		   sock_lock_init_class_and_name().
   */
@@ -579,7 +579,10 @@ struct sock {
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
index 048c8de1a130..dff0be8223a4 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -206,6 +206,7 @@ enum {
 	NETDEV_A_DMABUF_QUEUES,
 	NETDEV_A_DMABUF_FD,
 	NETDEV_A_DMABUF_ID,
+	NETDEV_A_DMABUF_AUTORELEASE,
 
 	__NETDEV_A_DMABUF_MAX,
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 4dee2666dd07..bba21c6cb195 100644
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
@@ -28,6 +29,17 @@
 
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
+/* Static key to lock down autorelease to a single mode on a system.  When
+ * enabled: autorelease mode (leaked tokens released on socket close).  When
+ * disabled: manual mode (leaked tokens released on dmabuf unbind).  Once the
+ * first binding is created, the mode is locked system-wide and can not be
+ * changed until the system has zero bindings again.
+ *
+ * Protected by xa_lock of net_devmem_dmabuf_bindings.
+ */
+DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
+EXPORT_SYMBOL(tcp_devmem_ar_key);
+
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
 bool net_is_devmem_iov(struct net_iov *niov)
@@ -116,6 +128,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
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
@@ -143,6 +173,10 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
+	/* Clean up any lingering urefs from sockets that had autorelease
+	 * disabled.
+	 */
+	net_devmem_dmabuf_binding_put_urefs(binding);
 	net_devmem_dmabuf_binding_put(binding);
 }
 
@@ -179,8 +213,10 @@ struct net_devmem_dmabuf_binding *
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
@@ -231,14 +267,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
+	/* Used by TX and also by RX when socket has autorelease disabled */
+	binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+				      sizeof(struct net_iov *),
+				      GFP_KERNEL | __GFP_ZERO);
+	if (!binding->vec) {
+		err = -ENOMEM;
+		goto err_unmap;
 	}
 
 	/* For simplicity we expect to make PAGE_SIZE allocations, but the
@@ -292,25 +327,67 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
 
-	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
-			      binding, xa_limit_32b, &id_alloc_next,
-			      GFP_KERNEL);
+	/* Enforce system-wide autorelease mode consistency for RX bindings.
+	 * TX bindings don't use autorelease (always false) since tokens aren't
+	 * leaked in TX path. Only RX bindings must all have the same
+	 * autorelease mode, never mixed.
+	 *
+	 * We use the xarray's lock to atomically check xa_empty() and toggle
+	 * the static key, avoiding the race where two new bindings may try to
+	 * set the static key to different states.
+	 */
+	xa_lock(&net_devmem_dmabuf_bindings);
+
+	if (direction == DMA_FROM_DEVICE) {
+		if (!xa_empty(&net_devmem_dmabuf_bindings)) {
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
+				goto err_unlock_xa;
+			}
+		} else {
+			/* First binding sets the mode for all subsequent
+			 * bindings.
+			 */
+			if (autorelease)
+				static_branch_enable(&tcp_devmem_ar_key);
+			else
+				static_branch_disable(&tcp_devmem_ar_key);
+		}
+	}
+
+	err = __xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
+				binding, xa_limit_32b, &id_alloc_next,
+				GFP_KERNEL);
 	if (err < 0)
-		goto err_free_chunks;
+		goto err_unlock_xa;
+
+	xa_unlock(&net_devmem_dmabuf_bindings);
 
 	list_add(&binding->list, &priv->bindings);
 
 	return binding;
 
+err_unlock_xa:
+	xa_unlock(&net_devmem_dmabuf_bindings);
 err_free_chunks:
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 1ea6228e4f40..33e85ff5f35e 100644
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
@@ -174,7 +178,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd,
 		       struct netdev_nl_sock *priv,
-		       struct netlink_ext_ack *extack)
+		       struct netlink_ext_ack *extack,
+		       bool autorelease)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index ff20435c45d2..ecbd8ae2a3fa 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -85,10 +85,11 @@ static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE
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
@@ -187,7 +188,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.cmd		= NETDEV_CMD_BIND_RX,
 		.doit		= netdev_nl_bind_rx_doit,
 		.policy		= netdev_bind_rx_nl_policy,
-		.maxattr	= NETDEV_A_DMABUF_FD,
+		.maxattr	= NETDEV_A_DMABUF_AUTORELEASE,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 470fabbeacd9..5f06a677f056 100644
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
@@ -1096,8 +1102,11 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
+	/* TX bindings don't use autorelease. Autorelease is only meaningful
+	 * for RX where tokens may be leaked by userspace.
+	 */
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
-					 dmabuf_fd, priv, info->extack);
+					 dmabuf_fd, priv, info->extack, false);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_netdev;
diff --git a/net/core/sock.c b/net/core/sock.c
index 41274bd0394e..f945cdb5a337 100644
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
+	if (static_branch_unlikely(&tcp_devmem_ar_key))
+		ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+	else
+		ret = sock_devmem_dontneed_manual_release(sk, tokens,
+							  num_tokens);
 
 	kvfree(tokens);
 	return ret;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index dee578aad690..e17b71244922 100644
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
+	if (!static_branch_unlikely(&tcp_devmem_ar_key))
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
@@ -2454,24 +2461,42 @@ static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
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
+					 skb_frag_t *frag, int *refs)
+{
+	struct net_iov *niov;
+
+	niov = skb_frag_net_iov(frag);
+
+	if (static_branch_unlikely(&tcp_devmem_ar_key)) {
+		atomic_long_inc(&niov->pp_ref_count);
+		tcp_xa_pool->netmems[tcp_xa_pool->idx++] =
+			skb_frag_netmem(frag);
+	} else {
+		if (atomic_inc_return(&niov->uref) == 1)
+			atomic_long_inc(&niov->pp_ref_count);
+		(*refs)++;
+	}
+}
+
 /* On error, returns the -errno. On success, returns number of bytes sent to the
  * user. May not consume all of @remaining_len.
  */
@@ -2479,10 +2504,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			      unsigned int offset, struct msghdr *msg,
 			      int remaining_len)
 {
+	struct net_devmem_dmabuf_binding *binding = NULL;
 	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
 	struct tcp_xa_pool tcp_xa_pool;
 	unsigned int start;
 	int i, copy, n;
+	int refs = 0;
 	int sent = 0;
 	int err = 0;
 
@@ -2536,6 +2563,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 			struct net_iov *niov;
 			u64 frag_offset;
+			u32 token;
 			int end;
 
 			/* !skb_frags_readable() should indicate that ALL the
@@ -2568,13 +2596,32 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 					      start;
 				dmabuf_cmsg.frag_offset = frag_offset;
 				dmabuf_cmsg.frag_size = copy;
-				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
-							 skb_shinfo(skb)->nr_frags - i);
-				if (err)
+
+				binding = net_devmem_iov_binding(niov);
+
+				if (!sk->sk_devmem_info.binding)
+					sk->sk_devmem_info.binding = binding;
+
+				if (sk->sk_devmem_info.binding != binding) {
+					err = -EFAULT;
 					goto out;
+				}
+
+				if (static_branch_unlikely(&tcp_devmem_ar_key)) {
+					err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
+								 skb_shinfo(skb)->nr_frags - i);
+					if (err)
+						goto out;
+
+					dmabuf_cmsg.frag_token =
+						tcp_xa_pool.tokens[tcp_xa_pool.idx];
+				} else {
+					token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
+					dmabuf_cmsg.frag_token = token;
+				}
+
 
 				/* Will perform the exchange later */
-				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
 				dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
 
 				offset += copy;
@@ -2587,8 +2634,8 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+				tcp_xa_pool_inc_pp_ref_count(&tcp_xa_pool, frag,
+							     &refs);
 
 				sent += copy;
 
@@ -2617,6 +2664,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 
 out:
 	tcp_xa_pool_commit(sk, &tcp_xa_pool);
+
 	if (!sent)
 		sent = err;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6fcaecb67284..bfa19aeec6b5 100644
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
@@ -2501,9 +2504,15 @@ void tcp_v4_destroy_sock(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
+	/* No static branch because sockets may outlive the binding, which
+	 * opens the opportunity for static key state to change. In any
+	 * scenario, if the xarray is non-empty then we need to free those
+	 * frags.
+	 */
 	tcp_release_user_frags(sk);
 
-	xa_destroy(&sk->sk_user_frags);
+	xa_destroy(&sk->sk_devmem_info.frags);
+	sk->sk_devmem_info.binding = NULL;
 
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
index 048c8de1a130..dff0be8223a4 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -206,6 +206,7 @@ enum {
 	NETDEV_A_DMABUF_QUEUES,
 	NETDEV_A_DMABUF_FD,
 	NETDEV_A_DMABUF_ID,
+	NETDEV_A_DMABUF_AUTORELEASE,
 
 	__NETDEV_A_DMABUF_MAX,
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)

-- 
2.47.3


