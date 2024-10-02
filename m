Return-Path: <linux-arch+bounces-7619-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C58798CC3A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 06:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160F8B2203F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 04:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84703171AF;
	Wed,  2 Oct 2024 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEkKxegf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453EC11187;
	Wed,  2 Oct 2024 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727844832; cv=none; b=nqioNcvCzatyIGqCGChqycNpkyOdH4LQY4mAST6gZsWbyAnDdiGAs5JeH75FWg/H2BuoZyrQaKub7Mp27Uv1+g08OLsatM03VEyicA5ylBbMX5gbGFiL6UF6rbkGC6DdROarjsIj0hHoxWWo4BCDqu30ha4rN+BlXPgE9cv5U+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727844832; c=relaxed/simple;
	bh=B2ZAQKodtjVu7cBwU2oU+uI8JVPYDT8FSzV0LYMamag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6y8he0t4VGMI2so2t1iMOKkO0dfm5gQ5DLjmxm1hILqwm+wUWDcYGhlfiN0W1hFJoSPEVH96mNJPCbo2O0eXq94N3mxFhkKJdF2pVIhKg5MhzZCi0vW2YcX1VFMLydjIluhp4LmgHlk1Oh+X7LUFTs1XlI+uEK4vl1XduCNzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEkKxegf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31909C4CEC5;
	Wed,  2 Oct 2024 04:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727844831;
	bh=B2ZAQKodtjVu7cBwU2oU+uI8JVPYDT8FSzV0LYMamag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEkKxegfpkX4Zw2CaHm5skQNLmPRJhWvRWrfwNVlh+TFSz9BPuRZdgUJT+gZ23vFJ
	 IxhXfrAdi/5Tzs2K9tvjU3gGZB7VVKI4WK6iDn0vYP8Or/TvoXD3w3WnjkCdL7pIqo
	 yAvyTAGmv5OmjrtPe8R7vrLNoxKPxUOfc15RGQ+nZr1J+I99IYLiEMGzK5HchaL0Rb
	 fCgXSnWAkdoQPpNtPUVza5lz7aLWm5cSFY86HH4WWW1emta+IbTxS2QRhxf7N54ops
	 vKi+l2ymUNL9BK54SZfzJOyLLVNlGP4C8ThAbAA+5rGKWDt7DLBpJn9rzmHQgg9i3o
	 dEWzEr1A+63LQ==
Date: Tue, 1 Oct 2024 21:53:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Wentao Zhang <wentaoz5@illinois.edu>
Cc: Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu,
	johannes@sipsolutions.net, jpoimboe@kernel.org,
	justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	peterz@infradead.org, richard@nod.at, rostedt@goodmis.org,
	samitolvanen@google.com, samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com, tglx@linutronix.de,
	tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code
 Coverage and MC/DC with Clang
Message-ID: <20241002045347.GE555609@thelio-3990X>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>

Hi Wentao,

I took this series for a spin on next-20241001 with LLVM 19.1.0 using a
distribution configuration tailored for a local development VM using
QEMU. You'll notice on the rebase for 6.12-rc1 but there is a small
conflict in kernel/Makefile due to commit 0e8b67982b48 ("mm: move
kernel/numa.c to mm/").

I initially did the build on one of my test machines which has 16
threads with 32GB of RAM and ld.lld got killed while linking vmlinux.o.
Is your comment in the MC/DC patch "more memory is consumed if larger
decisions are getting counted" relevant here or is that talking about
runtime memory on the target device? I assume the latter but I figured I
would make sure. If not, it might be worth a comment somewhere that this
can also require some heftier build resources possibly? If that is not
expected, I am happy to help look into why it is happening.

I was able to successfully build that same configuration and setup with
my primary workstation, which is much beefier. Unfortunately, the
resulting kernel did not boot with my usual VM testing setup. I will see
if I can narrow down a particular configuration option that causes this
tomorrow because I did a test with defconfig +
CONFIG_LLVM_COV_PROFILE_ALL and it booted fine. Perhaps some other
option that is not compatible with this? I'll follow up with more
information as I have it.

On the integration front, I think the -mm tree, run by Andrew Morton,
would probably be the best place to land this with Acks from the -tip
folks for the x86 bits? Once the issue above has been understood, I
think you can send v3 with any of the comments I made addressed and a
potential fix for the above issue if necessary directly to him, instead
of just on cc, so that it gets his attention. Other maintainers are free
to argue that it should go through their trees instead but I think it
would be good to decide on that sooner rather than later so this
patchset is not stuck in limbo.

Cheers,
Nathan

