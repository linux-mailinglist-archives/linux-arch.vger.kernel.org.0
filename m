Return-Path: <linux-arch+bounces-3005-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72A87C7A6
	for <lists+linux-arch@lfdr.de>; Fri, 15 Mar 2024 03:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B75C1C20ED6
	for <lists+linux-arch@lfdr.de>; Fri, 15 Mar 2024 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1244749A;
	Fri, 15 Mar 2024 02:45:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98EB6ABF;
	Fri, 15 Mar 2024 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470712; cv=none; b=YrSb3f7zYDbFGw7Nx1s9k3jHpmk0r1IWYVqO9DP6Xl3fX3Xh/Fc/oaey06+UVlW78+JF34VF8GpYA2OevPygUxSYOwm7ToGSiFINB/60gSaFFby9RW9JtA7+d0KNTqC2IcGxPUd4/xmXc9n14wCse1/KrehMRZXRL0fBvnzYooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470712; c=relaxed/simple;
	bh=gGdLKQeDx0rEaAwzLkXhbwbA9yc/pe+P9PvTcJ+1mAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlsPrzZM+YB70eWwRLZ9QPUDG3ZerLtvTWDvTE602PmvUqiMf90Rizw+mjBZWicBMfLn8c2FBZHwrE5DvQsZyby1/EEYwcHXu3KQ+rZbgIRAwofoXjpM4IczLcJe1EArpuNPgiui8hbdse4yAsqjnxYamDspCQzK6rB/S0ZWMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89371C433F1;
	Fri, 15 Mar 2024 02:45:09 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Select ARCH_HAS_CURRENT_STACK_POINTER in Kconfig
Date: Fri, 15 Mar 2024 10:44:35 +0800
Message-ID: <20240315024435.350013-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoongArch has implemented the current_stack_pointer macro, so select
ARCH_HAS_CURRENT_STACK_POINTER in Kconfig. This will let it be used in
non-arch places (like HARDENED_USERCOPY).

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f90949aa7cda..277d00acd581 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -15,6 +15,7 @@ config LOONGARCH
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CPU_FINALIZE_INIT
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
-- 
2.43.0


