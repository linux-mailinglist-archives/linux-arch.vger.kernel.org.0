Return-Path: <linux-arch+bounces-9837-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF63A17E92
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 14:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0845C1881FAE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64762E406;
	Tue, 21 Jan 2025 13:11:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F951F2390;
	Tue, 21 Jan 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465107; cv=none; b=PaprVwkjenaiNBrP/sf2Xv2IY3sXFfa+VHcJI52AAWXWuXWBk1gPXgDWaIyF+u6ee8UVvUNShZNcuhTCAUoDVAeeb9yCYFPlbEu2pGLtmKeKLQgtgUjdiFzH/6g+z/TWrF2VQwGiH5QTDCeK86QwvlmEgnHI/XSqbQSiKJSn9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465107; c=relaxed/simple;
	bh=9fYvXgSwsjHYdYsfiwKZn0WXtSbUbbLx+ln552yY3kI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pQkqvE7mBUsRJc3StY14jvMaClTApcQl29Nfrcjj2tUfd3nfmPDnnHnv2PQoHI1OVWisK9LmIj4TLeufY125ll1siSH79W3rUV4ZpP0k/apmNQfbyMT8RBCDHOU6ikGnrCF+DajC2ZMKpDJnMp52/Tu3zY6eMcoc3QWwsWPpXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Ycn8p5fv9z9v7N7;
	Tue, 21 Jan 2025 20:49:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BE634140725;
	Tue, 21 Jan 2025 21:11:30 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3reDwnI9nT9QIAQ--.50808S2;
	Tue, 21 Jan 2025 14:11:29 +0100 (CET)
Message-ID: <207235b3b8939fe6831e43208a41d9bed38f0fb2.camel@huaweicloud.com>
Subject: Re: [PATCH v2 0/6] module: Introduce hash-based integrity checking
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann
 <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Daniel
 Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan
 Corbet <corbet@lwn.net>, Fabian =?ISO-8859-1?Q?Gr=FCnbichler?=
 <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, Mattia
 Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Date: Tue, 21 Jan 2025 14:11:09 +0100
In-Reply-To: <ea767c0b-77fd-4e8a-ab14-4d231e9b779f@t-8ch.de>
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
	 <69b38f6a6fb53e7b8f8250e1d37641c6abbb6d07.camel@huaweicloud.com>
	 <ea767c0b-77fd-4e8a-ab14-4d231e9b779f@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwD3reDwnI9nT9QIAQ--.50808S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr43AF4fZF1rtr1UuryfJFb_yoW7Wr1Upa
	yUKa15tr4kJryxJF4Syw1v9F15K397JF42gFnxGr1xJryq9r1jvF17K34fuF97Wr48CFyU
	Wr4aq3WDuryDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBGePR1MDeQAAsP

On Tue, 2025-01-21 at 13:58 +0100, Thomas Wei=C3=9Fschuh wrote:
> Hi Roberto,
>=20
> On 2025-01-21 11:26:29+0100, Roberto Sassu wrote:
> > On Mon, 2025-01-20 at 18:44 +0100, Thomas Wei=C3=9Fschuh wrote:
> > > The current signature-based module integrity checking has some drawba=
cks
> > > in combination with reproducible builds:
> > > Either the module signing key is generated at build time, which makes
> > > the build unreproducible, or a static key is used, which precludes
> > > rebuilds by third parties and makes the whole build and packaging
> > > process much more complicated.
> > > Introduce a new mechanism to ensure only well-known modules are loade=
d
> > > by embedding a list of hashes of all modules built as part of the ful=
l
> > > kernel build into vmlinux.
> > >=20
> > > Interest has been proclaimed by NixOS, Arch Linux, Proxmox, SUSE and =
the
> > > general reproducible builds community.
> > >=20
> > > To properly test the reproducibility in combination with CONFIG_INFO_=
BTF
> > > another patch is needed:
> > > "[PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation" [0=
]
> > > (If you happen to test that one, please give some feedback)
> > >=20
> > > Questions for current patch:
> > > * Naming
> > > * Can the number of built-in modules be retrieved while building
> > >   kernel/module/hashes.o? This would remove the need for the
> > >   preallocation step in link-vmlinux.sh.
> > >=20
> > > Further improvements:
> > > * Use a LSM/IMA/Keyring to store and validate hashes
> >=20
> > + linux-integrity, Mimi
> >=20
> > Hi Thomas
> >=20
> > I developed something related to it, it is called Integrity Digest
> > Cache [1].
>=20
> Thanks for the pointer.
>=20
> > It has the ability to store in the kernel memory a cache of digests
> > extracted from a file (or if desired in the future, from a reserved
> > area in the kernel image).
> >=20
> > It exposes an API to query a digest (get/lookup/put) from a digest
> > cache and to verify whether or not the integrity of the file digests
> > were extracted from was verified by IMA or another LSM
> > (verif_set/verif_get).=20
>=20
> I see how this could be used together with the module hashes.
> For now I think both features should be developed independently.
> Integrating them will require some extra code and coordination.

