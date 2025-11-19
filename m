Return-Path: <linux-arch+bounces-14922-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8FC6FCCD
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6AA33578CE
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9813358C5;
	Wed, 19 Nov 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyjZVzEc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892452EC0BF
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567127; cv=none; b=fEXA7CGJhJrSEZM5sno7exRP9Z0/PnlGYsZ8LodOmQYzer+pWiA62naLAYjL56D4fb/2CH4mGqUYcbpS+9QX0aKBIqEoSDCGoKvCuCuJN34sQXSp1MVrEc/1NsN9YLUODYtfbakg+2DVCLSilqLthObsy1WF1YID2m48+hNBiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567127; c=relaxed/simple;
	bh=QqY5tRrVi6FWEAug1ZGmtO2F5zShkTvAx5jKQW4Bskg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEsxUtCpQjUeuOVPTssz74qp7xfIQqVSzrgxQFHwGSdZR/Ar57VUE20OAeoIdEuWv0sYs1Pt+nZ+cQonbflAzI4tjPqtKiBN5qz/gcPIfD6NKVu4/i9mKalToxshbdfIifcjqghOhhQvD+00HWmM9RhiRklehemX+PWHm3iCs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jyjZVzEc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so4676814f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567119; x=1764171919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qGk+s0IRVQRO0bT8nLdtgaCkCUOcAGvIaTFPbWEFSY=;
        b=jyjZVzEcYKohC0QlFzh99Knd2x89PWxeRJC6e34e7YPRGB/CS5oTHIcriedZFMgjcy
         97sXsc13kaT8U4/vj9kis+cc4zwbOBbH9cM6VKQw79djrMDg+VXlXlVYLfXiH4PcrI+N
         TR7fmNTfakXu26BBGWBPCzwbZWvbM5LbAYQrzSpxb+lZC1xfn9kDuSk16qY+IaSP5YjY
         L07GSsBbZV9nbiRntUw44xSARc9G7F2qg62E1H17wJTc1Zih7S8Gl//kr18DpYsHebnf
         kXTNbZdAG7hJOh1zXQ5tRG7X9JqgGpqaAoyTkhA84+VsFjk02Jw3sSBDRIshJXjrG8q3
         uwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567119; x=1764171919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7qGk+s0IRVQRO0bT8nLdtgaCkCUOcAGvIaTFPbWEFSY=;
        b=CJpe/hHoV0DpfyfCZu/5MFijXV3f2XoRtTKnmkipQy/FJMlQiqykpi9JgxsMC8s+jx
         BU5ZCJJBTBNQZqWCETDPh8Us8K3O+8zjH9gdRmhPIyFGF+nf/gwiiav37KtkNBnJB2LY
         CThSghk+P7Z1ZL4pjq4IFL+RUfIz5YbbEYAcVAy+1BgHJGYg62PtgmYFt6ApkcsKBDha
         SN9uYHFSxItOy8xb77wZoHKuiT89h/yTNonMP93Dr1qJXgzuniVZdAQPd2h0T9nqfsi0
         u/M9I58jPBHvJqPXedMR7lwyx8Jexc9lw+9CtPp2LdkegoZSVGOnCcgJ1AakrqX2ypIj
         y9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLlZn3uS0YhmAFMmIyo2lxOyhHC7MBSA/24oPE72qEle2VR4sowFuvhlZW5mzHpflF+YBDuYBa1Y8m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jRRg5SLkERFJT8oCBohMAp1cqZm8Vp5mZu2y13qhweytSLr2
	j1O1k/8MA4GTvG4Kh1VUTA9MlLC1eXWSbLWTIKTnd1yfzwpilHTaBcLRi6xc0fDmMW4=
X-Gm-Gg: ASbGncsNnIuyUyBhX7++2RVS2c5lBd+FS9KQpsKThKMaoj5PwufT82flYBFFrfzAOSq
	kcIYq0UL8CiOFBZCrc8v5lhmSt/9No+PyyeXYLST3E3x9T3e7KQvNTSb9Us+cYMy7kHX45kF3oc
	2S4EkGQEqdiOh765z2Cx5w1ovm60H18PTDOcDaasHZCjxQ0zS6kPloJkmfk3d4uOsLaIr2Av0JQ
	Vd5oqbtBFcp+zBtYpvrPDauT8Z50EluMN2jiIrD8/PBUbAnth90hRKmjImsIHjUbfdd58ve+LDn
	hpMOLGbzv4ByP/cjTzN6qUSYs3DUaJngiO3c6UsXa3xDayVxVjRXXeNyKI19YWBr2DGr5TJ/YGO
	HjKlT8qKGTEvKsJhZpeH8ShlCqx99WMnhd7goE+UXH6BIHHOBn+25RuhjlrSUcoBppf4a56Xa91
	XFBvcATNRS4QdYN9Rm9fk=
X-Google-Smtp-Source: AGHT+IEOAIlRNytX3BFrROSCN9C1ojEnrle3QifpbuwqR2P8RkIwfO+aGW98GH73tk57TYlzz5GB2w==
X-Received: by 2002:a05:6000:2890:b0:42b:3ad7:fdd4 with SMTP id ffacd0b85a97d-42b5933e3a6mr22918889f8f.3.1763567117642;
        Wed, 19 Nov 2025 07:45:17 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:17 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 01/26] kernel: Introduce meminspect
