Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B957E18A8
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjKFCoX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFCoW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:44:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C4EE
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86766bba9fso2274348276.1
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238658; x=1699843458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp+hYAUZTc06RYPWJdBOgGluYhcxVNOvLIAb9uVqzaA=;
        b=TRBQh02oXE1zB24Mf2sA3q2XC8tR0in0w8Iv36Mjv6FlWuaR4cgJBx6p4wOGGWPLu8
         EdOQM/UF6lT9ruyabrICfvRi4rBvUGoDYTKqgJPvpu0am8ToFgQRaOminD854hAg8VKg
         TvoTaqBnela0F/qruU65AvSS+7WjH+wCdk/sjJoc5m0xHuAr8vFmv5fwq8J1w9wcOHfl
         uJsroPMCJDhDUWiwKvSRJoOpRLHni8lDxyb8BQJmdhubPXUlLPgV9wkB+VXUTdSERE1y
         RmU4Jd5bGq8TyzcyXnjeSlnvTn5XWowl3evZo6jzFjOebgfTbwaTTEj8bSYdvNomT1WX
         aPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238658; x=1699843458;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp+hYAUZTc06RYPWJdBOgGluYhcxVNOvLIAb9uVqzaA=;
        b=MdwIxMRKlxjYMYYbv8KDLAFt61DWxvG5KSZZkDfRKmFZofbUnbVdTntFHUFODeeTV1
         7tjplCK6QN7mKSeaxeFBbOkO1Rg+5zP5dmdyYx2ni4Hje2WhpvEAMF4n0irZ9N1OPnX4
         jr9AamsLopa/fH5zzeiAV6rskseoyxS3w1UPbP3/XhJlvfD9kCzyWbNsGEOgb+zwNrPC
         6qmPtCco7GBKzVLXILv11WSo8vCR+wmtLUYP7I+eZUno7ESGk0aZ8Dtx8Iv8OQ+c0xNi
         yiYUg+v94AaMP14YKW7C7Sy6Kjgs9PgPLzZMJKqb5G/8VmCsG8c64vg9qUPWk9jSjXng
         6pkw==
X-Gm-Message-State: AOJu0Yw6hR2EOiB9udIzz3zDppQacH4swhO61B5YCYLedL67iij/atI2
        7FnOf6aFPxUv100Ie0HOHltDR6Hh8IQyNPyPvg==
X-Google-Smtp-Source: AGHT+IGnuAfdlVJP41lHA/nTbtKFLzUzs3m0rNvZ6H4sTLSVpHSiqAfuURFhbOGHi4LN2t4rE5zsPo/O2PYcQ+2WDQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:6907:0:b0:d9a:cbf9:1c8d with SMTP
 id e7-20020a256907000000b00d9acbf91c8dmr510046ybc.12.1699238658163; Sun, 05
 Nov 2023 18:44:18 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:43:59 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-1-almasrymina@google.com>
Subject: [RFC PATCH v3 00/12] Device Memory TCP
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
        Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

Mina Almasry (10):
  net: netdev netlink api to bind dma-buf to a net device
  netdev: support binding dma-buf to netdevice
  netdev: netdevice devmem allocator
  memory-provider: dmabuf devmem memory provider
  page-pool: device memory support
  net: support non paged skb frags
  net: add support for skbs with unreadable frags
  tcp: RX path for devmem TCP
  net: add SO_DEVMEM_DONTNEED setsockopt to release RX pages
  selftests: add ncdevmem, netcat for devmem TCP

 Documentation/netlink/specs/netdev.yaml |  28 ++
 include/linux/netdevice.h               |  93 ++++
 include/linux/skbuff.h                  |  56 ++-
 include/linux/socket.h                  |   1 +
 include/net/netdev_rx_queue.h           |   1 +
 include/net/page_pool/helpers.h         | 151 ++++++-
 include/net/page_pool/types.h           |  55 +++
 include/net/sock.h                      |   2 +
 include/net/tcp.h                       |   5 +-
 include/uapi/asm-generic/socket.h       |   6 +
 include/uapi/linux/netdev.h             |  10 +
 include/uapi/linux/uio.h                |  10 +
 net/core/datagram.c                     |   6 +
 net/core/dev.c                          | 240 +++++++++++
 net/core/gro.c                          |   7 +-
 net/core/netdev-genl-gen.c              |  14 +
 net/core/netdev-genl-gen.h              |   1 +
 net/core/netdev-genl.c                  | 118 +++++
 net/core/page_pool.c                    | 209 +++++++--
 net/core/skbuff.c                       |  80 +++-
 net/core/sock.c                         |  36 ++
 net/ipv4/tcp.c                          | 205 ++++++++-
 net/ipv4/tcp_input.c                    |  13 +-
 net/ipv4/tcp_ipv4.c                     |   7 +
 net/ipv4/tcp_output.c                   |   5 +-
 net/packet/af_packet.c                  |   4 +-
 tools/include/uapi/linux/netdev.h       |  10 +
 tools/net/ynl/generated/netdev-user.c   |  42 ++
 tools/net/ynl/generated/netdev-user.h   |  47 ++
 tools/testing/selftests/net/.gitignore  |   1 +
 tools/testing/selftests/net/Makefile    |   5 +
 tools/testing/selftests/net/ncdevmem.c  | 546 ++++++++++++++++++++++++
 32 files changed, 1950 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/net/ncdevmem.c

--=20
2.42.0.869.gea05f2083d-goog

