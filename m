Return-Path: <linux-arch+bounces-4195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9978BC1C7
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02624281AA6
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C3138389;
	Sun,  5 May 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq9xkaB6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9C37707;
	Sun,  5 May 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714925220; cv=none; b=gr7dg9xR2QnYbKCHNu0ABI84OTyz0M9fKwEVCD3tt1qMEwcBitbz6xnHhqgEwA+z0K+OxbKH2siaisGr385i0VtN1cbyCoWXdVp8muZLjAhBPkfSryiswXgenTyK9Q1enL50sfeino/4q8GDwA5ueh8s92v5IIM/gr99F7NRe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714925220; c=relaxed/simple;
	bh=M6QQiy27Yx7cZTOC0617KB9Ln6pKKwikPWIcgenY/bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE4ylf3ALZho69UjXZrZ9FXYEvXjk5GQzZTzWuidZzcBL7koHNnPx/QN4qbY3SfXaXV92Hbae7aaXbqKqrZ0gw0SOo2ERg6dXK52Oo1Gxkefujp/CSYlu0dOKtz57d/P8f7OmwnyTgDknfF1763U1GA+i7RfrwlFLa4vQo7JiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qq9xkaB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4F3C4DDE3;
	Sun,  5 May 2024 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714925220;
	bh=M6QQiy27Yx7cZTOC0617KB9Ln6pKKwikPWIcgenY/bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qq9xkaB6DJwbvT6OTP2sGk7b6G6bmDN5GyK5sBXSm32BVbedH8jHvu58xQEar8ba4
	 uKzUigAgbBAtsz8r5l3mt2L2za5eSKU/+BjQNHwkb8bkk1dSzjGw0MuhLVplgL5ZP8
	 9+4Xjjkzq/fb5aRZ15hEIYgAO+SLQ3ZdibwPKIo+aOqxO1Wde5HY2qBWwQ/K0irIeT
	 ivaaNIlis9trjR8Xspz86sAH3Biv9Y1hr0lxZc08RADzGXQ7JtgHd1tAb126rA5WHB
	 b8dLhnVtioffkmnpyWBCyjSpVlTprGY0DDKi7/kPoX4BYqxHmygNlAT6hSyOu4Q7Tl
	 8KyBh8i4EO9TA==
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
Subject: [PATCH RESEND v8 01/16] arm64: module: remove unneeded call to kasan_alloc_module_shadow()
Date: Sun,  5 May 2024 19:06:13 +0300
Message-ID: <20240505160628.2323363-2-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240505160628.2323363-1-rppt@kernel.org>
References: <20240505160628.2323363-1-rppt@kernel.org>
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


