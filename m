Return-Path: <linux-arch+bounces-101-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348FC7E6917
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 12:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84AF8B20D10
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56220182AF;
	Thu,  9 Nov 2023 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSVq+CPU"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE519445
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 11:04:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC80271F
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 03:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699527841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTHdoswUAcs5z99P9gQJOP7b9HTzdGGGib7KL3ylz+E=;
	b=LSVq+CPUUIbuT7zPmZD+2kmH8/xjB+2zBRdrBV86bSadd7v2K88Tw8e/WqyrnpsG7Yg0Td
	ebhZCDm0cVXDQF9SfRinRV3gJ39WClTRsHqOg4ymlSRyHG8RLHWVsDfhNxDcP2lWNYw1wy
	PQdLHLJlmSOGZ4BNOV4zzD0fWgE2wNk=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-nK5cxGLMPJSkxE5nM_yH8Q-1; Thu, 09 Nov 2023 06:04:00 -0500
X-MC-Unique: nK5cxGLMPJSkxE5nM_yH8Q-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4abf46a7107so145661e0c.1
        for <linux-arch@vger.kernel.org>; Thu, 09 Nov 2023 03:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699527839; x=1700132639;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTHdoswUAcs5z99P9gQJOP7b9HTzdGGGib7KL3ylz+E=;
        b=Q+VcdhyhR/srujCz8nObAnpw3fhIdGp/kM1y22skGXxt0DDX/dPh7pCRvEQ4M5Ztrx
         ACR/8Ph0K0drXLC+H2ZH4v5CQYjEvLRq8yldAhuewbSPdCnJqq+JZj+zBP2n5jEQJR4Q
         Dat2ONDkfXVkpXsy6dJhVDmn+O49aa7bh5AIJMa/bYQvNm1Qr0PWwUrRug8rPXOGXyBd
         Wb6y6/Q+UXCo+MHyZJXVKGIPfbGgk1WfrmsWDwQEdXg8drmHbaB3FzmZnt+SqiM96TYP
         FA7exmWCIX+wQPL7nL2t7+snUxWB1abewbgtr6yIhxB+5IXyqgeoY6Nr/LnAnHIYdKWF
         Tafg==
X-Gm-Message-State: AOJu0YzfeuV0BdbQk2cQUcSiU0bmaVh+lGT6TAWvzohbkdamj0eDM0am
	zM46p41HU9ZpJIrCflmkEGZdb/VwmdqXZ3kGvI82vU1jL055HzUBb9Kl2DaiaWioH1WmHCu7noS
	CZhle+gKL+RjL39IlGdqi4w==
X-Received: by 2002:a67:fe4f:0:b0:45d:b4ae:ddb9 with SMTP id m15-20020a67fe4f000000b0045db4aeddb9mr4081981vsr.2.1699527839668;
        Thu, 09 Nov 2023 03:03:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/PKB7u4hZG7vUEjD4FVPQ4r2OiRrvyLgxkTsj6m7W595bd9b7FYDieBBb/+sfLZB5ri4zKA==
X-Received: by 2002:a67:fe4f:0:b0:45d:b4ae:ddb9 with SMTP id m15-20020a67fe4f000000b0045db4aeddb9mr4081949vsr.2.1699527839319;
        Thu, 09 Nov 2023 03:03:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id e6-20020ad44426000000b0065afcf19e23sm1949798qvt.62.2023.11.09.03.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:03:58 -0800 (PST)
Message-ID: <53b5c756ff3387e81796d1859c79276a09328234.camel@redhat.com>
Subject: Re: [RFC PATCH v3 12/12] selftests: add ncdevmem, netcat for devmem
 TCP
From: Paolo Abeni <pabeni@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,  Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
  Stanislav Fomichev <sdf@google.com>
Date: Thu, 09 Nov 2023 12:03:54 +0100
In-Reply-To: <20231106024413.2801438-13-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	 <20231106024413.2801438-13-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
> @@ -91,6 +95,7 @@ TEST_PROGS +=3D test_bridge_neigh_suppress.sh
>  TEST_PROGS +=3D test_vxlan_nolocalbypass.sh
>  TEST_PROGS +=3D test_bridge_backup_port.sh
>  TEST_PROGS +=3D fdb_flush.sh
> +TEST_GEN_FILES +=3D ncdevmem

