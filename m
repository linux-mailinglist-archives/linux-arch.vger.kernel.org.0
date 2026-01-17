Return-Path: <linux-arch+bounces-15841-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C657D3914C
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 23:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00737301637D
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 22:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD8238D52;
	Sat, 17 Jan 2026 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LFT9TO0d"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56F500941;
	Sat, 17 Jan 2026 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768687422; cv=none; b=SBsX8MIE67MfSzce+7Sy0U4xuiKmAxmTzy/lwXeSIj3awNx3albukapULwMQHgR+cUfR+gB1x9u7WWdxv4V7pfPCyHyvzHQR72F62L7ZDMfqEBqFqnPsso/+tyTrkZWxFwZn2gIt7nA04B9lrzV8B0TDPchjfbMxu7eA1KP6vyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768687422; c=relaxed/simple;
	bh=TiPs6cq/EtN50uEKlREkvjO9QbgwhDh9PAnvWAQInrg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gS8OGxdeIWQ+GqzPDvIVofQjfbB3kyDIUwiTaT5VR9/OJaHkk/YsHuaUcMPcB5QloW+94duq+S/AcT5V1N2/ZEKleokQW65uXdGghimDF9pTd+ug7+KghiiQTic3y1Fq6en8XJbpN0y8qUUOpMKB62h7mx7AYK3cgXRrXilQgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LFT9TO0d; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60HM2mbb263372
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 17 Jan 2026 14:02:48 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60HM2mbb263372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768687369;
	bh=4i2HbEAnEC/7T4K9QJoXI9vu+jqVYKUomkKzTEkg9P0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LFT9TO0dG7ftZza9li25VyCQSZvrShRCSx1j8sLH6ZXiMh6XYT1Gz13NRe4+iHN92
	 XA4AlnNUC2rs7J9+DhH9ZMDZDecmVUxtK9VUL3Fyh92WFec2HQJhilMaq0UZkWZYv0
	 5SrSuGvJQxOoCcfmlCqetwqyL41c3SmVHfurr/NOMEFMVblNpgrfqRqfG6sVVAiRMU
	 01CkFN1bkt0tRe6UCaXTn1YJg8hQf27WPLdjoJ8HmypK38wCguOJks+2a2aDOXt7UB
	 70IjIxRS2fMWLFZZYQ6OVV8j00JCMETp+PO8u0pVbnIj47COhwuFOepREMcVYxM8nT
	 LzHNZPFTnTGnQ==
Date: Sat, 17 Jan 2026 14:02:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
CC: "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390@vger.kernel.org, Sun Jian <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH 2/4] x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
User-Agent: K-9 Mail for Android
In-Reply-To: <20260116090719-23bdcfe2-ee80-49bf-9545-61dd1e94e7c4@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de> <20260116-vdso-compat-checkflags-v1-2-4a83b4fbb0d3@linutronix.de> <edeb782d-f413-48e6-b6b5-36961aacfcdd@app.fastmail.com> <20260116090719-23bdcfe2-ee80-49bf-9545-61dd1e94e7c4@linutronix.de>
Message-ID: <0177FB0A-44F0-4D28-8DAD-2BAACC598373@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 16, 2026 12:09:34 AM PST, "Thomas Wei=C3=9Fschuh" <thomas=2Eweis=
sschuh@linutronix=2Ede> wrote:
>On Fri, Jan 16, 2026 at 08:49:12AM +0100, Arnd Bergmann wrote:
>> On Fri, Jan 16, 2026, at 08:40, Thomas Wei=C3=9Fschuh wrote:
>> > When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
>> > are used=2E These are combined with the 32-bit CFLAGS=2E This confuse=
s
>> > sparse, producing false-positive warnings or potentially missing
>> > real issues=2E
>> >
>> > Manually override the CHECKFLAGS for the compat vDSO with the correct
>> > 32-bit configuration=2E
>> >
>> > Reported-by: Sun Jian <sun=2Ejian=2Ekdev@gmail=2Ecom>
>> > Closes:=20
>> > https://lore=2Ekernel=2Eorg/lkml/20260114084529=2E1676356-1-sun=2Ejia=
n=2Ekdev@gmail=2Ecom/
>> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas=2Eweissschuh@linutronix=
=2Ede>
>>=20
>> Acked-by: Arnd Bergmann <arnd@arndb=2Ede>
>>=20
>> > +CHECKFLAGS_32 :=3D $(CHECKFLAGS) -U__x86_64__ -D__i386__ -m32
>> > +
>> >  $(obj)/vdso32=2Eso=2Edbg: KBUILD_CFLAGS =3D $(KBUILD_CFLAGS_32)
>> > +$(obj)/vdso32=2Eso=2Edbg: CHECKFLAGS =3D $(CHECKFLAGS_32)
>>=20
>> Have you checked if something like this is needed for x32 as well?
>
>It didn't show up in my testing=2E I think this is explained by the x32 v=
DSO
>being built as 64-bit and only converted to x32 afterwards=2E
>
>Thomas

This is going to crash hard with the changes in tip:x86/entry=2E

But yes, the x32 vdso is currently really just a wrapped version on the 64=
-bit code, and as long as there are no pointers to pointers used in the vds=
o ABI there isn't really a reason to change that=2E

