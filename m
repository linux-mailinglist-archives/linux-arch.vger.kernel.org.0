Return-Path: <linux-arch+bounces-5284-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDF9928879
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BF9285471
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B435E14A0BF;
	Fri,  5 Jul 2024 12:11:27 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2C1494C9;
	Fri,  5 Jul 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181487; cv=none; b=VqRpC37qnDwxJZFcNbbNmj3DUs7xYxLZemCR7TO1fEeUXqkfCvm6wSxkYGsv3lSw1Nvz1ZkItECz/JEEBrwWUO0rIPtkKNu8EnPUyQjqPn4PWXHm2CnO2oJlSZ98Fh/bHXt/SfhB2hx4sht6xi+SNykAhhxpUsFE8yb5DwkgJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181487; c=relaxed/simple;
	bh=05/bIqRH9praDQCZUhhGfwQWJR7VbIKHivdQqwPOe+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoOIkjCQvltSvKQb+3P27sxLeDQrougFmCr5Ehf0qGty1VxOKv/ufpQEfrtqW4aeWWzeXmWxRkV0FIo6q7IcKWxoR4YUwX7OwaHNZqJZ0prRRzt5rPDOgYtXy9uVfjHL017k56xxm+qi3zEepNHydFpom6kWQjfKMq5bxgcjuuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A58C32781;
	Fri,  5 Jul 2024 12:11:19 +0000 (UTC)
Date: Fri, 5 Jul 2024 13:11:17 +0100
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
Subject: Re: [PATCH 11/17] arm64: rework compat syscall macros
Message-ID: <Zofi5a3LNm76jaY3@arm.com>
References: <20240704143611.2979589-1-arnd@kernel.org>
 <20240704143611.2979589-12-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704143611.2979589-12-arnd@kernel.org>

On Thu, Jul 04, 2024 at 04:36:05PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The generated asm/unistd_compat_32.h header file now contains
> macros that can be used directly in the vdso and the signal
> trampolines, so remove the duplicate definitions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