I guess we want something added to TEST_PROGS, too ;)

>  TEST_FILES :=3D settings
> =20
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> new file mode 100644
> index 000000000000..78bc3ad767ca
> --- /dev/null
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -0,0 +1,546 @@
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
> + * * Without validation:
> + *
> + *	On server:
> + *	ncdevmem -s <server IP> -c <client IP> -f eth1 -n 0000:06:00.0 -l \
> + *		-p 5201
> + *
> + *	On client:
> + *	ncdevmem -s <server IP> -c <client IP> -f eth1 -n 0000:06:00.0 -p 520=
1
> + *
> + * * With Validation:
> + *	On server:
> + *	ncdevmem -s <server IP> -c <client IP> -l -f eth1 -n 0000:06:00.0 \
> + *		-p 5202 -v 1
> + *
> + *	On client:
> + *	ncdevmem -s <server IP> -c <client IP> -f eth1 -n 0000:06:00.0 -p 520=
2 \
> + *		-v 100000
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
> +static int queue_num =3D 15;
> +static char *ifname =3D "eth1";
> +static char *nic_pci_addr =3D "0000:06:00.0";
> +static unsigned int iterations;
> +
> +void print_bytes(void *ptr, size_t size)
> +{
> +	unsigned char *p =3D ptr;
> +	int i;
> +
> +	for (i =3D 0; i < size; i++) {
> +		printf("%02hhX ", p[i]);
> +	}
> +	printf("\n");
> +}
> +
> +void print_nonzero_bytes(void *ptr, size_t size)
> +{
> +	unsigned char *p =3D ptr;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < size; i++)
> +		putchar(p[i]);
> +	printf("\n");
> +}
> +
> +void validate_buffer(void *line, size_t size)
> +{
> +	static unsigned char seed =3D 1;
> +	unsigned char *ptr =3D line;
> +	int errors =3D 0;
> +	size_t i;
> +
> +	for (i =3D 0; i < size; i++) {
> +		if (ptr[i] !=3D seed) {
> +			fprintf(stderr,
> +				"Failed validation: expected=3D%u, actual=3D%u, index=3D%lu\n",
> +				seed, ptr[i], i);
> +			errors++;
> +			if (errors > 20)
> +				exit(1);
> +		}
> +		seed++;
> +		if (seed =3D=3D do_validation)
> +			seed =3D 0;
> +	}
> +
> +	fprintf(stdout, "Validated buffer\n");
> +}
> +
> +static void reset_flow_steering(void)
> +{
> +	char command[256];
> +
> +	memset(command, 0, sizeof(command));
> +	snprintf(command, sizeof(command), "sudo ethtool -K %s ntuple off",
> +		 "eth1");
> +	system(command);
> +
> +	memset(command, 0, sizeof(command));
> +	snprintf(command, sizeof(command), "sudo ethtool -K %s ntuple on",
> +		 "eth1");
> +	system(command);
> +}
> +
> +static void configure_flow_steering(void)
> +{
> +	char command[256];
> +
> +	memset(command, 0, sizeof(command));
> +	snprintf(command, sizeof(command),
> +		 "sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s ds=
t-port %s queue %d",
> +		 ifname, client_ip, server_ip, port, port, queue_num);
> +	system(command);
> +}
> +
> +/* Triggers a driver reset...
> + *
> + * The proper way to do this is probably 'ethtool --reset', but I don't =
have
> + * that supported on my current test bed. I resort to changing this
> + * configuration in the driver which also causes a driver reset...
> + */
> +static void trigger_device_reset(void)
> +{
> +	char command[256];
> +
> +	memset(command, 0, sizeof(command));
> +	snprintf(command, sizeof(command),
> +		 "sudo ethtool --set-priv-flags %s enable-header-split off",
> +		 ifname);
> +	system(command);
> +
> +	memset(command, 0, sizeof(command));
> +	snprintf(command, sizeof(command),
> +		 "sudo ethtool --set-priv-flags %s enable-header-split on",
> +		 ifname);
> +	system(command);
> +}
> +
> +static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
> +			 __u32 *queue_idx, unsigned int n_queue_index,
> +			 struct ynl_sock **ys)
> +{
> +	struct netdev_bind_rx_req *req =3D NULL;
> +	struct ynl_error yerr;
> +	int ret =3D 0;
> +
> +	*ys =3D ynl_sock_create(&ynl_netdev_family, &yerr);
> +	if (!*ys) {
> +		fprintf(stderr, "YNL: %s\n", yerr.msg);
> +		return -1;
> +	}
> +
> +	if (ynl_subscribe(*ys, "mgmt"))
> +		goto err_close;
> +
> +	req =3D netdev_bind_rx_req_alloc();
> +	netdev_bind_rx_req_set_ifindex(req, ifindex);
> +	netdev_bind_rx_req_set_dmabuf_fd(req, dmabuf_fd);
> +	__netdev_bind_rx_req_set_queues(req, queue_idx, n_queue_index);
> +
> +	ret =3D netdev_bind_rx(*ys, req);
> +	if (!ret) {
> +		perror("netdev_bind_rx");
> +		goto err_close;
> +	}
> +
> +	netdev_bind_rx_req_free(req);
> +
> +	return 0;
> +
> +err_close:
> +	fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
> +	netdev_bind_rx_req_free(req);
> +	ynl_sock_destroy(*ys);
> +	return -1;
> +}
> +
> +static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmab=
uf_size)
> +{
> +	struct udmabuf_create create;
> +	int ret;
> +
> +	*devfd =3D open("/dev/udmabuf", O_RDWR);
> +	if (*devfd < 0) {
> +		fprintf(stderr,
> +			"%s: [skip,no-udmabuf: Unable to access DMA "
> +			"buffer device file]\n",
> +			TEST_PREFIX);
> +		exit(70);
> +	}
> +
> +	*memfd =3D memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> +	if (*memfd < 0) {
> +		printf("%s: [skip,no-memfd]\n", TEST_PREFIX);
> +		exit(72);
> +	}
> +
> +	ret =3D fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
> +	if (ret < 0) {
> +		printf("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
> +		exit(73);
> +	}
> +
> +	ret =3D ftruncate(*memfd, dmabuf_size);
> +	if (ret =3D=3D -1) {
> +		printf("%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
> +		exit(74);
> +	}
> +
> +	memset(&create, 0, sizeof(create));
> +
> +	create.memfd =3D *memfd;
> +	create.offset =3D 0;
> +	create.size =3D dmabuf_size;
> +	*buf =3D ioctl(*devfd, UDMABUF_CREATE, &create);
> +	if (*buf < 0) {
> +		printf("%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
> +		exit(75);
> +	}
> +}
> +
> +int do_server(void)
> +{
> +	char ctrl_data[sizeof(int) * 20000];
> +	size_t non_page_aligned_frags =3D 0;
> +	struct sockaddr_in client_addr;
> +	struct sockaddr_in server_sin;
> +	size_t page_aligned_frags =3D 0;
> +	int devfd, memfd, buf, ret;
> +	size_t total_received =3D 0;
> +	bool is_devmem =3D false;
> +	char *buf_mem =3D NULL;
> +	struct ynl_sock *ys;
> +	size_t dmabuf_size;
> +	char iobuf[819200];
> +	char buffer[256];
> +	int socket_fd;
> +	int client_fd;
> +	size_t i =3D 0;
> +	int opt =3D 1;
> +
> +	dmabuf_size =3D getpagesize() * NUM_PAGES;
> +
> +	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
> +
> +	__u32 *queue_idx =3D malloc(sizeof(__u32) * 2);
> +
> +	queue_idx[0] =3D 14;
> +	queue_idx[1] =3D 15;
> +	if (bind_rx_queue(3 /* index for eth1 */, buf, queue_idx, 2, &ys)) {
                          ^^^^^^^^^^^^^^^^^^^
I guess we want to explicitly fetch the "ifname" index.

Side note: I'm wondering if we could extend some kind of virtual device
to allow single host self-tests? e.g. veth, if that would not cause
excessive bloat in the device driver?

Cheers,

Paolo


