Return-Path: <linux-arch+bounces-10992-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDCFA6AC52
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 18:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D363D8A3ED9
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0D22576E;
	Thu, 20 Mar 2025 17:44:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8C1494BB;
	Thu, 20 Mar 2025 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492671; cv=none; b=RaFYYljp64FJlvn33HZw5IOtnT2QQw2KV2ibP95QGHS5KGcGArQRswqYqOSVQdkLUX80Wlrp3qO8pvMzeATzIy20ul1Hd4lyJnKYccMJtSiDScKILigq0tVMT2uVEXNBdkE7c3Km6fVmv+7QmiPQPvgV1wnwE6Ub/UVwI5eTc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492671; c=relaxed/simple;
	bh=t9Nj6WMhTxqvW9S5CSHuDrY52HJZGzWXKKgEonbqeTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=br4ILOix2IpQhxpse5Yx4ANK3t11G+Lmzsh/Zj8DvamFcApFrSnDH2efuTnJlAoZ+qJDXkENpq+1HiRaVrg52jNm1sAGSOE9B5/2qdDl3NImZ8OBGzwL+XVWJfTPQhCfjdFy1DCNPWZAaNlbyVrnDb2pjlonairOJZFNaL0kA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJXtx4jStz6K9Fg;
	Fri, 21 Mar 2025 01:41:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1893114050A;
	Fri, 21 Mar 2025 01:44:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 18:44:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<james.morse@arm.com>, <conor@kernel.org>, Yicong Yang
	<yangyicong@huawei.com>, <linux-acpi@vger.kernel.org>
CC: <linux-arch@vger.kernel.org>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 6/6] Hack: Pretend we have PSCI 1.2
Date: Thu, 20 Mar 2025 17:41:18 +0000
Message-ID: <20250320174118.39173-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

Need to update QEMU to PSCI 1.2. In meantime lie.
This is just here to aid testing, not for review!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/firmware/psci/psci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index a1ebbe9b73b1..6a7a6e91fcc4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -646,6 +646,8 @@ static void __init psci_init_smccc(void)
 		}
 	}
 
+	/* Hack until qemu version stuff updated */
+	arm_smccc_version_init(ARM_SMCCC_VERSION_1_2, psci_conduit);
 	/*
 	 * Conveniently, the SMCCC and PSCI versions are encoded the
 	 * same way. No, this isn't accidental.
-- 
2.43.0


