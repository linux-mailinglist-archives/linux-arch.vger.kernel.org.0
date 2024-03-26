Return-Path: <linux-arch+bounces-3201-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC188D198
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 23:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409F73287CA
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2C13E037;
	Tue, 26 Mar 2024 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ooY3n4Y8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8213D8B2
	for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493459; cv=none; b=pSy6O66NbNEMH2GtGpn3SEhZIHmpeXb8N8modcm0ojZx4MjO5Uige354cqV/ZQIL1Htdgc9CG8mSgmQ8zARjoiYquJHvjzEF6gxAn2CcoWSU6q0708pm2xH7g0rPVWCmBAHCKgGDW4934ojEGpznuWThbMHUoOBuGsilnN28C6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493459; c=relaxed/simple;
	bh=n5ZiEOJkqfn8NOEVtgEgpWmWhgyuORNSw64P5IA5aNk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NcmghMPS1SiUWjL94QBzsiCtxDiu7Zf1arEFBVL7u6kXZlMSaDIX4Yo+Zgce9pamn3gzfRIGCGl37Fr4BoqDF6wRFom5Ze0pQP007Viv2bPY2XHIBiljgXwr3uUi9OavN0SXqXVGzATpFwtC9Lm24AMWXxw/zJUzdi88A5Wqg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ooY3n4Y8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso9375981276.0
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711493455; x=1712098255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YyFyyEaAfGg7EU+HKVRHyLS4Kz23ClETeDbC/U8pEG8=;
        b=ooY3n4Y8FOWxRa8ZMtdRpC8tVwO7JJOH1Ca+DduMqkx89RmllHwtgcocXeVi3ib+an
         Pjr3QV5K4XzqMv0C3TV0ghc3Miis3z8L1Aej3DjXp/ib/LUNrhOyfGQt90YaeS8i4PbP
         YkdMPrDYAyjt2seB+lFCMaRBKnT9EmuuAcm5iisGMxWuhEgWSfFlaoo2PzfCK52+ZzhN
         Hz+iKFNOFSpeaNnUjD0ILvsuWWsLAUAXiClHIBvp4TzR1A2neRiWWNdP/85G7m95rizF
         RBptgw8CXvq9nja8UZx0RC+GCB1015LNTaWP5NTJs+XMWmw6erlMxBfY4YuGh6LRRFdX
         538Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493455; x=1712098255;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyFyyEaAfGg7EU+HKVRHyLS4Kz23ClETeDbC/U8pEG8=;
        b=HgJW7aWzFZlqAjVfGKwIeAtOuoxVo38R+TocjjW7Vn0wpLzb+oJ3NfncJ1vVl0rlod
         n9zV6XSwI7lns9OF8EAEtIuKH34vT+LTQRhHSlxLlucV/Y0Pzk5u5oB4tDfV1GA3ZO86
         O1lIRm6Y321Lsin04qR+4shJc8u3zyqS2ZqL3eLnPFRRI+x9rQWMb5cdhjHwkUnmXOCU
         JPrziM79eDuqKXyBXJWIU5iKXMDlC3+IaGoCGc+lfXTthcb1tjtuq0NeLe4ExsQ1j3d8
         VvW/bQbWN3ckEPxDusi4a4GdKYIdK8+NJqT4VjYLjoBql92y5uodrFZSHYSum4Z+7GOc
         PpNA==
X-Forwarded-Encrypted: i=1; AJvYcCXYoTwn0FQMSQQMRFYVr+55EmIAFeyPGh5REpVESIfViqZNCtW12deAokGyM0CJOpot749lsyLLlX1He45I2yaV8cp/uTJ2L53+Rg==
X-Gm-Message-State: AOJu0YzLh3P5oeu61N92bywYD9y6GVWi3GxsXQ3PKeoMknhjofJGJfEw
	SxWByXqr0j9kQK3MuKBps3p+ob54IxK7/vhY7G4F7f6ImBqIUOl3d+qhIvikktNhjSUgBUeaCK5
	pwvRi/mi1hXLiRh6hf8sfrQ==
X-Google-Smtp-Source: AGHT+IEBBYNDb7JuK84bVlY9wS3T87c7vGo3D2kQ4Vtt6vtGB1b18JjrYKf+l40GB87vh2axhpDQ6aFdsfljKKP7AQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:c51e:bdd0:7cc8:695c])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:188f:b0:dda:f314:7e1f with
 SMTP id cj15-20020a056902188f00b00ddaf3147e1fmr228921ybb.4.1711493455207;
 Tue, 26 Mar 2024 15:50:55 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:50:31 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326225048.785801-1-almasrymina@google.com>
Subject: [RFC PATCH net-next v7 00/14] Device Memory TCP
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
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

RFC v7:
=3D=3D=3D=3D=3D=3D=3D