Date: Wed, 19 Nov 2025 17:44:02 +0200
Message-ID: <20251119154427.1033475-2-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inspection mechanism allows registration of a specific memory
area(or object) for later inspection purpose.
Ranges are being added into an inspection table, which can be
requested and analyzed by specific drivers.
Drivers would interface any hardware mechanism that will allow
inspection of the data, including but not limited to: dumping
for debugging, creating a coredump, analysis, or statistical
information.
Drivers can register a notifier to know when new objects are
registered, or to traverse existing inspection table.
Inspection table is created ahead of time such that it can be later
used regardless of the state of the kernel (running, frozen, crashed,
or any particular state).

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 Documentation/dev-tools/index.rst      |   1 +
 Documentation/dev-tools/meminspect.rst | 139 ++++++++
 MAINTAINERS                            |   7 +
 include/asm-generic/vmlinux.lds.h      |  13 +
 include/linux/meminspect.h             | 261 ++++++++++++++
 init/Kconfig                           |   2 +
 kernel/Makefile                        |   1 +
 kernel/meminspect/Kconfig              |  20 ++
 kernel/meminspect/Makefile             |   3 +
 kernel/meminspect/meminspect.c         | 470 +++++++++++++++++++++++++
 10 files changed, 917 insertions(+)
 create mode 100644 Documentation/dev-tools/meminspect.rst
 create mode 100644 include/linux/meminspect.h
 create mode 100644 kernel/meminspect/Kconfig
 create mode 100644 kernel/meminspect/Makefile
 create mode 100644 kernel/meminspect/meminspect.c

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 4b8425e348ab..8ce605de8ee6 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -38,6 +38,7 @@ Documentation/process/debugging/index.rst
    gpio-sloppy-logic-analyzer
    autofdo
    propeller
+   meminspect
 
 
 .. only::  subproject and html
