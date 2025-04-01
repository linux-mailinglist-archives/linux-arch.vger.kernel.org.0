Return-Path: <linux-arch+bounces-11210-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ACAA78492
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 00:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090231891A05
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 22:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E0E21C193;
	Tue,  1 Apr 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvkvCYBq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A021B9F4;
	Tue,  1 Apr 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545783; cv=none; b=fjX4WR16cTdk/IvWf0HpwCxrTXlSuOEZOdUOi4LopmCQYDyaRzRFwYNu3m11hM5tpKdXw00AHSJgUNfcSwPwFNDWh5T8M2jdCYDxm3MMmNyXFCps4PKeLb485kbslNLtgff/IwlMf3AKzRLy96Jn0Ee23La8NyRfp/vowFPftRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545783; c=relaxed/simple;
	bh=e/HAa2tvfjhQYMiNjdV0y5PNY2euM6WIbiBpYzwXq3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tC1oAPzIRLlC3vM2apvr0Z3l4oVFzWN5f7VvT+edOuWaK4D8yLtlJqaLQqkcTBnTdsqxD6k6O7sorduwyh7spzT9Tk/4qqm4b244Pj+lYEugGN3KMBITfY3fIdIQGIaBqKvINBzBu2V6g1pSDxT5uY5ouoM9vPs+on72tf5ybr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvkvCYBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E292EC4CEE9;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743545783;
	bh=e/HAa2tvfjhQYMiNjdV0y5PNY2euM6WIbiBpYzwXq3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvkvCYBq5/lHAMntUQ78b5im+YtXQnq175O/QRx944uBQyFMAo2QYYSe57581EAii
	 vKdOHi4W5whfSZda6aiVbd8KgjTRsVVrDRbpWqy9arlhoj8bdufCfUyzwMsAj7aUXz
	 bfqQtIJQPd6vp7kKC2qQCxx1XicMfzj3iJt9iaFl6nU6sQy3OdCi2e32qvfZ566PVQ
	 qqPgg5AwjshUeAdLkqQ0tB9Py1gYzN6MVw1ceqZeDQFwsFQDv7KPfzWapj0lRxlPTj
	 OO0rrwGl8pPqCV6oievGiV5xkTzx359vrjgSdQxAx9iU6e5WttRU9ZhGWOBVF4GTfa
	 cxoxgwXeVpcRQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 7/7] lib/crc: remove CONFIG_LIBCRC32C
Date: Tue,  1 Apr 2025 15:16:00 -0700
Message-ID: <20250401221600.24878-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401221600.24878-1-ebiggers@kernel.org>
References: <20250401221600.24878-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Now that LIBCRC32C does nothing besides select CRC32, make every option
that selects LIBCRC32C instead select CRC32 directly.  Then remove
LIBCRC32C.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/block/Kconfig                 | 2 +-
 drivers/block/drbd/Kconfig            | 2 +-
 drivers/md/Kconfig                    | 2 +-
 drivers/md/persistent-data/Kconfig    | 2 +-
 drivers/net/ethernet/broadcom/Kconfig | 4 ++--
 drivers/net/ethernet/cavium/Kconfig   | 2 +-
 fs/bcachefs/Kconfig                   | 2 +-
 fs/btrfs/Kconfig                      | 2 +-
 fs/ceph/Kconfig                       | 2 +-
 fs/erofs/Kconfig                      | 2 +-
 fs/gfs2/Kconfig                       | 1 -
 fs/xfs/Kconfig                        | 2 +-
 lib/Kconfig                           | 7 -------
 net/batman-adv/Kconfig                | 2 +-
 net/ceph/Kconfig                      | 2 +-
 net/netfilter/Kconfig                 | 4 ++--
 net/netfilter/ipvs/Kconfig            | 2 +-
 net/openvswitch/Kconfig               | 2 +-
 net/sched/Kconfig                     | 2 +-
 net/sctp/Kconfig                      | 2 +-
 20 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index a97f2c40c640..2551ebf88dda 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -365,11 +365,11 @@ config BLK_DEV_RUST_NULL
 
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
 	depends on INET && BLOCK
 	select CEPH_LIB
-	select LIBCRC32C
+	select CRC32
 	select CRYPTO_AES
 	select CRYPTO
 	help
 	  Say Y here if you want include the Rados block device, which stripes
 	  a block device over objects stored in the Ceph distributed object
diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 6fb4e38fca88..495a72da04c6 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -8,11 +8,11 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
 	depends on PROC_FS && INET
 	select LRU_CACHE
-	select LIBCRC32C
+	select CRC32
 	help
 
 	  NOTE: In order to authenticate connections you have to select
 	  CRYPTO_HMAC and a hash function as well.
 
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 0b1870a09e1f..2c26a02391cd 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -137,11 +137,11 @@ config MD_RAID10
 
 config MD_RAID456
 	tristate "RAID-4/RAID-5/RAID-6 mode"
 	depends on BLK_DEV_MD
 	select RAID6_PQ
