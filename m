Return-Path: <linux-arch+bounces-9974-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754FA25C32
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 15:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC89218821AF
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3762080DF;
	Mon,  3 Feb 2025 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OzYdcuyW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9E2080E3
	for <linux-arch@vger.kernel.org>; Mon,  3 Feb 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592581; cv=none; b=okU6eRJ2gbgvEqHeFZQyZCdmdjmytwHGRgKROLGDWb9IyNy1YAJvmXooleFAg/RgL3wFIRPzwG0tzz482oabX054RsAFlPRZtKhgXg9vPc/T6ShCYdORYg4cn2ULNCt2nJZU7LflPrrkBtl+9qX1DY0IPM8HET9UUMzDdUu1fi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592581; c=relaxed/simple;
	bh=FD92vlYikM6XJnzEQAd0wkXxCZm3gh++L6/nbT5htPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z52ZS49lma7ACZ/UAHGM6n7l64HeXD/J9TDUmSvMCRxOMznAHYsEREjTKuhtuZVxbLCdk3nLj6LbuiMk06q/a4mmUDU4OB8h6kyJIijqQTKeOLeQXZ/4cFMIF+Xu9rCtU91oqltCZ2EQfv8Id4qHya+kclCGTZFEaKySn5RTJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OzYdcuyW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so46282875e9.1
        for <linux-arch@vger.kernel.org>; Mon, 03 Feb 2025 06:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738592576; x=1739197376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIXnXsCXCVj5NLCiAx3qUNgUj+DE0/m/cXeEZni/Xr0=;
        b=OzYdcuyW13jTndxFTylBRpqcSbHvLRdJPAb7hf64jK/V2ERU/DQOt3Pz+CHPJX6/st
         XBeNunYirowirHmn2hbwWRmYWwQzPSWj6tpCOtiBZBqXMG0pBWiT4br/f4I01bt/Wqxs
         BnIl/79kswUTxDKLjvUgBTUJbN+yQNWj4tb4oztvzMj4AYvfxRW9lqNzAjNAxR+h3QuN
         8HapnJR2pQk7Ockjwbdq8P8tcdvzkCFOx8sSQlFaFHTHajCgD1U0wN1jUmL5Hu/IixeX
         gwyAgMaT9PPn1UTKm+NU+eSErFWBhuyqJvuyU3QdaedmuDHPJZqAOrZNSDG1J7J3VbGE
         22dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738592576; x=1739197376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIXnXsCXCVj5NLCiAx3qUNgUj+DE0/m/cXeEZni/Xr0=;
        b=QJ0WiuXV5NuJk0GUPU1daJbi1hSubofKgrJs/E/JKOl9/XPeBy7O+mh+89O0iWi8zi
         VCGAoPp6Q3TIy++O5ORshgMfNgPOGfzUhWBNtsWadw8PXaQqTm0WgRQhdWBPtrIUlYAP
         Jlp9Nq6X/c/8kLlfNitVITJ4PqTjhud3xUvxm5NOG7G6NrUQ+FSXZPqPD+Fq3Cb1XLTk
         5QTPWgsQyd7m3FM/CQTpigV0OdsYAVffd6R6ANuxkOlWGqEC+IfaDXc6kU/GESKq+4z5
         NKzdyzVwfcGQ84QnCS5PnrhJgebOiojzL3aEFJ6y1sEq+l5RtOgznB8BlTshWOZ9h414
         T1dg==
X-Forwarded-Encrypted: i=1; AJvYcCWAq/+hgOABAXFehtB8qQMnyW+bvz90avPZhMiRpXXfamDZQCQpCT2V5vXoZAZJlOnDu9RgTEMyiLj4@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpubOEKFsG2C9K+b6SfzG9m38fNbsXEo721IRMWQyYwD6G7yW
	ex8wRL0RGoIvUbVGZ75HdyhYFN2v3AhaACkCx/Dr/eOuaEh/P3tur03Wr1gJh48=
