Return-Path: <linux-arch+bounces-5282-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A68E92886F
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 14:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291851F22884
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 12:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FEA14A4C1;
	Fri,  5 Jul 2024 12:10:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD51494C9;
	Fri,  5 Jul 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181430; cv=none; b=tb44f4EfJbr9fRe2QAhnRiWCssEjN+t7ChGsV0CfforaEs4QTaWcwtxoQUNnwX0pLNyBHctRsp3D+X9SVL4+rJSVDR7ua0kYwgO70Skd4Fw4BlsXX1cLxqJVzpf8hVWPKpPASupgxI4KtIAXZfADbq2vCMiDhq9pXydVwz19S0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181430; c=relaxed/simple;
	bh=swj0FZd/2MnH7/jWGtvEcuYjMWoU4dnzcswcpFkNC8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tls2eNdLZVIEkYo+VKOrkIdXa2Iw/f0Wfxdrq8Z8yWkw7VsNX8fDIXqhSgVZVLvPJ55Yd68VQXM5GZ8IMNkaQAH0goN54kfJGVT2Dgziug/mYLU95lcRUO7gcq8B7h26+DETP9mX248IVabW7InOZSfX5mDZrNkLhjusw8PU1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A48C116B1;
	Fri,  5 Jul 2024 12:10:24 +0000 (UTC)
Date: Fri, 5 Jul 2024 13:10:21 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 09/17] arm64: convert unistd_32.h to syscall.tbl format
Message-ID: <ZofirWrl3nAuOQb_@arm.com>
References: <20240704143611.2979589-1-arnd@kernel.org>
 <20240704143611.2979589-10-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704143611.2979589-10-arnd@kernel.org>

On Thu, Jul 04, 2024 at 04:36:03PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is a straight conversion from the old asm/unistd32.h into the
> format used by 32-bit arm and most other architectures, calling scripts
> to generate the asm/unistd32.h header and a new asm/syscalls32.h headers.
> 
> I used a semi-automated text replacement method to do the conversion,
> and then used 'vimdiff' to synchronize the whitespace and the (unused)
> names of the non-compat syscalls with the arm version.
> 
> There are two differences between the generated syscalls names and the
> old version:
> 
>  - the old asm/unistd32.h contained only a __NR_sync_file_range2
>    entry, while the arm32 version also defines
>    __NR_arm_sync_file_range with the same number. I added this
>    duplicate back in asm/unistd32.h.
> 
>  - __NR__sysctl was removed from the arm64 file a while ago, but
>    all the tables still contain it. This should probably get removed
>    everywhere but I added it here for consistency.
> 
> On top of that, the arm64 version does not contain any references to
> the 32-bit OABI syscalls that are not supported by arm64. If we ever
> want to share the file between arm32 and arm64, it would not be
> hard to add support for both in one file.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

