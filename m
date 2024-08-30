Return-Path: <linux-arch+bounces-6836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150C1965473
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 03:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF349285703
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA61C6A3;
	Fri, 30 Aug 2024 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0zQsXLKq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3287F6
	for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980207; cv=none; b=EodUseicUjW2TjjbjvijMTglUnMpRsSfcw/lDA9TruKpWlOwoo+i+1ELICKFmmdXxg23qN1tnzBqk0RUV1WxgZZAGSfUI9U8YXyRd2u/r5XLXklwc9s4KQ0lBGTV40JhnRXHiwFnAbZAvu+PV0F3V7rCSd9pjiVp/9EIgDf83a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980207; c=relaxed/simple;
	bh=HZW4ajyimGkphse2tvktxCLLtKnAjNiIalW34p/EaqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8SdODQwGHNseC5cZtJkNpXITJcfyJ+4ld/y1vqTrJChdsFFxhXNcbXlBJMNRW4atVrXS2rRKIa3ycLsZ5VxQkGSxvzah2zfywYHRsrnIRjDIehdFvRJVmBAlOjTzBt1Wz6lGmqboPn1g1+Fujyuzz7s/VTu9g6XphGAfQYENIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0zQsXLKq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-714263cb074so982737b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724980205; x=1725585005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwoqNPnm0PFMKEw2mojvKZssW8GhVCDsDfQmuaD4p/M=;
        b=0zQsXLKq9eAp7bzdBb5T24xtEvQ57sKvIGE+OSizMF8Ct4/xvisjmAsyWNa4yj6pRN
         S3Z19pKhz9ADfvV2AWJFbqSYNp5merzeVnuCaJ5rx19BKUXO3ydd5jPSoeETlWU2F12e
         Dd1CcAyOFdlBJ7s72kCW9NM0qhf8ot899nQSNouHjhxOtm0A92rSmj8BqS8Dviou4fwD
         JsOtj4QkZkHnYmaxvnZhaUXEJhdYknZ6DhDHDozoWq0QAdYZZfFB6iWEyAtay5mte9TG
         quDPoSvlctM9U7bv0GxhMxnnEBUyZBl1yd1b1/4/aKO0GRY1s1ny4F+Br/5VA0lZPPA2
         3ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724980205; x=1725585005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwoqNPnm0PFMKEw2mojvKZssW8GhVCDsDfQmuaD4p/M=;
        b=Om9kKfLYrypDOEqzqylWV4dQNVXWlQrRc9mfLc5UHhzlDyZc/O/ZQg2Rw0asd8xiOV
         FBrPcRIMhkY/pa567kewhGntniySSLRrbCpiVgNnbBvZAM37Whb8DG/8amO2lz8Boyh0
         GsfeS7kMp6Wrr1xJX3TVQiA3S7NmxLwcWEvluiAI3d8UTlvcw4Rly4CJY3xrv3SsFppa
         Nwup/BIFh4o+ZT23srZXhUx229y2jQyM6mjW+MkXECaSZ2ylhIg9IX85Y6i6eS2AbgCp
         HWXdzPSbJfgxqh+/jgVGf+Ybga2HxhX3bKKTMsXyZ4fj+iG8vSW5bpdX//uUx7OQvl8T
         iRVg==
X-Forwarded-Encrypted: i=1; AJvYcCW0DrRZLXBRACde3lu93FVC1rTjUNL7aGHLCzunmeJCkQhLDKzER9CvOJZCI7y86P39oEDCggl0za6U@vger.kernel.org
X-Gm-Message-State: AOJu0YyrUV5jyypBqyIyaNENJJ4X3k9Xw/12PPY/Oe0vIuV+QKmtatrs
	SEQT+9dH3r+Q77k4J5p4rqPDen5TP/CmR7cpsM5KjAvG+zXrzRto+ZyZDIkf4fY=
