Return-Path: <linux-arch+bounces-14904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2AAC6E338
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 12:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5DA562BB64
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02AE35295B;
	Wed, 19 Nov 2025 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwIBFnys";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PaAcT0Pa"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6295351FDE;
	Wed, 19 Nov 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551266; cv=none; b=Iqbb6fRIino9O6WtwIgaDTiqZoQs+ncHgNOTNbf6tlChBNAazLrIUMp5xw7GzLN13bC+GZkznC5DvfQuWEDV6jqUslB47ja9Rd6txg+8Dinj8dwFucaaCq5BfkSGBo22PELlPOJLEXWANUKTl17EoYVXA/+0MpFBydtcWRrNIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551266; c=relaxed/simple;
	bh=wUSBlZZ9YDio7KtZN+X06BL6FGFKBS5aTCskRkM16k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6UtBXukTqsSg1ZGSFVDw+F67+FIcD3tAPfv3Qn8Yz8TqJTCBTnbNEKgCFelPc9nZvkeFXgauHKppLcmtJ7qwOh34sAcJwFaXkgVf38vHE/r2FHVyqQS+qT+wXo3uc8gjRYiG1QHc79ffmzdewOxjHQL1BFbslLqyUMa2hSBAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwIBFnys; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PaAcT0Pa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Nov 2025 12:20:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763551257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUSBlZZ9YDio7KtZN+X06BL6FGFKBS5aTCskRkM16k8=;
	b=JwIBFnysf2LFLEtQg0xbgBLVccfduk/drgzvy4AakLpJLS1rDRyQ3SzGNJg3IqMxpjwJlF
	cJrockj9vsQL4Rudtcco4j++0lF0oIiyoJs3cMm0ClblnX8RsGH/ozyLeD57cKb8+aSSJA
	QI9lVHLOUmernjmTs12vttLTxWC+aCvD6dUgyV5Kjfq3bliqCoXkbvquz3cuHyK0cs9QMH
	YMMKDLmCGd5XtftYaZeXwOfc8qiUI6pUaSfM6z2O3TCfhMLq5vQPTSpyC606DZEbtIpXr0
	7C9H0dgS3L9wYZ1tvhxQJHgIS2xnolt2VlX39CkSU6ia9+iUQslt8YQZYkLMHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763551257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUSBlZZ9YDio7KtZN+X06BL6FGFKBS5aTCskRkM16k8=;
	b=PaAcT0Pa0I47odYk/hl8N5o9JPaoc9DwKGKLs5RMYXX+0Dgn5BKBKHZSE3snhCH4dps8hX
	5JRbzpviPWRRL3Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
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
Subject: Re: [PATCH v3 7/9] module: Move lockdown check into generic module
 loader
Message-ID: <20251119112055.W1l5FOxc@linutronix.de>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
 <20250429-module-hashes-v3-7-00e9258def9e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250429-module-hashes-v3-7-00e9258def9e@weissschuh.net>

On 2025-04-29 15:04:34 [+0200], Thomas Wei=C3=9Fschuh wrote:
> The lockdown check buried in module_sig_check() will not compose well
> with the introduction of hash-based module validation.

An explanation of why would be nice.=20

> Move it into module_integrity_check() which will work better.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Sebastian

