Return-Path: <linux-arch+bounces-7380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A9983A29
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 01:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B6FB225A6
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 23:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2889137750;
	Mon, 23 Sep 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TWtx4cCo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A5136E0E;
	Mon, 23 Sep 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133108; cv=none; b=IB6BUJebLMcq3bLEtAzTvr0j4ajwW94TbEGd5nfW0S4gb25pErlaI9V/OZiEyu6oyX9Oe3+T2O2Mx8nvNTV4BMoaVAQ3jMHm1NRmVAEk/sGq9Gw6yLsCrsYcYr4nTltvrFIz/oKri3OJFFVoOQ239SQ8WQOSMAKgMHeRxfD9Zbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133108; c=relaxed/simple;
	bh=4sdqK7hdyku3hb89hVpNtD2lfhHg+rJAV64nqLVzxcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgfjL/lBtIJSvqiAI+2ebowrY4OBkPkVOyJqiBtE7CvuuGUCfXcZpk/LTchYXHWpd8o+bxmsSeFria8xjoEA3KF+P29mjFDij0Tfk0TvdAOXeiJdEV5ykRqYnDFcf5V0er2wJsfi2ZZyj1ANdsntWNmOQSqGzAax7OSojTJwnAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=TWtx4cCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7B1C4CECE;
	Mon, 23 Sep 2024 23:11:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TWtx4cCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727133104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3C/OUt0U6Ap2O+4553rXu/pe49KxPnBMUvMSIZ+6eM=;
	b=TWtx4cCoYUxLqtztKAfcfNHTvYS/lEKvry/0Fvlvxwmc0sCdO0YkL4c3rbUHH4Mb48DUEf
	sLYbJpIZo+lXQ+n7gyqA7N8qbWv/e1Q/UMOyfLBnPQPWag7imZXLrDYYUxW2crCUS8vGzF
	l6SGGjmXH00dTgVTt6Hl73vdO3BEAMk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c29f048e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Sep 2024 23:11:44 +0000 (UTC)
Date: Tue, 24 Sep 2024 01:11:41 +0200
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
Subject: Re: [PATCH v2 8/8] vdso: Modify getrandom to include the correct
 namespace.
Message-ID: <ZvH1rVYy0iNCTpds@zx2c4.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-9-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923141943.133551-9-vincenzo.frascino@arm.com>

On Mon, Sep 23, 2024 at 03:19:43PM +0100, Vincenzo Frascino wrote:
> -		params->mmap_prot = PROT_READ | PROT_WRITE;
> -		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
> +		params->mmap_prot = VDSO_MMAP_PROT;
> +		params->mmap_flags = VDSO_MMAP_FLAGS;

The code that's being deleted is meaningful and descriptive. The code
that's being added is confusing. What on earth is a vdso mmap flag? Not
only is it indirection, which makes it harder to understand, but its
indirection through a meaninglessly generic name that suggests to the
user there's some additional property of the vdso or mmap or both that
would imply a specific flag for these general things. In reality, the
thing in question is about what getrandom.c uses.

