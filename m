Return-Path: <linux-arch+bounces-760-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C888097B2
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 01:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB872820C8
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 00:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED425ED0;
	Fri,  8 Dec 2023 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yRvIryS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A7F1720
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 16:52:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db5508d1beeso1688894276.2
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 16:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996774; x=1702601574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oEC4/5l5n2T/qYCGKqOGy0FALO1z9p8+l3xS5q5p7gQ=;
        b=1yRvIryS++LOF7rZgQjLmhWhBdq+ZVoZiX1AEsXDl6r/d6bKOY5h4CTDFTDV8b5S0W
         AtYzriitQ/xJ87bwOcBynN/f8TP1No5i6UcAOaXtPwoTiYzn4C9rcJDh1PTPZCFjtGiq
         7hpyV9SbXVZtpZpsGeDrt8DaczFGkE03yFHlMMn5AiUE99jagXrUDd9DzIuqlAB3GLye
         X0qD/TxAKM+fIiy6gy6RYm88A09pfS4TQDLJyGD1IiGPoEDwqg14nqDIElX8eNQjXQ4I
         CTT/Zv9GxG70eS/dZwmz8/lVVKKy0kE3aAMOt4hm5atLzCk2nAeB+x+IyU5UfzZ84gX0
         IXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996774; x=1702601574;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEC4/5l5n2T/qYCGKqOGy0FALO1z9p8+l3xS5q5p7gQ=;
        b=alQkZeVv5Yg2KF5ECv/Aht77weCz1Ss2fh8kmxrvbky+z+jLqxRR4m0pJzlWXPY+J7
         TRPZSWpGYMj3O3CgHb0/tSq2v0Mf22VLgLSDAOEmEHzvjp4YNmyl3Jmlo+R1lkmL39fa
         vF2c/9VRtQDhdEEzqM7cPWOw0bK6BfEsekv9Ya5kOPHp/L/FuQ883mmtON91pJDugWcz
         +191iVIZVdjOUxNNRvvNJQxqsC1+AKl0pYhk1LagzdKfc6PdRisHgyQzfHyzLXW/gWwm
         oEX57qNRt3M57cO8jdhd8vD/am1V+4p5zMEMVHmVBsrHHp3OLjx9U5boAc2PPL/3JMzB
         dmfg==
X-Gm-Message-State: AOJu0YxcEVHrTDC65f2km1QwKrhUGQhx0Aj22SaqY60uhwnWaZ6fbXod
	ErQzFB4Xk3cbbf49CpKB1siUsvn5P8Kq5svPMw==
X-Google-Smtp-Source: AGHT+IHYY0Ghq58S/RpY3ORPjaG8n8Br1tdy1AIbfHpQKaWiIsvY0prGLnPYkvrfw7nIyRm1+GyE8RVLx8dfKnoykA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a25:e688:0:b0:dbc:1b8a:ea84 with SMTP
 id d130-20020a25e688000000b00dbc1b8aea84mr37055ybh.7.1701996774666; Thu, 07
 Dec 2023 16:52:54 -0800 (PST)
Date: Thu,  7 Dec 2023 16:52:31 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-1-almasrymina@google.com>
Subject: [net-next v1 00/16] Device Memory TCP
From: Mina Almasry <almasrymina@google.com>
To: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Major changes in v1:
--------------

1. Implemented MVP queue API ndos to remove the userspace-visible
   driver reset.

2. Fixed issues in the napi_pp_put_page() devmem frag unref path.

3. Removed RFC tag.

Many smaller addressed comments across all the patches (patches have
individual change log).

Full tree including the rest of the GVE driver changes:
https://github.com/mina/linux/commits/tcpdevmem-v1

Cc: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Shailend Chand <shailend@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>

Changes in RFC v3:
------------------

1. Pulled in the memory-provider dependency from Jakub's RFC[1] to make the
   series reviewable and mergable.

2. Implemented multi-rx-queue binding which was a todo in v2.

3. Fix to cmsg handling.

The sticking point in RFC v2[2] was the device reset required to refill
the device rx-queues after the dmabuf bind/unbind. The solution
suggested as I understand is a subset of the per-queue management ops
Jakub suggested or similar:

https://lore.kernel.org/netdev/20230815171638.4c057dcd@kernel.org/

This is not addressed in this revision, because:

1. This point was discussed at netconf & netdev and there is openness to
   using the current approach of requiring a device reset.

2. Implementing individual queue resetting seems to be difficult for my
   test bed with GVE. My prototype to test this ran into issues with the
   rx-queues not coming back up properly if reset individually. At the
   moment I'm unsure if it's a mistake in the POC or a genuine issue in
   the virtualization stack behind GVE, which currently doesn't test
   individual rx-queue restart.

3. Our usecases are not bothered by requiring a device reset to refill
   the buffer queues, and we'd like to support NICs that run into this
   limitation with resetting individual queues.

