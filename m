Return-Path: <linux-arch+bounces-5246-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D442927115
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 09:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D03B24D83
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667901A38E8;
	Thu,  4 Jul 2024 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfzOFnYs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055651A2FA6;
	Thu,  4 Jul 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079992; cv=none; b=d7AJEsE804spjUpbI7QbgoBgOHZan/U0jp+0hZW+ERqLbfwuozeXw/oCTz8nRqrAlHgjBE7HLtkd5AfJN+S8NWGUEBZ9pgqAf8vvlzAbSZYcyuJ/0BnwBqKAc2Gqwg5WvPm6mtZR5/71CPxdgr10yMd+d49LO/f2ODZXbO4W2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079992; c=relaxed/simple;
	bh=oLZ/ak927SSUjjhaGI/hPHr9hPFMvIpxieTv7jRF8eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JC6X8qvSLraBFj4B7IbNgT55nXQ8IqkDv16GsDpBrFFcWH9YmHw2CK8gyt8NsfNxTGSV1nJzeVvZgSJ+9K0iOQpcTpPm54LH4FQMrby2HABLTCtCYr8nNvVb+vtMoFSM2uEJ2FE0l4t5vhj8iymtjbh2JQh3ToyqEEozoffoW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfzOFnYs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77af4cd570so19745566b.1;
        Thu, 04 Jul 2024 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720079988; x=1720684788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLZ/ak927SSUjjhaGI/hPHr9hPFMvIpxieTv7jRF8eU=;
        b=MfzOFnYsGBUok3r+KlDukatKKv3IeiN8m0QxDzc8U8PP4PdCvoqUr9WOaBEh2TXt3J
         ZlgpqOwxA81ilAHaxU6GivA7IsQRj14Q/K52vJroYV+ed7dNeK7oWs1wOGfEa0qRa+Re
         /YwIE83BToaC1GKZWjXq+AKmuvYMwuXivRdl9lYfn5lRdMKqslu4GFj3gf3rYzq/MHen
         sswYlOxnzG4v8guanESIYxVZdqS4YlTL/IuepJmLysj+3UYvM6yLpqlvka/I44gFOAFn
         PPNJRM2Xp1HyilRsojQCddwr95HOHNxXORdi+QlrkeSzF9G2uta2zhOAddGUacyWmqRa
         BZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079988; x=1720684788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLZ/ak927SSUjjhaGI/hPHr9hPFMvIpxieTv7jRF8eU=;
        b=MFpTyVpgoqklFknSxDWwK+H6Xoi6BRowO00/TE7t/1eDgYQ16Oe2XXx7TeRK3tBC23
         XUfo/Qbe38sPaDzh8D3PCJ1K6bvKi4IH6jIiOJDf6+t8sr5RChb6A+Nk3FzgToGH3Uuo
         J4zGhiVK7Lbo4w6QAQ8Fwe+Oe+T7Sp/Ll8B4bdI2kQfWn3DOEKdTye1qth+6dSNwrqn/
         b/AstoxNdrx4Z6VoclD4eLgbCu8iWWYTcXCYgMDShAqpbATnyurB9mGob+WmTOw1nnTn
         GYJhm3LzBtry6u+LGztozhbjafFEbl4f9DW6RQosBw5FwwijIuuQXgW1fPC56BdC/nYP
         XATQ==
X-Forwarded-Encrypted: i=1; AJvYcCV10Lj0Hszm9wAPYezXc6cSBu963GhVTFWSLRWCcgs/qULs1SOJiJW9wve/ngcdtxB/aQSOjEovdeE2Ykq4PamnD3qaNw4D9tXXVQn5gVuk50Y2OsJhmVONZ3VxkHblqo81sa7MrIuX6wvgykh45pxHgO4hGaH1gWP2j8HU2KBb4tOazl3Sx/vUereaZEX4B+WkTEdXF2rCiePNi3iezeStepfgm33UiImv3jF/abM44FETr66Wh0iVVPBfgLDfdb0RXq/ftksi8m4sm0S1eBl6wZ/gPkRaaq3vx5v1CE4x+0lHWtV41tTa3BmH375aa/7z5rZ1HjBik5LwpZZPi1s3yRwqpJE0z2xxwXixQ5RV9U9za0E1dKCnKIgqnTLG7ArnU/ZDp0k/Sv9/CRHdIX/rWqg8gloM6vj2jUdrUdZkjK2DopBktwvUDcjym2ffuqIio0P5h3UO/lCxsHypUaExAdlw+n1TLpMFgPi5LA==
X-Gm-Message-State: AOJu0YzZ3Lcz+oQnAbtSOufl5NfcU27V4gDQhfSdn6tYsfiU7Vx/vn/L
	MeyKHZAMmXDybZy8qSmYTB4pGpRLpZ4pYnl0BS07cPKeXNGUmM2h7ar93NVa2Y1LpcaZWBWK62M
	RoSEJlotqDLL9K4zC0IFUX8L+MKM=
