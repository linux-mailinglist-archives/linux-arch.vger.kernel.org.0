Return-Path: <linux-arch+bounces-12825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10250B07C94
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 20:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A0B4E80DD
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 18:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEC1267F58;
	Wed, 16 Jul 2025 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PdYs1CW7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51F52F88;
	Wed, 16 Jul 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752689765; cv=none; b=MUb+NLDl3umxOA+k0XN3Yt2pg9Mzu5NiLMDPhjCwN9iT8zptoNBLQDXgzjxMweN+Uvp1bV83mTWbefFrPCkikulHkKRd5h1iBFZ/6lWxx1MpRtAeZAmTumhgh6+GXA6fSf7vhnUK85f4Bdnte5Db9MlJGjQrEcDYdE04ITNaSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752689765; c=relaxed/simple;
	bh=AxYk3hb0otPOpe8iCoKRDXyzipO8+IEj3pxhrwFiias=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mv36Ox1PVk8hnD3xOC4ArP2C0pFpqq2+z1/sbV9o6l4M56er6JhN0x4fFODYCIdeuwg4xhSxltO5n5HpqPKg640zcUTQ9664JInY5hte0hvnuMaAjcCmPuRlEY2opVZb2MV+TqfJCOl9ogFF1HleuLA0yBegB0kQX4mhiXA0uzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PdYs1CW7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56GI4wZF1640497
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 16 Jul 2025 11:05:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56GI4wZF1640497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752689107;
	bh=AxYk3hb0otPOpe8iCoKRDXyzipO8+IEj3pxhrwFiias=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PdYs1CW7P6NGZ7nqrSTKiw9kGz8+zKtbJLnnYWGn7EmE85IhMRHjUsfqejqSu3NpC
	 F8mkqPxV94oRfsry8xLqbBh6TIeqEphXrM8IQVQXG98VV0VtmaqRkm8gcHZ1DS8I+Y
	 9Ud40lsWpWvI8f/Mw4fJttPFSqVPnBxm60MpDadKClPpxIliIxgGgmXKbtvKQmNI4w
	 9zRbpJ/rGGTy9XhzMH+JGYmHR8cviSmLp4ZAluTl43LX0HJw1hILVpbbrTd8F7h/pQ
	 VEaChnOfID89c6bfwtXUBb4UKngfABWVJFjrAYzLGKal7C5mVferZwFoGX1uSfry52
	 xqWYa7EnyTKlQ==
Date: Wed, 16 Jul 2025 11:04:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/1=5D_uapi/termios=3A_remov?=
 =?US-ASCII?Q?e_struct_ktermios_from_uapi_headers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aHfn9z9_oIVgNGgx@shell.armlinux.org.uk>
References: <20250716164735.170713-1-hpa@zytor.com> <aHfn9z9_oIVgNGgx@shell.armlinux.org.uk>
Message-ID: <9AEAF0BE-39D7-4617-9CB5-D0703B3E6DF8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 16, 2025 10:57:11 AM PDT, "Russell King (Oracle)" <linux@armlinux=
=2Eorg=2Euk> wrote:
>On Wed, Jul 16, 2025 at 09:47:32AM -0700, H=2E Peter Anvin wrote:
>> diff --git a/arch/arm/include/asm/ktermios=2Eh b/arch/arm/include/asm/k=
termios=2Eh
>> new file mode 100644
>> index 000000000000=2E=2E4320921a82a9
>> --- /dev/null
>> +++ b/arch/arm/include/asm/ktermios=2Eh
>> @@ -0,0 +1 @@
>> +#include <asm-generic/ktermios=2Eh>
>
>Isn't this what arch/arm/include/asm/Kbuild's generic-y is for?
>
>Ditto for other arches=2E
>

Ah, yes, you're right (except for those with nontrivial stubs=2E)

I also found that a handful of drivers and arch/sparc needs <asm/termios=
=2Eh> =E2=86=92 <linux/termios=2Eh> in <linux/termios_internal=2Eh>=2E

