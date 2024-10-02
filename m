Return-Path: <linux-arch+bounces-7616-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47AE98CA8D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 03:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A490B2834B4
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBA5138E;
	Wed,  2 Oct 2024 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtnS6zyo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F75227;
	Wed,  2 Oct 2024 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831864; cv=none; b=KhHYfiphRd+4PV9NN5H2TTEBk/uR8XaAqa5GqYUwJtg4S3bEllE4rIHo3B0mHiz/xT827kXnS96lrIWzRFpb1zfLCq1Bda3ycsJBnXW6/TqwgLd8g5371iwTDK7jKo4+LYOYQvgG6DnbxbXsIARK4jAoR/2fgJQDzrKHjri+Mcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831864; c=relaxed/simple;
	bh=18sIvN/b40KUR8Z6IAlfjZJPkiV7wOxyLv5Q7q6Bu04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFNRtJR9BmhB0e4EBW7p1zVR544LhfFq1gceeVI5z0CILWXEYfjt5C7jeB1eRknmWGF/kzuod3dXNOJTupfhFvkB22kw5PuEJx29nPLiS/5nSXtRH1+NTKKJFNg3mhnFLiKj17XgdYWCV5mIleQ5G9zqiz2M2YuF5fMfysce/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtnS6zyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDCCC4CEC6;
	Wed,  2 Oct 2024 01:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727831864;
	bh=18sIvN/b40KUR8Z6IAlfjZJPkiV7wOxyLv5Q7q6Bu04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtnS6zyoFjLo0cC9ECwBxydPekHreMYtE0eg9Lo+D5KH5g6Q4DoCzzOgYnaQjv/jC
	 ObI1KHaJ7eIek7vhT5MV8wW3Wlpfxc3xHaF4cVXIisrUDJYAwbwt+19TBicGMY62z3
	 gavMEUSI+xZuLPKPzl7m4Lc91dkWZtT5cerz3DsyO9GCvh1CNtYwtgFdzdhH4c1AHy
	 mN+uEip3HTKgRlPHybFSXiLY6oaek6tSQQ7905hBVoxESfzLtm8EEBMUE+SE2Xt05n
	 tKBiU9uiw8DP9z/YFjwewvhl7KvZfeQ0U+WZVKN4OsLL0xHXdjFORm1Mq9/g4lQtPl
	 RplIJZ5yhUwpw==
Date: Tue, 1 Oct 2024 18:17:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Wentao Zhang <wentaoz5@illinois.edu>
Cc: Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu,
	johannes@sipsolutions.net, jpoimboe@kernel.org,
	justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	peterz@infradead.org, richard@nod.at, rostedt@goodmis.org,
	samitolvanen@google.com, samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com, tglx@linutronix.de,
	tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
Subject: Re: [PATCH v2 3/4] x86: disable llvm-cov instrumentation
Message-ID: <20241002011739.GC555609@thelio-3990X>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-4-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905043245.1389509-4-wentaoz5@illinois.edu>

On Wed, Sep 04, 2024 at 11:32:44PM -0500, Wentao Zhang wrote:
> Disable instrumentation for arch/x86/crypto/curve25519-x86_64.c. Otherwise
> compilation would fail with "error: inline assembly requires more registers
> than available".
> 
> Similar behavior was reported with gcov as well. See c390c452ebeb ("crypto:
> x86/curve25519 - disable gcov").
> 
> Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
> Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
> Tested-by: Chuck Wolber <chuck.wolber@boeing.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/crypto/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index 53b4a2778..57f3d4921 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -119,5 +119,6 @@ quiet_cmd_perlasm = PERLASM $@
>  $(obj)/%.S: $(src)/%.pl FORCE
>  	$(call if_changed,perlasm)
>  
> -# Disable GCOV in odd or sensitive code
> +# Disable GCOV and llvm-cov in odd or sensitive code
>  GCOV_PROFILE_curve25519-x86_64.o := n
> +LLVM_COV_PROFILE_curve25519-x86_64.o := n
> -- 
> 2.45.2
> 

