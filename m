Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4E5197EDE
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgC3OsZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:48:25 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:37847 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgC3OsZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:48:25 -0400
Received: by mail-pl1-f181.google.com with SMTP id x1so6813712plm.4
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8RkGkzvpEn2gE6ufEUfTmXKju5Dp210suWhMm1w9oYg=;
        b=GrDwNAH0WCdAruDR2vlb2GixUp32KNVjA1xdPTaaHzg5AV3HFQbP4VYSLu39FUFAVv
         DF0OahuEKkewaaH8KCwsyV8s6CbTQqVUbVyLZUcglIPixX0uxWNvLEuO+U0BE+i8hICH
         ziwHQLlAXt8HqM28dxKO1afmb0PenOaKLbwJ5maEYOAQZdZCl4C1nvgVwEmTGWgpBDd0
         MF1a2714AAkTot534vMU6agA/NMqGmIny1re9TEVaCyzHXkLx/D4Xk6BIPgEmiHKzfgE
         6LIealkrfViOg8qQdPejBEQSGl9GLhdLoY4XwhoCzOK2mIWSQJMbDbPpsybm4S6pFUkz
         wpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8RkGkzvpEn2gE6ufEUfTmXKju5Dp210suWhMm1w9oYg=;
        b=LzMPv+n/DGAl9er9iTTD9n5tv6W4hcI9KsEtSCCbWVv5v6IFKqbOBQ7EftRCTSMGK/
         x/Fh86poF2kHBW6vDlFNiJmABRLpyTj1Gt79XTxSQgpgKf7ql9LXHaoH58y0nRMPAZzv
         aGSuwKF3NPSG0nNJNKAmkZQb4O8etpVxsYgxHcElXURcA7lsDpKvJlmSwRsv0TGGGq7N
         3lHBpKbCmHtV8+rX3lrI0Qsgn/ENeZwTLZFRPD+md+peA96/LlpzUHXOSaQnJeYTpZx/
         2R05ge4Ayn3uHgKu9vp2zXvLkOG2ADz9uOQt8pLRjHudmVSwwJSY6Q5jLZeFP76+0vbq
         ckyA==
X-Gm-Message-State: ANhLgQ0NSh8GwZX0x4fUhCr6QOtq59RXrRExCG4n58uhmonkN/Hqs2W0
        ncUWpclWn8bTaLZiMTp4oACwikOJ37HexQ==
X-Google-Smtp-Source: ADFU+vvKD6fi6KeNUEa083IDPVpmuJ3GOegOTD/XqHjp4Mu6L8kt8KoR8dnHBg9SiYntKJ3XmsZx8w==
X-Received: by 2002:a17:902:8c94:: with SMTP id t20mr12792932plo.170.1585579702376;
        Mon, 30 Mar 2020 07:48:22 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id o11sm9703435pgh.78.2020.03.30.07.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:48:21 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id BCBF0202804DF2; Mon, 30 Mar 2020 23:48:19 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 15/25] lkl tools: host lib: networking helpers
Date:   Mon, 30 Mar 2020 23:45:47 +0900
Message-Id: <94b12a3395df2184c2faa9a95393166fc7fca46a.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit adds LKL application APIs to control network related
resources of kernel via LKL syscall, ioctl, and via netlink messages.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 tools/lkl/include/lkl.h      | 241 ++++++++++
 tools/lkl/include/lkl_host.h |  85 ++++
 tools/lkl/lib/Build          |   1 +
 tools/lkl/lib/net.c          | 826 +++++++++++++++++++++++++++++++++++
 4 files changed, 1153 insertions(+)
 create mode 100644 tools/lkl/lib/net.c

diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
index cdae92300320..1f4291ad9455 100644
--- a/tools/lkl/include/lkl.h
+++ b/tools/lkl/include/lkl.h
@@ -516,6 +516,247 @@ int lkl_dirfd(struct lkl_dir *dir);
  */
 int lkl_mount_fs(char *fstype);
 
