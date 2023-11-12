Return-Path: <linux-arch+bounces-171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0004C7E8EC3
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC8E280CF0
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA385394;
	Sun, 12 Nov 2023 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggOZX2kR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F615386
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F1EC433CC;
	Sun, 12 Nov 2023 06:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769941;
	bh=qRqp7QPejGbBbu5oKyIM5RFWyLdo559Kq9GxnASTbi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggOZX2kRI1MtgdsU3XRYcle/m3IZf5lFlvSEYa0dAcFri8lmz9B12mIjqRdjlTXpT
	 9eFDzbRis6FA35srzfdsZ1u+hdrQQVMKimjV/uEL8gk48FIJWD4Fq7mAEAar6U9BQA
	 UO4a6fHPSuSWXP7Uof/glDnhRF6GmGUcc2ukCjlha4UnHfycJl2E7Vmx63uepFbtX2
	 eSwGWL6bq0W+YoWoC5OdGwLBR3dmmolU6lxAdTgevj6QQ9NDteYmG5XgzL4wGhXiFx
	 mJWrDq5z/7tZHCpCSiEhZE6dgetUMoigTXmlWHhxf6Q40hsyiNK/Qs5ODE9ZGl3gwW
	 COGIgXRKibzXA==
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
Subject: [RFC PATCH V2 35/38] clocksource: riscv: s64ilp32: Use __riscv_xlen instead of CONFIG_32BIT
Date: Sun, 12 Nov 2023 01:15:11 -0500
Message-Id: <20231112061514.2306187-36-guoren@kernel.org>
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

When s64ilp32 enabled, CONFIG_32BIT=y but __riscv_xlen=64. So we
must use __riscv_xlen to detect real machine XLEN for CSR access.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index da3071b387eb..fe83b4e2005a 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -38,7 +38,7 @@ static int riscv_clock_next_event(unsigned long delta,
 
 	csr_set(CSR_IE, IE_TIE);
 	if (static_branch_likely(&riscv_sstc_available)) {
-#if defined(CONFIG_32BIT)
+#if __riscv_xlen == 32
 		csr_write(CSR_STIMECMP, next_tval & 0xFFFFFFFF);
 		csr_write(CSR_STIMECMPH, next_tval >> 32);
 #else
-- 
2.36.1


