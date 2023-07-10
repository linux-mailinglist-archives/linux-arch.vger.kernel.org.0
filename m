Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD1274E168
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGJWfc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjGJWfa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:35:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D538010FF
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:34:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5707177ff8aso57554057b3.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689028455; x=1691620455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKO6sogguZyjcmLGJ/hPDJOveqN84Swf5N5/pg86eqs=;
        b=Xc1Br1GD5LT+ysV69O+uNAFOOUAbf02O+HrvNnkbfJ1izSzFy6Ok06vRSUdPziTGaE
         +3glhnpZcNM+j4eKCMIQwzsvEIs7TUtCF6YQ7B3LB5UhdlozLITb0gWXFx15pEiIQwHB
         lb1XngFtKIZWG1x07iobyzwkMGwrncaUqi7OjBAV9mfOg4lMhlt3qQue+doX9PnCJO43
         rujdU8bT5yD1p9K7vmBkF+fpO8gWOxm5COgUqgl1cz9uYCBrniBM+9z6RMAxOXhqziPJ
         biD0LDnt/JaMQ2Wj+vQZk9IEDe9NJK+hbJMwVlywjwf9Mrl5ow415UQIgWSBJjmiua/K
         kleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028455; x=1691620455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKO6sogguZyjcmLGJ/hPDJOveqN84Swf5N5/pg86eqs=;
        b=X28gxibUUcd6Y+PAXB8BGzh0HAAGDPg5OUKHigM0MCO09xBxImDOvA/7QTbu7A9YyV
         gTvqWBz1NE/sYi2ihVSgEo40y8K5m3xIgGe04+JSyiZdYsArRCIjbWdRxhdQUih5uLqk
         yk9a/MsjAIhSKPwv7apkhZp/IK3qH+j5KD440zTsdeX7NWPJJaWZkbIZLzUlFMFLUE36
         VyEaz3jx87VSVTwVpF9hztln6WpykjH4X+1C4JrRHSfurmPS9qUIEvuXAeCmLxN8ZrW1
         3nJccHvqupaMi1+/BLcPt5UfFe7DhB5L1xsYgSnDkJpGAkrCq5leffHCKTheqQmnxXwY
         XFrg==
X-Gm-Message-State: ABy/qLYAfziWZCjctBCfrVDxbeNh9HOhy6p99gQlsLs1l6bZeBGN9KXs
        IninyUQH+6NjNzzo+8E2kqAUuWIeve6wLrPVxA==
X-Google-Smtp-Source: APBJJlG5e3EZCuprxXAZBHD12ycHywImC9zBDIViU2VYzdwhsM3l+IXw2PlsHbyEhMIScVpgSI4Mos+P/4wWIVOHRw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c0f:bfb6:9942:8c53])
 (user=almasrymina job=sendgmr) by 2002:a81:d305:0:b0:56d:2a88:49e5 with SMTP
 id y5-20020a81d305000000b0056d2a8849e5mr98145ywi.2.1689028455695; Mon, 10 Jul
 2023 15:34:15 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:32:59 -0700
In-Reply-To: <20230710223304.1174642-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230710223304.1174642-9-almasrymina@google.com>
Subject: [RFC PATCH 08/10] selftests: add ncdevmem, netcat for devmem TCP
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ncdevmem is a devmem TCP netcat. It works similarly to netcat, but it
sends and receives data using the devmem TCP APIs. It uses udmabuf as
the dmabuf provider. It is compatible with a regular netcat running on
a peer, or a ncdevmem running on a peer.

In addition to normal netcat support, ncdevmem has a validation mode,
where it sends a specific pattern and validates this pattern on the
receiver side to ensure data integrity.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   1 +
 tools/testing/selftests/net/ncdevmem.c | 693 +++++++++++++++++++++++++
 3 files changed, 695 insertions(+)
 create mode 100644 tools/testing/selftests/net/ncdevmem.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index f27a7338b60e..1153ba177f1b 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -16,6 +16,7 @@ ipsec
 ipv6_flowlabel
 ipv6_flowlabel_mgr
 msg_zerocopy
