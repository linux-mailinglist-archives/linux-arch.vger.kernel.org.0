Return-Path: <linux-arch+bounces-7140-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E0970D93
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 07:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEA81C21D51
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 05:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75941B1D4C;
	Mon,  9 Sep 2024 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FjgbLPZK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4F1AED40
	for <linux-arch@vger.kernel.org>; Mon,  9 Sep 2024 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725860634; cv=none; b=alvUWb6Sa9QCfqyEE+eGQMwxwBHIU4ZbOIqYOeXdtJZguQejFJg/Wx7i8YEfySXLd+Ak4ec4+Ld7dBY6DPDLX1mpf1frRBIxdj+9uL7N8zRqCZD1dyCVmbZ8X4I50YI9WEtmw7uoXFu4YR1KJqsUqZC8Shx8oKpjIJtX4HeAC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725860634; c=relaxed/simple;
	bh=PJB8MnDkY64lJweDrjdNdgxrCAth9X9p/HaOyMbjVAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VhzKoRRayhytYRUPuQyZltyqki2suwJO7Qd6fGRyG6Xo3zu+L5LAFSUyEpDXQO5ScMfB3M97vtTuooONhRAYr15Mmb2aQT3sy+bzHPqg1usJWeZM4AqQFMzrqzou3k1oRKfYggjdZxXVQfvty1U9EGVY2JEMD2UdNw3D6pTSoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FjgbLPZK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d5a54dcaefso2566675a12.2
        for <linux-arch@vger.kernel.org>; Sun, 08 Sep 2024 22:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725860628; x=1726465428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTSeEQvvLz7JMkJB8rY34SUA6KPOOIDr3cyazlDccxw=;
        b=FjgbLPZKVhfU2DWXWw/vaBN4AiU7a72MxExlOzESVkOU4SjQ9DN4jKTq+y/GpwILhE
         nGkj8H+cuSH6jVIkLN8egUsm0Ted/iBL4R08oRUo7yVzWPIO4Z304awPqdekLEA18g5p
         Mw2cj319aYt9sIDSryz+A8vDTOhW2WY4e8zO2nXzKjODkOlUeOIGpSFnozo3jY+7GebC
         UOFFCYusTlVhkTPnuft1hv7hrnnMsVVv75SrYgwGiVajRxz4c5tsFD3NUVQgV6y8qNGU
         xx9YJrfsBb9XlKQzwPt4xUgoSt1/NOK2N8dTS/MFWihI9RboOGtW/8fxmVoFlm5lUbNL
         8p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725860628; x=1726465428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTSeEQvvLz7JMkJB8rY34SUA6KPOOIDr3cyazlDccxw=;
        b=J7RTNWB4Jufk4fodv68YPjaYorPuBh/ctEuoA0HHRIuL8nYxx8m9jizaBA8F/nAwx1
         b1x0KsDaGVlVZW8xyRQzQu4VpfU8wBWG8a37BJ2dShk10TzO5qKC8PRa8t4jiHqIT1IR
         cbq0lFmJL6LRTr8IQJ1uSzQ2Sv2dpTDshuHxtoa5tM21O43yO8fE1xbvboLpjsG7+NnF
         4saYETI1x/E02uFZ4QKkhl+N3N2KbzlizzYyOFGFeqWI8H5E1rC3NjMPFCAQRDgph9W4
         aqGkcJnIzgp5PLs2MQKTAUvFRiwM3BqyhzOEP6/WesY65A7R97ZXyqJmjXoAjTdT79+p
         9mmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSUlqsdPB9Dr4C9MdoMRCV1nushKkkdpzuqBhwnNGXKQ8loMaJru13e8QYNqfPTeFyTRiHHnpKCy5d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/K2BXxl40gJ04Tl+n2sgTZmQKPb+1a57gqK5R/FQkmUFYQG/
	0gnmf3sUK1loIKSLEM/k+dLUbD9XccwbAaXx0b0f0v64EVxgbFxFWkNj/AhXwCfeVJYdwT/Ipp+
	3VmpJc7VKLc69/sDLjDgsyg==
X-Google-Smtp-Source: AGHT+IFlawdC4KCQfLhqI0Xy7yk4ED2go+LFfUpiqb3BRrNWwO5I+1bNuk03iJCYZid8NNj/xbpv1Yi7TsuSmuqPKg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a63:3755:0:b0:6f3:b24:6c27 with SMTP
 id 41be03b00d2f7-7d79f6e5f59mr68139a12.5.1725860627260; Sun, 08 Sep 2024
 22:43:47 -0700 (PDT)