X-Gm-Gg: ASbGncspgbYNjVGJyyLrLxN6BdNlQ+9Z3dRrt8h6EDxw1REGkXeiejDKsfBXDNbQlvq
	Zulkb93wd9cqjNRVdP/sx0IFMzidB2PPYpTpdQ3WIat4pvrvOlNOETObg+UWaB36vJLo7FN2f+3
	ULrEmbFu0dDTICGon7CCFD6sLm7VkdQgcPtcfo6dsKzK1ZD4M+FJTznir9O8/K2O0oiHOzOIUCC
	V9Vf7vDOqT4L94Cu55I/1+k6lh7N6mgClQGbjqC7l6nbrPfnYdFNjg6Ov/nGKD47XUm0Km5LNm6
	O7lcsmylJRFD3v1SYIc=
X-Google-Smtp-Source: AGHT+IFbgFq6uBjbotPyUxc3afI1yVnTZStdVW25ssb30gKJABBUOFceHdRftZrVQ6EhfXua/ZrAbQ==
X-Received: by 2002:a05:600c:3b9f:b0:431:12a8:7f1a with SMTP id 5b1f17b1804b1-438dc3caa6cmr208064955e9.16.1738592576166;
        Mon, 03 Feb 2025 06:22:56 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c139f15sm13057704f8f.59.2025.02.03.06.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 06:22:55 -0800 (PST)
Message-ID: <823ec325-e33d-4db2-8a35-537aead473a1@suse.com>
Date: Mon, 3 Feb 2025 15:22:54 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] module: Introduce hash-based integrity checking
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
 <20250120-module-hashes-v2-6-ba1184e27b7f@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250120-module-hashes-v2-6-ba1184e27b7f@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/20/25 18:44, Thomas Weißschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds:
> Either the module signing key is generated at build time, which makes
> the build unreproducible, or a static key is used, which precludes
> rebuilds by third parties and makes the whole build and packaging
> process much more complicated.
> Introduce a new mechanism to ensure only well-known modules are loaded
> by embedding a list of hashes of all modules built as part of the full
> kernel build into vmlinux.
> 
> Non-builtin modules can be validated as before through signatures.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  .gitignore                                   |  1 +
>  Documentation/kbuild/reproducible-builds.rst |  5 ++-
>  Makefile                                     |  8 ++++-
>  include/asm-generic/vmlinux.lds.h            | 11 ++++++
>  include/linux/module_hashes.h                | 17 +++++++++
>  kernel/module/Kconfig                        | 17 ++++++++-
>  kernel/module/Makefile                       |  1 +
>  kernel/module/hashes.c                       | 52 ++++++++++++++++++++++++++++
>  kernel/module/internal.h                     |  1 +
>  kernel/module/main.c                         |  6 ++++
>  scripts/Makefile.modfinal                    |  6 ++++
>  scripts/Makefile.vmlinux                     |  5 +++
>  scripts/link-vmlinux.sh                      | 25 ++++++++++++-
>  scripts/module-hashes.sh                     | 26 ++++++++++++++
>  security/lockdown/Kconfig                    |  2 +-
>  15 files changed, 178 insertions(+), 5 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 6839cf84acda0d2d3c236a2e42b0cb0fe1b14965..7c40151c3f5d0c15ac04cead5f21c291a98d779f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -28,6 +28,7 @@
>  *.gz
>  *.i
>  *.ko
> +*.ko.hash
>  *.lex.c
>  *.ll
>  *.lst
> diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
> index f2dcc39044e66ddd165646e0b51ccb0209aca7dd..6a742ad745113a9267223b33810dbc7218c47d4c 100644
> --- a/Documentation/kbuild/reproducible-builds.rst
> +++ b/Documentation/kbuild/reproducible-builds.rst
> @@ -79,7 +79,10 @@ generate a different temporary key for each build, resulting in the
>  modules being unreproducible.  However, including a signing key with
>  your source would presumably defeat the purpose of signing modules.
>  
> -One approach to this is to divide up the build process so that the
> +Instead ``CONFIG_MODULE_HASHES`` can be used to embed a static list
> +of valid modules to load.
> +
> +Another approach to this is to divide up the build process so that the
>  unreproducible parts can be treated as sources:
>  
>  1. Generate a persistent signing key.  Add the certificate for the key
> diff --git a/Makefile b/Makefile
> index b9464c88ac7230518a756bff5e6c5c8871cc5058..fc862ffd2df843c0b68bebc8f554b88850ba1541 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1535,8 +1535,10 @@ endif
>  # is an exception.
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  KBUILD_BUILTIN := 1
> +ifndef CONFIG_MODULE_HASHES
>  modules: vmlinux
>  endif
> +endif
>  
>  modules: modules_prepare
>  

