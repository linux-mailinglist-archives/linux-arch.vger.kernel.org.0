Return-Path: <linux-arch+bounces-3216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D088D368
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 01:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E81B22E51
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 00:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3A28EC;
	Wed, 27 Mar 2024 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R829kLYe"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117734A32;
	Wed, 27 Mar 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711499954; cv=none; b=RyNI8OalWyDoyfUjo0kIUXgczQGimrc0oD3whX6gXwOaFcLUDFiA+T9lEPLsqz4eiNDamNq3mJt8Id1MHt2cELDp8Vg0aQh+0jH3z4H0CiAOoLJMhw66d0EThgdlQR+MtTSddaWL2i0efwOKIKAZe3QoNJ1NJ3QdSpTCX94563g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711499954; c=relaxed/simple;
	bh=lM4O1qCIEDxEUxFxG3e/eyhm3l0cH5kZrKl+PEHoY9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fngoa88N03vZE7ce5DMrjGKw69hgi4Zz0rvaLy8FVUr/agF2UjgLiemiolU8pmaHXRu9cFoX0fh2RpWfmXyZWvStfzLP00IjTB8q1MmXLfoEHeTCCtqLTAPX9FkZ+HzvtAgyaD0f0mvs9eN/GHOIufp9S6JoCuO7CF4zrwBxhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R829kLYe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kP7WIHOLdzRBQLDrSBJg7izGME+taO/PS6KcXmTaXmA=; b=R829kLYeWxuVRhP3F0l8AK+syA
	QEH63rPSjU6cE1tUB9vjg/Zru7XGKlHCkGm8UnDZX0WWN4TnXIdlJ0WCiZCc+zozmDKQaebeG8Otb
	gyunQb5eOnepRvGutL7gjpRAwHFlsqdcqclVFqMr0vyZtopr7+xwWtqWjgaV+MjqFp3U22BjiB+yN
	hrpvRXIBaXs6tGlDTkTeW+IsWa74VNkZ1lsNunvW7tDimQkfGk1/En8lmoBA8qAVdcqWFJak4HC1p
	Ae3ZKaz7OrrcZMT5MuKSGX2sdsKSw7PSfpqxR0fKH0RYWoRot45laQOJq0wpX92gC9AGw0DJ8tZEp
	qhN43EZQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpHJc-00000006zwt-3DsR;
	Wed, 27 Mar 2024 00:38:52 +0000
Message-ID: <b448a180-b43d-435d-9444-60b1163deeed@infradead.org>
Date: Tue, 26 Mar 2024 17:38:47 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v7 13/14] net: add devmem TCP documentation
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240326225048.785801-1-almasrymina@google.com>
 <20240326225048.785801-14-almasrymina@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240326225048.785801-14-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/26/24 15:50, Mina Almasry wrote:
> Add documentation outlining the usage and details of devmem TCP.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v7:
> - Applied docs suggestions (Jakub).
> 
> v2:
> 
> - Missing spdx (simon)
> - add to index.rst (simon)
> 
> ---
>  Documentation/networking/devmem.rst | 256 ++++++++++++++++++++++++++++
>  Documentation/networking/index.rst  |   1 +
>  2 files changed, 257 insertions(+)
>  create mode 100644 Documentation/networking/devmem.rst
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> new file mode 100644
> index 000000000000..b0899e8e9e83
> --- /dev/null
> +++ b/Documentation/networking/devmem.rst
> @@ -0,0 +1,256 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Device Memory TCP
> +=================
> +
> +
> +Intro
> +=====
> +
> +Device memory TCP (devmem TCP) enables receiving data directly into device
> +memory (dmabuf). The feature is currently implemented for TCP sockets.
> +
> +
> +Opportunity
> +-----------
> +
> +A large number of data transfers have device memory as the source and/or
> +destination. Accelerators drastically increased the prevalence of such
> +transfers.  Some examples include:
> +
> +- Distributed training, where ML accelerators, such as GPUs on different hosts,
> +  exchange data.
> +
> +- Distributed raw block storage applications transfer large amounts of data with
> +  remote SSDs, much of this data does not require host processing.

            SSDs. Much

