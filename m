Return-Path: <linux-arch+bounces-11793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACC6AA6F6C
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 12:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3CE3B55BF
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E693F242D68;
	Fri,  2 May 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="EePdy6mZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C323E342
	for <linux-arch@vger.kernel.org>; Fri,  2 May 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181238; cv=none; b=ojHivUi/4V7b4PTRlcourWkazkvnjOc+Vt2bvG3OU8CQjHzIp3tk2cKCV3iMO98biASZF7EbeWpkoj87EB7kJE+85mXrQfFbIM6BeWyTN9Xhm4K54wWeF4Q4gDXdNTgm82CcuL3cMZlzgZG5RoGB+Gh3uEJ4GXAhLL+alNqWstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181238; c=relaxed/simple;
	bh=quzy+oiKmkH1XS0l8BQk76AhdQTzPi5yPvtAtts2b0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVTqLFuWUjKVcNGNaDceg2/xUAfHDgwDeIxO7Fwh/SiBH2t92vv6Vw+W8TZHwMKAk612fH9oBCWnqY/WPP+FcyGVOJAH+huEkR62yqhPYZrrqVffmfiP4esf/10AdWVxI/siA89LNp9xaK7hrIxvqbT6mggTBLVkUsJ5e8a+PQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=EePdy6mZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so14161125e9.3
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2025 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746181235; x=1746786035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEuFMWf+++nFaOCapqiFSZIUsmPtR0H6XhXwGHSkKg0=;
        b=EePdy6mZKjV4SaoWSwREks0kfK5gQ5nXIFmT03La/tKgm8khaZcNcuBna9PmWSeTpm
         /f4k8OXc/xWGPqI/Nlt7SL5vbluTWxs1LyDY8WFnYiTLC7YCORoEySHo2jMGc+AD3CA7
         SQlDriVCPbDsTc0t9M51rK7vtZF6pf6y7cL4B1U0s+Rj/1DkYBLR7v5yoE6kMEWvKAtP
         SkgvbebwP3bolE9oNGLJwT1T7B6JHKgPFEbM0y5h3jo4aSZl/MWhxn8nWaVCyz8ioF0D
         MDrY7tAiKedPjwjwG+hmQPNz0Tpr8ghOkT21IJLQoI11yqVd3Kdk5ObtrJ+XAwHWqQCB
         34+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181235; x=1746786035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEuFMWf+++nFaOCapqiFSZIUsmPtR0H6XhXwGHSkKg0=;
        b=UNVtkMz+eEApGmll+WTEXyu9aIpAQnebUYKX1c2WW7Mx3GM6sHEwzlnbNiLnGa9gf5
         wvIE5cL23MilooBXlkN5qeFGCS+4RDj9pVMPsxwraU4tAdRc5cg8w4AYbxTcbvDNE5wU
         R5HUX9XMv12kxiN88AM1u4mAhWZ3RD4eg/j/AhRfuQuDMSlVgtokir0BwJQT0/Qbx2iv
         V7ceYj6evu/KElWiwt0s28FO+IggLH9bK2qKxBpfXOjNYbtvIG+vQ2lq5HZ8xt/PH/np
         ZgH67t+LHjcyufreVp/OcKuFlPm9pBV/TBDwo7SnLKad2EVdcwQ5EhGj2LEwbkn6DvEN
         IP9A==
X-Gm-Message-State: AOJu0Yzj0oKkd0WaB/P31HRTOEuoj8VO172mWyqAx+rvQLSN4qmXW7Ge
	1gETnQVa4b3GyAmbgVhKcyF+jgIPBZbmgN0ujyvvlGIiN9BHMpxNpsO10aeHmH0n2/QQ6dIobT0
	B
X-Gm-Gg: ASbGncvQ1RDGcQNyCDBpiSYh5c/jWtUO+KwNMjKFBAffX2VBsFkcOfnK4OI/kIfTziE
	ReFYizNWfJBQaYC6IsZgQj+4XEFeYdS5RSpIgMAIWniGhyKNMlfoMl6kvnXu5Bw9azKHJgneKiZ
	ohqTGH6TlBbNsLOZae3IDi6NytYCF4wlgAZWJ4ccaK6NWDL/XAC+ib/U7VoqWnnJiX/tGjTsqgF
	RK0li96iTWpOHLihiQchl/ohcTGkIwBvP7wl1v/UjEx4CTzQc1OKSYVp/DRZXpvG1HKI27wdc7T
	6meB1ezDkl06ijcPpg3ocota1l26QU+5qj4cxWv1jnWv32vM0a5/n/Mh4rlbHiwKkAYcQHdv2uY
	tDTgk/jAykTnKIupF6fTjcy12Odk+M7PBrSfg
X-Google-Smtp-Source: AGHT+IGn9fC3DpDvhs9DP+B0CN8coaybkrxuKY9DQr8oz0MG5WBeTGhKVHgO1SfA4CRoh5AC43jptQ==
X-Received: by 2002:a05:600c:820d:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-441bbe98af1mr21134315e9.3.1746181234906;
        Fri, 02 May 2025 03:20:34 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17017sm1742342f8f.92.2025.05.02.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 03:20:34 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 02 May 2025 11:20:07 +0100