My thought is that drivers that have trouble with per-queue configs can
use the support in this series, while drivers that support new netdev
ops to reset individual queues can automatically reset the queue as
part of the dma-buf bind/unbind.

The same approach with device resets is presented again for consideration
with other sticking points addressed.

This proposal includes the rx devmem path only proposed for merge. For a
snapshot of my entire tree which includes the GVE POC page pool support &
device memory support:

https://github.com/torvalds/linux/compare/master...mina:linux:tcpdevmem-v3

[1] https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@red=
hat.com/T/
[2] https://lore.kernel.org/netdev/CAHS8izOVJGJH5WF68OsRWFKJid1_huzzUK+hpKb=
LcL4pSOD1Jw@mail.gmail.com/T/

Cc: Shakeel Butt <shakeelb@google.com>
Cc: Jeroen de Borst <jeroendb@google.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>

Changes in RFC v2:
------------------

The sticking point in RFC v1[1] was the dma-buf pages approach we used to
deliver the device memory to the TCP stack. RFC v2 is a proof-of-concept
that attempts to resolve this by implementing scatterlist support in the
networking stack, such that we can import the dma-buf scatterlist
directly. This is the approach proposed at a high level here[2].

Detailed changes:
1. Replaced dma-buf pages approach with importing scatterlist into the
   page pool.
2. Replace the dma-buf pages centric API with a netlink API.
3. Removed the TX path implementation - there is no issue with
   implementing the TX path with scatterlist approach, but leaving
   out the TX path makes it easier to review.
4. Functionality is tested with this proposal, but I have not conducted
   perf testing yet. I'm not sure there are regressions, but I removed
   perf claims from the cover letter until they can be re-confirmed.
5. Added Signed-off-by: contributors to the implementation.
6. Fixed some bugs with the RX path since RFC v1.

Any feedback welcome, but specifically the biggest pending questions
needing feedback IMO are:

1. Feedback on the scatterlist-based approach in general.
2. Netlink API (Patch 1 & 2).
3. Approach to handle all the drivers that expect to receive pages from
   the page pool (Patch 6).

[1] https://lore.kernel.org/netdev/dfe4bae7-13a0-3c5d-d671-f61b375cb0b4@gma=
il.com/T/
[2] https://lore.kernel.org/netdev/CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8n=
zTLXCc=3DH7Nw@mail.gmail.com/

----------------------

* TL;DR:

Device memory TCP (devmem TCP) is a proposal for transferring data to and/o=
r
from device memory efficiently, without bouncing the data to a host memory
buffer.

* Problem:

A large amount of data transfers have device memory as the source and/or
destination. Accelerators drastically increased the volume of such transfer=
s.
Some examples include:
- ML accelerators transferring large amounts of training data from storage =
into
  GPU/TPU memory. In some cases ML training setup time can be as long as 50=
% of
  TPU compute time, improving data transfer throughput & efficiency can hel=
p
  improving GPU/TPU utilization.

- Distributed training, where ML accelerators, such as GPUs on different ho=
sts,
  exchange data among them.

- Distributed raw block storage applications transfer large amounts of data=
 with
  remote SSDs, much of this data does not require host processing.

Today, the majority of the Device-to-Device data transfers the network are
implemented as the following low level operations: Device-to-Host copy,
Host-to-Host network transfer, and Host-to-Device copy.

The implementation is suboptimal, especially for bulk data transfers, and c=
an
put significant strains on system resources, such as host memory bandwidth,
PCIe bandwidth, etc. One important reason behind the current state is the
kernel=E2=80=99s lack of semantics to express device to network transfers.

* Proposal:

In this patch series we attempt to optimize this use case by implementing
socket APIs that enable the user to:

1. send device memory across the network directly, and
2. receive incoming network packets directly into device memory.

Packet _payloads_ go directly from the NIC to device memory for receive and=
 from
device memory to NIC for transmit.
Packet _headers_ go to/from host memory and are processed by the TCP/IP sta=
ck
normally. The NIC _must_ support header split to achieve this.

Advantages:

- Alleviate host memory bandwidth pressure, compared to existing
 network-transfer + device-copy semantics.

- Alleviate PCIe BW pressure, by limiting data transfer to the lowest level
  of the PCIe tree, compared to traditional path which sends data through t=
he
  root complex.

* Patch overview:

** Part 1: netlink API

Gives user ability to bind dma-buf to an RX queue.

** Part 2: scatterlist support

Currently the standard for device memory sharing is DMABUF, which doesn't
generate struct pages. On the other hand, networking stack (skbs, drivers, =
and
page pool) operate on pages. We have 2 options:

1. Generate struct pages for dmabuf device memory, or,
2. Modify the networking stack to process scatterlist.

Approach #1 was attempted in RFC v1. RFC v2 implements approach #2.

** part 3: page pool support

