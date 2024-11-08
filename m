Return-Path: <linux-arch+bounces-8924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C69C187F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 09:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16208287152
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904961494D4;
	Fri,  8 Nov 2024 08:54:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E351E0B9C
	for <linux-arch@vger.kernel.org>; Fri,  8 Nov 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056077; cv=none; b=a/3az9GVTuFGsrEJ8yYfbPMDs2NITbdFgyf3PjM8chnHnnJdMCgCL2NxQvQrp5xOeEbwpw48n5gA9mn5hocEUryyWknoPMWyI0SfvVaax967PbkGlmyz6rfmRddeShPrUG9L+WDACFaiKP/+cCnHT/IrRQZzWzuEZHdQurT5Zxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056077; c=relaxed/simple;
	bh=GzceIAbaXNsPjGUFjgVnyrzFi+PFtbLOmvFMQRf/2JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nuRIGamfRykfJ84lhC8vNOM69586IzWr5MTB3MUrzdBMm8H0QMEH2n1IynJ4zz1xxD4sI0hcq4b6SN2MPwX5iI1NWXr9CG4RUPj7tFWj/QgBXOpGW5OLAWS17q/1lNSIPb9+7Z3kEy0ZhiVS5VDRaojTFN4K6+b1qtFWZe8Vjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B90D1007;
	Fri,  8 Nov 2024 00:55:03 -0800 (PST)
Received: from udebian.localdomain (unknown [10.57.26.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64A93F66E;
	Fri,  8 Nov 2024 00:54:31 -0800 (PST)
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	nd@arm.com,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: [PATCH v4 1/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Date: Fri,  8 Nov 2024 08:53:56 +0000
Message-Id: <20241108085358.777687-2-yury.khrustalev@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108085358.777687-1-yury.khrustalev@arm.com>
References: <20241108085358.777687-1-yury.khrustalev@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory protection keys (pkeys) uapi has two macros for pkeys restrictions:

 - PKEY_DISABLE_ACCESS 0x1
 - PKEY_DISABLE_WRITE  0x2

with implicit literal value of 0x0 that means "unrestricted". Code that
works with pkeys has to use this literal value when implying that a pkey
imposes no restrictions. This may reduce readability because 0 can be
written in various ways (e.g. 0x0 or 0) and also because 0 in the context
of pkeys can be mistaken for "no permissions" (akin PROT_NONE) while it
actually means "no restrictions". This is important because pkeys are
oftentimes used near mprotect() that uses PROT_ macros.

This patch adds PKEY_UNRESTRICTED macro defined as 0x0.

Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
---
 include/uapi/asm-generic/mman-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..ea40e27e6dea 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -82,6 +82,7 @@
 /* compatibility flags */
 #define MAP_FILE	0
 
+#define PKEY_UNRESTRICTED	0x0
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-- 
2.39.5


