Return-Path: <linux-arch+bounces-9826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191CDA17245
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 18:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF80A1887DE0
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069091EF092;
	Mon, 20 Jan 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oz1+08NC"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F82033A;
	Mon, 20 Jan 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395145; cv=none; b=uLXGBb0UuNfNZCGK/Fy1JkFgYYmhtX5IpCBap2RZeJvjGsq/7MfHBlYtiz7+wnMCbpk13Xv+VmOTI5bAxixeOoHfJ/5zpGIvY+Mnt6Gb1AcUK75VkxdhvZm3XaCinlfim21BSJQMl38G9qr0yNCxoPc77L22zkDHqrnXSuNxtyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395145; c=relaxed/simple;
	bh=Anacu4YjU7Y+0UFvshDNslsiaYXQWIpLpz4Odcpokpo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P7JM0TEXzgj6F9PZzoFedapb8iXh7NTBOuYE7beXNCI6q5L4Qo7RY8SsIfWCu0e2EMqXnsfrwoac/Moyj6IYPjXv3+TSbbbI4CZw6qxHgZ5UcLAAtA8cwHznLEOzrMajY1Q4+ofYd9B1vo0IHTFZ2W9ISL7o5H07I9y/RZ4FWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oz1+08NC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737395132;
	bh=Anacu4YjU7Y+0UFvshDNslsiaYXQWIpLpz4Odcpokpo=;
	h=From:Subject:Date:To:Cc:From;
	b=oz1+08NC3D+Rhd49WpzRylo0D1eWe2OT8a5wTIivYU5cjl3JtKdXh4Ln81QznbVUt
	 BpwSg82Fu+Avhuurp8TmaaxU8/OV2rCosrm8dgANrflMmq2ffR/yft7tf01Y4FsCKo
	 QzLduNvOYkBFAFDyIBlXqP+rkMi+iw6cnfRw8qX0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/6] module: Introduce hash-based integrity checking
Date: Mon, 20 Jan 2025 18:44:19 +0100
Message-Id: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHOLjmcC/3XMQQrCMBCF4auUWTuSpJaAK+8hXYRkagY0lUwbl
 ZK7G7t3+T943wZCmUng3G2QqbDwnFqYQwc+unQj5NAajDInbcyAjzmsd8LoJJKgdYNy1nvjegX
 t88w08Xv3rmPryLLM+bPzRf/Wf1LRqDBYrTxZ109BX17EIuLjGo+JFhhrrV+L53jTrwAAAA==
X-Change-ID: 20241225-module-hashes-7a50a7cc2a30
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737395132; l=3412;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Anacu4YjU7Y+0UFvshDNslsiaYXQWIpLpz4Odcpokpo=;
 b=n8+AYe5cOrCdvMkfIk3unYSBDTJ/R6Pp6/qaXgD2sDJMYgTaiUbZDVr0KAUbEB3gqDIfVjOb5
 xe5U1rXRsKNBER8mFF9akip/deC0okGKLPSwwC9ROq9AQ9Ah9xnfYX3
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
another patch is needed:
"[PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation" [0]
(If you happen to test that one, please give some feedback)

Questions for current patch:
* Naming
* Can the number of built-in modules be retrieved while building
  kernel/module/hashes.o? This would remove the need for the
  preallocation step in link-vmlinux.sh.

Further improvements:
* Use a LSM/IMA/Keyring to store and validate hashes
* Use MODULE_SIG_HASH for configuration
* UAPI for discovery?

[0] https://lore.kernel.org/lkml/20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Drop RFC state
- Mention interested parties in cover letter
- Expand Kconfig description
- Add compatibility with CONFIG_MODULE_SIG
- Parallelize module-hashes.sh
- Update Documentation/kbuild/reproducible-builds.rst
- Link to v1: https://lore.kernel.org/r/20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net

---
Thomas Weißschuh (6):
      kbuild: add stamp file for vmlinux BTF data
      module: Make module loading policy usable without MODULE_SIG
      module: Move integrity checks into dedicated function
      module: Move lockdown check into generic module loader
      lockdown: Make the relationship to MODULE_SIG a dependency
      module: Introduce hash-based integrity checking

 .gitignore                                   |  1 +
 Documentation/kbuild/reproducible-builds.rst |  5 ++-
 Makefile                                     |  8 ++++-
 include/asm-generic/vmlinux.lds.h            | 11 ++++++
 include/linux/module.h                       |  8 ++---
 include/linux/module_hashes.h                | 17 +++++++++
 kernel/module/Kconfig                        | 21 ++++++++++-
 kernel/module/Makefile                       |  1 +
 kernel/module/hashes.c                       | 52 +++++++++++++++++++++++++++
 kernel/module/internal.h                     |  8 +----
 kernel/module/main.c                         | 54 +++++++++++++++++++++++++---
 kernel/module/signing.c                      | 24 +------------
 scripts/Makefile.modfinal                    | 10 ++++--
 scripts/Makefile.vmlinux                     |  5 +++
 scripts/link-vmlinux.sh                      | 31 +++++++++++++++-
 scripts/module-hashes.sh                     | 26 ++++++++++++++
 security/lockdown/Kconfig                    |  2 +-
 17 files changed, 238 insertions(+), 46 deletions(-)
---
base-commit: 2cd5917560a84d69dd6128b640d7a68406ff019b
change-id: 20241225-module-hashes-7a50a7cc2a30

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


