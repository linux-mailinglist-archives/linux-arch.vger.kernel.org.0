Return-Path: <linux-arch+bounces-7716-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353C499176F
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 16:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580C71C212F5
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5F15383C;
	Sat,  5 Oct 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nNC+sglF"
X-Original-To: linux-arch@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270E81ACA;
	Sat,  5 Oct 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728139383; cv=none; b=Z12UEcqMyzp86hqESBEFnM6aUQrS5meN6LB/dhXqVUFaV6y8bY3ra/MPBGHGEJ3CEeSw9ydOqyD+sKTCRIkYEbe9JGDcIkyCh+G56h1xPyJhgxZfUTudJrhPN/D8DseqqDxsOl4xu5xBByrKxqmTUqz5C2IPxJ44AnBRP4nE8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728139383; c=relaxed/simple;
	bh=kpSHQEms/Rvttwa5HYtYs+uKlFsj7N1NRyTtQWRzz+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QVncdAhe4JVBFDjQpZxGZCNglzb6ydKJUZ7yrUpYOdoXORfWsvSIBhZD45C4OLXSRPRP02Qv5dI4YiY/C6jvPdlXiM8ZQOTTRqWyyGtz1pGsYRTCf+OCNK0NDYpQB49UKt4EFjHWOikTJmGHbhE0qFEYHLhRjJjcRSQa0Jwb3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nNC+sglF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A660842B27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728139380; bh=1ghV5ihBKvKi7oCgzNLT9Q+CxNIVkuQosbBZs1PkcUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nNC+sglFQb2Y113jOnT5t5kTMDuqUx+XpA3Zb6KK1nYum8ML5G0LTRgPsA9frC1jN
	 xg29VbvIKi2p47ooHcbkrHB4Tb/xibn4nya7hI36tWGMD2gC/8zPoktH7b8SALzXpX
	 nWs3Y5qljNe6qbb15oSlGv1AjBRQKeDLMbNBUmlBoH0owKQZhejfNxXuaNVDHtf7Bt
	 Rz7BPvlWZGSyFlZxAleTE2/C8vB3N7laoKq0qtxxKSIJY2py9EPUyVjbUbuPo53eaV
	 rOBT1KiwPx5+OXdZeXT9nhSDArYsvA+2mWhi3q3FL4yNcxlGUXJH+osk9a1tR9SI5T
	 jTNRR8Nf1KB+g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A660842B27;
	Sat,  5 Oct 2024 14:43:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>,
 David Li <davidxl@google.com>, Krzysztof Pszeniczny
 <kpszeniczny@google.com>, Alice Ryhl <aliceryhl@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Bill Wendling
 <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao
 <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jann Horn
 <jannh@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross
 <jgross@suse.com>, Justin Stitt <justinstitt@google.com>,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>, "Mike
 Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney"
 <paulmck@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>,
 workflows@vger.kernel.org, x86@kernel.org, "Xin Li (Intel)"
 <xin@zytor.com>, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
In-Reply-To: <202410041106.6C1BC9BDA@keescook>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net>
 <202410041106.6C1BC9BDA@keescook>
Date: Sat, 05 Oct 2024 08:42:59 -0600
Message-ID: <87setapq4s.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <kees@kernel.org> writes:

> The tradition in kernel .rst is to do this with the trailing "::", e.g.:
>
> +Configure the kernel with::
> +
> +     CONFIG_AUTOFDO_CLANG=y
>
> This loses the language-specific highlighting when rendered. Perhaps the
> "::" extension can be further extended?
>
> +Configure the kernel with::(make)
> +
> +     CONFIG_AUTOFDO_CLANG=y
>
> Then we could avoid the extra 2 lines but still gain the rendered language
> highlights?

The :: notation is standard Sphinx, not an extension we have done.  So
the proposed syntax would have to be done from the beginning, I'm not
sure how easy or hard that would be, or whether it would be worth it.
But then, I've always seen relatively little value in the highlighting;
others clearly differ.

Thanks,

jon

