Return-Path: <linux-arch+bounces-11881-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F6AB23C6
	for <lists+linux-arch@lfdr.de>; Sat, 10 May 2025 14:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3254A8119
	for <lists+linux-arch@lfdr.de>; Sat, 10 May 2025 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF02586C1;
	Sat, 10 May 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="LdlebDNx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89964257424
	for <linux-arch@vger.kernel.org>; Sat, 10 May 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880515; cv=none; b=j3vH6iv8ovnVT9kVa2udK0d6zQPYObsejQAeW2DOXDzcjOmFoUPt0OMZzoDh7BqOXou8ogUqlvJZaMZcYH1ngqosmO+zEAeKnq3AhqP4/UhS3r4eWjMosE7cUqNk1U1zS4/7riLb/pctBJJeG7dPOMWaF4QfVTAA+zFBwfnISeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880515; c=relaxed/simple;
	bh=DUqDMiLgd2tvogAGyldhM32/j15Rh/ExfBiuYQf0mrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShaG6VVeUkslZTGBd9SK2CaQ1XEIVZY24aG6Y4r43LN90dbnFrC1H/VLcbpNFhAGg8nNED4NN8DVZmY5T2cIok+OKRLmXJd9UA6qvzv843dBHEgmwXwR4evL2ZkMOvRREsI+A4CrmnCKZlHjVYoq+C3X7rznBr1zPKbJ5rzmekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=LdlebDNx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f6e6ec07f0so10851546d6.3
        for <linux-arch@vger.kernel.org>; Sat, 10 May 2025 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746880512; x=1747485312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYAxWaJSrnfZ6nExHOjZ9y1eg860XnXFXGjDhITg1Kg=;
        b=LdlebDNxA5SnWof2laIBk/LXeyL5Tl8fS0Mi6OCih99a+8kFamF4Cv4X9dw+bZ3ApI
         6BA79B3vBHLKIr/hAr5YCKsrUScCUE+qBBrkuNnoPBxUSiygvBzFzRZb6t2r5cFH8c0I
         HYMv98Md/fVwbyd8vAmL0G/prsjHzrUpYnC7XBiacOXOpgksoqJl8r2Z5dK9mQ8KvVeW
         PZ5F4WMRzZpSxb7F1tt3H1HRm9/xjoAeVZTvmsRr2OJMxAAv5K9jmO4n4YNghRqzeOoa
         hQXOYw3AcIOk+A4Uei1bngejLvrWUvEAUbBHEto9JX8IEZSNp9P8pb0OhdZOjTzC5QY+
         WN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746880512; x=1747485312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYAxWaJSrnfZ6nExHOjZ9y1eg860XnXFXGjDhITg1Kg=;
        b=g63DpDm8JtPN90VMZdoHqid3uUZOdcX9a2YQTCpp+betnMOJqYeEkJmTL8C9KlVy8K
         Ifi6Ms2AD/WSUz98IcAFa10WmC+nSOOjvY5DrA0Zgwr7JMX4W40zjJCb3Mb30kz/llZ1
         JjJWwCDuuN5IoUkTyHbtlxHe+nJnH2/ZWbg1PlUPkyQsOBOsH9Vt76WJ7VRG3VmuvTGB
         CUM3A8x6wGrjXz2SzE5dqVeZy9JEySPABwa0/5fXJ1R+roBwJw/beplvmxT2pJ6lVe/J
         HnFkEWSRs858sMifnDFC1sC0FmK1ho8uYBEoCt1eMUNrYnuMq19wf1Sy0s6saQzZH9K6
         DhqQ==
X-Gm-Message-State: AOJu0YzioK/yU8Ge0ayUYWEY9RkleAUkydjNIcAeDo2MLsw3k+XNLcjD
	9nXeNt3+wfxOTSy8NILGYvQpJRbAQJF0Ji18iHcuO/tPVfSfYhZf30ibmwD0cf8=
