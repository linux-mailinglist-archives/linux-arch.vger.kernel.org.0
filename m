Return-Path: <linux-arch+bounces-7210-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE965975450
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAE51F26B4D
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8E1A7043;
	Wed, 11 Sep 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="oIPjnjA3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB21A4AD7;
	Wed, 11 Sep 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061939; cv=none; b=lrV6lA+84x6irTfCa+sDBKe9BcJDdXzwHPH+29fBYxo79EVf8oO9rh9agv+nT5a4nIITsD8Trte2T48VEdSRrDZBpDc88zEMnP6rGDqDNPO0nK4gCrspYHoplyS3l/nsIHk68YMjqq0vBn1bUKGmpQzaMevR5DW6jHf7lTZMDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061939; c=relaxed/simple;
	bh=TGjzub4d1zJGsXqoeyoF/a9/VWPt+phm9V/ukmlIKvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nflokhWwHGn6ZOzffYIrdvQ7AmA8P8YP4djrageOFwdQ7XWoo0KFaAdtGl5Krvp4VmlK0NcmOGlHGn4heAZN5eKJXImtd6o1s3qPhKCzLxM5GZpV5JIvt2XSwTClda0LjiYAb2uolNuS82suOOC2smyEKDO9wKPCTsNMIiJ8Gr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=oIPjnjA3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726061936;
	bh=/x6ppqNQQLzdvBUIltgwblDbEd/NsLYvkwyhRq8ySOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oIPjnjA38dDfnNUU0Rs/abozRGK9t9kzNcCWqs5zkrEw2u4QwGt3vFSpn0kotBm8X
	 fivnKpkEy/q9VIrQ4TVvIWeyCWERZBfrVvamUQzRqxJXXE/ps5sAChCuugQudut2zk
	 DVgLI54TE1CBwlW9mpADteXyPpiwyWh5AMK6K8+zAbXoPZkgJcSleQSG3qGcaJyJXX
	 A5ciDIpzEWsP5XUlIHYqj38DukHhKGL3HyneCvdybHcxtCNddxIqe5i6i2FP5wwBY7
	 57TlSw4u4a4SBXs0AeeOR/Okf9JAYihkTJfD71w2XroNa0syJ2Nx+YmIr7sD2bhmLV
	 DphJhs7LqH5rg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X3hVm0rPLz4x8Q;
	Wed, 11 Sep 2024 23:38:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge
 Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich
 Felker <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, Chris Torek
 <chris.torek@gmail.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
In-Reply-To: <CAMuHMdURgy6NPthHhfOv_h=C_gw2hEpnGQ7iBGoDE=ZazUPRHA@mail.gmail.com>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <87zfol468z.fsf@mail.lhotse> <Zt9HboH/PmPlRPmH@ghost>
 <1aca8e4c-1c12-4624-a689-147ff60b75d6@csgroup.eu>
 <CAMuHMdURgy6NPthHhfOv_h=C_gw2hEpnGQ7iBGoDE=ZazUPRHA@mail.gmail.com>
Date: Wed, 11 Sep 2024 23:38:55 +1000
Message-ID: <8734m6s428.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Christophe,
>
> On Tue, Sep 10, 2024 at 11:21=E2=80=AFAM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>> >>> diff --git a/include/uapi/linux/personality.h b/include/uapi/linux/p=
ersonality.h
>> >>> index 49796b7756af..cd3b8c154d9b 100644
>> >>> --- a/include/uapi/linux/personality.h
>> >>> +++ b/include/uapi/linux/personality.h
>> >>> @@ -22,6 +22,7 @@ enum {
>> >>>     WHOLE_SECONDS =3D         0x2000000,
>> >>>     STICKY_TIMEOUTS =3D       0x4000000,
>> >>>     ADDR_LIMIT_3GB =3D        0x8000000,
>> >>> +   ADDR_LIMIT_47BIT =3D      0x10000000,
>> >>>   };
>> >>
>> >> I wonder if ADDR_LIMIT_128T would be clearer?
>> >>
>> >
>> > I don't follow, what does 128T represent?
>>
>> 128T is 128 Terabytes, that's the maximum size achievable with a 47BIT
>> address, that naming would be more consistant with the ADDR_LIMIT_3GB
>> just above that means a 3 Gigabytes limit.
>
> Hence ADDR_LIMIT_128TB?

Yes it should be 128TB. Typo by me.

cheers

