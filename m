Return-Path: <linux-arch+bounces-7195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F4973EE2
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCEC1F26C92
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8768C1A4F0F;
	Tue, 10 Sep 2024 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJYNjYQA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC91AAE0A
	for <linux-arch@vger.kernel.org>; Tue, 10 Sep 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988532; cv=none; b=Mj3hTIkDtsgpOrOjThqnNYP/eWVZWQGz/6UJexBE4rvZ2cJjSdsNfPdsJWjBUvXxia9KUQqAIZWKr3/PyefedoCENJVEiqj4ekZL/K2qpNHevVGVqet/pGt3g3LtZgCibGZn/NKYfyVEIQL33GWDgmJOjo9IrRTjnZW+MiPE7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988532; c=relaxed/simple;
	bh=+o3FPWweDXPLGq0SP+NGlcEpWYMyRWwJBLbCADlHI0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R4lOAWflSB+uUIwC+5N56by82E3zj6qCmrK3+ix2uOjML6ezuN8W+PNFkZ68rORXgYnFUVChnpB3njlEfxKGVrtwfdC9XueeLrLEQya/Ijg4iT4p/owG9ijzZMZEqK71g9zUWFDIQx56DKVTSsaDsJuGXHeailEBzY7d62MgaxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJYNjYQA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4f52a4069so189082607b3.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Sep 2024 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725988521; x=1726593321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ahWJRPxl3RKmOCwH9SnfbagHaRKiJ7Meo+SFMxhVQI=;
        b=XJYNjYQAFw6XMlTMg9PAaAHf976Gxicel4RohHLOnI/HZ68ZnjoeEf94NtLVhOswj+
         mOjIQlmrxXsXtW6HPCi0EOwsnY6I+7U8DeHmxXRMtZFansw9IWXSYocMk1fiEWBJyzZZ
         QR/hnd1FOBH9SOGRIhg1BDyfmA6TrS2J7Q0IyCafFWgdkhdCmb+IV6c3J/BlmmEeGdq8
         iyooD6LN8uSFP93BpWfeP0YKMuRfEwiM9tMGRPaffmYQoqGlky4VHKku7f74SSU+nP4N
         k24e8TBxDwPWcH6ZJg9bO7vvHM/0NAj6M4+Y+WVy3h5u0kWng1RUYX9bj1YyWnc8P5wa
         7CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988521; x=1726593321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ahWJRPxl3RKmOCwH9SnfbagHaRKiJ7Meo+SFMxhVQI=;
        b=BmbYxyvDyZeKlFixtX/2WuWgoNNXjUJ9pCo0ONpylQJlrchisIpuTyyKCm/rt3fZ99
         cEvpaXqEZNF7yEDuYplafr3LOBj+XUCUyEEJIUSeVysto0G4w/oFdE9daEbjUa1+2rkY
         lB1fR1JtmvH3IPxH65xsjdQceq9M1V4DV6AaDULGYQGyFzNsR9Dm4YgrransmT3/tIWY
         CKlyRzufephrCuBq6gpQBBwPRvKeAeQY3M6lpOTyc++kKRsikeoeO/iY+qYMb4nwVhLJ
         bTHD35y+VWDhDntzyAJh0/oKZix3YTxVZmB5MTPT4dCUtoGlCqyfI4eZtfHW+z53qGhU
         0Udw==
X-Forwarded-Encrypted: i=1; AJvYcCUxD7XZPB7fOFlTiB85wMzx8CGeWSXnobKW/HGuZlMdJBVxR4WN2+D7ZoOJegKxh+9y79L9Rku3eE81@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLpCBc+43WSZS/lsOubYvHbtdUZAK9qPoxIAvUQEIldoExJi2
	ST86VvY1vyEd+0gRVnGIxklm2NmRMqotpBfPLh+SnDv8XrleuSbh+Vby2UFTPwv3P7ckC1iup0a
	XnnJ12xUzc4/YJC0HqpoyjA==
X-Google-Smtp-Source: AGHT+IFBDXv/QHCqfMFAsH2X3RBNNckQ7Lyawyra03ikUvBR/jauQEtFiFX1r/5ZjqH9EaYHnnhdMKPcYHnI9O9H/g==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:6645:0:b0:e11:639b:6428 with SMTP
 id 3f1490d57ef6-e1d346b2b64mr32795276.0.1725988521418; Tue, 10 Sep 2024
 10:15:21 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:14:55 +0000
In-Reply-To: <20240910171458.219195-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910171458.219195-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910171458.219195-12-almasrymina@google.com>
Subject: [PATCH net-next v26 11/13] net: add devmem TCP documentation
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
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
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

Add documentation outlining the usage and details of devmem TCP.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

---

v25:
- Doc cleanups (Jakub)

