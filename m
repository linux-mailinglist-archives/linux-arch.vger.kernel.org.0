Return-Path: <linux-arch+bounces-9486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0843D9FC6B0
	for <lists+linux-arch@lfdr.de>; Wed, 25 Dec 2024 23:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFEF1882E9D
	for <lists+linux-arch@lfdr.de>; Wed, 25 Dec 2024 22:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174231C3C05;
	Wed, 25 Dec 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HTLLIxTO"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A581B653E;
	Wed, 25 Dec 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735167170; cv=none; b=MxY+PzFlTWelCrSdKPxr2K6VT5iGbg/Mx8LRAeKCw6uSS+lzmwEq6Tlfgzp0oE4QRGNIvB8IgSpEse/JTNVecpez4zycie1PAbSRq/wMK9kFGEXXHMET3FiEe6oAS01XPN69L2uUnFbkKgiKyaT4fSC8rpsX+2niYs2kWUwu4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735167170; c=relaxed/simple;
	bh=BJ1bkF2bRq7DapBeVwwaT8+V5w9s4oEj9HKu5YbUkNM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DAi6XYTMc3eHbVflw1wTEsplprbPuk+7dgLBZkQPW4NQd1E9iQ60BSmDRB+EEFCFZmDFiHDBi8H+K6IoQeu9jf/n4hXH/EJeez1rE8SBNogAFa9UbmOIDllY2d+2b6OXKOJjY38TNQy09vyORT6H4tvLLxDAQHb7VmxViek+d1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HTLLIxTO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735167158;
	bh=BJ1bkF2bRq7DapBeVwwaT8+V5w9s4oEj9HKu5YbUkNM=;
	h=From:Subject:Date:To:Cc:From;
	b=HTLLIxTOk29n6S4nW8ho6AJBqXH4iCrANrB3B49ttizqq5tsUOQ3zChKbrPDuoJn3
	 vllUCzMJymFTDiMXrcfKJx3Rqrz3qPAmKGgHURtuMi4dETHzRu1UmLnh+8P6wXazL8
	 1yI9kAcTzoEV7L6EyEvrPZT0VwUIsIsRVCRUzzrE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC 0/2] module: Introduce hash-based integrity checking
Date: Wed, 25 Dec 2024 23:51:58 +0100
Message-Id: <20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI+MbGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIyNT3dz8lNKcVN2MxOKM1GJd80RTg0Tz5GSjRGMDJaCegqLUtMwKsHn
 RSkFuzkqxtbUA2vinumQAAAA=
X-Change-ID: 20241225-module-hashes-7a50a7cc2a30
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735167158; l=2299;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BJ1bkF2bRq7DapBeVwwaT8+V5w9s4oEj9HKu5YbUkNM=;
 b=uaPTOjI5sdkA/RCGSdoTlP3tvvx1abfZ1w4GNiwYxIPrHSzYG/Vam7ZjWI0KgQg7PbXOLoGhs
 0vXhHWKXHk9BOq3HHgB5RyDeUmhB8mdy1vUurhPUlB03fGG1EpdQKMz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The current signature-based module integrity checking has some drawbacks
in combination with reproducible builds:
Either the module signing key is generated at build time, which makes
the build unreproducible, or a static key is used, which precludes
rebuilds by third parties and makes the whole build and packaging
process much more complicated.
Introduce a new mechanism to ensure only well-known modules are loaded
by embedding a list of hashes of all modules built as part of the full
kernel build into vmlinux.

To properly test the reproducibility in combination with BTF the patch
"[PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation" [0]
is also needed.

Questions for current patch:
* Naming
* Can the number of built-in modules be retrieved while building
  kernel/module/hashes.o? This would remove the need for the
  preallocation step in link-vmlinux.sh.

Further improvements:
* Use a LSM/IMA/Keyring to store and validate hashes
* Make compatible with lockdown
* Use MODULE_SIG_HASH for configuration
* Enable coexistence with MODULE_SIG
* Set mod->sig_ok()
* UAPI for discovery?

[0] https://lore.kernel.org/lkml/20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      kbuild: add stamp file for vmlinux BTF data
      module: Introduce hash-based integrity checking

 Makefile                          |  8 +++++-
 include/asm-generic/vmlinux.lds.h | 11 +++++++++
 include/linux/module_hashes.h     | 17 +++++++++++++
 kernel/module/Kconfig             | 11 +++++++++
 kernel/module/Makefile            |  1 +
 kernel/module/hashes.c            | 51 +++++++++++++++++++++++++++++++++++++++
 kernel/module/internal.h          |  9 +++++++
 kernel/module/main.c              |  4 +++
 scripts/Makefile.modfinal         |  4 +--
 scripts/Makefile.vmlinux          |  5 ++++
 scripts/link-vmlinux.sh           | 31 +++++++++++++++++++++++-
 scripts/module-hashes.sh          | 26 ++++++++++++++++++++
 12 files changed, 174 insertions(+), 4 deletions(-)
---
base-commit: f722972b5df307d8c93c706c62d2e27e963c8f66
change-id: 20241225-module-hashes-7a50a7cc2a30

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


