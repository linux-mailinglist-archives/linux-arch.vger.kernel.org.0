Return-Path: <linux-arch+bounces-10335-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABE8A41D5A
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 12:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66D017AE48
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3286B23BCF4;
	Mon, 24 Feb 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="enHf0tfA"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5D26137C;
	Mon, 24 Feb 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396065; cv=none; b=H47X4353CiHyNF72tEEXXoiRyRZoFxZy6E6ZT5RYuoYU1q4di68zIClgbPmgxP2WGjlTPO8AlYihzy7jretSwJ1lqvDXBR+k0stw6jQTQtPwaagQRTWgyqmbSt7XToZ6orUqfen8+bco34NzlXVNilu82VJa11m3OYl0yYSgTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396065; c=relaxed/simple;
	bh=Jl/aGD6H8zlfW46eQ8hKfWnP+g4vlfzN/TfC502RuSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QucdffBVE82JVFVg/Hax9Rxe7AmtnqzIV8aiSL0FmcwM4UVIMpG9p4ZCW4JG8mqomk6xguQWaVrWe8m8/2o0iQy33cypJMgT/gKD6MZXR4cXg6XoMqpd9xmz96oB2kGHOsPvX61tDq/xvu6LGRSXGVUTcs9QkBPlOBObqKkDpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=enHf0tfA; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1740396055;
	bh=PEZ+XmHReJkvOO8ckw/Sp6e/Ys54sWdkMmIRDD4VEB0=;
	h=From:To:Cc:Subject:Date:From;
	b=enHf0tfAHWymo5wtzHP9lT0kTKne9eaEveqFQg9viuU+wCQ8SziFN2JNJhmVneul8
	 FGBw9M2ivI2HVxkGGdEjIyaGQnNNAWtIiqIFZ/waj4m5LSMo4Y77cwsuDCeS1jPWWr
	 J09MQ0ACFxs5EAXS2XHkAtj6nGgiv4v3dyMIEai4=
Received: from stargazer.. (unknown [IPv6:240e:358:1110:6100:dc73:854d:832e:7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id EFCB21A40EF;
	Mon, 24 Feb 2025 06:20:49 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fangrui Song <i@maskray.me>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 0/3] Drop explicit --hash-style= setting for new
Date: Mon, 24 Feb 2025 19:20:39 +0800
Message-ID: <20250224112042.60282-1-xry111@xry111.site>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For riscv, csky, and LoongArch, GNU hash had already become the de-facto
standard when they borned, so there's no Glibc/Musl releases for them
without GNU hash support, and the traditional SysV hash is just wasting
space for them.

Remove those settings and follow the distro toolchain default, which is
likely --hash-style=gnu.  In the past it could break vDSO self tests,
but now the issue has been addressed by commit
e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH").

Xi Ruoyao (3):
  riscv: vDSO: Remove --hash-style=both
  csky: vDSO: Remove --hash-style=both
  LoongArch: vDSO: Remove --hash-style=sysv

 arch/csky/kernel/vdso/Makefile  | 2 +-
 arch/loongarch/vdso/Makefile    | 2 +-
 arch/riscv/kernel/vdso/Makefile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1