v16:
- Add documentation on unbinding the NIC from dmabuf (Donald).
- Add note that any dmabuf should work (Donald).

v9: https://lore.kernel.org/netdev/20240403002053.2376017-14-almasrymina@google.com/
- Bagas doc suggestions.

v8:
- Applied docs suggestions (Randy). Thanks!

v7:
- Applied docs suggestions (Jakub).

v2:

- Missing spdx (simon)
- add to index.rst (simon)

---
 Documentation/networking/devmem.rst | 269 ++++++++++++++++++++++++++++
 Documentation/networking/index.rst  |   1 +
 2 files changed, 270 insertions(+)
 create mode 100644 Documentation/networking/devmem.rst

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
new file mode 100644
index 000000000000..a55bf21f671c
--- /dev/null
+++ b/Documentation/networking/devmem.rst
@@ -0,0 +1,269 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Device Memory TCP
+=================
+
+
+Intro
+=====
+
+Device memory TCP (devmem TCP) enables receiving data directly into device
+memory (dmabuf). The feature is currently implemented for TCP sockets.
+
+
+Opportunity
+-----------
+
+A large number of data transfers have device memory as the source and/or
+destination. Accelerators drastically increased the prevalence of such
+transfers.  Some examples include:
+
+- Distributed training, where ML accelerators, such as GPUs on different hosts,
+  exchange data.
+
+- Distributed raw block storage applications transfer large amounts of data with
+  remote SSDs. Much of this data does not require host processing.
+
+Typically the Device-to-Device data transfers in the network are implemented as
+the following low-level operations: Device-to-Host copy, Host-to-Host network
+transfer, and Host-to-Device copy.
+
+The flow involving host copies is suboptimal, especially for bulk data transfers,
+and can put significant strains on system resources such as host memory
+bandwidth and PCIe bandwidth.
+
+Devmem TCP optimizes this use case by implementing socket APIs that enable
+the user to receive incoming network packets directly into device memory.
+
+Packet payloads go directly from the NIC to device memory.
+
+Packet headers go to host memory and are processed by the TCP/IP stack
+normally. The NIC must support header split to achieve this.
+
+Advantages:
+
+- Alleviate host memory bandwidth pressure, compared to existing
+  network-transfer + device-copy semantics.
+
+- Alleviate PCIe bandwidth pressure, by limiting data transfer to the lowest
+  level of the PCIe tree, compared to the traditional path which sends data
+  through the root complex.
+
+
+More Info
+---------
+
+  slides, video
+    https://netdevconf.org/0x17/sessions/talk/device-memory-tcp.html
+
+  patchset
+    [PATCH net-next v24 00/13] Device Memory TCP
+    https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymina@google.com/
+
+
+Interface
+=========
+
+
+Example
+-------
+
+tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
+the RX path of this API.
+
+
+NIC Setup
+---------
+
+Header split, flow steering, & RSS are required features for devmem TCP.
+
+Header split is used to split incoming packets into a header buffer in host
+memory, and a payload buffer in device memory.
+
+Flow steering & RSS are used to ensure that only flows targeting devmem land on
+an RX queue bound to devmem.
+
+Enable header split & flow steering::
+
+	# enable header split
+	ethtool -G eth1 tcp-data-split on
+
+
+	# enable flow steering
+	ethtool -K eth1 ntuple on
+
+Configure RSS to steer all traffic away from the target RX queue (queue 15 in
+this example)::
+
+	ethtool --set-rxfh-indir eth1 equal 15
+
+
+The user must bind a dmabuf to any number of RX queues on a given NIC using
+the netlink API::
+
+	/* Bind dmabuf to NIC RX queue 15 */
+	struct netdev_queue *queues;
+	queues = malloc(sizeof(*queues) * 1);
+
+	queues[0]._present.type = 1;
+	queues[0]._present.idx = 1;
+	queues[0].type = NETDEV_RX_QUEUE_TYPE_RX;
+	queues[0].idx = 15;
+
+	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+
+	req = netdev_bind_rx_req_alloc();
+	netdev_bind_rx_req_set_ifindex(req, 1 /* ifindex */);
+	netdev_bind_rx_req_set_dmabuf_fd(req, dmabuf_fd);
+	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
+
+	rsp = netdev_bind_rx(*ys, req);
+
+	dmabuf_id = rsp->dmabuf_id;
+
+
+The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
+that has been bound.
+
+The user can unbind the dmabuf from the netdevice by closing the netlink socket
+that established the binding. We do this so that the binding is automatically
+unbound even if the userspace process crashes.
+
+Note that any reasonably well-behaved dmabuf from any exporter should work with
+devmem TCP, even if the dmabuf is not actually backed by devmem. An example of
+this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
+
+
+Socket Setup
+------------
+
+The socket must be flow steered to the dmabuf bound RX queue::
+
+	ethtool -N eth1 flow-type tcp4 ... queue 15
+
+
+Receiving data
+--------------
+
+The user application must signal to the kernel that it is capable of receiving
+devmem data by passing the MSG_SOCK_DEVMEM flag to recvmsg::
+
+	ret = recvmsg(fd, &msg, MSG_SOCK_DEVMEM);
+
+Applications that do not specify the MSG_SOCK_DEVMEM flag will receive an EFAULT
+on devmem data.
+
+Devmem data is received directly into the dmabuf bound to the NIC in 'NIC
+Setup', and the kernel signals such to the user via the SCM_DEVMEM_* cmsgs::
+
+		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+			if (cm->cmsg_level != SOL_SOCKET ||
+				(cm->cmsg_type != SCM_DEVMEM_DMABUF &&
+				 cm->cmsg_type != SCM_DEVMEM_LINEAR))
+				continue;
+
+			dmabuf_cmsg = (struct dmabuf_cmsg *)CMSG_DATA(cm);
+
+			if (cm->cmsg_type == SCM_DEVMEM_DMABUF) {
+				/* Frag landed in dmabuf.
+				 *
+				 * dmabuf_cmsg->dmabuf_id is the dmabuf the
+				 * frag landed on.
+				 *
+				 * dmabuf_cmsg->frag_offset is the offset into
+				 * the dmabuf where the frag starts.
+				 *
+				 * dmabuf_cmsg->frag_size is the size of the
+				 * frag.
+				 *
+				 * dmabuf_cmsg->frag_token is a token used to
+				 * refer to this frag for later freeing.
+				 */
+
+				struct dmabuf_token token;
+				token.token_start = dmabuf_cmsg->frag_token;
+				token.token_count = 1;
+				continue;
+			}
+
+			if (cm->cmsg_type == SCM_DEVMEM_LINEAR)
+				/* Frag landed in linear buffer.
+				 *
+				 * dmabuf_cmsg->frag_size is the size of the
+				 * frag.
+				 */
+				continue;
+
+		}
+
+Applications may receive 2 cmsgs:
+
+- SCM_DEVMEM_DMABUF: this indicates the fragment landed in the dmabuf indicated
+  by dmabuf_id.
+
+- SCM_DEVMEM_LINEAR: this indicates the fragment landed in the linear buffer.
+  This typically happens when the NIC is unable to split the packet at the
+  header boundary, such that part (or all) of the payload landed in host
+  memory.
+
+Applications may receive no SO_DEVMEM_* cmsgs. That indicates non-devmem,
+regular TCP data that landed on an RX queue not bound to a dmabuf.
+
+
+Freeing frags
+-------------
+
+Frags received via SCM_DEVMEM_DMABUF are pinned by the kernel while the user
+processes the frag. The user must return the frag to the kernel via
+SO_DEVMEM_DONTNEED::
+
+	ret = setsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_DONTNEED, &token,
+			 sizeof(token));
+
+The user must ensure the tokens are returned to the kernel in a timely manner.
+Failure to do so will exhaust the limited dmabuf that is bound to the RX queue
+and will lead to packet drops.
+
+
+Implementation & Caveats
+========================
+
+Unreadable skbs
+---------------
+
+Devmem payloads are inaccessible to the kernel processing the packets. This
+results in a few quirks for payloads of devmem skbs:
+
+- Loopback is not functional. Loopback relies on copying the payload, which is
+  not possible with devmem skbs.
+
+- Software checksum calculation fails.
+
+- TCP Dump and bpf can't access devmem packet payloads.
+
+
+Testing
+=======
+
+More realistic example code can be found in the kernel source under
+``tools/testing/selftests/net/ncdevmem.c``
+
+ncdevmem is a devmem TCP netcat. It works very similarly to netcat, but
+receives data directly into a udmabuf.
+
+To run ncdevmem, you need to run it on a server on the machine under test, and
+you need to run netcat on a peer to provide the TX data.
+
+ncdevmem has a validation mode as well that expects a repeating pattern of
+incoming data and validates it as such. For example, you can launch
+ncdevmem on the server by::
+
+	ncdevmem -s <server IP> -c <client IP> -f eth1 -d 3 -n 0000:06:00.0 -l \
+		 -p 5201 -v 7
+
+On client side, use regular netcat to send TX data to ncdevmem process
+on the server::
+
+	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
+		tr \\n \\0 | head -c 5G | nc <server IP> 5201 -p 5201
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index c71b87346178..08f437c326ab 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -49,6 +49,7 @@ Contents:
    cdc_mbim
    dccp
    dctcp
+   devmem
    dns_resolver
    driver
    eql
-- 
2.46.0.598.g6f2099f65c-goog


