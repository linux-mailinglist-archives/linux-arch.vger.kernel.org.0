Return-Path: <linux-arch+bounces-2794-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC7B8712E3
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 03:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C701F287141
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6DD7B3F8;
	Tue,  5 Mar 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfKALwNM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7274A2941C
	for <linux-arch@vger.kernel.org>; Tue,  5 Mar 2024 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604135; cv=none; b=rcCo2JApje1zbYX35iFPhWUAGscUCaxTwf2FBxqX0VCmdxHOf3XPsv5U9e8eccK31A5eNTUKgZYOi5DDgvz6aWTR+GnN+dKZFYtoWrx62Yr78szfgwUwwvpTzZkxcQRUeas2bXrBdeJVy1P/lsxYS1rSBgsr22JvdTlFHXNx2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604135; c=relaxed/simple;
	bh=cvQhiIpC3y+RS9Gm99XbZoZlqQ7K9itfikVyQItkfww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eNrxaHtQV1x2qpAzKd6qdK9R5KpNSxBiDCVttqgODqweflQc6Isfs9OkIfFwVk+1e11PchFZ2BYVvXafFoDcFwNFa4T/WoLPEuuYC/oVAnjJyT0OxmLaFPUEXriO7BMcnshv2YUmMK0Jri78lHLchHeAqiQcsHhOljU5YtsyLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AfKALwNM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso343566276.3
        for <linux-arch@vger.kernel.org>; Mon, 04 Mar 2024 18:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709604130; x=1710208930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYNPKIZQ281lVVO6ngxcCFyACEH85a0Tth4BHfTjTEU=;
        b=AfKALwNMjAAVlDN+SvPY8KglsT5I76vqxr0bHIbXyU+wTdjgM+Z7sMNwzvS5zYxwcd
         39LBe/XaH+3Xdd2o9ST323JA8QBylAl+49dz1wrf7ruYNgVsTzXpAA3M44Q/0kkSeFQZ
         XFf6wQvF2ppRphiGYJ71tlEBOo8i7RET1aLRI85pRsmOFnCnwO+dokpJmzrGwbInsp54
         +7gI9GnpZcT80vrKeam638irWwUbQRiOB+soGiYmGkQZNDx1Is/sW9ELvcbX88KMWnCl
         DQcaqbizaJJguAtAyU3L/8dglxpJd+vwBRTzWQSzOy4aaPoy7foT5HaXVUp+d8oRkIiy
         dSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604130; x=1710208930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYNPKIZQ281lVVO6ngxcCFyACEH85a0Tth4BHfTjTEU=;
        b=dw0vSTRz0AH06Yv0tVeodRkAVzKtjm+aTS6ceBXlN3I5FH+10/4/+vyebcPcAxxNfD
         JdaKosVnYS1dtCpC+Mpbp7s0tpU33YKRJw8RS9ZC1244Ds3ixRgHiDmdax2InYveQJJk
         M7ilR4MkFpci7tn0lyuX2TDmfaP4azn2G0WNj0eqSf0aAW+AB90MJt82kdPYvxsmyVNU
         kzI7Jq1uoagzrfSKNS2N34M3EnNLVK0agkfek0AXmYRkGWVfa1Hfpq5Ml/FEy9EnoB7D
         2rA1H8HqZNigVOb1IFbYtYhbiLD1Y+p2YVjs16WAPD14+krHx3/wx4EC8ho92T5Nag+W
         bSvg==
X-Forwarded-Encrypted: i=1; AJvYcCWJK5G7rp4lnzkG5m3lAYlGGr2f5ylC2MITyvJwjW7jpZWJfb/yEvwrd9wNYED4m0eD2t7UuF1+tnCl0kSQzPgAI3df5VQt41zADw==
X-Gm-Message-State: AOJu0YxXcBDgUznQti5tMSaxeiQYKG51MACrRkxInCK87sxFfSLe1Exm
	D18rF+MmPf6U4+WIwETtOhGKhozjV+bIdCgnYjiGEDQ6V5UQ1Fu+/cm3Wksx1PDDi0FOmfDM0rC
	NF2YvqmwRl4oRy95krkn3tw==
X-Google-Smtp-Source: AGHT+IFp6UEtUOWoZdRym40bjXyf80/9kbOdm1B3G9vAhJbMjUPJhOdTewfBOuFMN7wsO34DBHuDxFG4/drkODwMOA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b614:914c:63cd:3830])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2492:b0:dcb:b9d7:2760 with
 SMTP id ds18-20020a056902249200b00dcbb9d72760mr2965477ybb.13.1709604130576;
 Mon, 04 Mar 2024 18:02:10 -0800 (PST)
