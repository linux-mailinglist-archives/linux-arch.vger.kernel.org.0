Return-Path: <linux-arch+bounces-15335-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3A2CB4AD1
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 05:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58DB73008F8B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 04:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B7E1E5B63;
	Thu, 11 Dec 2025 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzEXc4tx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D771990C7;
	Thu, 11 Dec 2025 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765427225; cv=none; b=QHNCyTvVXT7UTLbgYUtLC77lN7KDcGIqhlRgJ/lEYN1BkMaJS52vfrsUSBJZRRCdsuqyeTZmDf7kcIZpVhWGN3aZPBBLjTo/3LH4aPKoGVDphFE2dEBxwFZAfDIzTgYLe5LE7pXd0AzjU2Su91KajW81LOGWYv+XIPJ+yfHIdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765427225; c=relaxed/simple;
	bh=xpkKIG9FMryb6P12ow/DNTd5Jc1/Y/mhnvtHiSrrxfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUeHpxs5471muL4WyQFwXm6lxaZs22DJjmhIUX3tL3UA+ch0zn3KVk8G+Lu6JFO6z6nvwxzKZ7j3uvnUH0/T60hvvvg6UfGgudETvpxLXKqwLtED3mf+N8SpGNgXygL0Q2D4n6zGHJNtSHuraBvmykZ5dMp2ye64TOry4IrvE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzEXc4tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B448EC4CEFB;
	Thu, 11 Dec 2025 04:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765427224;
	bh=xpkKIG9FMryb6P12ow/DNTd5Jc1/Y/mhnvtHiSrrxfc=;
	h=From:To:Cc:Subject:Date:From;
	b=TzEXc4txHsbtptaVuuDDJvsSdK4q9CA+1T++9wgdK60nWiPaodxe5xZuV5yE45TC6
	 LdMueM5iAF+Lx4gkH87EUZmBc/+Czs4gTzcgeX/I15yhBL4njM9duiE2JOpTT3K55v
	 Lv7Ty2KdcASnmjbhnDmIeJzrESlF+VyPQ3cjQ5AS4ELsoSI9VWJutjgmXV0VBmV0qC
	 g91EjdDdlGA1v5EIj+wVhQtl6r0BH/ubL+vyKT2Wh1zTM+C2SURNGc6yDMORqXbSvt
	 bK37cHL0bnYdxlw3vO14L4LQLZnF5X5OUPfnKAL7ttBQZoJJ+1WxzPG1y0NCEXdv9+
	 7o3TjfsdRNHyw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Miu <jasonmiu@google.com>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: [RFC PATCH] liveupdate: list all file handler versions in vmlinux section
Date: Thu, 11 Dec 2025 13:26:22 +0900
Message-ID: <20251211042624.175517-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As live update evolves, there will be a need to update the serialization
formats for the different file types. This could be for adding new
features, for supporting a change in behaviour, or to fix bugs.

If the current kernel does not understand the same set of versions as
the next kernel, live update will inevitably fail. The next kernel will
be unable to understand the handed over data and will be unable to
restore memory, devices, IOMMU page tables, etc.

List the set of versions the kernel understands in a section in vmlinux.
This can then be used by userspace tooling to make sure the set of file
descriptors it uses have the same version between both kernels. If there
is a mismatch, the tooling can catch this early and abort live update
before it is too late.

The versions are listed in a section called ".liveupdate_versions". The
section has a header that contains a magic number and the version of the
data format. The list of version strings directly follow this header.
Only the version strings are listed, and it is up to userspace to map
them to file descriptor types.

The format of the section has the same ABI rules as the rest of LUO ABI.

Introduce a LIVEUPDATE_FILE_HANDLER macro that makes it easy to define a
file handler while also adding its version string to the right section.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    I also wrote a small tool [0] to parse this section and list all the
    versions it contains to demonstrate how it can be used.
    
    This topic will also be discussed at an upcoming session at the Linux
    Plumbers Conference 2025 [1].
    
    [0] https://github.com/prati0100/luo_section_parser
    [1] https://lpc.events/event/19/contributions/2049/

 include/asm-generic/vmlinux.lds.h | 12 +++++++++++
 include/linux/kho/abi/luo.h       | 34 +++++++++++++++++++++++++++++++
 include/linux/liveupdate.h        | 23 +++++++++++++++++++++
 kernel/liveupdate/luo_core.c      | 14 +++++++++++++
 mm/memfd_luo.c                    |  6 ++----
 5 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e04d56a5332e..a474c9529a5f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -342,6 +342,17 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define THERMAL_TABLE(name)
 #endif
 
