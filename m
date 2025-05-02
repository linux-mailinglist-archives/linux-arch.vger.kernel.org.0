Return-Path: <linux-arch+bounces-11790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9336FAA6F62
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8566D7B4C49
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BDB23C4F5;
	Fri,  2 May 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="cVLsjI0q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FB23A562
	for <linux-arch@vger.kernel.org>; Fri,  2 May 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181235; cv=none; b=NeI01yxf70CPPNqrW6uQb2dqWXm8S+Jnfn1nZTOEgZVD95fj+03YMXA2gQ1pd96GWMHgQSHekrvzUzvX+ZZFacAS2bKE3VjzVN1wlEO3dAFbIPKNSRH2CArl/WaJuwti+T+kDdbjnP8kzWZjrMX8l0KWcuGGC9EEkt1y4+mPXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181235; c=relaxed/simple;
	bh=u1j0xmZoRnBzW8s0HMWnudNyoJzXBHt8pCUQz+ESzuk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AqbSKbYXdX4GXylaYW1RD2opAKrOjgQq2Zu4NwVEqfjlxBRkhUpjHMCpzGTXo/j0S4DckvDDuHwLAcCOQyg2mZtLU1XWkZCt70eb4GPzx3OZhNmy5I8k/qUgZ784vEcXaRPQwQi8u5WDWfMyLK4vAVyV4tY+f3eJJX778FihPaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=cVLsjI0q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so15705715e9.3
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2025 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746181232; x=1746786032; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMtJkZBjun5r4V6RProzP3wHroZCQ0IdrQUIPRbgJLs=;
        b=cVLsjI0qtP+1CG6fIYQI7nf+/8z1ksm0jh6cHrgQDevSISvnxTnJd6zfC881v/eAy6
         A3an4iff/tbOFa8T7kcHD1dBna7iFLpHV7hVWCR/srZ2M8nnLyiKrS9YPNWbwvnCkp1o
         keFOha6vUg/pdKSJ0VlHQ+N8IpYG6vx5F3VXVfs+tm31gVt+Jd0t9Z40BTg0CRxvjBvv
         MGNV7m6WFL2UAG1cy1/euExF4LFiNakJMqaTCgJ4fh7HcPUxhpJuAwctSbkOEeKApOPa
         9GgX1a/vNzWeAcG2D0tYKU/infQsqmjJ9lYFJ700M8eLIgTaqY42Tp+V8q4Q+Djp7fxE
         aFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181232; x=1746786032;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMtJkZBjun5r4V6RProzP3wHroZCQ0IdrQUIPRbgJLs=;
        b=taWkL8qxhKBVyrKPUO9uekoCHMWm1Mp2ez2kpsaL3w/SqW5Ybt1u8HYMzwteasWk/J
         TW/9MmhLBb/KbAphjih7nGJvdmG/hNHx3Gw7mu71pfuTvQP8LrLSWaTgY2pIffUKo4gV
         +fb2Ha91dl1hKHGHMYe7+3c2UNsuUBRQmC7lXOuxcr517Q7qz9WNPcUMM9i7ZodqieRP
         P8WZ+8162taROD+xpMXv59Cv0yr18MzFKPAHARQK60muinDsyqdCgUBIFgqFHF60D4sp
         5Ysla7IEoZPzlVL9IMa7rtmzHAPnWqX9T+p8AMmh74TXwtSWf8PlEDTW7H5PvIx5/ST5
         Yu4Q==
X-Gm-Message-State: AOJu0YxukPQR0Nx12+zTkQyMJv+314GMYb/7/2OoBqO1zeOb1MtUpK7G
	M95+kTBxDaI2xH7wqLMPPdXSiBPwKTg4UkJOb5xB/+1isqsDoGKrrQqo2KvIVGpB1nHe9WNNNqE
	k
X-Gm-Gg: ASbGncuo0ABzRLMh5nZbqjH0mKuO2cHWuQ/YanqTjZnEVPQAiI7nvM3CMsl4d9GGeZ4
	qctXP0w/mPv8LEMSKAn2TQo2xu48J9IXzGAaFGWYvA3HdGxhkg7uDl6IhAg7Kv8mKLgDumYPAec
	RH5X9By/7JQ8445RA4riqfvl33uC9uA/eNPSm/D8giOWXRL0+jAEOMNME4K/sfCM2mSLY/pL9wf
	mQ8hwtmk3Vjy/NQRneZ5jHMbz+5bCR4plsHL0oqtF/fYyDR/3y3eyoc/mnhOXqEuxH7EXer2BMX
	Ctxs+0zr0XdkFIu6MzMJFHzaXlHagcqEK9dvbkSKpnU3R2cHLRo6JU+21EYaFMllyViY/xps9SE
	HjP5C5SqbQoV0XGoxXxjVzM/v9e1390Id335YLFUXmc5VV3o=
X-Google-Smtp-Source: AGHT+IEHjhGDCWU2ZicYHzORmLl7fKou5XinJhHqakSMdG3W/Xr6HSBzfM+uhzSB/14vI2WwqXdL4A==
X-Received: by 2002:a05:600c:3ca5:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-441bbed4726mr17576305e9.14.1746181231995;
        Fri, 02 May 2025 03:20:31 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17017sm1742342f8f.92.2025.05.02.03.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 03:20:31 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v2 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Date: Fri, 02 May 2025 11:20:04 +0100
Message-Id: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFScFGgC/22Nyw6CMBBFf4XM2pp2sKKu/A/DotZBJqGPtNhgC
 P9uw9rlyck9d4VMiSnDrVkhUeHMwVfAQwN2NP5Ngl+VASVqqaUSxU3sP4twzkSBZLU+t7alQUG
 dxEQDL3vuAc84CE/LDH01I+c5pO/+U9Tu/yeLElIYgx2edIf6erlzDsVM5OejDQ76bdt+Da2w0
 LYAAAA=
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
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
With some upcoming changes the library is sitting at 5MiB for a parse.
Most of that memory is simply copying the BTF blob into user space.
By allowing vmlinux BTF to be mmapped read-only into user space I can
cut memory usage by about 75%.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
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
 kernel/bpf/sysfs_btf.c                             | 36 +++++++++-
 tools/lib/bpf/btf.c                                | 82 +++++++++++++++++++---
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 82 ++++++++++++++++++++++
 4 files changed, 189 insertions(+), 14 deletions(-)
---
base-commit: 38d976c32d85ef12dcd2b8a231196f7049548477
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


