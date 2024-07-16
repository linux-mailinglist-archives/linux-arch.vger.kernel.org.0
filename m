Return-Path: <linux-arch+bounces-5425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081F9327EF
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 16:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5712857A0
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D058199E91;
	Tue, 16 Jul 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuBb6prh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA1C8DF;
	Tue, 16 Jul 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138442; cv=none; b=LwAS5kIBuR7EczRg+8w1LUXBJd+SDxj52GVaBMx4LQqLZdx7LnvnUx5grpdb9TWLOOMLmz2z5yACSguKe47Y2jmXZQiC2UJnIPa1exgpizGDaFjHzicbedbarnLaoBbVk1GQcH/xMiDHtCjp2WhdwmkuuUafsIXpVwP7wQgVqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138442; c=relaxed/simple;
	bh=q6G0LaBTnMOqEYsABjZwsURGHz9QWdlHe+gyWVklxts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0c4fBSWhE5Qo3rD/fGV4Lp7+rTctmEppnbzVtWb46x4nKKq+6RCbmK92dacocCu917OAoMWDz5MT5fllUSAl2oyUWGeAX03BTZu+CK72RXrk5AsNNjxnLT8qYmLVKljV1XwqFlHuXSd+Hv1LdvF03QuwMQK7s6zWM+uMDe92HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuBb6prh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405FBC116B1;
	Tue, 16 Jul 2024 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721138441;
	bh=q6G0LaBTnMOqEYsABjZwsURGHz9QWdlHe+gyWVklxts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FuBb6prhshjfIeleU2KrheelYSh2TnxOI7dWe1G5Dd3y1F4w95HaNp1CjgnCeXkNW
	 OR9rOeHh6duuGkkJ5a9B5+hzU+Zcd1olvWoEkNfYz71Bws4g6DG4L8z7Aa5cenrALe
	 6D26r7/ySoliE5GFuI9+e63sLpiG32FtnKhiUAgadyy9kgEJBASbO6dTYH3hiBULVG
	 o01Fgg3qZspZLf72CjxlxGa/zXLNpsWmPMJ0jKY5R+4I3dpTGrFGl6nBJRy9Lqwuf2
	 ZfivNfieZL0KusjE55gOWZQ+MTgxa5TCybgmzgp02+S7nSMi5MozglZjRCUHjRgmJ8
	 BqzAaLW5GH6JQ==
Date: Tue, 16 Jul 2024 07:00:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	kernel test robot <lkp@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
Message-ID: <20240716140038.GA3272205@thelio-3990X>
References: <20240626130347.520750-2-alexghiti@rivosinc.com>
 <202407041157.odTZAYZ6-lkp@intel.com>
 <20240705172750.GF987634@thelio-3990X>
 <CAHVXubhvk_CbBX=hWFGt+1HEM4cj=cAc1NsCEknn=B8UDcXVSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubhvk_CbBX=hWFGt+1HEM4cj=cAc1NsCEknn=B8UDcXVSQ@mail.gmail.com>

On Tue, Jul 16, 2024 at 02:19:57PM +0200, Alexandre Ghiti wrote:
> On Fri, Jul 5, 2024 at 7:27 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > Another alternative would be to require LLVM 17+ for RISC-V, which may
> > not be the worst alternative, since I think most people doing serious
> > work with clang will probably be living close to tip of tree anyways
> > because of all the extension work that goes on upstream.
> 
> Stupid question but why the fix in llvm 17 was not backported to
> previous versions?

Unfortunately, LLVM releases are only supported for a few months with
fixes, unlike GCC that supported their releases for a few years. By the
time this issue was uncovered and resolved in LLVM main (17 at the
time), LLVM 16 was no longer supported.

I could potentially patch the kernel.org toolchains but that doesn't fix
the issue for other versions of clang out there.

> Anyway, I'd rather require llvm 17+ than add a bunch of preprocessor
> guards in this file (IIUC what you said above) as it is complex
> enough.

Sure, this is not a super unreasonable issue to bump the minimum
supported version for RISC-V over in my opinion, so no real objections
from me.

> @Conor Dooley @Palmer Dabbelt WDYT? Is there any interest in
> supporting llvm < 17? We may encounter this bug again in the future so
> I'd be in favor of moving to llvm 17+.

FWIW, I would envision a diff like this (assuming it actually works to
resolve this issue, I didn't actually test it):

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 91c91201212c..e81eb7ed257d 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -28,6 +28,8 @@ llvm)
 		echo 15.0.0
 	elif [ "$SRCARCH" = loongarch ]; then
 		echo 18.0.0
+	elif [ "$SRCARCH" = riscv ]; then
+		echo 17.0.0
 	else
 		echo 13.0.1
 	fi

Cheers,
Nathan

