Return-Path: <linux-arch+bounces-162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3557E8EB3
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5D51C203DE
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178F440E;
	Sun, 12 Nov 2023 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbhMDVf5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CE440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E993CC433CA;
	Sun, 12 Nov 2023 06:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769886;
	bh=pCbLyhlTiTCPVyjC6F0x/RIOJUl3eHTLK6u1tDMFHiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbhMDVf5Ls3HY7vX7w6FISj1kn1U4VVPGZX4dsUZKDlZoIDE6gN68LYCDykSmzwq/
	 HW0hrA9GMbmEYenBeVuylzxp0i40jlJS2sb74sRLRaQ7a28yqIyPj9pyIMqLEXwWdH
	 womA6+yJRG46rjsiYplmtxAQnB1q+T0g11SjcvYIFwMpeVdQxIM03g9v2CFzu3QD95
	 4kfemghrnDw8pcpdHOqG0p/JJMRLzSyTLGUTIt1gBNht3bc8n9RJ547lfMACGeRf9M
	 0cQcGwBytXmIbT0qepXitV/1fhx0YB7aPqbEHs86kXMbtwoNMJH7ZAyUeICU2LVS3C
	 QAYg6f/FQx6MQ==
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
Subject: [RFC PATCH V2 26/38] riscv: s64ilp32: Disable KVM
Date: Sun, 12 Nov 2023 01:15:02 -0500
Message-Id: <20231112061514.2306187-27-guoren@kernel.org>
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

Disable the KVM host feature for s64ilp32 first, and let's work on this
feature after the s64ilp32 main feature is merged.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index dfc237d7875b..3033fc1f7271 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -20,6 +20,7 @@ if VIRTUALIZATION
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support (EXPERIMENTAL)"
 	depends on RISCV_SBI && MMU
+	depends on !ARCH_RV64ILP32
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
-- 
2.36.1


