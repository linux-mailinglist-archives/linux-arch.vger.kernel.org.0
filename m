Return-Path: <linux-arch+bounces-7689-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5475990172
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 12:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EC01C22156
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76514A60F;
	Fri,  4 Oct 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b="NTzg6eCi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.syndicat.com (mail.syndicat.com [62.146.89.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC911369BB;
	Fri,  4 Oct 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.89.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038195; cv=none; b=ql3Sfevd8iyTysK6uvu5gEABSyxKMX3N05FI4+Hx5HsTF0MalbCMQa6Nkj8DpfqvC0FKdXNwr52t4pnYdLUpZWqAMaCNfhNZCWahIJsgUCPyPNaYFJtJBzc1+GDrrxwFbRjoTZRWq22GNzF+oa1s8Gbdl/5IhqWfBd0Xn7M1wUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038195; c=relaxed/simple;
	bh=GrbPeAK5qkQQQwjlzw5HoXFZHBNyvLny9Hy3BfR+P00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7UM5j5KXvqwjLdW5rQ/RLNnB4GBbOdkOaw6qWPOnGivLT1BZYTi8fn1rhmLrIHoy8ZhXM9NltHmBEz/hymsV8qArnU/K5x0AzpiVJ4Ya0pdQWaQGl9Vr/IfyeBOohnVoImnfGGI992JTb87Z4XsjCbAdMuUFXUsKhzhR/PHIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com; spf=pass smtp.mailfrom=syndicat.com; dkim=pass (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b=NTzg6eCi; arc=none smtp.client-ip=62.146.89.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syndicat.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=syndicat.com; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/QkDROfGDvJqG3hdiAViZ9A3NRJn+vKEY02ZDZuWBAs=; b=NTzg6eCip1bXj4b+mJrtsVSKkG
	brkV800C7iWdYj9nQZOiN9GF1wqVl54fU3p0Wu0Yf821ssjmHMCtrH2QrbT6sN395/Mmo+gXkU1QU
	1h8d2eG9N6Iv5FVjJx+aTEiqb2cYcvp5F4bC7eexjmRPrQhPvCkKN76xU3pDHnxTtPnc=;
Received: from localhost.syndicat.com ([127.0.0.1]:54665 helo=localhost)
	by mail.syndicat.com with esmtp (Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1swffQ-0005tE-0T;
	Fri, 04 Oct 2024 12:36:12 +0200
X-Virus-Scanned: amavisd-new at syndicat.com
Received: from mail.syndicat.com ([127.0.0.1])
	by localhost (mail.syndicat.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yx5r5LuOo7ZZ; Fri,  4 Oct 2024 12:36:11 +0200 (CEST)
Received: from [62.89.4.53] (port=48282 helo=gongov.localnet)
	by mail.syndicat.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1swffP-0003ug-1l;
	Fri, 04 Oct 2024 12:36:11 +0200
From: Niels Dettenbach <nd@syndicat.com>
To: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
Date: Fri, 04 Oct 2024 12:36:09 +0200
Message-ID: <14053472.RDIVbhacDa@gongov>
Organization: Syndicat IT&Internet
Disposition-Notification-To: Niels Dettenbach <nd@syndicat.com>
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
Content-Type: multipart/signed; boundary="nextPart13610981.dW097sEU6C";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Report-Abuse-To: abuse@syndicat.com (see https://www.syndicat.com/kontakt/kontakte/)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.syndicat.com
X-AntiAbuse: Original Domain - 
X-AntiAbuse: Sender Address Domain - syndicat.com

--nextPart13610981.dW097sEU6C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Niels Dettenbach <nd@syndicat.com>
Subject: Re: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
Date: Fri, 04 Oct 2024 12:36:09 +0200
Message-ID: <14053472.RDIVbhacDa@gongov>
Organization: Syndicat IT&Internet
Disposition-Notification-To: Niels Dettenbach <nd@syndicat.com>
In-Reply-To: <45f3a10c-8695-42cb-abb8-8c13ce1a476b@suse.com>
MIME-Version: 1.0

Am Freitag, 4. Oktober 2024, 12:29:57  schrieben Sie:
> On 04.10.24 12:05, Niels Dettenbach wrote:
> > Virtual machines under Xen Hypervisor (DomU) running in Xen PV mode use=
 a
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
> Does the attached patch instead of yours help?
>=20
> Compile tested only.

Thanks J=C3=BCrgen - will try until monday...


niels.






--nextPart13610981.dW097sEU6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEen+3H2N8RDyGzUZnDbtaiEWSKkQFAmb/xRkACgkQDbtaiEWS
KkRfZA//XvrnCNs6eEXQKRO7D+ih4l5qYPj4xxrC3yP2Kf6syfIVEHPmC+wCSTZF
qGS11tqp7ePVeyWGvmjJ1M28XDY0tKXM32v937OpqN4L6ynohlEa/zk6ibaKUvg7
eEQpMOQ9aDeKMH0MUvdB4YWewmHvV/a3zv3rEiUHvFFsaEQBGwv32+t8ShuiCm+p
e430u+L0fDcLbkLjmGpW3zyehkRImVY/gvQ05LM7/JR6C49HzXSSB/juqfmQimf4
y9PkbmbzxRqwUjSGxHF1dj6c/ypak+kdS+/J8ht39kcVk4vOOmTuaj3xp7cGU7O1
WSLvDzB+YA2cB0xeLBq+tJi6AVdS9iCVfUcz4yopq3U5V4uju1qTubUP3K9VfUs9
Blsvfk79Gf5eaBAp78dZFPiJ0f5ZujHpg4e99wL7F2HLa0XQJjIGCw/jeQuYNFxe
WfpM7Lv+RTFt8xkBMTZWE13J69yd+6GIibEsupt1A3017uhltNXtnQdIzbhtcQkZ
wNnHqR4n+T0UJArieDQ/wxhPW25o6+3xcrZEWZHWQgmfOpmybyRlTLX/Sukd6N0W
uxMjchWf6+jTvMTFipjKHGIWs37svWEvcj563ufgIe8/qSV/FDHoo/DZvcIgBxdl
Es4tYKVHUu6iqAOHsiTuHvjXUJ8tk/nTXE8TA58c1XhF/7IjhmQ=
=JRW+
-----END PGP SIGNATURE-----

--nextPart13610981.dW097sEU6C--