I think that the way the feature is integrated into the build is
currently suboptimal. We should look how to make it properly orthogonal
with the BTF stuff and also try to obtain the number of modules early.
Sorry, I can't immediately provide any advice here as I need to
understand the relevant logic more myself.

> @@ -1916,7 +1918,11 @@ modules.order: $(build-dir)
>  # KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
>  # This is solely useful to speed up test compiles.
>  modules: modpost
> -ifneq ($(KBUILD_MODPOST_NOFINAL),1)
> +ifdef CONFIG_MODULE_HASHES
> +ifeq ($(MODULE_HASHES_MODPOST_FINAL), 1)
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
> +endif
> +else ifneq ($(KBUILD_MODPOST_NOFINAL),1)
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
>  endif
>  
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 54504013c74915c2ed923fb3afde024a69cdae6b..aebea528aac3d7209bcee12c25f750ab0f7576a5 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -486,6 +486,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  									\
>  	PRINTK_INDEX							\
>  									\
> +	MODULE_HASHES							\
> +									\
>  	/* Kernel symbol table: Normal symbols */			\
>  	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
>  		__start___ksymtab = .;					\
> @@ -895,6 +897,15 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  #define PRINTK_INDEX
>  #endif
>  
> +#ifdef CONFIG_MODULE_HASHES
> +#define MODULE_HASHES							\
> +	.module_hashes : AT(ADDR(.module_hashes) - LOAD_OFFSET) {	\
> +	BOUNDED_SECTION_BY(.module_hashes, _module_hashes)		\
> +	}
> +#else
> +#define MODULE_HASHES
> +#endif
> +
>  /*
>   * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
>   * Otherwise, the type of .notes section would become PROGBITS instead of NOTES.
> diff --git a/include/linux/module_hashes.h b/include/linux/module_hashes.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..5f2f0546e3875e6bc73bdd53aebaada7371b7f79
> --- /dev/null
> +++ b/include/linux/module_hashes.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef _LINUX_MODULE_HASHES_H
> +#define _LINUX_MODULE_HASHES_H
> +
> +#include <linux/compiler_attributes.h>
> +#include <linux/types.h>
> +#include <crypto/sha2.h>
> +
> +#define __module_hashes_section __section(".module_hashes")
> +#define MODULE_HASHES_HASH_SIZE SHA256_DIGEST_SIZE
> +
> +extern const u8 module_hashes[][MODULE_HASHES_HASH_SIZE];
> +
> +extern const typeof(module_hashes[0]) __start_module_hashes, __stop_module_hashes;
> +
> +#endif /* _LINUX_MODULE_HASHES_H */
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index a80de8d22efdd0f13b3eb579a8ff1e69029d0694..cdd30b9a08d8cdf3ec0595b5e414265b869d343e 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -212,7 +212,7 @@ config MODULE_SIG
>  
>  config MODULE_SIG_POLICY
>  	def_bool y
> -	depends on MODULE_SIG
> +	depends on MODULE_SIG || MODULE_HASHES
>  
>  config MODULE_SIG_FORCE
>  	bool "Require modules to be validly signed"
> @@ -348,6 +348,21 @@ config MODULE_DECOMPRESS
>  
>  	  If unsure, say N.
>  
> +config MODULE_HASHES
> +	bool "Module hash validation"
> +	depends on $(success,cksum --algorithm sha256 --raw /dev/null)

