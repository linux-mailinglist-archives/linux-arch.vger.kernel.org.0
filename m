Return-Path: <linux-arch+bounces-10378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4352AA46092
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 14:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D401F3B0491
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 13:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362621930F;
	Wed, 26 Feb 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MVNxQ8AF"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81687219308;
	Wed, 26 Feb 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575974; cv=none; b=cXOXykQqXGtLOLSGeO/Ilkmr5NQRPwNHONZ6uJRV2KTxw9unESpTQGXbf7A6z1bsX3GLnAa6hMIojX/0wqcLVcu0xYAAb2tx52iFlHftwEFyGt9VvPVqqaOaLFwSXBNwsU+ck2DHAbuBULbxm0+7SM8SnFko9L6IyIF3h3ep1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575974; c=relaxed/simple;
	bh=O1Y5vBykNHMTTGHcg8y79qXJPM38/IRWr889jowtlfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ruI7Tw3pwC/cZbO/xf86qQhwLYT7TxxXs43Y6QqWaRnZ7xzbaXb21Z9zlIva/Zj4OfYSnaK5OJOdVd0XwaYcfAc7bppXgS5Iw6ID85dtM4/8A4ldSBCv9clZWEWy9gkSi005G4Z+lU1Qc48zH6GwaVjjLk1pz/AJLR8ELzx7JbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MVNxQ8AF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qJBErG/pSE3mwR2gO0Zf0GO3sxAtsZqzG79Fy9J4HfA=;
	t=1740575972; x=1741785572; b=MVNxQ8AFiXZ/1S5md0GWysYz6Iuxg849085k4vYsCv3lWSD
	JJn3LQz7IcSGKiCEv5X20hbnUPCbEFde+dwyF2zYHTrbrS0PuC2wmNAhc1zxEsIzYZdeZi9kBkKdc
	Zb4dTPH2tZOuKwgKoHCo/7clo9wrNC74ocTAHHUSbl9dPuvjeIhizu+iCX5Iqf9RKbOpScf3XVV02
	umPHodEYW+xPFoKXYycHwUbZrwQCiyfF3lbu+fMjF46iXbYvM+kUH5+TZEICm4V07H6+bOyHwo913
	RnYtcM4unAUCIIA+TduvsbvY3Z5qLyTbSf4GJmrUIUi33hIgpsMj4SIZTJpzCnww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tnHJs-0000000BUdH-0WaR;
	Wed, 26 Feb 2025 14:19:24 +0100
Message-ID: <159a83bf5457edbabcc1e88ee5ab98cf58ca6cb0.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] x86: avoid copying dynamic FP state from init_task
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
 x86@kernel.org, 	briannorris@chromium.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Date: Wed, 26 Feb 2025 14:19:19 +0100
In-Reply-To: <Z78SVdv5YKie-Mcp@gmail.com>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
	 <20241217202745.1402932-4-benjamin@sipsolutions.net>
	 <Z78SVdv5YKie-Mcp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-02-26 at 14:08 +0100, Ingo Molnar wrote:
>=20
> * Benjamin Berg <benjamin@sipsolutions.net> wrote:
>=20
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > The init_task instance of struct task_struct is statically allocated an=
d
> > may not contain the full FP state for userspace. As such, limit the cop=
y
> > to the valid area of init_task and fill the rest with zero.
> >=20
> > Note that the FP state is only needed for userspace, and as such it is
> > entirely reasonable for init_task to not contain parts of it.
> >=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > Fixes: 5aaeb5c01c5b ("x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAM=
IC_TASK_STRUCT and use it on x86")
> > ---
> > =C2=A0arch/x86/kernel/process.c | 10 +++++++++-
> > =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index f63f8fd00a91..1be45fe70cad 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -92,7 +92,15 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
> > =C2=A0 */
> > =C2=A0int arch_dup_task_struct(struct task_struct *dst, struct task_str=
uct *src)
> > =C2=A0{
> > -	memcpy(dst, src, arch_task_struct_size);
> > +	/* init_task is not dynamically sized (incomplete FPU state) */
> > +	if (unlikely(src =3D=3D &init_task)) {
> > +		memcpy(dst, src, sizeof(init_task));
> > +		memset((void *)dst + sizeof(init_task), 0,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch_task_struct_size - sizeof(=
init_task));
> > +	} else {
> > +		memcpy(dst, src, arch_task_struct_size);
>=20
> Note that this patch, while it still applies cleanly, crashes/hangs the=
=20
> x86-64 defconfig kernel bootup in the early boot phase in a KVM guest
> bootup.

Oh, outch. It seems that arch_task_struct_size can actually become
smaller than sizeof(init_task) if the CPU does not have certain
features.

See fpu__init_task_struct_size, which does:

  int task_size =3D sizeof(struct task_struct);
  task_size -=3D sizeof(current->thread.fpu.__fpstate.regs);
  task_size +=3D fpu_kernel_cfg.default_size;

I'll submit a new version of the patch and then also switch to use
memcpy_and_pad.

Benjamin

