Return-Path: <linux-arch+bounces-11882-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4627AAB23CC
	for <lists+linux-arch@lfdr.de>; Sat, 10 May 2025 14:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3F17ACEF1
	for <lists+linux-arch@lfdr.de>; Sat, 10 May 2025 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA18258CD6;
	Sat, 10 May 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="S7dgPmSn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF93257ADB
	for <linux-arch@vger.kernel.org>; Sat, 10 May 2025 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880516; cv=none; b=I2nR2ciWwBMCjSoRxfIXyc6Diq6Z6BsnRYyGOcIhyR9kZLwos6yZ1pTuN1Tfes0ivJ5eeQ3ngYBSsfWFWtYl3Ifqc+6/ZICM/4p2+FuOa/00Wh4Mslen6nqrR/Pyz7U+pDCER8+Kh1elsbG2kTaPDuSKryJBHQRFYCflHBRkQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880516; c=relaxed/simple;
	bh=E4dMNNnVTsxU67yMkTyvHQT6LvBD9dD3EKDdUb1spL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c+gFGAWfhDHwgH5CR9s9EmQXup0xhEncmdkQv5U6g7Anr+xHgojNMKophPBFbnkYGXNpsyNbLsKmH3VVmnYqQOHnawQKERwp+Eg0Ol6AV3aiNDUOYBER8VxjHRCAKzvVp+3ih8q8m/5onAsMNqo93cKRMq6Q7v2BtD8UnuAQojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=S7dgPmSn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so54175526d6.2
        for <linux-arch@vger.kernel.org>; Sat, 10 May 2025 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746880513; x=1747485313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSmxBWoHOESSY60Jb4jCFImphntRhbF/jzT+yOUkKiI=;
        b=S7dgPmSnNNazETW6TQjbweZPw/gNgFpOkAaREbKCCl9UKZNMknX5A93rt4Xa59Anzu
         JFdQ5YLxWIcyagD5i+9hvaS6oYCDJeL94I99I1DmSPabvMcsBRd6Mb6fTT+hr1DC9bvQ
         DFWX3ZlICC01a+kRz6txaACNZUyDhybQcBmsgpUQpMRnkRDReMYbzsTH1njfpJAMsfhp
         idR2fnjcq5407bUJLLZZUYQj7lyn+CX72U81vJboGS2W2qnCPLzxOyB52rImaBL6TgzP
         lc0zj3I05BP6nQglv8pmq9UTJlIPE/c+qCtHeKSX6XqAonIwG9XzOazafuadXywnJrxa
         BVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746880513; x=1747485313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSmxBWoHOESSY60Jb4jCFImphntRhbF/jzT+yOUkKiI=;
        b=u4TO1H2Bfmvo90y8q8wR8JPG5dQlFNxwmp8gQsIZhP7HR/eK/2M3RwVXEQG0ICUy0g
         6JQCjE5CmLggFQi+795f+nYr3wbk3R5k1QX9EAIFhuZ4dKti6gLJLT9S9eLJ7kn5Hj6m
         lQToEFNnRmD9XCQtnzqz+QD/TIQPmwSJpfRrd421eG2FOl2WJ3PhAQDZ9aofZyaF+UNe
         k9f9MFODoZXUonffo/iMur2yZ2P/T7EUre/MjgcmuyUVDx99wcZr5YHWMqYV0hgbhbhr
         VTzO3Zam9h+QvtVzPXf2afIqrtYTVOKSce4ahzeZ6//mMQuBer0BnP8T1x1/oTXq/yaq
         oFMg==
X-Gm-Message-State: AOJu0YyxC1fVz3sdqPCcfFqne3sJmvmwdTp17sTj8YU4o1wr/kKzDlUp
	GujpZjhpzk3Ozg5PjoVu0rgHIuiUvUnFa4kWIfUmCRiqRp1Kpdq1MmccqYiRuk/ahu6XaPS6Nhj
	v
X-Gm-Gg: ASbGncsIiT3ppfY4irLFcvPt4tsR99GTLM+96CrK1V7+omHAKcYVpgZDMoNx5kvxrv9
	2wNEkOMRVNfneSQ9jYLgUphbL5/i0RnbntSiurJ9D3WQayiuGD5pZEXpuGo3BZaOikN4NEjz4oe
	vghnLKKxz2Ji0e5X4QxPr8ASQ/3EvEPJhIMk78Q6/her4FtzWd9lddH5jpjCkRNbmCmNTUjIhJH
	4RKoGT0YkN1+f9pelYI5fs/Y1Iz6OCloglHFhmkw79vCpVKtNdLjZm+E91FLZyrZ0O1jLedzE1A
	7bL0Yqk8SEmkBe8nQUn108PN7WvJhtHk2ZEWwtHkp6Ckpq6XRHSnyqkny1kGgYlJHncGLxZl05B
	tBuRBcA8=
X-Google-Smtp-Source: AGHT+IFDBOzsnKDQDmN5hEIHEOheS6MBFMmjcf/7s7AIHD7p09Y4avPfN2YUFnkpyoryFPv6mOLk+g==
X-Received: by 2002:a0c:f68d:0:b0:6f5:401b:c985 with SMTP id 6a1803df08f44-6f6e4841d07mr76743466d6.42.1746880513549;
        Sat, 10 May 2025 05:35:13 -0700 (PDT)
Received: from [192.168.1.45] (ool-182edad1.dyn.optonline.net. [24.46.218.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39f588asm25725556d6.49.2025.05.10.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 05:35:13 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Sat, 10 May 2025 08:34:55 -0400
Subject: [PATCH bpf-next v4 2/3] selftests: bpf: add a test for mmapable
 vmlinux BTF
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-vmlinux-mmap-v4-2-69e424b2a672@isovalent.com>
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

Add a basic test for the ability to mmap /sys/kernel/btf/vmlinux.
Ensure that the data is valid BTF and that it is padded with zero.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..3923e64c4c1d0f1dfeef2a39c7bbab7c9a19f0ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright (c) 2025 Isovalent */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+static void test_btf_mmap_sysfs(const char *path, struct btf *base)
+{
+	struct stat st;
+	__u64 btf_size, end;
+	void *raw_data = NULL;
+	int fd = -1;
+	long page_size;
+	struct btf *btf = NULL;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (!ASSERT_GE(page_size, 0, "get_page_size"))
+		goto cleanup;
+
+	if (!ASSERT_OK(stat(path, &st), "stat_btf"))
+		goto cleanup;
+
+	btf_size = st.st_size;
+	end = (btf_size + page_size - 1) / page_size * page_size;
+
+	fd = open(path, O_RDONLY);
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
+	raw_data = mmap(NULL, end + 1, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_invalid_size"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, end, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_OK_PTR(raw_data, "mmap_btf"))
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
+	/* Check padding is zeroed */
+	for (int i = btf_size; i < end; i++) {
+		if (((__u8 *)raw_data)[i] != 0) {
+			PRINT_FAIL("tail of BTF is not zero at page offset %d\n", i);
+			goto cleanup;
+		}
+	}
+
+	btf = btf__new_split(raw_data, btf_size, base);
+	if (!ASSERT_OK_PTR(btf, "parse_btf"))
+		goto cleanup;
+
+cleanup:
+	btf__free(btf);
+	if (raw_data && raw_data != MAP_FAILED)
+		munmap(raw_data, btf_size);
+	if (fd >= 0)
+		close(fd);
+}
+
+void test_btf_sysfs(void)
+{
+	test_btf_mmap_sysfs("/sys/kernel/btf/vmlinux", NULL);
+}

-- 
2.49.0