Yes, I agree.

> While the current linear, unsorted list of hashes used by my code may be
> slightly inefficient, it shouldn't matter in practize as the hash
> validation is only a bunch of memcmp()s over a contiguous chunk of
> memory, which is very cheap.

Ok, I guess so, should not be too slow for this use case.

> When both features are well established we can look at integrating them.
> At least a build-time userspace generator of a digest cache would be
> necessary.
> And due to the current implementation details it would be necessary to
> estimate the size of a static digest cache more or less exactly by its
> number of elements alone.

This information is included in the digest list, since it is also used
by the Integrity Digest Cache itself to determine the correct size of
the hash table.

Thanks

Roberto

> Thomas
>=20
> > [1]: https://lore.kernel.org/linux-integrity/20241119104922.2772571-1-r=
oberto.sassu@huaweicloud.com/
> >=20
> > > * Use MODULE_SIG_HASH for configuration
> > > * UAPI for discovery?
> > >=20
> > > [0] https://lore.kernel.org/lkml/20241211-pahole-reproducible-v1-1-22=
feae19bad9@weissschuh.net/
> > >=20
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > ---
> > > Changes in v2:
> > > - Drop RFC state
> > > - Mention interested parties in cover letter
> > > - Expand Kconfig description
> > > - Add compatibility with CONFIG_MODULE_SIG
> > > - Parallelize module-hashes.sh
> > > - Update Documentation/kbuild/reproducible-builds.rst
> > > - Link to v1: https://lore.kernel.org/r/20241225-module-hashes-v1-0-d=
710ce7a3fd1@weissschuh.net
> > >=20
> > > ---
> > > Thomas Wei=C3=9Fschuh (6):
> > >       kbuild: add stamp file for vmlinux BTF data
> > >       module: Make module loading policy usable without MODULE_SIG
> > >       module: Move integrity checks into dedicated function
> > >       module: Move lockdown check into generic module loader
> > >       lockdown: Make the relationship to MODULE_SIG a dependency
> > >       module: Introduce hash-based integrity checking
> > >=20
> > >  .gitignore                                   |  1 +
> > >  Documentation/kbuild/reproducible-builds.rst |  5 ++-
> > >  Makefile                                     |  8 ++++-
> > >  include/asm-generic/vmlinux.lds.h            | 11 ++++++
> > >  include/linux/module.h                       |  8 ++---
> > >  include/linux/module_hashes.h                | 17 +++++++++
> > >  kernel/module/Kconfig                        | 21 ++++++++++-
> > >  kernel/module/Makefile                       |  1 +
> > >  kernel/module/hashes.c                       | 52 ++++++++++++++++++=
+++++++++
> > >  kernel/module/internal.h                     |  8 +----
> > >  kernel/module/main.c                         | 54 ++++++++++++++++++=
+++++++---
> > >  kernel/module/signing.c                      | 24 +------------
> > >  scripts/Makefile.modfinal                    | 10 ++++--
> > >  scripts/Makefile.vmlinux                     |  5 +++
> > >  scripts/link-vmlinux.sh                      | 31 +++++++++++++++-
> > >  scripts/module-hashes.sh                     | 26 ++++++++++++++
> > >  security/lockdown/Kconfig                    |  2 +-
> > >  17 files changed, 238 insertions(+), 46 deletions(-)
> > > ---
> > > base-commit: 2cd5917560a84d69dd6128b640d7a68406ff019b
> > > change-id: 20241225-module-hashes-7a50a7cc2a30
> > >=20
> > > Best regards,
> >=20