+/**
+ * lkl_if_up - activate network interface
+ *
+ * @ifindex - the ifindex of the interface
+ * @returns - return 0 if no error: otherwise negative value returns
+ */
+int lkl_if_up(int ifindex);
+
+/**
+ * lkl_if_down - deactivate network interface
+ *
+ * @ifindex - the ifindex of the interface
+ * @returns - return 0 if no error: otherwise negative value returns
+ */
+int lkl_if_down(int ifindex);
+
+/**
+ * lkl_if_set_mtu - set MTU on interface
+ *
+ * @ifindex - the ifindex of the interface
+ * @mtu - the requested MTU size
+ * @returns - return 0 if no error: otherwise negative value returns
+ */
+int lkl_if_set_mtu(int ifindex, int mtu);
+
+/**
+ * lkl_if_set_ipv4 - set IPv4 address on interface
+ *
+ * @ifindex - the ifindex of the interface
+ * @addr - 4-byte IP address (i.e., struct in_addr)
+ * @netmask_len - prefix length of the @addr
+ * @returns - return 0 if no error: otherwise negative value returns
+ */
+int lkl_if_set_ipv4(int ifindex, unsigned int addr, unsigned int netmask_len);
+
+/**
+ * lkl_set_ipv4_gateway - add an IPv4 default route
+ *
+ * @addr - 4-byte IP address of the gateway (i.e., struct in_addr)
+ * @returns - return 0 if no error: otherwise negative value returns
+ */
+int lkl_set_ipv4_gateway(unsigned int addr);
+
+/**
+ * lkl_if_set_ipv4_gateway - add an IPv4 default route in rule table
+ *
+ * @ifindex - the ifindex of the interface, used for tableid calculation
+ * @addr - 4-byte IP address of the interface
+ * @netmask_len - prefix length of the @addr
+ * @gw_addr - 4-byte IP address of the gateway
+ * @returns - return 0 if no error: otherwise negative value returns
+ */
+int lkl_if_set_ipv4_gateway(int ifindex, unsigned int addr,
+		unsigned int netmask_len, unsigned int gw_addr);
+
+/**
+ * lkl_if_set_ipv6 - set IPv6 address on interface
+ * must be called after interface is up.
+ *
+ * @ifindex - the ifindex of the interface
+ * @addr - 16-byte IPv6 address (i.e., struct in6_addr)
+ * @netprefix_len - prefix length of the @addr
+ * @returns - return 0 if no error: otherwise negative value returns
+ */
+int lkl_if_set_ipv6(int ifindex, void *addr, unsigned int netprefix_len);
+
+/**
+ * lkl_set_ipv6_gateway - add an IPv6 default route
+ *
+ * @addr - 16-byte IPv6 address of the gateway (i.e., struct in6_addr)
+ * @returns - return 0 if no error: otherwise negative value returns
+ */
+int lkl_set_ipv6_gateway(void *addr);
+
+/**
+ * lkl_if_set_ipv6_gateway - add an IPv6 default route in rule table
+ *
+ * @ifindex - the ifindex of the interface, used for tableid calculation
+ * @addr - 16-byte IP address of the interface
+ * @netmask_len - prefix length of the @addr
+ * @gw_addr - 16-byte IP address of the gateway (i.e., struct in_addr)
+ * @returns - return 0 if no error: otherwise negative value returns
+ */
+int lkl_if_set_ipv6_gateway(int ifindex, void *addr,
+		unsigned int netmask_len, void *gw_addr);
+
+/**
+ * lkl_ifname_to_ifindex - obtain ifindex of an interface by name
+ *
+ * @name - string of an interface
+ * @returns - return an integer of ifindex if no error
+ */
+int lkl_ifname_to_ifindex(const char *name);
+
+/**
+ * lkl_netdev_get_ifindex - retrieve the interface index for a given network
+ * device id
+ *
+ * @id - the network device id
+ * @returns the interface index or a stricly negative value in case of error
+ */
+int lkl_netdev_get_ifindex(int id);
+
+/**
+ * lkl_add_neighbor - add a permanent arp entry
+ * @ifindex - the ifindex of the interface
+ * @af - address family of the ip address. Must be LKL_AF_INET or LKL_AF_INET6
+ * @ip - ip address of the entry in network byte order
+ * @mac - mac address of the entry
+ */
+int lkl_add_neighbor(int ifindex, int af, void *addr, void *mac);
+
+/**
+ * lkl_if_add_ip - add an ip address
+ * @ifindex - the ifindex of the interface
+ * @af - address family of the ip address. Must be LKL_AF_INET or LKL_AF_INET6
+ * @addr - ip address of the entry in network byte order
+ * @netprefix_len - prefix length of the @addr
+ */
+int lkl_if_add_ip(int ifindex, int af, void *addr, unsigned int netprefix_len);
+
+/**
+ * lkl_if_del_ip - add an ip address
+ * @ifindex - the ifindex of the interface
+ * @af - address family of the ip address. Must be LKL_AF_INET or LKL_AF_INET6
+ * @addr - ip address of the entry in network byte order
+ * @netprefix_len - prefix length of the @addr
+ */
+int lkl_if_del_ip(int ifindex, int af, void *addr, unsigned int netprefix_len);
+
+/**
+ * lkl_add_gateway - add a gateway
+ * @af - address family of the ip address. Must be LKL_AF_INET or LKL_AF_INET6
+ * @gwaddr - 4-byte IP address of the gateway (i.e., struct in_addr)
+ */
+int lkl_add_gateway(int af, void *gwaddr);
+
+/**
+ * XXX Should I use OIF selector?
+ * temporary table idx = ifindex * 2 + 0 <- ipv4
+ * temporary table idx = ifindex * 2 + 1 <- ipv6
+ */
+/**
+ * lkl_if_add_rule_from_addr - create an ip rule table with "from" selector
+ * @ifindex - the ifindex of the interface, used for table id calculation
+ * @af - address family of the ip address. Must be LKL_AF_INET or LKL_AF_INET6
+ * @saddr - network byte order ip address, "from" selector address of this rule
+ */
+int lkl_if_add_rule_from_saddr(int ifindex, int af, void *saddr);
+
+/**
+ * lkl_if_add_gateway - add gateway to rule table
+ * @ifindex - the ifindex of the interface, used for table id calculation
+ * @af - address family of the ip address. Must be LKL_AF_INET or LKL_AF_INET6
+ * @gwaddr - 4-byte IP address of the gateway (i.e., struct in_addr)
+ */
+int lkl_if_add_gateway(int ifindex, int af, void *gwaddr);
+
+/**
+ * lkl_if_add_linklocal - add linklocal route to rule table
+ * @ifindex - the ifindex of the interface, used for table id calculation
+ * @af - address family of the ip address. Must be LKL_AF_INET or LKL_AF_INET6
+ * @addr - ip address of the entry in network byte order
+ * @netprefix_len - prefix length of the @addr
+ */
+int lkl_if_add_linklocal(int ifindex, int af,  void *addr, int netprefix_len);
+
+/**
+ * lkl_if_wait_ipv6_dad - wait for DAD to be done for a ipv6 address
+ * must be called after interface is up
+ *
+ * @ifindex - the ifindex of the interface
+ * @addr - ip address of the entry in network byte order
+ */
+int lkl_if_wait_ipv6_dad(int ifindex, void *addr);
+
+/**
+ * lkl_set_fd_limit - set the maximum number of file descriptors allowed
+ * @fd_limit - fd max limit
+ */
+int lkl_set_fd_limit(unsigned int fd_limit);
+
+/**
+ * lkl_qdisc_add - set qdisc rule onto an interface
+ *
+ * @ifindex - the ifindex of the interface
+ * @root - the name of root class (e.g., "root");
+ * @type - the type of qdisc (e.g., "fq")
+ */
+int lkl_qdisc_add(int ifindex, const char *root, const char *type);
+
+/**
+ * lkl_qdisc_parse_add - Add a qdisc entry for an interface with strings
+ *
+ * @ifindex - the ifindex of the interface
+ * @entries - strings of qdisc configurations in the form of
+ *            "root|type;root|type;..."
+ */
+void lkl_qdisc_parse_add(int ifindex, const char *entries);
+
+/**
+ * lkl_netdev - host network device handle, defined in lkl_host.h.
+ */
+struct lkl_netdev;
+
+/**
+ * lkl_netdev_args - arguments to lkl_netdev_add
+ * @mac - optional MAC address for the device
+ * @offload - offload bits for the device
+ */
+struct lkl_netdev_args {
+	void *mac;
+	unsigned int offload;
+};
+
+/*
+ * lkl_register_dbg_handler- register a signal handler that loads a debug lib.
+ *
+ * The signal handler is triggered by Ctrl-Z. It creates a new pthread which
+ * call dbg_entrance().
+ *
+ * If you run the program from shell script, make sure you ignore SIGTSTP by
+ * "trap '' TSTP" in the shell script.
+ */
+void lkl_register_dbg_handler(void);
+
+/**
+ * lkl_sysctl - write a sysctl value
+ *
+ * @path - the path to an sysctl entry (e.g., "net.ipv4.tcp_wmem");
+ * @value - the value of the sysctl (e.g., "4096 87380 2147483647")
+ */
+int lkl_sysctl(const char *path, const char *value);
+
+/**
+ * lkl_sysctl_parse_write - Configure sysctl parameters with strings
+ *
+ * @sysctls - Configure sysctl parameters as the form of "key=value;..."
+ */
+void lkl_sysctl_parse_write(const char *sysctls);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
index 85e80eb4ad0d..4e6d6e031498 100644
--- a/tools/lkl/include/lkl_host.h
+++ b/tools/lkl/include/lkl_host.h
@@ -18,6 +18,91 @@ extern struct lkl_host_operations lkl_host_ops;
  */
 int lkl_printf(const char *fmt, ...);
 
