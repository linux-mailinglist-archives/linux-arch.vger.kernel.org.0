Return-Path: <linux-arch+bounces-11769-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB213AA5FFA
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 16:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6951B4C4F42
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2841FBC90;
	Thu,  1 May 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Nz18OdUV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF11F9F7C
	for <linux-arch@vger.kernel.org>; Thu,  1 May 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109709; cv=none; b=QjkZnzN4OzhO0lRDgNB4BOPmMJIhFid+k/c5kURU3Po8cwwb0x1Pm/l0cf/pYDpLV4X6bB/u7lvzsHOk5/nMFvjxW3bWwbvcXsOKswHK4E3UT0FI0wwA1aVVfX2EB2QJy7RQmfN36XYty5toD3KgUKlbDshIPOKjf4zx2y2EvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109709; c=relaxed/simple;
	bh=bsz764YfWE4MRTb/rqiHtlptyqwMLFB4ZEx+pwwq78M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UI8ChG/eokcPy6wSCq1dx+TPf9r5k7Uvk8BMWcFgoSn6TFMak8oDloK2rdvAh79SwBlJn+MyxHEWQZTKZGbFz28Vzar35ZlMMXUpVicJ9KStvha4+Ipn5eWNaGkmyQeMRuYxykrPzBgbaextOpg0F7C08TvwP1yzSJ1fvGp1Ytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Nz18OdUV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39149bccb69so672613f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 01 May 2025 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746109706; x=1746714506; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StVEjYMIl6wQyDKAupy/1mKYeucD0OYxvq84SFVjyeE=;
        b=Nz18OdUVPqtfO1CS81ZnZncxcGyeiNFrAzEeWVYMUMZXtJaVFIeU9ypYHo5k9OX9ka
         DH2Vq0YPwxNGy3ry5h0VrD5aUvwG0P5KggRCmQUAmpIurDioH/qiLuhuv9wLpvhps3SF
         q7IWQquVRvqH7uD7oZUkEbG3ZzGJ9gijK+xwPdn8ue4hXSfLmrx/VX7sKi6Pn0ANyKH0
         IznUj/vEXZd+STczZM8JmlO6JWHm/GIdDxp4u0pLkuoudBr3dBdQPrJRY0cudkdfxdPF
         n9r7pAPpEOQLYH7SDhBBjXCz1V/AUDZW2l9Wq5dR6kJQLZja5O1jNxu4m7YUDbGhYX1T
         Is5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109706; x=1746714506;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StVEjYMIl6wQyDKAupy/1mKYeucD0OYxvq84SFVjyeE=;
        b=AQ5hSzTO0uhUS9Y/yx2yF90CycN7kfsx9PV8Neqm2vc0vBJoblJXuPQ1foVn0YubpS
         XQ8zw0oEgNyF4ngbfmrdAkmQRX5mXuPuWy5wcUabFPWMGAQjB/edD+JU1WIZD27PlUcS
         Q+7HF6cSxUPngx8vLW+5jbEyizB3KSAfsXJ3Ivroea5uyLrkvIOrFPO312b3kccIeypn
         I3sMAHuqWTL36fQsacfTt3cMQplEM6V9z7v/Mvuc+DsROTb2K6iDSNOXnGeE7Ck2HUaI
         wmN+OwqxY8w0ntT+h2XMyNpNj+h8z6CwcLXWB8/h0Mg1JiYVGBc+He1B+/7luqdln1Lr
         iJrQ==
X-Gm-Message-State: AOJu0YySp96y6Kqxcdaj20NAsVC6yYufBGxIkJpobIXfGZG+gT85D276
	bOF0deHzop85FWzyK3XCgs2nts+qAkNAPNXMVWeU8naVVi9a2U3HaEWMNO4dChk=
X-Gm-Gg: ASbGnctTh+wDDvCJNeHl1aB61Np1ObBY6dEe5H1VmbHOEv1DtprifQYuQR5qtnq+Mn6
	qVEzbUh8zte3Eqj1Z2rbeLjtZ9acnLqId8VcD9/d1jCjB1ZfuD1Tc/t+vxyd0YC1R307Mz2iVII
	zwgLOd++EkgFh4gvtnj8Gcg013rQavMW24aDBP8PPrW0z0OH6zrDJjpf24emE5DyBO2bDqaOdq1
	QlB9HIN5uPxwiQFdv9L1trUwlnaBK922OuiQatd0ZyqAWKhwNZx0h1LYmbNn2wSoedZCEIVZQ1m
	J2scw/mex8jjTOQ143+MkPRCSkVYLFrsrm1+q64F+8AVqXhHLmbtFQeMMb025j8fpvXVrhOC/N8
	vK2B9faDPTtlVPPj8AZ/Ajes4/drsG07PkA0Z
X-Google-Smtp-Source: AGHT+IEPSk+cQIgonsEsIg1aqlii+4w8mjQ/IOfqZ7nsCbNMR2MfqFqMDG1cn5sRDjMY3mVaDu76ig==
X-Received: by 2002:a5d:59af:0:b0:39c:1f11:bb2 with SMTP id ffacd0b85a97d-3a08f761da1mr6037739f8f.22.1746109706055;
        Thu, 01 May 2025 07:28:26 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d15dasm13908445e9.16.2025.05.01.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:28:25 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next 0/2] Allow mmap of /sys/kernel/btf/vmlinux
Date: Thu, 01 May 2025 15:28:20 +0100
Message-Id: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASFE2gC/x3MQQqAIBBA0avErBtQwxZdJVqUjTWQJloiRHdPW
 r7F/w8kikwJhuaBSJkTn75Ctg2YffYbIa/VoITSQguJ2R3s74LOzQEVGa37znRkJdQkRLJc/t0
 IS7DoqVwwve8HbY5dLmgAAAA=
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
Lorenz Bauer (2):
      btf: allow mmap of vmlinux btf
      selftests: bpf: add a test for mmapable vmlinux BTF

 include/asm-generic/vmlinux.lds.h                  |  3 +-
 kernel/bpf/sysfs_btf.c                             | 25 ++++++-
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 79 ++++++++++++++++++++++
 3 files changed, 104 insertions(+), 3 deletions(-)
---
base-commit: 38d976c32d85ef12dcd2b8a231196f7049548477
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


