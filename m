Return-Path: <linux-arch+bounces-9588-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE87CA0156B
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7316A3A2411
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FFF1B6541;
	Sat,  4 Jan 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="hHjWR7Gn"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8B14375D;
	Sat,  4 Jan 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736003599; cv=none; b=AJ3r7BVLzioQalVc/URYMQM5gEK03tjJjtTUh7r6M/TXGYKY2OrJiuUIJB6vT0FSV5uz5PPOkgOoB0K/QuqTX/nPjPIVS6VmNHhausIlCiQcr+plqyphlPDYwgyGY7PZE5RQu72zkBWGxB4ViUmvwBF3wiI/OyGD+xTf8Zrr6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736003599; c=relaxed/simple;
	bh=E7sXpPzI/Y8sItiYiSPO1J4ECJ43ySequ0hT5NaXR2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ej5Ji5k5HcNoOumxx/iVfrvoUSlHbFajJbXoqVmihdDcwIjbi+Meg6/acC/9hp9ClMFX4uy0gB62RcOg1FfsDFfV9+DH2cFZzCjzdW4rQBVlBnTp3sG/RfSCoFGd78m93GFN6QPOUfzR2ZAkcqD1GNGfh+yPRRTzPnG5nL/iCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=hHjWR7Gn; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1736003597;
	bh=3qGLag7nPn1heyneisSntScc9NQLMJbK2HBK8k1x92A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hHjWR7Gn5uTGqZVXiP99XfmEEfFnhsU/EyQmH6E1xjhZkIFGBVMmp77Hkk7LaUnZ5
	 IoYJMidBVqbZmsWhsT/QHzJ6Dh5YL83BffT6DtuLffaYN+6nJGl60GD6UazKyaw2bn
	 k2tUYAV3MWGBXAsP71af34fRxpP6KkX04vl50N9o=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id F20F966EA9;
	Sat,  4 Jan 2025 10:13:15 -0500 (EST)
Message-ID: <4504b10e4a0bfd09d9a3c719d234295bb638aa3f.camel@xry111.site>
Subject: Re: [PATCH 0/3] LoongArch: initial 32-bit UAPI
From: Xi Ruoyao <xry111@xry111.site>
To: Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Linux-Arch
	 <linux-arch@vger.kernel.org>
Date: Sat, 04 Jan 2025 23:13:14 +0800
In-Reply-To: <d4e4253b-1a06-499a-879b-e6b3c672d213@app.fastmail.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
	 <d4e4253b-1a06-499a-879b-e6b3c672d213@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-01-04 at 16:00 +0100, Arnd Bergmann wrote:
> On Thu, Jan 2, 2025, at 19:34, Jiaxun Yang wrote:
>=20
> > Why am I upstreaming LoongArch32?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Although 32-bit systems are experiencing declining adoption in general
> > computing, LoongArch32 remains highly relevant within specific niches.
> > Beyond embedded applications, several vendors are actively developing
> > application-level LoongArch32 processors. Loongson, for example, has
> > released two open-source reference hardware implementations: openLA500
> > and openLA1000 [6].
> >=20
> > The architecture also holds considerable educational value, having been
> > integrated into China's national computer architecture curricula and
> > embedded systems courses. Additionally, the National Student Computer
> > System Capability Challenge (NSCSCC) [1] features LoongArch32 CPUs, whe=
re
> > hundreds of students design Linux-capable hardware implementations and
> > compete on performance. This initiative has resulted in several excitin=
g
> > high-performance LoongArch32 cores, including LainCore[2], Wired[3],
> > NOP-Core[4], NagiCore[5]....
>=20
> I'm surprised that so many resources get put into 32-bit hardware
> implementations on loongarch, when this has mostly stopped on riscv
> and arm, where new hardware is practically all either 64-bit Linux
> or 32-bit NOMMU microcontrollers.
>=20
> > From an upstream perspective, we will largely reuse the infrastructure
> > already established for LoongArch64, ensuring that the maintenance burd=
en
> > remains minimal.
> >=20
> > Porting Status
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The LoongArch32 port has been available downstream for some time, with
> > various system components hosted on Loongson's Gitee[6]. However, these
> > components utilise an older downstream ABI and fall short of upstream
> > quality.
> >=20
> > On the upstream front, LLVM-19 now includes experimental support for
> > LoongArch32 (ILP32 ABI) under the loongarch32* triple, and efforts are
> > underway to enable GNU toolchain support. My upstream-ready kernel port
> > and musl libc port can successfully boot into a minimal Buildroot
> > environment and execute test cases on QEMU virt machine with clang
> > toolchain.
>=20
> I assume the MIPS legacy means that a 64-bit kernel is going to be
> able to run the same ILP32 binaries as a 32-bit kernel running on
> pure 32-bit hardware, similar to powerpc/s390/x86, but unlike
> riscv/arm?

LoongArch has instructions like addi.d/addi.w, instead of addi/addi.w,
thus on 32-bit implementation it's simply addi.d is missing, not the
semantic of addi is changed.  So I cannot see a real reason we cannot
support the same ILP32 userspace binaries compiled for 32-bit hardware
on 64-bit hardware.

> We need to be careful in defining the ABI to ensure that this covers
> all the corner cases, such as defining a signal stack layout with
> room to save 64-bit user register contents if there is a chance that
> a 32-bit userspace will end up using the wide registers when
> running on a 64-bit kernel, but also avoid any dependency on 64-bit
> registers in the ABI itself.

Yes such issues are nasty, we'd already need something in the calling
convention like "on 64-bit hardware, in ILP32 ABI the saved registers
may be unchanged or changed to the sign-extension from the lower 32 bits
of the original value."

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

