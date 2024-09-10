Return-Path: <linux-arch+bounces-7199-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 668B1974667
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 01:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF6B1F26E85
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194981ABEDB;
	Tue, 10 Sep 2024 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZFCdnhyn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DBC1AC8A2
	for <linux-arch@vger.kernel.org>; Tue, 10 Sep 2024 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010960; cv=none; b=K7Azw3pCiA4YhUsYe6mcQ2MHQilEaC0LEbve4C4VJbzhU1J4+ausXY3SHki6zdVU/MwyICiPGwWGLBSO4W2ct3tXCRhofknnBIVnrRUuE36YXp+NSYpdl1FrLHtvPlE1HZBdD71tvkKzVaZBY8d2IdmknEgYhFIYNvzol5mPQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010960; c=relaxed/simple;
	bh=EaQYpDu4fd+dR1oVIB+uyEjjvPPcoakUS8tLH3tLHH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3SJ8SEaqYKPeIMzRCTWIfG9dtPasZLEBzcRjSgTqbilO1IgJWoPP+cHE4vkozJRxynZYnlSH80MkcFKtWw5LP0O1CFClejpd/o+qx6NHOkVqcastmjO1NX21VltuXuxfeK9XB69HpV3MliNIrjDsYehd71IncBoRAk3Og8b82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZFCdnhyn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3928447a12.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Sep 2024 16:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726010957; x=1726615757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYrCbXlvqV0+h/8xybyAavYRRnIQ4hnNCNmZGJwr9QU=;
        b=ZFCdnhynOTrA0VNAj+06D67XGpi+QeyXqLiL/hiUAXv67amrykjDWYLm3rdZ/DfLF+
         i2W8eOgzHMQLu6twHwprTjL011qP+c2fEaq1Qk1tOLrspv80Vs5ZrR/st4toqDZ7lQn9
         h92KVaI72TZSRmNV5pCW70nXO0ahHpFV2Ps0fQONeveAnWo1A0skKjU4ANtN/wh8l3PP
         uFRBhpgv/rn7MtpbjsJqQhWmDXJLyPRTiluzGA7Fw2ZWv16B+G46U8oim3yGuOUvuclP
         3SHrZsRdGkTG0F5xgo46lxFvUChIwP8qMrMkutm/1MT0zsdhmjYq8qFA3VHead8ZZEwm
         e31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726010957; x=1726615757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYrCbXlvqV0+h/8xybyAavYRRnIQ4hnNCNmZGJwr9QU=;
        b=WsHrIsVAtX9sl371/5CCeOaqgQdWWNsI3QMh+o1ssiik8akmgEgi3+Y7RryWdgyX8w
         BSkwWC2IVYSU2oTzx6lOSvYEFLPmV5C0MdIj3PsH3g4IoVcK/31kshMix9xDbuDnt2hG
         P0GoQeIc4+WXRJDphDJZ/BTn1oyWbRgfJnTG5u8NHRIe/XVL9qecXqfkgnk2Ug5lkYRF
         9UKnV6wl6IeESXnffScIB3tYp9g1rWTR5q+K7CVturwLoYZ7SbOMIYAXAf6H2Ibyszt2
         KX7jomvbXt0ruRTalTnv940BEvScHc39PuMX3GopQ+7ZxFinPFLBLki3EtV4n1m330iT
         DPzw==
X-Forwarded-Encrypted: i=1; AJvYcCVcGq1OilpxhjKwfXYG4zDQPSzrYd+IJosDh430zCdXeTAsvWMFdhICIRzYJf0b635P6dy22m61/nXX@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnh5qauJig47KlB8KuciJNTTXO3FNBnkVkvl6GB5RN/LgxA6N
	c3QmTfGwpBtclAJiiUuAP2odkLBoVV2N4euiNvxCwvaGFlZ5NEBkzm1qC5PKDeQ=
X-Google-Smtp-Source: AGHT+IFu2ts9QR3o7HId+sTbARvp/Mp4cS7y9d4XxkhhKVfZnTlnktrEfIJSlLrlAVGi3hD8KRDoUg==
X-Received: by 2002:a05:6a21:3318:b0:1cc:e4a9:9138 with SMTP id adf61e73a8af0-1cf5e10ea44mr2924283637.29.1726010956374;
        Tue, 10 Sep 2024 16:29:16 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe2641sm1873651b3a.59.2024.09.10.16.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 16:29:15 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:29:10 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, guoren <guoren@kernel.org>,
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, shuah <shuah@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <ZuDWRq+9b1o864vY@ghost>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <58f39d58-579e-4dd3-8084-baebf86f1ae0@lucifer.local>
 <7be08ea9-f343-42da-805f-e5f0d61bde26@app.fastmail.com>
 <016c7857-9ea8-4333-96e6-3ae3870f375f@lucifer.local>
 <Zt+DGHZrHFxfq7xo@ghost>
 <89d21669-8daa-4225-b6d2-33d439ebd746@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d21669-8daa-4225-b6d2-33d439ebd746@app.fastmail.com>

