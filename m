Return-Path: <linux-arch+bounces-146-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093567E8E95
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B360E1F20F99
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1E4410;
	Sun, 12 Nov 2023 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB1Tkw1Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF819440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0415FC433CC;
	Sun, 12 Nov 2023 06:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769788;
	bh=x2yNl81rtMLNR83PEs3HCmEpsQ4/7rJymYTh7H6aEEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EB1Tkw1ZePpU08PhgrQFyDzSgHHkUjmbXxR/MUfG9bEVV+Iqk7O9UI0yiAixM8Jim
	 ijdKADfSY75NGC29rcYC1mdguX3mcb7TwbXCv5XJbBQy0Szp1r0s50Ul50mA7JJS0O
	 nLfC/bApQGYZcDd7S8pGBd2WNctZpvQ2G4sr3FE+v+cbbKJcQ154u+YzChQk2HyUZO
	 QMl52JlYFGIXKd1n7CaPK5ahUUZ3kDSEhDiIoMq5PhRfUHho2veayBgIf8qrZBZYJS
	 dEMpUJibV+TeKlPUnHb0iDewAmVuzxXifFf3b86rqSS9CRpgB19LbEZjFi810Jl04U
	 Ds4QiYJ1/SScw==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 10/38] riscv: u64ilp32: Remove the restriction of UXL=32
Date: Sun, 12 Nov 2023 01:14:46 -0500
Message-Id: <20231112061514.2306187-11-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

The u64ilp32 needn't hardware support UXL=32, so remove the
restriction when EF_RISCV_64ILP32 is detected.

Reported-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e32d737e039f..93057ca2e2a7 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -88,7 +88,7 @@ static bool compat_mode_supported __read_mostly;
 
 bool compat_elf_check_arch(Elf32_Ehdr *hdr)
 {
-	return compat_mode_supported &&
+	return (compat_mode_supported || (hdr->e_flags & EF_RISCV_64ILP32)) &&
 	       hdr->e_machine == EM_RISCV &&
 	       hdr->e_ident[EI_CLASS] == ELFCLASS32;
 }
-- 
2.36.1


