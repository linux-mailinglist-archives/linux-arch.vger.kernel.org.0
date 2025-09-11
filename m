Return-Path: <linux-arch+bounces-13479-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B333B5261B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163FBA01919
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 01:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878021D3C5;
	Thu, 11 Sep 2025 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Vouw/9NR"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569F1B21BF;
	Thu, 11 Sep 2025 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555547; cv=none; b=k/yZnJvatU7pME0fKZEv9z+lnJE31wVD980mVoeqQqaoTdnxV20HjWeCzDIJ+uBPfSU2xSuF56wz4Y25WlejYF/8CajIg4J5Meh3Hhk2yXQ3NtaIYaLUbY+TPrCqurxASlZRNCJqniCgximBoxoVDUXSZYXeorOnsAID2Ms9mik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555547; c=relaxed/simple;
	bh=RLOgC7zXP9NZxl2kK8zLRyNwOhZ7B55IEs5aMsoaots=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP0gomkfYoENLemrZ0k9EC2OXPuhsCL/4nYPaCPlcj1S6tHdHWFlBsFa12+GbupOqQTX0UXXrvRVPIm7cqBUnMbjJUSniLKMuoRoMcRCIpFYaFz+qCWHajLAhRqSG4eAWNPqnQaX6Q6Dn8laSxBi/MKiBBeZE92MYu5GLCTFNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Vouw/9NR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bipETsgPWVaFANxbSXui1hLmR6SFNZXBcN/ptmVJ9CI=; b=Vouw/9NRkZp0XoAlikAoc4vtYP
	lNACrHy23uLQP9F3DIobGFqE4y2yETY6Qm+GnRjdwxJsVAlcf7BfR1wMTFnfuSMAiEga0VN7P6Zih
	OnWeGwzyqRcJ53tiQJK2Xtg0L4qivc8HiUe1y7cYv+WjnsJYz6uBR8bCY7S6MUzexNT6rXeinSSDE
	K/VY/pFO2urn2xXoUtwrwNx+u9HrJOA4juSh1zWx0rgW38P81oxCwGtWrW4+Obu76dvdJ+hzo2RHI
	jHnQqMAtqhDlFDfKa/C0M+zJQFd2YPvSvwZDJFNVWs3PuTrYdD7Y8OBZ46ObcePz9esbZtDxpY7u9
	Fs4VujWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwWU3-0000000Avqa-1hpX;
	Thu, 11 Sep 2025 01:52:23 +0000
Date: Thu, 11 Sep 2025 02:52:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	linux-alpha@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/6] csky: remove BS check for FAULT_FLAG_ALLOW_RETRY
Message-ID: <20250911015223.GA2604499@ZenIV>
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

flags are initialized as FAULT_FLAG_DEFAULT, and the only thing done
to that afterwards is |=; since FAULT_FLAG_DEFAULT already includes
FAULT_FLAG_ALLOW_RETRY, it's guaranteed to remain there all along.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/csky/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index a885518ce1dd..a6ca7dff4215 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -277,7 +277,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	if (fault & VM_FAULT_COMPLETED)
 		return;
 
-	if (unlikely((fault & VM_FAULT_RETRY) && (flags & FAULT_FLAG_ALLOW_RETRY))) {
+	if (unlikely(fault & VM_FAULT_RETRY)) {
 		flags |= FAULT_FLAG_TRIED;
 
 		/*
-- 
2.47.2