diff --git a/Documentation/dev-tools/meminspect.rst b/Documentation/dev-tools/meminspect.rst
new file mode 100644
index 000000000000..2a0bd4d6e448
--- /dev/null
+++ b/Documentation/dev-tools/meminspect.rst
@@ -0,0 +1,139 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+meminspect
+==========
+
+This document provides information about the meminspect feature.
+
+Overview
+========
+
+meminspect is a mechanism that allows the kernel to register a chunk of
+memory into a table, to be used at a later time for a specific
+inspection purpose like debugging, memory dumping or statistics.
+
+meminspect allows drivers to traverse the inspection table on demand,
+or to register a notifier to be called whenever a new entry is being added
+or removed.
+
+The reasoning for meminspect is also to minimize the required information
+in case of a kernel problem. For example a traditional debug method involves
+dumping the whole kernel memory and then inspecting it. Meminspect allows the
+users to select which memory is of interest, in order to help this specific
+use case in production, where memory and connectivity are limited.
+
+Although the kernel has multiple internal mechanisms, meminspect fits
+a particular model which is not covered by the others.
+
+meminspect Internals
+====================
+
+API
+---
+
+Static memory can be registered at compile time, by instructing the compiler
+to create a separate section with annotation info.
+For each such annotated memory (variables usually), a dedicated struct
+is being created with the required information.
+To achieve this goal, some basic APIs are available:
+
+  MEMINSPECT_ENTRY(idx, sym, sz)
+is the basic macro that takes an ID, the symbol, and a size.
+
+To make it easier, some wrappers are also defined:
+  MEMINSPECT_SIMPLE_ENTRY(sym)
+will use the dedicated MEMINSPECT_ID_##sym with a size equal to sizeof(sym)
+
+  MEMINSPECT_NAMED_ENTRY(name, sym)
+will be a simple entry that has an id that cannot be derived from the sym,
+so a name has to be provided
+
+  MEMINSPECT_AREA_ENTRY(sym, sz)
+this will register sym, but with the size given as sz, useful for e.g.
+arrays which do not have a fixed size at compile time.
+
+For dynamically allocated memory, or for other cases, the following APIs
+are being defined:
+  meminspect_register_id_pa(enum meminspect_uid id, phys_addr_t zone,
+                            size_t size, unsigned int type);
+which takes the ID and the physical address.
+Similarly there are variations:
+  meminspect_register_pa() omits the ID
+  meminspect_register_id_va() requires the ID but takes a virtual address
+  meminspect_register_va() omits the ID and requires a virtual address
+
+If the ID is not given, the next avialable dynamic ID is allocated.
+
+To unregister a dynamic entry, some APIs are being defined:
+  meminspect_unregister_pa(phys_addr_t zone, size_t size);
+  meminspect_unregister_id(enum meminspect_uid id);
+  meminspect_unregister_va(va, size);
+
+All of the above have a lock variant that ensures the lock on the table
+is taken.
+
+
+meminspect drivers
+------------------
+
+Drivers are free to traverse the table by using a dedicated function
+meminspect_traverse(void *priv, MEMINSPECT_ITERATOR_CB cb)
+The callback will be called for each entry in the table.
+
+Drivers can also register a notifier with
+  meminspect_notifier_register()
+and unregister with
+  meminspect_notifier_unregister()
+to be called when a new entry is being added or removed.
+
+Data structures
+---------------
+
+The regions are being stored in a simple fixed size array. It avoids
+memory allocation overhead. This is not performance critical nor does
+allocating a few hundred entries create a memory consumption problem.
+
+The static variables registered into meminspect are being annotated into
+a dedicated .inspect_table memory section. This is then walked by meminspect
+at a later time and each variable is then copied to the whole inspect table.
+
+meminspect Initialization
+-------------------------
+
+At any time, meminspect will be ready to accept region registration
+from any part of the kernel. The table does not require any initialization.
+In case CONFIG_CRASH_DUMP is enabled, meminspect will create an ELF header
+corresponding to a core dump image, in which each region is added as a
+program header. In this scenario, the first region is this ELF header, and
+the second region is the vmcoreinfo ELF note.
+By using this mechanism, all the meminspect table, if dumped, can be
+concatenated to obtain a core image that is loadable with the `crash` tool.
+
+meminspect example
+==================
+
+A simple scenario for meminspect is the following:
+The kernel registers the linux_banner variable into meminspect with
+a simple annotation like:
+
+  MEMINSPECT_SIMPLE_ENTRY(linux_banner);
+
+The meminspect late initcall will parse the compilation time created table
+and copy the entry information into the inspection table.
+At a later point, any interested driver can call the traverse function to
+find out all entries in the table.
+A specific driver will then note into a specific table the address of the
+banner and the size of it.
+The specific table is then written to a shared memory area that can be
+read by upper level firmware.
+When the kernel freezes (hypothetically), the kernel will no longer feed
+the watchdog. The watchdog will trigger a higher exception level interrupt
+which will be handled by the upper level firmware. This firmware will then
+read the shared memory table and find an entry with the start and size of
+the banner. It will then copy it for debugging purpose. The upper level
+firmware will then be able to provide useful debugging information,
+like in this example, the banner.
+
+As seen here, meminspect facilitates the interaction between the kernel
+and a specific firmware.
diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..2cb2cc427c90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16157,6 +16157,13 @@ F:	arch/*/include/asm/sync_core.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
 
+MEMINSPECT
+M:	Eugen Hristev <eugen.hristev@linaro.org>
+S:	Maintained
+F:	Documentation/dev-tools/meminspect.rst
+F:	include/linux/meminspect.h
+F:	kernel/meminspect/*
+
 MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
 M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8a9a2e732a65..713135d72c34 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -489,6 +489,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	FW_LOADER_BUILT_IN_DATA						\
 	TRACEDATA							\
 									\
+	MEMINSPECT_TABLE						\
+									\
 	PRINTK_INDEX							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
@@ -893,6 +895,17 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TRACEDATA
 #endif
 
+#ifdef CONFIG_MEMINSPECT
+#define MEMINSPECT_TABLE						\
+	. = ALIGN(8);							\
+	.inspect_table : AT(ADDR(.inspect_table) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(.inspect_table,		\
+					   __inspect_table,, _end)	\
+	}
+#else
+#define MEMINSPECT_TABLE
+#endif
+
 #ifdef CONFIG_PRINTK_INDEX
 #define PRINTK_INDEX							\
 	.printk_index : AT(ADDR(.printk_index) - LOAD_OFFSET) {		\
diff --git a/include/linux/meminspect.h b/include/linux/meminspect.h
new file mode 100644
index 000000000000..e58b00079156
--- /dev/null
+++ b/include/linux/meminspect.h
@@ -0,0 +1,261 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _MEMINSPECT_H
+#define _MEMINSPECT_H
+
+#include <linux/notifier.h>
+
+enum meminspect_uid {
+	MEMINSPECT_ID_STATIC = 0,
+	MEMINSPECT_ID_ELF,
+	MEMINSPECT_ID_VMCOREINFO,
+	MEMINSPECT_ID_CONFIG,
+	MEMINSPECT_ID__totalram_pages,
+	MEMINSPECT_ID___cpu_possible_mask,
+	MEMINSPECT_ID___cpu_present_mask,
+	MEMINSPECT_ID___cpu_online_mask,
+	MEMINSPECT_ID___cpu_active_mask,
+	MEMINSPECT_ID_mem_section,
+	MEMINSPECT_ID_jiffies_64,
+	MEMINSPECT_ID_linux_banner,
+	MEMINSPECT_ID_nr_threads,
+	MEMINSPECT_ID_nr_irqs,
+	MEMINSPECT_ID_tainted_mask,
+	MEMINSPECT_ID_taint_flags,
+	MEMINSPECT_ID_node_states,
+	MEMINSPECT_ID___per_cpu_offset,
+	MEMINSPECT_ID_nr_swapfiles,
+	MEMINSPECT_ID_init_uts_ns,
+	MEMINSPECT_ID_printk_rb_static,
+	MEMINSPECT_ID_printk_rb_dynamic,
+	MEMINSPECT_ID_prb,
+	MEMINSPECT_ID_prb_descs,
+	MEMINSPECT_ID_prb_infos,
+	MEMINSPECT_ID_prb_data,
+	MEMINSPECT_ID_high_memory,
+	MEMINSPECT_ID_init_mm,
+	MEMINSPECT_ID_init_mm_pgd,
+	MEMINSPECT_ID__sinittext,
+	MEMINSPECT_ID__einittext,
+	MEMINSPECT_ID__end,
+	MEMINSPECT_ID__text,
+	MEMINSPECT_ID__stext,
+	MEMINSPECT_ID__etext,
+	MEMINSPECT_ID_kallsyms_num_syms,
+	MEMINSPECT_ID_kallsyms_relative_base,
+	MEMINSPECT_ID_kallsyms_offsets,
+	MEMINSPECT_ID_kallsyms_names,
+	MEMINSPECT_ID_kallsyms_token_table,
+	MEMINSPECT_ID_kallsyms_token_index,
+	MEMINSPECT_ID_kallsyms_markers,
+	MEMINSPECT_ID_kallsyms_seqs_of_names,
+	MEMINSPECT_ID_swapper_pg_dir,
+	MEMINSPECT_ID_DYNAMIC,
+	MEMINSPECT_ID_MAX = 201,
+};
+
+#define MEMINSPECT_TYPE_REGULAR		0
+
+#define MEMINSPECT_NOTIFIER_ADD		0
+#define MEMINSPECT_NOTIFIER_REMOVE	1
+
+/**
+ * struct inspect_entry - memory inspect entry information
+ * @id: unique id for this entry
+ * @va: virtual address for the memory (pointer)
+ * @pa: physical address for the memory
+ * @size: size of the memory area of this entry
+ * @type: type of the entry (class)
+ */
+struct inspect_entry {
+	enum meminspect_uid	id;
+	void			*va;
+	phys_addr_t		pa;
+	size_t			size;
+	unsigned int		type;
+};
+
+typedef void (*MEMINSPECT_ITERATOR_CB)(void *priv, const struct inspect_entry *ie);
+
+#ifdef CONFIG_MEMINSPECT
+/* .inspect_table section table markers*/
+extern const struct inspect_entry __inspect_table[];
+extern const struct inspect_entry __inspect_table_end[];
+
+/*
+ * Annotate a static variable into inspection table.
+ * Can be called multiple times for the same ID, in which case
+ * multiple table entries will be created
+ */
+#define MEMINSPECT_ENTRY(idx, sym, sz)						\
+	static const struct inspect_entry __UNIQUE_ID(__inspect_entry_##idx)	\
+	__used __section(".inspect_table") = { .id = idx,			\
+					       .va = (void *)&(sym),		\
+					       .size = (sz),			\
+					     }
+/*
+ * A simple entry is just a variable, the size of the entry is the variable size
+ * The variable can also be a pointer, the pointer itself is being added in this
+ * case.
+ */
+#define MEMINSPECT_SIMPLE_ENTRY(sym)	\
+	MEMINSPECT_ENTRY(MEMINSPECT_ID_##sym, sym, sizeof(sym))
+/*
+ * In the case when `sym` is not a variable, but a member of a struct e.g.,
+ * and we cannot derive a name from it, a name must be provided.
+ */
+#define MEMINSPECT_NAMED_ENTRY(name, sym)	\
+	MEMINSPECT_ENTRY(MEMINSPECT_ID_##name, sym, sizeof(sym))
+/*
+ * Create a more complex entry, by registering an arbitrary memory starting
+ * at sym. The size is provided as a parameter.
+ * This is used e.g. when the symbol is a start of an unknown sized array.
+ */
+#define MEMINSPECT_AREA_ENTRY(sym, sz) \
+	MEMINSPECT_ENTRY(MEMINSPECT_ID_##sym, sym, sz)
+
+/* Iterate through .inspect_table section entries */
+#define for_each_meminspect_entry(__entry)		\
+	for (__entry = __inspect_table;			\
+	     __entry < __inspect_table_end;		\
+	     __entry++)
+
+#else
+#define MEMINSPECT_ENTRY(...)
+#define MEMINSPECT_SIMPLE_ENTRY(...)
+#define MEMINSPECT_NAMED_ENTRY(...)
+#define MEMINSPECT_AREA_ENTRY(...)
+#endif
+
+#ifdef CONFIG_MEMINSPECT
+
+/*
+ * Dynamic helpers to register entries.
+ * These do not lock the table, so use with caution.
+ */
+void meminspect_register_id_pa(enum meminspect_uid id, phys_addr_t zone,
+			       size_t size, unsigned int type);
+void meminspect_table_lock(void);
+void meminspect_table_unlock(void);
+
+#define meminspect_register_pa(...) \
+	meminspect_register_id_pa(MEMINSPECT_ID_DYNAMIC, __VA_ARGS__, MEMINSPECT_TYPE_REGULAR)
+
+#define meminspect_register_id_va(id, va, size) \
+	meminspect_register_id_pa(id, virt_to_phys(va), size, MEMINSPECT_TYPE_REGULAR)
+
+#define meminspect_register_va(...) \
+	meminspect_register_id_va(MEMINSPECT_ID_DYNAMIC, __VA_ARGS__)
+
+void meminspect_unregister_pa(phys_addr_t zone, size_t size);
+void meminspect_unregister_id(enum meminspect_uid id);
+
+#define meminspect_unregister_va(va, size) \
+	meminspect_unregister_pa(virt_to_phys(va), size)
+
+void meminspect_traverse(void *priv, MEMINSPECT_ITERATOR_CB cb);
+
+/*
+ * Producers, or registrators, are advised to use the locked API below
+ */
+#define meminspect_lock_register_pa(...)		\
+	{						\
+		meminspect_table_lock();		\
+		meminspect_register_pa(__VA_ARGS__);	\
+		meminspect_table_unlock();		\
+	}
+
+#define meminspect_lock_register_id_va(...)		\
+	{						\
+		meminspect_table_lock();		\
+		meminspect_register_id_va(__VA_ARGS__);	\
+		meminspect_table_unlock();		\
+	}
+
+#define meminspect_lock_register_va(...)		\
+	{						\
+		meminspect_table_lock();		\
+		meminspect_register_va(__VA_ARGS__);	\
+		meminspect_table_unlock();		\
+	}
+
+#define meminspect_lock_unregister_pa(...)		\
+	{						\
+		meminspect_table_lock();		\
+		meminspect_unregister_pa(__VA_ARGS__);	\
+		meminspect_table_unlock();		\
+	}
+
+#define meminspect_lock_unregister_va(...)		\
+	{						\
+		meminspect_table_lock();		\
+		meminspect_unregister_va(__VA_ARGS__);	\
+		meminspect_table_unlock();		\
+	}
+
+#define meminspect_lock_unregister_id(...)		\
+	{						\
+		meminspect_table_lock();		\
+		meminspect_unregister_id(__VA_ARGS__);	\
+		meminspect_table_unlock();		\
+	}
+
+#define meminspect_lock_traverse(...)			\
+	{						\
+		meminspect_table_lock();		\
+		meminspect_traverse(__VA_ARGS__);	\
+		meminspect_table_unlock();		\
+	}
+
+int meminspect_notifier_register(struct notifier_block *n);
+int meminspect_notifier_unregister(struct notifier_block *n);
+
+#else
+static inline void meminspect_register_id_pa(enum meminspect_uid id,
+					     phys_addr_t zone,
+					     size_t size, unsigned int type)
+{
+}
+
+static inline void meminspect_table_lock(void)
+{
+}
+
+static inline void meminspect_table_unlock(void)
+{
+}
+
+static inline void meminspect_unregister(phys_addr_t zone, size_t size)
+{
+}
+
+static inline void meminspect_unregister_id(enum meminspect_uid id)
+{
+}
+
+static inline void meminspect_traverse(MEMINSPECT_ITERATOR_CB cb)
+{
+}
+
+static inline int meminspect_notifier_register(struct notifier_block *n)
+{
+	return 0;
+}
+
+static inline int meminspect_notifier_unregister(struct notifier_block *n)
+{
+	return 0;
+}
+
+#define meminspect_register_pa(...)
+#define meminspect_register_id_va(...)
+#define meminspect_register_va(...)
+#define meminspect_lock_register_pa(...)
+#define meminspect_lock_register_va(...)
+#define meminspect_lock_register_id_va(...)
+#define meminspect_lock_traverse(...)
+#define meminspect_lock_unregister_va(...)
+#define meminspect_lock_unregister_pa(...)
+#define meminspect_lock_unregister_id(...)
+#endif
+
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..d48647419944 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2138,6 +2138,8 @@ config TRACEPOINTS
 
 source "kernel/Kconfig.kexec"
 
+source "kernel/meminspect/Kconfig"
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/kernel/Makefile b/kernel/Makefile
index df3dd8291bb6..83ec5310dfd1 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y += locking/
 obj-y += power/
 obj-y += printk/
 obj-y += irq/
+obj-y += meminspect/
 obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
diff --git a/kernel/meminspect/Kconfig b/kernel/meminspect/Kconfig
new file mode 100644
index 000000000000..8680fbf0e285
--- /dev/null
+++ b/kernel/meminspect/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config MEMINSPECT
+	bool "Allow the kernel to register memory regions for inspection purpose"
+	help
+	  Inspection mechanism allows registration of a specific memory
+	  area(or object) for later inspection purpose.
+	  Ranges are being added into an inspection table, which can be
+	  requested and analyzed by specific drivers.
+	  Drivers would interface any hardware mechanism that will allow
+	  inspection of the data, including but not limited to: dumping
+	  for debugging, creating a coredump, analysis, or statistical
+	  information.
+	  Inspection table is created ahead of time such that it can be later
+	  used regardless of the state of the kernel (running, frozen, crashed,
+	  or any particular state).
+
+	  Note that modules using this feature must be rebuilt if option
+	  changes.
+
diff --git a/kernel/meminspect/Makefile b/kernel/meminspect/Makefile
new file mode 100644
index 000000000000..09fd55e6d9cf
--- /dev/null
+++ b/kernel/meminspect/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MEMINSPECT) += meminspect.o
diff --git a/kernel/meminspect/meminspect.c b/kernel/meminspect/meminspect.c
new file mode 100644
index 000000000000..0d9ad65ba92e
--- /dev/null
+++ b/kernel/meminspect/meminspect.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/crash_core.h>
+#include <linux/dma-map-ops.h>
+#include <linux/vmcore_info.h>
+#include <linux/notifier.h>
+#include <linux/meminspect.h>
+
+static DEFINE_MUTEX(meminspect_lock);
+static struct inspect_entry inspect_entries[MEMINSPECT_ID_MAX];
+
+ATOMIC_NOTIFIER_HEAD(meminspect_notifier_list);
+
+#ifdef CONFIG_CRASH_DUMP
+
+#define CORE_STR "CORE"
+
+static struct elfhdr *ehdr;
+static size_t elf_offset;
+static bool elf_hdr_ready;
+
+static void append_kcore_note(char *notes, size_t *i, const char *name,
+			      unsigned int type, const void *desc,
+			      size_t descsz)
+{
+	struct elf_note *note = (struct elf_note *)&notes[*i];
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = descsz;
+	note->n_type = type;
+	*i += sizeof(*note);
+	memcpy(&notes[*i], name, note->n_namesz);
+	*i = ALIGN(*i + note->n_namesz, 4);
+	memcpy(&notes[*i], desc, descsz);
+	*i = ALIGN(*i + descsz, 4);
+}
+
+static void append_kcore_note_nodesc(char *notes, size_t *i, const char *name,
+				     unsigned int type, size_t descsz)
+{
+	struct elf_note *note = (struct elf_note *)&notes[*i];
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = descsz;
+	note->n_type = type;
+	*i += sizeof(*note);
+	memcpy(&notes[*i], name, note->n_namesz);
+	*i = ALIGN(*i + note->n_namesz, 4);
+}
+
+static struct elf_phdr *elf_phdr_entry_addr(struct elfhdr *ehdr, int idx)
+{
+	struct elf_phdr *ephdr = (struct elf_phdr *)((size_t)ehdr + ehdr->e_phoff);
+
+	return &ephdr[idx];
+}
+
+static int clear_elfheader(const struct inspect_entry *e)
+{
+	struct elf_phdr *phdr;
+	struct elf_phdr *tmp_phdr;
+	unsigned int phidx;
+	unsigned int i;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		if (phdr->p_paddr == e->pa &&
+		    phdr->p_memsz == ALIGN(e->size, 4))
+			break;
+	}
+
+	if (i == ehdr->e_phnum) {
+		pr_debug("Cannot find program header entry in elf\n");
+		return -EINVAL;
+	}
+
+	phidx = i;
+
+	/* Clear program header */
+	tmp_phdr = elf_phdr_entry_addr(ehdr, phidx);
+	for (i = phidx; i < ehdr->e_phnum - 1; i++) {
+		tmp_phdr = elf_phdr_entry_addr(ehdr, i + 1);
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		memcpy(phdr, tmp_phdr, sizeof(*phdr));
+		phdr->p_offset = phdr->p_offset - ALIGN(e->size, 4);
+	}
+	memset(tmp_phdr, 0, sizeof(*tmp_phdr));
+	ehdr->e_phnum--;
+
+	elf_offset -= ALIGN(e->size, 4);
+
+	return 0;
+}
+
+static void update_elfheader(const struct inspect_entry *e)
+{
+	struct elf_phdr *phdr;
+
+	phdr = elf_phdr_entry_addr(ehdr, ehdr->e_phnum++);
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = elf_offset;
+	phdr->p_vaddr = (elf_addr_t)e->va;
+	if (e->pa)
+		phdr->p_paddr = (elf_addr_t)e->pa;
+	else
+		phdr->p_paddr = (elf_addr_t)virt_to_phys(e->va);
+	phdr->p_filesz = phdr->p_memsz = ALIGN(e->size, 4);
+	phdr->p_flags = PF_R | PF_W;
+
+	elf_offset += ALIGN(e->size, 4);
+}
+
+/*
+ * This function prepares the elf header for the coredump image.
+ * Initially there is a single program header for the elf NOTE.
+ * The note contains the usual core dump information, and the vmcoreinfo.
+ */
+static int init_elfheader(void)
+{
+	struct elf_phdr *phdr;
+	void *notes;
+	unsigned int elfh_size, buf_sz;
+	unsigned int phdr_off;
+	size_t note_len, i = 0;
+	struct page *p;
+
+	struct elf_prstatus prstatus = {};
+	struct elf_prpsinfo prpsinfo = {
+		.pr_sname = 'R',
+		.pr_fname = "vmlinux",
+	};
+
+	/*
+	 * Header buffer contains:
+	 * ELF header, Note entry with PR status, PR ps info, and vmcoreinfo.
+	 * Also, MEMINSPECT_ID_MAX program headers.
+	 */
+	elfh_size = sizeof(*ehdr);
+	elfh_size += sizeof(struct elf_prstatus);
+	elfh_size += sizeof(struct elf_prpsinfo);
+	elfh_size += sizeof(VMCOREINFO_NOTE_NAME);
+	elfh_size += ALIGN(vmcoreinfo_size, 4);
+	elfh_size += (sizeof(*phdr)) * (MEMINSPECT_ID_MAX);
+
+	elfh_size = ALIGN(elfh_size, 4);
+
+	/* Length of the note is made of :
+	 * 3 elf notes structs (prstatus, prpsinfo, vmcoreinfo)
+	 * 3 notes names (2 core strings, 1 vmcoreinfo name)
+	 * sizeof each note
+	 */
+	note_len = (3 * sizeof(struct elf_note) +
+		    2 * ALIGN(sizeof(CORE_STR), 4) +
+		    VMCOREINFO_NOTE_NAME_BYTES +
+		    ALIGN(sizeof(struct elf_prstatus), 4) +
+		    ALIGN(sizeof(struct elf_prpsinfo), 4) +
+		    ALIGN(vmcoreinfo_size, 4));
+
+	buf_sz = elfh_size + note_len - ALIGN(vmcoreinfo_size, 4);
+
+	/* Never freed */
+	p = dma_alloc_from_contiguous(NULL, buf_sz >> PAGE_SHIFT,
+				      get_order(buf_sz), true);
+	if (!p)
+		return -ENOMEM;
+
+	ehdr = dma_common_contiguous_remap(p, buf_sz,
+			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
+			__builtin_return_address(0));
+	if (!ehdr) {
+		dma_release_from_contiguous(NULL, p, buf_sz >> PAGE_SHIFT);
+		return -ENOMEM;
+	}
+
+	memset(ehdr, 0, elfh_size);
+
+	/* Assign Program headers offset, it's right after the elf header. */
+	phdr = (struct elf_phdr *)(ehdr + 1);
+	phdr_off = sizeof(*ehdr);
+
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELF_CLASS;
+	ehdr->e_ident[EI_DATA] = ELF_DATA;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_ehsize = sizeof(*ehdr);
+	ehdr->e_phentsize = sizeof(*phdr);
+
+	elf_offset = elfh_size;
+
+	notes = (void *)(((char *)ehdr) + elf_offset);
+
+	/* we have a single program header now */
+	ehdr->e_phnum = 1;
+
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = elf_offset;
+	phdr->p_filesz = note_len;
+
+	/* advance elf offset */
+	elf_offset += note_len;
+
+	strscpy(prpsinfo.pr_psargs, saved_command_line,
+		sizeof(prpsinfo.pr_psargs));
+
+	append_kcore_note(notes, &i, CORE_STR, NT_PRSTATUS, &prstatus,
+			  sizeof(prstatus));
+	append_kcore_note(notes, &i, CORE_STR, NT_PRPSINFO, &prpsinfo,
+			  sizeof(prpsinfo));
+	append_kcore_note_nodesc(notes, &i, VMCOREINFO_NOTE_NAME, 0,
+				 ALIGN(vmcoreinfo_size, 4));
+
+	ehdr->e_phoff = phdr_off;
+
+	/* This is the first coredump region, the ELF header */
+	meminspect_register_id_pa(MEMINSPECT_ID_ELF, page_to_phys(p),
+				  buf_sz, MEMINSPECT_TYPE_REGULAR);
+
+	/*
+	 * The second region is the vmcoreinfo, which goes right after.
+	 * It's being registered through vmcoreinfo.
+	 */
+
+	return 0;
+}
+#endif
+
+/**
+ * meminspect_unregister_id() - Unregister region from inspection table.
+ * @id: region's id in the table
+ *
+ * Return: None
+ */
+void meminspect_unregister_id(enum meminspect_uid id)
+{
+	struct inspect_entry *e;
+
+	WARN_ON(!mutex_is_locked(&meminspect_lock));
+
+	e = &inspect_entries[id];
+	if (!e->id)
+		return;
+
+	atomic_notifier_call_chain(&meminspect_notifier_list,
+				   MEMINSPECT_NOTIFIER_REMOVE, e);
+#ifdef CONFIG_CRASH_DUMP
+	if (elf_hdr_ready)
+		clear_elfheader(e);
+#endif
+	memset(e, 0, sizeof(*e));
+}
+EXPORT_SYMBOL_GPL(meminspect_unregister_id);
+
+/**
+ * meminspect_unregister_pa() - Unregister region from inspection table.
+ * @pa: Physical address of the memory region to remove
+ * @size: Size of the memory region to remove
+ *
+ * Return: None
+ */
+void meminspect_unregister_pa(phys_addr_t pa, size_t size)
+{
+	struct inspect_entry *e;
+	enum meminspect_uid i;
+
+	WARN_ON(!mutex_is_locked(&meminspect_lock));
+
+	for (i = MEMINSPECT_ID_STATIC; i < MEMINSPECT_ID_MAX; i++) {
+		e = &inspect_entries[i];
+		if (e->pa != pa)
+			continue;
+		if (e->size != size)
+			continue;
+		meminspect_unregister_id(e->id);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(meminspect_unregister_pa);
+
+/**
+ * meminspect_register_id_pa() - Register region into inspection table
+ *		 with given ID and physical address.
+ * @req_id: Requested unique meminspect_uid that identifies the region
+ *	This can be MEMINSPECT_ID_DYNAMIC, in which case the function will
+ *	find an unused ID and register with it.
+ * @pa: physical address of the memory region
+ * @size: region size
+ * @type: region type
+ *
+ * Return: None
+ */
+void meminspect_register_id_pa(enum meminspect_uid req_id, phys_addr_t pa,
+			       size_t size, unsigned int type)
+{
+	struct inspect_entry *e;
+	enum meminspect_uid uid = req_id;
+
+	WARN_ON(!mutex_is_locked(&meminspect_lock));
+
+	if (uid < MEMINSPECT_ID_STATIC || uid >= MEMINSPECT_ID_MAX)
+		return;
+
+	if (uid == MEMINSPECT_ID_DYNAMIC)
+		while (uid < MEMINSPECT_ID_MAX) {
+			if (!inspect_entries[uid].id)
+				break;
+			uid++;
+		}
+
+	if (uid == MEMINSPECT_ID_MAX)
+		return;
+
+	e = &inspect_entries[uid];
+
+	if (e->id)
+		meminspect_unregister_id(e->id);
+
+	e->pa = pa;
+	e->va = phys_to_virt(pa);
+	e->size = size;
+	e->id = uid;
+	e->type = type;
+#ifdef CONFIG_CRASH_DUMP
+	if (elf_hdr_ready)
+		update_elfheader(e);
+#endif
+	atomic_notifier_call_chain(&meminspect_notifier_list,
+				   MEMINSPECT_NOTIFIER_ADD, e);
+}
+EXPORT_SYMBOL_GPL(meminspect_register_id_pa);
+
+/**
+ * meminspect_table_lock() - Lock the mutex on the inspection table
+ *
+ * Return: None
+ */
+void meminspect_table_lock(void)
+{
+	mutex_lock(&meminspect_lock);
+}
+EXPORT_SYMBOL_GPL(meminspect_table_lock);
+
+/**
+ * meminspect_table_unlock() - Unlock the mutex on the inspection table
+ *
+ * Return: None
+ */
+void meminspect_table_unlock(void)
+{
+	mutex_unlock(&meminspect_lock);
+}
+EXPORT_SYMBOL_GPL(meminspect_table_unlock);
+
+/**
+ * meminspect_traverse() - Traverse the meminspect table and call the
+ *		callback function for each valid entry.
+ * @priv: private data to be called to the callback
+ * @cb: meminspect iterator callback that should be called for each entry
+ *
+ * Return: None
+ */
+void meminspect_traverse(void *priv, MEMINSPECT_ITERATOR_CB cb)
+{
+	const struct inspect_entry *e;
+	int i;
+
+	WARN_ON(!mutex_is_locked(&meminspect_lock));
+
+	for (i = MEMINSPECT_ID_STATIC; i < MEMINSPECT_ID_MAX; i++) {
+		e = &inspect_entries[i];
+		if (e->id)
+			cb(priv, e);
+	}
+}
+EXPORT_SYMBOL_GPL(meminspect_traverse);
+
+/**
+ * meminspect_notifier_register() - Register a notifier to meminspect table
+ * @n: notifier block to register. This will be called whenever an entry
+ *		is being added or removed.
+ *
+ * Return: errno
+ */
+int meminspect_notifier_register(struct notifier_block *n)
+{
+	return atomic_notifier_chain_register(&meminspect_notifier_list, n);
+}
+EXPORT_SYMBOL_GPL(meminspect_notifier_register);
+
+/**
+ * meminspect_notifier_unregister() - Unregister a previously registered
+ *		notifier from meminspect table.
+ * @n: notifier block to unregister.
+ *
+ * Return: errno
+ */
+int meminspect_notifier_unregister(struct notifier_block *n)
+{
+	return atomic_notifier_chain_unregister(&meminspect_notifier_list, n);
+}
+EXPORT_SYMBOL_GPL(meminspect_notifier_unregister);
+
+#ifdef CONFIG_CRASH_DUMP
+static int __init meminspect_prepare_crashdump(void)
+{
+	const struct inspect_entry *e;
+	int ret;
+	enum meminspect_uid i;
+
+	ret = init_elfheader();
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Some regions may have been registered very early.
+	 * Update the elf header for all existing regions,
+	 * except for MEMINSPECT_ID_ELF and MEMINSPECT_ID_VMCOREINFO,
+	 * those are included in the ELF header upon its creation.
+	 */
+	for (i = MEMINSPECT_ID_VMCOREINFO + 1; i < MEMINSPECT_ID_MAX; i++) {
+		e = &inspect_entries[i];
+		if (e->id)
+			update_elfheader(e);
+	}
+
+	elf_hdr_ready = true;
+
+	return 0;
+}
+#endif
+
+static int __init meminspect_prepare_table(void)
+{
+	const struct inspect_entry *e;
+	enum meminspect_uid i;
+
+	meminspect_table_lock();
+	/*
+	 * First, copy all entries from the compiler built table
+	 * In case some entries are registered multiple times,
+	 * the last chronological entry will be stored.
+	 * Previusly registered entries will be dropped.
+	 */
+	for_each_meminspect_entry(e) {
+		inspect_entries[e->id] = *e;
+	}
+#ifdef CONFIG_CRASH_DUMP
+	meminspect_prepare_crashdump();
+#endif
+	/* if we have early notifiers registered, call them now */
+	for (i = MEMINSPECT_ID_STATIC; i < MEMINSPECT_ID_MAX; i++)
+		if (inspect_entries[i].id)
+			atomic_notifier_call_chain(&meminspect_notifier_list,
+						   MEMINSPECT_NOTIFIER_ADD,
+						   &inspect_entries[i]);
+	meminspect_table_unlock();
+
+	pr_debug("Memory inspection table initialized");
+
+	return 0;
+}
+late_initcall(meminspect_prepare_table);
-- 
2.43.0


