Return-Path: <linux-arch+bounces-5279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AB9286AB
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 12:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD751C2296B
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDCE149C5E;
	Fri,  5 Jul 2024 10:18:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E9614658F;
	Fri,  5 Jul 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174703; cv=none; b=NNM9GjfZWoMGDpeUafb5q2DYWV4441OU8++CpXqxkdprM8kjrppAJnUgIwMeMC81QwkWGDV0+3Mue8CLlaxDdUIyRakFps6qlQdIMnELuyvZVjjEW5sFPJNQ4GRn+56wonIImltTGd57Dy85H6LiVc5L19iTbma3f8b0ImEmxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174703; c=relaxed/simple;
	bh=Hwul11NZsyd+DScj1E92lgwl/APxMNe0JTVvacK0Fak=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Sc7dC9n7S+BjIN9KImxFXLV59Df39kF6cHUImxSo+NqhE1UiaYdu5Ek4vEV3UvkxZRvMwNhuLZgqo6nvPXtKUIYR6QoD857KHEQWHleA+n3EvEAE5yePS/ACbPkFgWCIPlUkc2B2+6ky/zLLg7eHKkQ0Vevf+C73ICcnQlqwLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E3DCF92009C; Fri,  5 Jul 2024 12:18:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DD96792009B;
	Fri,  5 Jul 2024 11:18:14 +0100 (BST)
Date: Fri, 5 Jul 2024 11:18:14 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@kernel.org>
cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
    Masahiro Yamada <masahiroy@kernel.org>, 
    Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
    Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
    Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
    Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
    Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
    Stafford Horne <shorne@gmail.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Rich Felker <dalias@libc.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, 
    Christian Brauner <brauner@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
    linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
    linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
    linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 00/17] arch: convert everything to syscall.tbl
In-Reply-To: <20240704143611.2979589-1-arnd@kernel.org>
Message-ID: <alpine.DEB.2.21.2407050323400.38148@angie.orcam.me.uk>
References: <20240704143611.2979589-1-arnd@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Jul 2024, Arnd Bergmann wrote:

>  arch/alpha/include/asm/unistd.h               |   1 +

 This seems out of sync with the actual changes, any idea what happened 
here?

  Maciej

