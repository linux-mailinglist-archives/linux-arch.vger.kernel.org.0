Return-Path: <linux-arch+bounces-13481-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343FB52622
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B22188AC7D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2A1F2BAD;
	Thu, 11 Sep 2025 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mDc6rQ3l"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C919DF5F;
	Thu, 11 Sep 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555625; cv=none; b=EHIhnFO/4rqCy1f/zBfxMbjx6MhTnQCYpLVHsTY7X8NdKVJxbdvW3ZMEOUB9RyYCAlpaMJyZTc3AIPZsAhvxPTJDqQflCrax+WxiuycLMOqo0Iewz/Ii4Hk0Ksy7OsY66qpp7xlQk0igV+TWYQd3pEPdY9OjFuyMuPoNzhh5Ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555625; c=relaxed/simple;
	bh=AaFueproN8HkG6THuRFmfB1NLpeBpQoqrS5gTSgA1T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjCXwDwgJWwrGLwu3fuEVo7V2QSl+kYa4UewqnltO2rhqedKc+V9DfSFr4nL5Nl9ieXn4hOsAS3SRc+BSKvzzM2ovzgMspSEAQZKwbFo3SW3WXfqMdoo+HsJwbVHI8wTEVoTuQEF58ruejcKjz9bHoGAPGrVlbOlF8s5gpFwjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mDc6rQ3l; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Tk1A2sTy6VDFsphzaw8AYcpDL7TifGjn1ZBFfBwm88=; b=mDc6rQ3lUUCRFuAjzYi747ID+L
	IFJlookDCeIm3scjzhv+rMtDhRVAIxzhW0vLZYiCLT7cBbgWj8ddim7hzGz7AfDDRRjy/9w5E/p7Y
	Fh/OCI+J2fL/qi6msnGK7jyhC0AeJbypU5IyP1QpdU1Y5ojMbnvXWAVyNOBGYiC31ae/DFaC0eLbV
	4/8O1pHjelWzPOJ7FtFK2+B+CmpImEB2AZahoFu1YRJzqoAPntW9DxubzgGcy/ySX1BcqN9IZPWC3
	MBTkK5AJnYY9h6DkxodfvOBbbD+JHGkyL4PoZK0LDqIsjGcUsaupEvJJABSdjc+BIAM5kfsP8UoxW
	f/HHMFJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwWVJ-0000000AwNR-3P6B;
	Thu, 11 Sep 2025 01:53:41 +0000
Date: Thu, 11 Sep 2025 02:53:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	linux-alpha@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 3/6][openrisc] SET_PAGE_DIR() users had been gone since
 2.3.12pre1
Message-ID: <20250911015341.GC2604499@ZenIV>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/openrisc/include/asm/pgtable.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 138f46fc838b..b218050e2f6d 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -183,9 +183,6 @@ extern void paging_init(void);
 extern unsigned long empty_zero_page[2048];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 
-/* to set the page-dir */
-#define SET_PAGE_DIR(tsk, pgdir)
-
 #define pte_none(x)	(!pte_val(x))
 #define pte_present(x)	(pte_val(x) & _PAGE_PRESENT)
 #define pte_clear(mm, addr, xp)	do { pte_val(*(xp)) = 0; } while (0)
-- 
2.47.2


