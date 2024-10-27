Return-Path: <linux-arch+bounces-8629-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA89B1F48
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 18:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F23B20EAC
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1ED1CD2C;
	Sun, 27 Oct 2024 17:02:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D7178389
	for <linux-arch@vger.kernel.org>; Sun, 27 Oct 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730048521; cv=none; b=FTQScqGhEbwFZWf1gM3z4DFdY3cOz+J/fJWlRef9zfsrjN1y9qZWilpBFLMlkZPF1TDefZgd5XfpPKWSFDaw9GQhXDcmrNtttSjmGHS/8RT+TF9rHnQ4N25hQ+wslpRKZZ+4ozeKpvBYM/uqBQpOf57lBc5hUlLb3Mr2fE1szLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730048521; c=relaxed/simple;
	bh=bvcWC3j578HXGYGBJJ1xvsFkG8kxenbcIq2GoLY+c6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9ZAhzx7dd3hkelyudrjv3JUkwkypAplHatz8iV7nriuH+i3nazb32YaYeaaaHcrkmDRyjSJ4bhX3OhXmyU1Gqy6HIbbBYSNQF071D15sEQ/ML7jHdSuxswMxR7fKdlfwaYvZpT4c0/hLIC2A0oxhuxMdgZjor5G9uevPt3Olr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDFD3497;
	Sun, 27 Oct 2024 10:02:27 -0700 (PDT)
Received: from udebian.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 142133F66E;
	Sun, 27 Oct 2024 10:01:56 -0700 (PDT)
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	nd@arm.com,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: [PATCH v2 3/3] selftests/powerpc/mm: Use PKEY_UNRESTRICTED macro
Date: Sun, 27 Oct 2024 17:00:06 +0000
Message-Id: <20241027170006.464252-4-yury.khrustalev@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241027170006.464252-1-yury.khrustalev@arm.com>
References: <20241027170006.464252-1-yury.khrustalev@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace literal 0 with macro PKEY_UNRESTRICTED where pkey_*() functions
are used in mm selftests for memory protection keys for ppc target.

Note that I couldn't build these tests so I would appreciate if someone
could check this patch. Thank you!

Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/powerpc/mm/pkey_exec_prot.c | 2 +-
 tools/testing/selftests/powerpc/mm/pkey_siginfo.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
index 0af4f02669a1..29b91b7456eb 100644
--- a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
+++ b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
@@ -72,7 +72,7 @@ static void segv_handler(int signum, siginfo_t *sinfo, void *ctx)
 
 		switch (fault_type) {
 		case PKEY_DISABLE_ACCESS:
-			pkey_set_rights(fault_pkey, 0);
+			pkey_set_rights(fault_pkey, PKEY_UNRESTRICTED);
 			break;
 		case PKEY_DISABLE_EXECUTE:
 			/*
diff --git a/tools/testing/selftests/powerpc/mm/pkey_siginfo.c b/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
index 2db76e56d4cb..e89a164c686b 100644
--- a/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
+++ b/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
@@ -83,7 +83,7 @@ static void segv_handler(int signum, siginfo_t *sinfo, void *ctx)
 	    mprotect(pgstart, pgsize, PROT_EXEC))
 		_exit(1);
 	else
-		pkey_set_rights(pkey, 0);
+		pkey_set_rights(pkey, PKEY_UNRESTRICTED);
 
 	fault_count++;
 }
-- 
2.39.5


