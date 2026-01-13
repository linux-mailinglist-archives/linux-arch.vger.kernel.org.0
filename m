Return-Path: <linux-arch+bounces-15768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8523DD18C6D
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D6B63008744
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25338FF01;
	Tue, 13 Jan 2026 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mSKhjy2c"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10338F252;
	Tue, 13 Jan 2026 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307868; cv=none; b=djYiWvhzEKieTxGVJd356uzT7sFI0pFL/lFHQonJR4qEmQchC8ru6z8dMLM5EBJcdNH6MpO9oUa50stDufwT40YqHaQeVFQs2339FAWLg5bQkMAMIRiN6ijj8AiPFzEjd1o/aGbpzl+lbUZm0ppiTVWLTV1MQDlJVFnR10uJMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307868; c=relaxed/simple;
	bh=jMY1zKU+259Wp+a3wq7CZ+K7/FJMp48oaCmjQIniFCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/3yDX28/N2Wpqfq52VHlwq7D/6QI59NxXYmVKOkqGLOnuD7g1dAXTUARC1TGh2g6Iw2p0+FaSYbBlmIhWArjqal6e9yIRUMP0ylfxpXeJykx/5NFRBCR44XeTEU6kyNppvPcJZsLYKhjqSvgKJxNn64HjIbVoIKwsfdB8jW/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mSKhjy2c; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307860;
	bh=jMY1zKU+259Wp+a3wq7CZ+K7/FJMp48oaCmjQIniFCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mSKhjy2cG0SoILQv6Sr5rIyz5sWn5E0wLY3SYbLLDS9EqPxMJhvK5dceTJALZmcP6
	 IJkkOs4Z59ynVOtBwrDVgxIv2mk6V5U9lnCDBdvLQ8fszOFsxgyMUabiC78EePjOKs
	 izVG9zxTIbRTSmJkQHf/uqmX6k7wqCIvs2VkWc/k=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:49 +0100
Subject: [PATCH v4 05/17] module: Switch load_info::len to size_t
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
In-Reply-To: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, Nicolas Schier <nsc@kernel.org>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=1455;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jMY1zKU+259Wp+a3wq7CZ+K7/FJMp48oaCmjQIniFCk=;
 b=DVDR4kzvvUtq8+nWgk5cczzRSYZuy7YfCXuw3SJMcR55420EdKvv7LI9IbT3Q+CEQVjFib1SB
 YS60h4NLSKWBX+FrCbwVXvEXOnGXehLwzKKNc6JZZOu+013x24N04AZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Switching the types will make some later changes cleaner.
size_t is also the semantically correct type for this field.

As both 'size_t' and 'unsigned int' are always the same size, this
should be risk-free.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/internal.h | 2 +-
 kernel/module/main.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index e68fbcd60c35..037fbb3b7168 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -66,7 +66,7 @@ struct load_info {
 	/* pointer to module in temporary copy, freed at end of load_module() */
 	struct module *mod;
 	Elf_Ehdr *hdr;
-	unsigned long len;
+	size_t len;
 	Elf_Shdr *sechdrs;
 	char *secstrings, *strtab;
 	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 710ee30b3bea..a88f95a13e06 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1838,7 +1838,7 @@ static int validate_section_offset(const struct load_info *info, Elf_Shdr *shdr)
 static int elf_validity_ehdr(const struct load_info *info)
 {
 	if (info->len < sizeof(*(info->hdr))) {
-		pr_err("Invalid ELF header len %lu\n", info->len);
+		pr_err("Invalid ELF header len %zu\n", info->len);
 		return -ENOEXEC;
 	}
 	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0) {

-- 
2.52.0


