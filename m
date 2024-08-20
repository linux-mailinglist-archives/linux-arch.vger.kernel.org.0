Return-Path: <linux-arch+bounces-6352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC61957D50
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 08:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF281C2149E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 06:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADE51607BD;
	Tue, 20 Aug 2024 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEGaVCsi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE8158541
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133906; cv=none; b=VZCS7jmbvD/URRlB4cUsZXdwSpo3r+U9XeVle4pMlbF/nw8IC1u/sPduKxiYxohfgMTHsiJ9SxNCLffNGX3R6opIsj528S6HWMJPaufS8p0Kb3D91aKr+Q8m8GI2efi8yQatNb4uTXe34PDyap4+73sNPmdk85rBaIcOQa7usZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133906; c=relaxed/simple;
	bh=F1X9JjECJwnqVzffS2wm4s538p3BTnTMQhmftSIAorY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nq8RYglzfjtX7Ft6AqN2s7poBt8MtEFwn/dlaZ9SuDRj8XYTSGLWZHPW8ZwKHsJ4TXbmu+GMN3Mv2U9jQG5NdhVRuWegHdH6oGirxHI7qDy8lr4CTshOoJTLGEqtsLOJDbiBPCb29tTy7eX7eoqOehE0NbQSs5MIzFTlI5DiC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEGaVCsi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad97b9a0fbso97840867b3.0
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 23:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724133898; x=1724738698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/XhNim9Vng1t1K3Q1oYQQU2KJwqJalILsrUX6ByOLA=;
        b=oEGaVCsi8WR4W+AeQpyBpA1E/ndQPoL6eibj54S+NTcaZEqcW4fPvLKKKKyeRcjaR5
         R9Rbk2oa0L+ROfFkGUQb0kP5+VAOEd8C7OiPoHdEOX4MKjBentd4ErmPijbx5CXxGIj4
         YHt26mF3c5Il9KqP+kgGOY7KA1YJp85D36c+yv/91Qs4N6Tt/p6/cNtjoC3mCADp8xEe
         tkXZvjaNWOyWAMj7Jr5yrf0RfswQOyWzRNkG1K12wz9oP5cxjyJeC2O6k2r8+hhcQOKi
         4ERdEdUkYbbkUlvDFh9RElF73ScFKVwkbWW4r+bvudqki1s6s9E6ElTZt2L4PN/Nc85R
         ozdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724133898; x=1724738698;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/XhNim9Vng1t1K3Q1oYQQU2KJwqJalILsrUX6ByOLA=;
        b=Du8AuunIA1BDcAjg/xGxDL0cWnei8XnWAMSFNPchh/4p5TFZswLgguAFcnjTKfu24v
         NHwNvRmdUVGREW8vLbwpYMb2wqkqVwsRb2vmE9m2kjP4MH3VPZViHthiIYwRsF6SGeqN
         urmumUmIB7s7RlrILHqqo6x/INJ7T/xzuXjIJR/UegO6I0bQCwBrAA74VnKIaLOBkvMj
         NWh6Jb7lk7VR/B7B83ob9nKKl+fmb1KXFoBIr4a28k+NeAXXgJXOMPDWa/Mndiq3Hndk
         Z6eHqP2EWB8NkVWEIN20pFhVKV/wrj4t+HsqZ9nY/gB/KE7VTbJd8dN6VctgrE/+PxPQ
         YaRg==
X-Forwarded-Encrypted: i=1; AJvYcCVpXlX+WsyuT1X9b2dGTEXhet1CbU15kHzwPeijS2lQp5EQsIZ19YTNX6PWxEU4nNNYUVMMZ2At57xbq7vbREC3oGyFaQCKufTYhA==
X-Gm-Message-State: AOJu0YzhH6QROuXqf+KLCjW6hk1C9D+wn27RDg0BKHNkhOVutT2Gj7Mw
	0PSpRkM7GyAFnV7gXYkyw7FcDOaLmcMzVFPs/B/RnuojLOEEOUBUsr/dLQIkqFnBI84nI0BF5AT
	t9ZYBrpG1Q/rjFNLQ2lNrsQ==
X-Google-Smtp-Source: AGHT+IGwDfmYR4pQ5TbvI3/+YParkCxPfWcGALPy8O/GTqz+MuL6ztwq78X9JLG5xr0TaCLqdjlNhTDkDaOEEL/H4w==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:6006:0:b0:e0e:426b:bf6f with SMTP
 id 3f1490d57ef6-e1180f55181mr20566276.7.1724133897985; Mon, 19 Aug 2024
 23:04:57 -0700 (PDT)
