Return-Path: <linux-arch+bounces-7378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E29839E4
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 01:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56D81F22740
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 23:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A849631;
	Mon, 23 Sep 2024 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RPVr1/rm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65332EBE;
	Mon, 23 Sep 2024 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727132741; cv=none; b=b+2IEGFSV43a/SKX39ME203QLRfjdG3QigZOV4z7DU2DnL1GN5VN8yKBaZkIGc3fIS25m5D7J7P2Arj+kAvbLrd+nmG8ETgCBorjh6v7MAXoJVvdNVVxydhQC2TQH+BHImwW2O25I6PJREpX13vpWA92kdEvHZbmAfv7dBFOM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727132741; c=relaxed/simple;
	bh=0O6PtROxadZrY/VAcyyyw9Np/jYoGHj6QI/nNVeXILo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvAHHRKoDNPMwN8Eq15fjIacaagVgEr1HTH0xDC3xbTz9HSq/D2q8oUVx3XdchHKcE8qAaM6IqpqvQ0vcIhnfKk+tsjQ4Add0g6Zi8j9tdd5uCBbmc9P9FR/MuHRg62awu4ZP0xdijS/bx110DBfvL4qzfHMIu2wrBtFIbxggjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=RPVr1/rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C89C4CEC4;
	Mon, 23 Sep 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RPVr1/rm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727132737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BZ/LKuy4JUAxkCxQ7w2V85f9H0J8TJTm3lbIAOw3TI=;
	b=RPVr1/rmQkiFFZmwEAEGwQ0hr7hRSCwHhoQiMrMWvFmxgkNs3jJ7HaTbTKUZURFBkafIpK
	08R2gMJKzesQcloQtqFCdhcivSdF4L8PMxIwzjSe2SeSw4Y3ym7Lx0DRq6ABFLk5gm64h4
	MNmvE9iqKM7GieSVt00jnmiPN48918E=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e7ef6b0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Sep 2024 23:05:36 +0000 (UTC)
Date: Tue, 24 Sep 2024 01:05:33 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 1/8] x86: vdso: Introduce asm/vdso/mman.h
Message-ID: <ZvH0PdVy5jJN3VTt@zx2c4.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-2-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923141943.133551-2-vincenzo.frascino@arm.com>

Hi,

I have the feeling I said this in the last two revisions, but maybe I
just thought it or agreed with somebody else who typed it but never
typed it myself, so now I'm typing it in no uncertain terms.

On Mon, Sep 23, 2024 at 03:19:36PM +0100, Vincenzo Frascino wrote:
> +#define VDSO_MMAP_PROT	PROT_READ | PROT_WRITE
> +#define VDSO_MMAP_FLAGS	MAP_DROPPABLE | MAP_ANONYMOUS

No, absolutely not. This is nonsense. Those flags aren't "the vdso
flags" or something. The variable name makes no sense. Moving the
definition outside of getrandom.c like the next patch does also makes no
sense. Do not do this.

If you need to, for some reason, rename those symbols, then rename them
each to VDSO_MAP_ANONYMOUS or whatever, and then use those from within
getrandom.c so it remains as readable and reasonable as it currently is.

But under no circumstances should you move where this is expressed and
rename it something generic like "vdso flags", when it is not generic
but rather very specific to the function where it is currently used.
IOW, please take a look and try to understand the code that you're
touching when proposing changes like this.


Also, though, I don't quite see what this patch accomplishes. If you're
fine doing #include <notvdso/whatever.h> into here, importing this
header into vdso code will transitively include notvdso/whatever.h with
it. So in that case, either we can keep using MAP_ANONYMOUS and whatnot
in the original sane symbol names, or this approach isn't correct in the
first place.

Maybe what you want instead is a simpler vdso/whatever.h header that
just includes nonvdso/whatever.h, and then you let getrandom.c and other
things keep using the same symbols as they were using before.

Jason

