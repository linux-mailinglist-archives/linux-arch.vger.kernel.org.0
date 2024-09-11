Return-Path: <linux-arch+bounces-7211-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB21A975482
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFDA1F277BD
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275619E987;
	Wed, 11 Sep 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="b6rCWOCp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A019C563;
	Wed, 11 Sep 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062613; cv=none; b=uX14mTqLDF79qFU3SK8PlNr8IVfTmHTGbhORtarw0S6rbmxXqipBFb1KDxTFuXwFVFNizbWKrCoy+FEzni8MVfKIN7VtnE+WKHS2XnAgPWmH723dyyNkJI6e2/aNW/2MjWAn6cecadMIqcnprACPYlOdvjMeEDhuz1JLnzHkGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062613; c=relaxed/simple;
	bh=PrFjse7wa9r7BLbYlfJSIri5+7sSsF6OSOZIIGlgpL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=il02RxYHdtQw38fKeurReB7ft2prSarjmtvpLfPI7cXnUnURCZ6/vONv4YN2QKKtNvXEegjlT+b6IlPCZLIun0GvmnkAsH4EW72o87Coj0cz2W3GlnpIQ+DZWTQSMYh/LKzctbjHwPKxdmktZSLfYa2rgmUctwjdHo68arD9z74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=b6rCWOCp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726062608;
	bh=lpBzbgWttHYkkQ41sscZ0OOoe2UyQs048+I1EnGEnbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b6rCWOCpsR6QTZU68icEH6ah28jcqnXyKEGoUH0ohvJRhp/Mm3QMMNf7cz1PRZVJk
	 qZnhrbEZQSdtE52b5m7L8yLtR87aHqZ9Y3U05UdXnLFYWT6W/Gva4cteQod4+pDscF
	 iq9WFey+WYHFyzKGuoKHndEZ0KUL/iVZ82dFsXKNk1jKIZA3FOkaV87mvcYAUlbhmC
	 QSm0f+2sovoKzmv6FOXBVgqAL9iWpzg6XychwCtrVghD79R/XByY5tXAMuIaTpHV5g
	 0oMsPLM4pI21UqirAlt8h43LH7OPXzxNCN5RDMbPbQlnnQRUFay141JPyB1XvhsCzO
	 l8YWjW9+O5+hg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X3hlf1JyWz4x8D;
	Wed, 11 Sep 2024 23:50:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Charlie Jenkins <charlie@rivosinc.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, guoren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge
 Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, shuah
 <shuah@kernel.org>, Christoph Hellwig <hch@infradead.org>, Michal Hocko
 <mhocko@suse.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Chris
 Torek <chris.torek@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
In-Reply-To: <89d21669-8daa-4225-b6d2-33d439ebd746@app.fastmail.com>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <58f39d58-579e-4dd3-8084-baebf86f1ae0@lucifer.local>
 <7be08ea9-f343-42da-805f-e5f0d61bde26@app.fastmail.com>
 <016c7857-9ea8-4333-96e6-3ae3870f375f@lucifer.local>
 <Zt+DGHZrHFxfq7xo@ghost>
 <89d21669-8daa-4225-b6d2-33d439ebd746@app.fastmail.com>
Date: Wed, 11 Sep 2024 23:50:05 +1000
Message-ID: <87zfoeqoz6.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:
> On Mon, Sep 9, 2024, at 23:22, Charlie Jenkins wrote:
>> On Fri, Sep 06, 2024 at 10:52:34AM +0100, Lorenzo Stoakes wrote:
>>> On Fri, Sep 06, 2024 at 09:14:08AM GMT, Arnd Bergmann wrote:
>>> The intent is to optionally be able to run a process that keeps higher bits
>>> free for tagging and to be sure no memory mapping in the process will
>>> clobber these (correct me if I'm wrong Charlie! :)
...
> Let's see what the other architectures do and then come up with
> a way that fixes the pointer tagging case first on those that are
> broken. We can see if there needs to be an extra flag after that.
> Here is what I found:
>
> - x86_64 uses DEFAULT_MAP_WINDOW of BIT(47), uses a 57 bit
>   address space when an addr hint is passed.
> - arm64 uses DEFAULT_MAP_WINDOW of BIT(47) or BIT(48), returns
>   higher 52-bit addresses when either a hint is passed or
>   CONFIG_EXPERT and CONFIG_ARM64_FORCE_52BIT is set (this
>   is a debugging option)
> - ppc64 uses a DEFAULT_MAP_WINDOW of BIT(47) or BIT(48),
>   returns 52 bit address when an addr hint is passed
   
It's 46 or 47 depending on PAGE_SIZE (4K or 64K):

  $ git grep "define DEFAULT_MAP_WINDOW_USER64" arch/powerpc/include/asm/task_size_64.h
  arch/powerpc/include/asm/task_size_64.h:#define DEFAULT_MAP_WINDOW_USER64        TASK_SIZE_128TB
  arch/powerpc/include/asm/task_size_64.h:#define DEFAULT_MAP_WINDOW_USER64        TASK_SIZE_64TB

cheers

