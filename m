Return-Path: <linux-arch+bounces-9579-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F2A01189
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 02:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193123A471D
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 01:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F96038FA6;
	Sat,  4 Jan 2025 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oibeiaxk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF552381B9;
	Sat,  4 Jan 2025 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735954675; cv=none; b=m2001/F5R/b2TQn/lOM7cOaO9H+my3Ba2bZrv0o+j7L3xRElAIFLTwjzLidV81IbZPA16LldSHTDq/0jAGs6m97kBKe5CGLo1Ljy29Lzoyjhtc4kKctd+pKmsjwTZELawk3QnQcu7E4WLU5t8o1Vm20GdlYjPLEp4uIw03BIRRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735954675; c=relaxed/simple;
	bh=o8fDQX46pA+dvY8cqfL8dHgiiL6/GQLpQvWf2Mg87GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkK/uAj1pOa0LTyEB2cVCxxYMoSSz2vmd3QoeR15UX4Q1+avhzw1kd4PjI0KEmjbfPbXw9wQ73+7PIX3wLUBMeU+U05AT++OcVjU4FY9edehCjiQmgul0UDEB7CQxQDAwNGJyJavCQ3fsYIdlYlWHszcYe5i34uFe1YN4Mnzh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oibeiaxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0D4C4CED6;
	Sat,  4 Jan 2025 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735954674;
	bh=o8fDQX46pA+dvY8cqfL8dHgiiL6/GQLpQvWf2Mg87GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oibeiaxkeoIhcXxxV0NQ0LkXtQmlsSzXxAdP2VkNeBSUoIBV9z/dVr6X0lAJbypnt
	 mJaz6CG+CcghdHbRkpdPl5REPPW/SOEQX/xmYZZV9MNZb6uuhGNiGQJ3wRUfPirdJ7
	 gfajJH28946xAiCm1HPMdNf1um+X6wcgAEnshO3IY0ZubSW9o3kON4xjBMreiM+Cjj
	 SZGHasUD3YVMVrEz9y/S3n4P1UuyTkieyeUpJez2d3BN0dQ2A/VGYGUSsUMRU0YaXv
	 EDMQo+M6KIAEfKl5CQpRS78dWKvObyUJBMBpDphVBg72ZcV6wcro4NA7OfR2vZuVaS
	 BLAkz8jmTQxwg==
Date: Fri, 3 Jan 2025 17:37:52 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@arndb.de>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] module: Introduce hash-based integrity checking
Message-ID: <Z3iQ8FI4J7rCzICF@bombadil.infradead.org>
References: <20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net>
 <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>

On Wed, Dec 25, 2024 at 11:52:00PM +0100, Thomas Weißschuh wrote:
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 7b329057997ad2ec310133ca84617d9bfcdb7e9f..57d317a6fa444195d0806e6bd7a2af6e338a7f01 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -344,6 +344,17 @@ config MODULE_DECOMPRESS
>  
>  	  If unsure, say N.
>  
> +config MODULE_HASHES
> +	bool "Module hash validation"
> +	depends on !MODULE_SIG

Why are these mutually exclusive? Can't you want module signatures *and*
this as well? What distro which is using module signatures would switch
to this as an alternative instead? The help menu does not clarify any of
this at all, and neither does the patch.

> +	select CRYPTO_LIB_SHA256
> +	help
> +	  Validate modules by their hashes.
> +	  Only modules built together with the main kernel image can be
> +	  validated that way.
> +
> +	  Also see the warning in MODULE_SIG about stripping modules.
> +
>  config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
>  	bool "Allow loading of modules with missing namespace imports"
>  	help
> diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> index 50ffcc413b54504db946af4dce3b41dc4aece1a5..6fe0c14ca5a05b49c1161fcfa8aaa130f89b70e1 100644
> --- a/kernel/module/Makefile
> +++ b/kernel/module/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_KGDB_KDB) += kdb.o
>  obj-$(CONFIG_MODVERSIONS) += version.o
>  obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
>  obj-$(CONFIG_MODULE_STATS) += stats.o
> +obj-$(CONFIG_MODULE_HASHES) += hashes.o
> diff --git a/kernel/module/hashes.c b/kernel/module/hashes.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f19eccb0e3754e3edbf5cdea6d418da5c6ae6c65
> --- /dev/null
> +++ b/kernel/module/hashes.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define pr_fmt(fmt) "module/hash: " fmt
> +
> +#include <linux/int_log.h>
> +#include <linux/module_hashes.h>
> +#include <linux/module.h>
> +#include <crypto/sha2.h>
> +#include "internal.h"
> +
> +static inline size_t module_hashes_count(void)
> +{
> +	return (__stop_module_hashes - __start_module_hashes) / MODULE_HASHES_HASH_SIZE;
> +}
> +
> +static __init __maybe_unused int module_hashes_init(void)
> +{
> +	size_t num_hashes = module_hashes_count();
> +	int num_width = (intlog10(num_hashes) >> 24) + 1;
> +	size_t i;
> +
> +	pr_debug("Builtin hashes (%zu):\n", num_hashes);
> +
> +	for (i = 0; i < num_hashes; i++)
> +		pr_debug("%*zu %*phN\n", num_width, i,
> +			 (int)sizeof(module_hashes[i]), module_hashes[i]);
> +
> +	return 0;
> +}
> +
> +#ifdef DEBUG

We have MODULE_DEBUG so just add depend on that and leverage that for
this instead.


> diff --git a/scripts/module-hashes.sh b/scripts/module-hashes.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..7ca4e84f4c74266b9902d9f377aa2c901a06f995
> --- /dev/null
> +++ b/scripts/module-hashes.sh
> @@ -0,0 +1,26 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +set -e
> +set -u
> +set -o pipefail
> +
> +prealloc="${1:-}"
> +
> +echo "#include <linux/module_hashes.h>"
> +echo
> +echo "const u8 module_hashes[][MODULE_HASHES_HASH_SIZE] __module_hashes_section = {"
> +
> +for mod in $(< modules.order); do
> +	mod="${mod/%.o/.ko}"
> +	if [ "$prealloc" = "prealloc" ]; then
> +		modhash=""
> +	else
> +		modhash="$(cksum -a sha256 --raw "$mod" | hexdump -v -e '"0x" 1/1 "%02x, "')"
> +	fi
> +	echo "	/* $mod */"
> +	echo "	{ $modhash },"
> +	echo
> +done
> +
> +echo "};"

Parallelize this.

  Luis

