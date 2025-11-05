Return-Path: <linux-arch+bounces-14510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BCC33A4B
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 02:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06747465B21
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C7C2652BD;
	Wed,  5 Nov 2025 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJV1yIAS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CE2550D5
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305810; cv=none; b=pMUUUhIVIWvi2E1RzrJae3WZ2eJc5eHRyo1bS03zXLKkl5Z1bnvAvMhlBJ63jVNN4NNOHp2XCdlevDFq9FhylXL9XZbSNLlw+AZyBopUScaBVF4KGdHzg7tqqtQ83qa7rRJNbbATb1MDh+EfLl+nXaAFoIJznQt8szURhHtVC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305810; c=relaxed/simple;
	bh=YMknTLKRCPhcgUPsp62PyPTAUbInQWS2lHoa+4aPnJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=smuRyeFg1S0QNMcQrN7R1JpO33TErHg6qUZXC5iyxEfhY1cwdTe6DLtBX+TkwAGZRbeL+6KHIotaYeIQ4E8mDhIxSv3EhH/L8gVJcFZQ+YGen6wJNU2UOHohtipxRuqfO9zcJj/oQL/B5Y6Kd34hnlkOqC3s6eWpBUAYae+D4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJV1yIAS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-781014f4e12so84095527b3.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 17:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305806; x=1762910606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hil2HKi9B1UhfW0L0RR1Dk2NsV84mEAbRdtkuqHzVz0=;
        b=BJV1yIASAB+IHEsg1uZ3SBAFlgxdvLyZtVUJ97MqD/uiVgZ3T/ivtYOp8x8VLsTEB7
         FXYKAcyVWbvvpXCw8U/MK3jZksZd3qXjwaPooedpeVvHwIlhKCjymfwn9Gn2pN9HCEYE
         ZQd2Uc/9jbroXUTXMYnragIZixcAlpyJERxWo8wlxQ55NOB4QORWpL8B6Nb+Oggioxqu
         rhrJAA3El2JsjiO6vP1fZueT739ofxyzOhLyFvL+H4xkxDIyAZDOEc8a9NZnIVnNu2o2
         FYcPt2W1KZs0poJAQ8VMEaiIKBDeSYsnYglTsM8g3zqMtPxMqUviFe97L42x7/+GMuf3
         rp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305806; x=1762910606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hil2HKi9B1UhfW0L0RR1Dk2NsV84mEAbRdtkuqHzVz0=;
        b=ZXvXADBRrNb4zQJ+V9e9e7RVtffpaKuq16w3/yTbwtfReHPmZBiSzLqWfR8muuDzu4
         75f0xV0K22OTfrFmfl1uYNJUPX0tbOZtaD2sixDsm85D15K49pEQjWUOyWC11EDAIeDI
         5LmKei468Hdh5Dv8xfFEaBT9lmpdN5jkb+MWOgA6J+jSZW847Ov7sBtKgm8QdcJc59sU
         0x5KebT+k6+AFXTSUJB+jZnBtKMCvYkIAKxc/RfyPOCFaQCEliMc6xCqnzKIdToo2/o5
         dMfehPHaXXOjKezI7StyaGOEvKDfpqtCVvo4kvD9R3Sq+hQAcc2RG5C2HYqsXpzjk3v6
         ZHJg==
X-Forwarded-Encrypted: i=1; AJvYcCW4sbe4YC/8VDiyll7Au3A1bNbWa79V2tFUKHQ22kkpmmZ//8Um98w16JgkcASzT2YA7EhSMJE11If6@vger.kernel.org
X-Gm-Message-State: AOJu0YwTwoun7dyLapoaOEf9Mij/9PZuE17R0lihdRR9J/1nOteFpaX5
	xMdJ869L7CFVvkXF3JeCXASJQaqi6W73yG+KlE1cz/8VXZ4Knqe28srygkThKYkf
