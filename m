Return-Path: <linux-arch+bounces-13483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CAFB52627
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7025416BC35
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7B2236FD;
	Thu, 11 Sep 2025 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pxTvlzvq"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60C2F37;
	Thu, 11 Sep 2025 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555683; cv=none; b=Vpq0Og8W0pmrSQmAvw2McB+9JWRjyBU04boDjnlKByfOylQeOt1EWw38Pm91WMPz/I3hLmCt5b3xtHUQQzb4SOdXhhGQseL+n6Jtx9+s5KoMjKvbJ0Hzl52QwXKl93grv5nxdOz++QwWLopcuJLUAeb/A4F7s/fzKRkAISXTyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555683; c=relaxed/simple;
	bh=HRgrsQv3TRAJeig9Wv8n54LXSx4Fv7V04s/RUiuHWZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuWo0afBo1UPjNJQmS9IpSGZPz/QuxMH8XTXcFRpqyAswdaXIEmmyBq4h5NsOSaSOZleU4IoywchuO992hHf5YCqzY/NMo7KDHxGen6V0GigR+MenSB9ftv4DS8x+PsMg9abu7ZMDqqpJ0aGjq1T7D7SwtfYfe0rptBuQSXpZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pxTvlzvq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ukSclwrT6kroAs8r1I6CaQG0F71DFeLRQqzTaNYsaoU=; b=pxTvlzvqlKwSDfZ9WnIPNsGEDX
	ql+/4r/TOnyckp4IelqXmhAdtqGQDdyVNFMhR6cgxJloFCQiekJsL4tHn1Ilm+CZcnch/ErPWHHKw
	JG5XQAhZSmDi6PdJcmStdbgDYMQiL8wWgYhA7dQFxrwdv8wAObovOGPWIBQ7c2GLzqXLz4IgZgoBK
	1HIXSIATQqxW9ZgriUQDoGY7isxUBfGnEmlRq+UovKM4dNEgiBgfdjviTcLIlJMooOdi4P2w5gy/R
	tr15Hzqo/hAQngtjKpv5q9UIt/HcslISerC1U39/VKwYupU69zN69RD6dch3QPTXjKF8vs5PweBM6
	b85COVoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwWWG-0000000Ax1M-2EeJ;
	Thu, 11 Sep 2025 01:54:40 +0000
Date: Thu, 11 Sep 2025 02:54:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	linux-alpha@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 5/6][microblaze,xtensa] kill FIRST_USER_PGD_NR
Message-ID: <20250911015440.GE2604499@ZenIV>
References: <20250911015124.GV31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911015124.GV31600@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

dead since 2005, time to bury the body...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/microblaze/include/asm/pgtable.h | 1 -
 arch/xtensa/include/asm/pgtable.h     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index bae1abfa6f6b..ec10ec9ca639 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -99,7 +99,6 @@ extern pte_t *va_to_pte(unsigned long address);
 #define PTRS_PER_PGD	(1 << (32 - PGDIR_SHIFT))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
 #define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index d6eb695f2b26..50a136213b2b 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -58,7 +58,6 @@
 #define PTRS_PER_PTE_SHIFT	10
 #define PTRS_PER_PGD		1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	(FIRST_USER_ADDRESS >> PGDIR_SHIFT)
 
 #ifdef CONFIG_MMU
 /*
-- 
2.47.2


