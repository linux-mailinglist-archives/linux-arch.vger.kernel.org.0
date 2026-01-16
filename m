Return-Path: <linux-arch+bounces-15820-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96013D2BBC5
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 06:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE11C304D495
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 05:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8459134D396;
	Fri, 16 Jan 2026 05:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP/8p35B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9F34B18C
	for <linux-arch@vger.kernel.org>; Fri, 16 Jan 2026 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539809; cv=none; b=hbA/n08lNUm0AHWZrUyIfusBEf6PRO5UgitjsmZWlfpK0tzZraRmLzOEBxC82dQg2NjeEkPuu6jbhdVJVsuVs9gdMOoWlPkJkU+UgbCHnRo5G5YqLgQz5viz9FOPdRomXlpoYeV9QKRT1lz28Vi5TMl4j03Y4/ZItn3G3fZLfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539809; c=relaxed/simple;
	bh=9S5OUgIpuf56WuydD4vdzfH08s/+w+X+AXyg3rys7KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzeKcMsGMBwtnDFGasiS2LN8hY6Y8XuLTKEJ4euJGXlPq49AexY4VYXL7pGwuH3rTGcTU+wCaFQehB/WQ2NnNzZnyJ1Go1rLBwjnRkWyz0NqYYDVFwG8VgUdoNkkwihv6m8nD87cxgUq2nBd/qaXACXJmh6YMxvQAk0AsjRMcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP/8p35B; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64455a2a096so1416256d50.3
        for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 21:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768539800; x=1769144600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/asKP1YvaUXXv4sijY4YouNHQV0l+Ef77I/RdWYiUjg=;
        b=LP/8p35BVItbcke/qa95GbG8LNugb/ZyNLm8Cx3zP8DQ6o0abnYk2987J4UaB2ocYi
         VoWEeEoMehSyPkPwbMheHQlJbzudqNPiNiNLGrG3+Ecn2S4JHzlNGfsRjbcJvknV69P8
         /hAteteJbafrI1oqFpVazeGUJ4wr5pmyj4cN9uXzy9Se8AvSStWpPGl+cFMbhzDYEoaB
         0V3ELeMk9WqtKl7cjmBV+w7iF8QkHP2CjscQ647ljA5PtAsIYTM+D21SfsbVzdMmODPx
         6L4dUdB+wd4QgdT3oMAB1h3eYS26jDuaBHySe8+mDnxPYOdoZbQJKZ0oHLe6PJFD8axq
         qPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768539800; x=1769144600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/asKP1YvaUXXv4sijY4YouNHQV0l+Ef77I/RdWYiUjg=;
        b=oVm+IZdDAbFRUe0HA8DEDsyt2a117DuBpoRwnb/bSGTyBt8t4c2cXelxAf3s0FTXln
         /WFpM2Q5ocsCIzP1OpjcqR5WvOweo76hn8anmII+KKbjne2XMxoe5d65Us4hsey2gQGV
         WxFlmOFePNFTkZO/DDUQAToazKOGFmpKBrj0OdayihPksEnjy6zwDlMCJHVmJRbOOqg9
         wmZ1krPbj44pl1ggZrlNHHZn3hxP6Y+hHgT06K/+mLLFK/n1gsl+X5UCyBy4KvaBpm01
         S7hIIJOUKEOoQNU+8dYJHgWFNjybqMGcBI2B4/X6IGWNR07e2KkmBI8951OYDOJvj2xX
         ecIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwNjSXSVblioQln9jzAefH9bFqV22rwgeVgU9L0oyvYg/rWE7z0XyFALC3H62uVgmNGDJC/OBYbht/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5xLXMO/0ZJEua2w5zbf7D5MB/olVSNoffqm4OiBZt+gRV+8K9
	X6js5MKdpONRTMGddQWB1nnBafqvx6Gh90nCBoTWKU4ONJhnwGH0Uf0F
