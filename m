Return-Path: <linux-arch+bounces-409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6A87F533B
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 23:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D281C20BC9
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC0F200AE;
	Wed, 22 Nov 2023 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laW49S+9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824319BDE;
	Wed, 22 Nov 2023 22:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02699C433C9;
	Wed, 22 Nov 2023 22:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700691506;
	bh=z8B55/ejcoe2WW+RVahNts4dxuwsQAuxIT3oPjNu21M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=laW49S+9ECP9y1T3wKde/cIOj+JYD94ZcV2pI72RtAoICnQozqPsFxDWdxqSrefDs
	 ZjJqCBW5+z6y6DzbG/csYQ6qH+PKfJG30uVSgEA5HoqOs885iuMwXWhUKNjPsAwbdw
	 XxvuGpQBeGw7woppvooV/6F5QcCuM+r8430xkQV5fEQ3z29cskCKuvxCiK6dt3ldAO
	 qaVCT/uPkCtPeBI2ntkUjI5j8N8ms+wmJIo8CjN8FD9esa5RfFYHm3KKeJJfq4DzBB
	 ppL8aFHiNtClGNGSAJOItlB/hWNweuQwonVMF7Ot9M2RAfSPlcInsxxZjHopGYk+fw
	 Q2mrXvH3TOBDQ==
From: deller@kernel.org
To: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/4] modules: Add missing entry for __ex_table
Date: Wed, 22 Nov 2023 23:18:14 +0100
Message-ID: <20231122221814.139916-5-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122221814.139916-1-deller@kernel.org>
References: <20231122221814.139916-1-deller@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

The entry for __ex_table was missing, which may make __ex_table
become 1- or 2-byte aligned in modules.
Add the entry to ensure it gets 32-bit aligned.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.0+
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
2.41.0


