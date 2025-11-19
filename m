Return-Path: <linux-arch+bounces-14947-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A03C6FD15
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E39FE2F043
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535C36998B;
	Wed, 19 Nov 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VRh9ulT9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XK8cAQQ9"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952E368280;
	Wed, 19 Nov 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567325; cv=none; b=iKb83G2tbB2gg1T28TeFpGi0C7MVlBs0SQpEPQyI6vrqBpZqS8NgAB2Q+/hdknKAOrNiSq8/YZFrVGXwq+MosWI6Beq0EwhtzT5HbIwTPbz7MquzFV0TwdqD8rlSdX4lr9dSzZYoMTqus5t1FtIXS/WNv8PsWPYA5pvcnCR9AIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567325; c=relaxed/simple;
	bh=MStiUWaHLnkFbuKIFe0Os1WT6o/77tkLZdxBURkti9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEiQS3e/IFaHszi1Hjs6WxaCqGzHdFiFj5XkZ4l6F717c+pzGN8xS2MPjcr3A3BYRaf5o+gTsyF47UquIkdre21dUnkN9SjLo0br5VY0hovjxfctY+U4FT4NlHBAGC621j97TP3dDLN8QDdoY1Kba0hxncFuuFcnWo301Uo1j2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VRh9ulT9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XK8cAQQ9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Nov 2025 16:48:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763567317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQnlE2n5aekx+v6zObGqphQStw7ib6XRN1BfScwnLic=;
	b=VRh9ulT9FxvWXw7qMNvg+9uqEbxMCDbNhTdu0TX5v8Jes0ESbXArTw+TvOAvrxRS9JJ2HV
	JXYinsWrLLUTIDhNkVDo8fLhscZVlJtULXtH2F8ss4EgU+hPaS3aGl1MektltakP3CN5AS
	MR+m66XxqYw6tAt0DewTszz+Lq+yBh+ZO9bCCdD5EgizYN/0aHF3aHdNeVAqNlAE1p0xnH
	anshj0nr96xb7MViJ6sK/AT50w5MEHipWVDn3a7naUaCV36XkpcXZRam5SR1Ldaz6/+zlK
	edwu9fTV5jAk4FXDjYH0+qekDRokeOz/zYC1UIQt1SZJHvgDN8NzzGqdt45AMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763567317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQnlE2n5aekx+v6zObGqphQStw7ib6XRN1BfScwnLic=;
	b=XK8cAQQ9othT6G++4p2Pn+74xeBwkh0bSY/TQQSgsoPxSMehVrp8KtnZXI7Biuir2r6hnA
	WYH4a8uF8T6ihmBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/9] module: Introduce hash-based integrity checking
Message-ID: <20251119154834.A-tQsLzh@linutronix.de>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
 <f1dca9daa01d0d2432c12ecabede3fa1389b1d29.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f1dca9daa01d0d2432c12ecabede3fa1389b1d29.camel@HansenPartnership.com>

On 2025-04-29 10:05:04 [-0400], James Bottomley wrote:
> On Tue, 2025-04-29 at 15:04 +0200, Thomas Wei=C3=9Fschuh wrote:
> > The current signature-based module integrity checking has some
> > drawbacks in combination with reproducible builds:
> > Either the module signing key is generated at build time, which makes
> > the build unreproducible,
>=20
> I don't believe it does: as long as you know what the key was, which
> you can get from the kernel keyring, you can exactly reproduce the core
> build (it's a public key after all and really equivalent to built in
> configuration).  Is the fact that you have to boot the kernel to get
> the key the problem?  In which case we could insist it be shipped in
> the kernel packaging.

The kernel itself is signed. This is not a problem because distros have
the "unsigned" package which is used for comparison.
The modules are signed by an ephemeral key which is created at build
time. This is where the problem starts:
- the public key is embedded into the kernel. Extracting it with tooling
  is possible (or it is part of the kernel package). Adding this key
  into the build process while rebuilding the kernel should work.
  This will however alter the build process and is not *the* original
  one, which was used to build the image.

- the private key remains unknown which means the modules can not be
  signed. The rebuilding would need to get past this limitation and the
  logic must not be affected by this "change". Then the modules need to
  be stripped of their signature for the comparison.

Doing all this requires additional handling/ tooling on the "validation"
infrastructure. This infrastructure works currently without special
care.
Adding special care will not build the package exactly like it has been
built originally _and_ the results need to be interpreted (as in we
remove this signature and do this and now it is fine).

Adding hashes of each module into the kernel image looks like a
reasonable thing to do. I don't see any downsides to this. Yes, you are
limited to the modules available at build time but this is also the case
today with the ephemeral key. It is meant for distros not for individual
developers testing their code.

With this change it is possible to build a kernel and its modules and
put the result in an archive such as tar/ deb/ rpm. You can build the
package _again_ following exactly the same steps as you did before and
the result will be the identical archive.
Bit by bit.
No need for interpreting the results, stripping signatures or altering
the build process.

I fully agree with this approach. I don't like the big hash array but I
have an idea how to optimize that part. So I don't see a problem in the
long term.

> Regards,
>=20
> James

Sebastian

