Return-Path: <linux-arch+bounces-11857-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C24AAA917
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 03:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5C24A58D4
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28555359E0E;
	Mon,  5 May 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRMymOBL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D483589D2;
	Mon,  5 May 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484940; cv=none; b=qXnk9bgNgAngeClngsSWwun4H9Zfg4AbMC5/BHiYXt2RZyeDB0q7sAjoXG679ze0sVXKVZvsENIAMW1e1/1rv42YVkTaKCzBNy9i7AmOvoySCrxkFOx31Qs9cWyiGN9bJ2WNDUhoLnAuWYauFUUpGrgs5ZsaFtzQbrPEaXkPIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484940; c=relaxed/simple;
	bh=Mo3VTkzF1AIgn1cJigM5Oe1FxcUfv4q/iX7gWwFkfz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E497qkNkzbjBAQL1HktuxY/0tLewf8ZNgbDaENW1eyZO9jaetpW/LO+pLmBDEbUCBgeYJTlckrdsXeWmQa0SZiwupLtOr/QlmDOLp+ssyfwvB8qQm4iGN8rksWPpSUzj1MyNId4XRptVpMYterskK3iDNboVfFGm5OYuGt49Wsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRMymOBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17F8C4CEEE;
	Mon,  5 May 2025 22:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484940;
	bh=Mo3VTkzF1AIgn1cJigM5Oe1FxcUfv4q/iX7gWwFkfz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRMymOBL/fiopGjdMxdkK8omSSO6Iw9gHOjpl+qwPkoIsVYtdGZNN4QvMZGP/xQ+O
	 yCm8HSPxOh8p99GcAunN3SClR8ic42d6EAjCXWBTcm9p9o8JesrGw+BmJgYZ4Oz66F
	 e4oe8oKn6Y6LcsdryIdmPzff5mBzakVmYIkKjIhwM5oBtW5djGLzYDG8T1UolN0sf5
	 Bx/+MruHhJwzY3U2Fm4hLAEa3IRAUxmaN+t9RNW7LuYSlC4jytzxjgci6KnfqyH2SF
	 KaM4yFgQ6cw0qGH3UzTughi9iNdlWFEMvjhiSq8lnLWLZo7MtzpzEkIPwnqixnfGdR
	 0siV6qvSjV5qQ==
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
Subject: [PATCH AUTOSEL 6.12 086/486] s390/tlb: Use mm_has_pgste() instead of mm_alloc_pgste()
Date: Mon,  5 May 2025 18:32:42 -0400
Message-Id: <20250505223922.2682012-86-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index e95b2c8081eb8..793afe236df07 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -85,7 +85,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_pmds = 1;
-	if (mm_alloc_pgste(tlb->mm))
+	if (mm_has_pgste(tlb->mm))
 		gmap_unlink(tlb->mm, (unsigned long *)pte, address);
 	tlb_remove_ptdesc(tlb, pte);
 }
-- 
2.39.5


