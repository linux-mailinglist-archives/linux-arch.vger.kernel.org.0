Return-Path: <linux-arch+bounces-12982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F2B1503E
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jul 2025 17:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229943B3304
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jul 2025 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432F2293C73;
	Tue, 29 Jul 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N7w5MmHJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C4293C71
	for <linux-arch@vger.kernel.org>; Tue, 29 Jul 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803460; cv=none; b=pbBpx//RJAnrYNqX050/zZxMva1hFgqfbvywTbuM31ogd8Qvs4CWFe595HdI7ro5TIIHB54x0cIShciFnaiBFoW25c748ubgGpzh+WeV10B+sBc3dlxNiOL1/VAjb1aArugdZf9nH0HPM3dLeAook3fIolLsbbfPI51txd7GU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803460; c=relaxed/simple;
	bh=jeQdashjdQNI8gbjgURwp4/QnqHp/DiqcU6QF/6BzDI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OaJ2qvkwYrTlslUQDfKCJphKRI/bqSaOMElSW1F6jIhlqaUMY9+m7+LG4kYOXiZLyomapM7dGpRsUocGYUJylw/1/l00PizkJcvKi8hTI5En5V/CLlfBH4SIlpLIczfmD0THFP3jUSLiCADPKgU0VBeZz2XXDwIDiq6xOeFCz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N7w5MmHJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jeQdashjdQNI8gbjgURwp4/QnqHp/DiqcU6QF/6BzDI=;
	t=1753803458; x=1755013058; b=N7w5MmHJf72RlRT7Q2QVKvVg7X0m6jjBllM/iO7dIdQD7jM
	C7NGQ7dAg2mItK57/1C8MmgUwl/sdYOHLhDXNqP/OhQDFnKv74BDh7T9d4JiTxZXicM9NIk8jzSwd
	AuCcBRyIo3BmvGbu/9aYnkGbTLkjJyMEgpKWlt3uH8Kc87+b0YxNprJW3kgX9xV2l1p5hrvQlOSns
	VFwlGBqMDezsrx7g12oztK5HsvNxyKee533ta/i1n1b8Dtv9RdEmIERsUcDfbZ1n6mcnOt2CuEO2h
	NEVKaGDTMhfKT5wEerOfBZvwt0Z095UPrbLMaeFbraQ9IJsFwrvWMFDQaBMflsOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ugmOK-0000000EkPg-3Wtz;
	Tue, 29 Jul 2025 17:37:25 +0200
Message-ID: <8bfc7ba021d584d30ac25c06d142d06dd72f15d0.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 tiwei.btw@antgroup.com
Date: Tue, 29 Jul 2025 17:37:24 +0200
In-Reply-To: <20250729150651.1957466-1-tiwei.bie@linux.dev>
References: 
	<1310a0eaf8c8e3a1e944ad3f4f289f02164702cf.camel@sipsolutions.net>
	 <20250729150651.1957466-1-tiwei.bie@linux.dev>
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

On Tue, 2025-07-29 at 23:06 +0800, Tiwei Bie wrote:
> On Mon, 28 Jul 2025 18:27:53 +0200, Johannes Berg wrote:
> > On Tue, 2025-07-29 at 00:04 +0800, Tiwei Bie wrote:
> > > > > +++ b/arch/um/include/asm/spinlock.h
> > > > > @@ -0,0 +1,8 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +#ifndef __ASM_UM_SPINLOCK_H
> > > > > +#define __ASM_UM_SPINLOCK_H
> > > > > +
> > > > > +#include <asm/processor.h>
> > > > > +#include <asm-generic/spinlock.h>
> > > > > +
> > > > > +#endif /* __ASM_UM_SPINLOCK_H */
> > > >=20
> > > > Do we need this file? Maybe asm-generic should be including the rig=
ht
> > > > things it needs?
> > >=20
> > > I added this file to include asm/processor.h; otherwise, there would =
be
> > > a lot of compilation errors. Other architectures seem to do the same:
> > >=20
> > > $ grep -r asm/processor.h arch/ | grep asm/spinlock.h
> > > arch/arm/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/alpha/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/arc/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/hexagon/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/parisc/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/x86/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/s390/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/mips/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/loongarch/include/asm/spinlock.h:#include <asm/processor.h>
> >=20
> > Except for loongarch they all do something else too though. Feels to me
> > um (and loongarch) really shouldn't need that file.
>=20
> Sorry for the confusion. My point is that since other architectures
> also do this, it seems common practice to include asm/processor.h in
> asm/spinlock.h when necessary.

Yeah, I understand.

>=20
> The reason we need to include asm/processor.h in asm/spinlock.h on UML
> is because:
>=20
> ticket_spin_lock() (which is an inline function indirectly provided by
> asm-generic/spinlock.h) relies on atomic_cond_read_acquire(), which
> is defined as smp_cond_load_acquire().

Right, but that's not the architecture's "fault".

It seems to me that either spinlock.h should include asm/processor.h for
it, or (at least, but I think less appropriate) asm-generic/spinlock.h
should be doing this.

> On UML, smp_cond_load_acquire() is provided by asm-generic/barrier.h,
> and it relies on smp_cond_load_relaxed(), which is also provided by
> asm-generic/barrier.h on UML. And smp_cond_load_relaxed() is a macro
> that relies on cpu_relax(), which is provided by asm/processor.h.

In general though, there ought to be some definition of which header
file(s) is/are expected to provide smp_cond_load_acquire() and/or
atomic_cond_read_acquire(). And that header file/those header files
should be included by the files that use the functions/macros.


IOW, I think you've stumbled across an inconsistency in the generic
files, and hence we should fix that, rather than having each
architecture paper over it.


johannes

