Return-Path: <linux-arch+bounces-9592-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6DA0180E
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jan 2025 05:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7620318832C4
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jan 2025 04:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8D35976;
	Sun,  5 Jan 2025 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WExkrkOZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuN61FOR"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171425258;
	Sun,  5 Jan 2025 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736052227; cv=none; b=NbyNkxR/dgOYoP+8PPqlxwdnLA4pwhj0Bd4x9aAXWWYHOW7wfzoKg/WDdtl3plysCgIytMx6XqQzy/l2/NA+XK07KiipJohhCLGVMnkMHvAPAaVoMhHRcDafr/kV9skegtjF8ByYIk1shDRj4uO31CQ6efKbJCVh5dkwqeFZLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736052227; c=relaxed/simple;
	bh=+T1DHpLj8xn8g5w59WQtn0P/6eORf2AIzPOsp3W+W0o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jfpMLVAn/7gHx2p9K6atTcteUQp3oD0An+QyM86a5uxVRcW1XOIpKy1M5VwholvDAjkBUWvILwGdygSZZchXX4pmrcW3ed/3Qqfv4OEbU7YggZZd3iHVNvnQI77tgtdFT+cx7PcvnFj4qjzwoamfPL6G/dRYkqGsZhyDh4czFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WExkrkOZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuN61FOR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D187525400C7;
	Sat,  4 Jan 2025 23:43:43 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 04 Jan 2025 23:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736052223;
	 x=1736138623; bh=FTHMyEuma3NmBk+cAv1TE8+oRELEbF5gh3WtVtbAwX8=; b=
	WExkrkOZGhoFBW+CAVy+f0K/rTGQrrLc4HXy6wjWNxyodwemhDIUmmPr2O2zk+FP
	J0fOg8kxjh2WG2u4JbB+l+aq/3beRJiWfNlf/9UDO9d0S3jyd8oXqhDRjicEQR31
	3uQIQb74VyWrfluDdjrNZ2k+5pUxye6C9v7FpvZdfpByyvraspNRCdLoJyyJS+Dh
	Ofi31Ym2ga1TF9DVpA/if3t6MeV5qKJY/JMirzDG5ibQiUF1ZkAn9z4+XUfaYgwd
	6DztKdzhGs29DUDRcLWqt0sx2qkeu/VwnY7Ym2csa9FL3nq2t0qHTsROmqiInONI
	bSUndrHIlvi/k5HxD8I/Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736052223; x=
	1736138623; bh=FTHMyEuma3NmBk+cAv1TE8+oRELEbF5gh3WtVtbAwX8=; b=E
	uN61FOR27wtE/KHtlJjMdKOAkultNlAcGjEimojMxjR9WbdYq5TlTpprM3c3GOQt
	0Rlj9BbPNUpJ0JBRI4qSAFOVSReImEdxPwE0Y9V6CxCn460hh1VJ3JL3tMVHwFjl
	elhj0AvNe+cAr5rm0uZsg3BIioPJ6AACyQjlMfSsPS09zXQAFwG3SFxFouml2ttY
	wtXqJqwaQGbkNSkkvsWCXiynrmBQEP2639S/F2+aPCGdXWLnwZbPPINARZDD9yAM
	E4ugTbwiayhMk9Mwh9Qtv9wHaHgVykTX3xw5RGcAPrYRspzEwfKpLssD8j2P9yeW
	TqH+FSi/kpnNUUgbqi6qw==
X-ME-Sender: <xms:_g16ZwJo5h2yrOTTyJFZmF38EAZpj0G413FpTHATxIGvxbBteNOVHA>
    <xme:_g16ZwIxWqL1r3o6VownoKJy0e2XgsYwD0KgTY0iDJkK1Es177rLKFX2lZmalhpMh
    drBQkH-Yw21W1mF0ZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefjedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgvpdhrtghpthhtohepgihr
    hiduudduseigrhihudduuddrshhithgv
