Return-Path: <linux-arch+bounces-11864-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211AAAD063
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 23:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6F43ACDC7
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 21:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51639221FA0;
	Tue,  6 May 2025 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCrmcGub"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5C221F32;
	Tue,  6 May 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567576; cv=none; b=py7SxVw4X5RRcxRjqmlJeP924GCTrA2FXvmpLcDo8ltWjF62LvPVvYe5cO5lF7qw4bTUv4dEY1LOONbIJCnlTkYCj3WA2ndvhIQoj/9+0ggzlGBI2NStjhtefJ40Xj0TgJW5IJd+qK1cTr4ljeLLxcMdahd6j3ubpnlShhReaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567576; c=relaxed/simple;
	bh=aj6Wa/BxvisBUyM6z+CuE8LXB/JkGU/LICdWFH6Yz7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5oYCVCVLHlhaeYcyoClR9xLzIeuSZudsP+TGGc+Vj7/YQbiJLHE5Gwnu98M7I0a+th4iC4qRyt78EFGS1mCUmfy99bbVYhbjaKAX7oRiRtadi0l64q7OWpMARFJ3FCawxPXUJqxyfKnc+fespB+KFoLN4GayRa8qLIKD573N2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCrmcGub; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74019695377so5110336b3a.3;
        Tue, 06 May 2025 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746567574; x=1747172374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArM5dlMoYg2RFoYEdOLIGATcWwbGLoqA/9nIToevMcw=;
        b=hCrmcGub/esiDZ44Ryo33X9GCVex+vcD7Cd5d1YvOH2HGwIcgB6vU6Bzgo3fpeDVLs
         iE+p+K4EQ5T9EW5b6Di2acai8HEAMdeZQRYhpT65LF9WmpfQhBIPT58LKqfXe06FKD5+
         e8XAFkKB5pHyZeInma+mha9umBaNgCTrtsbqr7eUg+mkgxgN+STkxNnZM+S9RPWLbPJX
         LdrevbKdLwvxkAq5H5WGNGPw6e54k6i+fF71vcwejHUh5H/6X5mm1+A13144626h16Jc
         7yj2M4NlsXkwXhlrub5iigtK1lpHu9q5kMTg5bTy8WgWUBcZTeSBRV4TDyCTvs7p4xH3
         mJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746567574; x=1747172374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArM5dlMoYg2RFoYEdOLIGATcWwbGLoqA/9nIToevMcw=;
        b=K9BcOZKuDkSYKwgFgUZFp+O7Jf0wfM9xagWV3Fwn68BdeSCfUQQZnaADNhxaOCwjzV
         MLVNyy6YQovjtOW6c5vHMFTopja+3O4euMuZICHbTGIKCQkF6zLNdd94AsXmw+qjpwIq
         8XoG65zu3xoZpXGIoMD1uNCaHKBJYXY5h+6+jVp1WB36UAP+uKx0y5iEKtHRHCJVoRxj
         LzhNTBH+dyN/0hb0e2kDdLyTbFa+owPapmZeiDALtCs5My5AN99viceuFKuYPHMKANd9
         +pQ1ZVT3ijjOInwDTtBAozBGtMIiTe+Rt5UQERQJilIRPGT3pQLoQLUeNB1hoxUCsB1+
         26MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHC/96f/7YbSnWZvw7jGveJmnJ1ksWEBqJy2BQcfFIcj6gUKCliVU+J1cs7wW6DTfjjBdNjoLxMWCBojGa3Uc/@vger.kernel.org, AJvYcCUtenbkZW/5IMiM6yuLubOgRtpxOBtlvkM3kJzs2707c1ocq5SMULlB+36Ah30pEdX/DIT/RJjsjrOuQ0WX@vger.kernel.org, AJvYcCV9nYpRQAORETpIDdlM4VUYUZY9BPj/ArhfuGJb7aE6D7eUGNvtDYLPpBlOHMkz3dewwHU=@vger.kernel.org, AJvYcCVV53R0FfT2uO4cunFakFQ55JJRa7tQPWA7B1iuNJk+UdwiPucb4JTjvdyTUdlykxXR+jRDyM37pqPHyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SLvc3/EX5yQPPPr6APC02Xnrx4WQlQDFnDBTSAs3pNfvxw2t
	JC6hrDiu2kCTFES5rDF13UYuYRI11gEnxATC4rvq/pvaRQxiKu/YrXVP/U/QiumResE2qc8/dN4
	tkW8E0ZeonmuYiYNSz+bN26aLjhg=
X-Gm-Gg: ASbGncuzwEOaxje8oAAqMPy4Pd/2DTIcKhKhTX9JEZu2V5cyGvUkdbWiQBdLNDN7hjm
	UHXXeLAaCxWqCHfc+nMH3KEEGGLx15tC4q+qbOrvfG4+RFONnTaRZ0qG3YnJI+jnRbxzm+hQcz8
	/p7xd+bRE1IM7aV54z+N8ITgOhGbNs0LWenj5q3+IWYAW1L712