X-Gm-Gg: AY/fxX5KQPbmISzGMtFxGqe2vXEz3n//411kfk7m4srAOT8gzbV0VkGcYEiG04oO8j8
	qkeDxeg7qcYI72oznQ95Jtoktsf/LcwHlZDnPAXQ08m7QRCtDJQ19omScKNN1eCWC+SKMNRhyCY
	4MrSmxlCW0L9n5AlPDsH1VVy4flKErlvc9q3pqy3xlHNcPEewgacp2iFsL+URe0h6nudv7hxNhb
	5yF1WZ/xGincNEBVEEhA+M1sx1Pa4KFJXH8kG/f9rPfSmbGSePrutFAw8CVEn1NJFtqnL8q1gvR
	/PpW1aZeLFMtFL6mNxWnp3EFeR1BcKpEzvr/wngZYiQ33f/dhb6lydgNDMkpf/l4L+Spp73Bc8+
	+nUGu4IL0mam5k/Vym/XWO/r+8bIgPf3sxiEswS+u3ssuG+gsdZmkcwCapx0KPl463h1RUOwqtX
	aPq9+tivYwJ9QB7UTTvmiE
X-Received: by 2002:a05:690c:f96:b0:788:989:fdae with SMTP id 00721157ae682-793c52a3abdmr38677927b3.28.1768539800055;
        Thu, 15 Jan 2026 21:03:20 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c68c31dfsm5205917b3.51.2026.01.15.21.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 21:03:19 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 15 Jan 2026 21:02:14 -0800
Subject: [PATCH net-next v10 3/5] net: devmem: implement autorelease token
 management
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-3-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
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

The xa_erase(&net_devmem_dmabuf_bindings, ...) call is moved into
__net_devmem_dmabuf_binding_free(...). The result is that it becomes
possible to switch static branches atomically with regards to xarray
state. In the time window between unbind and free the socket layer can
still find the binding in the xarray, but it will fail to acquire
binding->ref (if unbind decremented to zero). This change preserves
correct behavior and allows us to avoid more complicated counting
schemes for bindings.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v10:
- add binding->users to track socket and rxq users of binding, defer
  release of urefs until binding->users hits zero to guard users from
  incrementing urefs *after* net_devmem_dmabuf_binding_put_urefs()
  is called. (Mina)
- fix error failing to restore static key state when xarray alloc fails
  (Jakub)
- add wrappers for setting/unsetting mode that captures the static key +
  rx binding count logic.
- move xa_erase() into __net_devmem_dmabuf_binding_free()
- remove net_devmem_rx_bindings_count, change xarray management to be
  to avoid the same race as net_devmem_rx_bindings_count did
- check return of net_devmem_dmabuf_binding_get() in
  tcp_recvmsg_dmabuf()
- move sk_devmem_info.binding fiddling into autorelease=off static path

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
 Documentation/netlink/specs/netdev.yaml |  12 +++
 include/net/netmem.h                    |   1 +
 include/net/sock.h                      |   7 +-
 include/uapi/linux/netdev.h             |   1 +
 net/core/devmem.c                       | 136 +++++++++++++++++++++++++++-----
 net/core/devmem.h                       |  64 ++++++++++++++-
 net/core/netdev-genl-gen.c              |   5 +-
 net/core/netdev-genl.c                  |  10 ++-
 net/core/sock.c                         |  57 +++++++++++--
 net/ipv4/tcp.c                          |  87 ++++++++++++++++----
 net/ipv4/tcp_ipv4.c                     |  15 +++-
 net/ipv4/tcp_minisocks.c                |   3 +-
 tools/include/uapi/linux/netdev.h       |   1 +
 13 files changed, 345 insertions(+), 54 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 596c306ce52b..a5301b150663 100644
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
+          released when the dmabuf is torn down. Once a binding is created with
+          a specific mode, all subsequent bindings system-wide must use the
+          same mode.
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
index 9dee697a28ee..1264d8ee40e3 100644
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
@@ -27,6 +28,9 @@
 /* Device memory support */
 
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
+static DEFINE_MUTEX(devmem_ar_lock);
+DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
+EXPORT_SYMBOL(tcp_devmem_ar_key);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
@@ -63,12 +67,71 @@ static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 	schedule_work(&binding->unbind_w);
 }
 