X-Gm-Gg: ASbGncuw4hwYDCdzFrUyfu9nDO/7Jz5f1RxUh7tYCtLqe95xHLA6Tw9vv1cuJ3WXQoi
	K2XM/ljBLh/Ut8lc8NrbnOTINendxHELRZuYDOxeVL+OwqqxQPqV/2B5k8ZsV75yMoP5j5HJPLU
	FP+rWpLt19bGqJBqymGwVkEYpn7P/WhMqyMm3JCIEfxLnxUB9SCU0kWDObR172PbapKiO2uI/KA
	G9ZACbBJpRTSvoZJsi6GxTGSKXYsITW4JpoFjaTZjhMms5+2fyqWoNOQADc7CA2dLZeoZz+0rI6
	LxhnQVoAVCMTY3GvCnZ9I8c3KhQjD4Z6Q/tydPjqJEgyfkypM07+RKKfz/4e2xoMP/5e6/CvgYs
	114kBhqg=
X-Google-Smtp-Source: AGHT+IEN8UctYdRzvlWNq05Mh2iid7CcTaujQ7Nc89AVrvbTK4mCAIX+yQUCvA5ZtJ3VtN5m86Z8yg==
X-Received: by 2002:a05:6214:5007:b0:6e6:5d61:4f01 with SMTP id 6a1803df08f44-6f6e47a77abmr132849336d6.8.1746880512242;
        Sat, 10 May 2025 05:35:12 -0700 (PDT)
Received: from [192.168.1.45] (ool-182edad1.dyn.optonline.net. [24.46.218.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39f588asm25725556d6.49.2025.05.10.05.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 05:35:11 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Sat, 10 May 2025 08:34:54 -0400
Subject: [PATCH bpf-next v4 1/3] btf: allow mmap of vmlinux btf
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-vmlinux-mmap-v4-1-69e424b2a672@isovalent.com>
References: <20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com>
In-Reply-To: <20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com>
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

User space needs access to kernel BTF for many modern features of BPF.
Right now each process needs to read the BTF blob either in pieces or
as a whole. Allow mmaping the sysfs file so that processes can directly
access the memory allocated for it in the kernel.

remap_pfn_range is used instead of vm_insert_page due to aarch64
compatibility issues.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/asm-generic/vmlinux.lds.h |  3 ++-
 kernel/bpf/sysfs_btf.c            | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 58a635a6d5bdf0c53c267c2a3d21a5ed8678ce73..1750390735fac7637cc4d2fa05f96cb2a36aa448 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -667,10 +667,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
  */
 #ifdef CONFIG_DEBUG_INFO_BTF
 #define BTF								\
+	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
 		BOUNDED_SECTION_BY(.BTF, _BTF)				\
 	}								\
-	. = ALIGN(4);							\
+	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
 	}
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 81d6cf90584a7157929c50f62a5c6862e7a3d081..941d0d2427e3a2d27e8f1cff7b6424d0d41817c1 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -7,14 +7,46 @@
 #include <linux/kobject.h>
 #include <linux/init.h>
 #include <linux/sysfs.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/btf.h>
 
 /* See scripts/link-vmlinux.sh, gen_btf() func for details */
 extern char __start_BTF[];
 extern char __stop_BTF[];
 
+static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
+				  const struct bin_attribute *attr,
+				  struct vm_area_struct *vma)
+{
+	unsigned long pages = PAGE_ALIGN(attr->size) >> PAGE_SHIFT;
+	size_t vm_size = vma->vm_end - vma->vm_start;
+	phys_addr_t addr = virt_to_phys(__start_BTF);
+	unsigned long pfn = addr >> PAGE_SHIFT;
+
+	if (attr->private != __start_BTF || !PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	if (vma->vm_pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_WRITE | VM_EXEC | VM_MAYSHARE))
+		return -EACCES;
+
+	if (pfn + pages < pfn)
+		return -EINVAL;
+
+	if ((vm_size >> PAGE_SHIFT) > pages)
+		return -EINVAL;
+
+	vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC | VM_MAYWRITE);
+	return remap_pfn_range(vma, vma->vm_start, pfn, vm_size, vma->vm_page_prot);
+}
+
 static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.attr = { .name = "vmlinux", .mode = 0444, },
 	.read_new = sysfs_bin_attr_simple_read,
+	.mmap = btf_sysfs_vmlinux_mmap,
 };
 
 struct kobject *btf_kobj;

-- 
2.49.0


