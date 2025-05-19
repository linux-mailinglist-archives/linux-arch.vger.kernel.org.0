Return-Path: <linux-arch+bounces-11994-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B918AABC57C
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 19:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01AD7AA6C3
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8B202981;
	Mon, 19 May 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv6a6o/9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEF1DE2DF;
	Mon, 19 May 2025 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675209; cv=none; b=nzmdV7pdP3ZqRQcDjNmd+hDZ+c0HQu+Up+tVHBWPoO+LiuRJa8SiZWy65vZdNOQpA/iK0XVIPMbbt5zybdhNoHiHI/cNqmAHE2L0X10m6O27s6EwmX92eOfOyZ1XaRo2oE8IIvGXgBXOxFrgOBXu6dUEFFbRnIEa6XQQd/i9CjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675209; c=relaxed/simple;
	bh=/qDPGAJe6QWZQRFh5mkIaN3rUECBPrvhVDophOu0STQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDsIzr/h8OwM3S8fzRfwd/auHPBxqnubkI86JW5C5n+qO8fxXY5mlWvOtqDpvlRZDXRuruys3PudRSuSyVdMzsxV2dbG8SV+IMsIBBXrXa9mUJS9Pc9iw0+26i0+8KWprzLHPZ+w8UYWg7E2isrgyp0sG13GsICfwfaIIe7W2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv6a6o/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0486C4CEE4;
	Mon, 19 May 2025 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747675208;
	bh=/qDPGAJe6QWZQRFh5mkIaN3rUECBPrvhVDophOu0STQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nv6a6o/9GXqFce+WdqziKMZrgOnXd14Xk3g4S1nNlUHZltfdV2rEB9RDQCOmCeSgK
	 ebQsjcpfmgR6sWVWBw5dta/I6m1xLYkae6rTJ4OSb859vEywgddyloj50eaFEjRTPe
	 8FJ2qDU6rfYPGiDk1ORLqVzTGk/lQ8qlSrYclPnaRHuqKyuUafe4DFZ6lMgRdY6Wt1
	 dRptEgZtQ8qGZDrQUwGD8JbkbioWwAY9aSpa8iIJWxNVsecoqluy1Xci9uIALX28U6
	 ObnLi7IgFlid4DAXOMe7kw3cQbAB55J7ruXkv/fKErQRWuv0MXWPHfuo3pZS732DBZ
	 yyZPReh2t/BVw==
Date: Mon, 19 May 2025 20:19:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>, Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Praveen Kumar <pravkmr@amazon.de>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <aCtoNLf1FbtqijGr@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
 <20250313135003.836600-11-rppt@kernel.org>
 <mafs05xi0o9ri.fsf@amazon.de>
 <aCdveN2w9ThjVhae@kernel.org>
 <dc4e60dc-9b78-473a-9c18-3a2f128a02d2@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4e60dc-9b78-473a-9c18-3a2f128a02d2@ghiti.fr>

Hi Alexandre,

On Mon, May 19, 2025 at 05:54:23PM +0200, Alexandre Ghiti wrote:
> Hi Mike,
> 
> I encountered the same error as Pratyush and the above diff fixes it: do you
> plan on sending this fix for 6.15?
> 
> If so, you can add:
> 
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!
Here's the patch:
https://lore.kernel.org/linux-mm/20250519171805.1288393-1-rppt@kernel.org

> Thanks,
> Alex

-- 
Sincerely yours,
Mike.