X-Gm-Gg: ASbGnctcHIBHY/sIXwvKstDX2WNNS+OEr48zOgQ+xaQc/nHL87WUYP7uvYDPervkrsd
	KbWMSa6ZGVd5NnqAD6cFBMzHl4OdsdgyAB6wV/gisCOYWQKWoZlNmjPi/XgsFDaVlGRnmJR+Ktq
	0WWsAlHhLsDkxytoO6UAb6X2saeqXbvXwGaNcoLujSUhTfRA9FyakGhiO7ZRpOP9fHAT+8iWhZE
	Z9sTavDEPkCCs+PqIT0uEdHMY0dRRB+5q7K7j51pfRKlubiSyWS9GM/sgVNiVj9It+4O2EFPAwx
	CeSEDUh/nz26LMCSkbxHiUM5AueBQFG2nt1m/fljamjQcR/wYKdDc0OxtKW/8d9gnrLCnJ868i9
	g8EvhdYXdbSWXtbbjGiZvyY0IYOjHVGkDPtlJSuu/KnjwtA99aB+7t2yc0H6SCDoZ01fMTRTfOv
	LzkeoQyshAV9UrpWX2sYCF
X-Google-Smtp-Source: AGHT+IHIxe8GEicHF4Mwai1ViXqkyqY1nn4HDCAvuanckvMK93kalwvgw28+rUEVuRK43rzSsEqBAQ==
X-Received: by 2002:a05:690c:a4da:10b0:784:8d21:394f with SMTP id 00721157ae682-786a4103d98mr13457847b3.6.1762305805797;
        Tue, 04 Nov 2025 17:23:25 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-786a1f7af41sm5902377b3.45.2025.11.04.17.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:25 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 17:23:22 -0800
Subject: [PATCH net-next v6 3/6] net: devmem: prepare for autorelease rx
 token management
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-3-ea98cf4d40b3@meta.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add alternative token management implementation (autorelease vs
non-autorelease) that replaces xarray-based token lookups with direct
array access using page offsets as dmabuf tokens. When enabled, this
eliminates xarray overhead and reduces CPU utilization in devmem RX
threads by approximately 13%.

This patch changes the meaning of tokens when this option is used.
Tokens previously referred to unique fragments of pages. With this
option tokens instead represent references to pages, not fragments.
Because of this, multiple tokens may refer to the same page and so have
identical value (e.g., two small fragments may coexist on the same
page). The token and offset pair that the user receives uniquely
identifies fragments if needed.  This assumes that the user is not
attempting to sort / uniq the token list using tokens alone.

This introduces a restriction: devmem RX sockets cannot switch dmabuf
bindings when using the autorelease off option. This is necessary
because 32-bit tokens lack sufficient bits to encode both large dmabuf
page counts and binding/queue IDs. For example, a system with 8 NICs and
32 queues needs 8 bits for binding IDs, leaving only 24 bits for pages
(64GB max). This restriction aligns with common usage, as steering flows
to different queues/devices is often undesirable for TCP.

This patch adds an atomic uref counter to net_iov for tracking user
references via binding->vec. The pp_ref_count is only updated on uref
transitions from zero to one or from one to zero, to minimize atomic
overhead. If a user fails to refill and closes before returning all
tokens, the binding will finish the uref release when unbound.

A flag "autorelease" is added per-socket. This will be used for enabling
the old behavior of the kernel releasing references for the sockets upon
close(2) (autorelease), instead of requiring that socket users do this
themselves. The autorelease flag is always true in this patch, meaning
that the old (non-optimized) behavior is kept unconditionally. A future
patch supports a user-facing knob to toggle this feature and will change
the default to false for the improved performance.

An outstanding_urefs counter is added per-socket so that changes to the
autorelease mode can be rejected for active sockets.

The dmabuf unbind path always checks for any leaked urefs.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
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
 include/net/netmem.h     |  1 +
 include/net/sock.h       | 13 +++++++--
 net/core/devmem.c        | 42 ++++++++++++++++++++++-------
 net/core/devmem.h        |  2 +-
 net/core/sock.c          | 55 +++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp.c           | 69 ++++++++++++++++++++++++++++++++++++++----------
 net/ipv4/tcp_ipv4.c      | 11 +++++---
 net/ipv4/tcp_minisocks.c |  5 +++-
 8 files changed, 161 insertions(+), 37 deletions(-)

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
index c7e58b8e8a90..548fabacff7c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -350,7 +350,11 @@ struct sk_filter;
   *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
   *	@sk_scm_unused: unused flags for scm_recv()
   *	@ns_tracker: tracker for netns reference