We piggy back on page pool memory providers proposal:
https://github.com/kuba-moo/linux/tree/pp-providers

It allows the page pool to define a memory provider that provides the
page allocation and freeing. It helps abstract most of the device memory
TCP changes from the driver.

** part 4: support for unreadable skb frags

Page pool iovs are not accessible by the host; we implement changes
throughput the networking stack to correctly handle skbs with unreadable
frags.

** Part 5: recvmsg() APIs

We define user APIs for the user to send and receive device memory.

Not included with this RFC is the GVE devmem TCP support, just to
simplify the review. Code available here if desired:
https://github.com/mina/linux/tree/tcpdevmem

This RFC is built on top of net-next with Jakub's pp-providers changes
cherry-picked.

* NIC dependencies:

1. (strict) Devmem TCP require the NIC to support header split, i.e. the
   capability to split incoming packets into a header + payload and to put
   each into a separate buffer. Devmem TCP works by using device memory
   for the packet payload, and host memory for the packet headers.

2. (optional) Devmem TCP works better with flow steering support & RSS supp=
ort,
   i.e. the NIC's ability to steer flows into certain rx queues. This allow=
s the
   sysadmin to enable devmem TCP on a subset of the rx queues, and steer
   devmem TCP traffic onto these queues and non devmem TCP elsewhere.

The NIC I have access to with these properties is the GVE with DQO support
running in Google Cloud, but any NIC that supports these features would suf=
fice.
I may be able to help reviewers bring up devmem TCP on their NICs.

* Testing:

The series includes a udmabuf kselftest that show a simple use case of
devmem TCP and validates the entire data path end to end without
a dependency on a specific dmabuf provider.

** Test Setup

Kernel: net-next with this RFC and memory provider API cherry-picked
locally.

Hardware: Google Cloud A3 VMs.

NIC: GVE with header split & RSS & flow steering support.

Jakub Kicinski (2):
  net: page_pool: factor out releasing DMA from releasing the page
  net: page_pool: create hooks for custom page providers

Mina Almasry (14):
  queue_api: define queue api
  gve: implement queue api
  net: netdev netlink api to bind dma-buf to a net device
  netdev: support binding dma-buf to netdevice
  netdev: netdevice devmem allocator
  memory-provider: dmabuf devmem memory provider
  page_pool: device memory support
  page_pool: don't release iov on elevanted refcount
  net: support non paged skb frags
  net: add support for skbs with unreadable frags
  tcp: RX path for devmem TCP
  net: add SO_DEVMEM_DONTNEED setsockopt to release RX frags
  net: add devmem TCP documentation
  selftests: add ncdevmem, netcat for devmem TCP

 Documentation/netlink/specs/netdev.yaml      |  52 ++
 Documentation/networking/devmem.rst          | 270 ++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.c |   6 +-
 drivers/net/ethernet/google/gve/gve_adminq.h |   3 +
 drivers/net/ethernet/google/gve/gve_dqo.h    |   2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 286 +++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |   5 +-
 include/linux/netdevice.h                    |  24 +
 include/linux/skbuff.h                       |  56 ++-
 include/linux/socket.h                       |   1 +
 include/net/devmem.h                         | 109 +++++
 include/net/netdev_rx_queue.h                |   1 +
 include/net/page_pool/helpers.h              | 162 +++++-
 include/net/page_pool/types.h                |  48 ++
 include/net/sock.h                           |   2 +
 include/net/tcp.h                            |   5 +-
 include/uapi/asm-generic/socket.h            |   6 +
 include/uapi/linux/netdev.h                  |  19 +
 include/uapi/linux/uio.h                     |  14 +
 net/core/datagram.c                          |   6 +
 net/core/dev.c                               | 314 +++++++++++-
 net/core/gro.c                               |   7 +-
 net/core/netdev-genl-gen.c                   |  19 +
 net/core/netdev-genl-gen.h                   |   2 +
 net/core/netdev-genl.c                       | 124 +++++
 net/core/page_pool.c                         | 239 +++++++--
 net/core/skbuff.c                            | 108 +++-
 net/core/sock.c                              |  38 ++
 net/ipv4/tcp.c                               | 196 +++++++-
 net/ipv4/tcp_input.c                         |  13 +-
 net/ipv4/tcp_ipv4.c                          |   8 +
 net/ipv4/tcp_output.c                        |   5 +-
 net/packet/af_packet.c                       |   4 +-
 tools/include/uapi/linux/netdev.h            |  19 +
 tools/testing/selftests/net/.gitignore       |   1 +
 tools/testing/selftests/net/Makefile         |   5 +
 tools/testing/selftests/net/ncdevmem.c       | 489 +++++++++++++++++++
 37 files changed, 2585 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/networking/devmem.rst
 create mode 100644 include/net/devmem.h
 create mode 100644 tools/testing/selftests/net/ncdevmem.c

--=20
2.43.0.472.g3155946c3a-goog


