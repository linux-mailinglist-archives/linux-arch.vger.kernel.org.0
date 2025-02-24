Return-Path: <linux-arch+bounces-10338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49FDA41D64
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 12:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC818919BC
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5C254847;
	Mon, 24 Feb 2025 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="k3VDnIYo"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D523BD11;
	Mon, 24 Feb 2025 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396076; cv=none; b=GnRg66eWWrsBe2eB2WnwjxK7rkfn74Ui+WAghPPqkyxS5S5jlULr4/sjdADIrrCrEYcugJMW35YZ23bX/bEO39ed7LEgD9k5ckCPlE5O3MZ9jrTYsj80VPS/vO8f/1PPw0B+uWLz/fmZ18bbh+FMQt95jkZvmWulLbFe89C5OTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396076; c=relaxed/simple;
	bh=UR/V5CaH1smA/Ep6TuqVVJoHIRliBWAMQqudackZJOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePi6u8F0r58Y/JwaSEtRVCIT2MIDIq/y+/NscSKbyaCjhbcOMyReXe+UfepyIy//RJ9aoLZYaR8qcEQ/VL1F755sZE/72jbABhnqyefp0EvA7erBCQHnVkpe536rWsRjsSHqHqY2Fddfc0etfoQCDXyIV9jAxGI9IDjZGtwQMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=k3VDnIYo; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1740396074;
	bh=x+JZ0bZh6o31FzL/bWs2L2enB0qu5OHjl9gf7Goj11o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3VDnIYouVr0xuGpeuELmGYMzdWobg9FRDuC7C9Ezp9heZVLghfX8FkRtu2F7dDHT
	 Kkkq7HbrnLxWRaK/eMZiQsJyjeG6FRUei2AEg/LnV7gQrdulTn+JnyRv/tFHXSOAk8
	 Dl81KF6d1PcEAr5VfpGYtWbDbzhEzWuGwV+nG0ho=
Received: from stargazer.. (unknown [IPv6:240e:358:1110:6100:dc73:854d:832e:7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 44E931A40EF;
	Mon, 24 Feb 2025 06:21:08 -0500 (EST)
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
Subject: [PATCH 3/3] LoongArch: vDSO: Remove --hash-style=sysv
Date: Mon, 24 Feb 2025 19:20:42 +0800
Message-ID: <20250224112042.60282-4-xry111@xry111.site>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224112042.60282-1-xry111@xry111.site>
References: <20250224112042.60282-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
far before the first LoongArch CPU was taped.  Using
--hash-style=sysv might imply unaddressed issues and confuse readers.

Some architectures use an explicit --hash-style=both here, but
DT_GNU_HASH has already been supported by Glibc and Musl and become the
de-facto standard of the distros when the first LoongArch CPU was taped.
So DT_HASH seems just wasting storage space for LoongArch.

Just drop the option and rely on the linker default, which is likely
"gnu" (Arch, Debian, Gentoo, LFS) on all LoongArch distros (confirmed on
Arch, Debian, Gentoo, and LFS; AOSC now defaults to "both" but it seems
just an oversight).

Following the logic of commit 48f6430505c0
("arm64/vdso: Remove --hash-style=sysv").

Link: https://github.com/AOSC-Dev/aosc-os-abbs/pull/9796
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index fdde1bcd4e26..abaf87c58f9d 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -37,7 +37,7 @@ endif
 # VDSO linker flags.
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
-	--hash-style=sysv --build-id -T
+	--build-id -T
 
 #
 # Shared build commands.
-- 
2.48.1


