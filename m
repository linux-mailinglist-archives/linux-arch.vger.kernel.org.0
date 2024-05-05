Return-Path: <linux-arch+bounces-4177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C838BC0CD
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED91B20D1C
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F525760;
	Sun,  5 May 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSPh68o6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E212230C;
	Sun,  5 May 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714919194; cv=none; b=rLe1sGyNVBSvayAuJPYXwvoxSsFEgjN/lYikYkTiDn/nexctUkWSjdD6Sw6HfbbW9dXLQ3htBqNvqr9kLSnDYI12QkPC5XshFhk1z17luoWL8ghGTos6jFS0FaGWWIoPB7eyzZ0K1lDEHKCKWSr9EYeKWM03faEeuwDFZc/2qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714919194; c=relaxed/simple;
	bh=M6QQiy27Yx7cZTOC0617KB9Ln6pKKwikPWIcgenY/bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/LScXLf6gTJp06p/CRRMq6xGkfEdAQmvl1ga38WyO1OJQte21LD/NjQl0yacNc0LJFoEJ0zvxqrtn6sPFdo47880b9LTtbuDEzsEsQAtoEn2LCqO9Ci95pdzmXyvOp4DtMHw46TM1TjA41sY2JX7Eg4900w9WRh9W+Sr66IIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSPh68o6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC393C4DDE5;
	Sun,  5 May 2024 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714919193;
	bh=M6QQiy27Yx7cZTOC0617KB9Ln6pKKwikPWIcgenY/bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSPh68o6mPYr5fxxFtC2V72LTOuvr3yq8hW9zx6j+MQT2QTIBh9u0UYi6U60wKMQ8
	 4pUcdPzWIOrk786o1LPMCd95D81lUAiJdKTVxj1ZpL+gyGi8qYDPggeL2hw/UDWEMu
	 H8yR71nI/+PlLDzZBqTfTQ1Cie+RG4x5ncIdrHl8Seo9b772nXYthDV76uYlYsxO3e
	 wQYg6gU14o2i3rAa5QG/0f77H7ZldG9qTZa21eZgJY4qTNmIeZTc79JOB4S8iYpY/l
	 0cYrL/tkLY7wSmRuDhM/ExnpEYA0X6qhsgfUjZwCYRm6wHSDtLs/Jy026Jn90UZc9J
	 yhiYIU+MAPqGA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Liviu Dudau <liviu@dudau.co.uk>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 01/17] arm64: module: remove unneeded call to kasan_alloc_module_shadow()
Date: Sun,  5 May 2024 17:25:44 +0300
Message-ID: <20240505142600.2322517-2-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240505142600.2322517-1-rppt@kernel.org>
References: <20240505142600.2322517-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Since commit f6f37d9320a1 ("arm64: select KASAN_VMALLOC for SW/HW_TAGS
modes") KASAN_VMALLOC is always enabled when KASAN is on. This means
that allocations in module_alloc() will be tracked by KASAN protection
for vmalloc() and that kasan_alloc_module_shadow() will be always an
empty inline and there is no point in calling it.

Drop meaningless call to kasan_alloc_module_shadow() from
module_alloc().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm64/kernel/module.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 47e0be610bb6..e92da4da1b2a 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -141,11 +141,6 @@ void *module_alloc(unsigned long size)
 				    __func__);
 	}
 
-	if (p && (kasan_alloc_module_shadow(p, size, GFP_KERNEL) < 0)) {
-		vfree(p);
-		return NULL;
-	}
-
 	/* Memory is intended to be executable, reset the pointer tag. */
 	return kasan_reset_tag(p);
 }
-- 
2.43.0


