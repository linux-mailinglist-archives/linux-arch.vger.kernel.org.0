Return-Path: <linux-arch+bounces-155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD6E7E8EA7
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B850B2096E
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61A1440E;
	Sun, 12 Nov 2023 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMoW3pc7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04F440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44E8C433C8;
	Sun, 12 Nov 2023 06:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769843;
	bh=bke8fOXFDjV1zILAGkdyjNPTOfL1ZR2nFogEIcEnLNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMoW3pc7nxmWk9TC7awLImserdou0qBcPtBdvsgWteW/xYXDxcUp9v4CpLyETmaoe
	 p3F6oi8kTZDV31QvjU85h0OvOvaSmokczVTFAn8MOVlJv4xAOqyCkEWTSCOVQhiVaO
	 +VMnKyi2Y49C1IwpIkWtL55An0Wh21zTNPPdJbECeOst0TfGqO1q1Qa46RZy2jqKZX
	 dkCnLhdQYPdb1O6P/jSu/4/wlIY0OIQVhM8E5enAcQkeavsiof2vH1S9rtjvuMoXtF
	 BckquD1HmBgApzGOgJxELfdlsEjtlWU1xrlEjpMdpe78xyEva6NJTvqonnWbhS/bzu
	 Qk8o+iazacIow==
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
	Guo Ren <guoren@linux.alibaba.com>,
	Guo Ren <guoren@kerenl.org>
Subject: [RFC PATCH V2 19/38] riscv: s64ilp32: Add ELF32 support
Date: Sun, 12 Nov 2023 01:14:55 -0500
Message-Id: <20231112061514.2306187-20-guoren@kernel.org>
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

Use abi_len to distinct ELF32 and ELF64 because s64ilp32 is xlen=64 and
abi_len=32 (__SIZEOF_POINTER__=4). And s64ilp32 is an ELF32 based the
same as s32ilp32.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kerenl.org>
---
 arch/riscv/include/uapi/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index d696d6610231..962e8ec8fe05 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -24,7 +24,7 @@ typedef __u64 elf_fpreg_t;
 typedef union __riscv_fp_state elf_fpregset_t;
 #define ELF_NFPREG (sizeof(struct __riscv_d_ext_state) / sizeof(elf_fpreg_t))
 
-#if __riscv_xlen == 64
+#if __SIZEOF_POINTER__ == 8
 #define ELF_RISCV_R_SYM(r_info)		ELF64_R_SYM(r_info)
 #define ELF_RISCV_R_TYPE(r_info)	ELF64_R_TYPE(r_info)
 #else
-- 
2.36.1


