Return-Path: <linux-arch+bounces-9836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88207A17E33
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 13:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847BF1884304
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9E1F238D;
	Tue, 21 Jan 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XmUywweF"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209B1F239F;
	Tue, 21 Jan 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464332; cv=none; b=K1qb0p+SXPfPiEqY5UPy0/Jo07J1tjLsAssAq1Ppp2yiwTbfCD9ge3jfAcDXEyAgUhe3j2qiRULpFxoFOHRdWqYLmoEKI9qC4OKXYayXSOz1kQ7Bq/PorHbewDQDwEBmHj4uiqv7pU6Y4Mn/y3xFqwLx+bEFMow9oHf6SMk9InY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464332; c=relaxed/simple;
	bh=ygOJGitSi5o6JNHaPJYhlAOWzAAIdcZfAKVQyARTh1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuGXGtRiEx+NPgITbs1qxHkxs2xvoLDkrGrLYT9xxfQfR1MaWK6zAL76SnRA3OtJShgvGZrrcll0Xa2QtAaAUswf77GAlf1aRRFzx9SDiX1X+bCtCfU1NnJ/+TML+BUk/SdZvnKmfj2JRa+QvaE3comGWCseMW/zhhClXfIKE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XmUywweF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737464327;
	bh=ygOJGitSi5o6JNHaPJYhlAOWzAAIdcZfAKVQyARTh1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmUywweFHYs1UGnzVOY1cKVNWkr9vq1fGZzYkRNpZRED9/NMaFkfr+xySz9jxOECo
	 /OfBipTbP/eC/0d9N/HF4h4Dj/42vVcjidr9Kb090A9ULai8N/Y9ixOXztL7NyVRAg
	 r0a/5WMfYnbHHv8r67yl03No+LZnFZtkS7cnUf1g=
Date: Tue, 21 Jan 2025 13:58:47 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
	kpcyrd <kpcyrd@archlinux.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com
Subject: Re: [PATCH v2 0/6] module: Introduce hash-based integrity checking
Message-ID: <ea767c0b-77fd-4e8a-ab14-4d231e9b779f@t-8ch.de>
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
 <69b38f6a6fb53e7b8f8250e1d37641c6abbb6d07.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69b38f6a6fb53e7b8f8250e1d37641c6abbb6d07.camel@huaweicloud.com>

Hi Roberto,

On 2025-01-21 11:26:29+0100, Roberto Sassu wrote:
> On Mon, 2025-01-20 at 18:44 +0100, Thomas Weißschuh wrote:
> > The current signature-based module integrity checking has some drawbacks
> > in combination with reproducible builds:
> > Either the module signing key is generated at build time, which makes
> > the build unreproducible, or a static key is used, which precludes
> > rebuilds by third parties and makes the whole build and packaging
> > process much more complicated.
> > Introduce a new mechanism to ensure only well-known modules are loaded
> > by embedding a list of hashes of all modules built as part of the full
> > kernel build into vmlinux.
> > 
> > Interest has been proclaimed by NixOS, Arch Linux, Proxmox, SUSE and the
> > general reproducible builds community.
> > 
> > To properly test the reproducibility in combination with CONFIG_INFO_BTF
> > another patch is needed:
> > "[PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation" [0]
> > (If you happen to test that one, please give some feedback)
> > 
> > Questions for current patch:
> > * Naming
> > * Can the number of built-in modules be retrieved while building
> >   kernel/module/hashes.o? This would remove the need for the
> >   preallocation step in link-vmlinux.sh.
> > 
> > Further improvements:
> > * Use a LSM/IMA/Keyring to store and validate hashes
> 
> + linux-integrity, Mimi
> 
> Hi Thomas
> 
> I developed something related to it, it is called Integrity Digest
> Cache [1].

Thanks for the pointer.

> It has the ability to store in the kernel memory a cache of digests
> extracted from a file (or if desired in the future, from a reserved
> area in the kernel image).
> 
> It exposes an API to query a digest (get/lookup/put) from a digest
> cache and to verify whether or not the integrity of the file digests
> were extracted from was verified by IMA or another LSM
> (verif_set/verif_get). 

I see how this could be used together with the module hashes.
For now I think both features should be developed independently.
Integrating them will require some extra code and coordination.

While the current linear, unsorted list of hashes used by my code may be
slightly inefficient, it shouldn't matter in practize as the hash
validation is only a bunch of memcmp()s over a contiguous chunk of
memory, which is very cheap.

When both features are well established we can look at integrating them.
At least a build-time userspace generator of a digest cache would be
necessary.
And due to the current implementation details it would be necessary to
estimate the size of a static digest cache more or less exactly by its
number of elements alone.


Thomas

> [1]: https://lore.kernel.org/linux-integrity/20241119104922.2772571-1-roberto.sassu@huaweicloud.com/
> 
> > * Use MODULE_SIG_HASH for configuration
> > * UAPI for discovery?
> > 
> > [0] https://lore.kernel.org/lkml/20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net/
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Changes in v2:
> > - Drop RFC state
> > - Mention interested parties in cover letter
> > - Expand Kconfig description
> > - Add compatibility with CONFIG_MODULE_SIG
> > - Parallelize module-hashes.sh
> > - Update Documentation/kbuild/reproducible-builds.rst
> > - Link to v1: https://lore.kernel.org/r/20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net
> > 
> > ---
> > Thomas Weißschuh (6):
> >       kbuild: add stamp file for vmlinux BTF data
> >       module: Make module loading policy usable without MODULE_SIG
> >       module: Move integrity checks into dedicated function
> >       module: Move lockdown check into generic module loader
> >       lockdown: Make the relationship to MODULE_SIG a dependency
> >       module: Introduce hash-based integrity checking
> > 
> >  .gitignore                                   |  1 +
> >  Documentation/kbuild/reproducible-builds.rst |  5 ++-
> >  Makefile                                     |  8 ++++-
> >  include/asm-generic/vmlinux.lds.h            | 11 ++++++
> >  include/linux/module.h                       |  8 ++---
> >  include/linux/module_hashes.h                | 17 +++++++++
> >  kernel/module/Kconfig                        | 21 ++++++++++-
> >  kernel/module/Makefile                       |  1 +
> >  kernel/module/hashes.c                       | 52 +++++++++++++++++++++++++++
> >  kernel/module/internal.h                     |  8 +----
> >  kernel/module/main.c                         | 54 +++++++++++++++++++++++++---
> >  kernel/module/signing.c                      | 24 +------------
> >  scripts/Makefile.modfinal                    | 10 ++++--
> >  scripts/Makefile.vmlinux                     |  5 +++
> >  scripts/link-vmlinux.sh                      | 31 +++++++++++++++-
> >  scripts/module-hashes.sh                     | 26 ++++++++++++++
> >  security/lockdown/Kconfig                    |  2 +-
> >  17 files changed, 238 insertions(+), 46 deletions(-)
> > ---
> > base-commit: 2cd5917560a84d69dd6128b640d7a68406ff019b
> > change-id: 20241225-module-hashes-7a50a7cc2a30
> > 
> > Best regards,
> 

