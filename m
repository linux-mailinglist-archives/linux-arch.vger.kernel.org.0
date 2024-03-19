Return-Path: <linux-arch+bounces-3032-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06ED87F741
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 07:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5441F2265C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BCF5B1E3;
	Tue, 19 Mar 2024 06:25:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B54594E;
	Tue, 19 Mar 2024 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829506; cv=none; b=l7rwtCtVzm9Mw6Hl01ko0JcVjNCVUtqXFE6d8yMihVgV6HX8eVBXm26rL9vdiMrNeo4Atan+wYwsWisj0lJCl7pxSW2WSwVufRwlN3E/Z2FAmk70AWWGUgO9UJih1VH6FWsaBWLPYhro2KYbTVcKWvh2UqllL41tTtP3nEdOb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829506; c=relaxed/simple;
	bh=x5GRcJP4/69nKg2T9VOa0UIbcWd6tlxpikRifHHI+EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pp+TfRMQ8E7Uek+xSjLleK0YMy+7QJRfp3Xf7/c+pFSUNFOegrMiKzboM7BWTRAWR+co+xbJ/XPuEFJ3yeMYPUxqOgMz5Q3Cx4kZ1AOcO8pD3rVdRv9hPSue9k0rynTalRfbhiUGCcVfZ0mOq2gpV1O6deWcDt9MyKxKltLBD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55318C433F1;
	Tue, 19 Mar 2024 06:25:03 +0000 (UTC)
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
Subject: [PATCH] LoongArch: Select HAVE_ARCH_USERFAULTFD_MINOR in Kconfig
Date: Tue, 19 Mar 2024 14:24:32 +0800
Message-ID: <20240319062432.3529127-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allocates the VM flag needed to support the userfaultfd minor fault
functionality. See commit 7677f7fd8be7665 ("userfaultfd: add minor fault
registration mode") for more information.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ce8b55bdf68d..3da341bd48ef 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -105,6 +105,7 @@ config LOONGARCH
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
-- 
2.43.0


