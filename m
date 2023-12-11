Return-Path: <linux-arch+bounces-896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5561280D107
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8678F1C21415
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997994C633;
	Mon, 11 Dec 2023 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FiucfIPo"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A381A9;
	Mon, 11 Dec 2023 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MPLySSIA+ntdrvXPY6WLPHcSeoOpRBMJKsLFdEaHpkU=; b=FiucfIPo+cO11SUxoMH1rJdvqv
	wfEC5yblDCMXDQY0OixUw0haAM61OP7SSA+pSzbjWuXecVi10RyVfeyqeXMWZTJMJZPMW8UyiE+2t
	g+svd17tDKounF/vNcRa5yoyPjucT8XLCCZHwrXjUSfmzvhY1vpFNOoT7PvEuwde+WUSmxCEc7p0W
	1ul+M4tqKhhUj05i/GCzaLechyYXXE9C2thbHs8lQwUjgWOUkHceRkV3o+/DWL9yx1/GW852FAwWG
	KrNQQTP3w4OIETUwxzlphh61g0cIqWK5xeXd6eOjjmlarE2bnEbyzACmkdhG3zoz3cwFtTRQv51bT
	rmQymT4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCizL-005k47-1J;
	Mon, 11 Dec 2023 16:18:35 +0000
Date: Mon, 11 Dec 2023 08:18:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH 11/12] selftests/fpu: Move FP code to a separate
 translation unit
Message-ID: <ZXc2W1Rl+S/UWAK3@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-12-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-12-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

>  obj-$(CONFIG_TEST_FPU) += test_fpu.o
> -CFLAGS_test_fpu.o += $(FPU_CFLAGS)
> +test_fpu-y := test_fpu_glue.o test_fpu_impl.o
> +CFLAGS_test_fpu_impl.o += $(FPU_CFLAGS)

Btw, I really wonder if having a

modname-fpu += foo.o

syntax in kbuild wouldn't be preferable to this.  Of coure that requires
someone who understands kbuild inside out.

> +int test_fpu(void);

This needs to go into a header.

And I think I underatand your way to enforce the use of a separate
compilation unit in the riscv patch now.

Can we just make that generic, e.g. have a <linux/fpu.h> that wraps
<asm/fpu.h> that does the guard based on a
-D_LINUX_FPU_COMPILATION_UNIT=1 on the command line so that all the
code becomes fully portable?  Any legacy arch specific fpu users not
using <linux/fpu.h> would not be affected by it, although it would be
great to eventually migrate them to the common scheme.


