Return-Path: <linux-arch+bounces-8908-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED89C0FEE
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 21:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E467C1F23AF4
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B3218315;
	Thu,  7 Nov 2024 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmQfYSyN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51317217F5C;
	Thu,  7 Nov 2024 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012309; cv=none; b=gR9ntX7pLRp7eOKsyN4vlvVWWIIdoOF1QQIUWi6pjGI+htgOXR+HfpM9aDEdq4kaD3tCJpo2gw5z2y/pJb7K0hbZGbKEa2Riad4HNTn078aZyFZy+sFyAXj1ZzEXi3B2EOyVeV+NPrdByW+L5fmKxdNCLaie+o5Fg4rJ0WEk5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012309; c=relaxed/simple;
	bh=TOAtp4toshHubG+QWf7mLLFWC4nu6LMEdHwXu5eYJ7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNZfRlvG6uI3a9ph4HUMafgejEF/ErsMhA+scxuv75yifgiH1Ccrl4/F+Off8ez1nC4rsgIUFJ+cHVfM765W48AW2vIIJ6JfUz1jTkcPZPatDPHDvaUeHK5mBNRbKrOhycNZeuZ/jMNTqZOgF2XvPlBohqTou2zXbYyEviQ97zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmQfYSyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61555C4CECC;
	Thu,  7 Nov 2024 20:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731012308;
	bh=TOAtp4toshHubG+QWf7mLLFWC4nu6LMEdHwXu5eYJ7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmQfYSyN557ZaAA1bJb7ExxyPTgjDfFF5PZfAM2GMCgFO1N4mF+tOBYp/kOjjVDxz
	 RI2Zj4OpJRUVWYH1p8b4kSSWkeD0m/QkyhUV70moN4DKQgatFPQQrK50oNHuRr9EDa
	 P+y2dE7kps+GGe75B/WvphIQZZV5uGwL8R49YIWf/5AuYXkDu7I1YBiU6k10ak13Td
	 RPjXGHq2KH/vFUvxx3nMypKkvLGtXimNb8xoARX8Hxlgimohj2PDzNXCBCqescvea7
	 h4Qm0FfqlcWtMcbfQGSv3YNPKJamU8OWi386Gx/K/ZMz4hnbRcOXVKmeW0LvfBdHKt
	 4LOAqFqHvlcGg==
Date: Thu, 7 Nov 2024 13:45:04 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Li <davidxl@google.com>, Han Shen <shenhan@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Maksim Panchenko <max4bolt@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Yabin Cui <yabinc@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	Stephane Eranian <eranian@google.com>, x86@kernel.org,
	linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 7/7] Add Propeller configuration for kernel build
Message-ID: <20241107204504.GA3432398@thelio-3990X>
References: <20241102175115.1769468-1-xur@google.com>
 <20241102175115.1769468-8-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102175115.1769468-8-xur@google.com>

Hi Rong,

On Sat, Nov 02, 2024 at 10:51:14AM -0700, Rong Xu wrote:
> diff --git a/scripts/Makefile.propeller b/scripts/Makefile.propeller
> new file mode 100644
> index 0000000000000..344190717e471
> --- /dev/null
> +++ b/scripts/Makefile.propeller
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Enable available and selected Clang Propeller features.
> +ifdef CLANG_PROPELLER_PROFILE_PREFIX
> +  CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=list=$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.txt -ffunction-sections
> +  KBUILD_LDFLAGS += --symbol-ordering-file=$(CLANG_PROPELLER_PROFILE_PREFIX)_ld_profile.txt --no-warn-symbol-ordering
> +else
> +  CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=labels
> +endif

It appears that '-fbasic-block-sections=labels' has been deprecated in
the main branch of LLVM, as I see a warning repeated over and over when
building allmodconfig:

  clang: warning: argument '-fbasic-block-sections=labels' is deprecated, use '-fbasic-block-address-map' instead [-Wdeprecated]

https://github.com/llvm/llvm-project/commit/7b7747dc1d3da1a829503ea9505b4cecce4f5bda

Sorry that I missed this during testing, as I was only using clang-19 at
the time.

I think you can send a fixup on top of Masahiro's branch:

https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/log/?h=kbuild

> +# Propeller requires debug information to embed module names in the profiles.
> +# If CONFIG_DEBUG_INFO is not enabled, set -gmlt option. Skip this for AutoFDO,
> +# as the option should already be set.
> +ifndef CONFIG_DEBUG_INFO
> +  ifndef CONFIG_AUTOFDO_CLANG
> +    CFLAGS_PROPELLER_CLANG += -gmlt
> +  endif
> +endif
> +
> +ifdef CONFIG_LTO_CLANG_THIN
> +  ifdef CLANG_PROPELLER_PROFILE_PREFIX
> +    KBUILD_LDFLAGS += --lto-basic-block-sections=$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.txt
> +  else
> +    KBUILD_LDFLAGS += --lto-basic-block-sections=labels

I think this might have a similar problem but I have not tested.

> +  endif
> +endif
> +
> +export CFLAGS_PROPELLER_CLANG

Cheers,
Nathan

