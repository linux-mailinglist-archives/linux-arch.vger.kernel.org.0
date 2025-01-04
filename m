Return-Path: <linux-arch+bounces-9585-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E21A01422
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 12:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7049A188457C
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 11:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC84168DA;
	Sat,  4 Jan 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="lPsM/DsP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Da8cBEDK"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BA4A3E;
	Sat,  4 Jan 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735990473; cv=none; b=kXjX2tb0eg30iwKyHboxwepTE16aKpJ99du7w+PSWmcjnWaj7TOv8QHvYI/6wGe6xRr5xmvfCtGuy/zits8a7QcACQb7osEH72gf04SvP618kxC3qMuB7kfZ2jBTGgN9cGa76ckrDke1QVHWYx70PIxd7j1pUF3mSjy57UgQflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735990473; c=relaxed/simple;
	bh=FSte7ZUNLuTsz53PhzzJ3/rn5SXSalqeMv2ZrkIi2v0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QNYIe6Cut4jUMcpmGV0SoFR6qokKFdM+7j7BhpOjM6dNGz0HuijNGxhNkcMTNDg8stEckcCE20c3sEJUPQ+E0hQGl+vnioESWNE5B0UxsLqY9DHflSbaG5awXI9AYDT2VoIf+x6MRgpXyQ+aZcEkfaIb0U7XOKglcASNBSbCMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=lPsM/DsP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Da8cBEDK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E848D1380214;
	Sat,  4 Jan 2025 06:34:29 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sat, 04 Jan 2025 06:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1735990469;
	 x=1736076869; bh=ebp8PyepCOEv3mZfvOwTAhscinI8vJ9KWmtuYcZ8rNA=; b=
	lPsM/DsP1jkt5LC8DG9NF2xdMRngmQeypIBMdZplixXZ12F1T/xGGziUBkTPn7YG
	6DQoScnCyJgIcwvgEXoL9Z+sAWyvVTCyEh4HTr14TrJ1pnk0fVHMfvpjaflQm/5g
	bAEki8HjURlWOwZuds1H+Od/De+9XKfDv4afD+0BR+/36Ol2mHTsNSprSs7NRdww
	m+AV3ryzPtZKxdRBiWtjbH4VJ2EnwRX4P3D0X+aw3tw6OwwdUeJwiQ+KDusWqCuw
	A8HFKcmwT8/iA1G7UYpbmp/d18gxUAoNb/lUjUH8VmQa6+SwMjtJeqbZND9t/Xvv
	Muau4qXRPQGZrgvFhgxHpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735990469; x=
	1736076869; bh=ebp8PyepCOEv3mZfvOwTAhscinI8vJ9KWmtuYcZ8rNA=; b=D
	a8cBEDKF5KHk6gcUHMHVyl+pfRk/3NLTxpJB/jto13kQ/eEyBP1bntcdXP0RN3Ue
	9+WKZJp1Ax9zADrtNgit6kNSgA/ajUSAS10wYNiNSCi8mXKCnyrg1jxydibMVaaU
	vBG8dzL0tbeIQwGLyfTyNUG3bmf2zpYY2Pl1Z2HCZ26LWif5c/V7wDHAzK08ZRBX
	BSl/n4i4xax7Ag11Ms0c+KIuVqktpKXI3PsrqqA98TNVx3BF8E8dgmFjFPkwmKtn
	JlvaDBhVCem2IR9q8qozF/iwZHNCfhgKHf/dZteUZ6CfhLarQmmBy762mwtrSGbN
	/MqiF+StQW2F2ctugXfJA==
X-ME-Sender: <xms:xRx5ZylIzVfWGZ27vOC8RKi4Ac6NYM8r3r4dXxu44k1AKc3e3oS35Q>
    <xme:xRx5Z52r_iwYZn5i2kIPwOkw15niogJGBBRbuunbD4XlxZmd-5TTWc_reMOW0ydcy
    EjjCi5HnY1YNAxN3tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepffekveettdeuveefhfekhfdu
    gfegteejffejudeuheeujefgleduveekuddtueehnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
    ejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggv
    pdhrtghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlohhonhhgrghrtghhsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohep
    lhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopeigrhihudduudesgihrhi
    duuddurdhsihhtvg