+#ifdef CONFIG_LIVEUPDATE
+#define LIVEUPDATE_VERSIONS						\
+	. = ALIGN(8);							\
+	.liveupdate_versions : AT(ADDR(.liveupdate_versions) - LOAD_OFFSET) {	\
+		KEEP(*(.liveupdate_sec_hdr))				\
+		KEEP(*(.liveupdate_versions))				\
+	}
+#else
+#define LIVEUPDATE_VERSIONS
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -544,6 +555,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	RO_EXCEPTION_TABLE						\
 	NOTES								\
 	BTF								\
+	LIVEUPDATE_VERSIONS						\
 									\
 	. = ALIGN((align));						\
 	__end_rodata = .;
diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 4a1cc6a5f3f8..57ef75695f62 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -244,4 +244,38 @@ struct luo_flb_ser {
 #define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
 #endif
 
+#define LIVEUPDATE_VER_HDR_MAGIC 0x4c565550 /* 'LVUP' */
+#define LIVEUPDATE_VER_HDR_VER   1
+
+/**
+ * struct liveupdate_ver_hdr - Header of vmlinux section with version lists
+ * @magic:     Magic number.
+ * @version:   Version of the header format.
+ *
+ * This struct is the header for the vmlinux section ".liveupdate_versions". The
+ * section contains the list of file handler versions that the kernel can
+ * support.
+ */
+struct liveupdate_ver_hdr {
+	u32 magic;
+	u32 version;
+};
+
+/**
+ * struct liveupdate_ver_table - Table of file handler versions that the kernel
+ * can support.
+ *
+ * @hdr:        Table header.
+ * @versions:   List of versions the kernel supports. The strings ate
+ *              NUL-terminated, but to keep the format simpler always take up
+ *              LIVEUPDATE_HNDL_COMPAT_LENGTH bytes.
+ *
+ * The list of versions immediately follows the header. The number of versions
+ * are determined by section length.
+ */
+struct liveupdate_ver_table {
+	struct liveupdate_ver_hdr hdr;
+	char versions[][LIVEUPDATE_HNDL_COMPAT_LENGTH];
+};
+
 #endif /* _LINUX_KHO_ABI_LUO_H */
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index ed81e7b31a9f..5a8305595fe5 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -212,6 +212,29 @@ struct liveupdate_flb {
 	struct luo_flb_private __private private;
 };
 
+#define LIVEUPDATE_SEC_VERSION(_name, _ver)				\
+	static const char __ ## _name ## _vers[LIVEUPDATE_HNDL_COMPAT_LENGTH] \
+	__used __section(".liveupdate_versions")			\
+	__aligned(1) = _ver
+
+/**
+ * LIVEUPDATE_FILE_HANDLER - Define a live update file handler.
+ * @_name:        The name for the variable.
+ * @_compatible:  The compatible string for the file handler.
+ * @ops:          The file handler operations.
+ *
+ * Defines a struct liveupdate_file_handler called _name. It also makes sure the
+ * compatible of the handler gets added to the liveupdate versions section. All
+ * file handler must be defined using this macro.
+ */
+#define LIVEUPDATE_FILE_HANDLER(_name, _compatible, _ops)		\
+	static struct liveupdate_file_handler _name = {\
+		.compatible = _compatible,				\
+		.ops = _ops,						\
+	};								\
+									\
+	LIVEUPDATE_SEC_VERSION(_name, _compatible)
+
 #ifdef CONFIG_LIVEUPDATE
 
 /* Return true if live update orchestrator is enabled */
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 7a9ef16b37d8..f44ed6019367 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -62,6 +62,20 @@
 #include "kexec_handover_internal.h"
 #include "luo_internal.h"
 
+/*
+ * This is the header for the ".liveupdate_versions" section in vmlinux. See
+ * struct liveupdate_ver_table for more info. The linker makes sure that the
+ * this header precedes the compatibles added by LIVEUPDATE_FILE_HANDLER().
+ */
+static const struct liveupdate_ver_hdr ver_hdr
+	__used __section(".liveupdate_sec_hdr") __aligned(8) = {
+	.magic = LIVEUPDATE_VER_HDR_MAGIC,
+	.version = LIVEUPDATE_VER_HDR_VER,
+};
+
+/* Also list the LUO core version. */
+LIVEUPDATE_SEC_VERSION(luo_ver, LUO_FDT_COMPATIBLE);
+
 static struct {
 	bool enabled;
 	void *fdt_out;
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 4f6ba63b4310..23c7f1dd7d8e 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -495,10 +495,8 @@ static const struct liveupdate_file_ops memfd_luo_file_ops = {
 	.owner = THIS_MODULE,
 };
 
-static struct liveupdate_file_handler memfd_luo_handler = {
-	.ops = &memfd_luo_file_ops,
-	.compatible = MEMFD_LUO_FH_COMPATIBLE,
-};
+LIVEUPDATE_FILE_HANDLER(memfd_luo_handler, MEMFD_LUO_FH_COMPATIBLE,
+			&memfd_luo_file_ops);
 
 static int __init memfd_luo_init(void)
 {
-- 
2.43.0


