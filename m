Return-Path: <linux-arch+bounces-7081-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B796E112
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33FB1C228A9
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3A1A38E1;
	Thu,  5 Sep 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QoO4qY6U"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCE1A2C2C
	for <linux-arch@vger.kernel.org>; Thu,  5 Sep 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557221; cv=none; b=dPmn+ECkR6CVaXb/PU6JSe8w+m4+nz2zDmQsMNbeJWFQGBqM2unJQ+ytYMLMY17EAlO48nHnkNAM7oxiCi9BAECER+oEwmhY4wO9rJZWuVIisHv541MgzbKW4/EPrQnd79zDLaBtD7TB+mf2std+ccxUyti/bzHAWkhgSNQjYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557221; c=relaxed/simple;
	bh=h9V6gwSALxoQh2n6tyi2ux0NqTNkpRulrrb7ZNYpQ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEmfno/hXH9Kg0SzfTuFu6w0epXM5PC4DgWfzzVfYuorklz2gjU/vYMOIiyr5xq6paeSfE3xUf0jtYL7JZmiICiXASaTSzkUDBkZZiXghLfDfNzr9KuC2xEnfbaew9GSWJDfm92tNWDrwoRGHlyL1cjEF8wUrfHmvYtHooovd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QoO4qY6U; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d87176316eso1658976a91.0
        for <linux-arch@vger.kernel.org>; Thu, 05 Sep 2024 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725557218; x=1726162018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzHtjVKsvMG2J+VEdT3JJ4mY+8euHciuRxZ037YJyIs=;
        b=QoO4qY6USsGxO5XvIoat2k65P6i4wxlRnTgjBvYfCtoLxebRI229jv5sogxj7RMGaP
         wxrIHBrZD9mDcWn0w7dzz9pGI7kNlnkBNwb2hkkp3g20x6j1ExOQmOZHA6mtxlLTDOxk
         VuqvFcbqqBjCuOgHu9KSBhCAmVTWPqLPf3J3++XMQ5BZvVoYJBk1S3NcFfMGRXNLV5kq
         AUgDvf3doF0EDUK9fYbA78HgRn8Tl5rhjAsCnxNQBjeSo8JRikhiBDhyUMk1Il9ljhKb
         UNIwPmlJ2sLZa03LVE5TjEVlS4Y/k5nXMF7NCjwacPbf0q0KnyNDIVuxMN4EmcjtWN+V
         cAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725557218; x=1726162018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzHtjVKsvMG2J+VEdT3JJ4mY+8euHciuRxZ037YJyIs=;
        b=hKBwaNkpx/5drlw27ihe24dEzRWiQJKLgVk3Sul1VTr+Oam2+qDRqWIVeRB5AZUM9r
         JR8wgFdjrqwOy7WwAsxif2Mt44D408k+FQoDejvT14rRpyr9kXL4snPEzXhgl29wO/pk
         n/qsVo+CbrOCgheTJjmcrMLB8JDB12j2lZISMJaEPIaMkhJwmZtJGo5j2Bwo0HGmnj8Z
         WciP43YPKVKoBMGJ9CvEDl5UvoSdRHbKGiYSSTL3Y71Eult53eJ5aqL9WUy4UzQP9RY6
         QUrCf2A1bexjy/PSy1/PGr9gocrzv4++eAU8wmC0QH4Zxib+yrZrvPgXf69Z0AQZsvd0
         uLqA==
X-Forwarded-Encrypted: i=1; AJvYcCWsB2PaUsILvfj5jvoxtRvqFtE8Eh4whV9cEf+8jK1wyeMAL6DxvYbNlJ6kc300beP8oOlshap3wl1G@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqt15JG3YS5EfOZzZwhVjHY7bmx5N+MvX1LTKJL8PWEkDyfcD
	dwrBKnOD8NhrURpYqSypJEVU+2ApjhadOZmpcLlvThpTh3RI5eqwOhRHt8yXP4E=
X-Google-Smtp-Source: AGHT+IFxrgWNtdxCWG0RBGHbyeqfO4T1K/TMURzEB4vAspGF/eaSh/6stCCkbbdo5V+yBGPBQxqCJA==
X-Received: by 2002:a17:90b:3d2:b0:2d8:9fbe:6727 with SMTP id 98e67ed59e1d1-2dad4f0e4damr67155a91.4.1725557218097;
        Thu, 05 Sep 2024 10:26:58 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da5932d1ecsm6506552a91.43.2024.09.05.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:26:57 -0700 (PDT)
Date: Thu, 5 Sep 2024 10:26:52 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <Ztnp3OAIRz/daj7s@ghost>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <yu7um2tcxg2apoz372rmzpkrfgbb42ndvabvrsp4usb2e3bkrf@huaucjsp5vlj>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yu7um2tcxg2apoz372rmzpkrfgbb42ndvabvrsp4usb2e3bkrf@huaucjsp5vlj>

On Thu, Sep 05, 2024 at 09:47:47AM +0300, Kirill A. Shutemov wrote:
> On Thu, Aug 29, 2024 at 12:15:57AM -0700, Charlie Jenkins wrote:
> > Some applications rely on placing data in free bits addresses allocated
> > by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> > address returned by mmap to be less than the 48-bit address space,
> > unless the hint address uses more than 47 bits (the 48th bit is reserved
> > for the kernel address space).
> > 
> > The riscv architecture needs a way to similarly restrict the virtual
> > address space. On the riscv port of OpenJDK an error is thrown if
> > attempted to run on the 57-bit address space, called sv57 [1].  golang
> > has a comment that sv57 support is not complete, but there are some
> > workarounds to get it to mostly work [2].
> > 
> > These applications work on x86 because x86 does an implicit 47-bit
> > restriction of mmap() address that contain a hint address that is less
> > than 48 bits.
> > 
> > Instead of implicitly restricting the address space on riscv (or any
> > current/future architecture), a flag would allow users to opt-in to this
> > behavior rather than opt-out as is done on other architectures. This is
> > desirable because it is a small class of applications that do pointer
> > masking.
> 
> This argument looks broken to me.
> 
> The "small class of applications" is going to be broken unless they got
> patched to use your new mmap() flag. You are asking for bugs.
> 
> Consider the case when you write, compile and validate a piece of software
> on machine that has <=47bit VA. The binary got shipped to customers.
> Later, customer gets a new shiny machine that supports larger address
> space and your previously working software is broken. Such binaries might
> exist today.
> 
> It is bad idea to use >47bit VA by default. Most of software got tested on
> x86 with 47bit VA.
> 
> We can consider more options to opt-in into wider address space like
> personality or prctl() handle. But opt-out is no-go from what I see.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

riscv is in an interesting state in regards to this because the software
ecosystem is much less mature than other architectures. The existing
riscv hardware supports either 38 or 47 bit userspace VAs, but a lot of
people test on QEMU which defaults to 56 bit. As a result, a lot of
code is tested with the larger address space. Applications that don't
work on the larger address space, like OpenJDK, currently throw an error
and exit.

Since riscv does not currently have the address space default to 47
bits, some applications just don't work on 56 bits. We could change the
kernel so that these applications start working without the need for
them to change their code, but that seems like the kernel is
overstepping and fixing binaries rather than providing users tools to
fix the binaries themselves.

This mmap flag was an attempt to provide a tool for these applications
that work on the existing 47 bit VA hardware to also work on different
hardware that supports a 56 bit VA space. After feedback, it looks like
a better solution than the mmap flag is to use the personality syscall
to set a process wide restriction to 47 bits instead, which matches the
32 bit flag that already exists.

- Charlie


