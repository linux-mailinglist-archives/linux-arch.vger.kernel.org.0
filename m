Return-Path: <linux-arch+bounces-13484-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52076B5262A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E9C16C73D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 01:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4205C2264C7;
	Thu, 11 Sep 2025 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s4TeIa1k"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B30205ABA;
	Thu, 11 Sep 2025 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555711; cv=none; b=sZgmGe7oWoxsm6CmJRzKe+9qdIZd5qkSK2butXVxfbUj7FWpUd3Nuda5g/U8b66Hx6PQ5vC50WbIpGBie21MRFbe83u3bW3CQedIxDWeV8nGF0tu227I9EYyb1YM49ximR+84OvOx/DKyHPg2RgNp5O6KTKjoeIh/L4b8n3vSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555711; c=relaxed/simple;
	bh=IUy/E6H1bXQemRd+GboxB19LKjaQ+ECgX4DWNTM875Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqTvvvhNxhahogXmmaDfk4LTxFonB0eR20xeKl10DSqmYSzWdf5WyoTt///0m6nBzSXfTsBtanpc84iIhWFP8uO1fMqW6+4j3GJRV70zHlumpmWnLok1Z/r+ig1s8p3kiXkxYCb/u0CnNdUMaLzKNbykY2Zp8vU66P1VmxlNjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s4TeIa1k; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XjyFjEVFp49vxD4e2leEVo+wdo3mlJ4RdyZvmikeMp8=; b=s4TeIa1ksvf1ZRmJySenEN91rY
	1IJZ6PZ62sZg21724aEKVtwskFeMdmSePJJ+IKul9H855WvPKn0mjHHbNhiEcEFoRpAQ8uw4ckatV
	jLOR3DYSNkXwoo9kPerIQ1cAkHPBPxR4/3iMuTTnxr9zXuPnOl1mU4K8bUxDeQDdcNQR+Lihh7C5K
	+iO1g/WHmSN5ybBndw7rCXk2xVoA8pB4/id5DP+CvXqChmEUhaaPdcJnHvfUiAFJ3xmAn3AzeoQ2A
	QV+CSK04qCjs1Ci5xAdGsn6/6cE6ggcRmsvFPpTkKWGwJNb/TIdR2jnMMIcrbZn155Ngx5Cj38kmE
	LXQNwqBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwWWi-0000000AxIG-1KGT;
	Thu, 11 Sep 2025 01:55:08 +0000
Date: Thu, 11 Sep 2025 02:55:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	linux-alpha@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 6/6] alpha: unobfuscate _PAGE_P() definition
Message-ID: <20250911015508.GF2604499@ZenIV>
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

Way, way back it used to be
	_PAGE_NORMAL((x) | ((x & _PAGE_FOW) ? 0 : _PAGE_FOW | _PAGE_COW))
Then (in 1.3.54) _PAGE_COW had died.  Result:
	_PAGE_NORMAL((x) | ((x & _PAGE_FOW) ? 0 : _PAGE_FOW))
which is somewhat... obscure.  What it does is simply
	_PAGE_NORMAL((x) | _PAGE_FOW)
and IMO that's easier to follow.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 84014e9be504..90e7a9539102 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -107,7 +107,7 @@ struct vm_area_struct;
 
 #define _PAGE_NORMAL(x) __pgprot(_PAGE_VALID | __ACCESS_BITS | (x))
 
-#define _PAGE_P(x) _PAGE_NORMAL((x) | (((x) & _PAGE_FOW)?0:_PAGE_FOW))
+#define _PAGE_P(x) _PAGE_NORMAL((x) | _PAGE_FOW)
 #define _PAGE_S(x) _PAGE_NORMAL(x)
 
 /*
-- 
2.47.2


