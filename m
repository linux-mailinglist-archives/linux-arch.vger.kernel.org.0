Return-Path: <linux-arch+bounces-14109-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A699BDCB05
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 08:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03223C87CC
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 06:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772133101BB;
	Wed, 15 Oct 2025 06:20:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DE30F93D;
	Wed, 15 Oct 2025 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509204; cv=none; b=Pn7QPDi/7VkFUuD/rrbK6CFevMowrqg4tCe7+znkGrloePBkISiPw7/sUDVCK8nOevUHWyYNkS4jMz3Ghax8FW1DEr280MBFAgXkWWjQ9grJZA9OgugUWKuz9xI5Ezd6sE0OnOFt0JEQkrQuGoMogao4qmvPgexL8VVB9Fiubr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509204; c=relaxed/simple;
	bh=RxwC5QQd4Pu4UsQiyRL0qgIA5ynrbat01elQ0/SS+to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sURWmSlicsDenZFyG2U6Gpzo5JjszrED24zRYerGluox7jzBN03DYUxk4ihDj6IBeobSZR7mAkZ2JntzzaxOjcMoEzIDZpNLBUPL26KXbdHcWnE8bcV3hbhBQFmaoWVvrNXQNG9pTH5NNkBkvUfLAMpWgntmN0HzJ+j+XZDKsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: zesmtpsz3t1760509123t05cff719
X-QQ-Originating-IP: nNfNQXy1/5EgLTlbfFU/BpAhqpvUPauMUCH0BNThics=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:18:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17077304549723306376
EX-QQ-RecipientCnt: 14
From: Yuan Tan <tanyuan@tinylab.org>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	nathan@kernel.org,
	palmer@dabbelt.com,
	linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i@maskray.me,
	tanyuan@tinylab.org,
	falcon@tinylab.org,
	ronbogo@outlook.com,
	z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: [PATCH v2 4/8] riscv: enable HAVE_TRIM_UNUSED_SYSCALLS when toolchain supports DCE
Date: Wed, 15 Oct 2025 14:18:31 +0800
Message-ID: <DFBC1E41A1103B87+997a9aedbe0a9a779d0a463bcbfd13eb677d5f0a.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Mpv6PNPPUmDu01OaIjV3/c9lP/+9l92EgFL6Up0MEq9OBV1ly0d0GAZH
	nMBUt4qG6xMxRFmM0labnaCvSycP58RZy71c1VR+/Neqs2+z6gtDCKo4ElOvtZFriDOUOiU
	pWCTMo3t6a/bdbCCOayMAqcWFK3G17PRM0WgvjpgXcMQw2t6xsn8foLu1Zr3lAr3eqXGACx
	3+DnSDxjJvzkUW4epJJQvjjXaW3BLN6ICtTb0f+W05/qN4wPsWs6UObMPvyTgDUBgVKuS/h
	9xzpk63Xnb6mR9UnpEwFXyqrzwybdECyAxC3ftAXIcF84kdFm80kgKDXVepDNWaWxxEALP1
	flaI7ouj1yZ5cbeYc6xysCRZWtEu7tU1+rUXa7cN7HsAyAXN+zQYOqJuuVeYpm7X7KY36/n
	5FckXbcHJGAx9wZalHQqecJ05JzY/1bJ0sj1FQNy4bH9m+0ejTGoUcVaztIft/TltR0xYha
	24c97saY0zCwDjkPylGdHFn92swxaCcTeNSiTc7gQQTxk0b0P2Y9rC6X+n1oW26lWejroqf
	ItMJcyMGaJkPJxLaaAlNKLeugvcNiRQaIkGawGFD4u9EmHQZzQ8hS1qdlF6CKCBxeZ/oQMr
	/Wx9fqLKyuoxP9rAY7IbbL2Bvuhe7POTkyXDm7YTAymFahHiDsJNokghcvCIp2eUxlgkD25
	RWI6V0pYw9iUjihkvGMZT7e3XTwZOPAUveuXHNwuBIjwQzaUHnxGjmRxHSmk2bNv1XEREsy
	gok1SDmW3LTBeHOZB8AURCYvJgijz5cM5e/kU+A37nuHLROrS679XRcxqzHvf8syGBipHsl
	GEAgzLFEh5+TX9oaub1gTZ+1NCnXM3xAXGPK8PQGvhOzjBXOrp7HD5W7gixHMfQ1mqnEDVX
	buvtHwEJAWDgqvhn/P3zFk67YlnmgO/xTJpePEsIK+dCpnR3IODlo9hMAU5Je6sonJ2eij2
	CGOLMid/TdK5Rzg/BLhBG32sP6j5x912TfLZxTUwJI1LFAA==
X-QQ-XMRINFO: OJlEh3abS6gXi5NWrXbD0WI=
X-QQ-RECHKSPAM: 0

From: Yuhang Zheng <z1652074432@gmail.com>

Enable HAVE_TRIM_UNUSED_SYSCALLS on RISC-V when the toolchain supports dead
code and data elimination.

This allows the unused syscalls and related code to be trimmed at link time
based on the list of actually used syscalls.

While this enables per-syscall elimination, some syscall entries still
cannot be fully discarded due to sections that are force-kept by the
linker, such as ex_table, bug_table, jump_table, and .alternative.

Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0c6038dc5dfd..697050ac8c62 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -198,6 +198,7 @@ config RISCV
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_TRIM_UNUSED_SYSCALLS
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
-- 
2.43.0


