Return-Path: <linux-arch+bounces-5836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019B49445FD
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F041C221F9
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F56161310;
	Thu,  1 Aug 2024 07:58:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624944962E;
	Thu,  1 Aug 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499087; cv=none; b=lSU2U3vhiE7noDzMDqQkbjyceltm6RSctc0uTB1tV1UMHew4FQG5vrnCXLpt+d3eHOeYhMM78p8zEGEpx2P8X+CqQYnHLkJn+YTAlIApUp2G575w7ShTUsL7nqWqZ51xefNpGm53Tb3BbgFXeyeCBlST6vB3AeOhyaJnbjrLdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499087; c=relaxed/simple;
	bh=IbcGpdzne2O0krK+v6xeXmL46Con0uxvUYCgOlm1hlg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=toGIP/+5YWrr5VQipij53ObjEFCQP5sV6iwZpMHCEFC2RQ20sTbzvMlG45NLl51Ax90V7+tzqmojZuCUprJUiNseN7EQw6edqMHy7l4tiCxhgCiWO2rC/1aS79+k8ds1rahckdFHntokKx228b7JOsysu1bC29uhi+vKXNNtie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4717uGhC049139;
	Thu, 1 Aug 2024 15:56:16 +0800 (GMT-8)
	(envelope-from zhang.renze@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 15BCD2004735;
	Thu,  1 Aug 2024 16:01:03 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Thu, 1 Aug 2024 15:56:18 +0800
From: BiscuitOS Broiler <zhang.renze@h3c.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>
CC: <arnd@arndb.de>, <linux-arch@vger.kernel.org>, <chris@zankel.net>,
        <jcmvbkbc@gmail.com>, <James.Bottomley@HansenPartnership.com>,
        <deller@gmx.de>, <linux-parisc@vger.kernel.org>,
        <tsbogend@alpha.franken.de>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-mips@vger.kernel.org>,
        <richard.henderson@linaro.org>, <ink@jurassic.park.msu.ru>,
        <mattst88@gmail.com>, <linux-alpha@vger.kernel.org>,
        <jiaoxupo@h3c.com>, <zhou.haofan@h3c.com>, <zhang.renze@h3c.com>
Subject: [PATCH v2 0/1] mm: introduce MADV_DEMOTE/MADV_PROMOTE
Date: Thu, 1 Aug 2024 15:56:09 +0800
Message-ID: <20240801075610.12351-1-zhang.renze@h3c.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 4717uGhC049139

Sure, here's the Scalable Tiered Memory Control (STMC)

**Background**

In the era when artificial intelligence, big data analytics, and
machine learning have become mainstream research topics and
application scenarios, the demand for high-capacity and high-
bandwidth memory in computers has become increasingly important.
The emergence of CXL (Compute Express Link) provides the
possibility of high-capacity memory. Although CXL TYPE3 devices
can provide large memory capacities, their access speed is lower
than traditional DRAM due to hardware architecture limitations.

To enjoy the large capacity brought by CXL memory while minimizing
the impact of high latency, Linux has introduced the Tiered Memory
architecture. In the Tiered Memory architecture, CXL memory is
treated as an independent, slower NUMA NODE, while DRAM is
considered as a relatively faster NUMA NODE. Applications allocate
memory from the local node, and Tiered Memory, leveraging memory
reclamation and NUMA Balancing mechanisms, can transparently demote
physical pages not recently accessed by user processes to the slower
CXL NUMA NODE. However, when user processes re-access the demoted
memory, the Tiered Memory mechanism will, based on certain logic,
decide whether to promote the demoted physical pages back to the
fast NUMA NODE. If the promotion is successful, the memory accessed
by the user process will reside in DRAM; otherwise, it will reside in
the CXL NODE. Through the Tiered Memory mechanism, Linux balances
betweenlarge memory capacity and latency, striving to maintain an
equilibrium for applications.

**Problem**
Although Tiered Memory strives to balance between large capacity and
latency, specific scenarios can lead to the following issues:

  1. In scenarios requiring massive computations, if data is heavily
     stored in CXL slow memory and Tiered Memory cannot promptly
     promote this memory to fast DRAM, it will significantly impact
     program performance.
  2. Similar to the scenario described in point 1, if Tiered Memory
     decides to promote these physical pages to fast DRAM NODE, but
     due to limitations in the DRAM NODE promote ratio, these physical
     pages cannot be promoted. Consequently, the program will keep
     running in slow memory.
  3. After an application finishes computing on a large block of fast
     memory, it may not immediately re-access it. Hence, this memory
     can only wait for the memory reclamation mechanism to demote it.
  4. Similar to the scenario described in point 3, if the demotion
     speed is slow, these cold pages will occupy the promotion
     resources, preventing some eligible slow pages from being
     immediately promoted, severely affecting application efficiency.

**Solution**
We propose the **Scalable Tiered Memory Control (STMC)** mechanism,
which delegates the authority of promoting and demoting memory to the
application. The principle is simple, as follows:

  1. When an application is preparing for computation, it can promote
     the memory it needs to use or ensure the memory resides on a fast
     NODE.
  2. When an application will not use the memory shortly, it can
     immediately demote the memory to slow memory, freeing up valuable
     promotion resources.

STMC mechanism is implemented through the madvise system call, providing
two new advice options: MADV_DEMOTE and MADV_PROMOTE. MADV_DEMOTE
advises demote the physical memory to the node where slow memory
resides; this advice only fails if there is no free physical memory on
the slow memory node. MADV_PROMOTE advises retaining the physical memory
in the fast memory; this advice only fails if there are no promotion
slots available on the fast memory node. Benefits brought by STMC
include:

  1. The STMC mechanism is a variant of on-demand memory management
     designed to let applications enjoy fast memory as much as possible,
     while actively demoting to slow memory when not in use, thus
     freeing up promotion slots for the NODE and allowing it to run in
     an optimized Tiered Memory environment.
  2. The STMC mechanism better balances large capacity and latency.

**Shortcomings of STMC**
The STMC mechanism requires the caller to manage memory demotion and
promotion. If the memory is not promptly demoting after an promotion,
it may cause issues similar to memory leaks, leading to short-term
promotion bottlenecks.

BiscuitOS Broiler (1):
  mm: introduce MADV_DEMOTE/MADV_PROMOTE

 arch/alpha/include/uapi/asm/mman.h           |   3 +
 arch/mips/include/uapi/asm/mman.h            |   3 +
 arch/parisc/include/uapi/asm/mman.h          |   3 +
 arch/xtensa/include/uapi/asm/mman.h          |   3 +
 include/uapi/asm-generic/mman-common.h       |   3 +
 mm/internal.h                                |   1 +
 mm/madvise.c                                 | 251 +++++++++++++++++++
 mm/vmscan.c                                  |  57 +++++
 tools/include/uapi/asm-generic/mman-common.h |   3 +
 9 files changed, 327 insertions(+)

-- 
2.34.1


