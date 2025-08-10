Return-Path: <linux-arch+bounces-13098-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646AEB1F83F
	for <lists+linux-arch@lfdr.de>; Sun, 10 Aug 2025 05:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744C6189BB66
	for <lists+linux-arch@lfdr.de>; Sun, 10 Aug 2025 03:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E818528E;
	Sun, 10 Aug 2025 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jyvGSVM9"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA120326;
	Sun, 10 Aug 2025 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754797333; cv=none; b=qeJlEH+oBEmv9LfBkOaYEVjsQbnJoxLhsLx0MgojQuOEDZHrC2N6CeWrxfb8+OHnEpg7BlGLY/C4uGEo4/SHN+mwvGyOs1vTZz8TCI4glygRYDkFqK9iH2RKdB9XSkiGsEI7fjtI1frc4Z6zoHkgujtIp1RlXN9D7qRhGnIrMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754797333; c=relaxed/simple;
	bh=sRQphQsbdSqw9t9FKGgb7so/WRPN2/oUCDWNlqAlQXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mok5u96TAd3s8bH1gm9jwT4Lynp8i/iFDR5jZ2lm1etCsUMcu7EtfDrxSJV2wwsrfpY/qcddM56GfdJCQJty1Vu2xqTnSgeHY5MDlqaxwLtmDqTm9STMC5NPHws8G8zeLmwkY8QOthKahVSSXRv08IgOhjeveWrSBqXAh3qnbmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jyvGSVM9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qPlTf7fIy8A1PMw5CFTdvUZdawfMWqNgCtcCDS0I6ns=; b=jyvGSVM9Efd2lJa4NnBZc0i7s8
	MDLKei39E5U8we1Ym/wOUSx8PbpUzVdl5akuCRAIyUVt50fjyQgXm2sbidq9c5FJ/oKq3ICUUiya4
	+zh19TdbLEbe05GZVvyV5f//g/tpRhYkei6leZucaX4fixb1mI+AZ1rRBlheqCQnuXbVrt2cJflIC
	Ge/cTcpZEkVWHOMhd3AUjAvyszdHZXraaTEleiditvguT0nU5vZ8ZBW8tHtgpuvLGa/Ddo+aFJxWG
	B0M9/+bZ/JX61aJ8la/KqjqMo067PeVEhAVC9dWza46Pxt0gN+WZ+PZFiTq9fu2KFWy6MedMSxhz/
	IeOs7DMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukwwi-00000002FXU-0pkL;
	Sun, 10 Aug 2025 03:42:08 +0000
Date: Sun, 10 Aug 2025 04:42:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: sparclinux@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Subject: [PATCH] fix prototypes of reads[bwl]() on sparc64
Message-ID: <20250810034208.GJ222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Conventions for readsl() are the same as for readl() - any __iomem
pointer is acceptable, both const and volatile ones being OK.  Same
for readsb() and readsw().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index c9528e4719cd..d8ed296624af 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -250,19 +250,19 @@ void insl(unsigned long, void *, unsigned long);
 #define insw insw
 #define insl insl
 
-static inline void readsb(void __iomem *port, void *buf, unsigned long count)
+static inline void readsb(const volatile void __iomem *port, void *buf, unsigned long count)
 {
 	insb((unsigned long __force)port, buf, count);
 }
 #define readsb readsb
 
-static inline void readsw(void __iomem *port, void *buf, unsigned long count)
+static inline void readsw(const volatile void __iomem *port, void *buf, unsigned long count)
 {
 	insw((unsigned long __force)port, buf, count);
 }
 #define readsw readsw
 
-static inline void readsl(void __iomem *port, void *buf, unsigned long count)
+static inline void readsl(const volatile void __iomem *port, void *buf, unsigned long count)
 {
 	insl((unsigned long __force)port, buf, count);
 }

