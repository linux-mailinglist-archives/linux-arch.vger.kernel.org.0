Return-Path: <linux-arch+bounces-14115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44ABDD256
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 09:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B953B16D7
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D04C31329D;
	Wed, 15 Oct 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MqmgDj7S"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B0304BBA;
	Wed, 15 Oct 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513846; cv=none; b=ju6EqBgwG1IhddvFXEayJq90848Zseu1azkj76c9eDFENbm418EzFUBPFMMIkMYDxlnO65aCDdJhjT8eRm5yRHfuyQDS/ovE5LHZeyBu+7HBr4bDQtAojeSFK4hmvwN/i1aKD5Mj+ecPscMZSk6CD+vWhlf1qjQJ34ZO9L99SRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513846; c=relaxed/simple;
	bh=usd1O1gWSARVzS39vvkdNKA/0m34I6mskKXhBcUW4JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjTSi33AVhOeDBqS79Ku9N6IvAhEaoCVqUNWtPx68g8b6GVSstyoMp+NsMK9wA5F2f4xHw2+CHHyWUI51Q5kSIqeoqG1MvT6WKP7zmMaCrZcZeje/zAyaGCgh4+pm6f3iepR4iV13zOILDZUn3laTNvu+/1/dVeGfHHvAfzvoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MqmgDj7S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K0Byfm25HAm+hkuPU/+MWl6Aww3n7DOCSkjI/zRPF4w=; b=MqmgDj7SwmG2m7iemtBBl9O0WI
	ICtTPOLnsUcUEE4QyBZjiakIuKfaL+DI/SdBoajINUi8s4JFhUj8jouZ2qRnSmxvH8zv4QrAgQwJz
	sOml5c8u2hWLB+BaJgIfH8xYKmDE847NLIBewcea/0pgau3GjKmrVc+9OzvXNxsSM/XoMk/dz3nRg
	exDTpN2rGq5/7FPem/jALj6GOaYzvaUXXbxh0DYGbV0COAW1BETkq/VNK9VRhQESH23SGL/Im0QA3
	aGidDeS4PVbzj8jqZEoaUBqx0iYkA5zpd+f52FuSEaKjF7v6HxMkp56PwgFA/7wBrC3VGjf5uXwY9
	VQcd+Z4g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8w4D-0000000A8y5-3wOB;
	Wed, 15 Oct 2025 07:37:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A4D59300325; Wed, 15 Oct 2025 09:37:01 +0200 (CEST)
Date: Wed, 15 Oct 2025 09:37:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: nathan@kernel.org, Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
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
	richard@nod.at, rostedt@goodmis.org, samitolvanen@google.com,
	samuel.sarkisian@boeing.com, steven.h.vanderleest@boeing.com,
	tglx@linutronix.de, tingxur@illinois.edu, tyxu@illinois.edu,
	wentaoz5@illinois.edu, x86@kernel.org
Subject: Re: [RFC PATCH 0/4] Enable Clang's Source-based Code Coverage and
 MC/DC for x86-64
Message-ID: <20251015073701.GZ3419281@noisy.programming.kicks-ass.net>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014232639.673260-1-sashal@kernel.org>

On Tue, Oct 14, 2025 at 07:26:35PM -0400, Sasha Levin wrote:
> This series adds support for Clang's Source-based Code Coverage to the
> Linux kernel, enabling more accurate coverage measurement at the source
> level compared to gcov. This is particularly valuable for safety-critical
> use cases (automotive, medical, aerospace) where MC/DC coverage is required
> for certification.
> 
> Changes since previous patchset [1]:
> - Rebased on v6.18-rc1
> - Adapted to lib/crypto reorganization (curve25519 exclusion moved to
>   lib/crypto/Makefile)
> - Minor correctness fixes throughout the codebase
> 
> The implementation has been tested with a kernel build using Clang 18+ and
> boots successfully in a KVM environment with instrumentation enabled.
> 
> [1] https://lore.kernel.org/all/20240905043245.1389509-1-wentaoz5@illinois.edu/
> 
> Wentao Zhang (4):
>   llvm-cov: add Clang's Source-based Code Coverage support
>   llvm-cov: add Clang's MC/DC support
>   x86: disable llvm-cov instrumentation
>   x86: enable llvm-cov support
> 
>  Makefile                          |   9 ++
>  arch/Kconfig                      |   1 +
>  arch/x86/Kconfig                  |   2 +
>  arch/x86/crypto/Makefile          |   1 +
>  arch/x86/kernel/vmlinux.lds.S     |   2 +
>  include/asm-generic/vmlinux.lds.h |  36 +++++
>  kernel/Makefile                   |   1 +
>  kernel/llvm-cov/Kconfig           | 121 ++++++++++++++
>  kernel/llvm-cov/Makefile          |   8 +
>  kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
>  kernel/llvm-cov/llvm-cov.h        | 157 ++++++++++++++++++
>  lib/crypto/Makefile               |   3 +-
>  scripts/Makefile.lib              |  23 +++
>  scripts/mod/modpost.c             |   2 +

I'm thinking I'm going to NAK this based on the fact that I'm not
interested in playing file based games. As long as this thing doesn't
honour noinstr I don't want this near x86.

And we have kcov support, and gcov and now llvm-cov, surely 3 coverage
solutions is like 2 too many?

