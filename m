Return-Path: <linux-arch+bounces-4626-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF58D5396
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 22:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852B51F22017
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB66199EBE;
	Thu, 30 May 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gk4n7pn3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537AE18628D
	for <linux-arch@vger.kernel.org>; Thu, 30 May 2024 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100215; cv=none; b=ToCzho3lrUgoSPWWiOBfPOAfjRGPuLV3PgczZzWiLi7esLQ5AARV2qP/DQKYTzyyziaW7lZEZkadV7y5/xEnuLM9Am5FnPD37VNdyW7ksWRzPrmg1vkyswFCZ9l/MIRIbvta3JS3g8ZFVScmd77ZRhIcmyy1hDYO35sCc2pVDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100215; c=relaxed/simple;
	bh=LInu/jBkSG++r6iSgjLWgEgWYQibfLm7kW/Alr0T9Gk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pa7CUYx4/wEXXqeVBD7Ak86FG2FHrONWskOTnQo/0dFuVJ3Mdv4N2WgSO/BwVsudKrjnK+cFg/BvzQAi4lGsEcWnbBYLGLHjgSrMPhJpQvjSaGFDYqo1HI9Hv2rTGo54x2JczRjeeBmEA+ailBoLIUHenhHs1BqfIB8kaUtFcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gk4n7pn3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a0841402aso4247137b3.2
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2024 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717100204; x=1717705004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJiVWgtSrxfLAO3xDXDkkFapUzaLpqZpeRoBI8y0Ibg=;
        b=gk4n7pn3ec/gP86C7cLvH2di/uweNbuAjw08S2wPYNi7OQPF1LoCjKNKzrmNJdNoPj
         KNFNWLf8mrs9UDOjDtSuLqEbGdAcu7O/kSds0+Q5135XPwLE0t9ibbLP06+gAf4jNdq5
         S/g0hVt0eenTvRZiVpfEkc6vNfxklHTVyYzbBKdwGr4g1g4ZlSLlCF1Nt5/HO2mfKSAw
         IwLGauUWK+ylpsrC8qHxtAN/r9RWGSbOXZyiD13kjJ4AydFIl0bpKhD+IYe/vLyzU8++
         ajfqbZo8LBgkRklP/OJ6oVP8Kple2u758gDj946F6FZ7sWi49446kvxk8BXDZRLAE+V7
         ddvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100204; x=1717705004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJiVWgtSrxfLAO3xDXDkkFapUzaLpqZpeRoBI8y0Ibg=;
        b=iXauKGMjQdBIh5y+h+OMdMWfXqaPNDS1+9dSayU0VX+SzNhvWUN2rvAlHwed9Y5TA9
         qiYat8oCyU//QAWeNCfrZW621PXMBANLEPIKAerf166o68DqGNyTPNkkV+1sizfazUYC
         6TTWGimH4fLaijRFNAB0gFngM4XrpgBA0KM1o7XUp/5jdGAoB93uoCBZ3mZ7WyfTHls7
         rGYZmkLain28xLYgB7p7LJsywiBsQgcUFdLwRBpFxrUaNozm0aLc6Q6knXb/ZAKGFYQX
         MGy99nVSe7vK+ld6kPXqUnL6LGRS0Q1VElIAkwbCf98NClzQsTbSZmLh9EwQ5UrBHNXs
         m/rA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ28MD1qzKdHpAtPhLGumurIDkgYeSQoQySTsar1naOap1D8TRQAt4Pjj3yYT/WVIjlkf2efZMA4f5NL10zVq2EvFhiSJOJqDuEg==
X-Gm-Message-State: AOJu0YzgL/5VpVKQ3Jzlh2umO9JdWuDIIv+DobSjFatla/3eqXfnz72i
	2IFMtYQEPboaTJcE9hEu1lw0mtlgrVxgdjzt2cCwJibyEeKOqe+gAhFxtzVL/4VLBgZn7xxqxY3
	vQsU3NOPKQ7ESVNCfPUkteQ==
X-Google-Smtp-Source: AGHT+IHtpkSASVHTK3UMgGJZ4rIULXVX5QhUVMJ33d8nXEf9fNvkyHoVq8f2hNzAQAiJxxVmn2h5dAghgN7PsTQBlA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:70c:b0:df4:9b3d:669f with
 SMTP id 3f1490d57ef6-dfa5a5a6ae0mr253283276.1.1717100204455; Thu, 30 May 2024
 13:16:44 -0700 (PDT)
