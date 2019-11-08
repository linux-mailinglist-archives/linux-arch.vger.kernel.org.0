Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43BCF3F4B
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfKHFEL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41601 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfKHFEL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so3233276plj.8
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/iDyrsv0k+H/H5o51UwrcgEarJN2mtUQtDYJqgcKFKI=;
        b=YC7SBV3B9Y7WqpQ+XQknuSQDmUbpnJgZ9p2DVRFIax/N5yg0AHcBPxSUFel8VjvVuO
         F/r+0IA98BdDb23FDM6jL1c+o6mMwGrODWaejUbCB+JZgmtwbW6IE+UALPo2leRlSbQY
         IBQZJHwv0KIGGBRWxmqQJCy1tAzLXm99584nPjoCCO+y/MdSQ99ytQ9BJqaSHeMmIU8l
         SdnwY68lXrP7ldT5Ewv14dt2qsRVPmEdCYIgH6V14Mo+zY/vlUOy1yLp3k/uUGpgzKHF
         W2hTgR0ovuESIqG2z9IrVziz4kfzDcny9V2tbgQdsc4Ds4RpSqP9UEjX7zQDSN9MVl4r
         Lf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/iDyrsv0k+H/H5o51UwrcgEarJN2mtUQtDYJqgcKFKI=;
        b=RAzcYUyp3HFRpB2T8CWrKF9oYjyM9OgKld95Nt1BgeQlImHnce+luxslwno3/emRez
         BVsIW7y5gAKs3B/yDqCxpPKzUv31O0jtSnQJgcM0Gb7H8tNRommcuLHu0XuDK//M/+yu
         53LNyzwcfUYv8AHPxC3XR9fRCQqjN4gU00ffdvuYBNe02yW4M+OxCaWMM5NXP9mcsH76
         ViR5Um2JSE4OgI4jWTR0A7ORs8ntdznW/1OrJqYIlvTAHS+hHJgvhHU+b5NFoHTd+l0P
         SsdRcJPinLFmOAkIyeaqceG3fIjwMtxN6Qoqw+GkgMeKmlZRnbsyw+3HfG1o7d7EYyWa
         yNxw==
X-Gm-Message-State: APjAAAVX910bjG0ws4EZOjdWdmFJY0Qq7p7Z1RN3dkBqXuVRj7btqG1m
        kh/eCdmheFBEOVqJlKVkBKY=
X-Google-Smtp-Source: APXvYqy2/uTaktmQcq2d/EgNnEIex3XQd/ctlmPVqrfXwI4v9pj97qFyD9gJliVlRgm2ZV74LtEhCg==
X-Received: by 2002:a17:90a:f84:: with SMTP id 4mr10467490pjz.110.1573189446923;
        Thu, 07 Nov 2019 21:04:06 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id b128sm172683pfg.65.2019.11.07.21.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:04 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 9D884201ACFE1E; Fri,  8 Nov 2019 14:04:02 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        David Disseldorp <ddiss@suse.de>,
        Hajime Tazaki <thehajime@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Thomas Liebetraut <thomas@tommie-lie.de>,
        Xiao Jia <xiaoj@google.com>, Yuan Liu <liuyuan@google.com>
Subject: [RFC v2 24/37] lkl tools: virtio: add network device support
Date:   Fri,  8 Nov 2019 14:02:39 +0900
Message-Id: <7cf3afe9885721055e4b60d47d2c404fe97a901d.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

This commit adds basic virtio_net device implementation support to be
utilized by virtio-net driver over LKL. It also adds various virtio_net
backend to be used as network devices.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Motomu Utsumi <motomuman@gmail.com>
Signed-off-by: Patrick Collins <pscollins@google.com>
Signed-off-by: Thomas Liebetraut <thomas@tommie-lie.de>
Signed-off-by: Xiao Jia <xiaoj@google.com>
Signed-off-by: Yuan Liu <liuyuan@google.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/include/lkl.h            | 392 ++++++++++++++
 tools/lkl/include/lkl_host.h       |  76 +++
 tools/lkl/lib/Build                |  10 +
 tools/lkl/lib/net.c                | 818 +++++++++++++++++++++++++++++
 tools/lkl/lib/virtio_net.c         | 322 ++++++++++++
 tools/lkl/lib/virtio_net_dpdk.c    | 480 +++++++++++++++++
 tools/lkl/lib/virtio_net_fd.c      | 217 ++++++++
 tools/lkl/lib/virtio_net_fd.h      |  28 +
 tools/lkl/lib/virtio_net_macvtap.c |  32 ++
 tools/lkl/lib/virtio_net_pipe.c    |  76 +++
 tools/lkl/lib/virtio_net_raw.c     |  94 ++++
 tools/lkl/lib/virtio_net_tap.c     | 111 ++++
 tools/lkl/lib/virtio_net_vde.c     | 168 ++++++
 tools/lkl/tests/net-setup.sh       | 134 +++++
 tools/lkl/tests/net-test.c         | 317 +++++++++++
 tools/lkl/tests/net.sh             | 186 +++++++
 16 files changed, 3461 insertions(+)
 create mode 100644 tools/lkl/lib/net.c
 create mode 100644 tools/lkl/lib/virtio_net.c
 create mode 100644 tools/lkl/lib/virtio_net_dpdk.c
 create mode 100644 tools/lkl/lib/virtio_net_fd.c
 create mode 100644 tools/lkl/lib/virtio_net_fd.h
 create mode 100644 tools/lkl/lib/virtio_net_macvtap.c
 create mode 100644 tools/lkl/lib/virtio_net_pipe.c
 create mode 100644 tools/lkl/lib/virtio_net_raw.c
 create mode 100644 tools/lkl/lib/virtio_net_tap.c
 create mode 100644 tools/lkl/lib/virtio_net_vde.c
 create mode 100644 tools/lkl/tests/net-setup.sh
 create mode 100644 tools/lkl/tests/net-test.c
 create mode 100755 tools/lkl/tests/net.sh

diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
index 8bda12d4c6de..710fa38af905 100644
--- a/tools/lkl/include/lkl.h
+++ b/tools/lkl/include/lkl.h
@@ -529,6 +529,398 @@ int lkl_dirfd(struct lkl_dir *dir);
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
+/**
+ * lkl_netdev_add - add a new network device
+ *
+ * Must be called before calling lkl_start_kernel.
+ *
+ * @nd - the network device host handle
+ * @args - arguments that configs the netdev. Can be NULL
+ * @returns a network device id (0 is valid) or a strictly negative value in
+ * case of error
+ */
+#ifdef LKL_HOST_CONFIG_VIRTIO_NET
+int lkl_netdev_add(struct lkl_netdev *nd, struct lkl_netdev_args *args);
+#else
+static inline int lkl_netdev_add(struct lkl_netdev *nd,
+				 struct lkl_netdev_args *args)
+{
+	return -LKL_ENOSYS;
+}
+#endif
+
+/**
+ * lkl_netdev_remove - remove a previously added network device
+ *
+ * Attempts to release all resources held by a network device created
+ * via lkl_netdev_add.
+ *
+ * @id - the network device id, as return by @lkl_netdev_add
+ */
+#ifdef LKL_HOST_CONFIG_VIRTIO_NET
+void lkl_netdev_remove(int id);
+#else
+static inline void lkl_netdev_remove(int id)
+{
+}
+#endif
+
+/**
+ * lkl_netdev_free - frees a network device
+ *
+ * @nd - the network device to free
+ */
+#ifdef LKL_HOST_CONFIG_VIRTIO_NET
+void lkl_netdev_free(struct lkl_netdev *nd);
+#else
+static inline void lkl_netdev_free(struct lkl_netdev *nd)
+{
+}
+#endif
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
+ * lkl_netdev_tap_create - create TAP net_device for the virtio net backend
+ *
+ * @ifname - interface name for the TAP device. need to be configured
+ * on host in advance
+ * @offload - offload bits for the device
+ */
+#ifdef LKL_HOST_CONFIG_VIRTIO_NET
+struct lkl_netdev *lkl_netdev_tap_create(const char *ifname, int offload);
+#else
+static inline struct lkl_netdev *
+lkl_netdev_tap_create(const char *ifname, int offload)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * lkl_netdev_dpdk_create - create DPDK net_device for the virtio net backend
+ *
+ * @ifname - interface name for the DPDK device. The name for DPDK device is
+ * only used for an internal use.
+ * @offload - offload bits for the device
+ * @mac - mac address pointer of dpdk-ed device
+ */
+#ifdef LKL_HOST_CONFIG_VIRTIO_NET_DPDK
+struct lkl_netdev *lkl_netdev_dpdk_create(const char *ifname, int offload,
+					unsigned char *mac);
+#else
+static inline struct lkl_netdev *
+lkl_netdev_dpdk_create(const char *ifname, int offload, unsigned char *mac)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * lkl_netdev_vde_create - create VDE net_device for the virtio net backend
+ *
+ * @switch_path - path to the VDE switch directory. Needs to be started on host
+ * in advance.
+ */
+#ifdef LKL_HOST_CONFIG_VIRTIO_NET_VDE
+struct lkl_netdev *lkl_netdev_vde_create(const char *switch_path);
+#else
+static inline struct lkl_netdev *lkl_netdev_vde_create(const char *switch_path)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * lkl_netdev_raw_create - create raw socket net_device for the virtio net
+ *                         backend
+ *
+ * @ifname - interface name for the snoop device.
+ */
+#ifdef LKL_HOST_CONFIG_VIRTIO_NET
+struct lkl_netdev *lkl_netdev_raw_create(const char *ifname);
+#else
+static inline struct lkl_netdev *lkl_netdev_raw_create(const char *ifname)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * lkl_netdev_macvtap_create - create macvtap net_device for the virtio
+ * net backend
+ *
+ * @path - a file name for the macvtap device. need to be configured
+ * on host in advance
+ * @offload - offload bits for the device
+ */
+#ifdef LKL_HOST_CONFIG_VIRTIO_NET_MACVTAP
+struct lkl_netdev *lkl_netdev_macvtap_create(const char *path, int offload);
+#else
+static inline struct lkl_netdev *
+lkl_netdev_macvtap_create(const char *path, int offload)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * lkl_netdev_pipe_create - create pipe net_device for the virtio
+ * net backend
+ *
+ * @ifname - a file name for the rx and tx pipe device. need to be configured
+ * on host in advance. delimiter is "|". e.g. "rx_name|tx_name".
+ * @offload - offload bits for the device
+ */
+#ifdef LKL_HOST_CONFIG_VIRTIO_NET
+struct lkl_netdev *lkl_netdev_pipe_create(const char *ifname, int offload);
+#else
+static inline struct lkl_netdev *
+lkl_netdev_pipe_create(const char *ifname, int offload)
+{
+	return NULL;
+}
+#endif
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
index a630efc95f0f..ab9c3f2a69fb 100644
--- a/tools/lkl/include/lkl_host.h
+++ b/tools/lkl/include/lkl_host.h
@@ -76,6 +76,82 @@ struct lkl_dev_blk_ops {
 	int (*request)(struct lkl_disk disk, struct lkl_blk_req *req);
 };
 
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
index a7a3bff27bb1..1f1d55f259a3 100644
--- a/tools/lkl/lib/Build
+++ b/tools/lkl/lib/Build
@@ -1,8 +1,10 @@
 CFLAGS_config.o += -I$(srctree)/tools/perf/pmu-events
 CFLAGS_posix-host.o += -D_FILE_OFFSET_BITS=64