> +
> +Typically the Device-to-Device data transfers the network are implemented as the

                                                 in the network
?

> +following low level operations: Device-to-Host copy, Host-to-Host network

             low-level

> +transfer, and Host-to-Device copy.
> +
> +The flow involving host copies is suboptimal, especially for bulk data transfers,
> +and can put significant strains on system resources such as host memory
> +bandwidth and PCIe bandwidth.
> +
> +Devmem TCP optimizes this use case by implementing socket APIs that enable
> +the user to receive incoming network packets directly into device memory.
> +
> +Packet payloads go directly from the NIC to device memory.
> +
> +Packet headers go to host memory and are processed by the TCP/IP stack
> +normally. The NIC must support header split to achieve this.
> +
> +Advantages:
> +
> +- Alleviate host memory bandwidth pressure, compared to existing
> +  network-transfer + device-copy semantics.
> +
> +- Alleviate PCIe bandwidth pressure, by limiting data transfer to the lowest
> +  level of the PCIe tree, compared to traditional path which sends data through

                                      to the

> +  the root complex.
> +
> +
> +More Info
> +---------
> +
> +  slides, video
> +    https://netdevconf.org/0x17/sessions/talk/device-memory-tcp.html
> +
> +  patchset
> +    [RFC PATCH v6 00/12] Device Memory TCP
> +    https://lore.kernel.org/netdev/20240305020153.2787423-1-almasrymina@google.com/
> +
> +
> +Interface
> +=========
> +
> +Example
> +-------
> +
> +tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
> +the RX path of this API.
> +
> +NIC Setup
> +---------
> +
> +Header split, flow steering, & RSS are required features for devmem TCP.
> +
> +Header split is used to split incoming packets into a header buffer in host
> +memory, and a payload buffer in device memory.
> +
> +Flow steering & RSS are used to ensure that only flows targeting devmem land on> +RX queue bound to devmem.

   an RX queue
?

> +
> +Enable header split & flow steering::
> +
> +	# enable header split
> +	ethtool -G eth1 tcp-data-split on
> +
> +
> +	# enable flow steering
> +	ethtool -K eth1 ntuple on
> +
> +Configure RSS to steer all traffic away from the target RX queue (queue 15 in
> +this example)::
> +
> +	ethtool --set-rxfh-indir eth1 equal 15
> +
> +
> +The user must bind a dmabuf to any number of RX queues on a given NIC using
> +netlink API::

   the netlink API::

> +
> +	/* Bind dmabuf to NIC RX queue 15 */
> +	struct netdev_queue *queues;
> +	queues = malloc(sizeof(*queues) * 1);
> +
> +	queues[0]._present.type = 1;
> +	queues[0]._present.idx = 1;
> +	queues[0].type = NETDEV_RX_QUEUE_TYPE_RX;
> +	queues[0].idx = 15;
> +
> +	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> +
> +	req = netdev_bind_rx_req_alloc();
> +	netdev_bind_rx_req_set_ifindex(req, 1 /* ifindex */);
> +	netdev_bind_rx_req_set_dmabuf_fd(req, dmabuf_fd);
> +	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
> +
> +	rsp = netdev_bind_rx(*ys, req);
> +
> +	dmabuf_id = rsp->dmabuf_id;
> +
> +
> +The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
> +that has been bound.
> +
> +Socket Setup
> +------------
> +
> +The socket must be flow steering to the dmabuf bound RX queue::

                      flow steered
?

