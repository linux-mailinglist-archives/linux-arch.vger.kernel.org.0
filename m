Return-Path: <linux-arch+bounces-13449-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6669B4AC46
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 13:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870753BFC58
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A731B833;
	Tue,  9 Sep 2025 11:38:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A14255F31;
	Tue,  9 Sep 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417926; cv=none; b=VRCt6c/TXVMYzZRLxSeWx7OvHup0m3fTbzUt0qBJsmZ+eYAVr4bToqQTz21YRDzIc6nDEQwJWitL+LXpwaSsPjmFOKCE7ni04y2xWw0VGXlg1+5QzumMcsVyk10PPZnyratQaeMXoqV8p35o6jj8NgLBpjbIExfr0E1FZms8I5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417926; c=relaxed/simple;
	bh=BL7y92URBYyKdU2Z35YuXLrdcUwIHPKCdzy5n31B7EE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aeke8SF5J6EXQdGyMNtnUq0fv/DNmnl/3yr44WS1AUrjBSO+whyKoq7bF8ALgc+687nIbkwH0JccYf+IMlyQpzfSYnagFqtMjsszX7gjW1twHbMYyjz3AAyN3PGJwId30a28hjwTsUllchooNnGQL4qgzeWUQUyL0nltFXC5k7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cLhY76wxZzdckX;
	Tue,  9 Sep 2025 19:34:03 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 06E60140137;
	Tue,  9 Sep 2025 19:38:36 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 19:38:35 +0800
Received: from huawei.com (10.44.142.84) by kwepemn200010.china.huawei.com
 (7.202.194.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 19:38:35 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <bobo.shaobowang@huawei.com>, <xiqi2@huawei.com>, <xiexiuqi@huawei.com>,
	<arnd@arndb.de>, <masahiroy@kernel.org>, <kuba@kernel.org>,
	<edumazet@google.com>, <linux-arch@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] once: fix race by moving DO_ONCE to separate section
Date: Tue, 9 Sep 2025 19:29:10 +0800
Message-ID: <20250909112911.66023-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn200010.china.huawei.com (7.202.194.133)

The commit c2c60ea37e5b ("once: use __section(".data.once")") moved
DO_ONCE's ___done variable to .data.once section, which conflicts with
DO_ONCE_LITE() that also uses the same section.

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
once_deferred: OK             write ___done (true)
static_branch_disable         release once_lock
                              schedule once_work
                              once_deferred:
                                  BUG_ON(!static_key_enabled)

DO_ONCE_LITE() in once_lite.h is used by WARN_ON_ONCE() and other warning
macros. Keep its ___done flag in the .data..once section and allow resetting
by clear_warn_once, as originally intended.

In contrast, DO_ONCE() is used for functions like get_random_once() and
relies on its ___done flag for internal synchronization. We should not reset
DO_ONCE() by clear_warn_once.

Fix it by isolating DO_ONCE's ___done into a separate .data..do_once section,
shielding it from clear_warn_once.

Fixes: c2c60ea37e5b ("once: use __section(".data.once")")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
v3 -> v2: apply the same section change to DO_ONCE_SLEEPABLE().
v2 -> v1: add comments for DO_ONCE_LITE() and DO_ONCE().
---
 include/asm-generic/vmlinux.lds.h | 1 +
 include/linux/once.h              | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index 30346fcdc799..449a0e34ad5a 100644
--- a/include/linux/once.h
+++ b/include/linux/once.h
@@ -46,7 +46,7 @@ void __do_once_sleepable_done(bool *done, struct static_key_true *once_key,
 #define DO_ONCE(func, ...)						     \
 	({								     \
 		bool ___ret = false;					     \
-		static bool __section(".data..once") ___done = false;	     \
+		static bool __section(".data..do_once") ___done = false;     \
 		static DEFINE_STATIC_KEY_TRUE(___once_key);		     \
 		if (static_branch_unlikely(&___once_key)) {		     \
 			unsigned long ___flags;				     \
@@ -64,7 +64,7 @@ void __do_once_sleepable_done(bool *done, struct static_key_true *once_key,
 #define DO_ONCE_SLEEPABLE(func, ...)						\
 	({									\
 		bool ___ret = false;						\
-		static bool __section(".data..once") ___done = false;		\
+		static bool __section(".data..do_once") ___done = false;	\
 		static DEFINE_STATIC_KEY_TRUE(___once_key);			\
 		if (static_branch_unlikely(&___once_key)) {			\
 			___ret = __do_once_sleepable_start(&___done);		\
-- 
2.33.0


