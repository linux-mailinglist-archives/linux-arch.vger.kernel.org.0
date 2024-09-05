Return-Path: <linux-arch+bounces-7057-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B4596CE1D
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 06:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5F7B2365D
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 04:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1671614F125;
	Thu,  5 Sep 2024 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="ggJtWKRe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09250144D01
	for <linux-arch@vger.kernel.org>; Thu,  5 Sep 2024 04:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510905; cv=none; b=X0Dbuj48ycNAYNAl7HaDwfTv5dlaGfUnp+AMUzJ661sA9IWyVYXqVWAHCGwLcOTnT6VLQ80edA1ahl3UcpJzA6oaz8nRw/ZbSDVX33vytjoWWNqR8LDTlAiJNuQ/OXT0sqsK15N6uGlS023gAQ7jukOMz/Tcz3ZDnImYNHQ+IPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510905; c=relaxed/simple;
	bh=ZpcEvvudV3zwcYeNP62knioScPXoayjlokROh8sA/AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4SYQHYEP0sPQ3WZ7Og8fDHNRMMHKNNb8/XBQVcv9pf6R6ymIDsZZ1wVbTLpFvTpcuAIuELUe56kzd382pSCblUZAEyqDu8m7W3dNWLpF9EBQPMnPpptjpP5hsJE+jJe1rCbRB1r6FgQZomT0E7/6gzDu0oo2QVAf2V+2+Ps7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=ggJtWKRe; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a8125458e4so22047685a.3
        for <linux-arch@vger.kernel.org>; Wed, 04 Sep 2024 21:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1725510901; x=1726115701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA8QNkfTPcJhmIVKfWV2EgXocZ+TYN3IbgT82p4dkrQ=;
        b=ggJtWKReyeYUJwzk9EutrB3PRzJYAwLSUUoX6hxshD15mKMMFRkOO85+t+FaW6pBF3
         fbV6dxEMfnZqja3GCEnuU6vlY+7gPcXH4vluOUmW7thQGUmAhmSoSe6KVcDIdCtuwv+e
         3suRz2eT/QodGjuv37Jt2TH4lbR1ZAuds66a5vARgTktZSojCuogk+W+AD04wt+Co3Ak
         um+XCcrbn5ZRoW6JaXd+DPjj++Nbsthm2QBYSgQ/Sc+wcqIQ+/ZvDXFSDXW977DuQJZa
         Lnhd7V93metJ3zlamcGHwubiLvf9GtMOUA0bTO81gMz5d+Wl8Pcian8AjBCxagpKbTsM
         WJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725510901; x=1726115701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA8QNkfTPcJhmIVKfWV2EgXocZ+TYN3IbgT82p4dkrQ=;
        b=ozn0LoljfCoI6DwAH1y9JVsN104L4z0IzN/PcZ5+E20nO87iqwLqlqu3izl+KLM3KQ
         cYrw7dlujBLLURal/Ug8vc/gPT9LPdWOgpOuS0YWu06wy5URC78/WCaJiYQZAnaVuDRw
         UXsJKaaqgxNqPBizDqKmR1tleNf1E6vYXD3z1so8cOyjqSK/82G19ZtbYWlW/nvRAioi
         RCTJlQMA2QurzcGOGh/vShVZyy+ra1nCN24JlOdQdnJasezil18k0SA75JiWJPgCEcLp
         VkZHqaJGT4eGM6SgdyDiSyOmUu2R+Ms3Vi3fJ4MK7JmA4/R2BIgeBj5h2LgnB7ih6/Mf
         QBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNbp03YFv1iG7DJqdIsmpoWB5IS7xVAFd+BWRDOCWHCgTAHbi/e8lML5tJ68U15jKc7Sa9FTJoPnxe@vger.kernel.org
X-Gm-Message-State: AOJu0YycYYzq2q0Pq7L3JIf4GQI1MYSvMTjPoBLGOeini7iPEh+VxIyG
	YHrOAzZy/tpRn9e9pPsUUTLRUMFdIqYgJDTR2NLtgpj+JPv53K/b1G02P8TYQA==
X-Google-Smtp-Source: AGHT+IFRf1D5vt1QAYst2+47RlHDBe/oTQ0pdJOm5kim3EC+oveF5BzPVYhrOWbWoMHiQ4QFDP6QZA==
X-Received: by 2002:a05:620a:2a08:b0:79d:55ab:3867 with SMTP id af79cd13be357-7a902f29ac7mr2154420785a.46.1725510900949;
        Wed, 04 Sep 2024 21:35:00 -0700 (PDT)
Received: from node0.kernel3.linux-mcdc-pg0.utah.cloudlab.us ([128.110.218.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4cf4csm4182341cf.48.2024.09.04.21.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:35:00 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: wentaoz5@illinois.edu
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	x86@kernel.org
Subject: [PATCH v2 4/4] x86: enable llvm-cov support
Date: Wed,  4 Sep 2024 23:32:45 -0500
Message-ID: <20240905043245.1389509-5-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set ARCH_HAS_* options to "y" in kconfig and include section description in
linker script.

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
Tested-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 arch/x86/Kconfig              | 2 ++
 arch/x86/kernel/vmlinux.lds.S | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2..e0a8f7b42 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,8 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_LLVM_COV		if X86_64
+	select ARCH_HAS_LLVM_COV_PROFILE_ALL	if X86_64
 	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6e73403e8..904337722 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -191,6 +191,8 @@ SECTIONS
 
 	BUG_TABLE
 
+	LLVM_COV_DATA
+
 	ORC_UNWIND_TABLE
 
 	. = ALIGN(PAGE_SIZE);
-- 
2.45.2