-	select LIBCRC32C
+	select CRC32
 	select ASYNC_MEMCPY
 	select ASYNC_XOR
 	select ASYNC_PQ
 	select ASYNC_RAID6_RECOV
 	help
diff --git a/drivers/md/persistent-data/Kconfig b/drivers/md/persistent-data/Kconfig
index f4f948b0e173..dbb97a7233ab 100644
--- a/drivers/md/persistent-data/Kconfig
+++ b/drivers/md/persistent-data/Kconfig
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DM_PERSISTENT_DATA
        tristate
        depends on BLK_DEV_DM
-       select LIBCRC32C
+       select CRC32
        select DM_BUFIO
 	help
 	 Library providing immutable on-disk data structure support for
 	 device-mapper targets such as the thin provisioning target.
 
diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index eeec8bf17cf4..1bd4313215d7 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -141,11 +141,11 @@ config BNX2X
 	tristate "Broadcom NetXtremeII 10Gb support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select FW_LOADER
 	select ZLIB_INFLATE
-	select LIBCRC32C
+	select CRC32
 	select MDIO
 	help
 	  This driver supports Broadcom NetXtremeII 10 gigabit Ethernet cards.
 	  To compile this driver as a module, choose M here: the module
 	  will be called bnx2x.  This is recommended.
@@ -205,11 +205,11 @@ config SYSTEMPORT
 config BNXT
 	tristate "Broadcom NetXtreme-C/E support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select FW_LOADER
-	select LIBCRC32C
+	select CRC32
 	select NET_DEVLINK
 	select PAGE_POOL
 	select DIMLIB
 	select AUXILIARY_BUS
 	help
diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
index ca742cc146d7..7dae5aad3689 100644
--- a/drivers/net/ethernet/cavium/Kconfig
+++ b/drivers/net/ethernet/cavium/Kconfig
@@ -68,12 +68,12 @@ config LIQUIDIO_CORE
 config LIQUIDIO
 	tristate "Cavium LiquidIO support"
 	depends on 64BIT && PCI
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select CRC32
 	select FW_LOADER
-	select LIBCRC32C
 	select LIQUIDIO_CORE
 	select NET_DEVLINK
 	help
 	  This driver supports Cavium LiquidIO Intelligent Server Adapters
 	  based on CN66XX, CN68XX and CN23XX chips.
diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
index c9798750202d..ea668dedb260 100644
--- a/fs/bcachefs/Kconfig
+++ b/fs/bcachefs/Kconfig
@@ -2,11 +2,11 @@
 config BCACHEFS_FS
 	tristate "bcachefs filesystem support (EXPERIMENTAL)"
 	depends on BLOCK
 	select EXPORTFS
 	select CLOSURES
-	select LIBCRC32C
+	select CRC32
 	select CRC64
 	select FS_POSIX_ACL
 	select LZ4_COMPRESS
 	select LZ4_DECOMPRESS
 	select LZ4HC_COMPRESS
diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index fa8515598341..73a2dfb854c5 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
 config BTRFS_FS
 	tristate "Btrfs filesystem support"
 	select BLK_CGROUP_PUNT_BIO
+	select CRC32
 	select CRYPTO
 	select CRYPTO_CRC32C
-	select LIBCRC32C
 	select CRYPTO_XXHASH
 	select CRYPTO_SHA256
 	select CRYPTO_BLAKE2B
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 7249d70e1a43..3e7def3d31c1 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config CEPH_FS
 	tristate "Ceph distributed file system"
 	depends on INET
 	select CEPH_LIB
-	select LIBCRC32C
+	select CRC32
 	select CRYPTO_AES
 	select CRYPTO
 	select NETFS_SUPPORT
 	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
 	default n
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 331e49cd1b8d..8f68ec49ad89 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
+	select CRC32
 	select FS_IOMAP
-	select LIBCRC32C
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
 	  file system with modern designs (e.g. no buffer heads, inline
 	  xattrs/data, chunk-based deduplication, multiple devices, etc.) for
 	  scenarios which need high-performance read-only solutions, e.g.
diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
index be7f87a8e11a..7bd231d16d4a 100644
--- a/fs/gfs2/Kconfig
+++ b/fs/gfs2/Kconfig
@@ -2,11 +2,10 @@
 config GFS2_FS
 	tristate "GFS2 file system support"
 	select BUFFER_HEAD
 	select FS_POSIX_ACL
 	select CRC32
-	select LIBCRC32C
 	select QUOTACTL
 	select FS_IOMAP
 	help
 	  A cluster filesystem.
 
diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index fffd6fffdce0..ae0ca6858496 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config XFS_FS
 	tristate "XFS filesystem support"
 	depends on BLOCK
 	select EXPORTFS
