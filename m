Return-Path: <linux-arch+bounces-8673-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908C9B3EBB
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40861F23399
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 23:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721F1F8EE8;
	Mon, 28 Oct 2024 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9X2dsx/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1A1DFDB9;
	Mon, 28 Oct 2024 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159813; cv=none; b=hIb30apFFglWuxvmQXjsNvNETUxrOe7blNfQh6kapAq/UO58A9JLciKLyQxtcxqa2I65zOkcY5FR1xdiTvzsW75+wYzShRW0xTX1u4SwqxmY6Fyf9YbS2kxW6+1eYKokQ4O9uWBs7oFfpnHbmMcYovtteZINvM1WylmnoVatzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159813; c=relaxed/simple;
	bh=JUHufYIdqmKXSfDlteSW20zJ1BG7mrAiwl8Jxg4y7ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7oZeA0oemjaiQZqZhDmDJ/RScwRyXjQfd/XOW+D5YGxpyDB2qwsydp8BoaAdzFEHZtjj6TmUwbQwZknvbkTyU+bqTMEfKhd508RF8pri7bZlG1+dGkbGnvNddF2TdSm0kK8nXRU3zuEqCYb/MbuzHL/PTtyrgmnyEAbVp5qeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9X2dsx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D64CC4CEC3;
	Mon, 28 Oct 2024 23:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730159813;
	bh=JUHufYIdqmKXSfDlteSW20zJ1BG7mrAiwl8Jxg4y7ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9X2dsx/WYpU0XxlJqeLzjw0zCr9QzJRK5HuFPJyM7dSk5hyi7aawTA4vbgZaNv0F
	 AsyBMVdxeXcdUsTNSnjUxHXjhAqkVrOvkUOuUku3uS1aI2ubXKvNfF8o9ALjmi7G7S
	 WFOswp6TSosWO5exTTVSL05V2sCYUj3Xgk2hdXoet7p+5R5oHmLwTvmkyttUXzlaRU
	 V3gjgFqybd0njHSVHNtHTHTVqMajCw7LWVWt3In/sE8G8Yuf6dcQStPNIIT41lWVSS
	 +dk3sMa1oXSufeFef45CJwSDzJLHsCvwToSMNlk+5RGO5EHZykpYsHA4ARnzD+jMQi
	 K0F5FD1ai5N7Q==
Date: Mon, 28 Oct 2024 16:56:50 -0700
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
Message-ID: <202410281656.6A598E64@keescook>
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

Yup, this is good.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

