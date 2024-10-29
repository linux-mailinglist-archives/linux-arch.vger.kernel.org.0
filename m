Return-Path: <linux-arch+bounces-8678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523D9B3EEE
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9F4283ABC
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69E23BB;
	Tue, 29 Oct 2024 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JurZnXor"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0341372;
	Tue, 29 Oct 2024 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160794; cv=none; b=ckgmDPAur//8TndBW7ojas4uBhfni91MOGay4GkG8wXaXehUcjJXQCppZulSwhSBL1I/pY5cN4ulUp6gHyJB3hlfzov8hXBOtI7MdMvFgEXGRIi6OHPF3fIfp+OpgzJNuI93/0U98KRC752V7cOi4I+jHjAFmA0gHQTTyEbV/J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160794; c=relaxed/simple;
	bh=cmDY0hVnN8OMS1CiL9X/xbVl3kpikmf3L9NSWf8EWHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy9FUY6EgxaVJpIqOSl3ujM1/idvnU70DLd+xU2l/jqXGAv97Al0Uz7HXV8GmqkKJyMXJ/n54ght+gOcV03ZGqxs5hq0X1ZYSwqLkAI4EAyYKXw4EvckM2Q9wkCmuCmDoogp4zSPOGVsndUZAyZLE0KdoNI7pCoLxDp1RyNDveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JurZnXor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F12C4CEC3;
	Tue, 29 Oct 2024 00:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160793;
	bh=cmDY0hVnN8OMS1CiL9X/xbVl3kpikmf3L9NSWf8EWHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JurZnXor1Qkel1iP8tzrJ7nyz3apQcnmPW+2bgSqcA+qkpyhh7Qjx/hEx/dVC0WJG
	 d+YCDjAUWPj+QCM7iZttaYsMt5FQE7yIIOZvoGNIs2Kz+OlcxDZzRt6lXfT8fSB+Hs
	 PMeu/ylajOPw2m305+3CJcWMY5ZpWXE++r8vO7VzMN12hp7ScQkyE8nNLrA7wMy2XJ
	 t0dVvBDhh7eCCUPJIVwzkIm/RwLdXFckzOgGb2swQ9Gla3WY4NbL/DPQpNsvkG1RLj
	 20Ug0SS9+T5GsmpHLEJ4y+vb65y1cnoECSOmEeb7qmCS81Bt43hO98ExguH7qSvYIC
	 nB9M1FjTe/LCA==
Date: Mon, 28 Oct 2024 17:13:10 -0700
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
Subject: Re: [PATCH v6 6/7] AutoFDO: Enable machine function split
 optimization for AutoFDO
Message-ID: <202410281713.28C1EDCA0@keescook>
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-7-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026051410.2819338-7-xur@google.com>

On Fri, Oct 25, 2024 at 10:14:08PM -0700, Rong Xu wrote:
> Enable the machine function split optimization for AutoFDO in Clang.
> 
> Machine function split (MFS) is a pass in the Clang compiler that
> splits a function into hot and cold parts. The linker groups all
> cold blocks across functions together. This decreases hot code
> fragmentation and improves iCache and iTLB utilization.
> 
> MFS requires a profile so this is enabled only for the AutoFDO builds.
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

