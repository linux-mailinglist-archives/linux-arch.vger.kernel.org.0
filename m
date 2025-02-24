Return-Path: <linux-arch+bounces-10336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360AAA41D57
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 12:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F004189A4F9
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9424888A;
	Mon, 24 Feb 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Gd4ZDedF"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C5248865;
	Mon, 24 Feb 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396070; cv=none; b=ofRBz1EqG7ZgBwNG/eVQYzjIeU6JNaWBionce1vOslW+tQb7IH1Vy00ig21dq6DGxWs0ejrKVtXxP64tH6B2vZPIYjKjqocgZqml6Wtq4PZfdwzK3EjLqx1MBYH4+0OXh7DufVVRbjp2ZyCeNz2yxn7x9HypS5ETqS9Xs0RaWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396070; c=relaxed/simple;
	bh=dL/5zoNdo+kDSHCjoHpsZarNox6ujoBo+G/m5ncxaWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQVR/lsCBzOMshuNobs1mquzDzreRkh3g38rSvOTIobNVGCQIwWIxWGr4kesxBbQa44DOUYjNTZtNGPv7zw28zbC+UVIfOS4wjg+VEr4eY+qtAj6d0LPH1wQe2OEOndWVMp8AO4Fm4jnBj4Z0CWjXCo0FWFIH/ZE7Vxgh5fasrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Gd4ZDedF; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1740396068;
	bh=uK0G5z1dgyQ1LGyKW373cRDB/WnmXJQCfB7OmH+z2fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gd4ZDedFN9+OzY9eGivWQTBRtB7LyVCXYFYIj2XuMmq5EdMAULRbgKhFeJFaBID9b
	 oBanxXh8CBUeMzpAT+AlLNpFn99zk9GzOtaO1H3bLQzGhHyjeIp6fO1lnxKukVme2s
	 b2beNCO8IiKLuLat0jC72Osz8qutKDtvGYaT6eWA=
Received: from stargazer.. (unknown [IPv6:240e:358:1110:6100:dc73:854d:832e:7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 131341A40F1;
	Mon, 24 Feb 2025 06:21:02 -0500 (EST)
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
Subject: [PATCH 2/3] csky: vDSO: Remove --hash-style=both
Date: Mon, 24 Feb 2025 19:20:41 +0800
Message-ID: <20250224112042.60282-3-xry111@xry111.site>
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

When CSKY borned, DT_GNU_HASH had already became the de-facto
standard so DT_HASH is just wasting storage space.  Remove the explicit
--hash-style=both setting and rely on the distro toolchain default,
which is most likely "gnu" (i.e. generating only DT_GNU_HASH, no
DT_HASH).

Following the logic of commit 48f6430505c0
("arm64/vdso: Remove --hash-style=sysv").

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/csky/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index 069ef0b17fe5..3e100e6cf72f 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -29,7 +29,7 @@ SYSCFLAGS_vdso.so.dbg = $(c_flags)
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
 SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
-	-Wl,--build-id=sha1 -Wl,--hash-style=both
+	-Wl,--build-id=sha1
 
 $(obj)/vdso-syms.S: $(obj)/vdso.so FORCE
 	$(call if_changed,so2s)
-- 
2.48.1


