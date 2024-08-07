Return-Path: <linux-arch+bounces-6071-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D6E949FD0
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 08:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B481AB21679
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 06:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677221B32BF;
	Wed,  7 Aug 2024 06:29:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463741B32B1;
	Wed,  7 Aug 2024 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012182; cv=none; b=C94+fXtX05Ap311OVnto/lgyXE1sSAZOecKOREvhOh/mHRgDD+SlNR0y5QgiEaUJ0bSPKoqipbK8FGZICgXP8ytdYzO2AqcZcxt//t1MYgnRV0+kY+OjJ9r9FiXmc5VJb0Pzx2Czc2u1CTE47jJ5M+mi8H9397b5k0HiAM1zmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012182; c=relaxed/simple;
	bh=Nds4k3kXpJavjlt7F3vtKH4PLupr8sOacndsqSsq1oM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOnOqX/Q0UtsmjEFDxSmqowydG+dMfPFkjeJoUWtiHqTx1EkP22dN7lbNtokjy7Ksqrobv5d2TX2Z7MplgNCO0BdcfvAubQnpCoEOcB47f8tb1hjRAbMG5xd3a1kM+APYG+7o07rmcJtirFs9P896FnJH1llrv6zBnJytYe7SoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wf0c05lFvzpT54;
	Wed,  7 Aug 2024 14:28:16 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FC8C180AE3;
	Wed,  7 Aug 2024 14:29:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 Aug
 2024 14:29:26 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] arch_numa: Fix section mismatch warning
Date: Wed, 7 Aug 2024 14:35:47 +0800
Message-ID: <20240807063547.3144151-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)

With CONFIG_NUMA_EMU=y, the following compile warning occurs on ARM64,
remove the __init of early_cpu_to_node() to fix it.

	WARNING: modpost: vmlinux: section mismatch in reference: numa_add_cpu+0x24 (section: .text) -> early_cpu_to_node (section: .init.text)

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/asm-generic/numa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index c2b046d1fd82..e063d6487f66 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -33,7 +33,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
 void __init arch_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
-int __init early_cpu_to_node(int cpu);
+int early_cpu_to_node(int cpu);
 void numa_store_cpu_info(unsigned int cpu);
 void numa_add_cpu(unsigned int cpu);
 void numa_remove_cpu(unsigned int cpu);
-- 
2.34.1


