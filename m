Return-Path: <linux-arch+bounces-15390-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0435CBA6F8
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 09:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30D43300856D
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0756023BCF5;
	Sat, 13 Dec 2025 08:00:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948E155C97
	for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765612856; cv=none; b=Gx8FViOS8G45lb8heKuFGA930d+GJAofaw3W4FoWWIuoUeC+ymSFnX/4R4BC0AZbGosIDaByGfyt1dJ3Ts4Fp62qzao/cTMYTFCHQ7hiuHdJ6N5G3Qi8qQkIsOZEhWuHDanJwPOKJYPO96R5kydiaffT/dGIFwIG1NDyW+GXABE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765612856; c=relaxed/simple;
	bh=kakJHZ2lxOABuc84HEYpUwvB3kPDkf6B0kMAKNFG/C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ri2cN1a18fDirrLwswLlGFx6uDyqMPuBR+TYCmRAzQuZ6z6ZUE6dM6r/+7DnnqjUr2oiQEDBmhzUASiHVclBfVNsACl+uiTbviWxOW0YPL85YYumW6Lm0BrGJMHuJAcpGnHnYHiCBZjBMsAP/y60U+PXiHlbpI2WTugvYbBVREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29d7b8bd6b0so12561005ad.0
        for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 00:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765612855; x=1766217655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwMoXNDgoraLN2s2u+sQU14RS7UZ7t31vygWf6FGxo8=;
        b=G1pojz1UPABdb8Kkk24W2IrVOc7d0aD9m0pTvNefzEkhMt2tLoDo80bMu8qdB32rHE
         ZKgHcws9hOJ82jo96jI38nVAGRzIBB09501py8pX0MYgNvqMDMnxx1aTWeK01W0vfqtB
         m8RpcfTrgk/RFUeOM6UWx80jntkepgVpm5LciKBROLzQFlmYukPDr1irFxaP2Vm+Ipfv
         4Ou6nq0ldONLL4Vzg2kP5qsRvM2iKVYI7BN7m2t/WruEPSr/eKT2hQ3WBxVV5shhYO2H
         u8gwqKyPNMckh4OWx1s+Lzc4lZkSOI3hhMjz4kWCnToZ/6uHMce/Lr+Jkl5N3ctljpww
         zZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCW2Y2rZ5veXtc+YzaAVYNZTBNgR79Dn50XkHJhzcNI+xsAQjbW3tyte2lYDT9eV4Ziv1H4a5avyzpdF@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0O6enKXVIOD6PO5MDX8l+Re2OAmpH3MZYgTLLkc4m3OIzwCH
	RrL/3jdEP7MPO2XmVfjQxZ1L2Vv1q4huZTWF36fMcpRvq9j/LhBSAC5Q
X-Gm-Gg: AY/fxX6xa0X6WEUKO8+pu5+dGpKDfBwG0IRReYVvJ9TE/Edhlld0BsjojX1r6FA1BNa
	ic6IAykLeCu2QVmf9Rc+j7bn4I60PVxhvu7BriCyIc6Yx8Xg0HqWpMHxdoqVWTXQWRHXnjNliju
	NZv/f2z+70TKb/3tlNIu9WrmPlXf4dV7j30JQi2ph2CK3QNombpq5l6/g80/FjRKD1n7eVdQMya
	fFuHwtxgmSRBWaI3ZQ8YZKtTe6h0DfjyHXmGZQETxssAva2O+9XVZcOtZYAIZ76vfpmVtqy2kl3
	kwdSThVIPOTg4WGJbg8eVzwsC5y+kdXEDHmF+BnVZz4pNu5hixFGabyGPabvfvOgmMrNq/8B2vo
	61MpwlnIeriSG7w/r+5kwlljSbXBVqbFgMt89Rcs3p0Bh/2ZKorKzPKPE1cN6WMLVw8TvCN56D6
	quvAcsokAnwh23xQOHKvCRwgFewA==
X-Google-Smtp-Source: AGHT+IH/JoAGIeWkbC5Ijwb4LT700SBRuvmuttOCUbTdCoNc0d7rgbi/92X8za8oyhtLlyVRSzlnrA==
X-Received: by 2002:a17:903:1c3:b0:266:57f7:25f5 with SMTP id d9443c01a7336-29eeea041c6mr87005275ad.7.1765612854584;
        Sat, 13 Dec 2025 00:00:54 -0800 (PST)
Received: from localhost.localdomain ([45.142.165.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f05287fa3sm53149155ad.5.2025.12.13.00.00.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Dec 2025 00:00:54 -0800 (PST)
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
Subject: [PATCH RFC 0/3] skip redundant TLB sync IPIs
Date: Sat, 13 Dec 2025 16:00:22 +0800
Message-ID: <20251213080038.10917-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
to both hugetlb PMD unsharing and khugepaged. I will dig into other
architectures later, and folks maintaining other architectures are welcome
to help out.

David Hildenbrand did the initial implementation. I just built on his work
and relied on off-list discussions to push it further — thanks a lot David!

Lance Yang (3):
  mm/tlb: allow architectures to skip redundant TLB sync IPIs
  x86/mm: implement redundant IPI elimination for PMD unsharing
  mm/khugepaged: skip redundant IPI in collapse_huge_page()

 arch/x86/include/asm/tlb.h | 17 ++++++++++++++++-
 include/asm-generic/tlb.h  | 22 +++++++++++++++++++++-
 mm/khugepaged.c            |  7 ++++++-
 3 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.49.0


