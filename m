Return-Path: <linux-arch+bounces-10328-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B379A40752
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 11:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606173AEECF
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E41207DFB;
	Sat, 22 Feb 2025 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E0xbOLPR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z74TsqYt"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A593A20766E;
	Sat, 22 Feb 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740219269; cv=none; b=HLxKPDO0PKCwa4LpjbJCpQFjRuEgaOl6imvrzmy5jHWcdVFIuWi+qqFOiNPUAcyZbpLrPYzn6/BB+YMaTnuqk/4GCrYWd7H4yRF9KZ2ch3jSMbxvqwsJLhsaYDETZlEro+XlrXZVvh5Wlniuxm8CkOFRxy02ZE3aGdylYi9tUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740219269; c=relaxed/simple;
	bh=ygaPhnEWXxg0PTIQSnFt/u2T3zJiHAt9hR7zOE9Myuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SflJThYgdUAK1XP1AAmE2Tk2Ph+dTBnkhkvnTIcKNiTl0p9OI0+qxt4hfPyrfn4KfdPFgxpdtCmMEtOUC+uw4e19WrwERiccYJ2iDDq9+X9bbtPPG9L1FEgmqgy6Z5Q7aZQgjg/WZE9PeqnMmA5Yf3U8+Aid1woJV00jw/G837E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0xbOLPR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z74TsqYt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740219265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYt57ZYgbjy6ej8hXDty7Cfp9Tf5nA32oYEo7YLt3U4=;
	b=E0xbOLPRJ+XD/M3Ao9By6szoKCsyLxcxtVTGsSbhAcE5NU1NK5C2+Dfl+zJ4+rpk8p2vce
	IgpgL+eLpTnyqk83xyrJHvEqqHTXl3g07KURIn1lsZ0aq6OKRUYTD54okHfdjXqNbDsSjC
	8vSMloBPM2AV4QgA0stwUEWMG6uZx3A9biypqi3p4tS6E2BLtlPpYMDvXniwVQOifJQaz1
	6Qig6O/uBgxjjBbGrOo71YvA2kL4peLeza5WOnn/Kdf4/Lf3rBALBWYLzmAVI3S8o31rMK
	Fy+Fe19AlwTl2IsoJXlYAVNRDdBMW1sP8B0maDlcTMTjaB57ZbWi7eIerkehlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740219265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYt57ZYgbjy6ej8hXDty7Cfp9Tf5nA32oYEo7YLt3U4=;
	b=z74TsqYtERi/FO28k1WNxuOk/eCrttvKrCalx/NPgzVgRgvry4d1qCKiaSmbcNlhBsMonW
	bE0L5AunrFXssYCw==
To: Xi Ruoyao <xry111@xry111.site>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Russell King <linux@armlinux.org.uk>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>,
 Madhavan
 Srinivasan <maddy@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
 <arnd@arndb.de>, Guo Ren <guoren@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
 linux-csky@vger.kernel.org
Subject: Re: [PATCH v3 09/18] riscv: vdso: Switch to generic storage
 implementation
In-Reply-To: <1adbf1603237b654a2948ae13692c6b6db0ab7eb.camel@xry111.site>
References: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
 <20250204-vdso-store-rng-v3-9-13a4669dfc8c@linutronix.de>
 <1adbf1603237b654a2948ae13692c6b6db0ab7eb.camel@xry111.site>
Date: Sat, 22 Feb 2025 11:14:23 +0100
Message-ID: <87a5aegubk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22 2025 at 16:17, Xi Ruoyao wrote:
> On Tue, 2025-02-04 at 13:05 +0100, Thomas Wei=C3=9Fschuh wrote:
>> The generic storage implementation provides the same features as the
>> custom one. However it can be shared between architectures, making
>> maintenance easier.
>>=20
>> Co-developed-by: Nam Cao <namcao@linutronix.de>
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>
> I made a RISC-V vDSO getrandom implementation on top of this and it
> works fine.  I'll submit it when this is merged.

You can submit it right now. If it's reviewed and if Jason agrees, this
can be merged through the timers/vdso branch on top of the pending
changes.

Thanks for testing it!

       tglx

