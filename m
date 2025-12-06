Return-Path: <linux-arch+bounces-15289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD5CA985F
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 23:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28335301D796
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3A1277C9D;
	Fri,  5 Dec 2025 22:39:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804352D5A14;
	Fri,  5 Dec 2025 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764974372; cv=none; b=ie/oQBKhDRL78nbaiNFOCZuShEes9XzKSrISg2KxLaSMdCzuM/52gii5vXJBpDOOymRGxYFT3jtMZ3JcIu2IXwd21Ln13gYRGJ/ZJv+oqXxx22u7YD+rXp0Mk9P03Uifgql4FQkx7Q+Fyur7BHhvzNZqX9aROK44e7qpksHZ9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764974372; c=relaxed/simple;
	bh=YkpMP0x2BtTAGvl+I9l4EJ+jEa48naTAsMlLIqjob2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NePszfvsB8LA6pct9tYh23exDOaAlIBdrfslFvdo6yP2kRQipb5aOTheht32/n2oJhHN+TA8iVLS8tSOSp7LiQVaEMFI8JMW6VxS3/Gqt6vQZYElXu0g23zEYGQGQdBMCCa4QKJkmEZfsoZfJOUjvcxL4qySI4EuOo5gwSl0DUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dNRBY4BxLzJ468c;
	Sat,  6 Dec 2025 06:39:17 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 100EF4056B;
	Sat,  6 Dec 2025 06:39:28 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 6 Dec 2025 01:39:27 +0300
From: Anatoly Stepanov <stepanov.anatoly@huawei.com>
To: <peterz@infradead.org>, <boqun.feng@gmail.com>, <longman@redhat.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <arnd@arndb.de>, <dvhart@infradead.org>,
	<dave@stgolabs.net>, <andrealmeid@igalia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
	<weiyongjun1@huawei.com>, <yusongping@huawei.com>, <leijitang@huawei.com>,
	<artem.kuzin@huawei.com>, <fedorov.nikita@h-partners.com>,
	<kang.sun@huawei.com>, Anatoly Stepanov <stepanov.anatoly@huawei.com>
Subject: [RFC PATCH v2 5/5] kernel: futex: use HQ-spinlock for hash-buckets
Date: Sat, 6 Dec 2025 14:21:06 +0800
Message-ID: <20251206062106.2109014-6-stepanov.anatoly@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
References: <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
 <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

This is example of HQ-spinlock enabled for futex hash-table bucket locks
(used in memcached testing scenario)

Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>

Co-authored-by: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Co-authored-by: Fedorov Nikita <fedorov.nikita@h-partners.com>
---
 kernel/futex/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 125804fbb..05c6d1efc 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1521,7 +1521,7 @@ static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 #endif
 	atomic_set(&fhb->waiters, 0);
 	plist_head_init(&fhb->chain);
-	spin_lock_init(&fhb->lock);
+	spin_lock_init_hq(&fhb->lock);
 }
 
 #define FH_CUSTOM	0x01
-- 
2.34.1


