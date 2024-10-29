Return-Path: <linux-arch+bounces-8677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA09B3EE2
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD731C2241D
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2594C8F;
	Tue, 29 Oct 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTZr1/0b"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AF4A2D;
	Tue, 29 Oct 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160604; cv=none; b=aYQPXuodyioqec2xqlKpqYPuIEHnK8f7wX4OAydoa2lcxEWUCe+VwF66NGAohBIyPKmjGehyDBCyqnraRA3CG6hSRv9+Exs6YKLa/yZmfdBFXNc4nzPka7nhRpY+RfKd65MXhfrnzjBwLf3fVi2ow9RtPMWswUZJqTT06Q+NIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160604; c=relaxed/simple;
	bh=CcH7XW3XrvkZndtH10ZtxH80+gXvC7h4Zu9smQr3Dcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj64bZ3IaOcnbtXNzLvjkQhD92YhKLNn26Y6F1f70nsxoCrKhXV1vyNunrGk0kMtCkUGRKmME5NLAfcQF9ra0sge3GMGvW3Y+nRRKAVYE+nhMP//w6JgO1nlwwK1MVrgMIxKHufSj8TTagV/44Ci5ahALp0MCjvBRTBTXJYIyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTZr1/0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E500C4CEC3;
	Tue, 29 Oct 2024 00:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160603;
	bh=CcH7XW3XrvkZndtH10ZtxH80+gXvC7h4Zu9smQr3Dcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTZr1/0bb0pqwmzeUkQvCvby7J2pvADOr6K7JDWHSa9kbYp2SjYObe319rTcWkBxd
	 1savu+cGUhJIwcLng1zwJ1V0T4rmi5e28qWjoeH+fpzobGlcC+Kbunr3Yj28CgUh6c
	 YNlxnHYNPm4GzH2U1uuQKOznhtiilFhPQ+qnYGnCaiKBizYd7fL2CIgClJmBo4JrCB
	 QiwXXGEHAVVYv5eZ9GdTLkzWVervGbqROHNj0wEnwf1l8COdWiQ4o2LvrhGN/yOgwW
	 hc6MgF1mkGN6m4PEI5IcRecBJgIbmeAX0myxgVAsw5WltUlm4kMvxd9pXKpAD3H6i4
	 WYJxD6XGZniew==
Date: Mon, 28 Oct 2024 17:10:00 -0700
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
Subject: Re: [PATCH v6 5/7] AutoFDO: Enable -ffunction-sections for the
 AutoFDO build
Message-ID: <202410281709.DDFE98FA3@keescook>
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-6-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026051410.2819338-6-xur@google.com>

On Fri, Oct 25, 2024 at 10:14:07PM -0700, Rong Xu wrote:
> Enable -ffunction-sections by default for the AutoFDO build.
> 
> With -ffunction-sections, the compiler places each function in its own
> section named .text.function_name instead of placing all functions in
> the .text section. In the AutoFDO build, this allows the linker to
> utilize profile information to reorganize functions for improved
> utilization of iCache and iTLB.
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

