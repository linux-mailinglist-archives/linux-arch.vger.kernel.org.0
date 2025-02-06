Return-Path: <linux-arch+bounces-10042-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CDA2A6A4
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 12:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3900F1889860
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB1218EA8;
	Thu,  6 Feb 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YGZTZnxX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gSo8yfFy"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2E2288EC;
	Thu,  6 Feb 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839605; cv=none; b=QpxMT13luwscfuRBNXqs+61Z6pk4AbMiBx+FsYQyetuz0uu+HoQqMg6Wdjj6eUbkHeq78WVJGMlvIO4GznmJ1M7kVe31U3EzV0AkWIlEZ1P4QRt93Qkx1QI2y7DfTI7JH+wXcKAgjhHrh6wkmXJEl48oFnQCqPBSyI5fi1sMrbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839605; c=relaxed/simple;
	bh=xQ1t5p/G1PuTyMUQl7uec82DUkXuAxu+nr72fhZ0FqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L34PNd4Pms0OpTc29xkdbMK8Bhe5NuvGv/i4Hj0C7t/PkC/LSHDxAPwDlxWPfK2W+YYGa7Q1kOo5N8njwZUMipUcMNVloauY0W0CyWyj9khsSh6p5U8DeFeuMY0iu8MUitDzQSZeuOn0PW6RzTMuxuShbCDVAqvtiPocyGKr5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YGZTZnxX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gSo8yfFy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Feb 2025 11:59:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738839601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ru5WdIbpSL0IOKGQMyXAT/ZbwjxtTCZKvCRArp1oQDE=;
	b=YGZTZnxXjpdI6oZKS05b+5XvnP+boGHN1C9QVygV7IAjLA8pAEovdmFAH8xFn7WI+w/Xhp
	8K+GjBJMH0JXK40pNxioacxcseFzn+iXVx4WoYt+J0VaxAt6ID0MNK8tJHkPrEinPnHwJG
	q7T7uflCus2GZC60/Vo9hxiLt7lbmMt3uhYS5TbYuilZ8s9n9kIooocVm9DSgR45+vozV8
	mKs7HvnUnL+HLLe1fD2OiCIYZL6f6ix3Bee88IjX4iDMFE94To0mtXdotTD+DhoAabPdO5
	+hTLhUwkR8YuE1I+6rX+payvbnygcsEtyByLEI0nCsLk7XsBFKKaA2MPCL7vew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738839601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ru5WdIbpSL0IOKGQMyXAT/ZbwjxtTCZKvCRArp1oQDE=;
	b=gSo8yfFya9Ajm2CmxNsGxQ1eCLyB3wbR/PEUj366khtBpyQwoXLrVFgUwGilu8dL/eMyJd
	VQWqN9SewyqCZ4BQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, 
	Nam Cao <namcao@linutronix.de>, linux-csky@vger.kernel.org, 
	"Ridoux, Julien" <ridouxj@amazon.com>, "Luu, Ryan" <rluu@amazon.com>, kvm <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 00/18] vDSO: Introduce generic data storage
Message-ID: <20250206110648-ec4cf3d0-0aef-4feb-a859-c69e53ab110c@linutronix.de>
References: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
 <ff83dc5c91b4e46bcf2d99680ec6af250fb05b27.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff83dc5c91b4e46bcf2d99680ec6af250fb05b27.camel@infradead.org>

On Thu, Feb 06, 2025 at 09:31:42AM +0000, David Woodhouse wrote:
> On Tue, 2025-02-04 at 13:05 +0100, Thomas Weißschuh wrote:
> > Currently each architecture defines the setup of the vDSO data page on
> > its own, mostly through copy-and-paste from some other architecture.
> > Extend the existing generic vDSO implementation to also provide generic
> > data storage.
> > This removes duplicated code and paves the way for further changes to
> > the generic vDSO implementation without having to go through a lot of
> > per-architecture changes.
> > 
> > Based on v6.14-rc1 and intended to be merged through the tip tree.

Note: The real answer will need to come from the timekeeping
maintainers, my personal two cents below.

> Thanks for working on this. Is there a plan to expose the time data
> directly to userspace in a form which is usable *other* than by
> function calls which get the value of the clock at a given moment?

There are no current plans that I am aware of.

> For populating the vmclock device¹ we need to know the actual
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

Exposing the raw vdso time data is problematic as it precludes any
evolution to its datastructures, like the one we are currently doing.

An additional, trimmed down and stable data structure could be used.
But I don't think it makes sense. The vDSO is all about a stable
highlevel function interface on top of an unstable data interface.
However the vmclock needs the lowlevel data to populate its own
datastructure, wrapping raw data access in function calls is unnecessary.
If no functions are involved then the vDSO is not needed. The data can
be maintained separately in any other place in the kernel and accessed
or mapped by userspace from there.
Also the vDSO does not have an active notification mechanism, this would
probably be implemented through a filedescriptor, but then the data
can also be mapped through exactly that fd.

>  2. In kernel, asking KVM to populate the vmclock structure much like
>     it does other pvclocks shared with the guest. KVM/x86 already uses
>     pvclock_gtod_register_notifier() to hook changes; should we expand
>     on that? The problem with that notifier is that it seems to be
>     called far more frequently than I'd expect.

This sounds better, especially as any custom ABI from the host kernel to
the VMM would look a lot like the vmclock structure anyways.

Timekeeper updates are indeed very frequent, but what are the concrete
issues? That frequency is fine for regular vDSO data page updates,
updating the vmclock data page should be very similar.
The timekeeper core can pass context to the notifier callbacks, maybe
this can be used to skip some expensive steps where possible.

> ¹ https://gitlab.com/qemu-project/qemu/-/commit/3634039b93cc5