+ncdevmem
 nettest
 psock_fanout
 psock_snd
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index c12df57d5539..ea5ccbd99d3b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -84,6 +84,7 @@ TEST_GEN_FILES += ip_local_port_range
 TEST_GEN_FILES += bind_wildcard
 TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
+TEST_GEN_FILES += ncdevmem
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
new file mode 100644
index 000000000000..4f62f22bf763
--- /dev/null
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -0,0 +1,693 @@
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
+
+#define PAGE_SHIFT 12
+#define PAGE_SIZE 4096
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
+ * * Without validation:
+ *
+ *	On server:
+ *	ncdevmem -s <server IP> -c <client IP> -f eth1 -n 0000:06:00.0 -l \
+ *		-p 5201
+ *
+ *	On client:
+ *	ncdevmem -s <server IP> -c <client IP> -f eth1 -n 0000:06:00.0 -p 5201
+ *
+ * * With Validation:
+ *	On server:
+ *	ncdevmem -s <server IP> -c <client IP> -l -f eth1 -n 0000:06:00.0 \
+ *		-p 5202 -v 1
+ *
+ *	On client:
+ *	ncdevmem -s <server IP> -c <client IP> -f eth1 -n 0000:06:00.0 -p 5202 \
+ *		-v 100000
+ *
+ * Note this is compatible with regular netcat. i.e. the sender or receiver can
+ * be replaced with regular netcat to test the RX or TX path in isolation.
+ */
+
+static char *server_ip = "192.168.1.4";
+static char *client_ip = "192.168.1.2";
+static char *port = "5201";
+static size_t do_validation = 0;
+static int queue_num = 15;
+static char *ifname = "eth1";
+static char *nic_pci_addr = "0000:06:00.0";
+static unsigned int iterations = 0;
+
+void print_bytes(void *ptr, size_t size)
+{
+	unsigned char *p = ptr;
+	int i;
+	for (i = 0; i < size; i++) {
+		printf("%02hhX ", p[i]);
+	}
+	printf("\n");
+}
+
+void print_nonzero_bytes(void *ptr, size_t size)
+{
+	unsigned char *p = ptr;
+	unsigned int i;
+	for (i = 0; i < size; i++) {
+		if (p[i])
+			printf("%c", p[i]);
+	}
+	printf("\n");
+}
+
+void initialize_validation(void *line, size_t size)
+{
+	static unsigned char seed = 1;
+	unsigned char *ptr = line;
+	for (size_t i = 0; i < size; i++) {
+		ptr[i] = seed;
+		seed++;
+		if (seed == 254)
+			seed = 0;
+	}
+}
+
+void validate_buffer(void *line, size_t size)
+{
+	static unsigned char seed = 1;
+	int errors = 0;
+
+	unsigned char *ptr = line;
+	for (size_t i = 0; i < size; i++) {
+		if (ptr[i] != seed) {
+			fprintf(stderr,
+				"Failed validation: expected=%u, "
+				"actual=%u, index=%lu\n",
+				seed, ptr[i], i);
+			errors++;
+			if (errors > 20)
+				exit(1);
+		}
+		seed++;
+		if (seed == 254)
+			seed = 0;
+	}
+
+	fprintf(stdout, "Validated buffer\n");
+}
+
+/* Triggers a driver reset...
+ *
+ * The proper way to do this is probably 'ethtool --reset', but I don't have
+ * that supported on my current test bed. I resort to changing this
+ * configuration in the driver which also causes a driver reset...
+ */
+static void reset_flow_steering()
+{
+	char command[256];
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
+static void configure_flow_steering()
+{
+	char command[256];
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command),
+		 "sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s "
+		 "src-port %s dst-port %s queue %d",
+		 ifname, client_ip, server_ip, port, port, queue_num);
+	system(command);
+}
+
+/* Triggers a device reset, which causes the dmabuf pages binding to take
+ * effect. A better and more generic way to do this may be ethtool --reset.
+ */
+static void trigger_device_reset()
+{
+	char command[256];
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command),
+		 "sudo ethtool --set-priv-flags %s enable-header-split off",
+		 ifname);
+	system(command);
+
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command),
+		 "sudo ethtool --set-priv-flags %s enable-header-split on",
+		 ifname);
+	system(command);
+}
+
+static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmabuf_size)
+{
+	struct udmabuf_create create;
+	int ret;
+
+	*devfd = open("/dev/udmabuf", O_RDWR);
+	if (*devfd < 0) {
+		fprintf(stderr,
+			"%s: [skip,no-udmabuf: Unable to access DMA "
+			"buffer device file]\n",
+			TEST_PREFIX);
+		exit(70);
+	}
+
+	*memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	if (*memfd < 0) {
+		printf("%s: [skip,no-memfd]\n", TEST_PREFIX);
+		exit(72);
+	}
+
+	ret = fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0) {
+		printf("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+		exit(73);
+	}
+
+	ret = ftruncate(*memfd, dmabuf_size);
+	if (ret == -1) {
+		printf("%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+		exit(74);
+	}
+
+	memset(&create, 0, sizeof(create));
+
+	create.memfd = *memfd;
+	create.offset = 0;
+	create.size = dmabuf_size;
+	*buf = ioctl(*devfd, UDMABUF_CREATE, &create);
+	if (*buf < 0) {
+		printf("%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
+		exit(75);
+	}
+}
+
+
+int do_server()
+{
+	struct dma_buf_create_pages_info pages_create_info = { 0 };
+	int devfd, memfd, buf, buf_pages, ret;
+	size_t dmabuf_size;
+
+	dmabuf_size = getpagesize() * NUM_PAGES;
+
+	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+
+	pages_create_info.dma_buf_fd = buf;
+	pages_create_info.type = DMA_BUF_PAGES_NET_RX;
+	pages_create_info.create_flags = (1 << queue_num);
+
+	ret = sscanf(nic_pci_addr, "0000:%hhx:%hhx.%hhx",
+		     &pages_create_info.pci_bdf[0],
+		     &pages_create_info.pci_bdf[1],
+		     &pages_create_info.pci_bdf[2]);
+
+	if (ret != 3) {
+		printf("%s: [FAIL, parse fail]\n", TEST_PREFIX);
+		exit(76);
+	}
+
+	buf_pages = ioctl(buf, DMA_BUF_CREATE_PAGES, &pages_create_info);
+	if (buf_pages < 0) {
+		perror("create pages");
+		exit(77);
+	}
+
+	char *buf_mem = NULL;
+	buf_mem = mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		       buf, 0);
+	if (buf_mem == MAP_FAILED) {
+		perror("mmap()");
+		exit(1);
+	}
+
+	/* Need to trigger the NIC to reallocate its RX pages, otherwise the
+	 * bind doesn't take effect.
+	 */
+	trigger_device_reset();
+
+	sleep(1);
+
+	reset_flow_steering();
+	configure_flow_steering();
+
+	struct sockaddr_in server_sin;
+	server_sin.sin_family = AF_INET;
+	server_sin.sin_port = htons(atoi(port));
+
+	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
+	if (socket < 0) {
+		printf("%s: [FAIL, create socket]\n", TEST_PREFIX);
+		exit(79);
+	}
+
+	int socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
+	if (socket < 0) {
+		printf("%s: [FAIL, create socket]\n", TEST_PREFIX);
+		exit(76);
+	}
+
+	int opt = 1;
+	ret = setsockopt(socket_fd, SOL_SOCKET,
+			 SO_REUSEADDR | SO_REUSEPORT | SO_ZEROCOPY, &opt,
+			 sizeof(opt));
+	if (ret) {
+		printf("%s: [FAIL, set sock opt]: %s\n", TEST_PREFIX,
+		       strerror(errno));
+		exit(76);
+	}
+
+	printf("binding to address %s:%d\n", server_ip,
+	       ntohs(server_sin.sin_port));
+
+	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
+	if (ret) {
+		printf("%s: [FAIL, bind]: %s\n", TEST_PREFIX, strerror(errno));
+		exit(76);
+	}
+
+	ret = listen(socket_fd, 1);
+	if (ret) {
+		printf("%s: [FAIL, listen]: %s\n", TEST_PREFIX,
+		       strerror(errno));
+		exit(76);
+	}
+
+	struct sockaddr_in client_addr;
+	socklen_t client_addr_len = sizeof(client_addr);
+
+	char buffer[256];
+
+	inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
+		  sizeof(buffer));
+	printf("Waiting or connection on %s:%d\n", buffer,
+	       ntohs(server_sin.sin_port));
+	int client_fd = accept(socket_fd, &client_addr, &client_addr_len);
+
+	inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
+		  sizeof(buffer));
+	printf("Got connection from %s:%d\n", buffer,
+	       ntohs(client_addr.sin_port));
+
+	char iobuf[819200];
+	char ctrl_data[sizeof(int) * 20000];
+
+	size_t total_received = 0;
+	size_t i = 0;
+	size_t page_aligned_frags = 0;
+	size_t non_page_aligned_frags = 0;
+	while (1) {
+		bool is_devmem = false;
+		printf("\n\n");
+
+		struct msghdr msg = { 0 };
+		struct iovec iov = { .iov_base = iobuf,
+				     .iov_len = sizeof(iobuf) };
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+		msg.msg_control = ctrl_data;
+		msg.msg_controllen = sizeof(ctrl_data);
+		ssize_t ret = recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
+		printf("recvmsg ret=%ld\n", ret);
+		if (ret < 0 && (errno == EAGAIN || errno == EWOULDBLOCK)) {
+			continue;
+		}
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
+		struct cmsghdr *cm = NULL;
+		struct cmsg_devmem *cmsg_devmem = NULL;
+		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+			if (cm->cmsg_level != SOL_SOCKET ||
+			    (cm->cmsg_type != SCM_DEVMEM_OFFSET &&
+			     cm->cmsg_type != SCM_DEVMEM_HEADER)) {
+				fprintf(stdout, "skipping non-devmem cmsg\n");
+				continue;
+			}
+
+			cmsg_devmem = (struct cmsg_devmem *)CMSG_DATA(cm);
+			is_devmem = true;
+
+			if (cm->cmsg_type == SCM_DEVMEM_HEADER) {
+				// TODO: process data copied from skb's linear
+				// buffer.
+				fprintf(stdout,
+					"SCM_DEVMEM_HEADER. "
+					"cmsg_devmem->frag_size=%u\n",
+					cmsg_devmem->frag_size);
+
+				continue;
+			}
+
+			struct devmemtoken token = { cmsg_devmem->frag_token,
+						     1 };
+
+			total_received += cmsg_devmem->frag_size;
+			printf("received frag_page=%u, in_page_offset=%u,"
+			       " frag_offset=%u, frag_size=%u, token=%u"
+			       " total_received=%lu\n",
+			       cmsg_devmem->frag_offset >> PAGE_SHIFT,
+			       cmsg_devmem->frag_offset % PAGE_SIZE,
+			       cmsg_devmem->frag_offset, cmsg_devmem->frag_size,
+			       cmsg_devmem->frag_token, total_received);
+
+			if (cmsg_devmem->frag_size % PAGE_SIZE)
+				non_page_aligned_frags++;
+			else
+				page_aligned_frags++;
+
+			struct dma_buf_sync sync = { 0 };
+			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
+			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+
+			if (do_validation)
+				validate_buffer(
+					((unsigned char *)buf_mem) +
+						cmsg_devmem->frag_offset,
+					cmsg_devmem->frag_size);
+			else
+				print_nonzero_bytes(
+					((unsigned char *)buf_mem) +
+						cmsg_devmem->frag_offset,
+					cmsg_devmem->frag_size);
+
+			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_END;
+			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+
+			ret = setsockopt(client_fd, SOL_SOCKET,
+					 SO_DEVMEM_DONTNEED, &token,
+					 sizeof(token));
+			if (ret) {
+				perror("SO_DEVMEM_DONTNEED");
+				exit(1);
+			}
+		}
+		if (!is_devmem)
+			printf("flow steering error\n");
+
+		printf("total_received=%lu\n", total_received);
+	}
+
+cleanup:
+	fprintf(stdout, "%s: ok\n", TEST_PREFIX);
+
+	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+		page_aligned_frags, non_page_aligned_frags);
+
+	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+		page_aligned_frags, non_page_aligned_frags);
+
+	munmap(buf_mem, dmabuf_size);
+	close(client_fd);
+	close(socket_fd);
+	close(buf_pages);
+	close(buf);
+	close(memfd);
+	close(devfd);
+	trigger_device_reset();
+
+	return 0;
+}
+
+int do_client()
+{
+	printf("doing client\n");
+
+	struct dma_buf_create_pages_info pages_create_info = { 0 };
+	int devfd, memfd, buf, buf_pages, ret;
+	size_t dmabuf_size;
+
+	dmabuf_size = getpagesize() * NUM_PAGES;
+
+	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+
+	pages_create_info.dma_buf_fd = buf;
+	pages_create_info.type = DMA_BUF_PAGES_NET_TX;
+
+	ret = sscanf(nic_pci_addr, "0000:%hhx:%hhx.%hhx",
+		     &pages_create_info.pci_bdf[0],
+		     &pages_create_info.pci_bdf[1],
+		     &pages_create_info.pci_bdf[2]);
+
+	if (ret != 3) {
+		printf("%s: [FAIL, parse fail]\n", TEST_PREFIX);
+		exit(76);
+	}
+
+	buf_pages = ioctl(buf, DMA_BUF_CREATE_PAGES, &pages_create_info);
+	if (buf_pages < 0) {
+		perror("create pages");
+		exit(77);
+	}
+
+	char *buf_mem = NULL;
+	buf_mem = mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		       buf, 0);
+	if (buf_mem == MAP_FAILED) {
+		perror("mmap()");
+		exit(1);
+	}
+
+	struct sockaddr_in server_sin;
+	server_sin.sin_family = AF_INET;
+	server_sin.sin_port = htons(atoi(port));
+
+	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
+	if (socket < 0) {
+		printf("%s: [FAIL, create socket]\n", TEST_PREFIX);
+		exit(79);
+	}
+
+	int socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
+	if (socket < 0) {
+		printf("%s: [FAIL, create socket]\n", TEST_PREFIX);
+		exit(76);
+	}
+
+	int opt = 1;
+	ret = setsockopt(socket_fd, SOL_SOCKET,
+			 SO_REUSEADDR | SO_REUSEPORT | SO_ZEROCOPY, &opt,
+			 sizeof(opt));
+	if (ret) {
+		printf("%s: [FAIL, set sock opt]: %s\n", TEST_PREFIX,
+		       strerror(errno));
+		exit(76);
+	}
+
+	struct sockaddr_in client_sin;
+	client_sin.sin_family = AF_INET;
+	client_sin.sin_port = htons(atoi(port));
+
+	ret = inet_pton(client_sin.sin_family, client_ip, &client_sin.sin_addr);
+	if (socket < 0) {
+		printf("%s: [FAIL, create socket]\n", TEST_PREFIX);
+		exit(79);
+	}
+
+	ret = bind(socket_fd, &client_sin, sizeof(client_sin));
+	if (ret) {
+		printf("%s: [FAIL, bind]: %s\n", TEST_PREFIX, strerror(errno));
+		exit(76);
+	}
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+	if (ret) {
+		printf("%s: [FAIL, set sock opt]: %s\n", TEST_PREFIX,
+		       strerror(errno));
+		exit(76);
+	}
+
+	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
+	if (ret) {
+		printf("%s: [FAIL, connect]: %s\n", TEST_PREFIX,
+		       strerror(errno));
+		exit(76);
+	}
+
+	char *line = NULL;
+	size_t line_size = 0;
+	size_t len = 0;
+
+	size_t i = 0;
+	while (!iterations || i < iterations) {
+		i++;
+		free(line);
+		line = NULL;
+		if (do_validation) {
+			line = malloc(do_validation);
+			if (!line) {
+				fprintf(stderr, "Failed to allocate\n");
+				exit(1);
+			}
+			memset(line, 0, do_validation);
+			initialize_validation(line, do_validation);
+			line_size = do_validation;
+		} else {
+			line_size = getline(&line, &len, stdin);
+		}
+
+		if (line_size < 0)
+			continue;
+
+		fprintf(stdout, "DEBUG: read line_size=%lu\n", line_size);
+
+		struct dma_buf_sync sync = { 0 };
+		sync.flags = DMA_BUF_SYNC_WRITE | DMA_BUF_SYNC_START;
+		ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+
+		memset(buf_mem, 0, dmabuf_size);
+		memcpy(buf_mem, line, line_size);
+
+		if (do_validation)
+			validate_buffer(buf_mem, line_size);
+
+		struct iovec iov = { .iov_base = NULL, .iov_len = line_size };
+
+		struct msghdr msg = { 0 };
+
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+
+		char ctrl_data[CMSG_SPACE(sizeof(int) * 2)];
+		msg.msg_control = ctrl_data;
+		msg.msg_controllen = sizeof(ctrl_data);
+
+		struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_type = SCM_DEVMEM_OFFSET;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(int) * 2);
+		*((int *)CMSG_DATA(cmsg)) = buf_pages;
+		((int *)CMSG_DATA(cmsg))[1] = 0;
+
+		ret = sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
+		if (ret < 0)
+			perror("sendmsg");
+		else
+			fprintf(stdout, "DEBUG: sendmsg_ret=%d\n", ret);
+
+		sync.flags = DMA_BUF_SYNC_WRITE | DMA_BUF_SYNC_END;
+		ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+
+		// sleep for a bit before we overwrite the dmabuf that's being
+		// sent.
+		if (do_validation)
+			sleep(1);
+	}
+
+	fprintf(stdout, "%s: ok\n", TEST_PREFIX);
+
+	while (1)
+		sleep(10);
+
+	munmap(buf_mem, dmabuf_size);
+
+	free(line);
+	close(socket_fd);
+	close(buf_pages);
+	close(buf);
+	close(memfd);
+	close(devfd);
+	trigger_device_reset();
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int is_server = 0, opt;
+
+	// put ':' in the starting of the
+	// string so that program can
+	//distinguish between '?' and ':'
+	while ((opt = getopt(argc, argv, "ls:c:p:v:q:f:n:i:")) != -1) {
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
+			queue_num = atoi(optarg);
+			break;
+		case 'f':
+			ifname = optarg;
+			break;
+		case 'n':
+			nic_pci_addr = optarg;
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
+	// optind is for the extra arguments
+	// which are not parsed
+	for (; optind < argc; optind++) {
+		printf("extra arguments: %s\n", argv[optind]);
+	}
+
+	if (is_server)
+		return do_server();
+
+	return do_client();
+}
-- 
2.41.0.390.g38632f3daf-goog

