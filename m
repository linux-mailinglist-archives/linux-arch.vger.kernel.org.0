Return-Path: <linux-arch+bounces-10148-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5ADA35C9E
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 12:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787B1188DCF2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D9262D11;
	Fri, 14 Feb 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0VNtTEYh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WFnwPIfj"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE5221541;
	Fri, 14 Feb 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532895; cv=none; b=ppG0Wzpt+Kznpqm62ea8JKVJz6eg3YT7PNFSTkKF3kK6PXRbVDifWpUtmKFWgiDJuouxM/HrkeHKq/0UyA3eDRy+n2U0f0rSMr9Em9gLYctjppwptKpM3gl49q4aTFW3EOFkN6FageJ8Qst0H9VaDfUhSE6R99Ft6Z7/hj5TjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532895; c=relaxed/simple;
	bh=ZSR5ExLzPOWzKeKJCYti0FPwPXEtrgPIJBvFt7ageL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwk8NZNh21ayng0IeDKlbnGLtHdZhpGKnFYRvgWmVng7EveNGoEebW5aZzcYEpF8vi01UTRuCpt+0wWcgnprHBBqjjjB49VQ+9cIZ1QpxsUrsIu5xlQXzEcnHDtufMXOYFB5VidtZlmKSiSTI/aeTKviUuYbxNeWRNFwh3Jz970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0VNtTEYh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WFnwPIfj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739532886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWdSDqLPiHMtkC3qRBjEr7KgW5xesCDv6jmHPBIB4Zc=;
	b=0VNtTEYhNZqymGENVsUmuk+rnlFfX7RSGT3Ho51Jzxq38FSlmeIElqqU148QkLgRvvbxMF
	oARriYR4RFpth96NjMkBo5hNBkelucCuzn5JwatniL1M08uy4SKjyhCAdV/qdQ/eba99LI
	XiEfVSgYOnLLjTtprHlvawcrkXxeqR+m8TpQcRwp+J+sEstFenL0586F5ak1q3mLy7LV6n
	qnrektVapcPsyxUDFZn8atapF68IW+EhNarZoqS+FgcZ3nF1GslRp9zthgkNswbWYfqivE
	2J78e9sNA7ZDPletmeb/HsB02wyQreu92A/Zp2E3TtpGj+8SwnWuzKOp2Uz71Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739532886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWdSDqLPiHMtkC3qRBjEr7KgW5xesCDv6jmHPBIB4Zc=;
	b=WFnwPIfjvhMmBrrfQwvQ/cPdgZnaXQkJD4fxKY5hU7USn1NEKaf7iB28bu/zo8sPSUnwBx
	KGOlqDpRoCYGNWAw==
To: David Woodhouse <dwmw2@infradead.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Russell King <linux@armlinux.org.uk>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
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
 linux-csky@vger.kernel.org, "Ridoux, Julien" <ridouxj@amazon.com>, "Luu,
 Ryan" <rluu@amazon.com>, kvm <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 00/18] vDSO: Introduce generic data storage
In-Reply-To: <ff83dc5c91b4e46bcf2d99680ec6af250fb05b27.camel@infradead.org>
References: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
 <ff83dc5c91b4e46bcf2d99680ec6af250fb05b27.camel@infradead.org>
Date: Fri, 14 Feb 2025 12:34:44 +0100
Message-ID: <87ed00kbe3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David!

On Thu, Feb 06 2025 at 09:31, David Woodhouse wrote:
> Thanks for working on this. Is there a plan to expose the time data
> directly to userspace in a form which is usable *other* than by
> function calls which get the value of the clock at a given moment?
>
> For populating the vmclock device=C2=B9 we need to know the actual
> relationship between the hardware counter (TSC, arch timer, etc.) and
> real time in order to propagate that to the guest.
>
> I see two options for doing this:
>
>  1. Via userspace, exposing the vdso time data (and a notification when
>     it changes?) and letting the userspace VMM populate the vmclock.
>     This is complex for x86 because of TSC scaling; in fact userspace
>     doesn't currently know the precise scaling from host to guest TSC
>     so we'd have to be able to extract that from KVM.

Exposing the raw data is not going to happen as we would create an ABI
preventing any modifications to the internals. VDSO data is considered a
fully internal (think kernel) representation and the accessor functions
create an ABI around it. So if at all you can add a accessor function
which exposes data to user space so that the internal data
representation can still be modified as necessary.

>  2. In kernel, asking KVM to populate the vmclock structure much like
>     it does other pvclocks shared with the guest. KVM/x86 already uses
>     pvclock_gtod_register_notifier() to hook changes; should we expand
>     on that? The problem with that notifier is that it seems to be
>     called far more frequently than I'd expect.

It's called once per tick to expose the continous updates to the
conversion factors and related internal data.

Thanks,

        tglx