> +
> +	ethtool -N eth1 flow-type tcp4 ... queue 15,
> +
> +
> +Receiving data
> +--------------
> +
> +The user application must signal to the kernel that it is capable of receiving
> +devmem data by passing the MSG_SOCK_DEVMEM flag to recvmsg::
> +
> +	ret = recvmsg(fd, &msg, MSG_SOCK_DEVMEM);
> +
> +Applications that do not specify the MSG_SOCK_DEVMEM flag will receive an EFAULT
> +on devmem data.
> +
> +Devmem data is received directly into the dmabuf bound to the NIC in 'NIC
> +Setup', and the kernel signals such to the user via the SCM_DEVMEM_* cmsgs::
> +
> +		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
> +			if (cm->cmsg_level != SOL_SOCKET ||
> +				(cm->cmsg_type != SCM_DEVMEM_DMABUF &&
> +				 cm->cmsg_type != SCM_DEVMEM_LINEAR))
> +				continue;
> +
> +			dmabuf_cmsg = (struct dmabuf_cmsg *)CMSG_DATA(cm);
> +
> +			if (cm->cmsg_type == SCM_DEVMEM_DMABUF) {
> +				/* Frag landed in dmabuf.
> +				 *
> +				 * dmabuf_cmsg->dmabuf_id is the dmabuf the
> +				 * frag landed on.
> +				 *
> +				 * dmabuf_cmsg->frag_offset is the offset into
> +				 * the dmabuf where the frag starts.
> +				 *
> +				 * dmabuf_cmsg->frag_size is the size of the
> +				 * frag.
> +				 *
> +				 * dmabuf_cmsg->frag_token is a token used to
> +				 * refer to this frag for later freeing.
> +				 */
> +
> +				struct dmabuf_token token;
> +				token.token_start = dmabuf_cmsg->frag_token;
> +				token.token_count = 1;
> +				continue;
> +			}
> +
> +			if (cm->cmsg_type == SCM_DEVMEM_LINEAR)
> +				/* Frag landed in linear buffer.
> +				 *
> +				 * dmabuf_cmsg->frag_size is the size of the
> +				 * frag.
> +				 */
> +				continue;
> +
> +		}
> +
> +Applications may receive 2 cmsgs:
> +
> +- SCM_DEVMEM_DMABUF: this indicates the fragment landed in the dmabuf indicated
> +  by dmabuf_id.
> +
> +- SCM_DEVMEM_LINEAR: this indicates the fragment landed in the linear buffer.
> +  This typically happens when the NIC is unable to split the packet at the
> +  header boundary, such that part (or all) of the payload landed in host
> +  memory.
> +
> +Applications may receive no SO_DEVMEM_* cmsgs. That indicates non-devmem,
> +regular TCP data that landed on an RX queue not bound to a dmabuf.
> +
> +
> +Freeing frags
> +-------------
> +
> +Frags received via SCM_DEVMEM_DMABUF are pinned by the kernel while the user
> +processes the frag. The user must return the frag to the kernel via
> +SO_DEVMEM_DONTNEED::
> +
> +	ret = setsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_DONTNEED, &token,
> +			 sizeof(token));
> +
> +The user must ensure the tokens are returned to the kernel in a timely manner.
> +Failure to do so will exhaust the limited dmabuf that is bound to the RX queue
> +and will lead to packet drops.
> +
> +
> +Implementation & Caveats
> +========================
> +
> +Unreadable skbs
> +---------------
> +
> +Devmem payloads are inaccessible to the kernel processing the packets. This
> +results in a few quirks for payloads of devmem skbs:
> +
> +- Loopback is not functional. Loopback relies on copying the payload, which is
> +  not possible with devmem skbs.
> +
> +- Software checksum calculation fails.
> +
> +- TCP Dump and bpf can't access devmem packet payloads.
> +
> +
> +Testing
> +=======
> +
> +More realistic example code can be found in the kernel source under
> +tools/testing/selftests/net/ncdevmem.c
> +
> +ncdevmem is a devmem TCP netcat. It works very similarly to netcat, but
> +receives data directly into a udmabuf.
> +
> +To run ncdevmem, you need to run it a server on the machine under test, and you

                                    it on a server

> +need to run netcat on a peer to provide the TX data.
> +
> +ncdevmem has a validation mode as well that expects a repeating pattern of
> +incoming data and validates it as such::
> +
> +	# On server:
> +	ncdevmem -s <server IP> -c <client IP> -f eth1 -d 3 -n 0000:06:00.0 -l \
> +		 -p 5201 -v 7
> +
> +	# On client:
> +	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
> +		tr \\n \\0 | head -c 5G | nc <server IP> 5201 -p 5201


-- 
#Randy

