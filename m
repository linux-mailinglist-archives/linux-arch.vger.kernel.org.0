Return-Path: <linux-arch+bounces-15290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE832CA98DA
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 23:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08A5630170C2
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 22:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8602C234A;
	Fri,  5 Dec 2025 22:58:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE02F5496;
	Fri,  5 Dec 2025 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975481; cv=none; b=Xe7IXXdmthLE/7wiXOVy7ccpYjoqKNwCeEKr5vp7ZRET00AcruPr4Ucugd5B7kdrJzZ5/DEYxDyXNewWWoQr5UOWQMmYbGHsTKKLyitMad11uuAqBXoVuVaAp60EIxLa0Lq2qQx6v01FwtxtCiZpS/R2zKSSpC+PdB2Jl3Grst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975481; c=relaxed/simple;
	bh=ZBBvwnhuUXGzV/t3CNeVk/gGG+BuHpDQ6hDCT90vECE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shFKGzHjq095ISY7oxt6nVZSWRv1W9JmLGCWHedcRh8siWN4pzcZeDFUfYCNG2m1x8MpH4oYAcRLm5hZkDuJjM8aZVNlCGs4Et5eNS2JK1hsM8/oMaGe9ytxe/0hwIs2nVb2pMhys1Q263bbffh8c64umyFBtdReOL41qrkom4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dNRBX5twvzJ468L;
	Sat,  6 Dec 2025 06:39:16 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A00440086;
	Sat,  6 Dec 2025 06:39:27 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 6 Dec 2025 01:39:26 +0300
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
Subject: [RFC PATCH v2 4/5] lockref: use hq-spinlock
Date: Sat, 6 Dec 2025 14:21:05 +0800
Message-ID: <20251206062106.2109014-5-stepanov.anatoly@huawei.com>
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

- Example of HQ-spinlock enabled for dentry->lockref spinlock
  (used in Nginx testing scenario)

Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>

Co-authored-by: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Co-authored-by: Fedorov Nikita <fedorov.nikita@h-partners.com>
---
 include/linux/lockref.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index 676721ee8..294686604 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -42,7 +42,7 @@ struct lockref {
  */
 static inline void lockref_init(struct lockref *lockref)
 {
-	spin_lock_init(&lockref->lock);
+	spin_lock_init_hq(&lockref->lock);
 	lockref->count = 1;
 }
 
-- 
2.34.1


