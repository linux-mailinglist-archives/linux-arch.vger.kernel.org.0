Return-Path: <linux-arch+bounces-8885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0161E9C01CC
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 11:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F1E28454B
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394201E9068;
	Thu,  7 Nov 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ci4sasAT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4bgUURb"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37C1E885A;
	Thu,  7 Nov 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973743; cv=none; b=sJ69eVkSyyxS4b9JGLEdlIfaM+6OTPvuV8ESySHWdyJQWxoN69YLk7F2DaZutxsFVL9AIQfQK1d6IazHhf5TsJ4b8EA7Y/7CYiUqJoTfh07Ta5IHURIu94y/APiZE2wVDoKG8XgNPoRQO6XITKg+fp+rHvLzMQ3HnGdsLNs3TEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973743; c=relaxed/simple;
	bh=CYIZ4InJfLSJ1hbtF82RJRg/Us0iUo2AybX8tPKT2wY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=epH1myM0qIWMMwlvYLYJ5zetMYPiR2S3VWzal+/Tenyxsnlh+eBOrMuht7f8s8dr3RD9dKZB4MyO3cRqL7XIq+QzgjbBsYrbsN68CzSt2XqSs94TltO+bYp4qusKUa0YblDH1co20BETpdeqSmAXtuzy8tMmWJ4IkBXJtpDrozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ci4sasAT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4bgUURb; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23BA511401DD;
	Thu,  7 Nov 2024 05:02:19 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 07 Nov 2024 05:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730973739;
	 x=1731060139; bh=Hd8IeJs9qp/ThzvdHUHNNNLGsqMD9xIcngR+XTuBn8I=; b=
	Ci4sasATfHowO5XaTQ4QmX64j1pCahNSaj2Ox0KLoOpWUUKPFVNbQM1yuYDfIZY3
	BWs0Ouo/ITVelMZ4/MdL297pq7hw5sfqLFDIGjYMTkU+MuAxM2I4w+dXFFw/NGS3
	zOd2L6sFbThvoR2B6IKsXlC8MpoTL5st5tsjCNg3x3wdUI+t8e6nVk+bXzPfd3h2
	7X31oH00oG5H0UrvXbQq293SmThVhDSmf62mOIuYOnUqbPtP0M7KIVNiLVJSBiWz
	3T3bZ6oUsuRQFVuThAhoIcz+1PNoHRA+DfP9hd+7/wfWliFlBa6euqm0jiCmmWIr
	PnzFL5jhhSVKbklB3I8Q8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730973739; x=
	1731060139; bh=Hd8IeJs9qp/ThzvdHUHNNNLGsqMD9xIcngR+XTuBn8I=; b=k
	4bgUURbKgUXcKo3cN0VpHlZtq+uEyd0EyWh76Oyj8eaEPiF9wkP9S1qqlLAeybuh
	aeyGUFw9KSo0YDdEsGZOsji7cPwjlnKc0H9rg5PmsLpvEAVgfKntXB18/RT8nUBe
	eiATpIhqIE/BMH5EOoCDoigO73cTEAcvqzWDm8ldCB5vc8cr8Y17mgow/L4K01jk
	u6k7kGrJ2nPjpIPf3I8JvkXwQJS3H2k9qvASsa4Xk7+IRMqIGNiUAX8W4GweEkUw
	Wzg7iy/atBAcLJaBWw/oK97HfDaxwr8wkfY3N471jbl8WMqn8SBkeGk2JvN6h8Jy
	8usUA2j4z0b8ZIv36KGpA==
X-ME-Sender: <xms:KpAsZyrFiHyuA6O3TS8rGVibTIkf4GYurf5x7l_aoJqO08fl5Bgmhw>
    <xme:KpAsZwrLDV5zg2zlstipBSp6vzvCTypeZE2sQ3fLYhtdOvNyijRYNR1gSzD8emaC5
    GfopkVMbjJZdoeXO5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeekgfehfefhleeuieehheehudekveegudfhtedugeek
    veeludeitdduhfehfeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgnhhurd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpthhtohep
    jhhonhdrghhrihhmmhesrghmugdrtghomhdprhgtphhtthhopehsrghnthhoshhhrdhshh
    hukhhlrgesrghmugdrtghomhdprhgtphhtthhopehsuhhrrghvvggvrdhsuhhthhhikhhu
    lhhprghnihhtsegrmhgurdgtohhmpdhrtghpthhtohepvhgrshgrnhhtrdhhvghguggvse
    grmhgurdgtohhmpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhm
    pdhrtghpthhtohepuhgsihiijhgrkhesghhmrghilhdrtghomhdprhgtphhtthhopehkuh
    hmrghrrghnrghnugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrnhguohhhsehg
    ohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:KpAsZ3PH4kBKEWxA-7cYZYIPwqZyZbdtot7xYeoaNPwwlp58M5rpeg>
    <xmx:KpAsZx6qpzzpHIrP5lGs0a6APEZh92MnfIRaM6t7bVr-GJAdeaKWzA>
    <xmx:KpAsZx4nJorSFU0btoGBgqpzNOZN3u1wr4uPUSl5XAiLR959ifgiGA>
    <xmx:KpAsZxg48q31vk2Ey-9ZKHHXG-T4b-622USRHNQdkD1Hp9TgNaAkSw>
    <xmx:K5AsZwIpJOIcOobCAoNeCrLRaHD5B9xn72WIyb5UWUcK9jZ_zoPULsoM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9E27A2220071; Thu,  7 Nov 2024 05:02:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 07 Nov 2024 11:01:58 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@nvidia.com>, "Uros Bizjak" <ubizjak@gmail.com>