Date: Mon,  4 Mar 2024 18:01:41 -0800
In-Reply-To: <20240305020153.2787423-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305020153.2787423-7-almasrymina@google.com>
Subject: [RFC PATCH net-next v6 06/15] netdev: netdevice devmem allocator
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
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement netdev devmem allocator. The allocator takes a given struct
netdev_dmabuf_binding as input and allocates net_iov from that
binding.

The allocation simply delegates to the binding's genpool for the
allocation logic and wraps the returned memory region in a net_iov
struct.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v6:
- Add comment on net_iov_dma_addr to explain why we don't use
  niov->dma_addr (Pavel)
- Refactor new functions into net/core/devmem.c (Pavel)

v1:
- Rename devmem -> dmabuf (David).

---
 include/net/devmem.h | 12 ++++++++++++
 include/net/netmem.h | 40 ++++++++++++++++++++++++++++++++++++++++
 net/core/devmem.c    | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/include/net/devmem.h b/include/net/devmem.h
index 85ccbbe84c65..4207adadc2bb 100644
--- a/include/net/devmem.h
+++ b/include/net/devmem.h
@@ -67,6 +67,8 @@ struct dmabuf_genpool_chunk_owner {
 };
 
 #ifdef CONFIG_DMA_SHARED_BUFFER
+struct net_iov *netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding);
+void netdev_free_dmabuf(struct net_iov *ppiov);
 void __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		       struct netdev_dmabuf_binding **out);
@@ -74,6 +76,16 @@ void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				struct netdev_dmabuf_binding *binding);
 #else
+static inline struct net_iov *
+netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+	return NULL;
+}
+
+static inline void netdev_free_dmabuf(struct net_iov *ppiov)
+{
+}
+
 static inline void
 __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding)
 {
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 72e932a1a948..ca17ea1d33f8 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -14,8 +14,48 @@
 
 struct net_iov {
 	struct dmabuf_genpool_chunk_owner *owner;
+	unsigned long dma_addr;
 };
 
+static inline struct dmabuf_genpool_chunk_owner *
+net_iov_owner(const struct net_iov *niov)
+{
+	return niov->owner;
+}
+
+static inline unsigned int net_iov_idx(const struct net_iov *niov)
+{
+	return niov - net_iov_owner(niov)->niovs;
+}
+
+/* This returns the absolute dma_addr_t calculated from
+ * net_iov_owner(niov)->owner->base_dma_addr, not the page_pool-owned
+ * niov->dma_addr.
+ *
+ * The absolute dma_addr_t is a dma_addr_t that is always uncompressed.
+ *
+ * The page_pool-owner niov->dma_addr is the absolute dma_addr compressed into
+ * an unsigned long. Special handling is done when the unsigned long is 32-bit
+ * but the dma_addr_t is 64-bit.
+ *
+ * In general code looking for the dma_addr_t should use net_iov_dma_addr(),
+ * while page_pool code looking for the unsigned long dma_addr which mirrors
+ * the field in struct page should use niov->dma_addr.
+ */
+static inline dma_addr_t net_iov_dma_addr(const struct net_iov *niov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
+}
+
+static inline struct netdev_dmabuf_binding *
+net_iov_binding(const struct net_iov *niov)
+{
+	return net_iov_owner(niov)->binding;
+}
+
 /* netmem */
 
 /**
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 779ad990971e..57d3a1f223ef 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -93,6 +93,44 @@ static int netdev_restart_rx_queue(struct net_device *dev, int rxq_idx)
 	return err;
 }
 
+struct net_iov *netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+	struct dmabuf_genpool_chunk_owner *owner;
+	unsigned long dma_addr;
+	struct net_iov *niov;
+	ssize_t offset;
+	ssize_t index;
+
+	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
+					(void **)&owner);
+	if (!dma_addr)
+		return NULL;
+
+	offset = dma_addr - owner->base_dma_addr;
+	index = offset / PAGE_SIZE;
+	niov = &owner->niovs[index];
+
+	niov->pp_magic = 0;
+	niov->pp = NULL;
+	niov->dma_addr = 0;
+	atomic_long_set(&niov->pp_ref_count, 0);
+
+	netdev_dmabuf_binding_get(binding);
+
+	return niov;
+}
+
+void netdev_free_dmabuf(struct net_iov *niov)
+{
+	struct netdev_dmabuf_binding *binding = net_iov_binding(niov);
+	unsigned long dma_addr = net_iov_dma_addr(niov);
+
+	if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
+		gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
+
+	netdev_dmabuf_binding_put(binding);
+}
+
 /* Protected by rtnl_lock() */
 static DEFINE_XARRAY_FLAGS(netdev_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
-- 
2.44.0.rc1.240.g4c46232300-goog


