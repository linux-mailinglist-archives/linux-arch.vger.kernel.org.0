Return-Path: <linux-arch+bounces-11856-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A7AAA109
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 00:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48133A953D
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 22:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C212298CC6;
	Mon,  5 May 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMEEUFKL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3F298CC2;
	Mon,  5 May 2025 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483549; cv=none; b=XEEs/kTl0sum6AhupKCSth7tQgjXdQr2PxCjlsTnwgqacrAz8z6SwMtKwyDDQGKZvoTzqwXp3gNeR2QjcG6Rq79sqBncX7hZWGbvdLeTvsHU7K33IAxJpy6Rd7EWUIfUUy2MSs/N1gycs7lH3Ksq3k8kuAzq05dqZqOd553pJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483549; c=relaxed/simple;
	bh=BsdnqqdGhS7yq5HlRe/s5Mi+ZUThGe8SVXmwGWSnpQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loPs+hMzxKrrP2woR6r3MwW1pKdVcHzX8DEtkV4lJipAUwScAzCmvOwCRenZodj5M4GP2ZC4z4uxHXiGHHo7781is7kHI/wy9Nu5CyHbWEt/Aguq+Ps3cTanWeHYzGG+NL/FnnE5yN46nnTr8sdf/Q4Bia6p09bHAvXtR2RSxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMEEUFKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B05C4CEE4;
	Mon,  5 May 2025 22:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483548;
	bh=BsdnqqdGhS7yq5HlRe/s5Mi+ZUThGe8SVXmwGWSnpQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMEEUFKLeW+nz8rH3eZklmu2EYAhS1pwU65OHTngAxL7Q3lppeorYB9O6tgETwtAR
	 OHWb7RzNHNj31CK4OvFYWQOxhejMtvxXsgHgSI0LhNGyDrL+zM4XQW71WcV7ukkIOG
	 23xY3VgyuFWtxyFFBr9bYN6mKlQuR9gSFGoCZdQIxA+gR5jWf1FpRhWX+UXjnI+wdT
	 qb9a8cTKJWgTb5Fa4ogd7uj0ycixDJq6wfc7RScZI5h0XpG69LHI3PxnjwahX+jYF1
	 gakarS3ONvPym40az2Ttx8ch1P9h2oGFIudv1p22FvSX76fLEWe4pOcTPRFZk1Jgzg
	 XEb3jCThFS17w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 109/642] s390/tlb: Use mm_has_pgste() instead of mm_alloc_pgste()
Date: Mon,  5 May 2025 18:05:25 -0400
Message-Id: <20250505221419.2672473-109-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 9291ea091b29bb3e37c4b3416c7c1e49e472c7d5 ]

An mm has pgstes only after s390_enable_sie() has been called, while
mm_alloc_pgste() may be always true (e.g. via sysctl setting).

Limit the calls to gmap_unlink() in pte_free_tlb() to those cases
where there might be something to unlink.

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 72655fd2d867c..f20601995bb0e 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -84,7 +84,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_pmds = 1;
-	if (mm_alloc_pgste(tlb->mm))
+	if (mm_has_pgste(tlb->mm))
 		gmap_unlink(tlb->mm, (unsigned long *)pte, address);
 	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pte));
 }
-- 
2.39.5


