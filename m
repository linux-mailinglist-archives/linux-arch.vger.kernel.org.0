Return-Path: <linux-arch+bounces-9411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA239F36EE
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D31B164554
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C841F706A;
	Mon, 16 Dec 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmVwFrWX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A51126BF7;
	Mon, 16 Dec 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368279; cv=none; b=Ky9U55do/UP9ABVX7zfoF1zgF6ccPqHZsGVaG5rJKv/kSj85R1fc3lc9YNzh1hDkdjVpvo25oxX1uLux0VukwBGQnrzqiCKvqfC3dCJYwXvElklWWwdl1AhfLVOvv5rg3/8T3HLDs44mgjRuQrHOHySuVb4U+FkNYOf+Q4m2dAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368279; c=relaxed/simple;
	bh=2g/ijjRAvwPbHRj0gGJmC78zGvQSCovuTyTercaC5Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAoW4I46rqVtFZlkwoTp8lXdDJFBq3JgxtkjdB1kkya82Z5KDNS1oYsH89BEe/oqLfiz/4yza8tdIZ4n3L9YPWXxsudhwqK5b0f/b5+eNZlhHs+0KZZ1ckTCZIARxfM3EHtraymzt8v6AblJw62YFAquwVyAWGrfbMRmQS75i28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmVwFrWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE15C4CED0;
	Mon, 16 Dec 2024 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734368279;
	bh=2g/ijjRAvwPbHRj0gGJmC78zGvQSCovuTyTercaC5Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmVwFrWXBe75ZGC/+7NSZeoc53qoFHfY+EhL8UfcZe6SnJQKPkmFVTAndYXgEHbGu
	 53fNGgaGkFe/CuakWOH1ocX2zfg4ZSWWX9hIFnba2QMpNggfzSn18IdKgLBktUUt2G
	 5ydztzXTWsCgjL/q60w94QJ03ffAbQCD6HJXvyODBqSkQwEHSFMS1XpNnspnVPWR3H
	 IV3P7dI6sbC5LV9AywNIVh7nkFBmQeTAfnydfM/T+ewuqRCx0I56Twr4WAppUoRHQI
	 w7hEsMUnRo8Uk6VDWWs/8tMGcJkobxCuniHSzJUDSOiygs7t3rqC89NvlwWIxlCX03
	 1524XMJkMGMnw==
Date: Mon, 16 Dec 2024 08:57:57 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Gomez <da.gomez@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: keep symbols for symbol_get() even with
 CONFIG_TRIM_UNUSED_KSYMS
Message-ID: <Z2BcFZ89wCLHm8YW@bombadil.infradead.org>
References: <20241214105726.92557-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214105726.92557-1-masahiroy@kernel.org>

On Sat, Dec 14, 2024 at 07:57:20PM +0900, Masahiro Yamada wrote:
> Linus observed that the symbol_request(utf8_data_table) call fails when
> CONFIG_UNICODE=y and CONFIG_TRIM_UNUSED_KSYMS=y.
> 
> symbol_get() relies on the symbol data being present in the ksymtab for
> symbol lookups. However, EXPORT_SYMBOL_GPL(utf8_data_table) is dropped
> due to CONFIG_TRIM_UNUSED_KSYMS, as no module references it in this case.
> 
> Probably, this has been broken since commit dbacb0ef670d ("kconfig option
> for TRIM_UNUSED_KSYMS").
> 
> This commit addresses the issue by leveraging modpost. Symbol names
> passed to symbol_get() are recorded in the special .no_trim_symbol
> section, which is then parsed by modpost to forcibly keep such symbols.
> The .no_trim_symbol section is discarded by the linker scripts, so there
> is no impact on the size of the final vmlinux or modules.
> 
> This commit cannot resolve the issue for direct calls to __symbol_get()
> because the symbol name is not known at compile-time.
> 
> Although symbol_get() may eventually be deprecated, this workaround
> should be good enough meanwhile.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