+CFLAGS_virtio_net_vde.o += $(pkg-config --cflags vdeplug 2>/dev/null)
 
 liblkl-y += fs.o
 liblkl-y += iomem.o
+liblkl-y += net.o
 liblkl-y += jmp_buf.o
 liblkl-$(LKL_HOST_CONFIG_POSIX) += posix-host.o
 liblkl-y += utils.o
@@ -10,5 +12,13 @@ liblkl-y += virtio_blk.o
 liblkl-y += virtio.o
 liblkl-y += dbg.o
 liblkl-y += dbg_handler.o
+liblkl-$(LKL_HOST_CONFIG_VIRTIO_NET) += virtio_net.o
+liblkl-$(LKL_HOST_CONFIG_VIRTIO_NET) += virtio_net_fd.o
+liblkl-$(LKL_HOST_CONFIG_VIRTIO_NET) += virtio_net_tap.o
+liblkl-$(LKL_HOST_CONFIG_VIRTIO_NET) += virtio_net_raw.o
+liblkl-$(LKL_HOST_CONFIG_VIRTIO_NET_MACVTAP) += virtio_net_macvtap.o
+liblkl-$(LKL_HOST_CONFIG_VIRTIO_NET_DPDK) += virtio_net_dpdk.o
+liblkl-$(LKL_HOST_CONFIG_VIRTIO_NET_VDE) += virtio_net_vde.o
+liblkl-$(LKL_HOST_CONFIG_VIRTIO_NET) += virtio_net_pipe.o
 liblkl-y += ../../perf/pmu-events/jsmn.o
 liblkl-y += config.o