Date: Thu, 30 May 2024 20:16:13 +0000
In-Reply-To: <20240530201616.1316526-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240530201616.1316526-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240530201616.1316526-15-almasrymina@google.com>
Subject: [PATCH net-next v10 14/14] selftests: add ncdevmem, netcat for devmem TCP
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

ncdevmem is a devmem TCP netcat. It works similarly to netcat, but it
sends and receives data using the devmem TCP APIs. It uses udmabuf as
the dmabuf provider. It is compatible with a regular netcat running on
a peer, or a ncdevmem running on a peer.

In addition to normal netcat support, ncdevmem has a validation mode,
where it sends a specific pattern and validates this pattern on the
receiver side to ensure data integrity.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
v9: https://lore.kernel.org/netdev/20240403002053.2376017-15-almasrymina@google.com/
- Remove unused nic_pci_addr entry (Cong).

v6:
- Updated to bind 8 queues.
- Added RSS configuration.
- Added some more tests for the netlink API.

Changes in v1:
- Many more general cleanups (Willem).
- Removed driver reset (Jakub).
- Removed hardcoded if index (Paolo).

RFC v2:
- General cleanups (Willem).

---
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   5 +
 tools/testing/selftests/net/ncdevmem.c | 542 +++++++++++++++++++++++++
 3 files changed, 548 insertions(+)
 create mode 100644 tools/testing/selftests/net/ncdevmem.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 49a56eb5d0368..9cd3c99c6e5d4 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -17,6 +17,7 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 log.txt
 msg_zerocopy
+ncdevmem
 nettest
 psock_fanout
 psock_snd
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index bd01e4a0be2c2..df3fdd727ffb3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -5,6 +5,10 @@ CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
 CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../
+CFLAGS += -I../../../net/ynl/generated/
+CFLAGS += -I../../../net/ynl/lib/
+
+LDLIBS += ../../../net/ynl/lib/ynl.a ../../../net/ynl/generated/protos.a
 
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
 	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