Date: Mon,  9 Sep 2024 05:43:18 +0000
In-Reply-To: <20240909054318.1809580-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240909054318.1809580-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240909054318.1809580-14-almasrymina@google.com>
Subject: [PATCH net-next v25 13/13] netdev: add dmabuf introspection
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
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add dmabuf information to page_pool stats:

$ ./cli.py --spec ../netlink/specs/netdev.yaml --dump page-pool-get
...
 {'dmabuf': 10,
  'id': 456,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 455,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 454,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 453,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 452,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 451,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 450,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 449,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},

And queue stats:

$ ./cli.py --spec ../netlink/specs/netdev.yaml --dump queue-get
...
{'dmabuf': 10, 'id': 8, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 9, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 10, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 11, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 12, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 13, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 14, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 15, 'ifindex': 3, 'type': 'rx'},

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>

---

v24:
- Code cleanup, no cast and use 1 if statement (Jakub)

---
 Documentation/netlink/specs/netdev.yaml | 10 ++++++++++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/netdev-genl.c                  |  7 +++++++
 net/core/page_pool_user.c               |  5 +++++
 tools/include/uapi/linux/netdev.h       |  2 ++
 5 files changed, 26 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 0c747530c275..08412c279297 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -167,6 +167,10 @@ attribute-sets:
           "re-attached", they are just waiting to disappear.
           Attribute is absent if Page Pool has not been detached, and
           can still be used to allocate new memory.
+      -
+        name: dmabuf
+        doc: ID of the dmabuf this page-pool is attached to.
+        type: u32
   -
     name: page-pool-info
     subset-of: page-pool
@@ -268,6 +272,10 @@ attribute-sets:
         name: napi-id
         doc: ID of the NAPI instance which services this queue.
         type: u32
+      -
+        name: dmabuf
+        doc: ID of the dmabuf attached to this queue, if any.
+        type: u32
 
   -
     name: qstats
@@ -543,6 +551,7 @@ operations:
             - inflight
             - inflight-mem
             - detach-time
+            - dmabuf
       dump:
         reply: *pp-reply
       config-cond: page-pool
@@ -607,6 +616,7 @@ operations:
             - type
             - napi-id
             - ifindex
+            - dmabuf
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 91bf3ecc5f1d..7c308f04e7a0 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -93,6 +93,7 @@ enum {
 	NETDEV_A_PAGE_POOL_INFLIGHT,
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
+	NETDEV_A_PAGE_POOL_DMABUF,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
@@ -131,6 +132,7 @@ enum {
 	NETDEV_A_QUEUE_IFINDEX,
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
+	NETDEV_A_QUEUE_DMABUF,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9153a8ab0cf8..1cb954f2d39e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -295,6 +295,7 @@ static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
 {
+	struct net_devmem_dmabuf_binding *binding;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
 	void *hdr;
@@ -314,6 +315,12 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
 					     rxq->napi->napi_id))
 			goto nla_put_failure;
+
+		binding = rxq->mp_params.mp_priv;
+		if (binding &&
+		    nla_put_u32(rsp, NETDEV_A_QUEUE_DMABUF, binding->id))
+			goto nla_put_failure;
+
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index cd6267ba6fa3..48335766c1bf 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -9,6 +9,7 @@
 #include <net/page_pool/types.h>
 #include <net/sock.h>
 
+#include "devmem.h"
 #include "page_pool_priv.h"
 #include "netdev-genl-gen.h"
 
@@ -213,6 +214,7 @@ static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
 {
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
 	size_t inflight, refsz;
 	void *hdr;
 
@@ -242,6 +244,9 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 			 pool->user.detach_time))
 		goto err_cancel;
 
+	if (binding && nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
+		goto err_cancel;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 91bf3ecc5f1d..7c308f04e7a0 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -93,6 +93,7 @@ enum {
 	NETDEV_A_PAGE_POOL_INFLIGHT,
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
+	NETDEV_A_PAGE_POOL_DMABUF,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
@@ -131,6 +132,7 @@ enum {
 	NETDEV_A_QUEUE_IFINDEX,
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
+	NETDEV_A_QUEUE_DMABUF,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.46.0.469.g59c65b2a67-goog