Subject: [PATCH bpf-next v2 3/3] libbpf: Use mmap to parse vmlinux BTF from
 sysfs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-vmlinux-mmap-v2-3-95c271434519@isovalent.com>
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

Teach libbpf to use mmap when parsing vmlinux BTF from /sys. We don't
apply this to fall-back paths on the regular file system because there
is no way to ensure that modifications underlying the MAP_PRIVATE
mapping are not visible to the process.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/lib/bpf/btf.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b7513d4cce55b263310c341bc254df6364e829d9..7fec41a2dc617c9d388f9ab10d9850ef759c74d9 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -12,6 +12,7 @@
 #include <sys/utsname.h>
 #include <sys/param.h>
 #include <sys/stat.h>
+#include <sys/mman.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/btf.h>
@@ -120,6 +121,9 @@ struct btf {
 	/* whether base_btf should be freed in btf_free for this instance */
 	bool owns_base;
 
+	/* whether raw_data is a (read-only) mmap */
+	bool raw_data_is_mmap;
+
 	/* BTF object FD, if loaded into kernel */
 	int fd;
 
@@ -951,6 +955,17 @@ static bool btf_is_modifiable(const struct btf *btf)
 	return (void *)btf->hdr != btf->raw_data;
 }
 
+static void btf_free_raw_data(struct btf *btf)
+{
+	if (btf->raw_data_is_mmap) {
+		munmap(btf->raw_data, btf->raw_size);
+		btf->raw_data_is_mmap = false;
+	} else {
+		free(btf->raw_data);
+	}
+	btf->raw_data = NULL;
+}
+
 void btf__free(struct btf *btf)
 {
 	if (IS_ERR_OR_NULL(btf))
@@ -970,7 +985,7 @@ void btf__free(struct btf *btf)
 		free(btf->types_data);
 		strset__free(btf->strs_set);
 	}
-	free(btf->raw_data);
+	btf_free_raw_data(btf);
 	free(btf->raw_data_swapped);
 	free(btf->type_offs);
 	if (btf->owns_base)
@@ -1030,7 +1045,7 @@ struct btf *btf__new_empty_split(struct btf *base_btf)
 	return libbpf_ptr(btf_new_empty(base_btf));
 }
 
-static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
+static struct btf *btf_new_no_copy(void *data, __u32 size, struct btf *base_btf)
 {
 	struct btf *btf;
 	int err;
@@ -1050,12 +1065,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 		btf->start_str_off = base_btf->hdr->str_len;
 	}
 
-	btf->raw_data = malloc(size);
-	if (!btf->raw_data) {
-		err = -ENOMEM;
-		goto done;
-	}
-	memcpy(btf->raw_data, data, size);
+	btf->raw_data = data;
 	btf->raw_size = size;
 
 	btf->hdr = btf->raw_data;
@@ -1081,6 +1091,24 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	return btf;
 }
 
+static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
+{
+	struct btf *btf;
+	void *raw_data;
+
+	raw_data = malloc(size);
+	if (!raw_data)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(raw_data, data, size);
+
+	btf = btf_new_no_copy(raw_data, size, base_btf);
+	if (IS_ERR(btf))
+		free(raw_data);
+
+	return btf;
+}
+
 struct btf *btf__new(const void *data, __u32 size)
 {
 	return libbpf_ptr(btf_new(data, size, NULL));
@@ -1659,8 +1687,7 @@ struct btf *btf__load_from_kernel_by_id(__u32 id)
 static void btf_invalidate_raw_data(struct btf *btf)
 {
 	if (btf->raw_data) {
-		free(btf->raw_data);
-		btf->raw_data = NULL;
+		btf_free_raw_data(btf);
 	}
 	if (btf->raw_data_swapped) {
 		free(btf->raw_data_swapped);
@@ -5290,7 +5317,40 @@ struct btf *btf__load_vmlinux_btf(void)
 		pr_warn("kernel BTF is missing at '%s', was CONFIG_DEBUG_INFO_BTF enabled?\n",
 			sysfs_btf_path);
 	} else {
-		btf = btf__parse(sysfs_btf_path, NULL);
+		struct stat st;
+		void *data = NULL;
+		int fd;
+
+		fd = open(sysfs_btf_path, O_RDONLY);
+		if (fd < 0) {
+			err = -errno;
+			pr_warn("failed to open kernel BTF at '%s': %s\n",
+				sysfs_btf_path, errstr(err));
+			return libbpf_err_ptr(err);
+		}
+
+		if (fstat(fd, &st) < 0) {
+			err = -errno;
+			pr_warn("failed to stat kernel BTF at '%s': %s\n",
+				sysfs_btf_path, errstr(err));
+			close(fd);
+			return libbpf_err_ptr(err);
+		}
+
+		data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		close(fd);
+
+		if (data != MAP_FAILED) {
+			btf = libbpf_ptr(btf_new_no_copy(data, st.st_size, NULL));
+			if (!btf)
+				munmap(data, st.st_size);
+			else
+				btf->raw_data_is_mmap = true;
+		} else {
+			pr_debug("reading kernel BTF via file-based fallback\n");
+			btf = btf__parse(sysfs_btf_path, NULL);
+		}
+
 		if (!btf) {
 			err = -errno;
 			pr_warn("failed to read kernel BTF from '%s': %s\n",

-- 
2.49.0


