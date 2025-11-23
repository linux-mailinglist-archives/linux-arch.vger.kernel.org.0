Return-Path: <linux-arch+bounces-15058-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D8C7E4A2
	for <lists+linux-arch@lfdr.de>; Sun, 23 Nov 2025 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876B13A9CB2
	for <lists+linux-arch@lfdr.de>; Sun, 23 Nov 2025 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD79220C461;
	Sun, 23 Nov 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wo8WQpA6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H8a+b7E4"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFEA14F125;
	Sun, 23 Nov 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917860; cv=none; b=K++/V/Ye4GGVMMVI7ch5SinaBQhunRrEKTwRMDur3QU1zyTRoLcqB3Emh9i2fEyBiGG7lfa8vfhEOl2Wr/vFks8NoQvdI+ykzmKf8W52C92HqLXJzSFP0cuJEvQjnjGysONQAlfgUyFSqJFNdH02yxRMuyLgOVcoUb24qn+tSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917860; c=relaxed/simple;
	bh=1TvV2CIHODDVvcsCFmEG146E5nX65wm9DJeM5XXQwW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyQw9rNx7Y83G9VuO8fNSOybgs1V6SSB1o2n2QAXsv+7Gc9tPvHD3YGy4/+kpJuhNrnrktc+uwsEljtsO+lRz3JfK2QMFP2CuWG67pZEaqa3Qpf9Qn0uhGhIeKtxybS0F4zI4I8mwZbjD9ip+dd6tC2uCcTOb79B/1Iixf9wJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wo8WQpA6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H8a+b7E4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Nov 2025 18:10:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763917856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TvV2CIHODDVvcsCFmEG146E5nX65wm9DJeM5XXQwW8=;
	b=wo8WQpA6NfO5oq1yU5MNIxMljtmOFymvIKwf+z4UpWIwlmWK66C9CioLMyGAOPzFA0j76x
	feTDuA2whfyAklcQwWO/kFWvgwWMGymo+2py2F9m0snFPcsiGb2px0IjJZXqcGHrvur9VH
	JltI0wdrt+vgV2fQLaCE9TaaYnJ1sEPv3Xcrqp0ibg+AnJOIAG+nn4YMVG874FGgvxpo2n
	MJMTZztLqBmS37z8mUn6XD5/rXrSl5JNZ15qQTziNCOzq622/JthL+xDeTbEIH+I9kWOCg
	JKL5L5uhHGwBitxvsz2++MsIcD4j/XrNx79t/M05VLbd8rdWlYJFtlifZn2GHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763917856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TvV2CIHODDVvcsCFmEG146E5nX65wm9DJeM5XXQwW8=;
	b=H8a+b7E4pwlDvJgRrStalE/DblBpY6KGjVhb8qJAv2yo/f7vbjkwGdH54cVGXBkqaDHNNk
	EznfI2lT8cZDOYBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paul Moore <paul@paul-moore.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	James Morris <jmorris@namei.org>,
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
Subject: Re: [PATCH v3 7/9] module: Move lockdown check into generic module
 loader
Message-ID: <20251123171054.wnPvVQrF@linutronix.de>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
 <20250429-module-hashes-v3-7-00e9258def9e@weissschuh.net>
 <20251119112055.W1l5FOxc@linutronix.de>
 <CAHC9VhTuf1u4B3uybZxdojcmz5sFG+_JHUCC=C0N=9gFDmurHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHC9VhTuf1u4B3uybZxdojcmz5sFG+_JHUCC=C0N=9gFDmurHg@mail.gmail.com>

On 2025-11-19 14:55:47 [-0500], Paul Moore wrote:
> On Wed, Nov 19, 2025 at 6:20=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > On 2025-04-29 15:04:34 [+0200], Thomas Wei=C3=9Fschuh wrote:
> > > The lockdown check buried in module_sig_check() will not compose well
> > > with the introduction of hash-based module validation.
> >
> > An explanation of why would be nice.
>=20
> /me shrugs
>=20
> I thought the explanation was sufficient.

Okay. So if it is just me and everyone is well aware then okay.

Sebastian