+static bool net_devmem_has_rx_bindings(void)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	unsigned long index;
+
+	lockdep_assert_held(&devmem_ar_lock);
+
+	xa_for_each(&net_devmem_dmabuf_bindings, index, binding) {
+		if (binding->direction == DMA_FROM_DEVICE)
+			return true;
+	}
+	return false;
+}
+
+/* caller must hold devmem_ar_lock */
+static int
+__net_devmem_dmabuf_binding_set_mode(enum dma_data_direction direction,
+				     bool autorelease)
+{
+	lockdep_assert_held(&devmem_ar_lock);
+
+	if (direction != DMA_FROM_DEVICE)
+		return 0;
+
+	if (net_devmem_has_rx_bindings() &&
+	    static_key_enabled(&tcp_devmem_ar_key) != autorelease)
+		return -EBUSY;
+
+	if (autorelease)
+		static_branch_enable(&tcp_devmem_ar_key);
+
+	return 0;
+}
+
+/* caller must hold devmem_ar_lock */
+static void
+__net_devmem_dmabuf_binding_unset_mode(enum dma_data_direction direction)
+{
+	lockdep_assert_held(&devmem_ar_lock);
+
+	if (direction != DMA_FROM_DEVICE)
+		return;
+
+	if (net_devmem_has_rx_bindings())
+		return;
+
+	static_branch_disable(&tcp_devmem_ar_key);
+}
+
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
 
 	size_t size, avail;
 
+	mutex_lock(&devmem_ar_lock);
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+	__net_devmem_dmabuf_binding_unset_mode(binding->direction);
+	mutex_unlock(&devmem_ar_lock);
+
+	/* Ensure no tx net_devmem_lookup_dmabuf() are in flight after the
+	 * erase.
+	 */
+	synchronize_net();
+
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
 
@@ -126,19 +189,30 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
 	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
 }
 
+void
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
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
 
-	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
-
-	/* Ensure no tx net_devmem_lookup_dmabuf() are in flight after the
-	 * erase.
-	 */
-	synchronize_net();
-
 	if (binding->list.next)
 		list_del(&binding->list);
 
@@ -151,6 +225,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
 		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
+
+		net_devmem_dmabuf_binding_user_put(binding);
 	}
 
 	percpu_ref_kill(&binding->ref);
@@ -178,6 +254,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	if (err)
 		goto err_close_rxq;
 
+	atomic_inc(&binding->users);
+
 	return 0;
 
 err_close_rxq:
@@ -189,8 +267,10 @@ struct net_devmem_dmabuf_binding *
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
@@ -225,6 +305,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	if (err < 0)
 		goto err_free_binding;
 
+	atomic_set(&binding->users, 0);
+
 	mutex_init(&binding->lock);
 
 	binding->dmabuf = dmabuf;
@@ -245,14 +327,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -306,25 +386,41 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
+	err = __net_devmem_dmabuf_binding_set_mode(direction, autorelease);
+	if (err < 0) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "System already configured with autorelease=%d",
+				   static_key_enabled(&tcp_devmem_ar_key));
+		goto err_unlock_mutex;
+	}
+
 	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
 			      binding, xa_limit_32b, &id_alloc_next,
 			      GFP_KERNEL);
 	if (err < 0)
-		goto err_free_chunks;
+		goto err_unset_mode;
+
+	mutex_unlock(&devmem_ar_lock);
 
 	list_add(&binding->list, &priv->bindings);
 
 	return binding;
 
+err_unset_mode:
+	__net_devmem_dmabuf_binding_unset_mode(direction);
+err_unlock_mutex:
+	mutex_unlock(&devmem_ar_lock);
 err_free_chunks:
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 94874b323520..284f0ad5f381 100644
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
@@ -43,6 +47,12 @@ struct net_devmem_dmabuf_binding {
 	 */
 	struct percpu_ref ref;
 
+	/* Counts sockets and rxqs that are using the binding. When this
+	 * reaches zero, all urefs are drained and new sockets cannot join the
+	 * binding.
+	 */
+	atomic_t users;
+
 	/* The list of bindings currently active. Used for netlink to notify us
 	 * of the user dropping the bind.
 	 */
@@ -61,7 +71,7 @@ struct net_devmem_dmabuf_binding {
 
 	/* Array of net_iov pointers for this binding, sorted by virtual
 	 * address. This array is convenient to map the virtual addresses to
-	 * net_iovs in the TX path.
+	 * net_iovs.
 	 */
 	struct net_iov **vec;
 
@@ -88,7 +98,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
-		       struct netlink_ext_ack *extack);
+		       struct netlink_ext_ack *extack, bool autorelease);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
@@ -134,6 +144,26 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 	percpu_ref_put(&binding->ref);
 }
 
