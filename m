Return-Path: <linux-arch+bounces-12975-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A89B14046
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 18:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDD7188239F
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9502749C2;
	Mon, 28 Jul 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ADUyyw4I"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129E25E44D
	for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720080; cv=none; b=AMMQFfOvwbAQ1a52i4en00BgH5KzTMvHI1fREUDmzwBU9BteOcXuD5PdOcO3m608UYS1VYIZ3VmJ7lMybznVw5E4L4Het0AJDmDh+KTNZy1tRGcbFdZlUMKbijTl+Z50mQyGkwFXJyDDhxsh0D5l0MAP10IeKQ0dMvCjiKyr2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720080; c=relaxed/simple;
	bh=Y4ljMbNbX+OMnkLybnUIH3jYWnqLfyv0p+qfTNsHIus=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zkc6d7rgDg4g4kSF677kU2edsY+RUOVlCL2U2m0+dyoxNoVNMk+Aosni6j9zPhASWqYY1hgaMv7klJrrjXe61eNfoUIsUZ8wOwrjNPX/wYfOiVebsRL5SfWdbxpc9fjimXNiU6KM0KS4540GrDk6ncGWG44KmSeFXzA/pq0najQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ADUyyw4I; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y4ljMbNbX+OMnkLybnUIH3jYWnqLfyv0p+qfTNsHIus=;
	t=1753720078; x=1754929678; b=ADUyyw4Ig/UNeBJPbQQgOrRYrEr/S5qsPmyIKqvdOYOTpbQ
	cykQ02mpadn1BGp+CXTuWF/rINHuazqi1Vp5lmise3RWiCctQbY+jUldEkyfeerCciY5iU1fBHRxq
	+eQDOw8+QgjRU/qy2MUMIDs2hpSuFCImMxG56v6C8ubZm+UJWWHZghfDBm7a0ag59hE28EjcV2DnH
	H/SJ1WPsAgmwHAqae6/Ky0Nd5nNDoi1fK2noxhWy70dKdN0YeHSfA5ZXKx2W0V83ufNDDerLL9Jvt
	JFuy7VJkhdgjPeJdxXSxjecaCvW0Vb70ZYYG2YzudTkDDxaoQdo6wW4d2IC0082A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ugQhe-0000000D1aq-0lIZ;
	Mon, 28 Jul 2025 18:27:54 +0200
Message-ID: <1310a0eaf8c8e3a1e944ad3f4f289f02164702cf.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 tiwei.btw@antgroup.com
Date: Mon, 28 Jul 2025 18:27:53 +0200
In-Reply-To: <20250728160419.3256752-1-tiwei.bie@linux.dev>
References: 
	<233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
	 <20250728160419.3256752-1-tiwei.bie@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-29 at 00:04 +0800, Tiwei Bie wrote:
> > > +++ b/arch/um/include/asm/spinlock.h
> > > @@ -0,0 +1,8 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __ASM_UM_SPINLOCK_H
> > > +#define __ASM_UM_SPINLOCK_H
> > > +
> > > +#include <asm/processor.h>
> > > +#include <asm-generic/spinlock.h>
> > > +
> > > +#endif /* __ASM_UM_SPINLOCK_H */
> >=20
> > Do we need this file? Maybe asm-generic should be including the right
> > things it needs?
>=20
> I added this file to include asm/processor.h; otherwise, there would be
> a lot of compilation errors. Other architectures seem to do the same:
>=20
> $ grep -r asm/processor.h arch/ | grep asm/spinlock.h
> arch/arm/include/asm/spinlock.h:#include <asm/processor.h>
> arch/alpha/include/asm/spinlock.h:#include <asm/processor.h>
> arch/arc/include/asm/spinlock.h:#include <asm/processor.h>
> arch/hexagon/include/asm/spinlock.h:#include <asm/processor.h>
> arch/parisc/include/asm/spinlock.h:#include <asm/processor.h>
> arch/x86/include/asm/spinlock.h:#include <asm/processor.h>
> arch/s390/include/asm/spinlock.h:#include <asm/processor.h>
> arch/mips/include/asm/spinlock.h:#include <asm/processor.h>
> arch/loongarch/include/asm/spinlock.h:#include <asm/processor.h>

Except for loongarch they all do something else too though. Feels to me
um (and loongarch) really shouldn't need that file.

> > I feel like probably this should at least for now be mutually exclusive
> > with time-travel=3D parameters, at least if it's not 1? Or perhaps only
> > with time-travel=3Dext?
>=20
> Currently, the UML_TIME_TRAVEL_SUPPORT option depends on !SMP:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/um/Kconfig?h=3Dv6.16#n218
>=20
> so they can't be enabled at the same time during build.

Oops, sorry, missed that. Good. I didn't see anything particularly wrong
in the time code, but I'm sure it won't work there :)

johannes

