Return-Path: <linux-arch+bounces-4052-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9498B585C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372CF283259
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49CA82D9F;
	Mon, 29 Apr 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7f0wuVA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AEA76050;
	Mon, 29 Apr 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393180; cv=none; b=kHCMKOzRw8hy90oDdNSgr+HR/5MyBMnn6QbS7ukeUe5PBfZtlUaDvRM25P6QMW8Of6OE01AmFWCH0SAOMTEPALGL/Y00GdrlTurCz/gr8MA2r1I2b/iVSdrXDlplUCjQcsLuAuHQ4gL4qHjQjBhZNZrNEUBLefmDUDbzwQ8GRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393180; c=relaxed/simple;
	bh=+AOj3OMDSB3feHYUPdQfVhUVtDWDdcImqVlO1v4xpng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhcfYpY4ZCfwVypE4QAAEviejzQJmV/49iFzPK9HzhYYaSV7IaeCVTdnQr67Q2Gg5tuFuOZIeEG4YvC6IiGs7L2rxd+bNrIPjwHQAIajg4OfmBh3Wg2TZj9A0OIXiV3rD3jYywtmrO/0jCYFaO2DYeK06oku7Z6dJKKKc5X9ylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7f0wuVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FDEC4AF1A;
	Mon, 29 Apr 2024 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714393180;
	bh=+AOj3OMDSB3feHYUPdQfVhUVtDWDdcImqVlO1v4xpng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7f0wuVAWdgbS5Dnrk/8uxCz/WMBnwfIEbrYQjsFBoWK/NO+gFsetX++9RtisOg+R
	 lyducI87XJq0Sa6/5knT2xgBqH7K2xW/qMnGa0g1XffUGK3v88+KqpLas4BZaDB8ho
	 7TEZf3UWszPCEBdKLSl5tSKkPNsGUW+hGDbSDeQiXvAbbZQ7/jWj/FVqaI9aEzKfJ3
	 n7rBw9DjLbVvNCoFkwi9pBCXtg9xh2adrE6zMXEpc+zsBt1S+VUeMtGvQpJ7f9J2+M
	 Gqm1Q42MZd9YPy1rtpJAQ/o+FnD8mnYQVVTP4aKCUYjgJ2YMq1N1K7OajA96dLskDm
	 vAoCNMH3V0h1Q==
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
Subject: [PATCH v7 16/16] bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of
Date: Mon, 29 Apr 2024 15:16:20 +0300
Message-ID: <20240429121620.1186447-17-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429121620.1186447-1-rppt@kernel.org>
References: <20240429121620.1186447-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

BPF just-in-time compiler depended on CONFIG_MODULES because it used
module_alloc() to allocate memory for the generated code.

Since code allocations are now implemented with execmem, drop dependency of
CONFIG_BPF_JIT on CONFIG_MODULES and make it select CONFIG_EXECMEM.

Suggested-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 kernel/bpf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index bc25f5098a25..f999e4e0b344 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -43,7 +43,7 @@ config BPF_JIT
 	bool "Enable BPF Just In Time compiler"
 	depends on BPF
 	depends on HAVE_CBPF_JIT || HAVE_EBPF_JIT
-	depends on MODULES
+	select EXECMEM
 	help
 	  BPF programs are normally handled by a BPF interpreter. This option
 	  allows the kernel to generate native code when a program is loaded
-- 
2.43.0