Date: Tue, 20 Aug 2024 06:04:43 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820060456.1485518-1-almasrymina@google.com>
Subject: [PATCH net-next v21 00/13] Device Memory TCP
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

v21: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D880735&s=
tate=3D*
=3D=3D=3D=3D

v20 addressed some comments and resolved a test failure, but introduced
an unfortunate build error with a config edge case I wasn't testing. v21
simply resolves that error.

Major Changes:
- Resolve build error with CONFIG_PAGE_POOL=3Dn && CONFIG_NET=3Dy

Full devmem TCP changes including the full GVE driver implementation is
here:

https://github.com/mina/linux/commits/tcpdevmem-v21/

v20: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D879373&s=
tate=3D*
=3D=3D=3D=3D

v20 aims to resolve a couple of bug reports against v19, and addresses
some review comments around the page_pool_check_memory_provider
mechanism.

Major changes:
- Test edge cases such as header split disabled in selftest.
- Change `offset =3D 0` back to `offset =3D offset - start` to resolve issu=
e
  found in RX path by Taehee (thanks!)
- Address a few comments around page_pool_check_memory_provider() from
  Pavel & Jakub.
- Removed some unnecessary includes across various patches in the
  series.
- Removed unnecessary EXPORT_SYMBOL(page_pool_mem_providers) (Jakub).
- Fix regression caused by incorrect dev_get_max_mp_channel check, along
  with rename (Jakub).

Full devmem TCP changes including the full GVE driver implementation is
here:

https://github.com/mina/linux/commits/tcpdevmem-v20/

v19: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D876852&s=
tate=3D*
=3D=3D=3D=3D

v18 got a thorough review (thanks!), and this iteration addresses the
feedback.

Major changes:
- Prevent deactivating mp bound queues.
- Prevent installing xdp on mp bound netdevs, or installing mps on xdp
  installed netdevs.
- Fix corner cases in netlink API vis-a-vis missing attributes.
- Iron out the unreadable netmem driver support story. To be honest, the
  conversation with Jakub & Pavel got a bit confusing for me. I've
  implemented an approach in this set that makes sense to me, and
  AFAICT, addresses the requirements. It may be good as-is, or it
  may be a conversation starter/continuer. To be honest IMO there
  are many ways to skin this cat and I don't see an extremely strong
  reason to go for one approach over another. Here is one approach you
  may like.
- Don't reset niov dma_addr on allocation & free.
- Add some tests to the selftest that catches some of the issues around
  missing netlink attributes or deactivating mp-bound queues.

Full devmem TCP changes including the full GVE driver implementation is
here:

https://github.com/mina/linux/commits/tcpdevmem-v19/

v18: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D874848&s=
tate=3D*
=3D=3D=3D=3D

v17 got minor feedback: (a) to beef up the description on patch 1 and (b)
to remove the leading underscores in the header definition.

I applied (a). (b) seems to be against current conventions so I did not
apply before further discussion.

Full devmem TCP changes including the full GVE driver implementation is
here:

https://github.com/mina/linux/commits/tcpdevmem-v17/

v17: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D869900&s=
tate=3D*
=3D=3D=3D=3D

v16 also got a very thorough review and some testing (thanks again!).
Thes version addresses all the concerns reported on v15, in terms of
feedback and issues reported.

Major changes:
- Use ASSERT_RTNL.
- Moved around some of the page_pool helpers definitions so I can hide
  some netmem helpers in private files as Jakub suggested.
- Don't make every net_iov hold a ref on the binding as Jakub suggested.
- Fix issue reported by Taehee where we access queues after they have
  been freed.

Full devmem TCP changes including the full GVE driver implementation is
here:

https://github.com/mina/linux/commits/tcpdevmem-v17/

v16: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D866353&s=
tate=3D*
=3D=3D=3D=3D

v15 got a thorough review and some testing, and this version addresses almo=
st
all the feedback. Some more minor comments where the authors said it
could be done later, I left out.

Major changes:
- Addition of dma-buf introspection to page-pool-get and queue-get.
- Fixes to selftests suggested by Taehee.
- Fixes to documentation suggested by Donald.
- A couple of suggestions and fixes to TCP patches by Eric and David.
- Fixes to number assignements suggested by Arnd.
- Use rtnl_lock()ing to guard against queue reconfiguration while the
  page_pool initialization is happening. (Jakub).
- Fixes to a few warnings reproduced by Taehee.
- Fixes to dma-buf binding suggested by Taehee and Jakub.
- Fixes to netlink UAPI suggested by Jakub
- Applied a number of Reviewed-bys and Acked-bys (including ones I lost
  from v13+).

Full devmem TCP changes including the full GVE driver implementation is
here:

https://github.com/mina/linux/commits/tcpdevmem-v16/

