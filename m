Return-Path: <linux-arch+bounces-11852-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29893AA9BA9
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 20:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A03BDD68
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 18:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C737726F453;
	Mon,  5 May 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="hma8j/LP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289926771B
	for <linux-arch@vger.kernel.org>; Mon,  5 May 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470383; cv=none; b=MzGqL3pKRJjNH3+wj4pSjidFnBU8LKbDHt+1L0j2ZCPabN7Mn686ILX4qhZwzPC1ifrJm5Mkttzg1rDjEkiITV/Eq5/rBaESirlUASQPQkwfVJjGG2mzoWIXQ+BEOo+24Rdz4HpdGg8IxKJDggfojjn0sGBrs8N4UkbQADm7kEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470383; c=relaxed/simple;
	bh=hXBcmhzt7pc6mnlU3vaU2qmGiS+9/nJx5CuvAcuDxoM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T+eTuNZ40LcrjPKPXGQdMnOLjErYSkSDUaR37NP+kQb15rPgKmmIK+zl0KH4Ru3hlOEkxUid1n7ywd5HL3lsVg8fvqPDMDIQgwuHp22M6/mJt/Hq40kDKpyBHvGxIvFaGZbId88igW1HarbHEB1f8QCHFI4lUM3GMCeRvS67jJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=hma8j/LP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913d129c1aso2914452f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 05 May 2025 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746470380; x=1747075180; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r39SIeBEKMPL6NAc24Q2e8XKW+qtgjjLIiRr8dMiQPo=;
        b=hma8j/LPJpq2VP4VSnLFKv5J8fIktsNniUoWw3ynZbUjkiJMcu7IWllkXixFUcCSOR
         b0Gkr//lOu99HYwdzzqD8kbAI08Ua+cm+rEdv3RbJD7WhNPQiJVaV6YuiAQ0Zps1lHmJ
         S10x0/JwY3XVg0bwinsDIRSzOMIlILemP0MmnTbsj+l/KwX1zcuokCnwVLGwMCXuA+pw
         TQXgsryfJFXS7Y3cw4cUNLXjxlcmy7hnoe5yFxkIT+nyZ+g08JFDPrib6XyUNJ7dYMk1
         5HAF2q3MHy5QeREMhVmbt7qUigw6rXct874H6HAPZZYDy7nC/cV8qWnPC8HapFEKIEJF
         pMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746470380; x=1747075180;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r39SIeBEKMPL6NAc24Q2e8XKW+qtgjjLIiRr8dMiQPo=;
        b=u+Ohs885deTYDPRD/Nm43uloA9i6FSMBCL+0M8lckgVhQwReoQ19HEqYbbSgdMAnld
         9fOCKZLSJ2iA3ZeXlnzUt4mFKDVlZqOXLUz0NLezIk85obIXRfN0xzqPlZXaK+CZ/nm5
         XeBE4LeuMOvT6nt8r4uSc6POlzxzPvMXJOjiVqg+hHKy5l4BsflJgvO6PBD0chgBy7Am
         MHnlC6XCRaQo87XAyehzNq0Txz6w7owbbKQQaFEOqDcpMOZb2J6rglfVVYF1/BnFDJLk
         daJ9qlcZCjYgPKL+ogGSDCY3GwCcXseS5hWxY2B0CnyUXrQ4g1K5SLCX1E6XLUftjiN8
         C7oA==
X-Gm-Message-State: AOJu0YzvZbZiX+qAkiU0ayB9xUzFksxv4FQSpHgatQjiaNS8uGD1sCRC
	s1Dx2jDjBMqPmiomZQbaYO+xkhwD5Uc4OgVD3ftL2Qh5YD2TqBnVmIyDWIvVrkg=
X-Gm-Gg: ASbGncsPEoUxFdMjLH/cRFNjiZvhOX3Hl7Vt5wK75FGHOubUv5rwe7ztUwUAlNphdEn
	7glFFpVwInLhh9Si1aaLSG0xY9Q2kfJfSkxEP48KbThVXDPuVABXyJrblG6mH6Z7Py42S9hUcWL
	MV9fBdz5GTzB9TRBuNmnniWPDJdMEBkIXu5IFj7FYp45tcEgsrXLVExdd79cjMyJKHqAAwUFiwh
	ahyDRKKdO1H8VcOfPukugl1FOuC8H4McvW9ja14k7eoChIKZ58tVyCTm4MBx7goo2+GDMm6U+Id
	7wqCxFpGZRSvPXSSv9JP1RvdRLwXRsGVuRbH6yCZPbtVL42XrhnqowpLRa+dvkhReHiUTuNQHwi
	iaxge4YrWGwPHBcScqCTCJFUF1UMRRDghlAgj
X-Google-Smtp-Source: AGHT+IGaobnO4beOxK06wBrh3AtVwE6dZwzlJzIKWXgEz52cycCg7Fbg2XB6I7+Nolx5NZpbK0CsIw==
X-Received: by 2002:a5d:59a7:0:b0:39f:bfa:7c90 with SMTP id ffacd0b85a97d-3a0ab57d1bdmr475313f8f.13.1746470379915;
        Mon, 05 May 2025 11:39:39 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae8117sm11328877f8f.56.2025.05.05.11.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:39:39 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v3 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Date: Mon, 05 May 2025 19:38:42 +0100
Message-Id: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIFGWgC/23NQQ7CIBQE0Ks0rMXAp1jrynsYF4i/9ictNFBJT
 dO7S1iZxuVkMm9WFjEQRnapVhYwUSTvclCHitneuBdyeubMQIAWWkiexoHce+HjaCYOaLU+Kau
 wkyxPpoAdLYW7scfUcYfLzO656SnOPnzKT5Kl/08myQU3BhqodQO6PV8p+mQGdPPR+rFgCX4B2
 AGQgVZbaGStai3bPbBt2xcErgqQ9wAAAA==
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
 kernel/bpf/sysfs_btf.c                             | 37 ++++++++++
 tools/lib/bpf/btf.c                                | 83 +++++++++++++++++++---
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 83 ++++++++++++++++++++++
 4 files changed, 194 insertions(+), 12 deletions(-)
---
base-commit: 38d976c32d85ef12dcd2b8a231196f7049548477
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


