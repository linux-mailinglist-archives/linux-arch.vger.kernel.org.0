Return-Path: <linux-arch+bounces-11770-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE21AA5FFD
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D057460131
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861611F2382;
	Thu,  1 May 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="gXRCHB6m"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A61F8BD6
	for <linux-arch@vger.kernel.org>; Thu,  1 May 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109710; cv=none; b=DDJH1jFjvbJHTx96UvVsGF3h0LovzOb5VnZp09hY9wXWbvwFzh2uIcPU/VeC8UIzC+fsPzBGNEWIWcs3cjfsvKbCvc68eb80rINColr4O+F/5vSvfl16ZTFOxSaEMuMe6AD6/0iRCgowPQyO0FzSw5tbIYDVObuVcS6zqFyARGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109710; c=relaxed/simple;
	bh=Bdk+C4naWZdvQAznGsmCl57RU0n4Z14M9ctNJtILpyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9FabELHvhAJqutvCw5l+DAcCYNYxArWicRf+AazQuBPLwYgqWsmGgYk7ymkR+PcF211vc7dOYwfY8t7KrpXrI3pZKB0MOCzEDUCXwjrqumBEok+7eCNeG26FABcHPWM8Uhwrm3jIQDiVKLlCSuLG6qt/X0q4rpy96Swpjbxvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=gXRCHB6m; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so7806145e9.1
        for <linux-arch@vger.kernel.org>; Thu, 01 May 2025 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746109707; x=1746714507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQvdlwU602sy2200o3Yv2M/yNfMxMp0HA+iE0MAoltw=;
        b=gXRCHB6mtmqMV/okRDRU9EyktzsXSmmV5WPy+DfL0lDyiWr0OB5HCc/1ZrT4ew0kHu
         nIndcfA/LBA6um74Q1eZmr41F0vbLUxiNlxgAiUsx/uX9SUqaiVcwRbx9XBFLPe199Zm
         CY/yHy587MbF25y7T6CqrdrlQK4JwLqVlMHg1iISal17vLmYWpL4Ibs+SYS1lH4FB7L5
         dCDdM1oyODjVwkifMBoQM+Uoo5UQytv93bR+OQvCttuuKmHECIK3gxhRKmU/WNslRLpl
         zo8gcYTUKtLKuK1Hv5+TczEYerBM4VwS95z6CXICTVieAyHedlnr69nzEW9K8oHh65yF
         Hbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109707; x=1746714507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQvdlwU602sy2200o3Yv2M/yNfMxMp0HA+iE0MAoltw=;
        b=DyaEHTxBU1aUw+mLCGWuSDa0NC7wFv5c12PVWq4n0BMsKPRLdzB4i9nf7Yg6+C4fo0
         uXDHo0zhT0Q5Zxsw75rqHhq7MKAlE2ibJD9lJ8j5eK6v/DHd229HaN1CbzgbcpJK8ahG
         T5M2tyO2BDG+v0HMdlb/A6aaXxFEIiGaiZdhTTiPGVfwhltbBuQ57HNJGO4bYnNPLAEX
         v6/RDIzWilofZt3NsT+FpeGs53jGGGxjfaJJBdomjzHhpvdNUaK+t6yL2Srw8qOWta0a
         zv9y8Q3QvHiCoWtAqqzqmMwHfd3Ew9l3pXEXbqw/7NTXF9z7eRZOKmIPyElNRKwhe/vB
         PC1g==
X-Gm-Message-State: AOJu0YzqFOqM84WpEOC5CSXXEKlk7j9ppOvj3HH9YfJk1I6Y6axM8y4t
	+UNRKKwxYhbi/tTQPVVGZtaYZjXy9LY98d3snoFiOpLm9VqGfeUN8iO1pNoqJkI=
X-Gm-Gg: ASbGncuGuxNlLi/ycMZtQaUBw+19p4uRrqSvOdL8744YfOZvCZkb6bEB/QQSTp2loHg
	DBCJ5di6MbrrzT/j/Xu8wg8Izbpz0xr8Vtr6CsDOeMRhrn7q3vtSbnmi2g3byjoM4A4FrFj5ffe
	7TGYy5hEvAx3uxTSBN7qi9Rt4AFY7VVjzwGGS1MPC5HekQnGAQA7S5WvwBXg+qS733qjCqWYafJ
	teoR+bxJPWnPDxJ1gHQeTTjzNxxNLOfAkqTSw8soQD6wDReGJJKwQRaEHv/7BSlx49vBGwfOCR7
	+45nf1xzsdixyQKhuee6SjYHwAWbW5slKRmWcW34pDt4NhuN3cTWweqhbD1ZkPNf8wUp3XajBYk
	ngeD6xyttENb6Bctg4XBr12AuI+TGZLd0JHjS
X-Google-Smtp-Source: AGHT+IGy0LDUHyJXOVHAC98GhTWux6/a5g/Z2ztBK4/3fRtxG05OxDLTr5GuNeJQsjhZZpo79dJY/A==
X-Received: by 2002:a05:600c:502b:b0:43c:fb8e:aec0 with SMTP id 5b1f17b1804b1-441b1f2f0fdmr58254725e9.1.1746109706849;
        Thu, 01 May 2025 07:28:26 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d15dasm13908445e9.16.2025.05.01.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:28:26 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 01 May 2025 15:28:21 +0100
Subject: [PATCH bpf-next 1/2] btf: allow mmap of vmlinux btf
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-vmlinux-mmap-v1-1-aa2724572598@isovalent.com>
References: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
In-Reply-To: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
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

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/asm-generic/vmlinux.lds.h |  3 ++-
 kernel/bpf/sysfs_btf.c            | 25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

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
index 81d6cf90584a7157929c50f62a5c6862e7a3d081..7651f37b82c78b8afd96078567a5b6612f5f4d97 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -7,18 +7,39 @@
 #include <linux/kobject.h>
 #include <linux/init.h>
 #include <linux/sysfs.h>
+#include <linux/mm.h>
+#include <linux/io.h>
 
 /* See scripts/link-vmlinux.sh, gen_btf() func for details */
 extern char __start_BTF[];
 extern char __stop_BTF[];
 
+struct kobject *btf_kobj;
+
+static int btf_vmlinux_mmap(struct file *filp, struct kobject *kobj,
+			    const struct bin_attribute *attr,
+			    struct vm_area_struct *vma)
+{
+	size_t btf_size = __stop_BTF - __start_BTF;
+
+	if (kobj != btf_kobj)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_WRITE|VM_EXEC|VM_MAYSHARE))
+		return -EACCES;
+
+	vm_flags_clear(vma, VM_MAYEXEC);
+	vm_flags_clear(vma, VM_MAYWRITE);
+
+	return vm_iomap_memory(vma, virt_to_phys(__start_BTF), btf_size);
+}
+
 static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.attr = { .name = "vmlinux", .mode = 0444, },
 	.read_new = sysfs_bin_attr_simple_read,
+	.mmap = btf_vmlinux_mmap,
 };
 
-struct kobject *btf_kobj;
-
 static int __init btf_vmlinux_init(void)
 {
 	bin_attr_btf_vmlinux.private = __start_BTF;

-- 
2.49.0