X-Google-Smtp-Source: AGHT+IHjWR5hohyc19lNozH4CTnGNOicvRPszOH5PvlKyMQFSKFQKAXiGMUabKYrMEs/kL3dRfpZ8w==
X-Received: by 2002:a05:6a21:3943:b0:1c0:f216:7f20 with SMTP id adf61e73a8af0-1cce10ec619mr4946320637.49.1724980205096;
        Thu, 29 Aug 2024 18:10:05 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b1326sm17228115ad.35.2024.08.29.18.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 18:10:04 -0700 (PDT)
Date: Thu, 29 Aug 2024 18:10:00 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
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
	Shuah Khan <shuah@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/16] mm: Introduce MAP_BELOW_HINT
Message-ID: <ZtEb6EogqifmKrQU@ghost>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <fd1b8016-e73d-4535-9c67-579ab994351f@intel.com>
 <Zs+FYbII0ewwdisg@ghost>
 <4219f619-4b32-40bc-85b8-cb11d76fde98@intel.com>
 <pzxlpwxbrs3pali53bogsorwebi45ayqivxmpeagrhvdh7zt4u@ybsa2vnkze7v>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pzxlpwxbrs3pali53bogsorwebi45ayqivxmpeagrhvdh7zt4u@ybsa2vnkze7v>

On Thu, Aug 29, 2024 at 03:36:43PM -0400, Liam R. Howlett wrote:
> * Dave Hansen <dave.hansen@intel.com> [240829 12:54]:
> > On 8/28/24 13:15, Charlie Jenkins wrote:
> > > A way to restrict mmap() to return LAM compliant addresses in an entire
> > > address space also doesn't have to be mutually exclusive with this flag.
> > > This flag allows for the greatest degree of control from applications.
> > > I don't believe there is additionally performance saving that could be
> > > achieved by having this be on a per address space basis.
> > 
> > I agree with you in general.  The MAP_BELOW_HINT _is_ the most flexible.
> >  But it's also rather complicated.
> 
> There is a (seldom used?) feature of mmap_min_addr, it seems like we
> could have an mmap_max_addr.  Would something like that work for your
> use case?  Perhaps it would be less intrusive to do something in this
> way?  I haven't looked at it in depth and this affects all address
> spaces as well (new allocations only).
> 
> There is a note on mmap_min_addr about applications that require the
> lower addresses, would this mean we'll now have a note about upper
> limits?

I don't think that's a viable solution because that would change the
mmap behavior for all applications running on the system, and wouldn't
allow individual applications to have different configurations.

> 
> I really don't understand why you need this at all, to be honest.  If
> you know the upper limit you could just MAP_FIXED map a huge guard at
> the top of your address space then do whatever you want with those bits.
> 
> This will create an entry in the vma tree that no one else will be able
> to use, and you can do this in any process you want, for as many bits as
> you want.

Oh that's an interesting idea. I am not sure how that could work in
practice though. The application would need to know it allocated all of
the addresses in the upper address space, how would it be able to do
that?

> 
> > 
> > My _hope_ would be that a per-address-space property could share at
> > least some infrastructure with what x86/LAM and arm/TBI do to the
> > address space.  Basically put the restrictions in place for purely
> > software reasons instead of the mostly hardware reasons for LAM/TBI.
> > 
> > Lorenzo also raised some very valid points about a having a generic
> > address-restriction ABI.  I'm certainly not discounting those concerns.
> > It's not something that can be done lightly.
> 
> Yes, I am concerned about supporting this (probably forever) and dancing
> around special code that may cause issues, perhaps on an arch that few
> have for testing.  I already have so many qemu images for testing, some
> of which no longer have valid install media - and basically none of them
> use the same code in this area (or have special cases already).  I think
> you understand what we are dealing with considering your comments in
> your cover letter.

It is definitely not something to be taken lightly. The version 2 of
this is completely generic so that should eliminate most of the concern
of "special code" on various architectures. Unless I am misunderstanding
something.

- Charlie

> 
> Thanks,
> Liam

