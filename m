Return-Path: <linux-arch+bounces-9808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098CA1530B
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 16:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868EE166EC4
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808C113D897;
	Fri, 17 Jan 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJsPsA6N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA01422A8;
	Fri, 17 Jan 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128686; cv=none; b=HR/mw65jw9g9laJetQaIFV4kGW2Pkmda/M5dezeSn/nZY9PV9w92IUC+rOoAiSLW9KsyjmbxmKsf6gfjC/3FmA5GTbrMxijePH0ksRlnjU9CZu9TbgWNPo9eOtd/EjIJjZWLY1FFF1okOoLO0/u8UynZl36qLsvL9exIHCwLjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128686; c=relaxed/simple;
	bh=2eYFLaWM2SV5SCMr09KRtCDPcssaE0WkpCl80N1bTio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuaRNIehX3J6WrCfKuO2fAL79XxcHTKU0WMsmU6ae/jZXTjZ2sHw02u8qjcBp18OrtWhfB22IVQprbyWIDDY6PqHaeE/NCN+QsO9W170V6YSkJY9oDXmPfl9KR8KbxUOjGXgusfiHGJrNDB9V2eRJHgTYQNC4N8PxHCx5Nn93yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJsPsA6N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso3235422a91.2;
        Fri, 17 Jan 2025 07:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737128683; x=1737733483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whHgpC9NdP83/YfvPy6m/Zm1/eSoIWGpN2YA1mG9PX0=;
        b=SJsPsA6NgpdpQU3sHawKFIkhbEkgjc0popnkz6r9alKNiKe1JYWIb/111hQATcV+M8
         LQUU0DL1TvzNwEBLahOpJEbHCGaQ2SopmuFfV41VpllRDcusoj+CuXcL9kNk0BxeOfhc
         cfBLX0XRBEIglW59nUq7Anj4LQSqVkJlFZAWgKA11OHD+2W1M5QKR5cMyMaEmX8M2Ejz
         Is3nNS8x/0U6ULvix3mXdeUxPCgycjLvKIvfxvSt3EpMnsm+1OaO+CgHXr835lG6POGz
         7TKvTseqJBod4EsSICmdUA3x5KK8pgjeADcl0IzSLr/ykqw6hr4ZJFj1KkKvZBuRTVxr
         4dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737128683; x=1737733483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whHgpC9NdP83/YfvPy6m/Zm1/eSoIWGpN2YA1mG9PX0=;
        b=T37RjqaH5Rd17lv5zCNwBP5LcjBPCcEyq9h80Y1titSHjSYv/4a7h8cWu4J1NiUo2Q
         tnfBnd2KAs9CuAXOJ1aBFmDYgYepA7m+Keg5kdZSTlxaejL17caFIQ+lQ6H3XH4NFJcD
         mFmlTc7FOCCcWWiMFcnk7UQwdQwDOLFIDWxdxJ1JdfGGp8xyhFNwcFjW0gu0GAwpJzXb
         7NmZTw3p4xaL6gsfI9X8Iol8WBlymKQr7st/lVPk7EMBKiSXCXlK6Gm7jvvriR4dYYLv
         5rHth/v4H5MNr4dlp4r4RymQf/gt0aowPdvfTxnHEYvJ+FB+7vrSCqKammcmwaJTe306
         Vhfw==
