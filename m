Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2C774E137
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGJWdk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjGJWdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:33:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA81B8
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:33:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573d70da2afso55016247b3.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689028416; x=1691620416;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vww/pYdC1DJeva2AfnXbGu4C5u6TgbMhBMBTAdXoxfg=;
        b=tYuqkf1i1ML5V4o25T0vWw2AWYvTHmOdYjkPseY2zygasjrULUgRP0lpwslZq4BlNn
         r1p4R05iJaCaBeDKpj43UQs0ywurMXa8xm/jLGob/nvAh3tjpHM1PVLFapsJwR/ka1YV
         OCsLUyi/uoR6UBz4oCwsZPYuOl7NB6tSRitea5cmk6T+xQOOyfhtosCAuCmmHP3pASl3
         FTJcJXa6DUCUieE5FhnpIjd11iJE7Eyy6HtGjsye3wuVkng9TA1g9wlYGDtVF3B0KaVO
         3HzZZK95D11PQUMva7mNWvWl66mMUrB5ooxHO0g24qTp1JovuF4cWpSDU4WzfBUUTKLM
         wSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028416; x=1691620416;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vww/pYdC1DJeva2AfnXbGu4C5u6TgbMhBMBTAdXoxfg=;
        b=HOUKNePi/Ub2U9aAu85Y3eNx59P7gt6ADlXcvfXntT63XGL0saZJ7f/Ivwn7qwOOBp
         LAzY1Mo1hnOBg90HaSyL0iydFDLpV90KgWdzQvKqirDmKEyLYIEDxWv6hGxUSMWfPHRi
         wiDLTzmyHTMi5e63NeCrF0C12kL8dPHGFGh4U73mTpPyWFIzmTpTBtnZpzFW7NCnvFMt
         e6KjBHIetYwj2wCjzp4PukmB103i1otI+9wrUOKC7xiXiLKGuk+k0mfKZ2GjuGYHWNpm
         mi4BllYzv+j8RYEX6kdSc0x0xl314zMapMyRb2cvG4YthUEMJnXdQOFO4+kaI1KewWK8
         PeBQ==
X-Gm-Message-State: ABy/qLZBZNKRTmUbwptbvmgp0ridmhi8hLvRrU1P+EqUR6o7f8UJC2WT
        lfeMMIYG41TVvAFLxkY+ddMQ8/0YLORWAcUxCA==
X-Google-Smtp-Source: APBJJlEO8eLcuFuH8wVnMQWAHkbzZWQHuwFwsGmDwYpzfNPSGiEWAwrAUfjiTOVp1l1HiHVrM6vyb9Q+AKeZ71Ccyg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c0f:bfb6:9942:8c53])
 (user=almasrymina job=sendgmr) by 2002:a81:ad44:0:b0:565:9e73:f937 with SMTP
 id l4-20020a81ad44000000b005659e73f937mr67586ywk.4.1689028416099; Mon, 10 Jul
 2023 15:33:36 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:32:51 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230710223304.1174642-1-almasrymina@google.com>
Subject: [RFC PATCH 00/10] Device Memory TCP
From:   Mina Almasry <almasrymina@google.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Mina Almasry <almasrymina@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
kernel=E2=80=99s lack of semantics to express device to network transfers.=
=C2=A0

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

With this proposal we're able to reach ~96.6% line rate speeds with data se=
nt
and received directly from/to device memory.

* Patch overview:

** Part 1: struct paged device memory

Currently the standard for device memory sharing is DMABUF, which doesn't
generate struct pages. On the other hand, networking stack (skbs, drivers, =
and
page pool) operate on pages. We have 2 options:

1. Generate struct pages for dmabuf device memory, or,
2. Modify the networking stack to understand a new memory type.

This proposal implements option #1. We implement a small framework to gener=
ate
struct pages for an sg_table returned from dma_buf_map_attachment(). The su=
pport
added here should be generic and easily extended to other use cases interes=
ted
in struct paged device memory. We use this framework to generate pages that=
 can
be used in the networking stack.

** Part 2: recvmsg() & sendmsg() APIs

We define user APIs for the user to send and receive these dmabuf pages.

** part 3: support for unreadable skb frags

Dmabuf pages are not accessible by the host; we implement changes throughpu=
t the
networking stack to correctly handle skbs with unreadable frags.

** part 4: page pool support

We piggy back on Jakub's page pool memory providers idea:
https://github.com/kuba-moo/linux/tree/pp-providers

It allows the page pool to define a memory provider that provides the
page allocation and freeing. It helps abstract most of the device memory TC=
P
changes from the driver.

This is not strictly necessary, the driver can choose to allocate dmabuf pa=
ges
and use them directly without going through the page pool (if acceptable to
their maintainers).

Not included with this RFC is the GVE devmem TCP support, just to
simplify the review. Code available here if desired:
https://github.com/mina/linux/tree/tcpdevmem

This RFC is built on top of v6.4-rc7 with Jakub's pp-providers changes
cherry-picked.

* NIC dependencies:

1. (strict) Devmem TCP require the NIC to support header split, i.e. the
   capability to split incoming packets into a header + payload and to put
   each into a separate buffer. Devmem TCP works by using dmabuf pages
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

Not included in this series is our devmem TCP benchmark, which
transfers data to/from GPU dmabufs directly.

With this implementation & benchmark we're able to reach ~96.6% line rate
speeds with 4 GPU/NIC pairs running bi-direction traffic, with all the
packet payloads going straight to the GPU memory (no host buffer bounce).

** Test Setup

Kernel: v6.4-rc7, with this RFC and Jakub's memory provider API
cherry-picked locally.

Hardware: Google Cloud A3 VMs.

NIC: GVE with header split & RSS & flow steering support.

Benchmark: custom devmem TCP benchmark not yet open sourced.

Mina Almasry (10):
  dma-buf: add support for paged attachment mappings
  dma-buf: add support for NET_RX pages
  dma-buf: add support for NET_TX pages
  net: add support for skbs with unreadable frags
  tcp: implement recvmsg() RX path for devmem TCP
  net: add SO_DEVMEM_DONTNEED setsockopt to release RX pages
  tcp: implement sendmsg() TX path for for devmem tcp
  selftests: add ncdevmem, netcat for devmem TCP
  memory-provider: updates core provider API for devmem TCP
  memory-provider: add dmabuf devmem provider

 drivers/dma-buf/dma-buf.c              | 444 ++++++++++++++++
 include/linux/dma-buf.h                | 142 +++++
 include/linux/netdevice.h              |   1 +
 include/linux/skbuff.h                 |  34 +-
 include/linux/socket.h                 |   1 +
 include/net/page_pool.h                |  21 +
 include/net/sock.h                     |   4 +
 include/net/tcp.h                      |   6 +-
 include/uapi/asm-generic/socket.h      |   6 +
 include/uapi/linux/dma-buf.h           |  12 +
 include/uapi/linux/uio.h               |  10 +
 net/core/datagram.c                    |   3 +
 net/core/page_pool.c                   | 111 +++-
 net/core/skbuff.c                      |  81 ++-
 net/core/sock.c                        |  47 ++
 net/ipv4/tcp.c                         | 262 +++++++++-
 net/ipv4/tcp_input.c                   |  13 +-
 net/ipv4/tcp_ipv4.c                    |   8 +
 net/ipv4/tcp_output.c                  |   5 +-
 net/packet/af_packet.c                 |   4 +-
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   1 +
 tools/testing/selftests/net/ncdevmem.c | 693 +++++++++++++++++++++++++
 23 files changed, 1868 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/net/ncdevmem.c

--=20
2.41.0.390.g38632f3daf-goog