-  *	@sk_user_frags: xarray of pages the user is holding a reference on.
+  *	@sk_devmem_info: the devmem binding information for the socket
+  *		@frags: xarray of tokens for autorelease mode
+  *		@binding: pointer to the dmabuf binding
+  *		@outstanding_urefs: count of outstanding user references
+  *		@autorelease: if true, tokens released on close; if false, user must release
   *	@sk_owner: reference to the real owner of the socket that calls
   *		   sock_lock_init_class_and_name().
   */
@@ -579,7 +583,12 @@ struct sock {
 	struct numa_drop_counters *sk_drop_counters;
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
-	struct xarray		sk_user_frags;
+	struct {
+		struct xarray				frags;
+		struct net_devmem_dmabuf_binding	*binding;
+		atomic_t				outstanding_urefs;
+		bool					autorelease;
+	} sk_devmem_info;
 
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 	struct module		*sk_owner;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 4dee2666dd07..904d19e58f4b 100644
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
@@ -116,6 +117,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
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
@@ -143,6 +162,10 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
+	/* Clean up any lingering urefs from sockets that had autorelease
+	 * disabled.
+	 */
+	net_devmem_dmabuf_binding_put_urefs(binding);
 	net_devmem_dmabuf_binding_put(binding);
 }
 
@@ -231,14 +254,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -292,10 +314,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 2ada54fb63d7..d4eb28d079bb 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -61,7 +61,7 @@ struct net_devmem_dmabuf_binding {
 
 	/* Array of net_iov pointers for this binding, sorted by virtual
 	 * address. This array is convenient to map the virtual addresses to
-	 * net_iovs in the TX path.
+	 * net_iovs.
 	 */
 	struct net_iov **vec;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 5562f517d889..465645c1d74f 100644
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
@@ -1081,6 +1083,43 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 #define MAX_DONTNEED_TOKENS 128
 #define MAX_DONTNEED_FRAGS 1024
 
+static noinline_for_stack int
+sock_devmem_dontneed_manual_release(struct sock *sk, struct dmabuf_token *tokens,
+				    unsigned int num_tokens)
+{
+	struct net_iov *niov;
+	unsigned int i, j;
+	netmem_ref netmem;
+	unsigned int token;
+	int num_frags = 0;
+	int ret;
+
+	if (!sk->sk_devmem_info.binding)
+		return -EINVAL;
+
+	for (i = 0; i < num_tokens; i++) {
+		for (j = 0; j < tokens[i].token_count; j++) {
+			token = tokens[i].token_start + j;
+			if (token >= sk->sk_devmem_info.binding->dmabuf->size / PAGE_SIZE)
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
+	atomic_sub(ret, &sk->sk_devmem_info.outstanding_urefs);
+
+	return ret;
+}
+
 static noinline_for_stack int
 sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
 				 unsigned int num_tokens)
@@ -1089,32 +1128,32 @@ sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
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
+				&sk->sk_devmem_info.frags, tokens[i].token_start + j);
 
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
 
@@ -1145,7 +1184,11 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 		return -EFAULT;
 	}
 
-	ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+	if (sk->sk_devmem_info.autorelease)
+		ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+	else
+		ret = sock_devmem_dontneed_manual_release(sk, tokens,
+							  num_tokens);
 
 	kvfree(tokens);
 	return ret;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a9345aa5a2e5..052875c1b547 100644
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
@@ -492,7 +493,10 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
-	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
+	xa_init_flags(&sk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
+	sk->sk_devmem_info.binding = NULL;
+	atomic_set(&sk->sk_devmem_info.outstanding_urefs, 0);
+	sk->sk_devmem_info.autorelease = true;
 }
 EXPORT_IPV6_MOD(tcp_init_sock);
 