Major Changes:
--------------

This revision largely rebases on top of net-next and addresses the feedback
RFCv6 received from folks, namely Jakub, Yunsheng, Arnd, David, & Pavel.

The series remains in RFC because the queue-API ndos defined in this
series are not yet implemented. I have a GVE implementation I carry out
of tree for my testing. A upstreamable GVE implementation is in the
works. Aside from that, in my estimation all the patches are ready for
review/merge. Please do take a look.

As usual the full devmem TCP changes including the full GVE driver
implementation is here:

https://github.com/mina/linux/commits/tcpdevmem-v7/

Detailed changelog:

- Use admin-perm in netlink API.
- Addressed feedback from Jakub with regards to netlink API
  implementation.
- Renamed devmem.c functions to something more appropriate for that
  file.
- Improve the performance seen through the page_pool benchmark.
- Fix the value definition of all the SO_DEVMEM_* uapi.
- Various fixes to documentation.

Perf - page-pool benchmark:
---------------------------

Improved performance of bench_page_pool_simple.ko tests compared to v6:

https://pastebin.com/raw/v5dYRg8L

      net-next base: 8 cycle fast path.
      RFC v6: 10 cycle fast path.
      RFC v7: 9 cycle fast path.
      RFC v7 with CONFIG_DMA_SHARED_BUFFER disabled: 8 cycle fast path,
                                                     same as baseline.

Perf - Devmem TCP benchmark:
---------------------

Perf is about the same regardless of the changes in v7, namely the
removal of the static_branch_unlikely to improve the page_pool benchmark
performance:

189/200gbps bi-directional throughput with RX devmem TCP and regular TCP
TX i.e. ~95% line rate.

RFC v6:
=3D=3D=3D=3D=3D=3D=3D

Major Changes:
--------------

This revision largely rebases on top of net-next and addresses the little
feedback RFCv5 received.

The series remains in RFC because the queue-API ndos defined in this
series are not yet implemented. I have a GVE implementation I carry out
of tree for my testing. A upstreamable GVE implementation is in the
works. Aside from that, in my estimation all the patches are ready for
review/merge. Please do take a look.

As usual the full devmem TCP changes including the full GVE driver
implementation is here:

https://github.com/mina/linux/commits/tcpdevmem-v6/

This version also comes with some performance data recorded in the cover
letter (see below changelog).

Detailed changelog:

- Rebased on top of the merged netmem_ref changes.

- Converted skb->dmabuf to skb->readable (Pavel). Pavel's original
  suggestion was to remove the skb->dmabuf flag entirely, but when I
  looked into it closely, I found the issue that if we remove the flag
  we have to dereference the shinfo(skb) pointer to obtain the first
  frag to tell whether an skb is readable or not. This can cause a
  performance regression if it dirties the cache line when the
  shinfo(skb) was not really needed. Instead, I converted the skb->dmabuf
  flag into a generic skb->readable flag which can be re-used by io_uring
  0-copy RX.

- Squashed a few locking optimizations from Eric Dumazet in the RX path
  and the DEVMEM_DONTNEED setsockopt.

- Expanded the tests a bit. Added validation for invalid scenarios and
  added some more coverage.

Perf - page-pool benchmark:
---------------------------

bench_page_pool_simple.ko tests with and without these changes:
https://pastebin.com/raw/ncHDwAbn

AFAIK the number that really matters in the perf tests is the
'tasklet_page_pool01_fast_path Per elem'. This one measures at about 8
cycles without the changes but there is some 1 cycle noise in some
results.

With the patches this regresses to 9 cycles with the changes but there
is 1 cycle noise occasionally running this test repeatedly.

Lastly I tried disable the static_branch_unlikely() in
netmem_is_net_iov() check. To my surprise disabling the
static_branch_unlikely() check reduces the fast path back to 8 cycles,
but the 1 cycle noise remains.

Perf - Devmem TCP benchmark:
---------------------

189/200gbps bi-directional throughput with RX devmem TCP and regular TCP
TX i.e. ~95% line rate.

Major changes in RFC v5:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Rebased on top of 'Abstract page from net stack' series and used the
   new netmem type to refer to LSB set pointers instead of re-using
   struct page.

2. Downgraded this series back to RFC and called it RFC v5. This is
   because this series is now dependent on 'Abstract page from net
   stack'[1] and the queue API. Both are removed from the series to
   reduce the patch # and those bits are fairly independent or
   pre-requisite work.

3. Reworked the page_pool devmem support to use netmem and for some
   more unified handling.

4. Reworked the reference counting of net_iov (renamed from
   page_pool_iov) to use pp_ref_count for refcounting.

The full changes including the dependent series and GVE page pool
support is here:

https://github.com/mina/linux/commits/tcpdevmem-rfcv5/

