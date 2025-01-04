Return-Path: <linux-arch+bounces-9580-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F00A012C6
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 07:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512693A4399
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 06:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B61531D5;
	Sat,  4 Jan 2025 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QJmLbxxK"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8914F123;
	Sat,  4 Jan 2025 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735972248; cv=none; b=nohYPRiryor5GO8sxofSCwxdZNVMbD0t3ipWT3OdnHtYNWNaNg4Mef/ZjS5372yuNB4vVt29IidTRa1D2YVQVsSUGQyVfBi9MdkK9KhctybQnbSbYK1Jo3hbsu8fsBu1zbdVstfoyAWlJszhNHP/wEmpTz3pe355C6Jh2+2u8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735972248; c=relaxed/simple;
	bh=+VQlci/lpWUmZtr7JVADCGsdOB2jTAKsJBZPjdGGBYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwTt9ERmrqFg/hGAw62KEOdxS7WarJz+/+Plc1EKUvfEjiybmmOGX6BT4/v5MNoGOow3paAqn7tGuh10yFzxD/vaRlS40anLRBdCfYKKP1ic/LLoJhchH4M81AV2+q7ZOZzwiTHszp9DjvfV4V9PeRuSBRFP4TEHlB8O8YnVOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QJmLbxxK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735972239;
	bh=+VQlci/lpWUmZtr7JVADCGsdOB2jTAKsJBZPjdGGBYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJmLbxxKkr86pkCAnynomJW9gzFgc8oHiUWfTE31PQu8+BN5xbKz3N47y05pW12Zc
	 NDBf1GvgvkQJvtk9u9FKRNPn8HJvlBgxHHRfB7yyRFqgY9UQofMABPv6A+oHyLT3wJ
	 QSAFPQlWqh2U/LefgvkI1f8DiDKaibGnHBehVIHs=
Date: Sat, 4 Jan 2025 07:30:39 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Arnd Bergmann <arnd@arndb.de>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] module: Introduce hash-based integrity checking
Message-ID: <5c2ef82a-7558-4397-827d-523f8fe4895b@t-8ch.de>
References: <20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net>
 <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
 <Z3iQ8FI4J7rCzICF@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3iQ8FI4J7rCzICF@bombadil.infradead.org>

Hi Luis,

On 2025-01-03 17:37:52-0800, Luis Chamberlain wrote:
> On Wed, Dec 25, 2024 at 11:52:00PM +0100, Thomas Weißschuh wrote:
> > diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> > index 7b329057997ad2ec310133ca84617d9bfcdb7e9f..57d317a6fa444195d0806e6bd7a2af6e338a7f01 100644
> > --- a/kernel/module/Kconfig
> > +++ b/kernel/module/Kconfig
> > @@ -344,6 +344,17 @@ config MODULE_DECOMPRESS
> >  
> >  	  If unsure, say N.
> >  
> > +config MODULE_HASHES
> > +	bool "Module hash validation"
> > +	depends on !MODULE_SIG
> 
> Why are these mutually exclusive? Can't you want module signatures *and*
> this as well? What distro which is using module signatures would switch
> to this as an alternative instead? The help menu does not clarify any of
> this at all, and neither does the patch.

The exclusivity is to keep the initial RFC patch small.
The cover letter lists "Enable coexistence with MODULE_SIG" as
a further improvement.

In general this MODULE_HASHES would be used by distros which are
currently using the build-time generated signing key with
CONFIG_MODULE_SIG_KEY=certs/signing_key.pem.

More concretely the Arch Linux team has expressed interest.

> > +	select CRYPTO_LIB_SHA256
> > +	help
> > +	  Validate modules by their hashes.
> > +	  Only modules built together with the main kernel image can be
> > +	  validated that way.
> > +
> > +	  Also see the warning in MODULE_SIG about stripping modules.
> > +
> >  config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
> >  	bool "Allow loading of modules with missing namespace imports"
> >  	help
> > diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> > index 50ffcc413b54504db946af4dce3b41dc4aece1a5..6fe0c14ca5a05b49c1161fcfa8aaa130f89b70e1 100644
> > --- a/kernel/module/Makefile
> > +++ b/kernel/module/Makefile
> > @@ -23,3 +23,4 @@ obj-$(CONFIG_KGDB_KDB) += kdb.o
> >  obj-$(CONFIG_MODVERSIONS) += version.o
> >  obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
> >  obj-$(CONFIG_MODULE_STATS) += stats.o
> > +obj-$(CONFIG_MODULE_HASHES) += hashes.o
> > diff --git a/kernel/module/hashes.c b/kernel/module/hashes.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..f19eccb0e3754e3edbf5cdea6d418da5c6ae6c65
> > --- /dev/null
> > +++ b/kernel/module/hashes.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#define pr_fmt(fmt) "module/hash: " fmt
> > +
> > +#include <linux/int_log.h>
> > +#include <linux/module_hashes.h>
> > +#include <linux/module.h>
> > +#include <crypto/sha2.h>
> > +#include "internal.h"
> > +
> > +static inline size_t module_hashes_count(void)
> > +{
> > +	return (__stop_module_hashes - __start_module_hashes) / MODULE_HASHES_HASH_SIZE;
> > +}
> > +
> > +static __init __maybe_unused int module_hashes_init(void)
> > +{
> > +	size_t num_hashes = module_hashes_count();
> > +	int num_width = (intlog10(num_hashes) >> 24) + 1;
> > +	size_t i;
> > +
> > +	pr_debug("Builtin hashes (%zu):\n", num_hashes);
> > +
> > +	for (i = 0; i < num_hashes; i++)
> > +		pr_debug("%*zu %*phN\n", num_width, i,
> > +			 (int)sizeof(module_hashes[i]), module_hashes[i]);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef DEBUG
> 
> We have MODULE_DEBUG so just add depend on that and leverage that for
> this instead.

Ack.

> > diff --git a/scripts/module-hashes.sh b/scripts/module-hashes.sh
> > new file mode 100755
> > index 0000000000000000000000000000000000000000..7ca4e84f4c74266b9902d9f377aa2c901a06f995
> > --- /dev/null
> > +++ b/scripts/module-hashes.sh
> > @@ -0,0 +1,26 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +set -e
> > +set -u
> > +set -o pipefail
> > +
> > +prealloc="${1:-}"
> > +
> > +echo "#include <linux/module_hashes.h>"
> > +echo
> > +echo "const u8 module_hashes[][MODULE_HASHES_HASH_SIZE] __module_hashes_section = {"
> > +
> > +for mod in $(< modules.order); do
> > +	mod="${mod/%.o/.ko}"
> > +	if [ "$prealloc" = "prealloc" ]; then
> > +		modhash=""
> > +	else
> > +		modhash="$(cksum -a sha256 --raw "$mod" | hexdump -v -e '"0x" 1/1 "%02x, "')"
> > +	fi
> > +	echo "	/* $mod */"
> > +	echo "	{ $modhash },"
> > +	echo
> > +done
> > +
> > +echo "};"
> 
> Parallelize this.

Ack.

