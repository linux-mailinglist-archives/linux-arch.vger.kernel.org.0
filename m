Return-Path: <linux-arch+bounces-10337-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3AA41D5C
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 12:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057117A46A7
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192B24889B;
	Mon, 24 Feb 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="D1xeJqD1"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B8261392;
	Mon, 24 Feb 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396071; cv=none; b=Xn8BDVNrFW6Ic7KrcdQdwiYzvZyqNbFHzoS8hrSzxPUl2l4ssWEATLnw3Lna9fu2RUtqd5RNJEGJzwfoHJB6mHcIGCuLgfsu6P55tDOs7g1MyY25vKnYT5TOLOQIs5n3nDDJmq6VCyqNFpmFbhjCD4kg9SzXtFQEUUBZKV4jWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396071; c=relaxed/simple;
	bh=17AhFnNHpt0G9klcgmVrv/F5ASOOetBZnSvC/7J2698=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcwzXYAMZ6m5mREj98GpiLCvNxwLytCMZG5lfBEleqswKDF9U5llRrOzWXO4rVyNadIuNT9LZ+eRUUrqAyyeni2Y97AMiJjMF5UWbKuJpUbn0/0WRXMcgLvYe6ZEx76YK4h7t9jLS/uNG4VFzpRYf8dp7oAikrBYAZ45YrarZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=D1xeJqD1; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1740396062;
	bh=9N5UbYwwS3cj4ISBSwf0j1nK6obW0UxDyUzHGsn7IM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1xeJqD1EyhCPVOKwyq6EZS92UTpksyChGpHsp0/kMrNZ/qiBm9uYbSBNgFkV18W8
	 I4Mn+BG1Nnbb0PDA+3SQryW3Q6ibwr1eEF4B4ZMDldpQleHkN7ADemC/803GF2n3e3
	 yozfHj9ZvBFx81aO8ITspHS7YqkUn4w7PXg5zVe0=
Received: from stargazer.. (unknown [IPv6:240e:358:1110:6100:dc73:854d:832e:7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D8D9F1A40F0;
	Mon, 24 Feb 2025 06:20:55 -0500 (EST)
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
Subject: [PATCH 1/3] riscv: vDSO: Remove --hash-style=both
Date: Mon, 24 Feb 2025 19:20:40 +0800
Message-ID: <20250224112042.60282-2-xry111@xry111.site>
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

When RISC-V borned, DT_GNU_HASH had already became the de-facto
standard so DT_HASH is just wasting storage space.  Remove the explicit
--hash-style=both setting and rely on the distro toolchain default,
which is most likely "gnu" (i.e. generating only DT_GNU_HASH, no
DT_HASH).

Following the logic of commit 48f6430505c0
("arm64/vdso: Remove --hash-style=sysv").

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/riscv/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 9a1b555e8733..ecee348af9ce 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -47,7 +47,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold_and_check)
 LDFLAGS_vdso.so.dbg = -shared -soname=linux-vdso.so.1 \
-	--build-id=sha1 --hash-style=both --eh-frame-hdr
+	--build-id=sha1 --eh-frame-hdr
 
 # strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
-- 
2.48.1