The cksum utility from GNU coreutils gained the --algorithm option in
2021 [1] and the --raw option in 2023 [2], which looks quite recent.
The document process/changes.rst doesn't mention a minimum version for
coreutils. However, I'd consider using sha256sum or
'openssl dgst -sha256 -binary' as that should cover more systems.

[1] https://git.savannah.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=ad6c8e1181a3966e35d68c1c354deb1c73f3e974
[2] https://git.savannah.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=ead07bb3d461389bb52336109be7858458e49c38

> +	select CRYPTO_LIB_SHA256
> +	help
> +	  Validate modules by their hashes.
> +	  Only modules built together with the main kernel image can be
> +	  validated that way.
> +
> +	  This is a reproducible-build compatible alternative to a build-time
> +	  generated module keyring, as enabled by
> +	  CONFIG_MODULE_SIG_KEY=certs/signing_key.pem.
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
> index 0000000000000000000000000000000000000000..1aa49767a39b4e0c495b17d3f2edcb5a6ceb839e
> --- /dev/null
> +++ b/kernel/module/hashes.c
> @@ -0,0 +1,52 @@
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

It is unlikely, but I suppose one could configure the kernel with
CONFIG_MODULE_DEBUG and CONFIG_MODULE_HASHES but without any actual
modules. In this corner case, intlog10() will be called with 0 and
produces a warning.

> +	size_t i;
> +
> +	pr_debug("Known hashes (%zu):\n", num_hashes);
> +
> +	for (i = 0; i < num_hashes; i++)
> +		pr_debug("%*zu %*phN\n", num_width, i,
> +			 (int)sizeof(module_hashes[i]), module_hashes[i]);
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_MODULE_DEBUG)
> +early_initcall(module_hashes_init);
> +#endif
> +
> +int module_hash_check(struct load_info *info, int flags)
> +{
> +	u8 digest[MODULE_HASHES_HASH_SIZE];
> +	size_t i;
> +
> +	sha256((const u8 *)info->hdr, info->len, digest);
> +
> +	for (i = 0; i < module_hashes_count(); i++) {
> +		if (memcmp(module_hashes[i], digest, MODULE_HASHES_HASH_SIZE) == 0) {
> +			pr_debug("allow %*phN\n", (int)sizeof(digest), digest);
> +			info->sig_ok = true;
> +			return 0;
> +		}
> +	}
> +
> +	pr_debug("block %*phN\n", (int)sizeof(digest), digest);
> +	return -ENOKEY;
> +}
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index c30abeefa60b884c4a69b1eb4f1123a4bbee4b47..9c927c212f862fff7000f1cfac3c7e391a2390ac 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -334,6 +334,7 @@ int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
>  				char *secstrings, struct module *mod);
>  
>  int module_sig_check(struct load_info *info, int flags);
> +int module_hash_check(struct load_info *info, int flags);
>  
>  #ifdef CONFIG_DEBUG_KMEMLEAK
>  void kmemleak_load_module(const struct module *mod, const struct load_info *info);
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index effe1db02973d4f60ff6cbc0d3b5241a3576fa3e..094ace81d795711b56d12a2abc75ea35449c8300 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3218,6 +3218,12 @@ static int module_integrity_check(struct load_info *info, int flags)
>  {
>  	int err = 0;
>  
> +	if (IS_ENABLED(CONFIG_MODULE_HASHES)) {
> +		err = module_hash_check(info, flags);
> +		if (!err)
> +			return 0;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_MODULE_SIG))
>  		err = module_sig_check(info, flags);
>  

Nit: I'd write this function as follows to make the logic shorter and to
express that the code looks for the first handler that successfully
verifies the module by setting info->sig_ok.

static int module_integrity_check(struct load_info *info, int flags)
{
	int err = 0;

	if (IS_ENABLED(CONFIG_MODULE_HASHES))
		err = module_hash_check(info, flags);

	if (!info->sig_ok && IS_ENABLED(CONFIG_MODULE_SIG))
		err = module_sig_check(info, flags);

	if (err)
		return err;
	if (info->sig_ok)
		return 0;
	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
}

[...]

-- 
Thanks,
Petr

