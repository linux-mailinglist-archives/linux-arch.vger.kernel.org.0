Return-Path: <linux-arch+bounces-9835-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F39A17BA1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 11:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0543AC021
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D185B1F12EE;
	Tue, 21 Jan 2025 10:27:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50861F0E44;
	Tue, 21 Jan 2025 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737455231; cv=none; b=HMKXiDa+jPCdTE0jz+Yjy4qbu585TajAMKh+dW/QwqVM62Ufh1+3CKmqFCRjAfzoi09tZHpditlo+9NHbvTz2QoyBWRaeUd41GTIZ4NU0SPkuuyHi/H+uVRWMzFFLm7Hun5zxxhQcPBLxErOaMlqJ51yzTSVNme/vnGd2MLul7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737455231; c=relaxed/simple;
	bh=Itx1KidBw4QpxecgKrKibHzjX+XhiOBYVd+0EdKjtZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTRkQDuqQciMjB3oS2ttAlYwH/QCao9mw7PxHy0y5XY7TI76DbgBI3x3Uofp0cS8qZUJiVRkKpFnj2wbKLWuZW782u+0OtU63p5VX7NfctRjnfWTRgRXU3lDLMEDqQSNWaqSKTNFgrnHVDVWY1biRNbKJzKpxsknF47MpI6Cm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4YcjVp0C54z9v7NR;
	Tue, 21 Jan 2025 18:04:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8A663140EB3;
	Tue, 21 Jan 2025 18:26:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHmklZdo9nRW0IAQ--.11999S2;
	Tue, 21 Jan 2025 11:26:51 +0100 (CET)
Message-ID: <69b38f6a6fb53e7b8f8250e1d37641c6abbb6d07.camel@huaweicloud.com>
Subject: Re: [PATCH v2 0/6] module: Introduce hash-based integrity checking
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Masahiro
 Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@arndb.de>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Fabian =?ISO-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 zohar@linux.ibm.com
Date: Tue, 21 Jan 2025 11:26:29 +0100
In-Reply-To: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHmklZdo9nRW0IAQ--.11999S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fur4ktF1xXw43WF1xZrb_yoWrGF4Upa
	yDKr45tr4kJryxAFs3Ar109r15K3ykGw4agFsxGw42y34j9r12vFnFg34fZFy29r4IkFyU
	Gr4aqF1jkryDJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBGePR1QCGgABso

On Mon, 2025-01-20 at 18:44 +0100, Thomas Wei=C3=9Fschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds:
> Either the module signing key is generated at build time, which makes
> the build unreproducible, or a static key is used, which precludes
> rebuilds by third parties and makes the whole build and packaging
> process much more complicated.
> Introduce a new mechanism to ensure only well-known modules are loaded
> by embedding a list of hashes of all modules built as part of the full
> kernel build into vmlinux.
>=20
> Interest has been proclaimed by NixOS, Arch Linux, Proxmox, SUSE and the
> general reproducible builds community.
>=20
> To properly test the reproducibility in combination with CONFIG_INFO_BTF
> another patch is needed:
> "[PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation" [0]
> (If you happen to test that one, please give some feedback)
>=20
> Questions for current patch:
> * Naming
> * Can the number of built-in modules be retrieved while building
>   kernel/module/hashes.o? This would remove the need for the
>   preallocation step in link-vmlinux.sh.
>=20
> Further improvements:
> * Use a LSM/IMA/Keyring to store and validate hashes

+ linux-integrity, Mimi

Hi Thomas

I developed something related to it, it is called Integrity Digest
Cache [1].

It has the ability to store in the kernel memory a cache of digests
extracted from a file (or if desired in the future, from a reserved
area in the kernel image).

It exposes an API to query a digest (get/lookup/put) from a digest
cache and to verify whether or not the integrity of the file digests
were extracted from was verified by IMA or another LSM
(verif_set/verif_get).=20

Roberto


[1]: https://lore.kernel.org/linux-integrity/20241119104922.2772571-1-rober=
to.sassu@huaweicloud.com/

> * Use MODULE_SIG_HASH for configuration
> * UAPI for discovery?
>=20
> [0] https://lore.kernel.org/lkml/20241211-pahole-reproducible-v1-1-22feae=
19bad9@weissschuh.net/
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Drop RFC state
> - Mention interested parties in cover letter
> - Expand Kconfig description
> - Add compatibility with CONFIG_MODULE_SIG
> - Parallelize module-hashes.sh
> - Update Documentation/kbuild/reproducible-builds.rst
> - Link to v1: https://lore.kernel.org/r/20241225-module-hashes-v1-0-d710c=
e7a3fd1@weissschuh.net
>=20
> ---
> Thomas Wei=C3=9Fschuh (6):
>       kbuild: add stamp file for vmlinux BTF data
>       module: Make module loading policy usable without MODULE_SIG
>       module: Move integrity checks into dedicated function
>       module: Move lockdown check into generic module loader
>       lockdown: Make the relationship to MODULE_SIG a dependency
>       module: Introduce hash-based integrity checking
>=20
>  .gitignore                                   |  1 +
>  Documentation/kbuild/reproducible-builds.rst |  5 ++-
>  Makefile                                     |  8 ++++-
>  include/asm-generic/vmlinux.lds.h            | 11 ++++++
>  include/linux/module.h                       |  8 ++---
>  include/linux/module_hashes.h                | 17 +++++++++
>  kernel/module/Kconfig                        | 21 ++++++++++-
>  kernel/module/Makefile                       |  1 +
>  kernel/module/hashes.c                       | 52 ++++++++++++++++++++++=
+++++
>  kernel/module/internal.h                     |  8 +----
>  kernel/module/main.c                         | 54 ++++++++++++++++++++++=
+++---
>  kernel/module/signing.c                      | 24 +------------
>  scripts/Makefile.modfinal                    | 10 ++++--
>  scripts/Makefile.vmlinux                     |  5 +++
>  scripts/link-vmlinux.sh                      | 31 +++++++++++++++-
>  scripts/module-hashes.sh                     | 26 ++++++++++++++
>  security/lockdown/Kconfig                    |  2 +-
>  17 files changed, 238 insertions(+), 46 deletions(-)
> ---
> base-commit: 2cd5917560a84d69dd6128b640d7a68406ff019b
> change-id: 20241225-module-hashes-7a50a7cc2a30
>=20
> Best regards,


