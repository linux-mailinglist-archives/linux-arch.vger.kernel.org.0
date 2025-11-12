Return-Path: <linux-arch+bounces-14660-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DCFC5045E
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 03:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8893E189BC7F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD782C026F;
	Wed, 12 Nov 2025 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nf6racO2";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nf6racO2"
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB22951B3;
	Wed, 12 Nov 2025 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912743; cv=none; b=SMKf0yMC6INthkel04O2tTSrYuG3eXbXWIk+Vuiuqh1I1RNvGaaErlsvsaHtaGMkrxSWBZ9w5pwgS4c0J8oW2/V34QYS25L2XqfdGVMgdzRmEgQprN7V/1nFu02k9S1+zW2OOvHlEptJ5+I8UinivhAE7ehhsrsVsTX8GAFKP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912743; c=relaxed/simple;
	bh=VGlN7vVe2hkC/tx36jnpELpV0RtmhQbUr5kiaBGYMw4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DjA8KNBxA4uCbG3O1T2wWQ2yVJ//THWxpPfJ2OAwj0zIUso1zd8GdqGKffF5ts1Ve5SGyiq3Bl+4MSS93ZKhGnwijjouAxI/6PYsCEkY/ReJcFOUN4OL6MLRQF3eJU7A+c3qEcF57sPNCpd2s2qaZD3fQjrwHuYL+ru9MTLCblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nf6racO2; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nf6racO2; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wuX5r28VaexWnYhOLnt7f93j+3rz9YK+PcJBP/DbyyY=;
	b=nf6racO2ksupU9wnn7MfavGg5x+g9M7INfJAy2o3q9Itvw5SbuaeUa0L2xgDo5LTzma7YBj6a
	2tOcS8MpWNvVWvo7OTjD4FW4TnG/HXjnAciTL84eHGp7WasyyJ5J8KwQhG85pKW6pHTMaVNMc9N
	aNat5F8LjTaYTJ9S9WAzOkE=
Received: from canpmsgout11.his.huawei.com (unknown [172.19.92.148])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4d5mlb08ftz1BFpZ;
	Wed, 12 Nov 2025 09:58:35 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wuX5r28VaexWnYhOLnt7f93j+3rz9YK+PcJBP/DbyyY=;
	b=nf6racO2ksupU9wnn7MfavGg5x+g9M7INfJAy2o3q9Itvw5SbuaeUa0L2xgDo5LTzma7YBj6a
	2tOcS8MpWNvVWvo7OTjD4FW4TnG/HXjnAciTL84eHGp7WasyyJ5J8KwQhG85pKW6pHTMaVNMc9N
	aNat5F8LjTaYTJ9S9WAzOkE=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5mjy0VhLzKm7C;
	Wed, 12 Nov 2025 09:57:10 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 00E0A1A0174;
	Wed, 12 Nov 2025 09:58:50 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:58:48 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:58:48 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <andriy.shevchenko@linux.intel.com>,
	<herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-crypto@vger.kernel.org>, <linux-api@vger.kernel.org>
CC: <fanghao11@huawei.com>, <shenyang39@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>
Subject: [PATCH RFC 0/4] Introduce 128-bit IO access
Date: Wed, 12 Nov 2025 09:58:42 +0800
Message-ID: <20251112015846.1842207-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200001.china.huawei.com (7.202.195.16)

These patches introduce 128-bit IO access functionality. The reason
is that the current HiSilicon cryptographic devices need to
maintain atomic operations when accessing 128-bit MMIO across
physical and virtual functions.

Currently, 128-bit atomic writes have already been implemented in
the device driver, and the driver also depends on a 128-bit atomic
read access interface. Therefore, we have introduced a generic
128-bit IO access interface to replace the implementation of
128-bit read and write IO interfaces using instructions in the
device driver. When the architecture does not support 128-bit
atomic operations, non-atomic 128-bit read and write interfaces can
be used to make the driver functional.

Weili Qian (4):
  UAPI: Introduce 128-bit types and byteswap operations
  asm-generic/io.h: add io{read,write}128 accessors
  io-128-nonatomic: introduce io{read|write}128_{lo_hi|hi_lo}
  arm64/io: Add {__raw_read|__raw_write}128 support

 arch/arm64/include/asm/io.h                  | 21 +++++++++
 include/asm-generic/io.h                     | 48 ++++++++++++++++++++
 include/linux/io-128-nonatomic-hi-lo.h       | 35 ++++++++++++++
 include/linux/io-128-nonatomic-lo-hi.h       | 34 ++++++++++++++
 include/uapi/linux/byteorder/big_endian.h    |  6 +++
 include/uapi/linux/byteorder/little_endian.h |  6 +++
 include/uapi/linux/swab.h                    | 10 ++++
 include/uapi/linux/types.h                   |  3 ++
 8 files changed, 163 insertions(+)
 create mode 100644 include/linux/io-128-nonatomic-hi-lo.h
 create mode 100644 include/linux/io-128-nonatomic-lo-hi.h

-- 
2.33.0