@@ -91,6 +95,7 @@ TEST_PROGS += fdb_flush.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
+TEST_GEN_FILES += ncdevmem
 
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
new file mode 100644
index 0000000000000..e00255e54f77b
--- /dev/null
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -0,0 +1,542 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#define __EXPORTED_HEADERS__
+
+#include <linux/uio.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <string.h>
+#include <errno.h>
+#define __iovec_defined
+#include <fcntl.h>
+#include <malloc.h>
+#include <error.h>
+
+#include <arpa/inet.h>
+#include <sys/socket.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+
+#include <linux/memfd.h>
+#include <linux/if.h>
+#include <linux/dma-buf.h>
+#include <linux/udmabuf.h>
+#include <libmnl/libmnl.h>
+#include <linux/types.h>
+#include <linux/netlink.h>
+#include <linux/genetlink.h>
+#include <linux/netdev.h>
+#include <time.h>
+
+#include "netdev-user.h"
+#include <ynl.h>
+
+#define PAGE_SHIFT 12
+#define TEST_PREFIX "ncdevmem"
+#define NUM_PAGES 16000
+
+#ifndef MSG_SOCK_DEVMEM
+#define MSG_SOCK_DEVMEM 0x2000000
+#endif
+
+/*
+ * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
+ * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
+ *
+ * Usage:
+ *
+ *	On server:
+ *	ncdevmem -s <server IP> -c <client IP> -f eth1 -d 3 -n 0000:06:00.0 -l \
+ *		-p 5201 -v 7
+ *
+ *	On client:
+ *	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
+ *		tr \\n \\0 | \
+ *		head -c 5G | \
+ *		nc <server IP> 5201 -p 5201
+ *
+ * Note this is compatible with regular netcat. i.e. the sender or receiver can
+ * be replaced with regular netcat to test the RX or TX path in isolation.
+ */
+
+static char *server_ip = "192.168.1.4";
+static char *client_ip = "192.168.1.2";
+static char *port = "5201";
+static size_t do_validation;
+static int start_queue = 8;
+static int num_queues = 8;
+static char *ifname = "eth1";
+static unsigned int ifindex = 3;
+static unsigned int iterations;
+static unsigned int dmabuf_id;
+
+void print_bytes(void *ptr, size_t size)
+{
+	unsigned char *p = ptr;
+	int i;
+
+	for (i = 0; i < size; i++)
+		printf("%02hhX ", p[i]);
+	printf("\n");
+}
+
+void print_nonzero_bytes(void *ptr, size_t size)
+{
+	unsigned char *p = ptr;
+	unsigned int i;
+
+	for (i = 0; i < size; i++)
+		putchar(p[i]);
+	printf("\n");
+}
+
+void validate_buffer(void *line, size_t size)
+{
+	static unsigned char seed = 1;
+	unsigned char *ptr = line;
+	int errors = 0;
+	size_t i;
+
+	for (i = 0; i < size; i++) {
+		if (ptr[i] != seed) {
+			fprintf(stderr,
+				"Failed validation: expected=%u, actual=%u, index=%lu\n",
+				seed, ptr[i], i);
+			errors++;
+			if (errors > 20)
+				error(1, 0, "validation failed.");
+		}
+		seed++;
+		if (seed == do_validation)
+			seed = 0;
+	}
+
+	fprintf(stdout, "Validated buffer\n");
+}
+
+static void reset_flow_steering(void)
+{
+	char command[256];
+
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command), "sudo ethtool -K %s ntuple off",
+		 "eth1");
+	system(command);
+
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command), "sudo ethtool -K %s ntuple on",
+		 "eth1");
+	system(command);
+}
+
+static void configure_rss(void)
+{
+	char command[256];
+
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command), "sudo ethtool -X %s equal %d",
+		 ifname, start_queue);
+	system(command);
+}
+
+static void configure_flow_steering(void)
+{
+	char command[256];
+
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command),
+		 "sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d",
+		 ifname, client_ip, server_ip, port, port, start_queue);
+	system(command);
+}
+
+static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
+			 struct netdev_queue_dmabuf *queues,
+			 unsigned int n_queue_index, struct ynl_sock **ys)
+{
+	struct netdev_bind_rx_req *req = NULL;
+	struct netdev_bind_rx_rsp *rsp = NULL;
+	struct ynl_error yerr;
+
+	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!*ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = netdev_bind_rx_req_alloc();
+	netdev_bind_rx_req_set_ifindex(req, ifindex);
+	netdev_bind_rx_req_set_dmabuf_fd(req, dmabuf_fd);
+	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
+
+	rsp = netdev_bind_rx(*ys, req);
+	if (!rsp) {
+		perror("netdev_bind_rx");
+		goto err_close;
+	}
+
+	if (!rsp->_present.dmabuf_id) {
+		perror("dmabuf_id not present");
+		goto err_close;
+	}
+
+	printf("got dmabuf id=%d\n", rsp->dmabuf_id);
+	dmabuf_id = rsp->dmabuf_id;
+
+	netdev_bind_rx_req_free(req);
+	netdev_bind_rx_rsp_free(rsp);
+
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
+	netdev_bind_rx_req_free(req);
+	ynl_sock_destroy(*ys);
+	return -1;
+}
+
+static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmabuf_size)
+{
+	struct udmabuf_create create;
+	int ret;
+
+	*devfd = open("/dev/udmabuf", O_RDWR);
+	if (*devfd < 0) {
+		error(70, 0,
+		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
+		      TEST_PREFIX);
+	}
+
+	*memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	if (*memfd < 0)
+		error(70, 0, "%s: [skip,no-memfd]\n", TEST_PREFIX);
+
+	/* Required for udmabuf */
+	ret = fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0)
+		error(73, 0, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+
+	ret = ftruncate(*memfd, dmabuf_size);
+	if (ret == -1)
+		error(74, 0, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+
+	memset(&create, 0, sizeof(create));
+
+	create.memfd = *memfd;
+	create.offset = 0;
+	create.size = dmabuf_size;
+	*buf = ioctl(*devfd, UDMABUF_CREATE, &create);
+	if (*buf < 0)
+		error(75, 0, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
+}
+
+int do_server(void)
+{
+	char ctrl_data[sizeof(int) * 20000];
+	struct netdev_queue_dmabuf *queues;
+	size_t non_page_aligned_frags = 0;
+	struct sockaddr_in client_addr;
+	struct sockaddr_in server_sin;
+	size_t page_aligned_frags = 0;
+	int devfd, memfd, buf, ret;
+	size_t total_received = 0;
+	socklen_t client_addr_len;
+	bool is_devmem = false;
+	char *buf_mem = NULL;
+	struct ynl_sock *ys;
+	size_t dmabuf_size;
+	char iobuf[819200];
+	char buffer[256];
+	int socket_fd;
+	int client_fd;
+	size_t i = 0;
+	int opt = 1;
+
+	dmabuf_size = getpagesize() * NUM_PAGES;
+
+	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+
+	reset_flow_steering();
+
+	/* Configure RSS to divert all traffic from our devmem queues */
+	configure_rss();
+
+	/* Flow steer our devmem flows to start_queue */
+	configure_flow_steering();
+
+	sleep(1);
+
+	queues = malloc(sizeof(*queues) * num_queues);
+
+	for (i = 0; i < num_queues; i++) {
+		queues[i]._present.type = 1;
+		queues[i]._present.idx = 1;
+		queues[i].type = NETDEV_QUEUE_TYPE_RX;
+		queues[i].idx = start_queue + i;
+	}
+
+	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+		error(1, 0, "Failed to bind\n");
+
+	buf_mem = mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		       buf, 0);
+	if (buf_mem == MAP_FAILED)
+		error(1, 0, "mmap()");
+
+	server_sin.sin_family = AF_INET;
+	server_sin.sin_port = htons(atoi(port));
+
+	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
+	if (socket < 0)
+		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+
+	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
+	if (socket < 0)
+		error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
+			 sizeof(opt));
+	if (ret)
+		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
+			 sizeof(opt));
+	if (ret)
+		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+
+	printf("binding to address %s:%d\n", server_ip,
+	       ntohs(server_sin.sin_port));
+
+	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
+	if (ret)
+		error(errno, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
+
+	ret = listen(socket_fd, 1);
+	if (ret)
+		error(errno, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
+
+	client_addr_len = sizeof(client_addr);
+
+	inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
+		  sizeof(buffer));
+	printf("Waiting or connection on %s:%d\n", buffer,
+	       ntohs(server_sin.sin_port));
+	client_fd = accept(socket_fd, &client_addr, &client_addr_len);
+
+	inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
+		  sizeof(buffer));
+	printf("Got connection from %s:%d\n", buffer,
+	       ntohs(client_addr.sin_port));
+
+	while (1) {
+		struct iovec iov = { .iov_base = iobuf,
+				     .iov_len = sizeof(iobuf) };
+		struct dmabuf_cmsg *dmabuf_cmsg = NULL;
+		struct dma_buf_sync sync = { 0 };
+		struct cmsghdr *cm = NULL;
+		struct msghdr msg = { 0 };
+		struct dmabuf_token token;
+		ssize_t ret;
+
+		is_devmem = false;
+		printf("\n\n");
+
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+		msg.msg_control = ctrl_data;
+		msg.msg_controllen = sizeof(ctrl_data);
+		ret = recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
+		printf("recvmsg ret=%ld\n", ret);
+		if (ret < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
+			continue;
+		if (ret < 0) {
+			perror("recvmsg");
+			continue;
+		}
+		if (ret == 0) {
+			printf("client exited\n");
+			goto cleanup;
+		}
+
+		i++;
+		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+			if (cm->cmsg_level != SOL_SOCKET ||
+			    (cm->cmsg_type != SCM_DEVMEM_DMABUF &&
+			     cm->cmsg_type != SCM_DEVMEM_LINEAR)) {
+				fprintf(stdout, "skipping non-devmem cmsg\n");
+				continue;
+			}
+
+			dmabuf_cmsg = (struct dmabuf_cmsg *)CMSG_DATA(cm);
+			is_devmem = true;
+
+			if (cm->cmsg_type == SCM_DEVMEM_LINEAR) {
+				/* TODO: process data copied from skb's linear
+				 * buffer.
+				 */
+				fprintf(stdout,
+					"SCM_DEVMEM_LINEAR. dmabuf_cmsg->frag_size=%u\n",
+					dmabuf_cmsg->frag_size);
+
+				continue;
+			}
+
+			token.token_start = dmabuf_cmsg->frag_token;
+			token.token_count = 1;
+
+			total_received += dmabuf_cmsg->frag_size;
+			printf("received frag_page=%llu, in_page_offset=%llu, frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu, dmabuf_id=%u\n",
+			       dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
+			       dmabuf_cmsg->frag_offset % getpagesize(),
+			       dmabuf_cmsg->frag_offset, dmabuf_cmsg->frag_size,
+			       dmabuf_cmsg->frag_token, total_received,
+			       dmabuf_cmsg->dmabuf_id);
+
+			if (dmabuf_cmsg->dmabuf_id != dmabuf_id)
+				error(1, 0,
+				      "received on wrong dmabuf_id: flow steering error\n");
+
+			if (dmabuf_cmsg->frag_size % getpagesize())
+				non_page_aligned_frags++;
+			else
+				page_aligned_frags++;
+
+			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
+			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+
+			if (do_validation)
+				validate_buffer(
+					((unsigned char *)buf_mem) +
+						dmabuf_cmsg->frag_offset,
+					dmabuf_cmsg->frag_size);
+			else
+				print_nonzero_bytes(
+					((unsigned char *)buf_mem) +
+						dmabuf_cmsg->frag_offset,
+					dmabuf_cmsg->frag_size);
+
+			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_END;
+			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+
+			ret = setsockopt(client_fd, SOL_SOCKET,
+					 SO_DEVMEM_DONTNEED, &token,
+					 sizeof(token));
+			if (ret != 1)
+				error(1, 0,
+				      "SO_DEVMEM_DONTNEED not enough tokens");
+		}
+		if (!is_devmem)
+			error(1, 0, "flow steering error\n");
+
+		printf("total_received=%lu\n", total_received);
+	}
+
+	fprintf(stdout, "%s: ok\n", TEST_PREFIX);
+
+	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+		page_aligned_frags, non_page_aligned_frags);
+
+	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+		page_aligned_frags, non_page_aligned_frags);
+
+cleanup:
+
+	munmap(buf_mem, dmabuf_size);
+	close(client_fd);
+	close(socket_fd);
+	close(buf);
+	close(memfd);
+	close(devfd);
+	ynl_sock_destroy(ys);
+
+	return 0;
+}
+
+void run_devmem_tests(void)
+{
+	struct netdev_queue_dmabuf *queues;
+	int devfd, memfd, buf;
+	struct ynl_sock *ys;
+	size_t dmabuf_size;
+	size_t i = 0;
+
+	dmabuf_size = getpagesize() * NUM_PAGES;
+
+	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+
+	/* Configure RSS to divert all traffic from our devmem queues */
+	configure_rss();
+
+	sleep(1);
+
+	queues = malloc(sizeof(*queues) * num_queues);
+
+	for (i = 0; i < num_queues; i++) {
+		queues[i]._present.type = 1;
+		queues[i]._present.idx = 1;
+		queues[i].type = NETDEV_QUEUE_TYPE_RX;
+		queues[i].idx = start_queue + i;
+	}
+
+	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+		error(1, 0, "Failed to bind\n");
+
+	/* Closing the netlink socket does an implicit unbind */
+	ynl_sock_destroy(ys);
+}
+
+int main(int argc, char *argv[])
+{
+	int is_server = 0, opt;
+
+	while ((opt = getopt(argc, argv, "ls:c:p:v:q:f:n:i:d:")) != -1) {
+		switch (opt) {
+		case 'l':
+			is_server = 1;
+			break;
+		case 's':
+			server_ip = optarg;
+			break;
+		case 'c':
+			client_ip = optarg;
+			break;
+		case 'p':
+			port = optarg;
+			break;
+		case 'v':
+			do_validation = atoll(optarg);
+			break;
+		case 'q':
+			num_queues = atoi(optarg);
+			break;
+		case 't':
+			start_queue = atoi(optarg);
+			break;
+		case 'f':
+			ifname = optarg;
+			break;
+		case 'd':
+			ifindex = atoi(optarg);
+			break;
+		case 'i':
+			iterations = atoll(optarg);
+			break;
+		case '?':
+			printf("unknown option: %c\n", optopt);
+			break;
+		}
+	}
+
+	for (; optind < argc; optind++)
+		printf("extra arguments: %s\n", argv[optind]);
+
+	run_devmem_tests();
+
+	if (is_server)
+		return do_server();
+
+	return 0;
+}
-- 
2.45.1.288.g0e0cd299f1-goog