On Tue, Sep 10, 2024 at 09:13:33AM +0000, Arnd Bergmann wrote:
> On Mon, Sep 9, 2024, at 23:22, Charlie Jenkins wrote:
> > On Fri, Sep 06, 2024 at 10:52:34AM +0100, Lorenzo Stoakes wrote:
> >> On Fri, Sep 06, 2024 at 09:14:08AM GMT, Arnd Bergmann wrote:
> >> The intent is to optionally be able to run a process that keeps higher bits
> >> free for tagging and to be sure no memory mapping in the process will
> >> clobber these (correct me if I'm wrong Charlie! :)
> >> 
> >> So you really wouldn't want this if you are using tagged pointers, you'd
> >> want to be sure literally nothing touches the higher bits.
> 
> My understanding was that the purpose of the existing design
> is to allow applications to ask for a high address without having
> to resort to the complexity of MAP_FIXED.
> 
> In particular, I'm sure there is precedent for applications that
> want both tagged pointers (for most mappings) and untagged pointers
> (for large mappings). With a per-mm_struct or per-task_struct
> setting you can't do that.
> 
> > Various architectures handle the hint address differently, but it
> > appears that the only case across any architecture where an address
> > above 47 bits will be returned is if the application had a hint address
> > with a value greater than 47 bits and was using the MAP_FIXED flag.
> > MAP_FIXED bypasses all other checks so I was assuming that it would be
> > logical for MAP_FIXED to bypass this as well. If MAP_FIXED is not set,
> > then the intent is for no hint address to cause a value greater than 47
> > bits to be returned.
> 
> I don't think the MAP_FIXED case is that interesting here because
> it has to work in both fixed and non-fixed mappings.
> 
> >> This would be more consistent vs. other arches.
> >
> > Yes riscv is an outlier here. The reason I am pushing for something like
> > a flag to restrict the address space rather than setting it to be the
> > default is it seems like if applications are relying on upper bits to be
> > free, then they should be explicitly asking the kernel to keep them free
> > rather than assuming them to be free.
> 
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
> - riscv uses a DEFAULT_MAP_WINDOW of BIT(47) but only uses
>   it for allocating the stack below, ignoring it for normal
>   mappings
> - s390 has no DEFAULT_MAP_WINDOW but tried to allocate in
>   the current number of pgtable levels and only upgrades to
>   the next level (31, 42, 53, 64 bits) if a hint is passed or
>   the current level is exhausted.
> - loongarch64 has no DEFAULT_MAP_WINDOW, and a default VA
>   space of 47 bits (16K pages, 3 levels), but can support
>   a 55 bit space (64K pages, 3 levels).
> - sparc has no DEFAULT_MAP_WINDOW and up to 52 bit VA space.
>   It may allocate both positive and negative addresses in
>   there. (?)
> - mips64, parisc64 and alpha have no DEFAULT_MAP_WINDOW and
>   at most 48, 41 or 39 address bits, respectively.
> 
> I would suggest these changes:
> 
> - make riscv enforce DEFAULT_MAP_WINDOW like x86_64, arm64
>    and ppc64, leave it at 47
> 
> - add DEFAULT_MAP_WINDOW on loongarch64 (47/48 bits
>   based on page size), sparc (48 bits) and s390 (unsure if
>   42, 53, 47 or 48 bits)
> 
> - leave the rest unchanged.
> 
>        Arnd

Changing all architectures to have a standardized DEFAULT_MAP_WINDOW
mostly solves the problem. However, I am concerned that it is fragile
for applications to rely on a default like this. Having the personality
bit flag is supposed to provide an intuitive ABI for users that
guarantees that they will not accidentally request for memory outside of
the boundary that they specified.

Also you bring up that the DEFAULT_MAP_WINDOW would not be able to be
standardized across architectures, so we still have the problem that
this default behavior will be different across architectures which I am
trying to solve.

- Charlie


