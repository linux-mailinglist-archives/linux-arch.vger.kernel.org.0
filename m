Return-Path: <linux-arch+bounces-8682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B2E9B3F4D
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368C4B21639
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B68F5E;
	Tue, 29 Oct 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGqy5BRJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55DFBF6;
	Tue, 29 Oct 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730162636; cv=none; b=HAUJmU6GLOGel6d8ZMWKPtTI6BWW7MV29lDT9Bg5/46dKuRAp/JF8ndDKDm3tbZ9+2TGgOwB9ZRfUOdl/YSb4WbaPz6FfPMKdlWieYhi8jG+cNRhZngki3IzfVOozMpYIZY/emcv7CEg72SFYBKxOzUb5GIPKm1w4ZX5I25mbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730162636; c=relaxed/simple;
	bh=CwB4pFzf7Hn9bGjeqEnak7QJ8xCYhIACX/3LdBBQjn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mx9KK4PCyh1hwvRhyZAPLWllSWDtBk+bYKYA6KM4/5WyaNRpkPX8KC0VW17Gbr5aAd4PiV97NwlYXL2mWATF06DvWuObD0KKvfVjRGSLPyONDlMJSU0nIovKUIN0zY3kKyLAfeRMfOCf2bO8MknT8xd1xl7oxWFPtiTQZNlPtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGqy5BRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B8EC4CEC3;
	Tue, 29 Oct 2024 00:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730162636;
	bh=CwB4pFzf7Hn9bGjeqEnak7QJ8xCYhIACX/3LdBBQjn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGqy5BRJQA3ZpT1bN8NZqNAfxTjOM2yt5csxBfxHpMdp8wI3qGmY5C5jIFRfRocSg
	 yTGKGsZv5KrhnJn/OQDIRK47M6VzGpGri/JA3ffTS5jJPpvWREsCfVQC9SQb+tge2p
	 Jog3fiZ0b6tGU/tfoBLUYV9coFaki+6TdLHvXU8/ggESBSc9OTNXE8KEIrF7/23Ftv
	 /a3g1zBzuvsbXLm+pk8E1o0sYyQOmQmZfRviU2J49Yd6A/KelzXTDSvkhJMxgu/H74
	 8MFmfQSR38T8qsqFtcn85kiEmO1jOHhCStNBP4Z7I53HeqAM3rr53uYuf/Qd9sjWW2
	 UyrKDXFtA/6WQ==
Date: Mon, 28 Oct 2024 17:43:52 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Rong Xu <xur@google.com>, Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Li <davidxl@google.com>, Han Shen <shenhan@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v6 2/7] objtool: Fix unreachable instruction warnings for
 weak functions
Message-ID: <20241029004352.z4nyyrexhlotptnr@treble.attlocal.net>
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-3-xur@google.com>
 <202410281716.0C8F383@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202410281716.0C8F383@keescook>

On Mon, Oct 28, 2024 at 05:16:44PM -0700, Kees Cook wrote:
> On Fri, Oct 25, 2024 at 10:14:04PM -0700, Rong Xu wrote:
> > In the presence of both weak and strong function definitions, the
> > linker drops the weak symbol in favor of a strong symbol, but
> > leaves the code in place. Code in ignore_unreachable_insn() has
> > some heuristics to suppress the warning, but it does not work when
> > -ffunction-sections is enabled.
> > 
> > Suppose function foo has both strong and weak definitions.
> > Case 1: The strong definition has an annotated section name,
> > like .init.text. Only the weak definition will be placed into
> > .text.foo. But since the section has no symbols, there will be no
> > "hole" in the section.
> > 
> > Case 2: Both sections are without an annotated section name.
> > Both will be placed into .text.foo section, but there will be only one
> > symbol (the strong one). If the weak code is before the strong code,
> > there is no "hole" as it fails to find the right-most symbol before
> > the offset.
> > 
> > The fix is to use the first node to compute the hole if hole.sym
> > is empty. If there is no symbol in the section, the first node
> > will be NULL, in which case, -1 is returned to skip the whole
> > section.
> > 
> > Co-developed-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Han Shen <shenhan@google.com>
> 
> This seems logically correct to me, but I'd love to see review from Josh
> and/or Peter Z on this change too.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>

LGTM, thanks!

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

