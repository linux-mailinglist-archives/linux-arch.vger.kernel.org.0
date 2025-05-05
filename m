Return-Path: <linux-arch+bounces-11854-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D113AAA9BB2
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 20:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A76E3BE37A
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E672701A5;
	Mon,  5 May 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iiTwDxYY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6626E15F
	for <linux-arch@vger.kernel.org>; Mon,  5 May 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470386; cv=none; b=XcrMSpQbEZtdEbQii8ToKYwFTCDTsa6P0eUSI6hLrZ7IUhjj+sBnKI5DjIf7sFTB8tnlwQ5GXgY4BThKP1t8WGobg0mgh2uCvmR8vCXvRNtdtqicoBXbUDlwBTqkTby274d5es218ctEulfuvI0El9aDzA/h4VccoDiTR8xS8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470386; c=relaxed/simple;
	bh=CztS+KUwtw99mOFMGWop7TTlPlQPx0Dh4oY50Ajoq88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=beGGBMOcylZdUG0ZOfCLyPwLToYAXO9tm4pqN4GW9QORmw3mvsD2Z9bWCdyB1RhIY7gckZEL9zYh/HRu2JFBeWNCTBlTESrAkkFl51CUkEXDP7uBQSHmYqGQft9WD7FMHbnpt4UTysVHusa3Qbm9ibpPXYcq5U5FQojP5So3bQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iiTwDxYY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39129fc51f8so3044333f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 05 May 2025 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746470381; x=1747075181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzNe6C0edsjyIWPceeV4C4p+25KcQZ/7bKBRPqQnHyY=;
        b=iiTwDxYY4ymP7BQOSu5mxaqnasgJaQdF3cqryvZ/dRTGG5nDgk6AAEgZ1FHEbw46J6
         HicIP7thkUanFXMxBkFdMajvwBFtV5+0PY5QEAMw3q6ELKBoKj1hqSfWsVYY4pRRJ4ga
         dIRv/n0TP0YTJfDJN6CglfVNLO9Z53H60+o5hQE0UiIoOHlMrGwsF5qOdsBRS0HpXEgt
         vb5LRK+3+Iak5+t3Rz576OdRUfvqao2SRbqwDot0x6mzS0bx+AjVeHcA6Me6DEF5iquA
         K4io8QAaGH1TljgXNermtvZVbcmFBzagwN3AuwPhowHlU7Z80A4DyPv1swdyuT341r9n
         7X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746470381; x=1747075181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzNe6C0edsjyIWPceeV4C4p+25KcQZ/7bKBRPqQnHyY=;
        b=j92m6WR7nO4CAwtBm8I1AN/16ywqEKyi0syPcNeM0fYzrn7d/1JydeW3wvIVjHvxwA
         trPZqrllyza4WDnzCg0PuK1RbVPLrbPvDe+4i7AflTYnKqKQ5GL1wKrzMy8LLbgCTUaI
         iICMs8w+Y/1LBo68Iqyq1P1/7IV9z8R+qa2FryS40EKIybkKaQdFr4KC6KpzeRbzYo01
         6GpmY4I6BHzLcTrBDBDcrLGgbD349ha55zChX8KvBhl4SVgmdoeVA1XaGNzJPvPVCWFA
         4ad/H8PPVt/k0d/MfJCC/nj/lymn2jPWBHBHPF58uvpfVz1Fw2ED1N199c8musw7e0UG
         fIkw==
X-Gm-Message-State: AOJu0YxBP26kee/zvheRla0PxM3ph3lX5+Eb9dwct/H49JfmJ4Fnq6Lh
	JX8nDQU4ZrMjEJIRNRZjN3Dc7kg7tuC5uQCDDQtziVVyrTxD1wNOuf4LBFPLIgo=
X-Gm-Gg: ASbGncuch/wd4B4qA7pSZhHc7zuesfelSGWsve/Z0HRH6jZMLD8NrKP96DAO6OtinFU
	XkdtJA1Dl6ADD8dBIQDg7SylqrM22kx+TcwjRA/EDhd6D2vOBp7LuFNSxYhU+bXL9iI831g0kx3
	6y6TAh5uM65/FGTnwlJmZS5YsLZ93uMcjSaQBTYNTN9LN2AF3tdvxQh4bsiUGfTrVoWSye8lSuo
	80iT2jbhpoURpF7f2Z7q9Kx6in0xeeHpGCeju61xcmcaoY+OF9coSc4D1qEdpaGfCZIlE4udps7
	n8ph/vV0+AHV6Myqqz9vVrCZhGVJyAKrRf+wPBteyNxz9TXFvpaTAuAXvmapQbBpIs7UFytRybZ
	NXQ68QC2vIMGIhNjyQlmvlwf30xvNATMrYmTG
X-Google-Smtp-Source: AGHT+IGwUA9SurKLxWLh45mHH6adoDU7MQ2Biah9osWdbgtkUBvKKSZQdOCU6OvgAcD3Wg09VVAOEA==
X-Received: by 2002:a05:6000:18ae:b0:3a0:aa06:1d8d with SMTP id ffacd0b85a97d-3a0aa061dafmr1084271f8f.46.1746470381511;
        Mon, 05 May 2025 11:39:41 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae8117sm11328877f8f.56.2025.05.05.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:39:41 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 05 May 2025 19:38:44 +0100
Subject: [PATCH bpf-next v3 2/3] selftests: bpf: add a test for mmapable
 vmlinux BTF
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-vmlinux-mmap-v3-2-5d53afa060e8@isovalent.com>
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
In-Reply-To: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
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
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..3319cf758897d46cefa8ca25e16acb162f4e9889
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
@@ -0,0 +1,83 @@
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
+	/* Check padding is zeroed */
+	for (int i = btf_size; i < end; i++) {
+		if (((__u8 *)raw_data)[i] != 0) {
+			PRINT_FAIL("tail of BTF is not zero at page offset %d\n", i);
+			goto cleanup;
+		}
+	}
+
+	btf = btf__new_split(raw_data, btf_size, base);
+	if (!ASSERT_NEQ(btf, NULL, "parse_btf"))
+		goto cleanup;
+
+cleanup:
+	if (raw_data && raw_data != MAP_FAILED)
+		munmap(raw_data, btf_size);
+	if (btf)
+		btf__free(btf);
+	if (fd >= 0)
+		close(fd);
+}
+
+void test_btf_sysfs(void)
+{
+	if (test__start_subtest("vmlinux"))
+		test_btf_mmap_sysfs("/sys/kernel/btf/vmlinux", NULL);
+}

-- 
2.49.0


