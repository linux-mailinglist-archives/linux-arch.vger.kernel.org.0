Return-Path: <linux-arch+bounces-7449-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE148986843
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 23:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AAD28426A
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B05714A635;
	Wed, 25 Sep 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ca1tJi6p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EC+Mms89"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF01CF93;
	Wed, 25 Sep 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299429; cv=none; b=usfVugreHmLrdqEST+4flM6Ujvf1an4DOy6ovpfubElypaiObYTLwXqQmKf8R7wJHFR+mQF1in5mXpM8DIJUhQfD3vm3/QccfCpzMx0F9HeoB6K0cXlYrvP2NKmJQGDJakdqmTajlaQWYFFPB0WSh0gEx9bO1JWLqbPODLEF6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299429; c=relaxed/simple;
	bh=EEL+scH5ZfQFllkr9VaYxN2Axjp7W8KsmHEsJ9I9jI0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tWOx0S8nS98rMZCRjPA03fvzNCviWf/L1QUZnVPiqZUKSMxGrGmchBcOS4858ojD/THsBd3eJWdiOSrk0nh4uE8bLlCwEvQCAa7xkPVIhI0cmyGqUTLp/eZR5q6PkE/ACMBelxXgylJ+UkUJ5jvxVDKfpBPnlAYnISSux+mqa4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ca1tJi6p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EC+Mms89; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 49B2313801A0;
	Wed, 25 Sep 2024 17:23:46 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 25 Sep 2024 17:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727299426;
	 x=1727385826; bh=J4rpxeCJhm3KEquxWD8v+82nmx/qaZF3d61PNtHrW8w=; b=
	ca1tJi6pDZvE5CPs/r8S9UQTH3C1ga5zv48dC7UC9YMKaHGXQa4887dbwmf1O9BB
	CGFNEK6yigIqj/UprPTj7035JvNyCzdd+BfU51/GEfZDTknC6cyXzaDTjP+02cZ8
	bTsu5TEPwZ7/RFrgZj5v0K2QIyNwCyK1Mn2C9IzFSgnq9EO52M0dWs3BNoV8udin
	Y1dz6T27a6nD+jrurpbXVaXhRGkvMtWw9g9RXvUaEWm09Sc1iL8jbEmzEBAcu6SE
	pkfiKLVCMILNjZwAgQoL3V6E/OA/DnjfGx2BqjnL1Ka8/QsGTodIhjVXV2w7pSB7
	iiRMwt+tAwENKL6xj3EMNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727299426; x=
	1727385826; bh=J4rpxeCJhm3KEquxWD8v+82nmx/qaZF3d61PNtHrW8w=; b=E
	C+Mms89jGN6AKKsB98qBSQUb2LTRlF+nN5PIZUJouqwYf6sRqwuC5sXCEGgr3jtt
	Wjp2yN28INCOUO8iYFA5LI0UvTYPrOhoy3VLBBbQYxsY1PP8tZSZHDKCuT6VoSz1
	+YR+rcG3bJ18n2Wpfd64MV5sz7eHHPNmd6puRkcWN9MqfxObsiAh1lQ/venbzmss
	obzm43j4Bfpcp1/PRL4SiORI7RSP6TxBrfZMvpUQzGW4QH9vdCa1qhvpTeQs1l8B
	fETX5iIRgkLtyDl1xWB86vxELeU5TCAQwWTPXqrYVw8arvbOZ92afFS7m4zjEXE4
	QZ9RLkrQE0cCjJqtCyj7A==
