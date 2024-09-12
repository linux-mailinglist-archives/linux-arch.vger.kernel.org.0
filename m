Return-Path: <linux-arch+bounces-7225-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DD29760F7
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 08:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D571C22D60
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 06:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A87F18BB86;
	Thu, 12 Sep 2024 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sHsSO+rK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47A54765
	for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121215; cv=none; b=bL/j51XRxTVxrBDEDEMTeLWU/M2w9NOX4vW3s7vU2KGrcwQydP3E9mdh1C/rDsixIzcL2RggblP+Vbe/IfiHTQok2zY0o2tnJfloxf+X8XdHeJiM4MICTrG54WzSjaKvMO4EUAM/TcQjAOoqqiLAB30a4OtqHUPwIZkbVKLvhQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121215; c=relaxed/simple;
	bh=8VMhfxsEEjCM7EFz4nzoCAQ/THTIdB3CL+j9lCXOfzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc4CNdG9tYoVB9aLW/VsxSwdlKrvX4BGWTcz4bsFzz3z+XuQmhgQfEOJnEsidx15OdqnxKlZ886GXLl7NVQ3WKa9qaKSP6FcvI3gDNzhLcBOjmIUpD8sXnh34t43ikY8PRAYnzuCzylNVC2yguKNe79yEC6IBhvhsknsNDcd4UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sHsSO+rK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2055136b612so8467985ad.0
        for <linux-arch@vger.kernel.org>; Wed, 11 Sep 2024 23:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726121213; x=1726726013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDJaA5Y9npfkWPEOnJeHdGlQ/o0X1HQ/Q2gtdhbnZuk=;
        b=sHsSO+rK7CTiNGyLTpsJZ39HJF79f/aHJJY9TFeKQaIer2XQuta/PiHqq58T+rt3Jd
         PqCrT7qQ6QT9I1BL5oTM2QD/le3wRhD6eh8fhsORmer2nTrR3TA+ollYTPqY6Ywmm1iy
         QoxaayWksxyI8fzzi2PCtgKWfsWqUf8DmJC0EZ4AOsQJkAC00mzAiD61s7IjA2UEjPit
         GQ6WqXF/KPmM+AcBcWOBNv5lAZq1gX4K0SxuWudQrjeYu5hVoomTBSq7NOwHRVlLYNmo
         QjX7Vl6fcshxwc4DTahTqtQuQtXNzVB1NvRH0jX8qZPe8+0/4QFrZB3HQ0EAM8ZS/TZA
         3HCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726121213; x=1726726013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDJaA5Y9npfkWPEOnJeHdGlQ/o0X1HQ/Q2gtdhbnZuk=;
        b=aLpU5QdOcyhZtGX+hpY2nECDHgwQVNYiRJclmIpU9X+FFaXsEuleU8kjTgWtpSNvqu
         Zn1sKy6Ejuks6oretAOHoiFvs3mK8tGwa14HAys1DFcNVWfJwyHj0DFmXdLi7gljw5E0
         KYeaAGgVW+ikc0uTf5vMakMB4Q0s4XcssBYUNKEoF81P8pvm6FMWp/YqlDw4fqjC3HN5
         rp0/hflUc3PjCe9bcqQ0JUW3rxYDH7sBvhTpaGJmIUf8/YoPX5UEH6VVZT7Ra8TqLJUI
         O6FGaWBwQgvchmbEanCKqyrU7y5hbyyWfSfR+B/Uv346kWHcdfQn83pvy1mpM2fJwZlj
         ZNxw==
X-Forwarded-Encrypted: i=1; AJvYcCWdmS5qshADes5PS1RhqKRYqkhwzjGEwmyu0QY9O9OPLJL7Fb+79Hay9CL2r37pFFsAwGMAEqsaAk23@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAqLmBwPoaxoHwsGPsLD8N3TOcBd9ghEI58Dln2ULhILeiygk
	lMv9X7yVRmgl8qM5iTlomxvI1jWMGjcFf6fK9AMoiZWJln6zFjUHr09JtMAe02s=
X-Google-Smtp-Source: AGHT+IGKXy/6JapHeAVjChHUI6qH3tbjA0GPIxSDVxSa+LImRNXpcKvZ6AKB4gkH/Tg4GRKQ5PFIHQ==
X-Received: by 2002:a17:902:d2ca:b0:206:c2f4:afb7 with SMTP id d9443c01a7336-2076e36db8cmr23914475ad.26.1726121212752;
        Wed, 11 Sep 2024 23:06:52 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:7acc:9910:2c1d:4e65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01a39esm8052185ad.287.2024.09.11.23.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 23:06:52 -0700 (PDT)
Date: Wed, 11 Sep 2024 23:06:46 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	guoren <guoren@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	shuah <shuah@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Chris Torek <chris.torek@gmail.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
Message-ID: <ZuKE9nnNGR/5fHh/@ghost>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
 <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
 <ZuDoExckq21fePoe@ghost>
 <8130e50c-01e2-45c3-a516-45f5499311f2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8130e50c-01e2-45c3-a516-45f5499311f2@app.fastmail.com>

On Wed, Sep 11, 2024 at 07:25:08AM +0000, Arnd Bergmann wrote:
> On Wed, Sep 11, 2024, at 00:45, Charlie Jenkins wrote:
> > On Tue, Sep 10, 2024 at 03:08:14PM -0400, Liam R. Howlett wrote:
> >
> > I responded to Arnd in the other thread, but I am still not convinced
> > that the solution that x86 and arm64 have selected is the best solution.
> > The solution of defaulting to 47 bits does allow applications the
> > ability to get addresses that are below 47 bits. However, due to
> > differences across architectures it doesn't seem possible to have all
> > architectures default to the same value. Additionally, this flag will be
> > able to help users avoid potential bugs where a hint address is passed
> > that causes upper bits of a VA to be used.
> >
> > The other issue I have with this is that if there is not a hint address
> > specified to be greater than 47 bits on x86, then mmap() may return an
> > address that is greater than 47-bits. The documentation in
> > Documentation/arch/x86/x86_64/5level-paging.rst says:
> >
> > "If hint address set above 47-bit, but MAP_FIXED is not specified, we try
> > to look for unmapped area by specified address. If it's already
> > occupied, we look for unmapped area in *full* address space, rather than
> > from 47-bit window."
> 
> This is also in the commit message of b569bab78d8d ("x86/mm: Prepare
> to expose larger address space to userspace"), which introduced it.
> However, I don't actually see the fallback to the full address space,
> instead the actual behavior seems to be the same as arm64.
> 
> Am I missing something in the x86 implementation, or do we just
> need to update the documentation?
> 
>       Arnd

Yeah I guess it is incorrect documentation then? It seems more
reasonable to me to have a hint address fall back onto the larger
address space because otherwise the "hint" address can cause allocations
to fail even if there is space above the 47-bit limit. This is another
reason I wanted to avoid having this default behavior on riscv, to not
have this abuse of the hint address.

- Charlie


