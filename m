Return-Path: <linux-arch+bounces-8680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7729B3EF8
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F078A1F23437
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E284A2D;
	Tue, 29 Oct 2024 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaL/UEsX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045CEAC7;
	Tue, 29 Oct 2024 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161008; cv=none; b=MpgJz8pwiapxyOED74PbVpfW7sQZZ2DqXmnAw6qWGwFX8L+oDMSdr8f8wl1KRqUw2+9IHelAfwX55iBYdM1b8TXQ2QiUZjljYFHJ8xSDZh6ayVJgDU2NUJKK6m4HHJGdPY9okE3S2KkqRJUGueTPGcSqpO0+TngCwxZH6A/dCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161008; c=relaxed/simple;
	bh=xhav10XFO8C8PiB8NEX2gC4giGIkDR6yNztn4uBYBn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxsEG2zy8nFGOAZSHcw4wOK3tvsUEPtkysK5iMdSa5FOTQ21VcAY5B+0TiBF0tj9SyACIZZ0VOV78gcQ6C5QYraHrXbuxxamg6ssGQVZIpHOVvHw6lJSK91KyWJ7RDDKDbWuciswM+JZp/PFU0bhpgsGRSGna+1lp3VOKxWFDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaL/UEsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46847C4CEC3;
	Tue, 29 Oct 2024 00:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730161007;
	bh=xhav10XFO8C8PiB8NEX2gC4giGIkDR6yNztn4uBYBn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaL/UEsX5xUCceSsz83+0va0N6TWXB1dfRvrUSOZmliayEMQrw16YVRu8wIFG04QD
	 duoMRAdnS0miyzU5PSNeRDEc9NxpH+f5794uwzZmyqh4XaRtoSVZI1lm6KF0LPPTnb
	 tDe7tTJMzfz5D8WwYt+q8twZiSmGJLXz96jUMpCrlZysPBiLfHjxW2fPeKNNWidsmH
	 n4oDpBjO8eJIKQAVWUbARlsCFUnYscPKb0aL6coXOUOpGaNiRjtOVTjcKSGd05IhJt
	 xWv9/2MP72R/tJvWLiakVHPp4GXvnQGuIDTDOQULMZjcCD1Pfs2H6YmMJaN99bx/EJ
	 i8+D4TYvDymJw==
Date: Mon, 28 Oct 2024 17:16:44 -0700
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
Subject: Re: [PATCH v6 2/7] objtool: Fix unreachable instruction warnings for
 weak functions
Message-ID: <202410281716.0C8F383@keescook>
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-3-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026051410.2819338-3-xur@google.com>

On Fri, Oct 25, 2024 at 10:14:04PM -0700, Rong Xu wrote:
> In the presence of both weak and strong function definitions, the
> linker drops the weak symbol in favor of a strong symbol, but
> leaves the code in place. Code in ignore_unreachable_insn() has
> some heuristics to suppress the warning, but it does not work when
> -ffunction-sections is enabled.
> 
> Suppose function foo has both strong and weak definitions.
> Case 1: The strong definition has an annotated section name,
> like .init.text. Only the weak definition will be placed into
> .text.foo. But since the section has no symbols, there will be no
> "hole" in the section.
> 
> Case 2: Both sections are without an annotated section name.
> Both will be placed into .text.foo section, but there will be only one
> symbol (the strong one). If the weak code is before the strong code,
> there is no "hole" as it fails to find the right-most symbol before
> the offset.
> 
> The fix is to use the first node to compute the hole if hole.sym
> is empty. If there is no symbol in the section, the first node
> will be NULL, in which case, -1 is returned to skip the whole
> section.
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>

This seems logically correct to me, but I'd love to see review from Josh
and/or Peter Z on this change too.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