X-ME-Proxy: <xmx:_g16ZwsCpwlC2DN4dLAePqsW34f7qryrfqrFa0P2PkOB0kWC37tmOw>
    <xmx:_g16Z9Ys-dgXnyGcfQCIzkM9QI6EgSxlIOGx-Aw5VhPCBdx2RJSZog>
    <xmx:_g16Z3Yf7GV4_R3DsVxAjJvJ4R6bm_KprSKauO3ZHzf5wkmA1jzUKg>
    <xmx:_g16Z5AFfF-jkZIMrYQdDjLXt30i1CaWCTq0yA1MAd_5e0kcWz4NbA>
    <xmx:_w16Z8PRpfC1tKZQBMX6-jujR0qFaCZ-KnlrAMWrj2D5rTNH68wcq7Tj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B75CD2220072; Sat,  4 Jan 2025 23:43:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 05 Jan 2025 05:43:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Xi Ruoyao" <xry111@xry111.site>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <1def7604-634d-4dd9-a8c3-7168409a72cf@app.fastmail.com>
In-Reply-To: <2c46fc29-d24b-40b9-a64b-081a1f2a7a25@app.fastmail.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <d4e4253b-1a06-499a-879b-e6b3c672d213@app.fastmail.com>
 <4504b10e4a0bfd09d9a3c719d234295bb638aa3f.camel@xry111.site>
 <2c46fc29-d24b-40b9-a64b-081a1f2a7a25@app.fastmail.com>
Subject: Re: [PATCH 0/3] LoongArch: initial 32-bit UAPI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025, at 17:03, Jiaxun Yang wrote:
> =E5=9C=A82025=E5=B9=B41=E6=9C=884=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=
=E5=8D=883:13=EF=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
>>
>>> We need to be careful in defining the ABI to ensure that this covers
>>> all the corner cases, such as defining a signal stack layout with
>>> room to save 64-bit user register contents if there is a chance that
>>> a 32-bit userspace will end up using the wide registers when
>>> running on a 64-bit kernel, but also avoid any dependency on 64-bit
>>> registers in the ABI itself.
>>
>> Yes such issues are nasty, we'd already need something in the calling
>> convention like "on 64-bit hardware, in ILP32 ABI the saved registers
>> may be unchanged or changed to the sign-extension from the lower 32 b=
its
>> of the original value."
>
> Makes sense to me. For MIPS the n32 (ILP32 for 64bit) ABI has a new se=
t of
> UAPI definition (also mandate 64bit GPR). While the vanilla o32 ABI is=
 32bit
> only, which disallows any 64bit instruction in user space.
>
> When I'm designing current LA32 ABI I actually have o32 ABI in mind. H=
owever
> LoongArch64 hardware is not capable to disable 32bit instructions alon=
e. So
> if we end up doing something like o32 the limitation of 32bit instruct=
ion needs
> to be enforced at compiler side.

> So I think the question would do we want to allow 64bit instructions f=
or
> LoongArch's ILP32 kernel UAPI. We can either go through MIPS's o32 PAT=
H,
> making 32bit ABI truly 32bit, or maybe reusing the UAPI for ILP32 on 6=
4.

If at all possible, I think both the kernel's UAPI and the user side
ELF psABI should be defined as compatible with 32-bit hardware and
with userspace running on 64-bit kernels.

> From Guo Ren's RISC-V's compat work and arm64ilp32 I can certainly see
> the benefit of ILP32 on 64. Maybe we can bring that to LoongArch as we=
ll.

I would not take these as examples, since something went wrong for
each of them:

- RISC-V defined rv64 to not be a superset of rv32, so arithmetic
  instructions behave differently unless you switch modes
- aarch64 and aarch32 modes are completely different instruction sets,
  so aarch64ilp32 is by definition incompatible
- mips o32 as I understand it could work with 64-bit at the ISA level,
  as n32 does, but the ELF ABI does not allow using 64-bit registers,
  while n32 requires the use of 64-bit registers and does not work
  on 32-bit hardware.

If both the ISA and the ABI get it right, it should be possible to
build 32-bit userspace that is compatible with both when targeting
a 32-bit hardware, but still use 64-bit registers inside a single
function when the compiler is building for a 64-bit capable CPU
(e.g. "-march=3Dla464 -m32"). There is a small cost in the calling
conventions for passing u64 arguments in pairs of registers
(unlike n32/x32/aarch64ilp32/rv64ilp32), but a huge benefit in
not maintaining two incompatible ABIs.

     Arnd

