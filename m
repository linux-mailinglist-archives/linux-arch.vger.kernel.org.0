Return-Path: <linux-arch+bounces-13397-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100B0B46FDB
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B97F17E142
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05FC2F744C;
	Sat,  6 Sep 2025 13:59:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198F2DFA22;
	Sat,  6 Sep 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757167142; cv=none; b=e98qEMJbqy46jIaRkqEcXoQoJL2wVxLilhftBk6MEyCRR3N8LIaZFR5S8/e8weLEsHhihobriuRav3tvPiG30AeRdfNr+rKremSyBZ6LnKoTBAuUIUvF42cQG8N2Fzm3c2inW+7b7hA1sBqZvUpuBLGs0pD2pqrkUlaD6HR+aG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757167142; c=relaxed/simple;
	bh=IWDRX+XRiNczCWsdyqXh5uteSAcNl6psuD6Csmsl/Nk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oOETH6ojqGouKXpf8goO1YVyYx95JsLGR7yoCoE0HgYOQGdqZ8nLaQiAVQEF4nGyUcjOK1w5JTwzFXHhjlX8hmuiBn6gAimAhR4K9dFXIAnxcLMPldDoV8tGSnJxIOZV0DOI3XxuABKHJEMd51avY3itQl8l/vxrRudyFSVoimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cJvpS4nYQzJsZM;
	Sat,  6 Sep 2025 21:54:24 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 64FAA18048F;
	Sat,  6 Sep 2025 21:58:55 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 6 Sep 2025 21:58:55 +0800
Received: from huawei.com (10.44.142.84) by kwepemn200010.china.huawei.com
 (7.202.194.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 6 Sep
 2025 21:58:54 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <bobo.shaobowang@huawei.com>, <xiqi2@huawei.com>, <xiexiuqi@huawei.com>,
	<arnd@arndb.de>, <masahiroy@kernel.org>, <kuba@kernel.org>,
	<edumazet@google.com>, <linux-arch@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] once: fix race by moving DO_ONCE to separate section
Date: Sat, 6 Sep 2025 21:49:34 +0800
Message-ID: <20250906134934.1739528-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn200010.china.huawei.com (7.202.194.133)

The commit c2c60ea37e5b ("once: use __section(".data.once")") moved
DO_ONCE's ___done variable to .data.once section, which conflicts with
WARN_ONCE series macros that also use the same section.

This creates a race condition when clear_warn_once is used:

Thread 1 (DO_ONCE)             Thread 2 (DO_ONCE)
__do_once_start
    read ___done (false)
    acquire once_lock
execute func
__do_once_done
    write ___done (true)      __do_once_start
    release once_lock             // Thread 3 clear_warn_once reset ___done
                                  read ___done (false)
                                  acquire once_lock
                              execute func
schedule once_work            __do_once_done
once_deferred: OK                 write ___done (true)
static_branch_disable             release once_lock
                              schedule once_work
                              once_deferred:
                                  BUG_ON(!static_key_enabled)

Fix by moving DO_ONCE to separate .data..do_once section to avoid
race conditions.

Fixes: c2c60ea37e5b ("once: use __section(".data.once")")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 include/linux/once.h              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 883dbac79da9..94850b52e5cc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -384,6 +384,7 @@
 	__start_once = .;						\
 	*(.data..once)							\
 	__end_once = .;							\
+	*(.data..do_once)						\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
diff --git a/include/linux/once.h b/include/linux/once.h
index 30346fcdc799..261a7a4977dd 100644
--- a/include/linux/once.h
+++ b/include/linux/once.h
@@ -46,7 +46,7 @@ void __do_once_sleepable_done(bool *done, struct static_key_true *once_key,
 #define DO_ONCE(func, ...)						     \
 	({								     \
 		bool ___ret = false;					     \
-		static bool __section(".data..once") ___done = false;	     \
+		static bool __section(".data..do_once") ___done = false;	     \
 		static DEFINE_STATIC_KEY_TRUE(___once_key);		     \
 		if (static_branch_unlikely(&___once_key)) {		     \
 			unsigned long ___flags;				     \
-- 
2.33.0