X-ME-Sender: <xms:X3_0ZjtOIsZAz-eKDVLdNJixcMQ3ybrZeLxiJzIJhy-rkGgPN6dvBg>
    <xme:X3_0ZkdtPr962fWykHR1sbrz0BjrkX-CISEo9KYos7D6bvDA9uykaPZrpQPahM_fT
    NURWIMQlXXTTx10hWk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeekvdeuhfeitdeuieejvedtieeijeefleevffef
    leekieetjeffvdekgfetuefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehvihhntggvnhiiohdr
    fhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghpthhtoheptghhrhhishhtohhphhgvrd
    hlvghrohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehmrghthhhivghurdguvghs
    nhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehmphgvsegvlhhlvg
    hrmhgrnhdrihgurdgruhdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhope
    hluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:X3_0Zmyplsoa0R38XU90zqhjX74ZIEn-GQuxFnr-Y3LYHr6Zve3ruA>
    <xmx:YH_0ZiOX0LrIpMVAw7ZYSHU0ccayJWdMBvdTShp_7GURFWA9_cIZfw>
    <xmx:YH_0Zj-QId14L5bbDWkneDKnXBv7Hinzq-1h51TXqFAC81HQOLm-ew>
    <xmx:YH_0ZiWh3Wufc2uyWRAMgxXvdVKiaCr_cRwgfPCDmnlciZmDVqEw5g>
    <xmx:Yn_0Zij4DFt3bj7487Zto9EgLR63k6j6yjjYxNUUaC4GEUcYzji6Y1Ob>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D92022220071; Wed, 25 Sep 2024 17:23:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 21:23:21 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <fe23745e-a965-4b74-863d-9479fdef239f@app.fastmail.com>
In-Reply-To: <626baa55-ca84-49ba-9131-c1657e0c0454@csgroup.eu>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-2-vincenzo.frascino@arm.com>
 <626baa55-ca84-49ba-9131-c1657e0c0454@csgroup.eu>
Subject: Re: [PATCH v2 1/8] x86: vdso: Introduce asm/vdso/mman.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024, at 06:51, Christophe Leroy wrote:
> Le 23/09/2024 =C3=A0 16:19, Vincenzo Frascino a =C3=A9crit=C2=A0:
>> @@ -0,0 +1,15 @@
>> +
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_VDSO_MMAN_H
>> +#define __ASM_VDSO_MMAN_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <uapi/linux/mman.h>
>> +
>> +#define VDSO_MMAP_PROT	PROT_READ | PROT_WRITE
>> +#define VDSO_MMAP_FLAGS	MAP_DROPPABLE | MAP_ANONYMOUS
>
> I still can't see the point with that change.
>
> Today 4 architectures implement getrandom and none of them require tha=
t=20
> indirection. Please leave prot and flags as they are in the code.
>
> Then this file is totally pointless, VDSO code can include=20
> uapi/linux/mman.h directly.
>
> VDSO is userland code, it should be safe to include any UAPI file ther=
e.

I think we are hitting an unfortunate corner case in the build
system here, based on the way we handle the uapi/ file namespace
in the kernel:

include/uapi/linux/mman.h includes three headers: asm/mman.h,
asm-generic/hugetlb_encode.h and linux/types.h. Two of these
exist in both include/uapi/ and include/, so while building
kernel code we end up picking up the non-uapi version which
on some architectures includes many other headers.

I agree that moving the contents out of uapi/ into vdso/ namespace
is not a solution here because that removes the contents from
the installed user headers, but we still need to do something
to solve the issue.

The easiest workaround I see for this particular file is to
move the contents of arch/{arm,arm64,parisc,powerpc,sparc,x86}/\
include/asm/mman.h into a different file to ensure that the
only existing file is the uapi/ one. Unfortunately this does
not help to avoid it regressing again in the future.

To go a little step further I would also move
uapi/asm-generic/hugetlb_encode.h to uapi/linux/hugetlb_encode.h
or merge it into uapi/linux/mman.h. This file has no business
in asm-generic/* since there is only one copy.

After looking at this file for way too long, I somehow
ended up with a (completely unrelated) cleanup series that
I now posted at
https://lore.kernel.org/lkml/20240925210615.2572360-1-arnd@kernel.org/T/=
#t

     Arnd

