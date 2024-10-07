Return-Path: <linux-arch+bounces-7751-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1F499293A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 12:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968EE1C2313C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 10:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150FA18A93F;
	Mon,  7 Oct 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b="q80ZG8fe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.syndicat.com (mail.syndicat.com [62.146.89.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B94317E;
	Mon,  7 Oct 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.89.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297043; cv=none; b=GZwCb3K3hSnSB48gWjH3pkerk9MjRSWIxfIM0QVzGnwizVgbOp0ybIV5HcRM9YIcTswTaOeUaZ2Fz+vyFv/55vqW/3Ue9DDiQcg7513WC4p05LQ4Xb9boWUyS//jKANVdSrZghwCTnix2syLn8vZ9qPBu8GPwg4RU429Tx0tDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297043; c=relaxed/simple;
	bh=ZDdQxa2zW8ATvib8cfZrqB0d6UaFhGcApr3Y+DfNnoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyYZYc7Vmn2xOfRTe/6vr2uxxGDF1o/EvN4RnSI6uAYVmBS4BDVmbaoAzJEN8t5L7Yvgl/AacdnxKL6nDRLSemdls0c82+v1VIxmZrXaAqNNQryFkGXSAVK/KyNOgD9MO87nTPK5GcgoCh2jlXMGTg9L1yeNRx0B9P1NbBYgDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com; spf=pass smtp.mailfrom=syndicat.com; dkim=pass (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b=q80ZG8fe; arc=none smtp.client-ip=62.146.89.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syndicat.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=syndicat.com; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:Reply-To:To:From:Sender:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EAprCz2Gwkm9+pncvZr2IJ9AQor7OnWEiPmOKypE4qM=; b=q80ZG8feEmafqmtw50AGULQgzC
	IwN3tCOeXvM5hn1fH50Ucu4L6mzmZIoDlIrYPC0yiQNideCrU3IdTqYtQ50ikYSSj0bTzM7voe/9D
	BYz1SC6qdLx8BGQJUAgxcfKWBkMnJ8JNITx6w3PL5lejmIZKo+Sb5KSRO4s7wBs5YoSE=;
Received: from localhost.syndicat.com ([127.0.0.1]:62311 helo=localhost)
	by mail.syndicat.com with esmtp (Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1sxkzy-0002o3-0X;
	Mon, 07 Oct 2024 12:29:54 +0200
X-Virus-Scanned: amavisd-new at syndicat.com
Received: from mail.syndicat.com ([127.0.0.1])
	by localhost (mail.syndicat.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S8PNeOnJl_IF; Mon,  7 Oct 2024 12:29:53 +0200 (CEST)
Received: from [62.89.4.53] (port=62965 helo=gongov.localnet)
	by mail.syndicat.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1sxkzx-0007Je-1p;
	Mon, 07 Oct 2024 12:29:53 +0200
From: Niels Dettenbach <nd@syndicat.com>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Reply-To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
Date: Mon, 07 Oct 2024 12:29:46 +0200
Message-ID: <3635258.LM0AJKV5NW@gongov>
Organization: Syndicat IT&Internet
Disposition-Notification-To:
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <45f3a10c-8695-42cb-abb8-8c13ce1a476b@suse.com>
References:
 <2210883.Icojqenx9y@gongov> <864022534.0ifERbkFSE@gongov>
 <45f3a10c-8695-42cb-abb8-8c13ce1a476b@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16948470.geO5KgaWL5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Report-Abuse-To: abuse@syndicat.com (see https://www.syndicat.com/kontakt/kontakte/)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.syndicat.com
X-AntiAbuse: Original Domain - 
X-AntiAbuse: Sender Address Domain - syndicat.com

--nextPart16948470.geO5KgaWL5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Niels Dettenbach <nd@syndicat.com>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Reply-To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
Date: Mon, 07 Oct 2024 12:29:46 +0200
Message-ID: <3635258.LM0AJKV5NW@gongov>
Organization: Syndicat IT&Internet
In-Reply-To: <45f3a10c-8695-42cb-abb8-8c13ce1a476b@suse.com>
MIME-Version: 1.0

Am Freitag, 4. Oktober 2024, 12:29:57  schrieb J=C3=BCrgen Gro=C3=9F:
> On 04.10.24 12:05, Niels Dettenbach wrote:
>=20
> > Virtual machines under Xen Hypervisor (DomU) running in Xen PV mode use
> > a
> > special, nonstandard synthetized CPU topology which "just works" under
> > kernels 6.9.x while newer kernels wrongly assuming a "crash kernel" and
> > disable SMP (reducing to one CPU core) because the newer topology
> > implementation produces a wrong error "[Firmware Bug]: APIC enumeration
> > order not specification compliant" after new topology checks which are
> > improper for Xen PV platform. As a result, the kernel disables SMP and
> > activates just one CPU core within the PV DomU "VM" (DomU in PV mode).
> >=20
> > The patch disables the regarding checks if it is running in Xen PV
> > mode (only) and bring back SMP / all CPUs as in the past to such DomU
> > VMs. The Xen subsystem takes care of the proper interaction between
> > "guest" (DomU) and the "host" (Dom0).
> >=20
> > Signed-off-by: Niels Dettenbach <nd@syndicat.com>
>=20
>=20
> Does the attached patch instead of yours help?
>=20
> Compile tested only.


it does =C3=9F)))


domU:
=2D- snip --
vcpus=3D6
cpu=3D"12,13,14,15,23,24"
=2D- snap --


=2D- snip --
[    0.500458] cpu 0 spinlock event irq 1
[    0.500485] VPMU disabled by hypervisor.
[    0.501273] Performance Events: unsupported p6 CPU model 62 no PMU drive=
r, software events only.
[    0.501304] signal: max sigframe size: 1776
[    0.501410] rcu: Hierarchical SRCU implementation.
[    0.501428] rcu:     Max phase no-delay instances is 400.
[    0.502032] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.502309] smp: Bringing up secondary CPUs ...
[    0.502759] installing Xen timer for CPU 2
[    0.503384] installing Xen timer for CPU 4
[    0.503838] cpu 2 spinlock event irq 16
[    0.503870] cpu 4 spinlock event irq 17
[    0.504867] installing Xen timer for CPU 1
[    0.505495] installing Xen timer for CPU 3
[    0.506125] installing Xen timer for CPU 5
[    0.506363] cpu 1 spinlock event irq 33
[    0.507869] cpu 3 spinlock event irq 34
[    0.507901] cpu 5 spinlock event irq 35
[    0.507923] smp: Brought up 1 node, 6 CPUs
=2D- snap --



