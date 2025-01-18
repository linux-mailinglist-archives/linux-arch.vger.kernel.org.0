Return-Path: <linux-arch+bounces-9814-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC1A15B6C
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jan 2025 05:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C00188A840
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jan 2025 04:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F5D4F5E0;
	Sat, 18 Jan 2025 04:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hdj5mGq9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C535968;
	Sat, 18 Jan 2025 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737175165; cv=none; b=pWISXyTzykOtAlNs4Yc4QQkjLGuS8bGyd1MFo1fX0G3QYftnfqarE/OPLFsTrhI9jBHaDOIRtkUi0XlJOIBMQItPOmGE1mgMR7Xb4ThmRuI5LfnDr14bkBA9htLh+4Eq/tTP8/LHIWIXj+m/o8yVSQ7qIMPOfnmUdRiIx7Cfw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737175165; c=relaxed/simple;
	bh=tFLBkahsiihIpZSximl2JBqPEwqeQPi3tzP7hERo3Ig=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=j9PKmrTwbCmE6ltqSDL0eJJ2YyFrKyRr2lVDPt0BUT6huv8mQuS+nPYK+YYhkzUPLDNVWWW1F5/eaPDYgIdz3XB4XqYlB8ZPLQjM2tydW2bob+W6Nv4P8tmCAedJYtTDCpIhzI0rboj9mfm66+mZPAvczifcMQbRW94ul1lIciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hdj5mGq9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50I4YkBo262261
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 17 Jan 2025 20:34:46 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50I4YkBo262261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737174897;
	bh=w1vtBdwCDfUdjXlAPq/H8CEoUqmusT1ScqFMMfS7dZ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hdj5mGq9LhBqQz1DGkEXyOAPg5UumXs4rYaXrAxe/XdXtsj44W9H6+brjFlKruZEu
	 KZw5piA42OHN/XcSeaUskoitHUnJNqT+XsxtkAneGSnIvuXW+n6ZC7eW8FnCimYSsG
	 Lq1HAj2fYTDCYOqRHD+qLXvSb6ZxhtiXDCdoJyIe1GRxYKC8axRGOudEZFGw1AbPA8
	 XfSMDwvu4q4o4HAn0vaClp5lq+a2D6iGDyVD9URdyKl9xLKY6kTXhchRX+IiLJk6MT
	 lQqfZZED15R6MYW2CL2TKc8zQ0Rfpn6iPT2QNmGS8gBb8X3N0roFy9uw8TLOeP93LY
	 mjPwqKCNYdQPg==
Date: Fri, 17 Jan 2025 20:34:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Eugene Syromyatnikov <evgsyr@gmail.com>
CC: Charlie Jenkins <charlie@rivosinc.com>, "Dmitry V. Levin" <ldv@strace.io>,
        Oleg Nesterov <oleg@redhat.com>, Mike Frysinger <vapier@gentoo.org>,
        Renzo Davoli <renzo@cs.unibo.it>,
        Davide Berardi <berardi.dav@gmail.com>, strace-devel@lists.strace.io,
        Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/7=5D_syscall=2Eh=3A_add_syscall=5Fse?=
 =?US-ASCII?Q?t=5Farguments=28=29_and_syscall=5Fset=5Freturn=5Fvalue=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CACGkJdtAmtxsPiKYUzLLmfNGf6oJ9YS-25ZY9VvEEWhz37Qx6Q@mail.gmail.com>
References: <20250113170925.GA392@strace.io> <20250113171140.GC589@strace.io> <Z4hs0X8RhGTuevnn@ghost> <eecada37-9d0e-4e3c-9b70-fefb990835b2@zytor.com> <CACGkJdtAmtxsPiKYUzLLmfNGf6oJ9YS-25ZY9VvEEWhz37Qx6Q@mail.gmail.com>
Message-ID: <B5D44A2A-BF4F-4EEA-992D-0A06F2AE08CA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 17, 2025 7:45:02 AM PST, Eugene Syromyatnikov <evgsyr@gmail=2Eco=
m> wrote:
>On Fri, Jan 17, 2025 at 2:03=E2=80=AFAM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> I link the concept of this patchset, but *please* make it clear in the
>> comments that this does not solve the issue of 64-bit kernel arguments
>> on 32-bit systems being ABI specific=2E
>
>Sorry, but I don't see how this is relevant; each architecture has its
>own ABI with its own set of peculiarities, and there's a lot of
>(completely unrelated) work needed in order to make an ABI that is
>architecture-agnostic=2E  All this patch set does is provides a
>consistent way to manipulate scno and args across architectures;  it
>doesn't address the fact that some architectures have mmap2/mmap_pgoff
>syscall, or that some have fadvise64_64 in addition to fadvise64, or
>the existence of clone2, or socketcall, or ipc; or that some
>architectures don't have open or stat;  or that scnos on different
>architectures or even different bit-widths within the "same"
>architecture are different=2E
>
>> This isn't unique to this patch in any way; the only way to handle it i=
s
>> by keeping track of each ABI=2E
>
>That's true, but this patch doesn't even try to address that=2E
>

I just want it noted in the comment, that's all=2E

