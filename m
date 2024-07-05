Return-Path: <linux-arch+bounces-5283-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04099928874
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 14:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2A71F2265C
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE814A0AE;
	Fri,  5 Jul 2024 12:10:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B4A1494C9;
	Fri,  5 Jul 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181446; cv=none; b=rjedoSOnyuxEXq3iZimOx2xzu/pOEoWzfjw+nM2dXN8WjHxP7MJn/fcYB9nbha8A9kQli81d5IFcdZzq+TG3fgU0tVfTR8oYLhliqGfg+n6lNtxBd88xYSToPs7mHtfllXdKDgoe4sJdS+PvbNEUBf8EVNlKmRbAuFvRTQ+cuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181446; c=relaxed/simple;
	bh=DcI8yPOQfp+ba/V0DnCzKDKydLHlGxb8rNVH/wyribU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oceSmbmGtQIJqSd6Ch58Wi0UnTsjpF6cwlMCsn5Z0EvMbHLZajGXq/3uEdjeiiNbgzdpoRZzTDULKGaYkNHWzIHpHN2O7mGBDnlEM1gNtK25vdECFhfHt4q3xmsqKBzP9Bv0c/yPEueWmIQ27Q9bdgftWRC6cY7+5p08pVqqDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A637C116B1;
	Fri,  5 Jul 2024 12:10:40 +0000 (UTC)
Date: Fri, 5 Jul 2024 13:10:38 +0100
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
Subject: Re: [PATCH 10/17] arm64: generate 64-bit syscall.tbl
Message-ID: <ZofivjdRybQKi6q9@arm.com>
References: <20240704143611.2979589-1-arnd@kernel.org>
 <20240704143611.2979589-11-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704143611.2979589-11-arnd@kernel.org>

On Thu, Jul 04, 2024 at 04:36:04PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Change the asm/unistd.h header for arm64 to no longer include
> asm-generic/unistd.h itself, but instead generate both the asm/unistd.h
> contents and the list of entry points using the syscall.tbl scripts that
> we use on most other architectures.
> 
> Once his is done for the remaining architectures, the generic unistd.h
> header can be removed and the generated tbl file put in its place.
> 
> The Makefile changes are more complex than they should be, I need
> a little help to improve those. Ideally this should be done in an
> architecture-independent way as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