-	select LIBCRC32C
+	select CRC32
 	select FS_IOMAP
 	help
 	  XFS is a high performance journaling filesystem which originated
 	  on the SGI IRIX platform.  It is completely multi-threaded, can
 	  support large files and large filesystems, extended attributes,
diff --git a/lib/Kconfig b/lib/Kconfig
index 4e796eaea2f4..6c1b8f184267 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -206,17 +206,10 @@ config CRC7
 	tristate
 	help
 	  The CRC7 library functions.  Select this if your module uses any of
 	  the functions from <linux/crc7.h>.
 
-config LIBCRC32C
-	tristate
-	select CRC32
-	help
-	  This option just selects CRC32 and is provided for compatibility
-	  purposes until the users are updated to select CRC32 directly.
-
 config CRC8
 	tristate
 	help
 	  The CRC8 library functions.  Select this if your module uses any of
 	  the functions from <linux/crc8.h>.
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 860a0786bc1e..20b316207f9a 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -7,11 +7,11 @@
 # B.A.T.M.A.N meshing protocol
 #
 
 config BATMAN_ADV
 	tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
-	select LIBCRC32C
+	select CRC32
 	help
 	  B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
 	  a routing protocol for multi-hop ad-hoc mesh networks. The
 	  networks may be wired or wireless. See
 	  https://www.open-mesh.org/ for more information and user space
diff --git a/net/ceph/Kconfig b/net/ceph/Kconfig
index c5c4eef3a9ff..0aa21fcbf6ec 100644
--- a/net/ceph/Kconfig
+++ b/net/ceph/Kconfig
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config CEPH_LIB
 	tristate "Ceph core library"
 	depends on INET
-	select LIBCRC32C
+	select CRC32
 	select CRYPTO_AES
 	select CRYPTO_CBC
 	select CRYPTO_GCM
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index df2dc21304ef..047ba81865ed 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -210,11 +210,11 @@ config NF_CT_PROTO_GRE
 
 config NF_CT_PROTO_SCTP
 	bool 'SCTP protocol connection tracking support'
 	depends on NETFILTER_ADVANCED
 	default y
-	select LIBCRC32C
+	select CRC32
 	help
 	  With this option enabled, the layer 3 independent connection
 	  tracking code will be able to do state tracking on SCTP connections.
 
 	  If unsure, say Y.
@@ -473,11 +473,11 @@ config NETFILTER_SYNPROXY
 
 endif # NF_CONNTRACK
 
 config NF_TABLES
 	select NETFILTER_NETLINK
-	select LIBCRC32C
+	select CRC32
 	tristate "Netfilter nf_tables support"
 	help
 	  nftables is the new packet classification framework that intends to
 	  replace the existing {ip,ip6,arp,eb}_tables infrastructure. It
 	  provides a pseudo-state machine with an extensible instruction-set
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 2a3017b9c001..8c5b1fe12d07 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -103,11 +103,11 @@ config	IP_VS_PROTO_AH
 	  This option enables support for load balancing AH (Authentication
 	  Header) transport protocol. Say Y if unsure.
 
 config  IP_VS_PROTO_SCTP
 	bool "SCTP load balancing support"
-	select LIBCRC32C
+	select CRC32
 	help
 	  This option enables support for load balancing SCTP transport
 	  protocol. Say Y if unsure.
 
 comment "IPVS scheduler"
diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index 2535f3f9f462..5481bd561eb4 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -9,11 +9,11 @@ config OPENVSWITCH
 	depends on !NF_CONNTRACK || \
 		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
 				     (!NF_NAT || NF_NAT) && \
 				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
 	depends on PSAMPLE || !PSAMPLE
-	select LIBCRC32C
+	select CRC32
 	select MPLS
 	select NET_MPLS_GSO
 	select DST_CACHE
 	select NET_NSH
 	select NF_CONNTRACK_OVS if NF_CONNTRACK
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 8180d0c12fce..a800127effcd 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -782,11 +782,11 @@ config NET_ACT_SKBEDIT
 	  module will be called act_skbedit.
 
 config NET_ACT_CSUM
 	tristate "Checksum Updating"
 	depends on NET_CLS_ACT && INET
-	select LIBCRC32C
+	select CRC32
 	help
 	  Say Y here to update some common checksum after some direct
 	  packet alterations.
 
 	  To compile this code as a module, choose M here: the
diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index 5da599ff84a9..d18a72df3654 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -5,14 +5,14 @@
 
 menuconfig IP_SCTP
 	tristate "The SCTP Protocol"
 	depends on INET
 	depends on IPV6 || IPV6=n
+	select CRC32
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
-	select LIBCRC32C
 	select NET_UDP_TUNNEL
 	help
 	  Stream Control Transmission Protocol
 
 	  From RFC 2960 <http://www.ietf.org/rfc/rfc2960.txt>.
-- 
2.49.0


