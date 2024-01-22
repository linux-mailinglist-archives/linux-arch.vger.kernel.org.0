Return-Path: <linux-arch+bounces-1422-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08542836DCB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCF81F27C0E
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35E41761;
	Mon, 22 Jan 2024 16:53:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BAA3D967
	for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942393; cv=none; b=FiUF84ewtVGR9dksLgf0eyvUxFN/XI4OOb0kJV9p0pwbDhxCE1ogv5PsoU6DXChMnS73Cy2GLGUm/OjXhU1Kn7GxQMRXgEFB/5qdg3UimHecu3kOzW8jq9XsKrhH8Pz6FBRnI6IezjdyOL0r2tgcbhXVSB9XUtoVRnsx+70qBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942393; c=relaxed/simple;
	bh=yB3S6jwurrEU9VAq2uFfd3p+Gn+5Y72CDpba3esPKqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BVbNWYBLALUDqTeBjYfFNSuF8hhIhx1qlQsQdn6WGESvlMCMRipGpJuaVmIeeQOGKmeYSs+ZrsqPxcQ+4xzaEFYdQ/2KPzcA1RkOezfJeSFvrc2dN3gilcE3lCNA46UbgykMwxnyCeMod9hFiO/srRqcT+w/WBommuiooDA3ef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-veqgJaI3Peyfp47kXADBow-1; Mon, 22 Jan 2024 16:53:09 +0000
X-MC-Unique: veqgJaI3Peyfp47kXADBow-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 Jan
 2024 16:52:42 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 22 Jan 2024 16:52:42 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Charlie Jenkins
	<charlie@rivosinc.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>, Xiao Wang
	<xiao.w.wang@intel.com>, Evan Green <evan@rivosinc.com>, Guo Ren
	<guoren@kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Thread-Topic: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Thread-Index: AQHaTVGn8AUolzpWZEe7KQadoytUPLDmCvsQ
Date: Mon, 22 Jan 2024 16:52:42 +0000
Message-ID: <6b0dc20f392c488a9080651a2a2cd4bd@AcuMS.aculab.com>
References: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
 <20240108-optimize_checksum-v15-5-1c50de5f2167@rivosinc.com>
 <2c8e98b6-336e-4bc7-81ba-5a4d35ac868a@roeck-us.net>
In-Reply-To: <2c8e98b6-336e-4bc7-81ba-5a4d35ac868a@roeck-us.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Guenter Roeck
> Sent: 22 January 2024 16:40
>=20
> Hi,
>=20
> On Mon, Jan 08, 2024 at 03:57:06PM -0800, Charlie Jenkins wrote:
> > Supplement existing checksum tests with tests for csum_ipv6_magic and
> > ip_fast_csum.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
>=20
> With this patch in the tree, the arm:mps2-an385 qemu emulation gets a bad=
 hiccup.
>=20
> [    1.839556] Unhandled exception: IPSR =3D 00000006 LR =3D fffffff1
> [    1.839804] CPU: 0 PID: 164 Comm: kunit_try_catch Tainted: G          =
       N 6.8.0-rc1 #1
> [    1.839948] Hardware name: Generic DT based system
> [    1.840062] PC is at __csum_ipv6_magic+0x8/0xb4
> [    1.840408] LR is at test_csum_ipv6_magic+0x3d/0xa4
> [    1.840493] pc : [<21212f34>]    lr : [<21117fd5>]    psr: 0100020b
> [    1.840586] sp : 2180bebc  ip : 46c7f0d2  fp : 21275b38
> [    1.840664] r10: 21276b60  r9 : 21275b28  r8 : 21465cfc
> [    1.840751] r7 : 00003085  r6 : 21275b4e  r5 : 2138702c  r4 : 00000001
> [    1.840847] r3 : 2c000000  r2 : 1ac7f0d2  r1 : 21275b39  r0 : 21275b29
> [    1.840942] xPSR: 0100020b
>=20
> This translates to:
>=20
> PC is at __csum_ipv6_magic (arch/arm/lib/csumipv6.S:15)
> LR is at test_csum_ipv6_magic (./arch/arm/include/asm/checksum.h:60
> ./arch/arm/include/asm/checksum.h:163 lib/checksum_kunit.c:617)
>=20
> Obviously I can not say if this is a problem with qemu or a problem with
> the Linux kernel. Given that, and the presumably low interest in
> running mps2-an385 with Linux, I'll simply disable that test. Just take
> it as a heads up that there _may_ be a problem with this on arm
> nommu systems.

Can you drop in a disassembly of __csum_ipv6_magic ?
Actually I think it is:
ENTRY(__csum_ipv6_magic)
=09=09str=09lr, [sp, #-4]!
=09=09adds=09ip, r2, r3
=09=09ldmia=09r1, {r1 - r3, lr}

So the fault is (probably) a misaligned ldmia ?
Are they ever supported?

=09David

=09=09adcs=09ip, ip, r1
=09=09adcs=09ip, ip, r2
=09=09adcs=09ip, ip, r3
=09=09adcs=09ip, ip, lr
=09=09ldmia=09r0, {r0 - r3}
=09=09adcs=09r0, ip, r0
=09=09adcs=09r0, r0, r1
=09=09adcs=09r0, r0, r2
=09=09ldr=09r2, [sp, #4]
=09=09adcs=09r0, r0, r3
=09=09adcs=09r0, r0, r2
=09=09adcs=09r0, r0, #0
=09=09ldmfd=09sp!, {pc}
ENDPROC(__csum_ipv6_magic)

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