+void net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *binding);
+
+static inline bool
+net_devmem_dmabuf_binding_user_get(struct net_devmem_dmabuf_binding *binding)
+{
+	return atomic_inc_not_zero(&binding->users);
+}
+
+static inline void
+net_devmem_dmabuf_binding_user_put(struct net_devmem_dmabuf_binding *binding)
+{
+	if (atomic_dec_and_test(&binding->users))
+		net_devmem_dmabuf_binding_put_urefs(binding);
+}
+
+static inline bool net_devmem_autorelease_enabled(void)
+{
+	return static_branch_unlikely(&tcp_devmem_ar_key);
+}
+
 void net_devmem_get_net_iov(struct net_iov *niov);
 void net_devmem_put_net_iov(struct net_iov *niov);
 
@@ -151,11 +181,38 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding, size_t addr,
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
 }
 
+static inline void
+net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *binding)
+{
+}
+
+static inline bool
+net_devmem_dmabuf_binding_user_get(struct net_devmem_dmabuf_binding *binding)
+{
+	return false;
+}
+
+static inline void
+net_devmem_dmabuf_binding_user_put(struct net_devmem_dmabuf_binding *binding)
+{
+}
+
+static inline bool net_devmem_autorelease_enabled(void)
+{
+	return false;
+}
+
 static inline void net_devmem_get_net_iov(struct net_iov *niov)
 {
 }
@@ -170,7 +227,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
index d5319ebe2452..73a577bd8765 100644
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
@@ -2436,14 +2439,17 @@ static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_pool *p)
 
 static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
 {
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
@@ -2454,24 +2460,41 @@ static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
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
@@ -2533,6 +2556,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		 * sequence of cmsg
 		 */
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+			struct net_devmem_dmabuf_binding *binding = NULL;
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 			struct net_iov *niov;
 			u64 frag_offset;
@@ -2568,13 +2592,45 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 					      start;
 				dmabuf_cmsg.frag_offset = frag_offset;
 				dmabuf_cmsg.frag_size = copy;
-				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
-							 skb_shinfo(skb)->nr_frags - i);
-				if (err)
-					goto out;
+
+				binding = net_devmem_iov_binding(niov);
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
+					if (!sk->sk_devmem_info.binding) {
+						if (!net_devmem_dmabuf_binding_user_get(binding)) {
+							err = -ENODEV;
+							goto out;
+						}
+
+						if (!net_devmem_dmabuf_binding_get(binding)) {
+							net_devmem_dmabuf_binding_user_put(binding);
+							err = -ENODEV;
+							goto out;
+						}
+
+						sk->sk_devmem_info.binding = binding;
+					}
+
+					if (sk->sk_devmem_info.binding != binding) {
+						err = -EFAULT;
+						goto out;
+					}
+
+					dmabuf_cmsg.frag_token =
+						net_iov_virtual_addr(niov) >> PAGE_SHIFT;
+				}
+
 
 				/* Will perform the exchange later */
-				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
 				dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
 
 				offset += copy;
@@ -2587,8 +2643,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->desc.pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+				tcp_xa_pool_inc_pp_ref_count(&tcp_xa_pool, frag);
 
 				sent += copy;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f8a9596e8f4d..420e8c8ebf6d 100644
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
@@ -2503,7 +2506,15 @@ void tcp_v4_destroy_sock(struct sock *sk)
 
 	tcp_release_user_frags(sk);
 
-	xa_destroy(&sk->sk_user_frags);
+	if (!net_devmem_autorelease_enabled() && sk->sk_devmem_info.binding) {
+		net_devmem_dmabuf_binding_user_put(sk->sk_devmem_info.binding);
+		net_devmem_dmabuf_binding_put(sk->sk_devmem_info.binding);
+		sk->sk_devmem_info.binding = NULL;
+		WARN_ONCE(!xa_empty(&sk->sk_devmem_info.frags),
+			  "non-empty xarray discovered in autorelease off mode");
+	}
+
+	xa_destroy(&sk->sk_devmem_info.frags);
 
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