X-ME-Proxy: <xmx:xRx5Zwp4ukgcg-sBunrokksiGLdDe7uaCFXUlu-Nludib4lFlUVSww>
    <xmx:xRx5Z2mEWRkU4pBXfscsF7ZcM1xXoNrVahVmWmJTVIIU9Fy1eMwF4w>
    <xmx:xRx5Zw17I5O7fuJsRrCYCE5t94PSV6oh1p9Yq32Ulc32VRshVoA_yQ>
    <xmx:xRx5Z9uui73kLzPp8hJu-ZXm0iHDeFdqCl8GMIX6wUh4weKrkcRfgA>
    <xmx:xRx5Z6oJsaNsznBPQrXz6pwf1RDTqpXKLPFliwPLt7a_DVZCWSvKNOsV>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 47CB71C20066; Sat,  4 Jan 2025 06:34:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Jan 2025 11:33:52 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Xi Ruoyao" <xry111@xry111.site>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Xuerui Wang" <kernel@xen0n.name>
Cc: "Arnd Bergmann" <arnd@arndb.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <ca4c18b1-da35-4b9a-9eef-bbdab19c9592@app.fastmail.com>
In-Reply-To: <3409b0608ba127c356e2a6d760c3ac2d446c9da7.camel@xry111.site>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <20250102-la32-uapi-v1-2-db32aa769b88@flygoat.com>
 <3409b0608ba127c356e2a6d760c3ac2d446c9da7.camel@xry111.site>
Subject: Re: [PATCH 2/3] loongarch: Introduce sys_loongarch_flush_icache syscall
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=884=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=E5=
=8D=889:31=EF=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, 2025-01-02 at 18:34 +0000, Jiaxun Yang wrote:
>
> /* snip */
>
>> Sadly many user space applications are assuming ICACHET support, we c=
an't
>> recall those binaries. So we'd better get UAPI for cacheflush ready s=
oonish
>> and encourage application to start using it.
>
> To encourage the developers changing ibar to loongarch_flush_icache, we
> should minimize the extra overhead on mainstream systems.  We can add =
an
> vDSO layer so if the CPU has ICACHET:

I'm a little bit confused as that's exactly what I'm doing in PATCH 3.

>
> int vdso_loongarch_flush_icache(...)
> {
>   asm ("ibar 0");
>   return 0;
> }
>
> And otherwise the vDSO wrapper invokes the real syscall.  I've
> implemented the boot-time alternative runtime patching for vDSO at
> https://lore.kernel.org/loongarch/20240816110717.10249-3-xry111@xry111=
.site/.

Thanks! Noted.

>
>> The syscall resolves to a ibar for now, it should be revised when we =
have
>> actual non-ICACHET support in kernel.
>
> /* snip */
>
>> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch=
/include/asm/cacheflush.h
>> index f8754d08a31ab07490717c31b9253871668b9a76..94f4a47f00860977db0b3=
60965a22ff0a461c098 100644
>> --- a/arch/loongarch/include/asm/cacheflush.h
>> +++ b/arch/loongarch/include/asm/cacheflush.h
>> @@ -80,6 +80,12 @@ static inline void flush_cache_line(int leaf, unsi=
gned long addr)
>>  	}
>>  }
>> =20
>> +/*
>> + * Bits in sys_loongarch_flush_icache()'s flags argument.
>> + */
>> +#define SYS_LOONGARCH_FLUSH_ICACHE_LOCAL 1UL
>> +#define SYS_LOONGARCH_FLUSH_ICACHE_ALL   (SYS_LOONGARCH_FLUSH_ICACHE=
_LOCAL)
>
> Not a UAPI header so not usable by the user?  How would they specify
> flags then?

We are following the RISC-V's convention on not exposing flags in UAPI
header for now as it's not really ready.

>
> If you meant to add them for UAPI, it would be very problematic.  When=
 a
> new cache type emerges in the hardware implementations, we need to grow
> SYS_LOONGARCH_FLUSH_ICACHE_ALL in the UAPI header, but we cannot change
> the already compiled JIT applications.  Thus all JIT applications have
> to be recompiled with the latest UAPI header.  This just seems an
> unnecessary severe burden to the packagers.

The _LOCAL flag not meant to be hardware cache level but the scope.
(i.e. all threads or just the caller). Vast majority of applications
shouldn't need this level of granularity, so just setting flags to zero.

However, for application want fine-grained optimisations they should
probe availability of flags before using it. Thus kernel should reject
all unknown flags to assist application probing.

>
> Instead IMO it's better not to expose so much details to the userspace.
> Just remove the flags argument and flush all the icaches the kernel
> knows, so with a new cache type the user (and distro) just need to
> update or patch their kernel, w/o recompiling all JIT apps.

There is no need to change anything in user space usage when a new cache
type emerge. See explanations above.

Thanks
>
> --=20
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

--=20
- Jiaxun