X-Google-Smtp-Source: AGHT+IF6+tZWso5Z6kOClTOh8AzWjUjHLEGhrWPv/n2ZbHBh8cm9FwumNME/x4Y2ZzuB76UxDM1V4gC2/XSVI6MsQUg=
X-Received: by 2002:a05:6a00:32cb:b0:740:6fa3:d323 with SMTP id
 d2e1a72fcca58-7409cf47359mr898812b3a.11.1746567573782; Tue, 06 May 2025
 14:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com> <20250505-vmlinux-mmap-v3-2-5d53afa060e8@isovalent.com>
In-Reply-To: <20250505-vmlinux-mmap-v3-2-5d53afa060e8@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 14:39:18 -0700
X-Gm-Features: ATxdqUEvLG3gTRtRTgXjmcSZoDP2TBHJQ2z5q36B5aPjJrR1X7DuAOfId_WtX1E
Message-ID: <CAEf4BzboH-au2bNCWYk1nYbQ61kGbUXuvTxftDPAEGF1Pc=TLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests: bpf: add a test for mmapable
 vmlinux BTF
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:39=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> Add a basic test for the ability to mmap /sys/kernel/btf/vmlinux. Since
> libbpf doesn't have an API to parse BTF from memory we do some basic
> sanity checks ourselves.
>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 83 ++++++++++++++++=
++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_sysfs.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..3319cf758897d46cefa8ca25e=
16acb162f4e9889
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/* Copyright (c) 2025 Isovalent */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +static void test_btf_mmap_sysfs(const char *path, struct btf *base)
> +{
> +       struct stat st;
> +       __u64 btf_size, end;
> +       void *raw_data =3D NULL;
> +       int fd =3D -1;
> +       long page_size;
> +       struct btf *btf =3D NULL;
> +
> +       page_size =3D sysconf(_SC_PAGESIZE);
> +       if (!ASSERT_GE(page_size, 0, "get_page_size"))
> +               goto cleanup;
> +
> +       if (!ASSERT_OK(stat(path, &st), "stat_btf"))
> +               goto cleanup;
> +
> +       btf_size =3D st.st_size;
> +       end =3D (btf_size + page_size - 1) / page_size * page_size;
> +
> +       fd =3D open(path, O_RDONLY);
> +       if (!ASSERT_GE(fd, 0, "open_btf"))
> +               goto cleanup;
> +
> +       raw_data =3D mmap(NULL, btf_size, PROT_READ | PROT_WRITE, MAP_PRI=
VATE, fd, 0);
> +       if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_writable"))
> +               goto cleanup;
> +
> +       raw_data =3D mmap(NULL, btf_size, PROT_READ, MAP_SHARED, fd, 0);
> +       if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_shared"))
> +               goto cleanup;
> +
> +       raw_data =3D mmap(NULL, end + 1, PROT_READ, MAP_PRIVATE, fd, 0);
> +       if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_invalid_size"))
> +               goto cleanup;
> +
> +       raw_data =3D mmap(NULL, end, PROT_READ, MAP_PRIVATE, fd, 0);
> +       if (!ASSERT_NEQ(raw_data, MAP_FAILED, "mmap_btf"))

ASSERT_OK_PTR()?

> +               goto cleanup;
> +
> +       if (!ASSERT_EQ(mprotect(raw_data, btf_size, PROT_READ | PROT_WRIT=
E), -1,
> +           "mprotect_writable"))
> +               goto cleanup;
> +
> +       if (!ASSERT_EQ(mprotect(raw_data, btf_size, PROT_READ | PROT_EXEC=
), -1,
> +           "mprotect_executable"))
> +               goto cleanup;
> +
> +       /* Check padding is zeroed */
> +       for (int i =3D btf_size; i < end; i++) {
> +               if (((__u8 *)raw_data)[i] !=3D 0) {
> +                       PRINT_FAIL("tail of BTF is not zero at page offse=
t %d\n", i);
> +                       goto cleanup;
> +               }
> +       }
> +
> +       btf =3D btf__new_split(raw_data, btf_size, base);
> +       if (!ASSERT_NEQ(btf, NULL, "parse_btf"))

ASSERT_OK_PTR()

> +               goto cleanup;
> +
> +cleanup:
> +       if (raw_data && raw_data !=3D MAP_FAILED)
> +               munmap(raw_data, btf_size);
> +       if (btf)

no need to check this, all libbpf destructor APIs deal with NULL
correctly (ignoring them)

> +               btf__free(btf);
> +       if (fd >=3D 0)
> +               close(fd);
> +}
> +
> +void test_btf_sysfs(void)
> +{
> +       if (test__start_subtest("vmlinux"))
> +               test_btf_mmap_sysfs("/sys/kernel/btf/vmlinux", NULL);

Do you intend to add more subtests? if not, why even using a subtest struct=
ure

> +}

>
> --
> 2.49.0
>

