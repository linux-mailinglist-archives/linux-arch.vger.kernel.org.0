Return-Path: <linux-arch+bounces-15595-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2FECE749C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4307300DB8B
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0FF32D43D;
	Mon, 29 Dec 2025 16:02:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4EC32D0E9
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024174; cv=none; b=pV3NklXyq100dJ+wDyB7LqXCC/DHxdKPisxGRbh4rRFH1a6E8H+xEgxAAdpZ/XMT68mKvfKtEe8EjFaZegyEozReC3LpThkpVtHI0EUC6QwU06/WY8wMReIXiNWSNle6pynwlKgATSh3ypzPr45BeWyuQoHuY3nAqrFlFPT1LmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024174; c=relaxed/simple;
	bh=N8padF7buaqa1eXg1+Igz+XpRALmc90ogMazOG4CwFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rr+eH04fwWYbKJHlq4PZa4Mm3l1jaOTZiN0Rm6LTOlshE2qu26V6rxdWmEc1kLt1c1ZmPOi4XHPTAh8m+2BreKENRvonu10TWzFmsmw+JaieMFJ6+HU6+MGnrp4e2rmDBg3SySYdlYVCCQ8o4cOEbq2Rc5y2Picp23iqe4I058Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3ed15120e55so6535601fac.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 08:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767024171; x=1767628971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lnYMzB+dCUz+mkORGwbpkYC+kll7m3t+mAqWOhKrD8=;
        b=i2Pl533A+vF6x3URsMG+IJq1ZmNnWSEEE6UnhzGkUoo8uuCxUnbErUg+36X45wm8bd
         FvuZ5Ivjo+iEoAP0hJX2smOhPQD8WXo7pAnnkF1zgAn5zs/kY1JC2XXIueXLtcxqGNEz
         PwEJoyLlbmnT3Fb7Oc2oKFuQ/xwYYzVRcTiFReaI571/uMk6ju86d+LZbkK/7W6u66jM
         aUiSHJempi7cJFtxmRO4cocOnqmNX5SKRTGtyuCiaRnp2I7u9a52t+HxB7MK1Ga/H6be
         Mn4dd/Fvs3+gv4nZL0NWAwW2k97VRa0DQwwGrKqkkf1YL4GbksujjvGj4MIGNVblZxev
         BoJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbZyhc5KyVKdrHdcOhKotg71kthZtatDbzIoKBYSqy91OaCg4ycX8bc7DGQchFOdaXXFyRDzg4nkN6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9e76LZnq7lKRFKwEgQo8LaJfQXBJqEOMtWVBtiWH2nYG0HH+z
	YswoJ5SnfQZlib2DJ2Ys0yoPfK55/Spt24Rmn4h8TgoGM/eTqGGpuBEB7XYQTDozcPc=
X-Gm-Gg: AY/fxX5mrbk1S6MzlY0U3hjxj8AodE72ByCZ00vUkwIxf8xBZ6VdkptUYLCXRgL27wv
	s/owDt1VfDPp8k1ZYa+22Y/sXo3celvue9K0r8XziFlMhtUJhbiiw2tsWGJZuOzH52N9X/AmnBW
	sFXu2+/s/uX3K70C22NszpO+A18weUbiG1FeaV2Jq7DcVwxNrrmw9ISLH/rw0sUkcaCA5BUdko/
	Wt8R3YnJ6aon+ZfOvoBkoN16TlPBkVlRChoHbqeCz5HIrvIE1qWyrsLSZrpUO10isKhnTWp0/0X
	IQgNwbX+0RMLNSFwhzXMxIZE51sJulyg8nPBcXTtG49cfNjZYNXSONaaiVUngznNa0XVw8jpG1T
	Y1R82XsA926S2c9qBFn0cuO40CcjKgFLuicaDndDB/h9lr03na9OoM7VKYOtSG/PEM/qcH22DAU
	I6Rs7kLrYxKE9HX3vWN1d9
X-Google-Smtp-Source: AGHT+IHg6byxM/xkxubE4jTDVkQ4ULmMFOY4QfJYQWgFM4sIg4d8O/EzQKPsy5ALE1+u/Z3o6zsA5w==
X-Received: by 2002:a05:6a00:9089:b0:781:be:277e with SMTP id d2e1a72fcca58-7ff64401115mr28062284b3a.4.1767017579562;
        Mon, 29 Dec 2025 06:12:59 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93ab3csm29472636b3a.7.2025.12.29.06.12.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:12:59 -0800 (PST)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] skip redundant TLB sync IPIs
Date: Mon, 29 Dec 2025 22:12:42 +0800
Message-ID: <20251229141246.63435-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

When unsharing hugetlb PMD page tables or collapsing pages in khugepaged,
we send two IPIs: one for TLB invalidation, and another to synchronize
with concurrent GUP-fast walkers. However, if the TLB flush already
reaches all CPUs, the second IPI is redundant. GUP-fast runs with IRQs
disabled, so when the TLB flush IPI completes, any concurrent GUP-fast
must have finished.

This series introduces a way for architectures to indicate their TLB flush
already provides full synchronization, allowing the redundant IPI to be
skipped. For now, the optimization is implemented for x86 first and applied
to all page table operations that free or unshare tables.

David Hildenbrand did the initial implementation. I built on his work and
relied on off-list discussions to push it further — thanks a lot David!

RFC -> v1:
- Use a callback function in pv_mmu_ops instead of comparing function
  pointers (per David)
- Embed the check directly in tlb_remove_table_sync_one() instead of
  requiring every caller to check explicitly (per David)
- Move tlb_table_flush_implies_ipi_broadcast() outside of
  CONFIG_MMU_GATHER_RCU_TABLE_FREE to fix build error on architectures
  that don't enable this config.
  https://lore.kernel.org/oe-kbuild-all/202512142156.cShiu6PU-lkp@intel.com/
- https://lore.kernel.org/linux-mm/20251213080038.10917-1-lance.yang@linux.dev/

Lance Yang (3):
  mm/tlb: allow architectures to skip redundant TLB sync IPIs
  x86/mm: implement redundant IPI elimination for page table operations
  mm: embed TLB flush IPI check in tlb_remove_table_sync_one()

 arch/x86/include/asm/paravirt_types.h |  6 ++++++
 arch/x86/include/asm/tlb.h            | 19 ++++++++++++++++++-
 arch/x86/kernel/paravirt.c            | 10 ++++++++++
 include/asm-generic/tlb.h             | 14 ++++++++++++++
 mm/mmu_gather.c                       |  4 ++++
 5 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.49.0


