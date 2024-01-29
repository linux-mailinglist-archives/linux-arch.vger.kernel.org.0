Return-Path: <linux-arch+bounces-1802-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D12B84136B
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 20:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E97B241B7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451613D51E;
	Mon, 29 Jan 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dsewV60v"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE676023;
	Mon, 29 Jan 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556412; cv=none; b=RidLqjO4iURrDsX0bs1GvXM5qk0N2nKLBjE85trFuzfLr19G2o2XQ+DKv1lknOw8n5ukb75ZPmadNDLvPPmX6GrV/pf9OaU9el25XUBAbPJCLlfGaqxAzSXSi2KKMyYzeULTznm0hwRaAeDmTMaRlGXvYFaZpp9U5i57CUOS03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556412; c=relaxed/simple;
	bh=0DCssUbSMzZG0WW8U5N3x7j24bKA4wfldkB5+LDWwFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEhqsYlBYpRoU+54rulEJppnwUzC+IP6nku896V/eSf19CVVOESOZf/E2/itmM/8BF5a52ZJnsfNKuLi3gzzKIVgZxOIu1heQ0mg6YiFWumW1tUn+t7TfJyHrgBdJxlUX3b0VmzP66DKInBfwew+N7zKXCH2rOvIdT//9s7U0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dsewV60v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=M1jujuKLf3xpruhDR2flI4/MXT9+iY7sBsE2JSjaJ8k=; b=dsewV60v9w6yB9nt1NnbKQcKrt
	vs1tUjLgte/Y8/eVUZw0tp4OdcDd/1aOSTr0te2/7Ri1VsyL4zE7Y05iM5U8Sx5e8yQU2yAmNWgO8
	Rp+Mx84CubR+TVZ4CElMitOr7g17G6b1xhmr8kPm6FkeTdi+tpTvKIEpGfk9hmvEDpN8NERbZAot4
	Nmp6AFlEDwR08x4/fFbTK3D+kCF0yMECJMixu+0sIr8TdnvS4lt6ldfAe6g21vOJpz/duKBw12tkK
	P/Yv8yLABZiaFa6gfwV2++5kivIJqLG6WOlZDczDtwzaiI0YqUZuysI4jXEeqpN38mzqcnCDd9Gt5
	8560ml8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXHN-0000000E683-3D7U;
	Mon, 29 Jan 2024 19:26:49 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: masahiroy@kernel.org,
	deller@gmx.de
Cc: mcgrof@kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] modules: Add missing entry for __ex_table
Date: Mon, 29 Jan 2024 11:26:43 -0800
Message-ID: <20240129192644.3359978-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129192644.3359978-1-mcgrof@kernel.org>
References: <20240129192644.3359978-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Helge Deller <deller@gmx.de>

The entry for __ex_table was missing, which may make __ex_table
become 1- or 2-byte aligned in modules.
Add the entry to ensure it gets 32-bit aligned.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 scripts/module.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index b00415a9ff27..488f61b156b2 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -26,6 +26,7 @@ SECTIONS {
 	.altinstructions	0 : ALIGN(8) { KEEP(*(.altinstructions)) }
 	__bug_table		0 : ALIGN(8) { KEEP(*(__bug_table)) }
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
+	__ex_table		0 : ALIGN(4) { KEEP(*(__ex_table)) }
 
 	__patchable_function_entries : { *(__patchable_function_entries) }
 
-- 
2.42.0