@@ -2424,11 +2428,11 @@ static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_pool *p)
 
 	/* Commit part that has been copied to user space. */
 	for (i = 0; i < p->idx; i++)
-		__xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_ENTRY,
+		__xa_cmpxchg(&sk->sk_devmem_info.frags, p->tokens[i], XA_ZERO_ENTRY,
 			     (__force void *)p->netmems[i], GFP_KERNEL);
 	/* Rollback what has been pre-allocated and is no longer needed. */
 	for (; i < p->max; i++)
-		__xa_erase(&sk->sk_user_frags, p->tokens[i]);
+		__xa_erase(&sk->sk_devmem_info.frags, p->tokens[i]);
 
 	p->max = 0;
 	p->idx = 0;
@@ -2436,14 +2440,17 @@ static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_pool *p)
 
 static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
 {
+	if (!sk->sk_devmem_info.autorelease)
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
@@ -2454,18 +2461,18 @@ static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
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
@@ -2479,12 +2486,14 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			      unsigned int offset, struct msghdr *msg,
 			      int remaining_len)
 {
+	struct net_devmem_dmabuf_binding *binding = NULL;
 	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
 	struct tcp_xa_pool tcp_xa_pool;
 	unsigned int start;
 	int i, copy, n;
 	int sent = 0;
 	int err = 0;
+	int refs;
 
 	tcp_xa_pool.max = 0;
 	tcp_xa_pool.idx = 0;
@@ -2536,6 +2545,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 			struct net_iov *niov;
 			u64 frag_offset;
+			u32 token;
 			int end;
 
 			/* !skb_frags_readable() should indicate that ALL the
@@ -2568,13 +2578,32 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
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
+				if (sk->sk_devmem_info.autorelease) {
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
@@ -2587,8 +2616,15 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+				if (sk->sk_devmem_info.autorelease) {
+					atomic_long_inc(&niov->pp_ref_count);
+					tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
+						skb_frag_netmem(frag);
+				} else {
+					if (atomic_inc_return(&niov->uref) == 1)
+						atomic_long_inc(&niov->pp_ref_count);
+					refs++;
+				}
 
 				sent += copy;
 
@@ -2599,6 +2635,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		}
 
 		tcp_xa_pool_commit(sk, &tcp_xa_pool);
+
 		if (!remaining_len)
 			goto out;
 
@@ -2617,9 +2654,13 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 
 out:
 	tcp_xa_pool_commit(sk, &tcp_xa_pool);
+
 	if (!sent)
 		sent = err;
 
+	if (refs > 0)
+		atomic_add(refs, &sk->sk_devmem_info.outstanding_urefs);
+
 	return sent;
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 40a76da5364a..dbb7a71e3cce 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -89,6 +89,9 @@
 
 #include <crypto/md5.h>
 
+#include <linux/dma-buf.h>
+#include "../core/devmem.h"
+
 #include <trace/events/tcp.h>
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -2493,7 +2496,7 @@ static void tcp_release_user_frags(struct sock *sk)
 	unsigned long index;
 	void *netmem;
 
-	xa_for_each(&sk->sk_user_frags, index, netmem)
+	xa_for_each(&sk->sk_devmem_info.frags, index, netmem)
 		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem));
 #endif
 }
@@ -2502,9 +2505,11 @@ void tcp_v4_destroy_sock(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	tcp_release_user_frags(sk);
+	if (sk->sk_devmem_info.binding && sk->sk_devmem_info.autorelease)
+		tcp_release_user_frags(sk);
 
-	xa_destroy(&sk->sk_user_frags);
+	xa_destroy(&sk->sk_devmem_info.frags);
+	sk->sk_devmem_info.binding = NULL;
 
 	trace_tcp_destroy_sock(sk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ded2cf1f6006..a017dea35bb8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -663,7 +663,10 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
 
-	xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
+	xa_init_flags(&newsk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
+	newsk->sk_devmem_info.binding = NULL;
+	atomic_set(&newsk->sk_devmem_info.outstanding_urefs, 0);
+	newsk->sk_devmem_info.autorelease = true;
 
 	return newsk;
 }

-- 
2.47.3


