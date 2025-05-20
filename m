Return-Path: <linux-arch+bounces-12016-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2788ABD8AA
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 15:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C624C0B26
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4C22CBF9;
	Tue, 20 May 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="PP5wTbRV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09F22B8D5
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746104; cv=none; b=sNHjqTFUOT/KJlwU2C0GvdQgblc+SETXo2LVwoAS38cx1ILct3mVc0k/vbuyf/XyPV1XNoemPS8zTBjQWrag3yXyA50dg2lX8Q93ApOQa6FVNReFacAp9AeYDTRyNAIJ9TVFrOrHNNQzOUXIhQ5p4HFsZJ1x2cbhytTyePcVIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746104; c=relaxed/simple;
	bh=c4jojo3FrsibvRNue34ztcliWE7ZrRLcrwLqEcNS708=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9Cp9uJBs2cRGLR4Kp8F4Wmv9bofbDBu9Soi+IYjr8tchPhcCERnAfytSfFNgbC7avzncRDJgxbM2PkFoSc9MYsFAAtJKWCqsPex5MYMfxssXYmcYXRmR/4tMr2RRVyIlFpAPaQxLKJTvK6NEQOo661AbTh0vcWiBMGK4oMwhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=PP5wTbRV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso55603395e9.0
        for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1747746100; x=1748350900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaoULxe21siuTC/4/X/NX4W28Unf1olYgXifLjKBGNc=;
        b=PP5wTbRV9rRTA1QvHhjX0QxlTMTp/P9GZYS6XNW0+7/UXLaba/GVxXixj4+P2NsvV/
         Nxy8l7DRPnL4ITY8enPl+YyKx7kd7gprpImz6QSsCrxWtp2Cd1lWZJLqS4L7+ARyiX/h
         ro69QgHxYAdCk+XGoMC1ousMGaHAmwr4+ZXM/XGZ+ncJGmBMu5Cbilf3fJoGGnwWTFRW
         3hWQ0slsrindc3KPAssdwBfWKSDgL+SvcTmjcQXCnfCFsHonVFtBNjF/8eMJwA78lUw+
         h18+HK2XOtj9rdPHddEWkYznZzupqcS/TbN9ScuJJohwxcIG3bRNvdX36zRUxZ/xNW6L
         kC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746100; x=1748350900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaoULxe21siuTC/4/X/NX4W28Unf1olYgXifLjKBGNc=;
        b=M7gFUvZ9aOdrMS6wMc/w0dmSNpdOTIm//rp8SlGvoEAv4A+cXLp9NtclcolIGrWnEY
         lkeWrX7FZnUP0bRMUqRmgtR6ZYHnWmnmewiPGSsY4gpFKq2Hlmhzfza3UvY2mP1XCyUx
         00P2rbsudUh8pUcRr11rXEubgT7lat07aszTX04p1rs1cBV4eoasZNV2S9K2MYsmA4wH
         eNOMSfajkQCu76lv1JhYKBDZNSpnxn4vg9U224TpUxbBhPqwnPaGK6VS6azahdiQ8fE3
         hE7vUVjATDOjfqmli3Gz+JTksxJjWJMkz+cve/LKDHckIdIWh44Zbls2y9PtTH+mXqjf
         WALQ==
X-Gm-Message-State: AOJu0Yxh/yj+dVkmw4b7wSgaXIDRlwnza/r1CXbKvnLso9MJoXWvOmxs
	O4GVg7pqJkj5A/NlrojiN1qVDPMQXj8XcE6kIP/yeWCHY4OFDNJ9kH8W7gh45klROWE=
X-Gm-Gg: ASbGncssaaY2KHbHa+4iwQ5fJo+8nPc2RCWF1YCe5+1zm4KaZqAvHPUkwgQ4GfvIS6u
	2/uCF4jxPA4olMLRWp7d45pUCgQS9J/UFdq4dt6wlckqwUPTPRT3lFhd/M/29y79Cj8jvS68ZzK
	hXX/LK92keBKRoRERVgnSaYOU2DOp4fIeHNXhorgXPZ1vwn6/OLvPxh4vI1reWWYzC+xKvqRQ74
	GUHJK9fQvgA92rm6Y5LSHo9vzzGLt9bVc5JtKMVr7tRjPed1gGd60yW+N3BPQvhN4Y6KBymU+3B
	090bBJEcSvQG6mreA+JIbt6DVGX35y17RA/Ra2ygCAFuRdB4vOGJy2HB0IyqcGWWuIY1UaQsSEE
	/yJdKyDw5J9lBYswP76kljru9M3EYxP0qK8YRLyu8xdumGEw=
X-Google-Smtp-Source: AGHT+IG0fsLJi/NVZ1/ziNxrgyZD18gc4dqp0HpWd7a9P0r35DxhIE6icjrA9lZempr35X+kXG5pyA==
X-Received: by 2002:a05:600c:34d4:b0:442:e0e0:250 with SMTP id 5b1f17b1804b1-442fd67200emr153675135e9.29.1747746100077;
        Tue, 20 May 2025 06:01:40 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a8cfsm16538095f8f.37.2025.05.20.06.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 06:01:39 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 20 May 2025 14:01:17 +0100
Subject: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com>
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
In-Reply-To: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
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
 Lorenz Bauer <lmb@isovalent.com>, Alan Maguire <alan.maguire@oracle.com>
X-Mailer: b4 0.14.2

User space needs access to kernel BTF for many modern features of BPF.
Right now each process needs to read the BTF blob either in pieces or
as a whole. Allow mmaping the sysfs file so that processes can directly
access the memory allocated for it in the kernel.

remap_pfn_range is used instead of vm_insert_page due to aarch64
compatibility issues.

Tested-by: Alan Maguire <alan.maguire@oracle.com>
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


