Return-Path: <linux-arch+bounces-12015-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C61ABD8A6
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 15:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96B64C08AC
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084C322B8A6;
	Tue, 20 May 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="TGZjvB2L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9622AE75
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746102; cv=none; b=tETFgMuQAg+QleAvJ/hEL0nIx1DkubfcspFy/0MTi65qpYVt9hYfVqqtn0CGF6HFT9DxW1pZ+6vtDdzRw0KfYUp+LSPFZTkSs8ZgM1010ocGolpK0FlWXytFmOzU7BlhidAGsIoWwBd3g+SDoCblO7S3FOzcsd6UvSgsRgWzxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746102; c=relaxed/simple;
	bh=34t1ctJUizMtaGCXNLsBowJ2GwafQ+PDmebniuWuRcQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ERnmdq3viWTDlBY/gIAMPnJhuSxgyh8tss4QthFdDd0kuu6fWBTo7v/IBEkFbgS8tB4dX/7w2K2zchlbqKPNAToO+kuQlWZ+Dm90WbOsn/izozSlCRDDAy3N37Dbfo0BdJ2DFCO1YVJz5JTNBbmj76HgsQWWYaaoYO1bh7HMgvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=TGZjvB2L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0618746bso44614955e9.2
        for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1747746099; x=1748350899; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALq+75rbc0YSVKBhmMHZ9TQaUd2k8+MFk3atSFaxTp0=;
        b=TGZjvB2LUIMxlniUq3MZA6Edl0zDjL1J6kyLs/ObOnBQAsFDxB5SqtVCcnbMYlYnEH
         VeoMg6for0eX/4qDlK9fLds0uOa1KYniTYDNZQsxF7wimcjyyUS9hBC6mGBETv4QSJLq
         +f2unQzH5sq+nJNkVovJPtbqKLDXKfx/KLNKGrF6XizxgKHkr+ToC89tPAisGQmtluHB
         jLOMITRenRhStiuuH98P0FD+2bo6135lyFyU9qr/RN0MlcVPaAaF4GkIVUGNL/+DeSJp
         0TFK4myc/SEvIU5l4JL2EwA5WZmAbnBhmLVsjkHYAcxuscedzmff3bOgjxlZ8YgA/TmS
         nynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746099; x=1748350899;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALq+75rbc0YSVKBhmMHZ9TQaUd2k8+MFk3atSFaxTp0=;
        b=n+nxeUpvenY6kPJuH0VwBQ7xHMRGgWwwcoT3G+419kVv6Se9h9/DE+HDNPjC2amJLt
         lQ49IM5tV1AEDL1svHtX6AsN2KDgXG6ij1N01kRpMmA04AZWA7AMw/FY21e9FG7AwJTv
         XnCCvCItHqdgqRNN6oi+JxryWsNKuZJQei/XVqTheQ6sTvB/qqdgOiEuZZGsaJoqDQe8
         mjw7BA0wlAJya3v5UELZxA00FB7Uq3z6AF9gkyoV06xJJrTPiNeEohUZiU+FTCAlqUri
         tpEUd0I0meV0npHxJiol7nEvi5fwLBgd+XberGyYCsA0TQfNk2Usi0T3CwFyksEmZidG
         SMJw==
X-Gm-Message-State: AOJu0Yz3rNN1KrtVnn60hKx4PmxV5ReE9iausLjXv4cCiT5WFthCGsBH
	sdfZKYiYczT/KU3M8Hr6ruEI7ca3XJuqGR3+E+3qFTc35rPpF8xSoTUJqk7xq+iP8Go=
X-Gm-Gg: ASbGncufufJBl/LSarX2wutIWlB6aBUv1ATMTVpgzDWt+dXdWGCuwm8gsVE1233yffW
	BUTJEolMc7tdYh2hiUkKPTqOJ/ocH+E75i5IYoGFWyrp+Kax9iO76bNa5qSHiqnfLLLHWtMGYDd
	mI+u6qAU87GYgh/AW/L2GX/jS6GrU/eq/K32ZPqKSK8ZENbHvXaezJdZqOJn8hwKkjg0khhRQpq
	XoeN/jaC2GY9KVJHkSXg4vdFuhSdZ5cdAg2yVbXiS2/+cV5kmCh/x4CVGyzlX0bGQYjPCgxYvNp
	lV5ANbiM1HzqxAP3j8lre0eqteeKMkQ2VLcKdk9UHSXggRKcJqp2F4curOuRY20tXmcgmeha2Yx
	AwKciqYMG1prvq6zayYyasxZl1mzIK6ul/I1N3cjeogBuNhY=
X-Google-Smtp-Source: AGHT+IFbIOxSLUg33BUpylzuKCK041iXvPKBjS+f2FA17A7KvsDTPjKnbUw6g/iuY+iBfbcHhkntQQ==
X-Received: by 2002:a05:600c:6296:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-442fefee254mr154045245e9.12.1747746099064;
        Tue, 20 May 2025 06:01:39 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a8cfsm16538095f8f.37.2025.05.20.06.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 06:01:38 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v5 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Date: Tue, 20 May 2025 14:01:16 +0100
Message-Id: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABx9LGgC/23OQQqDMBAF0KuUrJuSTDJau+o9ShcxjjWgUYwNF
 vHuDa5EXH4+8/4sLNDoKLDHZWEjRRdc71PA64XZxvgPcVelzEAAChSSx651/jvzrjMDB7KImbK
 KasnSyTBS7eaNe7FyqLmneWLv1DQuTP3423ai3PpzMkouuDGQg8YcsLg/XeijaclPN9t3GxZhD
 8ABgAQUaCGXWmmUxRmg9gAeAJUArFCZ2ohM0OkHegdIcQB0ArKCNOgSTJbDEVjX9Q9WJ3bweQE
 AAA==
X-Change-ID: 20250501-vmlinux-mmap-2ec5563c3ef1
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

I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
With some upcoming changes the library is sitting at 5MiB for a parse.
Most of that memory is simply copying the BTF blob into user space.
By allowing vmlinux BTF to be mmapped read-only into user space I can
cut memory usage by about 75%.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Changes in v5:
- Fix error return of btf_parse_raw_mmap (Andrii)
- Link to v4: https://lore.kernel.org/r/20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com

Changes in v4:
- Go back to remap_pfn_range for aarch64 compat
- Dropped btf_new_no_copy (Andrii)
- Fixed nits in selftests (Andrii)
- Clearer error handling in the mmap handler (Andrii)
- Fixed build on s390
- Link to v3: https://lore.kernel.org/r/20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com

Changes in v3:
- Remove slightly confusing calculation of trailing (Alexei)
- Use vm_insert_page (Alexei)
- Simplified libbpf code
- Link to v2: https://lore.kernel.org/r/20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com

Changes in v2:
- Use btf__new in selftest
- Avoid vm_iomap_memory in btf_vmlinux_mmap
- Add VM_DONTDUMP
- Add support to libbpf
- Link to v1: https://lore.kernel.org/r/20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com

---
Lorenz Bauer (3):
      btf: allow mmap of vmlinux btf
      selftests: bpf: add a test for mmapable vmlinux BTF
      libbpf: Use mmap to parse vmlinux BTF from sysfs

 include/asm-generic/vmlinux.lds.h                  |  3 +-
 kernel/bpf/sysfs_btf.c                             | 32 ++++++++
 tools/lib/bpf/btf.c                                | 89 +++++++++++++++++-----
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 81 ++++++++++++++++++++
 4 files changed, 186 insertions(+), 19 deletions(-)
---
base-commit: 7220eabff8cb4af3b93cd021aa853b9f5df2923f
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


