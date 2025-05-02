Return-Path: <linux-arch+bounces-11791-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B15E6AA6F63
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8C71C006C8
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6D23C51B;
	Fri,  2 May 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="dUcTnWQ1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD523BCF8
	for <linux-arch@vger.kernel.org>; Fri,  2 May 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181236; cv=none; b=WUo2+7zASr1lFPvxQ/mUInW50M0ETZhEHvmQPbNN6/U8/gN/ZW6D2IDMg1grKNoIgp9Ne3TgOesr36biFNNJoZwegk8TiUuPwkNnt32HsGQJzbUxn4+coUblrEJx53PLFbQRKWmkhEI1QZ5r1pyFRhoeJ2AL6Qjz560p1Ln2FLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181236; c=relaxed/simple;
	bh=Ylo3Ub/c876od9q4CA0Wfm+gRvKVrvDK1NgJ0c81mh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gy/PhfJaMYQrYkbVXD7Fkvmc+LaXE8YEgoIkDvg3CgjAVYl7A/F9A4vdhjJSwEqPakILkR7r+pv4IxZ6jb4WJZChYXfGYH54OTlTfdrdnrFTrsHfRzfPDVqqmkwyH9Ca7JtJ9If+sdkkk2QkXqswrexJ6Owsvq23rXC5o2Ey3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=dUcTnWQ1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so1891763f8f.1
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2025 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746181233; x=1746786033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD+xFPWezuPLNquEIvrdXCnLiFoEsA81xbyY7WvgQlY=;
        b=dUcTnWQ1cEAUu2Iu1iIMpVKJEAn9HH8XH9ncspHgXzZG1mTgwpV0lyseuvgrDHIZFn
         pW+TcZjzpbgSKZ3C84D0Bto+9iiuFGNB5N1veKm8pFM4dGU3Ku3sDzynI1KnlDanK9Bq
         2T07kqYPbV7Pzq37vCiRdtTZYzxPGjHFb21q1/HYzdAg+A6bnwrr9YvGRauJ9Xm87DU/
         PCy9AW/bBbm2Zv3NmN2mQoIBajB53xMBIDZqrxt1nalv6fEWRs3rjuLnNJyGRg6A0pvP
         qn2CE3k6PCchYuR4RyXQMYPB4+X+mDe34GdYS/vxm30KhIAKryJ8USUNY5zKbDmScGPC
         /sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181233; x=1746786033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD+xFPWezuPLNquEIvrdXCnLiFoEsA81xbyY7WvgQlY=;
        b=HqZCOj6tBPHVJyTZ8N37H3d2KHVO3pWxSkiEm5txTK0V6PsHzg3Rua7CLXye62lyVK
         JPWSQQaLqeWyGq0NwzvElEUmsHnhEa5XNEXZH/0oiUafoSS+CYmUqLMpcugijHsvWQEK
         gQv38wL0l7bXm8wY3frXKwZkXWdckRV/kmHHVTvwxk2MOY9/sFAfbCc/z+oE2Kx4mn4g
         Evf51BXZ+wv75TwTWhnHIyLJMmN+U0TCFVWAylNYH5EbYpjdIgUGBAjrqQmcYJ1umc04
         vfri4kz+TvBpg/wkqXOLQB2nMWSB7+PWIfgmbOtSt4l0plGGMRdDB+JCjX+kJ93FM0UZ
         CgOA==
X-Gm-Message-State: AOJu0Yzd7eChwTzZmhEESQ9+7eO+5TbcTq6corCxzzHocpeBZWbI6ebJ
	wcd0ljC7CHBx5lruMgGpaMH0n12y+wjDWJ9QnGPznibsjh6liVOOqXrxs8XBgV54iLxWgZPTEa/
	O
X-Gm-Gg: ASbGncsdUQYapGpmtaaQnZt8VlDhLXjS/4dXNjQBeG8fdiUo61WpQo8btKNLoC+QMdy
	olTs7IHJ+IJiwjfn2TND6H43+I3NYkCb68lEfXJKpD+YLSPA51AGsdr7+6C6YA0TOQgcCD5hMjJ
	35YxWa7CI8saz0kAUF4txW8WsdJqOWUnSQUyRzAPudX/03oK+mfcamBbYXrDJDBPnxqXhjILRS/
	1+nRFX/0eqOC9OF+7EUBr/CV6X15BvxmiPyWYYgp47ypLRqquNfTunKPxdSXgPhQsCzlfidU1KO
	QHCZ5J7eteDLiSvB1sknMpffs6yVcC0RqmaYHWeRIbfK4HxaD5BHEFj4w+qc5RwE4hH9YeQveMz
	/hohyFJzcXrJIYfDD5Qv/blqTu1MGZ/sXjY8lsk4NymEtqrk=
X-Google-Smtp-Source: AGHT+IEgYQYFDekPsQClBf5vIZVQdcfJLacTov41mJCtxCQP8j+WAhf+6C7cqk20Ftn9GIBaFYncaw==
X-Received: by 2002:a05:6000:2403:b0:3a0:831d:267c with SMTP id ffacd0b85a97d-3a099ad95cfmr1478745f8f.18.1746181233053;
        Fri, 02 May 2025 03:20:33 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17017sm1742342f8f.92.2025.05.02.03.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 03:20:32 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 02 May 2025 11:20:05 +0100
Subject: [PATCH bpf-next v2 1/3] btf: allow mmap of vmlinux btf
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com>
References: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
In-Reply-To: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
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
 kernel/bpf/sysfs_btf.c            | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

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
index 81d6cf90584a7157929c50f62a5c6862e7a3d081..f4b59b1c2e5b11ffffa80662ad39334c730019ee 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -7,18 +7,50 @@
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
+	phys_addr_t start = virt_to_phys(__start_BTF);
+	size_t btf_size = __stop_BTF - __start_BTF;
+	size_t vm_size = vma->vm_end - vma->vm_start;
+	unsigned long pfn = start >> PAGE_SHIFT;
+	unsigned long pages = PAGE_ALIGN(btf_size) >> PAGE_SHIFT;
+
+	if (kobj != btf_kobj)
+		return -EINVAL;
+
+	if (vma->vm_pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_WRITE|VM_EXEC|VM_MAYSHARE))
+		return -EACCES;
+
+	if (pfn + pages < pfn)
+		return -EINVAL;
+
+	if (vm_size >> PAGE_SHIFT > pages)
+		return -EINVAL;
+
+	vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC|VM_MAYWRITE);
+	return remap_pfn_range(vma, vma->vm_start, pfn, vm_size, vma->vm_page_prot);
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


