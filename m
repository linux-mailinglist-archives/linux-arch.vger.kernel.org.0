Return-Path: <linux-arch+bounces-8631-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A29B20FC
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 23:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E126628163F
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2DA1891A8;
	Sun, 27 Oct 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyjPVR9h"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E19188A15;
	Sun, 27 Oct 2024 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730067427; cv=none; b=LdSDgvfP9DDFF8N22A3PHlJGGtyncHeSJYfXD8L2VHQI3N4a/s15BwLtMu8FMBbYOxYfudl0MWlnb6NVTmg48osQxQDlAbAWxO3JJi7OvtNFf8Fg4H85Atdnqglw8b1bB5+mOS9nRoexaoDd261uDb6BADrMwM9iD7tjVmAyj8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730067427; c=relaxed/simple;
	bh=An0q1B1Vy5t3+lo7yESq7Pk4FRbEi09xmS9o/s3wurI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPt0UPGVZhzCsNUTSM/JIgHV268whJbJGQzrtEAnWpdV4YxAVVGsdiEQZL88s8LeICbGCejv26oq+YuzUcQmqwbMF0h9FbFt/TELd3+RJ6L7AtJ1yVpmGR5dO46rC1fYj1oJp4Kj6uwdUb5pzzS9757fFSOX5X0Hwjuk6/iRzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyjPVR9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE3CC4CEC3;
	Sun, 27 Oct 2024 22:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730067426;
	bh=An0q1B1Vy5t3+lo7yESq7Pk4FRbEi09xmS9o/s3wurI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyjPVR9hc8nObYdbxO+giY8LhlLmm6nS5/JBgfEyBXJeMrmd3+KWtt7qfaBKjwJDK
	 8xQiNB+6BkkGNszcAE8j2FGtOjh9U2zUtZGpmsrKG7gzl4WqNGihjYMBTUHctf7oAA
	 NL9fg2+fHaGRsFTOHvtChlFzqLSDjJ22GfcLq1hzoeif9lEjpMpdaBx5qdl0fK/6e9
	 3JZJMU8xH2cTIo0siIc1qGm6CuT673DC9ooimzgNk2O3nyjaDCypmC4i8zfWJ9/CXU
	 yk636+8ykOsPj4NFOL12SkfxOu8r1yPUEKFnGTqiPbbz3V+KZjq5TbwbLX8NkOr8kj
	 ObFeWm4T+TNRg==
Date: Sun, 27 Oct 2024 15:17:02 -0700
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
Subject: Re: [PATCH v6 0/7] Add AutoFDO and Propeller support for Clang build
Message-ID: <20241027221702.GD2755311@thelio-3990X>
References: <20241026051410.2819338-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026051410.2819338-1-xur@google.com>

Hi Rong,

I tested this series by following the documentation added in the series
using Clang 19 and my standard distribution configuration on an Intel
platform with the combinations of

  * AutoFDO
  * AutoFDO + ThinLTO
  * AutoFDO + Propeller
  * AutoFDO + ThinLTO + Propeller

and I noticed no issues (it would be great to see create_llvm_prof
somewhere in LLVM upstream for ease of access but that's a small
complaint).

I did not do any real benchmarking to see if those combinations were
actually quicker but I think it is pretty clear from the cover letter
that any sort of gains are going to depend on the profiling and test
case so for time's sake, I did not bother.

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan

