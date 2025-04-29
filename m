Return-Path: <linux-arch+bounces-11713-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7749EAA0CDB
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 15:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989A13A5874
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D22D3237;
	Tue, 29 Apr 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IRRJNLk+"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218692D29B8;
	Tue, 29 Apr 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931891; cv=none; b=dKo40atZJSIykaGCaoo+WhFwvw0EBCXPEAXg3LOb5cErAJk5Z+QdC3uPC3rGwS2kabaQ/F4rJ9pYuUTaTrD9cDIlQeYggIIdPHA0GCslOt67PS/vLCbjiso8Pyl5xRtjeBTgAEoUQJnMth0wIsaby2JhekwmwdYbIe27b3g6iwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931891; c=relaxed/simple;
	bh=Y+xLjK61Kdyaf5qG4FimETVDBBB3izTwQkrP8AuirI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q0qKgOfhrdVnz6OYLlgYLW1yXVhqYN+Bfh1EKN/dwsYY9xqIn22QF6vs3VYpPu82l/hpcAOdXlilAEt+vi291IRVDDWjEn32uP1x8bIeMMXLlmr3nGlaFowKz6tPvg5U9cmjpCnMQwhVDnVEk9b331AkT6USS8w8DuX8a+nadZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IRRJNLk+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745931874;
	bh=Y+xLjK61Kdyaf5qG4FimETVDBBB3izTwQkrP8AuirI4=;
	h=From:Subject:Date:To:Cc:From;
	b=IRRJNLk+e7inQgG0GdySHCzALbfOkLdvGf9nPAyO84CiqXQO1UO0uUl/tT200tV6h
	 t9zLXBXeJ6gdAnQbVxAEgBRjbrPzmpUaaDXzdsTg/s3ZAvFTqsHtb66hBTk8xURkCa
	 s3CiPKXGBG51UzVaWwtvmbgx9fG90CgWNMI1hDFk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 0/9] module: Introduce hash-based integrity checking
Date: Tue, 29 Apr 2025 15:04:27 +0200
Message-Id: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFvOEGgC/3XMQQrCMBCF4auUrI1kpi0RV96juEiTqQloK5k2K
 qV3Ny24UVz+D943C6YYiMWxmEWkFDgMfY5yVwjrTX8hGVxugQorQKzlbXDTlaQ37ImlNrUy2lo
 0pRL5c4/UhefmNefcPvA4xNfGJ1jXf1ICqaTToCxpU3YOTg8KzGz95Pc9jWLlEn6IWgGqbwIz0
 RqAQ0WoW939EMuyvAGqrA4I8gAAAA==
X-Change-ID: 20241225-module-hashes-7a50a7cc2a30
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745931873; l=4167;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Y+xLjK61Kdyaf5qG4FimETVDBBB3izTwQkrP8AuirI4=;
 b=EPx/fKWbgM9Vin3BDBMnBLPm+4MHXpOt4igmfsC24uEu/uUVs9r+4rDAXbDMhihK1CxXjLsGa
 zLa8agdSfc0DAmg+2uNWPgMQwlyk4enmeazWuA4PLxnd5pszMLDhjHD
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

Interest has been proclaimed by NixOS, Arch Linux, Proxmox, SUSE and the
general reproducible builds community.

To properly test the reproducibility in combination with CONFIG_INFO_BTF
another patch or pahole v1.29 is needed:
"[PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation" [0]

Questions for current patch:
* Naming
* Can the number of built-in modules be retrieved while building
  kernel/module/hashes.o? This would remove the need for the
  preallocation step in link-vmlinux.sh.
* How should this interaction with IMA?

Further improvements:
* Use a LSM/IMA Keyring to store and validate hashes
* Use MODULE_SIG_HASH for configuration
* UAPI for discovery?
* Currently has a permanent memory overhead

[0] https://lore.kernel.org/lkml/20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Rebase on v6.15-rc1
- Use openssl to calculate hash
- Avoid warning if no modules are built
- Simplify module_integrity_check() a bit
- Make incompatibility with INSTALL_MOD_STRIP explicit
- Update docs
- Add IMA cleanups
- Link to v2: https://lore.kernel.org/r/20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net

Changes in v2:
- Drop RFC state
- Mention interested parties in cover letter
- Expand Kconfig description
- Add compatibility with CONFIG_MODULE_SIG
- Parallelize module-hashes.sh
- Update Documentation/kbuild/reproducible-builds.rst
- Link to v1: https://lore.kernel.org/r/20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net

---
Thomas Weißschuh (9):
      powerpc/ima: Drop unnecessary check for CONFIG_MODULE_SIG
      ima: efi: Drop unnecessary check for CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
      kbuild: add stamp file for vmlinux BTF data
      kbuild: generate module BTF based on vmlinux.unstripped
      module: Make module loading policy usable without MODULE_SIG
      module: Move integrity checks into dedicated function
      module: Move lockdown check into generic module loader
      lockdown: Make the relationship to MODULE_SIG a dependency
      module: Introduce hash-based integrity checking

 .gitignore                                   |  1 +
 Documentation/kbuild/reproducible-builds.rst |  5 ++-
 Makefile                                     |  8 +++-
 arch/powerpc/kernel/ima_arch.c               |  3 +-
 include/asm-generic/vmlinux.lds.h            | 11 ++++++
 include/linux/module.h                       |  8 ++--
 include/linux/module_hashes.h                | 17 +++++++++
 kernel/module/Kconfig                        | 21 ++++++++++-
 kernel/module/Makefile                       |  1 +
 kernel/module/hashes.c                       | 56 ++++++++++++++++++++++++++++
 kernel/module/internal.h                     |  8 +---
 kernel/module/main.c                         | 51 ++++++++++++++++++++++---
 kernel/module/signing.c                      | 24 +-----------
 scripts/Makefile.modfinal                    | 18 ++++++---
 scripts/Makefile.modinst                     |  4 ++
 scripts/Makefile.vmlinux                     |  5 +++
 scripts/link-vmlinux.sh                      | 31 ++++++++++++++-
 scripts/module-hashes.sh                     | 26 +++++++++++++
 security/integrity/ima/ima_efi.c             |  6 +--
 security/lockdown/Kconfig                    |  2 +-
 20 files changed, 250 insertions(+), 56 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20241225-module-hashes-7a50a7cc2a30

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


