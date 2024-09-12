Return-Path: <linux-arch+bounces-7226-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD0E97614F
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 08:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99781F218CF
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 06:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E5518BBA0;
	Thu, 12 Sep 2024 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IBwzBVm+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE818BBA1
	for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121902; cv=none; b=SFGTJjQXoIzy0IYUJjZBkZ7u7RGR+WQwe7ytsQ21Xs5Xa5yhttm5b9qs5y4pDzN07L3MXGeAtlBhFk0lH/mAfPQUznyvNORUtvmuKXINpqkffervYQsDD1uMFb0CiiEPRiXqxyxubxEJuOK+c0Oi0h7pSH5mHeFLLU+KUUT1y3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121902; c=relaxed/simple;
	bh=JXQ5stJy2yGFyhQM8tYpvYIBlea3Ge+wa2GDoDqdiSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy6rSr8XjnUclicF0t/3Qv1xHo7JLyCU5hek/aWpazmE5hvWQXIuqYs/Jb94fanju8i89THWXd0hGoZ8EA1/Ik3orrTlxbHIqbla768S6kQKOSWurDwI0LtIXQp3rAw5gycCmg7bVohR8wXNlJvmOfa2ErZFLlth+i3ojkU+R/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IBwzBVm+; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e05a5f21afso324234b6e.0
        for <linux-arch@vger.kernel.org>; Wed, 11 Sep 2024 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726121898; x=1726726698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MAcwRzdYBVGpQvvsotib//4T0Ptv25mGEFNsz8/kzr4=;
        b=IBwzBVm+Dy9DemXiT+1joiWwNQ4MpJ6HiprnZBhfp+qlwYCm1SZOS8UFwa0Ob/wPCW
         vdT0GLddrfPUul+3HWiREsrr1BVDND1R7IS3vT802MVi0qC8GIU4yHQ7GO4xm81KEdx9
         TjHA9HiBsqv3ofAFpygNDj+gVBPINMdydaIlxa7xXengpnJtRkikrnl6a/Eeb/ABae/w
         ks3IT3BnNHYp4r19IbvLouGn3n1x1WKFgjdl3Thz3Yk4xPuVmDxPGtMs1TmPEX/TLFcE
         VGAPF+76PBRlColfrY2Ua355B6uk/L1vuIEzKCB0wC54ruMA9wW79peGN+bPCNqw8pEJ
         omLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726121898; x=1726726698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAcwRzdYBVGpQvvsotib//4T0Ptv25mGEFNsz8/kzr4=;
        b=CTar6CTkgWv8QUkj5dRwbePnkq13ZPnZkLZf2OKy69cb+/jdU93A/d+gGIQsBQCZYS
         WAESpmeYVk0FxSy2eGxHbHNYtC5+aykwXvBdF/7RQfyJG1ei2K6+LJ6mFSuWbVWLeqMa
         W3PBD7GTSgjJw2WA4jlt+HFlSNLtO6lwkG/S5QIP+SjVNXyp9IQ0Bc42yrP9D/D4wklK
         1zc1YA7Wo4W7YnkroC0j8if/1Gc4DJnfoTV/dFF3Tp0iXpBAsi4D57XiqkIbVn+GyYsX
         3lNPXH30KD8a+bP6XKLvLtOoarJTJ1IcB8Fe9Fp4r64XudMiG27Hfi/bHQTGqcLS+H/L
         Hv9A==
X-Forwarded-Encrypted: i=1; AJvYcCU44N2PWUDDUj68WUSdHlWMESL5tZGCUo4tjePpvGPJSWV1/S1oZ6U6fJIeB2sJCU7Ha6sG7/sgE1gp@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMPk0zXcpwOHdweYIAjurbIvFEp5TGswOOlEoBFHetpe6ZQcS
	oMWlt4e75KSlf6pUITBSe9J73dmuz9TYZePEQmQSSvoAbHdbcmLPScdwKxtjaKM=
X-Google-Smtp-Source: AGHT+IH1u/BITj52DSA2KLJ5czFa7HaODYxdqRl9mmjp1F3evKXCtYQOfdJUyouLtu9doLCVCxJHIA==
X-Received: by 2002:a05:6870:910f:b0:277:eb68:2878 with SMTP id 586e51a60fabf-27c3f6a6e6emr1295326fac.44.1726121898162;
        Wed, 11 Sep 2024 23:18:18 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:7acc:9910:2c1d:4e65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190f888a78sm3692711b3a.140.2024.09.11.23.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 23:18:17 -0700 (PDT)