diff --git a/tools/lkl/lib/net.c b/tools/lkl/lib/net.c
new file mode 100644
index 000000000000..316965ffd21e
--- /dev/null
+++ b/tools/lkl/lib/net.c
@@ -0,0 +1,818 @@
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
diff --git a/tools/lkl/lib/virtio_net.c b/tools/lkl/lib/virtio_net.c
new file mode 100644
index 000000000000..cd720b363f18
--- /dev/null
+++ b/tools/lkl/lib/virtio_net.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <lkl_host.h>
+#include "virtio.h"
+#include "endian.h"
+
+#include <lkl/linux/virtio_net.h>
+
+#define netdev_of(x) (container_of(x, struct virtio_net_dev, dev))
+#define BIT(x) (1ULL << x)
+
+/* We always have 2 queues on a netdev: one for tx, one for rx. */
+#define RX_QUEUE_IDX 0
+#define TX_QUEUE_IDX 1
+
+#define NUM_QUEUES (TX_QUEUE_IDX + 1)
+#define QUEUE_DEPTH 128
+
+/* In fact, we'll hit the limit on the devs string below long before
+ * we hit this, but it's good enough for now.
+ */
+#define MAX_NET_DEVS 16
+
+#ifdef DEBUG
+#define bad_request(s) do {			\
+		lkl_printf("%s\n", s);		\
+		panic();			\
+	} while (0)
+#else
+#define bad_request(s) lkl_printf("virtio_net: %s\n", s)
+#endif /* DEBUG */
+
+struct virtio_net_dev {
+	struct virtio_dev dev;
+	struct lkl_virtio_net_config config;
+	struct lkl_netdev *nd;
+	struct lkl_mutex **queue_locks;
+	lkl_thread_t poll_tid;
+};
+
+static int net_check_features(struct virtio_dev *dev)
+{
+	if (dev->driver_features == dev->device_features)
+		return 0;
+
+	return -LKL_EINVAL;
+}
+
+static void net_acquire_queue(struct virtio_dev *dev, int queue_idx)
+{
+	lkl_host_ops.mutex_lock(netdev_of(dev)->queue_locks[queue_idx]);
+}
+
+static void net_release_queue(struct virtio_dev *dev, int queue_idx)
+{
+	lkl_host_ops.mutex_unlock(netdev_of(dev)->queue_locks[queue_idx]);
+}
+
+/*
+ * The buffers passed through "req" from the virtio_net driver always starts
+ * with a vnet_hdr. We need to check the backend device if it expects vnet_hdr
+ * and adjust buffer offset accordingly.
+ */
+static int net_enqueue(struct virtio_dev *dev, int q, struct virtio_req *req)
+{
+	struct lkl_virtio_net_hdr_v1 *header;
+	struct virtio_net_dev *net_dev;
+	struct iovec *iov;
+	int ret;
+
+	header = req->buf[0].iov_base;
+	net_dev = netdev_of(dev);
+	/*
+	 * The backend device does not expect a vnet_hdr so adjust buf
+	 * accordingly. (We make adjustment to req->buf so it can be used
+	 * directly for the tx/rx call but remember to undo the change after the
+	 * call.  Note that it's ok to pass iov with entry's len==0.  The caller
+	 * will skip to the next entry correctly.
+	 */
+	if (!net_dev->nd->has_vnet_hdr) {
+		req->buf[0].iov_base += sizeof(*header);
+		req->buf[0].iov_len -= sizeof(*header);
+	}
+	iov = req->buf;
+
+	/* Pick which virtqueue to send the buffer(s) to */
+	if (q == TX_QUEUE_IDX) {
+		ret = net_dev->nd->ops->tx(net_dev->nd, iov, req->buf_count);
+		if (ret < 0)
+			return -1;
+	} else if (q == RX_QUEUE_IDX) {
+		int i, len;
+
+		ret = net_dev->nd->ops->rx(net_dev->nd, iov, req->buf_count);
+		if (ret < 0)
+			return -1;
+		if (net_dev->nd->has_vnet_hdr) {
+			/*
+			 * If the number of bytes returned exactly matches the
+			 * total space in the iov then there is a good chance we
+			 * did not supply a large enough buffer for the whole
+			 * pkt, i.e., pkt has been truncated.  This is only
+			 * likely to happen under mergeable RX buffer mode.
+			 */
+			if (req->total_len == (unsigned int)ret)
+				lkl_printf("PKT is likely truncated! len=%d\n",
+				    ret);
+		} else {
+			header->flags = 0;
+			header->gso_type = LKL_VIRTIO_NET_HDR_GSO_NONE;
+		}
+		/*
+		 * Have to compute how many descriptors we've consumed (really
+		 * only matters to the the mergeable RX mode) and return it
+		 * through "num_buffers".
+		 */
+		for (i = 0, len = ret; len > 0; i++)
+			len -= req->buf[i].iov_len;
+		header->num_buffers = i;
+
+		if (dev->device_features & BIT(LKL_VIRTIO_NET_F_GUEST_CSUM))
+			header->flags |= LKL_VIRTIO_NET_HDR_F_DATA_VALID;
+	} else {
+		bad_request("tried to push on non-existent queue");
+		return -1;
+	}
+	if (!net_dev->nd->has_vnet_hdr) {
+		/* Undo the adjustment */
+		req->buf[0].iov_base -= sizeof(*header);
+		req->buf[0].iov_len += sizeof(*header);
+		ret += sizeof(struct lkl_virtio_net_hdr_v1);
+	}
+	virtio_req_complete(req, ret);
+	return 0;
+}
+
+static struct virtio_dev_ops net_ops = {
+	.check_features = net_check_features,
+	.enqueue = net_enqueue,
+	.acquire_queue = net_acquire_queue,
+	.release_queue = net_release_queue,
+};
+
+void poll_thread(void *arg)
+{
+	struct virtio_net_dev *dev = arg;
+
+	/* Synchronization is handled in virtio_process_queue */
+	do {
+		int ret = dev->nd->ops->poll(dev->nd);
+
+		if (ret < 0) {
+			lkl_printf("virtio net poll error: %d\n", ret);
+			continue;
+		}
+
+		if (ret & LKL_DEV_NET_POLL_HUP)
+			break;
+		if (ret & LKL_DEV_NET_POLL_RX)
+			virtio_process_queue(&dev->dev, 0);
+		if (ret & LKL_DEV_NET_POLL_TX)
+			virtio_process_queue(&dev->dev, 1);
+	} while (1);
+}
+
+struct virtio_net_dev *registered_devs[MAX_NET_DEVS];
+static int registered_dev_idx;
+
+static int dev_register(struct virtio_net_dev *dev)
+{
+	if (registered_dev_idx == MAX_NET_DEVS) {
+		lkl_printf("Too many virtio_net devices!\n");
+		/* This error code is a little bit of a lie */
+		return -LKL_ENOMEM;
+	}
+
+	/* registered_dev_idx is incremented by the caller */
+	registered_devs[registered_dev_idx] = dev;
+	return 0;
+}
+
+static void free_queue_locks(struct lkl_mutex **queues, int num_queues)
+{
+	int i = 0;
+
+	if (!queues)
+		return;
+
+	for (i = 0; i < num_queues; i++)
+		lkl_host_ops.mutex_free(queues[i]);
+
+	lkl_host_ops.mem_free(queues);
+}
+
+static struct lkl_mutex **init_queue_locks(int num_queues)
+{
+	int i;
+	struct lkl_mutex **ret = lkl_host_ops.mem_alloc(
+		sizeof(struct lkl_mutex *) * num_queues);
+	if (!ret)
+		return NULL;
+
+	memset(ret, 0, sizeof(struct lkl_mutex *) * num_queues);
+	for (i = 0; i < num_queues; i++) {
+		ret[i] = lkl_host_ops.mutex_alloc(1);
+		if (!ret[i]) {
+			free_queue_locks(ret, i);
+			return NULL;
+		}
+	}
+
+	return ret;
+}
+
+int lkl_netdev_add(struct lkl_netdev *nd, struct lkl_netdev_args *args)
+{
+	struct virtio_net_dev *dev;
+	int ret = -LKL_ENOMEM;
+
+	dev = lkl_host_ops.mem_alloc(sizeof(*dev));
+	if (!dev)
+		return -LKL_ENOMEM;
+
+	memset(dev, 0, sizeof(*dev));
+
+	dev->dev.device_id = LKL_VIRTIO_ID_NET;
+	if (args) {
+		if (args->mac) {
+			dev->dev.device_features |= BIT(LKL_VIRTIO_NET_F_MAC);
+			memcpy(dev->config.mac, args->mac, LKL_ETH_ALEN);
+		}
+		dev->dev.device_features |= args->offload;
+
+	}
+	dev->dev.config_data = &dev->config;
+	dev->dev.config_len = sizeof(dev->config);
+	dev->dev.ops = &net_ops;
+	dev->nd = nd;
+	dev->queue_locks = init_queue_locks(NUM_QUEUES);
+
+	if (!dev->queue_locks)
+		goto out_free;
+
+	/*
+	 * MUST match the number of queue locks we initialized. We could init
+	 * the queues in virtio_dev_setup to help enforce this, but netdevs are
+	 * the only flavor that need these locks, so it's better to do it
+	 * here.
+	 */
+	ret = virtio_dev_setup(&dev->dev, NUM_QUEUES, QUEUE_DEPTH);
+
+	if (ret)
+		goto out_free;
+
+	/*
+	 * We may receive upto 64KB TSO packet so collect as many descriptors as
+	 * there are available up to 64KB in total len.
+	 */
+	if (dev->dev.device_features & BIT(LKL_VIRTIO_NET_F_MRG_RXBUF))
+		virtio_set_queue_max_merge_len(&dev->dev, RX_QUEUE_IDX, 65536);
+
+	dev->poll_tid = lkl_host_ops.thread_create(poll_thread, dev);
+	if (dev->poll_tid == 0)
+		goto out_cleanup_dev;
+
+	ret = dev_register(dev);
+	if (ret < 0)
+		goto out_cleanup_dev;
+
+	return registered_dev_idx++;
+
+out_cleanup_dev:
+	virtio_dev_cleanup(&dev->dev);
+
+out_free:
+	if (dev->queue_locks)
+		free_queue_locks(dev->queue_locks, NUM_QUEUES);
+	lkl_host_ops.mem_free(dev);
+
+	return ret;
+}
+
+/* Return 0 for success, -1 for failure. */
+void lkl_netdev_remove(int id)
+{
+	struct virtio_net_dev *dev;
+	int ret;
+
+	if (id >= registered_dev_idx) {
+		lkl_printf("%s: invalid id: %d\n", __func__, id);
+		return;
+	}
+
+	dev = registered_devs[id];
+
+	dev->nd->ops->poll_hup(dev->nd);
+	lkl_host_ops.thread_join(dev->poll_tid);
+
+	ret = lkl_netdev_get_ifindex(id);
+	if (ret < 0) {
+		lkl_printf("%s: failed to get ifindex for id %d: %s\n",
+			   __func__, id, lkl_strerror(ret));
+		return;
+	}
+
+	ret = lkl_if_down(ret);
+	if (ret < 0) {
+		lkl_printf("%s: failed to put interface id %d down: %s\n",
+			   __func__, id, lkl_strerror(ret));
+		return;
+	}
+
+	virtio_dev_cleanup(&dev->dev);
+
+	free_queue_locks(dev->queue_locks, NUM_QUEUES);
+	lkl_host_ops.mem_free(dev);
+}
+
+void lkl_netdev_free(struct lkl_netdev *nd)
+{
+	nd->ops->free(nd);
+}
diff --git a/tools/lkl/lib/virtio_net_dpdk.c b/tools/lkl/lib/virtio_net_dpdk.c
new file mode 100644
index 000000000000..9512769554a5
--- /dev/null
+++ b/tools/lkl/lib/virtio_net_dpdk.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel DPDK based virtual network interface feature for LKL
+ * Copyright (c) 2015,2016 Ryo Nakamura, Hajime Tazaki
+ *
+ * Author: Ryo Nakamura <upa@wide.ad.jp>
+ *         Hajime Tazaki <thehajime@gmail.com>
+ */
+
+//#define DEBUG
+
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <errno.h>
+#include <sys/queue.h>
+
+#include <rte_eal.h>
+#include <rte_ethdev.h>
+#include <rte_mempool.h>
+#include <rte_net.h>
+
+#include <lkl_host.h>
+
+static char *ealargs[4] = {
+	"lkl_vif_dpdk",
+	"-c 1",
+	"-n 1",
+	"--log-level=0",
+};
+
+#define MAX_PKT_BURST           16
+/* XXX: disable cache due to no thread-safe on mempool cache. */
+#define MEMPOOL_CACHE_SZ        0
+/* for TSO pkt */
+#define MAX_PACKET_SZ           (65535 \
+	- (sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM))
+#define MBUF_NUM                (512*2) /* vmxnet3 requires 1024 */
+#define MBUF_SIZ        \
+	(MAX_PACKET_SZ + sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM)
+#define NUMDESC         512	/* nb_min on vmxnet3 is 512 */
+#define NUMQUEUE        1
+
+#define BIT(x) (1ULL << x)
+
+static int portid;
+
+struct lkl_netdev_dpdk {
+	struct lkl_netdev dev;
+	int portid;
+	struct rte_mempool *rxpool, *txpool; /* ring buffer pool */
+	/* burst receive context by rump dpdk code */
+	struct rte_mbuf *rcv_mbuf[MAX_PKT_BURST];
+	int npkts;
+	int bufidx;
+	int offload;
+	int close: 1;
+	int busy_poll: 1;
+};
+
+static int dpdk_net_tx_prep(struct rte_mbuf *rm,
+		struct lkl_virtio_net_hdr_v1 *header)
+{
+	struct rte_net_hdr_lens hdr_lens;
+	uint32_t ptype;
+
+#ifdef DEBUG
+	lkl_printf("dpdk-tx: gso_type=%d, gso=%d, hdrlen=%d validation=%d\n",
+		header->gso_type, header->gso_size, header->hdr_len,
+		rte_validate_tx_offload(rm));
+#endif
+
+	ptype = rte_net_get_ptype(rm, &hdr_lens, RTE_PTYPE_ALL_MASK);
+	rm->l2_len = hdr_lens.l2_len;
+	rm->l3_len = hdr_lens.l3_len;
+	rm->l4_len = hdr_lens.l4_len; // including tcp opts
+
+	if ((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_TCP) {
+		if ((ptype & RTE_PTYPE_L3_MASK) == RTE_PTYPE_L3_IPV4)
+			rm->ol_flags = PKT_TX_IPV4;
+		else if ((ptype & RTE_PTYPE_L3_MASK) == RTE_PTYPE_L3_IPV6)
+			rm->ol_flags = PKT_TX_IPV6;
+
+		rm->ol_flags |= PKT_TX_TCP_CKSUM;
+		rm->tso_segsz = header->gso_size;
+		/* TSO case */
+		if (header->gso_type == LKL_VIRTIO_NET_HDR_GSO_TCPV4)
+			rm->ol_flags |= (PKT_TX_TCP_SEG | PKT_TX_IP_CKSUM);
+		else if (header->gso_type == LKL_VIRTIO_NET_HDR_GSO_TCPV6)
+			rm->ol_flags |= PKT_TX_TCP_SEG;
+	}
+
+	return sizeof(struct lkl_virtio_net_hdr_v1);
+
+}
+
+static int dpdk_net_tx(struct lkl_netdev *nd, struct iovec *iov, int cnt)
+{
+	void *pkt;
+	struct rte_mbuf *rm;
+	struct lkl_netdev_dpdk *nd_dpdk;
+	struct lkl_virtio_net_hdr_v1 *header = NULL;
+	int i, len, sent = 0;
+	void *data = NULL;
+
+	nd_dpdk = (struct lkl_netdev_dpdk *) nd;
+
+	/*
+	 * XXX: someone reported that DPDK's mempool with cache is not thread
+	 * safe (e.g., http://www.dpdk.io/ml/archives/dev/2014-February/001401.html),
+	 * potentially rte_pktmbuf_alloc() is not thread safe here.  so I
+	 * tentatively disabled the cache on mempool by assigning
+	 * MEMPOOL_CACHE_SZ to 0.
+	 */
+	rm = rte_pktmbuf_alloc(nd_dpdk->txpool);
+
+	for (i = 0; i < cnt; i++) {
+		data = iov[i].iov_base;
+		len = (int)iov[i].iov_len;
+
+		if (i == 0) {
+			header = data;
+			data += sizeof(*header);
+			len -= sizeof(*header);
+		}
+
+		if (len == 0)
+			continue;
+
+		pkt = rte_pktmbuf_append(rm, len);
+		if (pkt) {
+			/* XXX: I wanna have M_EXT flag !!! */
+			memcpy(pkt, data, len);
+			sent += len;
+		} else {
+			lkl_printf("dpdk-tx: failed to append: idx=%d len=%d\n",
+				   i, len);
+			rte_pktmbuf_free(rm);
+			return -1;
+		}
+#ifdef DEBUG
+		lkl_printf("dpdk-tx: pkt[%d]len=%d\n", i, len);
+#endif
+	}
+
+	/* preparation for TX offloads */
+	sent += dpdk_net_tx_prep(rm, header);
+
+	/* XXX: should be bulk-trasmitted !! */
+	if (rte_eth_tx_prepare(nd_dpdk->portid, 0, &rm, 1) != 1)
+		lkl_printf("tx_prep failed\n");
+
+	rte_eth_tx_burst(nd_dpdk->portid, 0, &rm, 1);
+
+	rte_pktmbuf_free(rm);
+	return sent;
+}
+
+static int __dpdk_net_rx(struct lkl_netdev *nd, struct iovec *iov, int cnt)
+{
+	struct lkl_netdev_dpdk *nd_dpdk;
+	int i = 0;
+	struct rte_mbuf *rm, *first;
+	void *r_data;
+	size_t read = 0, r_size, copylen = 0, offset = 0;
+	struct lkl_virtio_net_hdr_v1 *header = iov[0].iov_base;
+	uint16_t mtu;
+
+	nd_dpdk = (struct lkl_netdev_dpdk *) nd;
+	memset(header, 0, sizeof(struct lkl_virtio_net_hdr_v1));
+
+	first = nd_dpdk->rcv_mbuf[nd_dpdk->bufidx];
+
+	for (rm = nd_dpdk->rcv_mbuf[nd_dpdk->bufidx]; rm; rm = rm->next) {
+		r_data = rte_pktmbuf_mtod(rm, void *);
+		r_size = rte_pktmbuf_data_len(rm);
+
+#ifdef DEBUG
+		lkl_printf("dpdk-rx: mbuf pktlen=%d orig_len=%lu\n",
+			   r_size, iov[i].iov_len);
+#endif
+		/* mergeable buffer starts data after vnet header at [0] */
+		if (nd_dpdk->offload & BIT(LKL_VIRTIO_NET_F_MRG_RXBUF) &&
+		    i == 0)
+			offset = sizeof(struct lkl_virtio_net_hdr_v1);
+		else if (nd_dpdk->offload & BIT(LKL_VIRTIO_NET_F_GUEST_TSO4) &&
+			 i == 0)
+			i++;
+		else
+			offset = sizeof(struct lkl_virtio_net_hdr_v1);
+
+		read += r_size;
+		while (r_size > 0) {
+			if (i >= cnt) {
+				fprintf(stderr,
+					"dpdk-rx: buffer full. skip it. ");
+				fprintf(stderr,
+					"(cnt=%d, buf[%d]=%lu, size=%lu)\n",
+					i, cnt, iov[i].iov_len, r_size);
+				goto end;
+			}
+
+			copylen = r_size < (iov[i].iov_len - offset) ? r_size
+				: iov[i].iov_len - offset;
+			memcpy(iov[i].iov_base + offset, r_data, copylen);
+
+			r_size -= copylen;
+			offset = 0;
+			i++;
+		}
+	}
+
+end:
+	/* TSO (big_packet mode) */
+	header->flags = LKL_VIRTIO_NET_HDR_F_DATA_VALID;
+	rte_eth_dev_get_mtu(nd_dpdk->portid, &mtu);
+
+	if (read > (mtu + sizeof(struct ether_hdr)
+		    + sizeof(struct lkl_virtio_net_hdr_v1))) {
+		struct rte_net_hdr_lens hdr_lens;
+		uint32_t ptype;
+
+		ptype = rte_net_get_ptype(first, &hdr_lens, RTE_PTYPE_ALL_MASK);
+
+		if ((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_TCP) {
+			if ((ptype & RTE_PTYPE_L3_MASK) == RTE_PTYPE_L3_IPV4 &&
+			    nd_dpdk->offload & BIT(LKL_VIRTIO_NET_F_GUEST_TSO4))
+				header->gso_type = LKL_VIRTIO_NET_HDR_GSO_TCPV4;
+			/* XXX: Intel X540 doesn't support LRO
+			 * with tcpv6 packets
+			 */
+			if ((ptype & RTE_PTYPE_L3_MASK) == RTE_PTYPE_L3_IPV6 &&
+			    nd_dpdk->offload & BIT(LKL_VIRTIO_NET_F_GUEST_TSO6))
+				header->gso_type = LKL_VIRTIO_NET_HDR_GSO_TCPV6;
+		}
+
+		header->gso_size = mtu - hdr_lens.l3_len - hdr_lens.l4_len;
+		header->hdr_len = hdr_lens.l2_len + hdr_lens.l3_len
+			+ hdr_lens.l4_len;
+	}
+
+	read += sizeof(struct lkl_virtio_net_hdr_v1);
+
+#ifdef DEBUG
+	lkl_printf("dpdk-rx: len=%d mtu=%d type=%d, size=%d, hdrlen=%d\n",
+		   read, mtu, header->gso_type,
+		   header->gso_size, header->hdr_len);
+#endif
+
+	return read;
+}
+
+
+/*
+ * this function is not thread-safe.
+ *
+ * nd_dpdk->rcv_mbuf is specifically not safe in parallel access.  if future
+ * refactor allows us to read in parallel, the buffer (nd_dpdk->rcv_mbuf) shall
+ * be guarded.
+ */
+static int dpdk_net_rx(struct lkl_netdev *nd, struct iovec *iov, int cnt)
+{
+	struct lkl_netdev_dpdk *nd_dpdk;
+	int read = 0;
+
+	nd_dpdk = (struct lkl_netdev_dpdk *) nd;
+
+	if (nd_dpdk->npkts == 0) {
+		nd_dpdk->npkts = rte_eth_rx_burst(nd_dpdk->portid, 0,
+						  nd_dpdk->rcv_mbuf,
+						  MAX_PKT_BURST);
+		if (nd_dpdk->npkts <= 0) {
+			/* XXX: need to implement proper poll()
+			 * or interrupt mode PMD of dpdk, which is only
+			 * availbale on ixgbe/igb/e1000 (as of Jan. 2016)
+			 */
+			if (!nd_dpdk->busy_poll)
+				usleep(1);
+			return -1;
+		}
+		nd_dpdk->bufidx = 0;
+	}
+
+	/* mergeable buffer */
+	read = __dpdk_net_rx(nd, iov, cnt);
+
+	rte_pktmbuf_free(nd_dpdk->rcv_mbuf[nd_dpdk->bufidx]);
+
+	nd_dpdk->bufidx++;
+	nd_dpdk->npkts--;
+
+	return read;
+}
+
+static int dpdk_net_poll(struct lkl_netdev *nd)
+{
+	struct lkl_netdev_dpdk *nd_dpdk =
+		container_of(nd, struct lkl_netdev_dpdk, dev);
+
+	if (nd_dpdk->close)
+		return LKL_DEV_NET_POLL_HUP;
+	/*
+	 * dpdk's interrupt mode has equivalent of epoll_wait(2),
+	 * which we can apply here. but AFAIK the mode is only available
+	 * on limited NIC drivers like ixgbe/igb/e1000 (with dpdk v2.2.0),
+	 * while vmxnet3 is not supported e.g..
+	 */
+	return LKL_DEV_NET_POLL_RX | LKL_DEV_NET_POLL_TX;
+}
+
+static void dpdk_net_poll_hup(struct lkl_netdev *nd)
+{
+	struct lkl_netdev_dpdk *nd_dpdk =
+		container_of(nd, struct lkl_netdev_dpdk, dev);
+
+	nd_dpdk->close = 1;
+}
+
+static void dpdk_net_free(struct lkl_netdev *nd)
+{
+	struct lkl_netdev_dpdk *nd_dpdk =
+		container_of(nd, struct lkl_netdev_dpdk, dev);
+
+	free(nd_dpdk);
+}
+
+struct lkl_dev_net_ops dpdk_net_ops = {
+	.tx = dpdk_net_tx,
+	.rx = dpdk_net_rx,
+	.poll = dpdk_net_poll,
+	.poll_hup = dpdk_net_poll_hup,
+	.free = dpdk_net_free,
+};
+
+
+static int dpdk_init;
+struct lkl_netdev *lkl_netdev_dpdk_create(const char *ifparams, int offload,
+					 unsigned char *mac)
+{
+	int ret = 0;
+	struct rte_eth_conf portconf;
+	struct rte_eth_link link;
+	struct lkl_netdev_dpdk *nd;
+	struct rte_eth_dev_info dev_info;
+	char poolname[RTE_MEMZONE_NAMESIZE];
+	char *debug = getenv("LKL_HIJACK_DEBUG");
+	int lkl_debug = 0;
+
+	if (!dpdk_init) {
+		if (debug)
+			lkl_debug = strtol(debug, NULL, 0);
+		if (lkl_debug & 0x400)
+			ealargs[3] = "--log-level=100";
+
+		ret = rte_eal_init(sizeof(ealargs) / sizeof(ealargs[0]),
+				   ealargs);
+		if (ret < 0)
+			lkl_printf("dpdk: failed to initialize eal\n");
+
+		dpdk_init = 1;
+	}
+
+	nd = malloc(sizeof(struct lkl_netdev_dpdk));
+	memset(nd, 0, sizeof(struct lkl_netdev_dpdk));
+	nd->dev.ops = &dpdk_net_ops;
+	nd->portid = portid++;
+	/* busy-poll mode is described 'ifparams' with "*-busy" */
+	nd->busy_poll = strstr(ifparams, "busy") ? 1 : 0;
+	/* we always enable big_packet mode with dpdk. */
+	nd->offload = offload;
+
+	snprintf(poolname, RTE_MEMZONE_NAMESIZE, "%s%s", "tx-", ifparams);
+	nd->txpool =
+		rte_mempool_create(poolname,
+				   MBUF_NUM, MBUF_SIZ, MEMPOOL_CACHE_SZ,
+				   sizeof(struct rte_pktmbuf_pool_private),
+				   rte_pktmbuf_pool_init, NULL,
+				   rte_pktmbuf_init, NULL, 0, 0);
+
+	if (!nd->txpool) {
+		lkl_printf("dpdk: failed to allocate tx pool\n");
+		free(nd);
+		return NULL;
+	}
+
+
+	snprintf(poolname, RTE_MEMZONE_NAMESIZE, "%s%s", "rx-", ifparams);
+	nd->rxpool =
+		rte_mempool_create(poolname, MBUF_NUM, MBUF_SIZ, 0,
+				   sizeof(struct rte_pktmbuf_pool_private),
+				   rte_pktmbuf_pool_init, NULL,
+				   rte_pktmbuf_init, NULL, 0, 0);
+	if (!nd->rxpool) {
+		lkl_printf("dpdk: failed to allocate rx pool\n");
+		free(nd);
+		return NULL;
+	}
+
+	memset(&portconf, 0, sizeof(portconf));
+
+	/* offload bits */
+	/* but, we only configure NIC to use TSO *only if* user specifies. */
+	if (offload & (BIT(LKL_VIRTIO_NET_F_GUEST_TSO4) |
+			BIT(LKL_VIRTIO_NET_F_GUEST_TSO6) |
+			BIT(LKL_VIRTIO_NET_F_MRG_RXBUF))) {
+		portconf.rxmode.enable_lro = 1;
+		portconf.rxmode.hw_strip_crc = 1;
+	}
+
+	ret = rte_eth_dev_configure(nd->portid, NUMQUEUE, NUMQUEUE,
+				    &portconf);
+	if (ret < 0) {
+		lkl_printf("dpdk: failed to configure port\n");
+		free(nd);
+		return NULL;
+	}
+
+	rte_eth_dev_info_get(nd->portid, &dev_info);
+
+	ret = rte_eth_rx_queue_setup(nd->portid, 0, NUMDESC, 0,
+				     &dev_info.default_rxconf, nd->rxpool);
+	if (ret < 0) {
+		lkl_printf("dpdk: failed to setup rx queue\n");
+		free(nd);
+		return NULL;
+	}
+
+	dev_info.default_txconf.txq_flags = 0;
+
+	dev_info.default_txconf.txq_flags |= ETH_TXQ_FLAGS_NOXSUMSCTP;
+	dev_info.default_txconf.txq_flags |= ETH_TXQ_FLAGS_NOVLANOFFL;
+
+
+	ret = rte_eth_tx_queue_setup(nd->portid, 0, NUMDESC, 0,
+				     &dev_info.default_txconf);
+	if (ret < 0) {
+		lkl_printf("dpdk: failed to setup tx queue\n");
+		free(nd);
+		return NULL;
+	}
+
+	ret = rte_eth_dev_start(nd->portid);
+	/* XXX: this function returns positive val (e.g., 12)
+	 * if there's an error
+	 */
+	if (ret != 0) {
+		lkl_printf("dpdk: failed to start device\n");
+		free(nd);
+		return NULL;
+	}
+
+	if (mac) {
+		rte_eth_macaddr_get(nd->portid, (struct ether_addr *)mac);
+		lkl_printf("Port %d: %02x:%02x:%02x:%02x:%02x:%02x\n",
+			   nd->portid,
+			   mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+	}
+
+	rte_eth_dev_set_link_up(nd->portid);
+
+	rte_eth_link_get(nd->portid, &link);
+	if (!link.link_status) {
+		fprintf(stderr, "dpdk: interface state is down\n");
+		rte_eth_link_get(nd->portid, &link);
+		if (!link.link_status) {
+			fprintf(stderr,
+				"dpdk: interface state is down.. Giving up.\n");
+			return NULL;
+		}
+		lkl_printf("dpdk: interface state should be up now.\n");
+	}
+
+	/* should be promisc ? */
+	rte_eth_promiscuous_enable(nd->portid);
+
+	/* as we always assume to have vnet_hdr for dpdk device. */
+	nd->dev.has_vnet_hdr = 1;
+
+	return (struct lkl_netdev *) nd;
+}
diff --git a/tools/lkl/lib/virtio_net_fd.c b/tools/lkl/lib/virtio_net_fd.c
new file mode 100644
index 000000000000..f8664455e696
--- /dev/null
+++ b/tools/lkl/lib/virtio_net_fd.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * POSIX file descriptor based virtual network interface feature for
+ * LKL Copyright (c) 2015,2016 Ryo Nakamura, Hajime Tazaki
+ *
+ * Author: Ryo Nakamura <upa@wide.ad.jp>
+ *         Hajime Tazaki <thehajime@gmail.com>
+ *         Octavian Purdila <octavian.purdila@intel.com>
+ *
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#ifdef __FreeBSD__
+#include <sys/syslimits.h>
+#else
+#include <limits.h>
+#endif
+#include <fcntl.h>
+#include <sys/poll.h>
+#include <sys/uio.h>
+
+#include "virtio.h"
+#include "virtio_net_fd.h"
+
+struct lkl_netdev_fd {
+	struct lkl_netdev dev;
+	/* file-descriptor based device */
+	int fd_rx;
+	int fd_tx;
+	/*
+	 * Controlls the poll mask for fd. Can be acccessed concurrently from
+	 * poll, tx, or rx routines but there is no need for syncronization
+	 * because:
+	 *
+	 * (a) TX and RX routines set different variables so even if they update
+	 * at the same time there is no race condition
+	 *
+	 * (b) Even if poll and TX / RX update at the same time poll cannot
+	 * stall: when poll resets the poll variable we know that TX / RX will
+	 * run which means that eventually the poll variable will be set.
+	 */
+	int poll_tx, poll_rx;
+	/* controle pipe */
+	int pipe[2];
+};
+
+static int fd_net_tx(struct lkl_netdev *nd, struct iovec *iov, int cnt)
+{
+	int ret;
+	struct lkl_netdev_fd *nd_fd =
+		container_of(nd, struct lkl_netdev_fd, dev);
+
+	do {
+		ret = writev(nd_fd->fd_tx, iov, cnt);
+	} while (ret == -1 && errno == EINTR);
+
+	if (ret < 0) {
+		if (errno != EAGAIN) {
+			perror("write to fd netdev fails");
+		} else {
+			char tmp = 0;
+
+			nd_fd->poll_tx = 1;
+			if (write(nd_fd->pipe[1], &tmp, 1) <= 0)
+				perror("virtio net fd pipe write");
+		}
+	}
+	return ret;
+}
+
+static int fd_net_rx(struct lkl_netdev *nd, struct iovec *iov, int cnt)
+{
+	int ret;
+	struct lkl_netdev_fd *nd_fd =
+		container_of(nd, struct lkl_netdev_fd, dev);
+
+	do {
+		ret = readv(nd_fd->fd_rx, (struct iovec *)iov, cnt);
+	} while (ret == -1 && errno == EINTR);
+
+	if (ret < 0) {
+		if (errno != EAGAIN) {
+			perror("virtio net fd read");
+		} else {
+			char tmp = 0;
+
+			nd_fd->poll_rx = 1;
+			if (write(nd_fd->pipe[1], &tmp, 1) < 0)
+				perror("virtio net fd pipe write");
+		}
+	}
+	return ret;
+}
+
+static int fd_net_poll(struct lkl_netdev *nd)
+{
+	struct lkl_netdev_fd *nd_fd =
+		container_of(nd, struct lkl_netdev_fd, dev);
+	struct pollfd pfds[3] = {
+		{
+			.fd = nd_fd->fd_rx,
+		},
+		{
+			.fd = nd_fd->fd_tx,
+		},
+		{
+			.fd = nd_fd->pipe[0],
+			.events = POLLIN,
+		},
+	};
+	int ret;
+
+	if (nd_fd->poll_rx)
+		pfds[0].events |= POLLIN|POLLPRI;
+	if (nd_fd->poll_tx)
+		pfds[1].events |= POLLOUT;
+
+	do {
+		ret = poll(pfds, 3, -1);
+	} while (ret == -1 && errno == EINTR);
+
+	if (ret < 0) {
+		perror("virtio net fd poll");
+		return 0;
+	}
+
+	if (pfds[2].revents & (POLLHUP|POLLNVAL))
+		return LKL_DEV_NET_POLL_HUP;
+
+	if (pfds[2].revents & POLLIN) {
+		char tmp[PIPE_BUF];
+
+		ret = read(nd_fd->pipe[0], tmp, PIPE_BUF);
+		if (ret == 0)
+			return LKL_DEV_NET_POLL_HUP;
+		if (ret < 0)
+			perror("virtio net fd pipe read");
+	}
+
+	ret = 0;
+
+	if (pfds[0].revents & (POLLIN|POLLPRI)) {
+		nd_fd->poll_rx = 0;
+		ret |= LKL_DEV_NET_POLL_RX;
+	}
+
+	if (pfds[1].revents & POLLOUT) {
+		nd_fd->poll_tx = 0;
+		ret |= LKL_DEV_NET_POLL_TX;
+	}
+
+	return ret;
+}
+
+static void fd_net_poll_hup(struct lkl_netdev *nd)
+{
+	struct lkl_netdev_fd *nd_fd =
+		container_of(nd, struct lkl_netdev_fd, dev);
+
+	/* this will cause a POLLHUP / POLLNVAL in the poll function */
+	close(nd_fd->pipe[0]);
+	close(nd_fd->pipe[1]);
+}
+
+static void fd_net_free(struct lkl_netdev *nd)
+{
+	struct lkl_netdev_fd *nd_fd =
+		container_of(nd, struct lkl_netdev_fd, dev);
+
+	close(nd_fd->fd_rx);
+	close(nd_fd->fd_tx);
+	free(nd_fd);
+}
+
+struct lkl_dev_net_ops fd_net_ops =  {
+	.tx = fd_net_tx,
+	.rx = fd_net_rx,
+	.poll = fd_net_poll,
+	.poll_hup = fd_net_poll_hup,
+	.free = fd_net_free,
+};
+
+struct lkl_netdev *lkl_register_netdev_fd(int fd_rx, int fd_tx)
+{
+	struct lkl_netdev_fd *nd;
+
+	nd = malloc(sizeof(*nd));
+	if (!nd) {
+		fprintf(stderr, "fdnet: failed to allocate memory\n");
+		/* TODO: propagate the error state, maybe use errno for that? */
+		return NULL;
+	}
+
+	memset(nd, 0, sizeof(*nd));
+
+	nd->fd_rx = fd_rx;
+	nd->fd_tx = fd_tx;
+	if (pipe(nd->pipe) < 0) {
+		perror("pipe");
+		free(nd);
+		return NULL;
+	}
+
+	if (fcntl(nd->pipe[0], F_SETFL, O_NONBLOCK) < 0) {
+		perror("fnctl");
+		close(nd->pipe[0]);
+		close(nd->pipe[1]);
+		free(nd);
+		return NULL;
+	}
+
+	nd->dev.ops = &fd_net_ops;
+	return &nd->dev;
+}
diff --git a/tools/lkl/lib/virtio_net_fd.h b/tools/lkl/lib/virtio_net_fd.h
new file mode 100644
index 000000000000..713ba13cca7c
--- /dev/null
+++ b/tools/lkl/lib/virtio_net_fd.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _VIRTIO_NET_FD_H
+#define _VIRTIO_NET_FD_H
+
+struct ifreq;
+
+/**
+ * lkl_register_netdev_linux_fdnet - register a file descriptor-based network
+ * device as a NIC
+ *
+ * @fd_rx - a POSIX file descriptor number for input
+ * @fd_tx - a POSIX file descriptor number for output
+ * @returns a struct lkl_netdev_linux_fdnet entry for virtio-net
+ */
+struct lkl_netdev *lkl_register_netdev_fd(int fd_rx, int fd_tx);
+
+
+/**
+ * lkl_netdev_tap_init - initialize tap related structure fot lkl_netdev.
+ *
+ * @path - the path to open the device.
+ * @offload - offload bits for the device
+ * @ifr - struct ifreq for ioctl.
+ */
+struct lkl_netdev *lkl_netdev_tap_init(const char *path, int offload,
+				       struct ifreq *ifr);
+
+#endif /* _VIRTIO_NET_FD_H*/
diff --git a/tools/lkl/lib/virtio_net_macvtap.c b/tools/lkl/lib/virtio_net_macvtap.c
new file mode 100644
index 000000000000..5d6d2c822f2d
--- /dev/null
+++ b/tools/lkl/lib/virtio_net_macvtap.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * macvtap based virtual network interface feature for LKL
+ * Copyright (c) 2016 Hajime Tazaki
+ *
+ * Author: Hajime Tazaki <thehajime@gmail.com>
+ *
+ * Current implementation is linux-specific.
+ */
+
+/*
+ * You need to configure host device in advance.
+ *
+ * sudo ip link add link eth0 name vtap0 type macvtap mode passthru
+ * sudo ip link set dev vtap0 up
+ * sudo chown thehajime /dev/tap22
+ */
+
+#include <net/if.h>
+#include <linux/if_tun.h>
+
+#include "virtio.h"
+#include "virtio_net_fd.h"
+
+struct lkl_netdev *lkl_netdev_macvtap_create(const char *path, int offload)
+{
+	struct ifreq ifr = {
+		.ifr_flags = IFF_TAP | IFF_NO_PI,
+	};
+
+	return lkl_netdev_tap_init(path, offload, &ifr);
+}
diff --git a/tools/lkl/lib/virtio_net_pipe.c b/tools/lkl/lib/virtio_net_pipe.c
new file mode 100644
index 000000000000..c68d4c855499
--- /dev/null
+++ b/tools/lkl/lib/virtio_net_pipe.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pipe based virtual network interface feature for LKL
+ * Copyright (c) 2017,2016 Motomu Utsumi
+ *
+ * Author: Motomu Utsumi <motomuman@gmail.com>
+ *
+ * Current implementation is linux-specific.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <fcntl.h>
+
+#include "virtio.h"
+#include "virtio_net_fd.h"
+
+struct lkl_netdev *lkl_netdev_pipe_create(const char *_ifname, int offload)
+{
+	struct lkl_netdev *nd;
+	int fd_rx, fd_tx;
+	char *ifname = strdup(_ifname), *ifname_rx = NULL, *ifname_tx = NULL;
+
+	ifname_rx = strtok(ifname, "|");
+	if (ifname_rx == NULL) {
+		fprintf(stderr, "invalid ifname format: %s\n", ifname);
+		free(ifname);
+		return NULL;
+	}
+
+	ifname_tx = strtok(NULL, "|");
+	if (ifname_tx == NULL) {
+		fprintf(stderr, "invalid ifname format: %s\n", ifname);
+		free(ifname);
+		return NULL;
+	}
+
+	if (strtok(NULL, "|") != NULL) {
+		fprintf(stderr, "invalid ifname format: %s\n", ifname);
+		free(ifname);
+		return NULL;
+	}
+
+	fd_rx = open(ifname_rx, O_RDWR|O_NONBLOCK);
+	if (fd_rx < 0) {
+		perror("can not open ifname_rx pipe");
+		free(ifname);
+		return NULL;
+	}
+
+	fd_tx = open(ifname_tx, O_RDWR|O_NONBLOCK);
+	if (fd_tx < 0) {
+		perror("can not open ifname_tx pipe");
+		close(fd_rx);
+		free(ifname);
+		return NULL;
+	}
+
+	nd = lkl_register_netdev_fd(fd_rx, fd_tx);
+	if (!nd) {
+		perror("failed to register to.");
+		close(fd_rx);
+		close(fd_tx);
+		free(ifname);
+		return NULL;
+	}
+
+	free(ifname);
+	/*
+	 * To avoid mismatch with LKL otherside,
+	 * we always enabled vnet hdr
+	 */
+	nd->has_vnet_hdr = 1;
+	return nd;
+}
diff --git a/tools/lkl/lib/virtio_net_raw.c b/tools/lkl/lib/virtio_net_raw.c
new file mode 100644
index 000000000000..363ccf628569
--- /dev/null
+++ b/tools/lkl/lib/virtio_net_raw.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * raw socket based virtual network interface feature for LKL
+ * Copyright (c) 2015,2016 Ryo Nakamura, Hajime Tazaki
+ *
+ * Author: Ryo Nakamura <upa@wide.ad.jp>
+ *         Hajime Tazaki <thehajime@gmail.com>
+ *
+ * Current implementation is linux-specific.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <net/if.h>
+#include <arpa/inet.h>
+#ifdef __linux__
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#elif __FreeBSD__
+#include <netinet/in.h>
+#endif
+#include <fcntl.h>
+
+#include "virtio.h"
+#include "virtio_net_fd.h"
+
+/* since Linux 3.14 (man 7 packet) */
+#ifndef PACKET_QDISC_BYPASS
+#define PACKET_QDISC_BYPASS 20
+#endif
+
+struct lkl_netdev *lkl_netdev_raw_create(const char *ifname)
+{
+#ifdef __linux__
+	int ret;
+	int ifindex =  if_nametoindex(ifname);
+	struct sockaddr_ll ll = {
+		.sll_family = PF_PACKET,
+		.sll_ifindex = ifindex,
+		.sll_protocol = htons(ETH_P_ALL),
+	};
+	struct packet_mreq mreq = {
+		.mr_type = PACKET_MR_PROMISC,
+		.mr_ifindex = ifindex,
+	};
+#endif
+	int fd, fd_flags;
+#ifdef __linux__
+	int val;
+
+	if (ifindex < 0) {
+		perror("if_nametoindex");
+		return NULL;
+	}
+
+	fd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+#elif __FreeBSD__
+	fd = socket(AF_INET, SOCK_RAW, IPPROTO_RAW);
+#endif
+	if (fd < 0) {
+		perror("socket");
+		return NULL;
+	}
+
+#ifdef __linux__
+	ret = bind(fd, (struct sockaddr *)&ll, sizeof(ll));
+	if (ret) {
+		perror("bind");
+		close(fd);
+		return NULL;
+	}
+
+	ret = setsockopt(fd, SOL_PACKET, PACKET_ADD_MEMBERSHIP, &mreq,
+			sizeof(mreq));
+	if (ret) {
+		perror("PACKET_ADD_MEMBERSHIP PACKET_MR_PROMISC");
+		close(fd);
+		return NULL;
+	}
+
+	val = 1;
+	ret = setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &val,
+			 sizeof(val));
+	if (ret)
+		perror("PACKET_QDISC_BYPASS, ignoring");
+#endif
+
+	fd_flags = fcntl(fd, F_GETFD, NULL);
+	fcntl(fd, F_SETFL, fd_flags | O_NONBLOCK);
+
+	return lkl_register_netdev_fd(fd, fd);
+}
diff --git a/tools/lkl/lib/virtio_net_tap.c b/tools/lkl/lib/virtio_net_tap.c
new file mode 100644
index 000000000000..f1f64cee9695
--- /dev/null
+++ b/tools/lkl/lib/virtio_net_tap.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tun/tap based virtual network interface feature for LKL
+ * Copyright (c) 2015,2016 Ryo Nakamura, Hajime Tazaki
+ *
+ * Author: Ryo Nakamura <upa@wide.ad.jp>
+ *         Hajime Tazaki <thehajime@gmail.com>
+ *         Octavian Purdila <octavian.purdila@intel.com>
+ *
+ * Current implementation is linux-specific.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <fcntl.h>
+#include <net/if.h>
+#ifdef __linux__
+#include <linux/if_tun.h>
+#elif __FreeBSD__
+#include <net/if_tun.h>
+#endif
+#include <sys/ioctl.h>
+
+#include "virtio.h"
+#include "virtio_net_fd.h"
+
+#define BIT(x) (1ULL << x)
+
+struct lkl_netdev *lkl_netdev_tap_init(const char *path, int offload,
+				       struct ifreq *ifr)
+{
+	struct lkl_netdev *nd;
+	int fd, vnet_hdr_sz = 0;
+#ifdef __linux__
+	int ret, tap_arg = 0;
+
+	if (offload & BIT(LKL_VIRTIO_NET_F_GUEST_CSUM))
+		tap_arg |= TUN_F_CSUM;
+	if (offload & (BIT(LKL_VIRTIO_NET_F_GUEST_TSO4) |
+	    BIT(LKL_VIRTIO_NET_F_MRG_RXBUF)))
+		tap_arg |= TUN_F_TSO4 | TUN_F_CSUM;
+	if (offload & (BIT(LKL_VIRTIO_NET_F_GUEST_TSO6)))
+		tap_arg |= TUN_F_TSO6 | TUN_F_CSUM;
+
+	if (tap_arg || (offload & (BIT(LKL_VIRTIO_NET_F_CSUM) |
+				   BIT(LKL_VIRTIO_NET_F_HOST_TSO4) |
+				   BIT(LKL_VIRTIO_NET_F_HOST_TSO6)))) {
+		ifr->ifr_flags |= IFF_VNET_HDR;
+		vnet_hdr_sz = sizeof(struct lkl_virtio_net_hdr_v1);
+	}
+#endif
+	fd = open(path, O_RDWR|O_NONBLOCK);
+	if (fd < 0) {
+		perror("open");
+		return NULL;
+	}
+
+#ifdef __linux__
+	ret = ioctl(fd, TUNSETIFF, ifr);
+	if (ret < 0) {
+		fprintf(stderr, "%s: failed to attach to: %s\n",
+			path, strerror(errno));
+		close(fd);
+		return NULL;
+	}
+	if (vnet_hdr_sz && ioctl(fd, TUNSETVNETHDRSZ, &vnet_hdr_sz) != 0) {
+		fprintf(stderr, "%s: failed to TUNSETVNETHDRSZ to: %s\n",
+			path, strerror(errno));
+		close(fd);
+		return NULL;
+	}
+	if (ioctl(fd, TUNSETOFFLOAD, tap_arg) != 0) {
+		fprintf(stderr, "%s: failed to TUNSETOFFLOAD: %s\n",
+			path, strerror(errno));
+		close(fd);
+		return NULL;
+	}
+#endif
+	nd = lkl_register_netdev_fd(fd, fd);
+	if (!nd) {
+		perror("failed to register to.");
+		close(fd);
+		return NULL;
+	}
+
+	nd->has_vnet_hdr = (vnet_hdr_sz != 0);
+	return nd;
+}
+
+struct lkl_netdev *lkl_netdev_tap_create(const char *ifname, int offload)
+{
+#ifdef __linux__
+	char *path = "/dev/net/tun";
+#elif __FreeBSD__
+	char path[32];
+
+	sprintf(path, "/dev/%s", ifname);
+#endif
+
+	struct ifreq ifr = {
+#ifdef __linux__
+		.ifr_flags = IFF_TAP | IFF_NO_PI,
+#endif
+	};
+
+	strncpy(ifr.ifr_name, ifname, IFNAMSIZ);
+
+	return lkl_netdev_tap_init(path, offload, &ifr);
+}
diff --git a/tools/lkl/lib/virtio_net_vde.c b/tools/lkl/lib/virtio_net_vde.c
new file mode 100644
index 000000000000..1d017aba91ae
--- /dev/null
+++ b/tools/lkl/lib/virtio_net_vde.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <poll.h>
+#include <lkl.h>
+#include <lkl_host.h>
+
+#include "virtio.h"
+
+#include <libvdeplug.h>
+
+struct lkl_netdev_vde {
+	struct lkl_netdev dev;
+	VDECONN *conn;
+};
+
+struct lkl_netdev *nuse_vif_vde_create(char *switch_path);
+static int net_vde_tx(struct lkl_netdev *nd, struct iovec *iov, int cnt);
+static int net_vde_rx(struct lkl_netdev *nd, struct iovec *iov, int cnt);
+static int net_vde_poll_with_timeout(struct lkl_netdev *nd, int timeout);
+static int net_vde_poll(struct lkl_netdev *nd);
+static void net_vde_poll_hup(struct lkl_netdev *nd);
+static void net_vde_free(struct lkl_netdev *nd);
+
+struct lkl_dev_net_ops vde_net_ops = {
+	.tx = net_vde_tx,
+	.rx = net_vde_rx,
+	.poll = net_vde_poll,
+	.poll_hup = net_vde_poll_hup,
+	.free = net_vde_free,
+};
+
+int net_vde_tx(struct lkl_netdev *nd, struct iovec *iov, int cnt)
+{
+	int ret;
+	struct lkl_netdev_vde *nd_vde =
+		container_of(nd, struct lkl_netdev_vde, dev);
+	void *data = iov[0].iov_base;
+	int len = (int)iov[0].iov_len;
+
+	ret = vde_send(nd_vde->conn, data, len, 0);
+	if (ret <= 0 && errno == EAGAIN)
+		return -1;
+	return ret;
+}
+
+int net_vde_rx(struct lkl_netdev *nd, struct iovec *iov, int cnt)
+{
+	int ret;
+	struct lkl_netdev_vde *nd_vde =
+		container_of(nd, struct lkl_netdev_vde, dev);
+	void *data = iov[0].iov_base;
+	int len = (int)iov[0].iov_len;
+
+	/*
+	 * Due to a bug in libvdeplug we have to first poll to make sure
+	 * that there is data available.
+	 * The correct solution would be to just use
+	 *   ret = vde_recv(nd_vde->conn, data, len, MSG_DONTWAIT);
+	 * This should be changed once libvdeplug is fixed.
+	 */
+	ret = 0;
+	if (net_vde_poll_with_timeout(nd, 0) & LKL_DEV_NET_POLL_RX)
+		ret = vde_recv(nd_vde->conn, data, len, 0);
+	if (ret <= 0)
+		return -1;
+	return ret;
+}
+
+int net_vde_poll_with_timeout(struct lkl_netdev *nd, int timeout)
+{
+	int ret;
+	struct lkl_netdev_vde *nd_vde =
+		container_of(nd, struct lkl_netdev_vde, dev);
+	struct pollfd pollfds[] = {
+			{
+					.fd = vde_datafd(nd_vde->conn),
+					.events = POLLIN | POLLOUT,
+			},
+			{
+					.fd = vde_ctlfd(nd_vde->conn),
+					.events = POLLHUP | POLLIN
+			}
+	};
+
+	while (poll(pollfds, 2, timeout) < 0 && errno == EINTR)
+		;
+
+	ret = 0;
+
+	if (pollfds[1].revents & (POLLHUP | POLLNVAL | POLLIN))
+		return LKL_DEV_NET_POLL_HUP;
+	if (pollfds[0].revents & (POLLHUP | POLLNVAL))
+		return LKL_DEV_NET_POLL_HUP;
+
+	if (pollfds[0].revents & POLLIN)
+		ret |= LKL_DEV_NET_POLL_RX;
+	if (pollfds[0].revents & POLLOUT)
+		ret |= LKL_DEV_NET_POLL_TX;
+
+	return ret;
+}
+
+int net_vde_poll(struct lkl_netdev *nd)
+{
+	return net_vde_poll_with_timeout(nd, -1);
+}
+
+void net_vde_poll_hup(struct lkl_netdev *nd)
+{
+	struct lkl_netdev_vde *nd_vde =
+		container_of(nd, struct lkl_netdev_vde, dev);
+
+	vde_close(nd_vde->conn);
+}
+
+void net_vde_free(struct lkl_netdev *nd)
+{
+	struct lkl_netdev_vde *nd_vde =
+		container_of(nd, struct lkl_netdev_vde, dev);
+
+	free(nd_vde);
+}
+
+struct lkl_netdev *lkl_netdev_vde_create(char const *switch_path)
+{
+	struct lkl_netdev_vde *nd;
+	struct vde_open_args open_args = {.port = 0, .group = 0, .mode = 0700 };
+	char *switch_path_copy = 0;
+
+	nd = malloc(sizeof(*nd));
+	if (!nd) {
+		fprintf(stderr, "Failed to allocate memory.\n");
+		/* TODO: propagate the error state, maybe use errno? */
+		return 0;
+	}
+	nd->dev.ops = &vde_net_ops;
+
+	/* vde_open() allows the null pointer as path which means
+	 * "VDE default path"
+	 */
+	if (switch_path != 0) {
+		/* vde_open() takes a non-const char * which is a bug in their
+		 * function declaration. Even though the implementation does not
+		 * modify the string, we shouldn't just cast away the const.
+		 */
+		size_t switch_path_length = strlen(switch_path);
+
+		switch_path_copy = calloc(switch_path_length + 1, sizeof(char));
+		if (!switch_path_copy) {
+			fprintf(stderr, "Failed to allocate memory.\n");
+			/* TODO: propagate the error state, maybe use errno? */
+			return 0;
+		}
+		strncpy(switch_path_copy, switch_path, switch_path_length);
+	}
+	nd->conn = vde_open(switch_path_copy, "lkl-virtio-net", &open_args);
+	free(switch_path_copy);
+	if (nd->conn == 0) {
+		fprintf(stderr, "Failed to connect to vde switch.\n");
+		/* TODO: propagate the error state, maybe use errno? */
+		return 0;
+	}
+
+	return &nd->dev;
+}
diff --git a/tools/lkl/tests/net-setup.sh b/tools/lkl/tests/net-setup.sh
new file mode 100644
index 000000000000..cc260ed68a7b
--- /dev/null
+++ b/tools/lkl/tests/net-setup.sh
@@ -0,0 +1,134 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+TEST_TAP_IFNAME=tap
+else
+TEST_TAP_IFNAME=lkl_test_tap
+fi
+TEST_IP_NETWORK=192.168.113.0
+TEST_IP_NETMASK=24
+TEST_IP6_NETWORK=fc03::0
+TEST_IP6_NETMASK=64
+TEST_MAC0="aa:bb:cc:dd:ee:ff"
+TEST_MAC1="aa:bb:cc:dd:ee:aa"
+TEST_NETSERVER_PORT=11223
+
+# $1 - count
+# $2 - netcount
+ip_add()
+{
+    IP_HEX=$(printf '%.2X%.2X%.2X%.2X\n' \
+         `echo $TEST_IP_NETWORK | sed -e 's/\./ /g'`)
+    NET_COUNT=$(( 1 << (32 - $TEST_IP_NETMASK) ))
+    NEXT_IP_HEX=$(printf %.8X `echo $((0x$IP_HEX + $1 + ${2:-0} * $NET_COUNT))`)
+    NEXT_IP=$(printf '%d.%d.%d.%d\n' \
+          `echo $NEXT_IP_HEX | sed -r 's/(..)/0x\1 /g'`)
+    echo -n "$NEXT_IP"
+}
+
+# $1 - count
+# $2 - netcount
+ip6_add()
+{
+    IP6_PREFIX=${TEST_IP6_NETWORK%*::*}
+    IP6_HOST=${TEST_IP6_NETWORK#*::*}
+    echo -n "$(printf "%x" $((0x$IP6_PREFIX+${2:-0})))::$(($IP6_HOST+$1))"
+}
+
+ip_host()
+{
+
+    ip_add 1 $1
+}
+
+ip_lkl()
+{
+    ip_add 2 $1
+}
+
+ip_host_mask()
+{
+    echo -n "$(ip_host $1)/$TEST_IP_NETMASK"
+}
+
+ip_net_mask()
+{
+    echo "$(ip_add 0 $1)/$TEST_IP_NETMASK"
+}
+
+ip6_host()
+{
+    ip6_add 1 $1
+}
+
+ip6_lkl()
+{
+    ip6_add 2 $1
+}
+
+ip6_host_mask()
+{
+    echo -n "$(ip6_host $1)/$TEST_IP6_NETMASK"
+}
+
+ip6_net_mask()
+{
+    echo "$(ip6_add 0 $1)/$TEST_IP6_NETMASK"
+}
+
+tap_ifname()
+{
+    echo -n "$TEST_TAP_IFNAME${1:-0}"
+}
+
+tap_prepare()
+{
+    if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+        if ! lkl_test_cmd test -d /dev/net &>/dev/null; then
+            lkl_test_cmd sudo mkdir /dev/net
+            lkl_test_cmd sudo ln -s /dev/tun /dev/net/tun
+        fi
+        TAP_USER="vpn"
+        ANDROID_USER="vpn,vpn,net_admin,inet"
+        export_vars ANDROID_USER
+    else
+        TAP_USER=$USER
+    fi
+}
+
+tap_setup()
+{
+    if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+        lkl_test_cmd sudo ifconfig tap create
+        lkl_test_cmd sudo sysctl net.link.tap.up_on_open=1
+        lkl_test_cmd sudo sysctl net.link.tap.user_open=1
+        lkl_test_cmd sudo ifconfig $(tap_ifname) $(ip_host)
+        lkl_test_cmd sudo ifconfig $(tap_ifname) inet6 $(ip6_host)
+        return
+    fi
+
+    lkl_test_cmd sudo ip tuntap add dev $(tap_ifname $1) mode tap user $TAP_USER
+    lkl_test_cmd sudo ip link set dev $(tap_ifname $1) up
+    lkl_test_cmd sudo ip addr add dev $(tap_ifname $1) $(ip_host_mask $1)
+    lkl_test_cmd sudo ip -6 addr add dev $(tap_ifname $1) $(ip6_host_mask $1)
+
+    if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+        lkl_test_cmd sudo ip route add $(ip_net_mask $1) \
+                     dev $(tap_ifname $1) proto kernel scope link \
+                     src $(ip_host $1) table local
+        lkl_test_cmd sudo ip -6 route add $(ip6_net_mask $1) \
+                     dev $(tap_ifname $1) table local
+    fi
+}
+
+tap_cleanup()
+{
+    if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+        lkl_test_cmd sudo ifconfig $(tap_ifname) destroy
+        return
+    fi
+
+    lkl_test_cmd sudo ip link set dev $(tap_ifname $1) down
+    lkl_test_cmd sudo ip tuntap del dev $(tap_ifname $1) mode tap
+}
diff --git a/tools/lkl/tests/net-test.c b/tools/lkl/tests/net-test.c
new file mode 100644
index 000000000000..d2fd19f1b995
--- /dev/null
+++ b/tools/lkl/tests/net-test.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#ifdef __FreeBSD__
+#include <sys/types.h>
+#endif
+#ifdef __MINGW32__
+#include <winsock2.h>
+#else
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#endif
+
+#include <lkl.h>
+#include <lkl_host.h>
+
+#include "cla.h"
+#include "test.h"
+
+enum {
+	BACKEND_TAP,
+	BACKEND_MACVTAP,
+	BACKEND_RAW,
+	BACKEND_DPDK,
+	BACKEND_PIPE,
+	BACKEND_NONE,
+};
+
+const char *backends[] = { "tap", "macvtap", "raw", "dpdk", "pipe", "loopback",
+			   NULL };
+static struct {
+	int backend;
+	const char *ifname;
+	int dhcp, nmlen;
+	unsigned int ip, dst, gateway, sleep;
+} cla = {
+	.backend = BACKEND_NONE,
+	.ip = INADDR_NONE,
+	.gateway = INADDR_NONE,
+	.dst = INADDR_NONE,
+	.sleep = 0,
+};
+
+
+struct cl_arg args[] = {
+	{"backend", 'b', "network backend type", 1, CL_ARG_STR_SET,
+	 &cla.backend, backends},
+	{"ifname", 'i', "interface name", 1, CL_ARG_STR, &cla.ifname},
+	{"dhcp", 'd', "use dhcp to configure LKL", 0, CL_ARG_BOOL, &cla.dhcp},
+	{"ip", 'I', "IPv4 address to use", 1, CL_ARG_IPV4, &cla.ip},
+	{"netmask-len", 'n', "IPv4 netmask length", 1, CL_ARG_INT,
+	 &cla.nmlen},
+	{"gateway", 'g', "IPv4 gateway to use", 1, CL_ARG_IPV4, &cla.gateway},
+	{"dst", 'D', "IPv4 destination address", 1, CL_ARG_IPV4, &cla.dst},
+	{"sleep", 's', "sleep", 1, CL_ARG_INT, &cla.sleep},
+	{0},
+};
+
+u_short
+in_cksum(const u_short *addr, register int len, u_short csum)
+{
+	int nleft = len;
+	const u_short *w = addr;
+	u_short answer;
+	int sum = csum;
+
+	while (nleft > 1)  {
+		sum += *w++;
+		nleft -= 2;
+	}
+
+	if (nleft == 1)
+		sum += htons(*(u_char *)w << 8);
+
+	sum = (sum >> 16) + (sum & 0xffff);
+	sum += (sum >> 16);
+	answer = ~sum;
+	return answer;
+}
+
+static int lkl_test_sleep(void)
+{
+	struct lkl_timespec ts = {
+		.tv_sec = cla.sleep,
+	};
+	int ret;
+
+	ret = lkl_sys_nanosleep((struct __lkl__kernel_timespec *)&ts, NULL);
+	if (ret < 0) {
+		lkl_test_logf("nanosleep error: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int lkl_test_icmp(void)
+{
+	int sock, ret;
+	struct lkl_iphdr *iph;
+	struct lkl_icmphdr *icmp;
+	struct lkl_sockaddr_in saddr;
+	struct lkl_pollfd pfd;
+	char buf[32];
+
+	if (cla.dst == INADDR_NONE)
+		return TEST_SKIP;
+
+	memset(&saddr, 0, sizeof(saddr));
+	saddr.sin_family = AF_INET;
+	saddr.sin_addr.lkl_s_addr = cla.dst;
+
+	lkl_test_logf("pinging %s\n",
+		      inet_ntoa(*(struct in_addr *)&saddr.sin_addr));
+
+	sock = lkl_sys_socket(LKL_AF_INET, LKL_SOCK_RAW, LKL_IPPROTO_ICMP);
+	if (sock < 0) {
+		lkl_test_logf("socket error (%s)\n", lkl_strerror(sock));
+		return TEST_FAILURE;
+	}
+
+	icmp = malloc(sizeof(struct lkl_icmphdr *));
+	icmp->type = LKL_ICMP_ECHO;
+	icmp->code = 0;
+	icmp->checksum = 0;
+	icmp->un.echo.sequence = 0;
+	icmp->un.echo.id = 0;
+	icmp->checksum = in_cksum((u_short *)icmp, sizeof(*icmp), 0);
+
+	ret = lkl_sys_sendto(sock, icmp, sizeof(*icmp), 0,
+			     (struct lkl_sockaddr *)&saddr,
+			     sizeof(saddr));
+	if (ret < 0) {
+		lkl_test_logf("sendto error (%s)\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	free(icmp);
+
+	pfd.fd = sock;
+	pfd.events = LKL_POLLIN;
+	pfd.revents = 0;
+
+	ret = lkl_sys_poll(&pfd, 1, 1000);
+	if (ret < 0) {
+		lkl_test_logf("poll error (%s)\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_sys_recv(sock, buf, sizeof(buf), LKL_MSG_DONTWAIT);
+	if (ret < 0) {
+		lkl_test_logf("recv error (%s)\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	iph = (struct lkl_iphdr *)buf;
+	icmp = (struct lkl_icmphdr *)(buf + iph->ihl * 4);
+	/* DHCP server may issue an ICMP echo request to a dhcp client */
+	if ((icmp->type != LKL_ICMP_ECHOREPLY || icmp->code != 0) &&
+	    (icmp->type != LKL_ICMP_ECHO)) {
+		lkl_test_logf("no ICMP echo reply (type=%d, code=%d)\n",
+			      icmp->type, icmp->code);
+		return TEST_FAILURE;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static struct lkl_netdev *nd;
+
+static int lkl_test_nd_create(void)
+{
+	switch (cla.backend) {
+	case BACKEND_NONE:
+		return TEST_SKIP;
+	case BACKEND_TAP:
+		nd = lkl_netdev_tap_create(cla.ifname, 0);
+		break;
+	case BACKEND_DPDK:
+		nd = lkl_netdev_dpdk_create(cla.ifname, 0, NULL);
+		break;
+	case BACKEND_RAW:
+		nd = lkl_netdev_raw_create(cla.ifname);
+		break;
+	case BACKEND_MACVTAP:
+		nd = lkl_netdev_macvtap_create(cla.ifname, 0);
+		break;
+	case BACKEND_PIPE:
+		nd = lkl_netdev_pipe_create(cla.ifname, 0);
+		break;
+	}
+
+	if (!nd) {
+		lkl_test_logf("failed to create netdev\n");
+		return TEST_BAILOUT;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int nd_id;
+
+static int lkl_test_nd_add(void)
+{
+	if (cla.backend == BACKEND_NONE)
+		return TEST_SKIP;
+
+	nd_id = lkl_netdev_add(nd, NULL);
+	if (nd_id < 0) {
+		lkl_test_logf("failed to add netdev: %s\n",
+			      lkl_strerror(nd_id));
+		return TEST_BAILOUT;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int lkl_test_nd_remove(void)
+{
+	if (cla.backend == BACKEND_NONE)
+		return TEST_SKIP;
+
+	lkl_netdev_remove(nd_id);
+	lkl_netdev_free(nd);
+	return TEST_SUCCESS;
+}
+
+LKL_TEST_CALL(start_kernel, lkl_start_kernel, 0, &lkl_host_ops,
+	"mem=16M loglevel=8 %s", cla.dhcp ? "ip=dhcp" : "");
+LKL_TEST_CALL(stop_kernel, lkl_sys_halt, 0);
+
+static int nd_ifindex;
+
+static int lkl_test_nd_ifindex(void)
+{
+	if (cla.backend == BACKEND_NONE)
+		return TEST_SKIP;
+
+	nd_ifindex = lkl_netdev_get_ifindex(nd_id);
+	if (nd_ifindex < 0) {
+		lkl_test_logf("failed to get ifindex for netdev id %d: %s\n",
+			      nd_id, lkl_strerror(nd_ifindex));
+		return TEST_BAILOUT;
+	}
+
+	return TEST_SUCCESS;
+}
+
+LKL_TEST_CALL(if_up, lkl_if_up, 0,
+	      cla.backend == BACKEND_NONE ? 1 : nd_ifindex);
+
+static int lkl_test_set_ipv4(void)
+{
+	int ret;
+
+	if (cla.backend == BACKEND_NONE || cla.ip == LKL_INADDR_NONE)
+		return TEST_SKIP;
+
+	ret = lkl_if_set_ipv4(nd_ifindex, cla.ip, cla.nmlen);
+	if (ret < 0) {
+		lkl_test_logf("failed to set IPv4 address: %s\n",
+			      lkl_strerror(ret));
+		return TEST_BAILOUT;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int lkl_test_set_gateway(void)
+{
+	int ret;
+
+	if (cla.backend == BACKEND_NONE || cla.gateway == LKL_INADDR_NONE)
+		return TEST_SKIP;
+
+	ret = lkl_set_ipv4_gateway(cla.gateway);
+	if (ret < 0) {
+		lkl_test_logf("failed to set IPv4 gateway: %s\n",
+			      lkl_strerror(ret));
+		return TEST_BAILOUT;
+	}
+
+	return TEST_SUCCESS;
+}
+
+struct lkl_test tests[] = {
+	LKL_TEST(nd_create),
+	LKL_TEST(nd_add),
+	LKL_TEST(start_kernel),
+	LKL_TEST(nd_ifindex),
+	LKL_TEST(if_up),
+	LKL_TEST(set_ipv4),
+	LKL_TEST(set_gateway),
+	LKL_TEST(sleep),
+	LKL_TEST(icmp),
+	LKL_TEST(nd_remove),
+	LKL_TEST(stop_kernel),
+};
+
+int main(int argc, const char **argv)
+{
+	if (parse_args(argc, argv, args) < 0)
+		return -1;
+
+	if (cla.ip != LKL_INADDR_NONE && (cla.nmlen < 0 || cla.nmlen > 32)) {
+		fprintf(stderr, "invalid netmask length %d\n", cla.nmlen);
+		return -1;
+	}
+
+	lkl_host_ops.print = lkl_test_log;
+
+	return lkl_test_run(tests, sizeof(tests)/sizeof(struct lkl_test),
+			    "net %s", backends[cla.backend]);
+}
diff --git a/tools/lkl/tests/net.sh b/tools/lkl/tests/net.sh
new file mode 100755
index 000000000000..cd8de53fe0fd
--- /dev/null
+++ b/tools/lkl/tests/net.sh
@@ -0,0 +1,186 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+
+source $script_dir/test.sh
+source $script_dir/net-setup.sh
+
+cleanup_backend()
+{
+    set -e
+
+    case "$1" in
+    "tap")
+        tap_cleanup
+        ;;
+    "pipe")
+        rm -rf $work_dir
+        ;;
+    "raw")
+        ;;
+    "macvtap")
+        sudo ip link del dev $(tap_ifname) type macvtap
+        ;;
+    "loopback")
+        ;;
+    esac
+}
+
+get_test_ip()
+{
+    # DHCP test parameters
+    TEST_HOST=8.8.8.8
+    HOST_IF=$(lkl_test_cmd ip route get $TEST_HOST | head -n1 |cut -d ' ' -f5)
+    HOST_GW=$(lkl_test_cmd ip route get $TEST_HOST | head -n1 | cut -d ' ' -f3)
+    if lkl_test_cmd ping -c1 -w1 $HOST_GW; then
+        TEST_IP_REMOTE=$HOST_GW
+    elif lkl_test_cmd ping -c1 -w1 $TEST_HOST; then
+        TEST_IP_REMOTE=$TEST_HOST
+    else
+        echo "could not find remote test ip"
+        return $TEST_SKIP
+    fi
+
+    export_vars HOST_IF TEST_IP_REMOTE
+}
+
+setup_backend()
+{
+    set -e
+
+    if [ "$LKL_HOST_CONFIG_POSIX" != "y" ] &&
+       [ "$1" != "loopback" ]; then
+        echo "not a posix environment"
+        return $TEST_SKIP
+    fi
+
+    case "$1" in
+    "loopback")
+        ;;
+    "pipe")
+        if [ -z $(lkl_test_cmd which mkfifo) ]; then
+            echo "no mkfifo command"
+            return $TEST_SKIP
+        else
+            work_dir=$(lkl_test_cmd mktemp -d)
+        fi
+        fifo1=$work_dir/fifo1
+        fifo2=$work_dir/fifo2
+        lkl_test_cmd mkfifo $fifo1
+        lkl_test_cmd mkfifo $fifo2
+        export_vars work_dir fifo1 fifo2
+        ;;
+    "tap")
+        tap_prepare
+        if ! lkl_test_cmd test -c /dev/net/tun; then
+            if [ -z "$LKL_HOST_CONFIG_BSD" ]; then
+                echo "missing /dev/net/tun"
+                return $TEST_SKIP
+            fi
+        fi
+        tap_setup
+        ;;
+    "raw")
+        if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+            return $TEST_SKIP
+        fi
+        get_test_ip
+        ;;
+    "macvtap")
+        get_test_ip
+        if ! lkl_test_cmd sudo ip link add link $HOST_IF \
+             name $(tap_ifname) type macvtap mode passthru; then
+            echo "failed to create macvtap, skipping"
+            return $TEST_SKIP
+        fi
+        MACVTAP=/dev/tap$(lkl_test_cmd ip link show dev $(tap_ifname) | \
+                                 grep -o ^[0-9]*)
+        lkl_test_cmd sudo ip link set dev $(tap_ifname) up
+        lkl_test_cmd sudo chown $USER $MACVTAP
+        export_vars MACVTAP
+        ;;
+    "dpdk")
+        if -z [ $LKL_TEST_NET_DPDK ]; then
+            echo "DPDK needs user setup"
+            return $TEST_SKIP
+        fi
+        ;;
+    *)
+        echo "don't know how to setup backend $1"
+        return $TEST_FAILED
+        ;;
+    esac
+}
+
+run_tests()
+{
+    case "$1" in
+    "loopback")
+        lkl_test_exec $script_dir/net-test --dst 127.0.0.1
+        ;;
+    "pipe")
+        VALGRIND="" lkl_test_exec $script_dir/net-test --backend pipe \
+                      --ifname "$fifo1|$fifo2" \
+                      --ip $(ip_host) --netmask-len $TEST_IP_NETMASK \
+                      --sleep 1800 >/dev/null &
+        cp $script_dir/net-test $script_dir/net-test2
+
+        sleep 10
+        lkl_test_exec $script_dir/net-test2 --backend pipe \
+                      --ifname "$fifo2|$fifo1" \
+                      --ip $(ip_lkl) --netmask-len $TEST_IP_NETMASK \
+                      --dst $(ip_host)
+        rm -f $script_dir/net-test2
+        kill $!
+        wait $! 2>/dev/null
+        ;;
+    "tap")
+        lkl_test_exec $script_dir/net-test --backend tap \
+                      --ifname $(tap_ifname) \
+                      --ip $(ip_lkl) --netmask-len $TEST_IP_NETMASK \
+                      --dst $(ip_host)
+        ;;
+    "raw")
+        lkl_test_exec sudo $script_dir/net-test --backend raw \
+                      --ifname $HOST_IF --dhcp --dst $TEST_IP_REMOTE
+        ;;
+    "macvtap")
+        lkl_test_exec $script_dir/net-test --backend macvtap \
+                      --ifname $MACVTAP \
+                      --dhcp --dst $TEST_IP_REMOTE
+        ;;
+    "dpdk")
+        lkl_test_exec sudo $script_dir/net-test --backend dpdk \
+                      --ifname dpdk0 \
+                      --ip $(ip_lkl) --netmask-len $TEST_IP_NETMASK \
+                      --dst $(ip_host)
+        ;;
+    esac
+}
+
+if [ "$1" = "-b" ]; then
+    shift
+    backend=$1
+    shift
+fi
+
+if [ -z "$backend" ]; then
+    backend="loopback"
+fi
+
+lkl_test_plan 1 "net $backend"
+lkl_test_run 1 setup_backend $backend
+
+if [ $? = $TEST_SKIP ]; then
+    exit 0
+fi
+
+trap "cleanup_backend $backend" EXIT
+
+run_tests $backend
+
+trap : EXIT
+lkl_test_plan 1 "net $backend"
+lkl_test_run 1 cleanup_backend $backend
+
-- 
2.20.1 (Apple Git-117)

