Return-Path: <linux-arch+bounces-11771-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9879AA6001
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521147A7A85
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B520298E;
	Thu,  1 May 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="buCczSth"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857BE1FBC8C
	for <linux-arch@vger.kernel.org>; Thu,  1 May 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109712; cv=none; b=qI2YxoSZNN3HRYveQAB4cPDOzt4JTrGX4zFigmSxDI1cm8uI8exMny5DEqTgG1VHApHBgwiQyFLqwKlP4FJx0lXVypT5lAIdOEqcEAZsn/bx//oEKsUHeE4U/4kvEx3o+EszOjMGuZZtcU2BLEeV/v5U0RHI8I+izygLe/+L6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109712; c=relaxed/simple;
	bh=UHf0Gnh8ksl5dQCn2tzgemavr4ewEn7RVYTj5JxtNW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rRDGy2Go+PqHvNB1j7b9fBDaKll+ERXamuNDCv0Rm1bjGH8YgogvFCDDOyaWuv+osuZ6mCkFXPIFz4swjcOI7ELAbjco7DsBuNNVyZFlLIU/12leO5cc9e9ZL1MS+6vCYJH3jebSe8x8oR9un+tPl25rZ2vfEJdt74PvsAoLFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=buCczSth; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso632606f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 01 May 2025 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746109708; x=1746714508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DcGQefvvptQYw7ehSGQN9HwujMvdj5ehwVheaE79Vw=;
        b=buCczSth0/Yuz7dl0yp9Y3lXiuguynm+Hqk4NgKbCgX595+O1a6Ga6BXpWzCHwvzTR
         qN3TylHzcwBzJHvEQR8qwFd4W8uLAgJCmafR4J2Ny6HNGQsNTqTpgacx6cYAKECMxV4T
         oopaCoCpiTZRi0OFJG9bTeXVPnPtQUbTm/p92ib2VfOoOPYB8iuELWyuXLRqWc5gtmKn
         4A5+vA3S8R8GI5S2Kp23rGn0rLi2oO0x4Fg4HbekbeTLg8AQH6SOC6tY0yO1FtVn7cMV
         aKxB11yvnJhrqbxHsiyV4G17jevIZgdgB9MAsASsccVpBkPw0E9Z1SvucqQO43DWNnYl
         kFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109708; x=1746714508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DcGQefvvptQYw7ehSGQN9HwujMvdj5ehwVheaE79Vw=;
        b=OZHu5YY72H3zNocrMTmmbZJ814TmHCKnOgNIQ7RmdaeByKbP8Vghh3W/0l0JFzhVIJ
         y3yjUjh4jBtd1X9je0h2SCKEj16qr1RNNafTv58vAJIldOB8EEi13miu3QMFOmSdh/nt
         ls58RANGuH+xTaWz0jb18n39KHaecfEmVF6WijVy0gq+L/cGKojmZallhc4Kv0aLBjtb
         9FyG1QTz+V15ILrje4Q5/ZNAa4K5bSZywwLtr5ziNDAAVd2lxEN9thlTL9bde8Dwoa3r
         Syw+hIbF+k9m2dIF6zYrXSbK7ecKyVBVnNsYv/++q0gZLycPVc0xBmVc28w7GDGoWbOp
         HKiw==
X-Gm-Message-State: AOJu0Yy24MilPTS23d9H/wic2gCWWzYLNqvXT2qgmg8sdEus6xyoYY8Z
	75N8ciB+ePxDRkZla7Y1KevsPDKAgQ5O3OrYxRHv1MzCXgw9otSuvfWasm26TjI=
X-Gm-Gg: ASbGncvDw+l2jhYfjrhIgfsqYNQKj7yv5/0xt1Yx6hFmaN5hLfW58s9gKLksfEsTxPd
	MZgUbVQOthd/g6sflEMiNNIZBmVivTka7So34sR9urD0/et+hei2Vip94trk+NPA4oyhHk5jupR
	ZPhgyfkUH2u7FD00a/Idq4SveN6OIqqIfe3eEDIwaMVX0Q8zhRxh7C6Dc81rTcjNUoW2dsjk0xT
	Z0F1I4IchBSG2RaAZVNy+VxVyJUEnC3vxpBMw3xwimCUTdKlJPaGrvhKwTe5fpJhSreOCA1dW6T
	PFBJ/y5cOMzfWs6tCU4o2WNdzq23wHEz9VnAr7DhVoODaZqvstbW8NnOI7bP/ZnYO/yfEJ+JlLg
	NEsAFk7T/QTTceKDmASB8gagGSw9ORSeEV8yy
X-Google-Smtp-Source: AGHT+IGYI7eWshvOXOMSQIj5XTh7ey/sDlfBCCJhBg/3GXyALEfYIYT/c6FPdhLIsltARyEhoSfGtw==
X-Received: by 2002:a05:6000:2af:b0:3a0:7f85:1905 with SMTP id ffacd0b85a97d-3a094003b65mr2315851f8f.0.1746109707752;
        Thu, 01 May 2025 07:28:27 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d15dasm13908445e9.16.2025.05.01.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:28:27 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 01 May 2025 15:28:22 +0100
Subject: [PATCH bpf-next 2/2] selftests: bpf: add a test for mmapable
 vmlinux BTF
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-vmlinux-mmap-v1-2-aa2724572598@isovalent.com>
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

Add a basic test for the ability to mmap /sys/kernel/btf/vmlinux. Since
libbpf doesn't have an API to parse BTF from memory we do some basic
sanity checks ourselves.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..8dffed136b4757779028ec0971b56ff541f2218c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright (c) 2025 Isovalent */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#define BTF_MAGIC 0xeB9F
+
+static const char *btf_path = "/sys/kernel/btf/vmlinux";
+
+void test_btf_sysfs(void)
+{
+	struct stat st;
+	__u64 btf_size;
+	void *raw_data = NULL;
+	int fd = -1;
+	size_t trailing;
+	long page_size;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (!ASSERT_GE(page_size, 0, "get_page_size"))
+		goto cleanup;
+
+	if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
+		goto cleanup;
+
+	btf_size = st.st_size;
+	trailing = page_size - (btf_size % page_size) % page_size;
+
+	fd = open(btf_path, O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "open_btf"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_writable"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_shared"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size + trailing + 1, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_invalid_size"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_NEQ(raw_data, MAP_FAILED, "mmap_btf"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(mprotect(raw_data, btf_size, PROT_READ | PROT_WRITE), -1,
+	    "mprotect_writable"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(mprotect(raw_data, btf_size, PROT_READ | PROT_EXEC), -1,
+	    "mprotect_executable"))
+		goto cleanup;
+
+	/* Check BTF magic value */
+	if (!ASSERT_EQ(*(__u16 *)raw_data, BTF_MAGIC, "btf_magic"))
+		goto cleanup;
+
+	/* Check padding is zeroed */
+	for (int i = 0; i < trailing; i++) {
+		if (((__u8 *)raw_data)[btf_size + i] != 0) {
+			PRINT_FAIL("tail of BTF is not zero at page offset %d\n", i);
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	if (raw_data && raw_data != MAP_FAILED)
+		munmap(raw_data, btf_size);
+	if (fd >= 0)
+		close(fd);
+}

-- 
2.49.0


