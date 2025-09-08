Return-Path: <linux-arch+bounces-13400-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE48B4828B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 04:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590823A6DA6
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666D183CA6;
	Mon,  8 Sep 2025 02:20:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F72EACD;
	Mon,  8 Sep 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298010; cv=none; b=flUzA1jdfPUs4u6n24q4Slq9v4end/IpVzCRZzQfJI/TTejmIlnuK/zBwp3mxYVfBmeMEScxqEzous0J0rq9/RoZps1xAPMS/nYyvMfP8wXfifCwub5uW8njO7QiU/8x7jmttkomQvj/HxRMW1cOIn34yG3sbST8UU9XEK/7y8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298010; c=relaxed/simple;
	bh=KRSfORJrFl0gP3PLxItagIn9DLD7WCyexIdVlQZwDww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qYHq4AlPgUB2xBcrSIbjNWainUiBE3TE75wjA/+EMCZOAehTPmN2j6d6/xLdCjqrNSgsHe57TE5IybSEr1sqLInD1YiSeNI/gPzCy2RFgxURXNLSZj36scmkFQhNt2h/s5kKYG+ntPnKMjrmcU2imGcLmZ2PZ/tH8SR4Bxy5yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cKrDY4Rl4z2TT3C;
	Mon,  8 Sep 2025 10:16:45 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 96C401A016C;
	Mon,  8 Sep 2025 10:19:58 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 10:19:58 +0800
Received: from huawei.com (10.44.142.84) by kwepemn200010.china.huawei.com
 (7.202.194.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Sep
 2025 10:19:57 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <bobo.shaobowang@huawei.com>, <xiqi2@huawei.com>, <xiexiuqi@huawei.com>,
	<arnd@arndb.de>, <masahiroy@kernel.org>, <kuba@kernel.org>,
	<edumazet@google.com>, <linux-arch@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] once: fix race by moving DO_ONCE to separate section
Date: Mon, 8 Sep 2025 10:10:36 +0800
Message-ID: <20250908021036.1971956-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 include/linux/once.h              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ae2d2359b79e..8efbe8c4874e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -361,6 +361,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
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


