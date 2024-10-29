Return-Path: <linux-arch+bounces-8675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065289B3ECF
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF381F223E8
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166CB10E9;
	Tue, 29 Oct 2024 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNzJBRB/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4C63D;
	Tue, 29 Oct 2024 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160328; cv=none; b=WDl4ZtdjXTbHwDaR/E/zOu6BqyH+O6Q7rn/7ebfMb+Sw6QDBC3KaqTdzz6h2ZZNMrxt4Y0iHbBexygXGbTDX+vpneOY4mbVb3pKq9jdYAYCTr6WnfvldeOrXWm1A4z7m9p/VcaFMY3vLNWAD2Bs3ZrzREVEUdPHif/fLRZXfVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160328; c=relaxed/simple;
	bh=FxJLl4mrx/QrLDiJMwCFHrjtuieQ9Q9i2RWkURi65iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDFDX3Ph2NWohPNoZwgPhXoxSlEmPPKvySexgkzcu1g5ROkcHU/ZTPTPBgRz3U60UXZwouTC2GGPLDDSaJ84OnuQhXcsPAVTxgJGkxmfi9v9EXcOIjQ6gxBAJUaj8UxM9fBIuGiKEjhclx6k+J2xSJm6b7roltUBzs+t+4GylIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNzJBRB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E28C4CEC3;
	Tue, 29 Oct 2024 00:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160328;
	bh=FxJLl4mrx/QrLDiJMwCFHrjtuieQ9Q9i2RWkURi65iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNzJBRB/qkeDMzEqa0btA36O0TNo75Q84HsjMejGyTC+5s5kN7ErzH8zdQLQvwu35
	 q7jAqAV5euWWZA9ZRH+d1EJUHUwVLJi3iJ62TdeFTpVAMvoxhIDsRNvqinJs1gQBh5
	 Aqf5oYxzltR35L7kvde5bsgrtGm2TX3XF7+gFB8LLd/wV1dTfSsBRGWCKTQ2wZP/pf
	 i2urBsoZkjJBGsxYnWPdADBWBfrzKMetNAdqZAyQTBxLwkTUSdCKIrdJ4UdIFWRHf3
	 rHAEHtw7FfMyKmBJxYxb1Y6uB5933G4ImCphQdzT6+0hJ1EX7BrYQ38BlTb9vCGaZ3
	 yzc7fdIVCHtqw==
Date: Mon, 28 Oct 2024 17:05:25 -0700
From: Kees Cook <kees@kernel.org>
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
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
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
Subject: Re: [PATCH v6 4/7] Add markers for text_unlikely and text_hot
 sections
Message-ID: <202410281705.F093FC01@keescook>
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-5-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026051410.2819338-5-xur@google.com>

On Fri, Oct 25, 2024 at 10:14:06PM -0700, Rong Xu wrote:
> Add markers like __hot_text_start, __hot_text_end, __unlikely_text_start,
> and __unlikely_text_end which will be included in System.map. These markers
> indicate how the compiler groups functions, providing valuable information
> to developers about the layout and optimization of the code.
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