+#ifdef LKL_HOST_CONFIG_POSIX
+#include <sys/uio.h>
+#else
+struct iovec {
+	void *iov_base;
+	size_t iov_len;
+};
+#endif
+
+struct lkl_netdev {
+	struct lkl_dev_net_ops *ops;
+	int id;
+	uint8_t has_vnet_hdr: 1;
+};
+
+/**
+ * struct lkl_dev_net_ops - network device host operations
+ */
+struct lkl_dev_net_ops {
+	/**
+	 * @tx: writes a L2 packet into the net device
+	 *
+	 * The data buffer can only hold 0 or 1 complete packets.
+	 *
+	 * @nd - pointer to the network device;
+	 * @iov - pointer to the buffer vector;
+	 * @cnt - # of vectors in iov.
+	 *
+	 * @returns number of bytes transmitted
+	 */
+	int (*tx)(struct lkl_netdev *nd, struct iovec *iov, int cnt);
+
+	/**
+	 * @rx: reads a packet from the net device.
+	 *
+	 * It must only read one complete packet if present.
+	 *
+	 * If the buffer is too small for the packet, the implementation may
+	 * decide to drop it or trim it.
+	 *
+	 * @nd - pointer to the network device
+	 * @iov - pointer to the buffer vector to store the packet
+	 * @cnt - # of vectors in iov.
+	 *
+	 * @returns number of bytes read for success or < 0 if error
+	 */
+	int (*rx)(struct lkl_netdev *nd, struct iovec *iov, int cnt);
+
+#define LKL_DEV_NET_POLL_RX		1
+#define LKL_DEV_NET_POLL_TX		2
+#define LKL_DEV_NET_POLL_HUP		4
+
+	/**
+	 * @poll: polls a net device
+	 *
+	 * Supports the following events: LKL_DEV_NET_POLL_RX
+	 * (readable), LKL_DEV_NET_POLL_TX (writable) or
+	 * LKL_DEV_NET_POLL_HUP (the close operations has been issued
+	 * and we need to clean up). Blocks until one event is
+	 * available.
+	 *
+	 * @nd - pointer to the network device
+	 *
+	 * @returns - LKL_DEV_NET_POLL_RX, LKL_DEV_NET_POLL_TX,
+	 * LKL_DEV_NET_POLL_HUP or a negative value for errors
+	 */
+	int (*poll)(struct lkl_netdev *nd);
+
+	/**
+	 * @poll_hup: make poll wakeup and return LKL_DEV_NET_POLL_HUP
+	 *
+	 * @nd - pointer to the network device
+	 */
+	void (*poll_hup)(struct lkl_netdev *nd);
+
+	/**
+	 * @free: frees a network device
+	 *
+	 * Implementation must release its resources and free the network device
+	 * structure.
+	 *
+	 * @nd - pointer to the network device
+	 */
+	void (*free)(struct lkl_netdev *nd);
+};
 
 #ifdef __cplusplus
 }
diff --git a/tools/lkl/lib/Build b/tools/lkl/lib/Build
index 4a444337b0e7..dba530424e4a 100644
--- a/tools/lkl/lib/Build
+++ b/tools/lkl/lib/Build
@@ -1,6 +1,7 @@
 CFLAGS_config.o += -I$(srctree)/tools/perf/pmu-events
 
 liblkl-y += fs.o
+liblkl-y += net.o
 liblkl-y += jmp_buf.o
 liblkl-y += utils.o
 liblkl-y += dbg.o
diff --git a/tools/lkl/lib/net.c b/tools/lkl/lib/net.c
new file mode 100644
index 000000000000..cf6894c35e46
--- /dev/null
+++ b/tools/lkl/lib/net.c
@@ -0,0 +1,826 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <stdio.h>
+#include "endian.h"
+#include <lkl_host.h>
+
+#ifdef __MINGW32__
+#include <ws2tcpip.h>
+
+int lkl_inet_pton(int af, const char *src, void *dst)
+{
+	struct addrinfo hint, *res = NULL;
+	int err;
+
+	memset(&hint, 0, sizeof(struct addrinfo));
+
+	hint.ai_family = af;
+	hint.ai_flags = AI_NUMERICHOST;
+
+	err = getaddrinfo(src, NULL, &hint, &res);
+	if (err)
+		return 0;
+
+	switch (af) {
+	case AF_INET:
+		*(struct in_addr *)dst =
+			((struct sockaddr_in *)&res->ai_addr)->sin_addr;
+		break;
+	case AF_INET6:
+		*(struct in6_addr *)dst =
+			((struct sockaddr_in6 *)&res->ai_addr)->sin6_addr;
+		break;
+	default:
+		freeaddrinfo(res);
+		return 0;
+	}
+
+	freeaddrinfo(res);
+	return 1;
+}
+#endif
+
+static inline void set_sockaddr(struct lkl_sockaddr_in *sin, unsigned int addr,
+				unsigned short port)
+{
+	sin->sin_family = LKL_AF_INET;
+	sin->sin_addr.lkl_s_addr = addr;
+	sin->sin_port = port;
+}
+
+static inline int ifindex_to_name(int sock, struct lkl_ifreq *ifr, int ifindex)
+{
+	ifr->lkl_ifr_ifindex = ifindex;
+	return lkl_sys_ioctl(sock, LKL_SIOCGIFNAME, (long)ifr);
+}
+
+int lkl_ifname_to_ifindex(const char *name)
+{
+	struct lkl_ifreq ifr;
+	int fd, ret;
+
+	fd = lkl_sys_socket(LKL_AF_INET, LKL_SOCK_DGRAM, 0);
+	if (fd < 0)
+		return fd;
+
+	if (strlen(name) >= LKL_IFNAMSIZ)
+		return -LKL_ENAMETOOLONG;
+
+	strcpy(ifr.lkl_ifr_name, name);
+
+	ret = lkl_sys_ioctl(fd, LKL_SIOCGIFINDEX, (long)&ifr);
+	if (ret < 0)
+		return ret;
+
+	return ifr.lkl_ifr_ifindex;
+}
+
+int lkl_if_up(int ifindex)
+{
+	struct lkl_ifreq ifr;
+	int err, sock = lkl_sys_socket(LKL_AF_INET, LKL_SOCK_DGRAM, 0);
+
+	if (sock < 0)
+		return sock;
+	err = ifindex_to_name(sock, &ifr, ifindex);
+	if (err < 0)
+		return err;
+
+	err = lkl_sys_ioctl(sock, LKL_SIOCGIFFLAGS, (long)&ifr);
+	if (!err) {
+		ifr.lkl_ifr_flags |= LKL_IFF_UP;
+		err = lkl_sys_ioctl(sock, LKL_SIOCSIFFLAGS, (long)&ifr);
+	}
+
+	lkl_sys_close(sock);
+
+	return err;
+}
+
+int lkl_if_down(int ifindex)
+{
+	struct lkl_ifreq ifr;
+	int err, sock;
+
+	sock = lkl_sys_socket(LKL_AF_INET, LKL_SOCK_DGRAM, 0);
+	if (sock < 0)
+		return sock;
+
+	err = ifindex_to_name(sock, &ifr, ifindex);
+	if (err < 0)
+		return err;
+
+	err = lkl_sys_ioctl(sock, LKL_SIOCGIFFLAGS, (long)&ifr);
+	if (!err) {
+		ifr.lkl_ifr_flags &= ~LKL_IFF_UP;
+		err = lkl_sys_ioctl(sock, LKL_SIOCSIFFLAGS, (long)&ifr);
+	}
+
+	lkl_sys_close(sock);
+
+	return err;
+}
+
+int lkl_if_set_mtu(int ifindex, int mtu)
+{
+	struct lkl_ifreq ifr;
+	int err, sock;
+
+	sock = lkl_sys_socket(LKL_AF_INET, LKL_SOCK_DGRAM, 0);
+	if (sock < 0)
+		return sock;
+
+	err = ifindex_to_name(sock, &ifr, ifindex);
+	if (err < 0)
+		return err;
+
+	ifr.lkl_ifr_mtu = mtu;
+
+	err = lkl_sys_ioctl(sock, LKL_SIOCSIFMTU, (long)&ifr);
+
+	lkl_sys_close(sock);
+
+	return err;
+}
+
+int lkl_if_set_ipv4(int ifindex, unsigned int addr, unsigned int netmask_len)
+{
+	return lkl_if_add_ip(ifindex, LKL_AF_INET, &addr, netmask_len);
+}
+
+int lkl_if_set_ipv4_gateway(int ifindex, unsigned int src_addr,
+		unsigned int src_masklen, unsigned int via_addr)
+{
+	int err;
+
+	err = lkl_if_add_rule_from_saddr(ifindex, LKL_AF_INET, &src_addr);
+	if (err)
+		return err;
+	err = lkl_if_add_linklocal(ifindex, LKL_AF_INET,
+					&src_addr, src_masklen);
+	if (err)
+		return err;
+	return lkl_if_add_gateway(ifindex, LKL_AF_INET, &via_addr);
+}
+
+int lkl_set_ipv4_gateway(unsigned int addr)
+{
+	return lkl_add_gateway(LKL_AF_INET, &addr);
+}
+
+int lkl_netdev_get_ifindex(int id)
+{
+	struct lkl_ifreq ifr;
+	int sock, ret;
+
+	sock = lkl_sys_socket(LKL_AF_INET, LKL_SOCK_DGRAM, 0);
+	if (sock < 0)
+		return sock;
+
+	snprintf(ifr.lkl_ifr_name, sizeof(ifr.lkl_ifr_name), "eth%d", id);
+	ret = lkl_sys_ioctl(sock, LKL_SIOCGIFINDEX, (long)&ifr);
+	lkl_sys_close(sock);
+
+	return ret < 0 ? ret : ifr.lkl_ifr_ifindex;
+}
+
+static int netlink_sock(unsigned int groups)
+{
+	struct lkl_sockaddr_nl la;
+	int fd, err;
+
+	fd = lkl_sys_socket(LKL_AF_NETLINK, LKL_SOCK_DGRAM, LKL_NETLINK_ROUTE);
+	if (fd < 0)
+		return fd;
+
+	memset(&la, 0, sizeof(la));
+	la.nl_family = LKL_AF_NETLINK;
+	la.nl_groups = groups;
+	err = lkl_sys_bind(fd, (struct lkl_sockaddr *)&la, sizeof(la));
+	if (err < 0)
+		return err;
+
+	return fd;
+}
+
+static int parse_rtattr(struct lkl_rtattr *tb[], int max,
+			struct lkl_rtattr *rta, int len)
+{
+	unsigned short type;
+
+	memset(tb, 0, sizeof(struct lkl_rtattr *) * (max + 1));
+	while (LKL_RTA_OK(rta, len)) {
+		type = rta->rta_type;
+		if ((type <= max) && (!tb[type]))
+			tb[type] = rta;
+		rta = LKL_RTA_NEXT(rta, len);
+	}
+	if (len)
+		lkl_printf("!!!Deficit %d, rta_len=%d\n", len,
+			rta->rta_len);
+	return 0;
+}
+
+struct addr_filter {
+	unsigned int ifindex;
+	void *addr;
+};
+
+static unsigned int get_ifa_flags(struct lkl_ifaddrmsg *ifa,
+				  struct lkl_rtattr *ifa_flags_attr)
+{
+	return ifa_flags_attr ? *(unsigned int *)LKL_RTA_DATA(ifa_flags_attr) :
+				ifa->ifa_flags;
+}
+
+/* returns:
+ * 0 - dad succeed.
+ * -1 - dad failed or other error.
+ * 1 - should wait for new msg.
+ */
+static int check_ipv6_dad(struct lkl_sockaddr_nl *nladdr,
+			  struct lkl_nlmsghdr *n, void *arg)
+{
+	struct addr_filter *filter = arg;
+	struct lkl_ifaddrmsg *ifa = LKL_NLMSG_DATA(n);
+	struct lkl_rtattr *rta_tb[LKL_IFA_MAX+1];
+	unsigned int ifa_flags;
+	int len = n->nlmsg_len;
+
+	if (n->nlmsg_type != LKL_RTM_NEWADDR)
+		return 1;
+
+	len -= LKL_NLMSG_LENGTH(sizeof(*ifa));
+	if (len < 0) {
+		lkl_printf("BUG: wrong nlmsg len %d\n", len);
+		return -1;
+	}
+
+	parse_rtattr(rta_tb, LKL_IFA_MAX, LKL_IFA_RTA(ifa),
+		     n->nlmsg_len - LKL_NLMSG_LENGTH(sizeof(*ifa)));
+
+	ifa_flags = get_ifa_flags(ifa, rta_tb[LKL_IFA_FLAGS]);
+
+	if (ifa->ifa_index != filter->ifindex)
+		return 1;
+	if (ifa->ifa_family != LKL_AF_INET6)
+		return 1;
+
+	if (!rta_tb[LKL_IFA_LOCAL])
+		rta_tb[LKL_IFA_LOCAL] = rta_tb[LKL_IFA_ADDRESS];
+
+	if (!rta_tb[LKL_IFA_LOCAL] ||
+	    (filter->addr && memcmp(LKL_RTA_DATA(rta_tb[LKL_IFA_LOCAL]),
+				    filter->addr, 16))) {
+		return 1;
+	}
+	if (ifa_flags & LKL_IFA_F_DADFAILED) {
+		lkl_printf("IPV6 DAD failed.\n");
+		return -1;
+	}
+	if (!(ifa_flags & LKL_IFA_F_TENTATIVE))
+		return 0;
+	return 1;
+}
+
+/* Copied from iproute2/lib/ */
+static int rtnl_listen(int fd, int (*handler)(struct lkl_sockaddr_nl *nladdr,
+					      struct lkl_nlmsghdr *, void *),
+		       void *arg)
+{
+	int status;
+	struct lkl_nlmsghdr *h;
+	struct lkl_sockaddr_nl nladdr = { .nl_family = LKL_AF_NETLINK };
+	struct lkl_iovec iov;
+	struct lkl_user_msghdr msg = {
+		.msg_name = &nladdr,
+		.msg_namelen = sizeof(nladdr),
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	char   buf[16384];
+
+	iov.iov_base = buf;
+	while (1) {
+		iov.iov_len = sizeof(buf);
+		status = lkl_sys_recvmsg(fd, &msg, 0);
+
+		if (status < 0) {
+			if (status == -LKL_EINTR || status == -LKL_EAGAIN)
+				continue;
+			lkl_printf("netlink receive error %s (%d)\n",
+				lkl_strerror(status), status);
+			if (status == -LKL_ENOBUFS)
+				continue;
+			return status;
+		}
+		if (status == 0) {
+			lkl_printf("EOF on netlink\n");
+			return -1;
+		}
+		if (msg.msg_namelen != sizeof(nladdr)) {
+			lkl_printf("Sender address length == %d\n",
+				msg.msg_namelen);
+			return -1;
+		}
+
+		for (h = (struct lkl_nlmsghdr *)buf;
+		     (unsigned int)status >= sizeof(*h);) {
+			int err;
+			int len = h->nlmsg_len;
+			int l = len - sizeof(*h);
+
+			if (l < 0 || len > status) {
+				if (msg.msg_flags & LKL_MSG_TRUNC) {
+					lkl_printf("Truncated message\n");
+					return -1;
+				}
+				lkl_printf("!!!malformed message: len=%d\n",
+					len);
+				return -1;
+			}
+
+			err = handler(&nladdr, h, arg);
+			if (err <= 0)
+				return err;
+
+			status -= LKL_NLMSG_ALIGN(len);
+			h = (struct lkl_nlmsghdr *)((char *)h +
+						    LKL_NLMSG_ALIGN(len));
+		}
+		if (msg.msg_flags & LKL_MSG_TRUNC) {
+			lkl_printf("Message truncated\n");
+			continue;
+		}
+		if (status) {
+			lkl_printf("!!!Remnant of size %d\n", status);
+			return -1;
+		}
+	}
+}
+
+int lkl_if_wait_ipv6_dad(int ifindex, void *addr)
+{
+	struct addr_filter filter = {.ifindex = ifindex, .addr = addr};
+	int fd, ret;
+	struct {
+		struct lkl_nlmsghdr		nlmsg_info;
+		struct lkl_ifaddrmsg	ifaddrmsg_info;
+	} req;
+
+	fd = netlink_sock(1 << (LKL_RTNLGRP_IPV6_IFADDR - 1));
+	if (fd < 0)
+		return fd;
+
+	memset(&req, 0, sizeof(req));
+	req.nlmsg_info.nlmsg_len =
+			LKL_NLMSG_LENGTH(sizeof(struct lkl_ifaddrmsg));
+	req.nlmsg_info.nlmsg_flags = LKL_NLM_F_REQUEST | LKL_NLM_F_DUMP;
+	req.nlmsg_info.nlmsg_type = LKL_RTM_GETADDR;
+	req.ifaddrmsg_info.ifa_family = LKL_AF_INET6;
+	req.ifaddrmsg_info.ifa_index = ifindex;
+	ret = lkl_sys_send(fd, &req, req.nlmsg_info.nlmsg_len, 0);
+	if (ret < 0) {
+		lkl_perror("lkl_sys_send", ret);
+		return ret;
+	}
+	ret = rtnl_listen(fd, check_ipv6_dad, (void *)&filter);
+	lkl_sys_close(fd);
+	return ret;
+}
+
+int lkl_if_set_ipv6(int ifindex, void *addr, unsigned int netprefix_len)
+{
+	int err = lkl_if_add_ip(ifindex, LKL_AF_INET6, addr, netprefix_len);
+
+	if (err)
+		return err;
+	return lkl_if_wait_ipv6_dad(ifindex, addr);
+}
+
+int lkl_if_set_ipv6_gateway(int ifindex, void *src_addr,
+		unsigned int src_masklen, void *via_addr)
+{
+	int err;
+
+	err = lkl_if_add_rule_from_saddr(ifindex, LKL_AF_INET6, src_addr);
+	if (err)
+		return err;
+	err = lkl_if_add_linklocal(ifindex, LKL_AF_INET6,
+					src_addr, src_masklen);
+	if (err)
+		return err;
+	return lkl_if_add_gateway(ifindex, LKL_AF_INET6, via_addr);
+}
+
+int lkl_set_ipv6_gateway(void *addr)
+{
+	return lkl_add_gateway(LKL_AF_INET6, addr);
+}
+
+/* returns:
+ * 0 - succeed.
+ * < 0 - error number.
+ * 1 - should wait for new msg.
+ */
+static int check_error(struct lkl_sockaddr_nl *nladdr, struct lkl_nlmsghdr *n,
+		       void *arg)
+{
+	unsigned int s = *(unsigned int *)arg;
+
+	if (nladdr->nl_pid != 0 || n->nlmsg_seq != s) {
+		/* Don't forget to skip that message. */
+		return 1;
+	}
+
+	if (n->nlmsg_type == LKL_NLMSG_ERROR) {
+		struct lkl_nlmsgerr *err =
+			(struct lkl_nlmsgerr *)LKL_NLMSG_DATA(n);
+		int l = n->nlmsg_len - sizeof(*n);
+
+		if (l < (int)sizeof(struct lkl_nlmsgerr))
+			lkl_printf("ERROR truncated\n");
+		else if (!err->error)
+			return 0;
+
+		lkl_printf("RTNETLINK answers: %s\n",
+			lkl_strerror(-err->error));
+		return err->error;
+	}
+	lkl_printf("Unexpected reply!!!\n");
+	return -1;
+}
+
+static unsigned int seq;
+static int rtnl_talk(int fd, struct lkl_nlmsghdr *n)
+{
+	int status;
+	struct lkl_sockaddr_nl nladdr = {.nl_family = LKL_AF_NETLINK};
+	struct lkl_iovec iov = {.iov_base = (void *)n, .iov_len = n->nlmsg_len};
+	struct lkl_user_msghdr msg = {
+			.msg_name = &nladdr,
+			.msg_namelen = sizeof(nladdr),
+			.msg_iov = &iov,
+			.msg_iovlen = 1,
+	};
+
+	n->nlmsg_seq = seq;
+	n->nlmsg_flags |= LKL_NLM_F_ACK;
+
+	status = lkl_sys_sendmsg(fd, &msg, 0);
+	if (status < 0) {
+		lkl_perror("Cannot talk to rtnetlink", status);
+		return status;
+	}
+
+	status = rtnl_listen(fd, check_error, (void *)&seq);
+	seq++;
+	return status;
+}
+
+static int addattr_l(struct lkl_nlmsghdr *n, unsigned int maxlen,
+		     int type, const void *data, int alen)
+{
+	int len = LKL_RTA_LENGTH(alen);
+	struct lkl_rtattr *rta;
+
+	if (LKL_NLMSG_ALIGN(n->nlmsg_len) + LKL_RTA_ALIGN(len) > maxlen) {
+		lkl_printf("%s ERROR: message exceeded bound of %d\n", __func__,
+			   maxlen);
+		return -1;
+	}
+	rta = ((struct lkl_rtattr *) (((void *) (n)) +
+				      LKL_NLMSG_ALIGN(n->nlmsg_len)));
+	rta->rta_type = type;
+	rta->rta_len = len;
+	memcpy(LKL_RTA_DATA(rta), data, alen);
+	n->nlmsg_len = LKL_NLMSG_ALIGN(n->nlmsg_len) + LKL_RTA_ALIGN(len);
+	return 0;
+}
+
+int lkl_add_neighbor(int ifindex, int af, void *ip, void *mac)
+{
+	struct {
+		struct lkl_nlmsghdr n;
+		struct lkl_ndmsg r;
+		char buf[1024];
+	} req = {
+		.n.nlmsg_len = LKL_NLMSG_LENGTH(sizeof(struct lkl_ndmsg)),
+		.n.nlmsg_type = LKL_RTM_NEWNEIGH,
+		.n.nlmsg_flags = LKL_NLM_F_REQUEST |
+				 LKL_NLM_F_CREATE | LKL_NLM_F_REPLACE,
+		.r.ndm_family = af,
+		.r.ndm_ifindex = ifindex,
+		.r.ndm_state = LKL_NUD_PERMANENT,
+
+	};
+	int err, addr_sz;
+	int fd;
+
+	if (af == LKL_AF_INET)
+		addr_sz = 4;
+	else if (af == LKL_AF_INET6)
+		addr_sz = 16;
+	else {
+		lkl_printf("Bad address family: %d\n", af);
+		return -1;
+	}
+
+	fd = netlink_sock(0);
+	if (fd < 0)
+		return fd;
+
+	// create the IP attribute
+	addattr_l(&req.n, sizeof(req), LKL_NDA_DST, ip, addr_sz);
+
+	// create the MAC attribute
+	addattr_l(&req.n, sizeof(req), LKL_NDA_LLADDR, mac, 6);
+
+	err = rtnl_talk(fd, &req.n);
+	lkl_sys_close(fd);
+	return err;
+}
+
+static int ipaddr_modify(int cmd, int flags, int ifindex, int af, void *addr,
+			 unsigned int netprefix_len)
+{
+	struct {
+		struct lkl_nlmsghdr n;
+		struct lkl_ifaddrmsg ifa;
+		char buf[256];
+	} req = {
+		.n.nlmsg_len = LKL_NLMSG_LENGTH(sizeof(struct lkl_ifaddrmsg)),
+		.n.nlmsg_flags = LKL_NLM_F_REQUEST | flags,
+		.n.nlmsg_type = cmd,
+		.ifa.ifa_family = af,
+		.ifa.ifa_prefixlen = netprefix_len,
+		.ifa.ifa_index = ifindex,
+	};
+	int err, addr_sz;
+	int fd;
+
+	if (af == LKL_AF_INET)
+		addr_sz = 4;
+	else if (af == LKL_AF_INET6)
+		addr_sz = 16;
+	else {
+		lkl_printf("Bad address family: %d\n", af);
+		return -1;
+	}
+
+	fd = netlink_sock(0);
+	if (fd < 0)
+		return fd;
+
+	// create the IP attribute
+	addattr_l(&req.n, sizeof(req), LKL_IFA_LOCAL, addr, addr_sz);
+
+	err = rtnl_talk(fd, &req.n);
+
+	lkl_sys_close(fd);
+	return err;
+}
+
+int lkl_if_add_ip(int ifindex, int af, void *addr, unsigned int netprefix_len)
+{
+	return ipaddr_modify(LKL_RTM_NEWADDR, LKL_NLM_F_CREATE | LKL_NLM_F_EXCL,
+			     ifindex, af, addr, netprefix_len);
+}
+
+int lkl_if_del_ip(int ifindex, int af, void *addr, unsigned int netprefix_len)
+{
+	return ipaddr_modify(LKL_RTM_DELADDR, 0, ifindex, af,
+			     addr, netprefix_len);
+}
+
+static int iproute_modify(int cmd, unsigned int flags, int ifindex, int af,
+		void *route_addr, int route_masklen, void *gwaddr)
+{
+	struct {
+		struct lkl_nlmsghdr	n;
+		struct lkl_rtmsg	r;
+		char			buf[1024];
+	} req = {
+		.n.nlmsg_len = LKL_NLMSG_LENGTH(sizeof(struct lkl_rtmsg)),
+		.n.nlmsg_flags = LKL_NLM_F_REQUEST | flags,
+		.n.nlmsg_type = cmd,
+		.r.rtm_family = af,
+		.r.rtm_table = LKL_RT_TABLE_MAIN,
+		.r.rtm_scope = LKL_RT_SCOPE_UNIVERSE,
+	};
+	int err, addr_sz;
+	int i, fd;
+
+	fd = netlink_sock(0);
+	if (fd < 0) {
+		lkl_printf("netlink_sock error: %d\n", fd);
+		return fd;
+	}
+
+	if (af == LKL_AF_INET)
+		addr_sz = 4;
+	else if (af == LKL_AF_INET6)
+		addr_sz = 16;
+	else {
+		lkl_printf("Bad address family: %d\n", af);
+		return -1;
+	}
+
+	if (cmd != LKL_RTM_DELROUTE) {
+		req.r.rtm_protocol = LKL_RTPROT_BOOT;
+		req.r.rtm_scope = LKL_RT_SCOPE_UNIVERSE;
+		req.r.rtm_type = LKL_RTN_UNICAST;
+	}
+
+	if (gwaddr)
+		addattr_l(&req.n, sizeof(req),
+				LKL_RTA_GATEWAY, gwaddr, addr_sz);
+
+	if (af == LKL_AF_INET && route_addr) {
+		unsigned int netaddr = *(unsigned int *)route_addr;
+
+		netaddr = ntohl(netaddr);
+		netaddr = (netaddr >> (32 - route_masklen));
+		netaddr = (netaddr << (32 - route_masklen));
+		netaddr =  htonl(netaddr);
+		*(unsigned int *)route_addr = netaddr;
+		req.r.rtm_dst_len = route_masklen;
+		addattr_l(&req.n, sizeof(req), LKL_RTA_DST,
+					route_addr, addr_sz);
+	}
+
+	if (af == LKL_AF_INET6 && route_addr) {
+		struct lkl_in6_addr netaddr =
+			*(struct lkl_in6_addr *)route_addr;
+		int rmbyte = route_masklen/8;
+		int rmbit = route_masklen%8;
+
+		for (i = 0; i < rmbyte; i++)
+			netaddr.in6_u.u6_addr8[15-i] = 0;
+		netaddr.in6_u.u6_addr8[15-rmbyte] =
+			(netaddr.in6_u.u6_addr8[15-rmbyte] >> rmbit);
+		netaddr.in6_u.u6_addr8[15-rmbyte] =
+			(netaddr.in6_u.u6_addr8[15-rmbyte] << rmbit);
+		*(struct lkl_in6_addr *)route_addr = netaddr;
+		req.r.rtm_dst_len = route_masklen;
+		addattr_l(&req.n, sizeof(req), LKL_RTA_DST,
+					route_addr, addr_sz);
+	}
+
+	if (ifindex != LKL_RT_TABLE_MAIN) {
+		if (af == LKL_AF_INET)
+			req.r.rtm_table = ifindex * 2;
+		else if (af == LKL_AF_INET6)
+			req.r.rtm_table = ifindex * 2 + 1;
+		addattr_l(&req.n, sizeof(req), LKL_RTA_OIF, &ifindex, addr_sz);
+	}
+	err = rtnl_talk(fd, &req.n);
+	lkl_sys_close(fd);
+	return err;
+}
+
+int lkl_if_add_linklocal(int ifindex, int af,  void *addr, int netprefix_len)
+{
+	return iproute_modify(LKL_RTM_NEWROUTE, LKL_NLM_F_CREATE|LKL_NLM_F_EXCL,
+			ifindex, af, addr, netprefix_len, NULL);
+}
+
+int lkl_if_add_gateway(int ifindex, int af, void *gwaddr)
+{
+	return iproute_modify(LKL_RTM_NEWROUTE, LKL_NLM_F_CREATE|LKL_NLM_F_EXCL,
+			ifindex, af, NULL, 0, gwaddr);
+}
+
+int lkl_add_gateway(int af, void *gwaddr)
+{
+	return iproute_modify(LKL_RTM_NEWROUTE, LKL_NLM_F_CREATE|LKL_NLM_F_EXCL,
+			LKL_RT_TABLE_MAIN, af, NULL, 0, gwaddr);
+}
+
+static int iprule_modify(int cmd, int ifindex, int af, void *saddr)
+{
+	struct {
+		struct lkl_nlmsghdr	n;
+		struct lkl_rtmsg		r;
+		char			buf[1024];
+	} req = {
+		.n.nlmsg_type = cmd,
+		.n.nlmsg_len = LKL_NLMSG_LENGTH(sizeof(struct lkl_rtmsg)),
+		.n.nlmsg_flags = LKL_NLM_F_REQUEST,
+		.r.rtm_protocol = LKL_RTPROT_BOOT,
+		.r.rtm_scope = LKL_RT_SCOPE_UNIVERSE,
+		.r.rtm_family = af,
+		.r.rtm_type = LKL_RTN_UNSPEC,
+	};
+	int fd, err;
+	int addr_sz;
+
+	if (af == LKL_AF_INET)
+		addr_sz = 4;
+	else if (af == LKL_AF_INET6)
+		addr_sz = 16;
+	else {
+		lkl_printf("Bad address family: %d\n", af);
+		return -1;
+	}
+
+	fd = netlink_sock(0);
+	if (fd < 0)
+		return fd;
+
+	if (cmd == LKL_RTM_NEWRULE) {
+		req.n.nlmsg_flags |= LKL_NLM_F_CREATE|LKL_NLM_F_EXCL;
+		req.r.rtm_type = LKL_RTN_UNICAST;
+	}
+
+	//set from address
+	req.r.rtm_src_len = 8 * addr_sz;
+	addattr_l(&req.n, sizeof(req), LKL_FRA_SRC, saddr, addr_sz);
+
+	//use ifindex as table id
+	if (af == LKL_AF_INET)
+		req.r.rtm_table = ifindex * 2;
+	else if (af == LKL_AF_INET6)
+		req.r.rtm_table = ifindex * 2 + 1;
+	err = rtnl_talk(fd, &req.n);
+
+	lkl_sys_close(fd);
+	return err;
+}
+
+int lkl_if_add_rule_from_saddr(int ifindex, int af, void *saddr)
+{
+	return iprule_modify(LKL_RTM_NEWRULE, ifindex, af, saddr);
+}
+
+static int qdisc_add(int cmd, int flags, int ifindex,
+		     const char *root, const char *type)
+{
+	struct {
+		struct lkl_nlmsghdr n;
+		struct lkl_tcmsg tc;
+		char buf[2*1024];
+	} req = {
+		.n.nlmsg_len = LKL_NLMSG_LENGTH(sizeof(struct lkl_tcmsg)),
+		.n.nlmsg_flags = LKL_NLM_F_REQUEST|flags,
+		.n.nlmsg_type = cmd,
+		.tc.tcm_family = LKL_AF_UNSPEC,
+	};
+	int err, fd;
+
+	if (!root || !type) {
+		lkl_printf("root and type arguments\n");
+		return -1;
+	}
+
+	if (strcmp(root, "root") == 0)
+		req.tc.tcm_parent = LKL_TC_H_ROOT;
+	req.tc.tcm_ifindex = ifindex;
+
+	fd = netlink_sock(0);
+	if (fd < 0)
+		return fd;
+
+	// create the qdisc attribute
+	addattr_l(&req.n, sizeof(req), LKL_TCA_KIND, type, strlen(type)+1);
+
+	err = rtnl_talk(fd, &req.n);
+	lkl_sys_close(fd);
+	return err;
+}
+
+int lkl_qdisc_add(int ifindex, const char *root, const char *type)
+{
+	return qdisc_add(LKL_RTM_NEWQDISC, LKL_NLM_F_CREATE | LKL_NLM_F_EXCL,
+			 ifindex, root, type);
+}
+
+/* Add a qdisc entry for an interface in the form of
+ * "root|type;root|type;..."
+ */
+void lkl_qdisc_parse_add(int ifindex, const char *entries)
+{
+	char *saveptr = NULL, *token = NULL;
+	char *root = NULL, *type = NULL;
+	char strings[256];
+	int ret = 0;
+
+	if (strlen(entries) >= sizeof(strings)) {
+		lkl_printf("Error: long strings of input: %s\n", entries);
+		return;
+	}
+
+	strcpy(strings, entries);
+
+	for (token = strtok_r(strings, ";", &saveptr); token;
+	     token = strtok_r(NULL, ";", &saveptr)) {
+		root = strtok(token, "|");
+		type = strtok(NULL, "|");
+		ret = lkl_qdisc_add(ifindex, root, type);
+		if (ret) {
+			lkl_printf("Failed to add qdisc entry: %s\n",
+				   lkl_strerror(ret));
+			return;
+		}
+	}
+}
-- 
2.21.0 (Apple Git-122.2)