One caveat: Taehee reproduced a KASAN warning and reported it here:

https://lore.kernel.org/netdev/CAMArcTUdCxOBYGF3vpbq=3DeBvqZfnc44KBaQTN7H-w=
qdUxZdziw@mail.gmail.com/

I estimate the issue to be minor and easily fixable:

https://lore.kernel.org/netdev/CAHS8izNgaqC--GGE2xd85QB=3DutUnOHmioCsDd1TNx=
JWKemaD_g@mail.gmail.com/

I hope to be able to follow up with a fix to net tree as net-next closes
imminently, but if this iteration doesn't make it in, I will repost with
a fix squashed after net-next reopens, no problem.

v15: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D865481&s=
tate=3D*
=3D=3D=3D=3D

No material changes in this version, only a fix to linking against
libynl.a from the last version. Per Jakub's instructions I've pulled one
of his patches into this series, and now use the new libynl.a correctly,
I hope.

As usual, the full devmem TCP changes including the full GVE driver
implementation is here:

https://github.com/mina/linux/commits/tcpdevmem-v15/

v14: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D865135&a=
rchive=3Dboth&state=3D*
=3D=3D=3D=3D

No material changes in this version. Only rebase and re-verification on
top of net-next. v13, I think, raced with commit ebad6d0334793
("net/ipv4: Use nested-BH locking for ipv4_tcp_sk.") being merged to
net-next that caused a patchwork failure to apply. This series should
apply cleanly on commit c4532232fa2a4 ("selftests: net: remove unneeded
IP_GRE config").

I did not wait the customary 24hr as Jakub said it's OK to repost as soon
as I build test the rebased version:

https://lore.kernel.org/netdev/20240625075926.146d769d@kernel.org/

v13: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D861406&a=
rchive=3Dboth&state=3D*
=3D=3D=3D=3D

Major changes:
--------------

This iteration addresses Pavel's review comments, applies his
reviewed-by's, and seeks to fix the patchwork build error (sorry!).

As usual, the full devmem TCP changes including the full GVE driver
implementation is here:

https://github.com/mina/linux/commits/tcpdevmem-v13/

v12: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D859747&s=
tate=3D*
=3D=3D=3D=3D

Major changes:
--------------

This iteration only addresses one minor comment from Pavel with regards
to the trace printing of netmem, and the patchwork build error
introduced in v11 because I missed doing an allmodconfig build, sorry.

Other than that v11, AFAICT, received no feedback. There is one
discussion about how the specifics of  plugging io uring memory through
the page pool, but not relevant to content in this particular patchset,
AFAICT.

As usual, the full devmem TCP changes including the full GVE driver
implementation is here:

https://github.com/mina/linux/commits/tcpdevmem-v12/

v11: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D857457&s=
tate=3D*
=3D=3D=3D=3D

Major Changes:
--------------

v11 addresses feedback received in v10. The major change is the removal
of the memory provider ops as requested by Christoph. We still
accomplish the same thing, but utilizing direct function calls with if
statements rather than generic ops.

Additionally address sparse warnings, bugs and review comments from
folks that reviewed.

As usual, the full devmem TCP changes including the full GVE driver
implementation is here:

https://github.com/mina/linux/commits/tcpdevmem-v11/

Detailed changelog:
-------------------

- Fixes in netdev_rx_queue_restart() from Pavel & David.
- Remove commit e650e8c3a36f5 ("net: page_pool: create hooks for
custom page providers") from the series to address Christoph's
feedback and rebased other patches on the series on this change.
- Fixed build errors with CONFIG_DMA_SHARED_BUFFER &&
  !CONFIG_GENERIC_ALLOCATOR build.
- Fixed sparse warnings pointed out by Paolo.
- Drop unnecessary gro_pull_from_frag0 checks.
- Added Bagas reviewed-by to docs.

Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>

v10: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D852422&s=
tate=3D*
=3D=3D=3D=3D

Major Changes:
--------------

v9 was sent right before the merge window closed (sorry!). v10 is almost
a re-send of the series now that the merge window re-opened. Only
rebased to latest net-next and addressed some minor iterative comments
received on v9.

As usual, the full devmem TCP changes including the full GVE driver
implementation is here:

https://github.com/mina/linux/commits/tcpdevmem-v10/

Detailed changelog:
-------------------

- Fixed tokens leaking in DONTNEED setsockopt (Nikolay).
- Moved net_iov_dma_addr() to devmem.c and made it a devmem specific
  helpers (David).
- Rename hook alloc_pages to alloc_netmems as alloc_pages is now
  preprocessor macro defined and causes a build error.

v9:
=3D=3D=3D

Major Changes:
--------------

GVE queue API has been merged. Submitting this version as non-RFC after
rebasing on top of the merged API, and dropped the out of tree queue API
I was carrying on github. Addressed the little feedback v8 has received.

Detailed changelog:
------------------
- Added new patch from David Wei to this series for
  netdev_rx_queue_restart()
  - Fixed sparse error.
  - Removed CONFIG_ checks in netmem_is_net_iov()
  - Flipped skb->readable to skb->unreadable
  - Minor fixes to selftests & docs.

RFC v8:
=3D=3D=3D=3D=3D=3D=3D

Major Changes:
--------------

- Fixed build error generated by patch-by-patch build.
- Applied docs suggestions from Randy.

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



Mina Almasry (13):
  netdev: add netdev_rx_queue_restart()
  net: netdev netlink api to bind dma-buf to a net device
  netdev: support binding dma-buf to netdevice
  netdev: netdevice devmem allocator
  page_pool: devmem support
  memory-provider: dmabuf devmem memory provider
  net: support non paged skb frags
  net: add support for skbs with unreadable frags
  tcp: RX path for devmem TCP
  net: add SO_DEVMEM_DONTNEED setsockopt to release RX frags
  net: add devmem TCP documentation
  selftests: add ncdevmem, netcat for devmem TCP
  netdev: add dmabuf introspection

 Documentation/netlink/specs/netdev.yaml |  61 +++
 Documentation/networking/devmem.rst     | 269 +++++++++++
 Documentation/networking/index.rst      |   1 +
 arch/alpha/include/uapi/asm/socket.h    |   6 +
 arch/mips/include/uapi/asm/socket.h     |   6 +
 arch/parisc/include/uapi/asm/socket.h   |   6 +
 arch/sparc/include/uapi/asm/socket.h    |   6 +
 include/linux/netdevice.h               |   2 +
 include/linux/skbuff.h                  |  61 ++-
 include/linux/skbuff_ref.h              |   9 +-
 include/linux/socket.h                  |   1 +
 include/net/devmem.h                    | 128 ++++++
 include/net/mp_dmabuf_devmem.h          |  44 ++
 include/net/netdev_rx_queue.h           |   5 +
 include/net/netmem.h                    | 169 ++++++-
 include/net/page_pool/helpers.h         |  39 +-
 include/net/page_pool/types.h           |  22 +-
 include/net/sock.h                      |   2 +
 include/net/tcp.h                       |   5 +-
 include/trace/events/page_pool.h        |  12 +-
 include/uapi/asm-generic/socket.h       |   6 +
 include/uapi/linux/netdev.h             |  13 +
 include/uapi/linux/uio.h                |  17 +
 net/core/Makefile                       |   3 +-
 net/core/datagram.c                     |   6 +
 net/core/dev.c                          |  22 +-
 net/core/devmem.c                       | 374 +++++++++++++++
 net/core/gro.c                          |   3 +-
 net/core/netdev-genl-gen.c              |  23 +
 net/core/netdev-genl-gen.h              |   6 +
 net/core/netdev-genl.c                  | 118 +++++
 net/core/netdev_rx_queue.c              |  81 ++++
 net/core/netmem_priv.h                  |  31 ++
 net/core/page_pool.c                    | 117 +++--
 net/core/page_pool_priv.h               |  46 ++
 net/core/page_pool_user.c               |  29 ++
 net/core/skbuff.c                       |  77 +++-
 net/core/sock.c                         |  68 +++
 net/ethtool/common.c                    |   8 +
 net/ipv4/esp4.c                         |   3 +-
 net/ipv4/tcp.c                          | 261 ++++++++++-
 net/ipv4/tcp_input.c                    |  13 +-
 net/ipv4/tcp_ipv4.c                     |  16 +
 net/ipv4/tcp_minisocks.c                |   2 +
 net/ipv4/tcp_output.c                   |   5 +-
 net/ipv6/esp6.c                         |   3 +-
 net/packet/af_packet.c                  |   4 +-
 tools/include/uapi/linux/netdev.h       |  13 +
 tools/testing/selftests/net/.gitignore  |   1 +
 tools/testing/selftests/net/Makefile    |   9 +
 tools/testing/selftests/net/ncdevmem.c  | 588 ++++++++++++++++++++++++
 51 files changed, 2699 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/networking/devmem.rst
 create mode 100644 include/net/devmem.h
 create mode 100644 include/net/mp_dmabuf_devmem.h
 create mode 100644 net/core/devmem.c
 create mode 100644 net/core/netdev_rx_queue.c
 create mode 100644 net/core/netmem_priv.h
 create mode 100644 tools/testing/selftests/net/ncdevmem.c

--=20
2.46.0.184.g6999bdac58-goog