thank you very much!


niels.


--nextPart16948470.geO5KgaWL5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEen+3H2N8RDyGzUZnDbtaiEWSKkQFAmcDuBoACgkQDbtaiEWS
KkQnsg/+KCqd6M8AuOs1taM3LOothfBX+XvsqupFVM3+d6q88qITNequbF+q5ktV
QfVFy5i3GcIah1mx4cXMEBGipYczDEHQ9qQg2WnyRkgXBstPByztA2N47h7EyzXd
UcEDcApFiuonMxVV6r5/j01OIRAmk7zLrJzDpzUkh6ybJV4rpj+b+rabboHS1wA3
G5xmRCSZVGXQaxAKWUzt2IL/NEd0/36JvZgMukolf5Dj9Mbe8Uy7EhGxTCTUCQyO
kbfb7kd/HVdW4+tFXAU+U18Lvmg/cKt0ECdv/Adj+8ZYBfAgAJyWglQIgGlozHCm
OYPjBIEQe4KdODFg8xFa4Z4gQbEsfB1tZekj/rzMk54iHX71DYPNjCD9Mdk3+W1K
EUtOnLDZuLklbNfr6fE2NLcClVG4BeaFAj4xwY4o7YxCz0KUlvJkX6wdHGojCu+F
kvBIXDLu/0Kvor1mPSlsnWZ0No+pq1MsiRgXeLGhVW08wO4RQD9ZZAu/KEsjkZK+
tw3jTazLcfxsJlh5zAK/toG0ST9HNac5AJ1BYjFKW6+wbVNIjlAkCAB/MLIaTmq4
da0881C3+yYlk0aJMGSxqTW7S9hvECHsWoFak+6E/vy1pvYqJDrkAflYPufsVpjv
RNo2XOKfCztP2oSOypiQJSdvl+9NwXWhbJvwc1m7HNWFHYU5xJQ=
=WEKw
-----END PGP SIGNATURE-----

--nextPart16948470.geO5KgaWL5--




