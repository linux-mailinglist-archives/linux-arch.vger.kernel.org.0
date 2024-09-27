Return-Path: <linux-arch+bounces-7475-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6289888FD
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364581F21907
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1D186609;
	Fri, 27 Sep 2024 16:22:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC995142621;
	Fri, 27 Sep 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454144; cv=none; b=VzxlLmgElqTwORlXStcA69cPuMGtwaPmcdfCP2M0l7xWnXenFBsq5lBXZetdtGG8NdfrR3gDPWB4CsJNlekuBknKsJUcpyC2u0+Edn/TPKduJ5IqZhUk2S8sunIIVm5h5mb5mOGzhiHBBNetfzq6NZ2/p0Fveemn0szMvKeJUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454144; c=relaxed/simple;
	bh=MwxSYUQfpQZ8Dt7MR3StqGkeSe7twZkuP4tcbwLCnKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeS2eFB1r9OQ9O31gn7wzBt5Xi2JttLHUzr5ubeIDu/BPHYye3+igHHZcNvdfc9hxwbzc4gLRZL3z3PoOwjuoqlzd/qvJ65L9lJhDFtqlfoxO0kLG2797z+uFTxKOApkJE0/yEMiMgBwYPsEQDyNDaW33sjsxxOmklGKfv6PosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EDBA14BF;
	Fri, 27 Sep 2024 09:22:44 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B650E3F6A8;
	Fri, 27 Sep 2024 09:22:08 -0700 (PDT)
Date: Fri, 27 Sep 2024 17:22:03 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Keith Packard <keithp@keithp.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 02/28] Documentation: Bump minimum GCC version to 8.1
Message-ID: <ZvbbqzrfkgjM1VZ3@J2N7QTR9R3>
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-32-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925150059.3955569-32-ardb+git@google.com>

On Wed, Sep 25, 2024 at 05:01:02PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Bump the minimum GCC version to 8.1 to gain unconditional support for
> referring to the per-task stack cookie using a symbol rather than
> relying on the fixed offset of 40 bytes from %GS, which requires
> elaborate hacks to support.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  Documentation/admin-guide/README.rst | 2 +-
>  Documentation/process/changes.rst    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'd like this for arm64 and others too (for unconditional support for
-fpatchable-function-entry), so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I think you'll want to update scripts/min-tool-version.sh too; judging
by the diff in the cover letter that's not handled elsehere in the
series.

Mark.

> 
> diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
> index f2bebff6a733..3dda41923ed6 100644
> --- a/Documentation/admin-guide/README.rst
> +++ b/Documentation/admin-guide/README.rst
> @@ -259,7 +259,7 @@ Configuring the kernel
>  Compiling the kernel
>  --------------------
>  
> - - Make sure you have at least gcc 5.1 available.
> + - Make sure you have at least gcc 8.1 available.
>     For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
>  
>   - Do a ``make`` to create a compressed kernel image. It is also possible to do
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 00f1ed7c59c3..59b7d3d8a577 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -29,7 +29,7 @@ you probably needn't concern yourself with pcmciautils.
>  ====================== ===============  ========================================
>          Program        Minimal version       Command to check the version
>  ====================== ===============  ========================================
> -GNU C                  5.1              gcc --version
> +GNU C                  8.1              gcc --version
>  Clang/LLVM (optional)  13.0.1           clang --version
>  Rust (optional)        1.78.0           rustc --version
>  bindgen (optional)     0.65.1           bindgen --version
> -- 
> 2.46.0.792.g87dc391469-goog
> 
> 