[1] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D810774

Major changes in v1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Implemented MVP queue API ndos to remove the userspace-visible
   driver reset.

2. Fixed issues in the napi_pp_put_page() devmem frag unref path.

3. Removed RFC tag.

Many smaller addressed comments across all the patches (patches have
individual change log).

Full tree including the rest of the GVE driver changes:
https://github.com/mina/linux/commits/tcpdevmem-v1

Changes in RFC v3:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Pulled in the memory-provider dependency from Jakub's RFC[1] to make the
   series reviewable and mergeable.

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

Changes in RFC v2:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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

Not included with this series is the GVE devmem TCP support, just to
simplify the review. Code available here if desired:
https://github.com/mina/linux/tree/tcpdevmem

This series is built on top of net-next with Jakub's pp-providers changes
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

Kernel: net-next with this series and memory provider API cherry-picked
locally.

Hardware: Google Cloud A3 VMs.

NIC: GVE with header split & RSS & flow steering support.

Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Shailend Chand <shailend@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jeroen de Borst <jeroendb@google.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>


Jakub Kicinski (1):
  net: page_pool: create hooks for custom page providers

Mina Almasry (13):
  queue_api: define queue api
  net: netdev netlink api to bind dma-buf to a net device
  netdev: support binding dma-buf to netdevice
  netdev: netdevice devmem allocator
  page_pool: convert to use netmem
  page_pool: devmem support
  memory-provider: dmabuf devmem memory provider
  net: support non paged skb frags
  net: add support for skbs with unreadable frags
  tcp: RX path for devmem TCP
  net: add SO_DEVMEM_DONTNEED setsockopt to release RX frags
  net: add devmem TCP documentation
  selftests: add ncdevmem, netcat for devmem TCP

 Documentation/netlink/specs/netdev.yaml |  57 +++
 Documentation/networking/devmem.rst     | 256 +++++++++++
 Documentation/networking/index.rst      |   1 +
 arch/alpha/include/uapi/asm/socket.h    |   6 +
 arch/mips/include/uapi/asm/socket.h     |   6 +
 arch/parisc/include/uapi/asm/socket.h   |   6 +
 arch/sparc/include/uapi/asm/socket.h    |   6 +
 include/linux/netdevice.h               |   3 +
 include/linux/skbuff.h                  |  73 +++-
 include/linux/socket.h                  |   1 +
 include/net/devmem.h                    | 124 ++++++
 include/net/netdev_queues.h             |  27 ++
 include/net/netdev_rx_queue.h           |   2 +
 include/net/netmem.h                    | 234 +++++++++-
 include/net/page_pool/helpers.h         | 155 +++++--
 include/net/page_pool/types.h           |  33 +-
 include/net/sock.h                      |   2 +
 include/net/tcp.h                       |   5 +-
 include/trace/events/page_pool.h        |  29 +-
 include/uapi/asm-generic/socket.h       |   6 +
 include/uapi/linux/netdev.h             |  19 +
 include/uapi/linux/uio.h                |  17 +
 net/bpf/test_run.c                      |   5 +-
 net/core/Makefile                       |   2 +-
 net/core/datagram.c                     |   6 +
 net/core/dev.c                          |   6 +-
 net/core/devmem.c                       | 425 ++++++++++++++++++
 net/core/gro.c                          |   8 +-
 net/core/netdev-genl-gen.c              |  23 +
 net/core/netdev-genl-gen.h              |   6 +
 net/core/netdev-genl.c                  | 107 +++++
 net/core/page_pool.c                    | 364 +++++++++-------
 net/core/skbuff.c                       | 110 ++++-
 net/core/sock.c                         |  61 +++
 net/ipv4/esp4.c                         |   2 +-
 net/ipv4/tcp.c                          | 254 ++++++++++-
 net/ipv4/tcp_input.c                    |  13 +-
 net/ipv4/tcp_ipv4.c                     |   9 +
 net/ipv4/tcp_minisocks.c                |   2 +
 net/ipv4/tcp_output.c                   |   5 +-
 net/ipv6/esp6.c                         |   2 +-
 net/packet/af_packet.c                  |   4 +-
 tools/include/uapi/linux/netdev.h       |  19 +
 tools/testing/selftests/net/.gitignore  |   1 +
 tools/testing/selftests/net/Makefile    |   5 +
 tools/testing/selftests/net/ncdevmem.c  | 546 ++++++++++++++++++++++++
 46 files changed, 2776 insertions(+), 277 deletions(-)
 create mode 100644 Documentation/networking/devmem.rst
 create mode 100644 include/net/devmem.h
 create mode 100644 net/core/devmem.c
 create mode 100644 tools/testing/selftests/net/ncdevmem.c

--=20
2.44.0.396.g6e790dbe36-goog