X-Forwarded-Encrypted: i=1; AJvYcCU70I2gQ2SFoZv3Kg+aov4x4BW9kPLVneyb/P4hsrzBaRlm5fKqaQ6qC9Bg7okLhUoOBvbHpnzK9zW9Vg==@vger.kernel.org, AJvYcCUZazsjiuOiyAUPV5bzm+ntw4fi5NuFubZ3BFtFPvkjqRb38cBU65ymtHlTjZM/FlmZ2MsYGcy0kkKM@vger.kernel.org, AJvYcCUbgA+SSN34RQanuTDgfOAxh6mlGreuQ4VnDGDp4xMQ3StuenZLccta+QfsGqelnZdQ7dTl6xmkPnYCaR9g@vger.kernel.org, AJvYcCV/kRprDnsSj8ps8e5fiZv1l86Dfs3ZF+Zkpn79ZyOcngcSLZPKeD8dVYv1wdJtm6G+LB05J/cy14I=@vger.kernel.org, AJvYcCVNR88sbLW53SxyNsxLRSURsnP8inp8tohuiWuzQpN/eFQVchoBhlhaWpm3nTZDf6qjsAHgHOaM6P8jR99d@vger.kernel.org, AJvYcCVYF4GCf6zNaxB+Hl6DRqsTfsv1yl8MOImykBK2w4fM7ItXri1RGlIUuB/Zqzvumnuw1qhBYtu6zPrKTg==@vger.kernel.org, AJvYcCWtooy5fbe9IcUMxJp4g0VEVwoQ0CvJbFvu71vDJczDgrSyjPUTqyHIhJJGhMG6FU9Gbq8yHwTuMXIkzA==@vger.kernel.org, AJvYcCX3YoU2aE9cHQGrKRpqtky8uYClPZFCN/zJosSBAdf2puD+MFbDHOut2RfkEF2spIeb6LSojVR72/1S120LrW8=@vger.kernel.org, AJvYcCXBcwk5KBcG1ZwLpuGxVydqChlq7dc/QaUwDbPvHeGuc6XA+YeRSz+jdi1g4+e2cc2tEUuUc0WFMKA5WuEsYA==@vger.kernel.org, AJvYcCXc8OPlmz+I
 vG7XZp/3EJi3/hiycCBVTym15hIYCI9+ni3qRdcLyBfh40hVg0kMJrWdvn1xNisk74jL7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGkkL2XHUD5n4K7KaKGXXeK1VdHlT4X7MewsNjgfmHUbTnUEu2
	BGPPWQDa4cD6a1H2WWTw8KGd7Aj1IW53Zr8GbKOMD/MHNcBtS1n+auS2pEhRlwyQ3/PD6mSwVGS
	UlXvmft4PFUll1Yd+fOeIQVH4m1c=
X-Gm-Gg: ASbGncvRVEtDcs117AgCd6rqHNz3XV9CAc6TqzY69AS4alZGQTIvmjB+ZJ1Z/4gWPaJ
	x9IlzopbSWq3vf3Y0n7FXrGBljdNGEPOaq8geyA==
X-Google-Smtp-Source: AGHT+IE6c+RDPkVhdYpGhwJjY3swM/Kqbs9TiZQ1EhehCnKjqU+fLUq40RYGPSLu28v4p+m1VfknK3ci2deVkxFc/zo=
X-Received: by 2002:a17:90b:54cb:b0:2ee:df57:b194 with SMTP id
 98e67ed59e1d1-2f782cc011fmr4009658a91.21.1737128683175; Fri, 17 Jan 2025
 07:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113170925.GA392@strace.io> <20250113171140.GC589@strace.io>
 <Z4hs0X8RhGTuevnn@ghost> <eecada37-9d0e-4e3c-9b70-fefb990835b2@zytor.com>
In-Reply-To: <eecada37-9d0e-4e3c-9b70-fefb990835b2@zytor.com>
From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Fri, 17 Jan 2025 16:45:02 +0100
X-Gm-Features: AbW1kvb78AU_0HrrHV0OtjwO2uAvukZ8DnSGASVo_9Ya8_h5NunDjjnSIP4voz8
Message-ID: <CACGkJdtAmtxsPiKYUzLLmfNGf6oJ9YS-25ZY9VvEEWhz37Qx6Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] syscall.h: add syscall_set_arguments() and syscall_set_return_value()
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, "Dmitry V. Levin" <ldv@strace.io>, Oleg Nesterov <oleg@redhat.com>, 
	Mike Frysinger <vapier@gentoo.org>, Renzo Davoli <renzo@cs.unibo.it>, 
	Davide Berardi <berardi.dav@gmail.com>, strace-devel@lists.strace.io, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 2:03=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> I link the concept of this patchset, but *please* make it clear in the
> comments that this does not solve the issue of 64-bit kernel arguments
> on 32-bit systems being ABI specific.

Sorry, but I don't see how this is relevant; each architecture has its
own ABI with its own set of peculiarities, and there's a lot of
(completely unrelated) work needed in order to make an ABI that is
architecture-agnostic.  All this patch set does is provides a
consistent way to manipulate scno and args across architectures;  it
doesn't address the fact that some architectures have mmap2/mmap_pgoff
syscall, or that some have fadvise64_64 in addition to fadvise64, or
the existence of clone2, or socketcall, or ipc; or that some
architectures don't have open or stat;  or that scnos on different
architectures or even different bit-widths within the "same"
architecture are different.

> This isn't unique to this patch in any way; the only way to handle it is
> by keeping track of each ABI.

That's true, but this patch doesn't even try to address that.

--=20
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}