X-Google-Smtp-Source: AGHT+IFS60NocSDG44ogboX83wWYyK9MwfkCXBOlOHZ8IxTiKNVc2V9atUousex2RbBX5G5a+Q3ZZhDfilUeg1HGI20=
X-Received: by 2002:a05:6402:354b:b0:57d:3df:f881 with SMTP id
 4fb4d7f45d1cf-58e5994de19mr987388a12.3.1720079987992; Thu, 04 Jul 2024
 00:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com> <20240628003253.1694510-15-almasrymina@google.com>
In-Reply-To: <20240628003253.1694510-15-almasrymina@google.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 4 Jul 2024 16:59:36 +0900
Message-ID: <CAMArcTX04Ds5L6zMi0wXRepFUm+L1gKHPbj2i3VEG2P=xO2zZg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 14/14] selftests: add ncdevmem, netcat for
 devmem TCP
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 9:38=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>

Hi Mina,
Thank you so much for this work!

> ncdevmem is a devmem TCP netcat. It works similarly to netcat, but it
> sends and receives data using the devmem TCP APIs. It uses udmabuf as
> the dmabuf provider. It is compatible with a regular netcat running on
> a peer, or a ncdevmem running on a peer.
>
> In addition to normal netcat support, ncdevmem has a validation mode,
> where it sends a specific pattern and validates this pattern on the
> receiver side to ensure data integrity.
>
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
> v15:
> - Fix linking against libynl. (Jakub)
>
> v9: https://lore.kernel.org/netdev/20240403002053.2376017-15-almasrymina@=
google.com/
> - Remove unused nic_pci_addr entry (Cong).
>
> v6:
> - Updated to bind 8 queues.
> - Added RSS configuration.
> - Added some more tests for the netlink API.
>
> Changes in v1:
> - Many more general cleanups (Willem).
> - Removed driver reset (Jakub).
> - Removed hardcoded if index (Paolo).
>
> RFC v2:
> - General cleanups (Willem).
>
> ---
> tools/testing/selftests/net/.gitignore | 1 +
> tools/testing/selftests/net/Makefile | 9 +
> tools/testing/selftests/net/ncdevmem.c | 542 +++++++++++++++++++++++++
> 3 files changed, 552 insertions(+)
> create mode 100644 tools/testing/selftests/net/ncdevmem.c
>
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selft=
ests/net/.gitignore
> index 666ab7d9390b1..fe770903118c5 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -17,6 +17,7 @@ ipv6_flowlabel
> ipv6_flowlabel_mgr
> log.txt
> msg_zerocopy
> +ncdevmem
> nettest
> psock_fanout
> psock_snd
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index bc3925200637c..39420a6e86b7f 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -95,6 +95,11 @@ TEST_PROGS +=3D fq_band_pktlimit.sh
> TEST_PROGS +=3D vlan_hw_filter.sh
> TEST_PROGS +=3D bpf_offload.py
>
> +# YNL files, must be before "include ..lib.mk"
> +EXTRA_CLEAN +=3D $(OUTPUT)/libynl.a
> +YNL_GEN_FILES :=3D ncdevmem
> +TEST_GEN_FILES +=3D $(YNL_GEN_FILES)
> +
> TEST_FILES :=3D settings
> TEST_FILES +=3D in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_=
veth.sh
>
> @@ -104,6 +109,10 @@ TEST_INCLUDES :=3D forwarding/lib.sh
>
> include ../lib.mk
>
> +# YNL build
> +YNL_GENS :=3D netdev
> +include ynl.mk
> +
> $(OUTPUT)/epoll_busy_poll: LDLIBS +=3D -lcap
> $(OUTPUT)/reuseport_bpf_numa: LDLIBS +=3D -lnuma
> $(OUTPUT)/tcp_mmap: LDLIBS +=3D -lpthread -lcrypto
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> new file mode 100644
> index 0000000000000..e00255e54f77b
> --- /dev/null
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -0,0 +1,542 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#define __EXPORTED_HEADERS__
> +
> +#include <linux/uio.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <errno.h>
> +#define __iovec_defined
> +#include <fcntl.h>
> +#include <malloc.h>
> +#include <error.h>
> +
> +#include <arpa/inet.h>
> +#include <sys/socket.h>
> +#include <sys/mman.h>
> +#include <sys/ioctl.h>
> +#include <sys/syscall.h>
> +
> +#include <linux/memfd.h>
> +#include <linux/if.h>
> +#include <linux/dma-buf.h>
> +#include <linux/udmabuf.h>
> +#include <libmnl/libmnl.h>
> +#include <linux/types.h>
> +#include <linux/netlink.h>
> +#include <linux/genetlink.h>
> +#include <linux/netdev.h>
> +#include <time.h>
> +
> +#include "netdev-user.h"
> +#include <ynl.h>
> +
> +#define PAGE_SHIFT 12
> +#define TEST_PREFIX "ncdevmem"
> +#define NUM_PAGES 16000
> +
> +#ifndef MSG_SOCK_DEVMEM
> +#define MSG_SOCK_DEVMEM 0x2000000
> +#endif
> +
> +/*
> + * tcpdevmem netcat. Works similarly to netcat but does device memory TC=
P
> + * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
> + *
> + * Usage:
> + *
> + * On server:
> + * ncdevmem -s <server IP> -c <client IP> -f eth1 -d 3 -n 0000:06:00.0 -=
l \
> + * -p 5201 -v 7

The 'n' option disappeared, please remove it.


> + *
> + * On client:
> + * yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
> + * tr \\n \\0 | \
> + * head -c 5G | \
> + * nc <server IP> 5201 -p 5201
> + *
> + * Note this is compatible with regular netcat. i.e. the sender or recei=
ver can
> + * be replaced with regular netcat to test the RX or TX path in isolatio=
n.
> + */
> +
> +static char *server_ip =3D "192.168.1.4";
> +static char *client_ip =3D "192.168.1.2";
> +static char *port =3D "5201";
> +static size_t do_validation;
> +static int start_queue =3D 8;
> +static int num_queues =3D 8;
> +static char *ifname =3D "eth1";
> +static unsigned int ifindex =3D 3;
> +static unsigned int iterations;
> +static unsigned int dmabuf_id;
> +
> +void print_bytes(void *ptr, size_t size)
> +{
> + unsigned char *p =3D ptr;
> + int i;
> +
> + for (i =3D 0; i < size; i++)
> + printf("%02hhX ", p[i]);
> + printf("\n");
> +}
> +
> +void print_nonzero_bytes(void *ptr, size_t size)
> +{
> + unsigned char *p =3D ptr;
> + unsigned int i;
> +
> + for (i =3D 0; i < size; i++)
> + putchar(p[i]);
> + printf("\n");
> +}
> +
> +void validate_buffer(void *line, size_t size)
> +{
> + static unsigned char seed =3D 1;
> + unsigned char *ptr =3D line;
> + int errors =3D 0;
> + size_t i;
> +
> + for (i =3D 0; i < size; i++) {
> + if (ptr[i] !=3D seed) {
> + fprintf(stderr,
> + "Failed validation: expected=3D%u, actual=3D%u, index=3D%lu\n",
> + seed, ptr[i], i);
> + errors++;
> + if (errors > 20)
> + error(1, 0, "validation failed.");
> + }
> + seed++;
> + if (seed =3D=3D do_validation)
> + seed =3D 0;
> + }
> +
> + fprintf(stdout, "Validated buffer\n");
> +}
> +
> +static void reset_flow_steering(void)
> +{
> + char command[256];
> +
> + memset(command, 0, sizeof(command));
> + snprintf(command, sizeof(command), "sudo ethtool -K %s ntuple off",
> + "eth1");

I think we use ifname instead of "eth1".

> + system(command);
> +
> + memset(command, 0, sizeof(command));
> + snprintf(command, sizeof(command), "sudo ethtool -K %s ntuple on",
> + "eth1");

Please use ifname instead of "eth1" too.

> + system(command);
> +}
> +
> +static void configure_rss(void)
> +{
> + char command[256];
> +
> + memset(command, 0, sizeof(command));
> + snprintf(command, sizeof(command), "sudo ethtool -X %s equal %d",
> + ifname, start_queue);
> + system(command);
> +}
> +
> +static void configure_flow_steering(void)
> +{
> + char command[256];
> +
> + memset(command, 0, sizeof(command));
> + snprintf(command, sizeof(command),
> + "sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-=
port %s queue %d",
> + ifname, client_ip, server_ip, port, port, start_queue);
> + system(command);
> +}
> +
> +static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
> + struct netdev_queue_dmabuf *queues,
> + unsigned int n_queue_index, struct ynl_sock **ys)
> +{
> + struct netdev_bind_rx_req *req =3D NULL;
> + struct netdev_bind_rx_rsp *rsp =3D NULL;
> + struct ynl_error yerr;
> +
> + *ys =3D ynl_sock_create(&ynl_netdev_family, &yerr);
> + if (!*ys) {
> + fprintf(stderr, "YNL: %s\n", yerr.msg);
> + return -1;
> + }
> +
> + req =3D netdev_bind_rx_req_alloc();
> + netdev_bind_rx_req_set_ifindex(req, ifindex);
> + netdev_bind_rx_req_set_dmabuf_fd(req, dmabuf_fd);
> + __netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
> +
> + rsp =3D netdev_bind_rx(*ys, req);
> + if (!rsp) {
> + perror("netdev_bind_rx");
> + goto err_close;
> + }
> +
> + if (!rsp->_present.dmabuf_id) {
> + perror("dmabuf_id not present");
> + goto err_close;
> + }
> +
> + printf("got dmabuf id=3D%d\n", rsp->dmabuf_id);
> + dmabuf_id =3D rsp->dmabuf_id;
> +
> + netdev_bind_rx_req_free(req);
> + netdev_bind_rx_rsp_free(rsp);
> +
> + return 0;
> +
> +err_close:
> + fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
> + netdev_bind_rx_req_free(req);
> + ynl_sock_destroy(*ys);
> + return -1;
> +}
> +
> +static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmab=
uf_size)
> +{
> + struct udmabuf_create create;
> + int ret;
> +
> + *devfd =3D open("/dev/udmabuf", O_RDWR);
> + if (*devfd < 0) {
> + error(70, 0,
> + "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
> + TEST_PREFIX);
> + }
> +
> + *memfd =3D memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> + if (*memfd < 0)
> + error(70, 0, "%s: [skip,no-memfd]\n", TEST_PREFIX);
> +
> + /* Required for udmabuf */
> + ret =3D fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
> + if (ret < 0)
> + error(73, 0, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
> +
> + ret =3D ftruncate(*memfd, dmabuf_size);
> + if (ret =3D=3D -1)
> + error(74, 0, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
> +
> + memset(&create, 0, sizeof(create));
> +
> + create.memfd =3D *memfd;
> + create.offset =3D 0;
> + create.size =3D dmabuf_size;
> + *buf =3D ioctl(*devfd, UDMABUF_CREATE, &create);
> + if (*buf < 0)
> + error(75, 0, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
> +}
> +
> +int do_server(void)
> +{
> + char ctrl_data[sizeof(int) * 20000];
> + struct netdev_queue_dmabuf *queues;
> + size_t non_page_aligned_frags =3D 0;
> + struct sockaddr_in client_addr;
> + struct sockaddr_in server_sin;
> + size_t page_aligned_frags =3D 0;
> + int devfd, memfd, buf, ret;
> + size_t total_received =3D 0;
> + socklen_t client_addr_len;
> + bool is_devmem =3D false;
> + char *buf_mem =3D NULL;
> + struct ynl_sock *ys;
> + size_t dmabuf_size;
> + char iobuf[819200];
> + char buffer[256];
> + int socket_fd;
> + int client_fd;
> + size_t i =3D 0;
> + int opt =3D 1;
> +
> + dmabuf_size =3D getpagesize() * NUM_PAGES;
> +
> + create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
> +
> + reset_flow_steering();
> +
> + /* Configure RSS to divert all traffic from our devmem queues */
> + configure_rss();
> +
> + /* Flow steer our devmem flows to start_queue */
> + configure_flow_steering();
> +
> + sleep(1);
> +
> + queues =3D malloc(sizeof(*queues) * num_queues);
> +
> + for (i =3D 0; i < num_queues; i++) {
> + queues[i]._present.type =3D 1;
> + queues[i]._present.idx =3D 1;
> + queues[i].type =3D NETDEV_QUEUE_TYPE_RX;
> + queues[i].idx =3D start_queue + i;
> + }
> +
> + if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
> + error(1, 0, "Failed to bind\n");
> +
> + buf_mem =3D mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> + buf, 0);
> + if (buf_mem =3D=3D MAP_FAILED)
> + error(1, 0, "mmap()");
> +
> + server_sin.sin_family =3D AF_INET;
> + server_sin.sin_port =3D htons(atoi(port));
> +
> + ret =3D inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_add=
r);
> + if (socket < 0)
> + error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> +
> + socket_fd =3D socket(server_sin.sin_family, SOCK_STREAM, 0);
> + if (socket < 0)
> + error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> +
> + ret =3D setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
> + sizeof(opt));
> + if (ret)
> + error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
> +
> + ret =3D setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
> + sizeof(opt));
> + if (ret)
> + error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
> +
> + printf("binding to address %s:%d\n", server_ip,
> + ntohs(server_sin.sin_port));
> +
> + ret =3D bind(socket_fd, &server_sin, sizeof(server_sin));
> + if (ret)
> + error(errno, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
> +
> + ret =3D listen(socket_fd, 1);
> + if (ret)
> + error(errno, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
> +
> + client_addr_len =3D sizeof(client_addr);
> +
> + inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
> + sizeof(buffer));
> + printf("Waiting or connection on %s:%d\n", buffer,
> + ntohs(server_sin.sin_port));
> + client_fd =3D accept(socket_fd, &client_addr, &client_addr_len);
> +
> + inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
> + sizeof(buffer));
> + printf("Got connection from %s:%d\n", buffer,
> + ntohs(client_addr.sin_port));
> +
> + while (1) {
> + struct iovec iov =3D { .iov_base =3D iobuf,
> + .iov_len =3D sizeof(iobuf) };
> + struct dmabuf_cmsg *dmabuf_cmsg =3D NULL;
> + struct dma_buf_sync sync =3D { 0 };
> + struct cmsghdr *cm =3D NULL;
> + struct msghdr msg =3D { 0 };
> + struct dmabuf_token token;
> + ssize_t ret;
> +
> + is_devmem =3D false;
> + printf("\n\n");
> +
> + msg.msg_iov =3D &iov;
> + msg.msg_iovlen =3D 1;
> + msg.msg_control =3D ctrl_data;
> + msg.msg_controllen =3D sizeof(ctrl_data);
> + ret =3D recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
> + printf("recvmsg ret=3D%ld\n", ret);
> + if (ret < 0 && (errno =3D=3D EAGAIN || errno =3D=3D EWOULDBLOCK))
> + continue;
> + if (ret < 0) {
> + perror("recvmsg");
> + continue;
> + }
> + if (ret =3D=3D 0) {
> + printf("client exited\n");
> + goto cleanup;
> + }
> +
> + i++;
> + for (cm =3D CMSG_FIRSTHDR(&msg); cm; cm =3D CMSG_NXTHDR(&msg, cm)) {
> + if (cm->cmsg_level !=3D SOL_SOCKET ||
> + (cm->cmsg_type !=3D SCM_DEVMEM_DMABUF &&
> + cm->cmsg_type !=3D SCM_DEVMEM_LINEAR)) {
> + fprintf(stdout, "skipping non-devmem cmsg\n");
> + continue;
> + }
> +
> + dmabuf_cmsg =3D (struct dmabuf_cmsg *)CMSG_DATA(cm);
> + is_devmem =3D true;
> +
> + if (cm->cmsg_type =3D=3D SCM_DEVMEM_LINEAR) {
> + /* TODO: process data copied from skb's linear
> + * buffer.
> + */
> + fprintf(stdout,
> + "SCM_DEVMEM_LINEAR. dmabuf_cmsg->frag_size=3D%u\n",
> + dmabuf_cmsg->frag_size);
> +
> + continue;
> + }
> +
> + token.token_start =3D dmabuf_cmsg->frag_token;
> + token.token_count =3D 1;
> +
> + total_received +=3D dmabuf_cmsg->frag_size;
> + printf("received frag_page=3D%llu, in_page_offset=3D%llu, frag_offset=
=3D%llu, frag_size=3D%u, token=3D%u, total_received=3D%lu, dmabuf_id=3D%u\n=
",
> + dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
> + dmabuf_cmsg->frag_offset % getpagesize(),
> + dmabuf_cmsg->frag_offset, dmabuf_cmsg->frag_size,
> + dmabuf_cmsg->frag_token, total_received,
> + dmabuf_cmsg->dmabuf_id);
> +
> + if (dmabuf_cmsg->dmabuf_id !=3D dmabuf_id)
> + error(1, 0,
> + "received on wrong dmabuf_id: flow steering error\n");
> +
> + if (dmabuf_cmsg->frag_size % getpagesize())
> + non_page_aligned_frags++;
> + else
> + page_aligned_frags++;
> +
> + sync.flags =3D DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
> + ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
> +
> + if (do_validation)
> + validate_buffer(
> + ((unsigned char *)buf_mem) +
> + dmabuf_cmsg->frag_offset,
> + dmabuf_cmsg->frag_size);
> + else
> + print_nonzero_bytes(
> + ((unsigned char *)buf_mem) +
> + dmabuf_cmsg->frag_offset,
> + dmabuf_cmsg->frag_size);
> +
> + sync.flags =3D DMA_BUF_SYNC_READ | DMA_BUF_SYNC_END;
> + ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
> +
> + ret =3D setsockopt(client_fd, SOL_SOCKET,
> + SO_DEVMEM_DONTNEED, &token,
> + sizeof(token));
> + if (ret !=3D 1)
> + error(1, 0,
> + "SO_DEVMEM_DONTNEED not enough tokens");
> + }
> + if (!is_devmem)
> + error(1, 0, "flow steering error\n");
> +
> + printf("total_received=3D%lu\n", total_received);
> + }
> +
> + fprintf(stdout, "%s: ok\n", TEST_PREFIX);
> +
> + fprintf(stdout, "page_aligned_frags=3D%lu, non_page_aligned_frags=3D%lu=
\n",
> + page_aligned_frags, non_page_aligned_frags);
> +
> + fprintf(stdout, "page_aligned_frags=3D%lu, non_page_aligned_frags=3D%lu=
\n",
> + page_aligned_frags, non_page_aligned_frags);
> +
> +cleanup:
> +
> + munmap(buf_mem, dmabuf_size);
> + close(client_fd);
> + close(socket_fd);
> + close(buf);
> + close(memfd);
> + close(devfd);
> + ynl_sock_destroy(ys);
> +
> + return 0;
> +}
> +
> +void run_devmem_tests(void)
> +{
> + struct netdev_queue_dmabuf *queues;
> + int devfd, memfd, buf;
> + struct ynl_sock *ys;
> + size_t dmabuf_size;
> + size_t i =3D 0;
> +
> + dmabuf_size =3D getpagesize() * NUM_PAGES;
> +
> + create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
> +
> + /* Configure RSS to divert all traffic from our devmem queues */
> + configure_rss();
> +
> + sleep(1);
> +
> + queues =3D malloc(sizeof(*queues) * num_queues);
> +
> + for (i =3D 0; i < num_queues; i++) {
> + queues[i]._present.type =3D 1;
> + queues[i]._present.idx =3D 1;
> + queues[i].type =3D NETDEV_QUEUE_TYPE_RX;
> + queues[i].idx =3D start_queue + i;
> + }
> +
> + if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
> + error(1, 0, "Failed to bind\n");
> +
> + /* Closing the netlink socket does an implicit unbind */
> + ynl_sock_destroy(ys);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> + int is_server =3D 0, opt;
> +
> + while ((opt =3D getopt(argc, argv, "ls:c:p:v:q:f:n:i:d:")) !=3D -1) {

I think 't' option should be added here.

> + switch (opt) {
> + case 'l':
> + is_server =3D 1;
> + break;
> + case 's':
> + server_ip =3D optarg;
> + break;
> + case 'c':
> + client_ip =3D optarg;
> + break;
> + case 'p':
> + port =3D optarg;
> + break;
> + case 'v':
> + do_validation =3D atoll(optarg);
> + break;
> + case 'q':
> + num_queues =3D atoi(optarg);
> + break;
> + case 't':
> + start_queue =3D atoi(optarg);
> + break;
> + case 'f':
> + ifname =3D optarg;
> + break;
> + case 'd':
> + ifindex =3D atoi(optarg);

How about using if_nametoindex() instead of 'd' option?

> + break;
> + case 'i':
> + iterations =3D atoll(optarg);

I couldn't find a use of this variable.

> + break;
> + case '?':
> + printf("unknown option: %c\n", optopt);
> + break;
> + }
> + }
> +
> + for (; optind < argc; optind++)
> + printf("extra arguments: %s\n", argv[optind]);
> +
> + run_devmem_tests();
> +
> + if (is_server)
> + return do_server();
> +
> + return 0;
> +}
> --
> 2.45.2.803.g4e1b14247a-goog
>
>

Thanks a lot!
Taehee Yoo