Date: Wed, 11 Sep 2024 23:18:12 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, guoren <guoren@kernel.org>,
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
Message-ID: <ZuKHpFB+uWuJe2xm@ghost>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
 <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
 <ZuDoExckq21fePoe@ghost>
 <ZuHfp0_tAQhaymdy@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuHfp0_tAQhaymdy@arm.com>

On Wed, Sep 11, 2024 at 07:21:27PM +0100, Catalin Marinas wrote:
> On Tue, Sep 10, 2024 at 05:45:07PM -0700, Charlie Jenkins wrote:
> > On Tue, Sep 10, 2024 at 03:08:14PM -0400, Liam R. Howlett wrote:
> > > * Catalin Marinas <catalin.marinas@arm.com> [240906 07:44]:
> > > > On Fri, Sep 06, 2024 at 09:55:42AM +0000, Arnd Bergmann wrote:
> > > > > On Fri, Sep 6, 2024, at 09:14, Guo Ren wrote:
> > > > > > On Fri, Sep 6, 2024 at 3:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > >> It's also unclear to me how we want this flag to interact with
> > > > > >> the existing logic in arch_get_mmap_end(), which attempts to
> > > > > >> limit the default mapping to a 47-bit address space already.
> > > > > >
> > > > > > To optimize RISC-V progress, I recommend:
> > > > > >
> > > > > > Step 1: Approve the patch.
> > > > > > Step 2: Update Go and OpenJDK's RISC-V backend to utilize it.
> > > > > > Step 3: Wait approximately several iterations for Go & OpenJDK
> > > > > > Step 4: Remove the 47-bit constraint in arch_get_mmap_end()
> 
> Point 4 is an ABI change. What guarantees that there isn't still
> software out there that relies on the old behaviour?

Yeah I don't think it would be desirable to remove the 47 bit
constraint in architectures that already have it.

> 
> > > > > I really want to first see a plausible explanation about why
> > > > > RISC-V can't just implement this using a 47-bit DEFAULT_MAP_WINDOW
> > > > > like all the other major architectures (x86, arm64, powerpc64),
> > > > 
> > > > FWIW arm64 actually limits DEFAULT_MAP_WINDOW to 48-bit in the default
> > > > configuration. We end up with a 47-bit with 16K pages but for a
> > > > different reason that has to do with LPA2 support (I doubt we need this
> > > > for the user mapping but we need to untangle some of the macros there;
> > > > that's for a separate discussion).
> > > > 
> > > > That said, we haven't encountered any user space problems with a 48-bit
> > > > DEFAULT_MAP_WINDOW. So I also think RISC-V should follow a similar
> > > > approach (47 or 48 bit default limit). Better to have some ABI
> > > > consistency between architectures. One can still ask for addresses above
> > > > this default limit via mmap().
> > > 
> > > I think that is best as well.
> > > 
> > > Can we please just do what x86 and arm64 does?
> > 
> > I responded to Arnd in the other thread, but I am still not convinced
> > that the solution that x86 and arm64 have selected is the best solution.
> > The solution of defaulting to 47 bits does allow applications the
> > ability to get addresses that are below 47 bits. However, due to
> > differences across architectures it doesn't seem possible to have all
> > architectures default to the same value. Additionally, this flag will be
> > able to help users avoid potential bugs where a hint address is passed
> > that causes upper bits of a VA to be used.
> 
> The reason we added this limit on arm64 is that we noticed programs
> using the top 8 bits of a 64-bit pointer for additional information.
> IIRC, it wasn't even openJDK but some JavaScript JIT. We could have
> taught those programs of a new flag but since we couldn't tell how many
> are out there, it was the safest to default to a smaller limit and opt
> in to the higher one. Such opt-in is via mmap() but if you prefer a
> prctl() flag, that's fine by me as well (though I think this should be
> opt-in to higher addresses rather than opt-out of the higher addresses).

The mmap() flag was used in previous versions but was decided against
because this feature is more useful if it is process-wide. A
personality() flag was chosen instead of a prctl() flag because there
existed other flags in personality() that were similar. I am tempted to
use prctl() however because then we could have an additional arg to
select the exact number of bits that should be reserved (rather than
being fixed at 47 bits).

Opting-in to the higher address space is reasonable. However, it is not
my preference, because the purpose of this flag is to ensure that
allocations do not exceed 47-bits, so it is a clearer ABI to have the
applications that want this guarantee to be the ones setting the flag,
rather than the applications that want the higher bits setting the flag.

- Charlie

> 
> -- 
> Catalin