Cc: "Joerg Roedel" <joro@8bytes.org>,
 "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 "Robin Murphy" <robin.murphy@arm.com>, vasant.hegde@amd.com,
 "Kevin Tian" <kevin.tian@intel.com>, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <4c9fd886-3305-4797-9091-3f9b0b9ee0b6@app.fastmail.com>
In-Reply-To: <20241106134034.GN458827@nvidia.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com>
 <ZyoP0IKVmxfesRU8@8bytes.org>
 <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com>
 <CAFULd4Za4BQL+h9Xmra1TjB2oGGzPwru_y1xOrrAFSg==bfvgg@mail.gmail.com>
 <20241106134034.GN458827@nvidia.com>
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE() support for
 __int128
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Nov 6, 2024, at 14:40, Jason Gunthorpe wrote:
> On Wed, Nov 06, 2024 at 11:01:20AM +0100, Uros Bizjak wrote:
>> On Wed, Nov 6, 2024 at 9:55=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> >
>> > On Tue, Nov 5, 2024, at 13:30, Joerg Roedel wrote:
>> > > On Fri, Nov 01, 2024 at 04:22:57PM +0000, Suravee Suthikulpanit w=
rote:
>> > >>  include/asm-generic/rwonce.h   | 2 +-
>> > >>  include/linux/compiler_types.h | 8 +++++++-
>> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
>> > >
>> > > This patch needs Cc:
>> > >
>> > >       Arnd Bergmann <arnd@arndb.de>
>> > >       linux-arch@vger.kernel.org
>> > >
>> >
>> > It also needs an update to the comment about why this is safe:
>> >
>> > >> +++ b/include/asm-generic/rwonce.h
>> > >> @@ -33,7 +33,7 @@
>> > >>   * (e.g. a virtual address) and a strong prevailing wind.
>> > >>   */
>> > >>  #define compiletime_assert_rwonce_type(t)                      =
             \
>> > >> -    compiletime_assert(__native_word(t) || sizeof(t) =3D=3D siz=
eof(long long),  \
>> > >> +    compiletime_assert(__native_word(t) || sizeof(t) =3D=3D siz=
eof(__dword_type), \
>> > >>              "Unsupported access size for {READ,WRITE}_ONCE().")
>> >
>> > As far as I can tell, 128-but words don't get stored atomically on
>> > any architecture, so this seems wrong, because it would remove
>> > the assertion on someone incorrectly using WRITE_ONCE() on a
>> > 128-bit variable.
>>=20
>> READ_ONCE() and WRITE_ONCE() do not guarantee atomicity for double
>> word types. They only guarantee (c.f. include/asm/generic/rwonce.h):
>>=20
>>  * Prevent the compiler from merging or refetching reads or writes. T=
he
>>  * compiler is also forbidden from reordering successive instances of
>>  * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of s=
ome
>>  * particular ordering. ...
>>=20
>> and later:
>>=20
>>  * Yes, this permits 64-bit accesses on 32-bit architectures. These w=
ill
>>  * actually be atomic in some cases (namely Armv7 + LPAE), but for ot=
hers we
>>  * rely on the access being split into 2x32-bit accesses for a 32-bit=
 quantity
>>  * (e.g. a virtual address) and a strong prevailing wind.
>>=20
>> This is the "strong prevailing wind", mentioned in the patch review a=
t [1].
>>=20
>> [1] https://lore.kernel.org/lkml/20241016130819.GJ3559746@nvidia.com/

I understand the special case for ARMv7VE. I think the more important
comment in that file is

  * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
  * atomicity. Note that this may result in tears!

The entire point of compiletime_assert_rwonce_type() is to ensure
that these are accesses fit the stricter definition, and I would
prefer to not extend that to 64-bit architecture. If there are users
that need the "once" behavior but not require atomicity of the
access, can't that just use __READ_ONCE() instead?

> Yes, there are two common uses for READ_ONCE, actually "read once" and
> prevent compiler double read "optimizations". It doesn't matter if
> things tear in this case because it would be used with cmpxchg or
> something like that.
>
> The other is an atomic relaxed memory order read, which would
> have to guarentee non-tearing.
>
> It is unfortunate the kernel has combined these two things, and we
> probably have exciting bugs on 32 bit from places using the atomic
> read variation on a u64..

Right, at the minimum, we'd need to separate READ_ONCE()/WRITE_ONCE()
from the smp_load_acquire()/smp_store_release() definitions in
asm/barrier.h. Those certainly don't work beyond word size aside
from a few special cases.

>> FYI, Processors with AVX guarantee 128bit atomic access with SSE
>> 128bit move instructions, see e.g. [2].
>>=20
>> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D104688

AVX instructions are not used in the kernel. If you want atomic
loads, that has to rely on architecture specific instructions
like cmpxchg16b on x86-64 or ldp on arm64. Actually using these
requires checking the system_has_cmpxchg128() macro.

   Arnd

