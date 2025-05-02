Return-Path: <linux-arch+bounces-11779-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A00AA6B0B
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 08:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CE21B6643D
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83066266B6F;
	Fri,  2 May 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CxKUsKab"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC81D554;
	Fri,  2 May 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746168798; cv=none; b=qVvAvWmfh0pGb1v+56+tEfcByZW96ygD2dE7c4N0C+cHK0fpawi/xWvbWEt6dSJ1F39hFRmA8KFdXCEuXvYvu2T6HE68UKr+LgdRJPiWCBkLZFYHa2ovHfppaU7QTemObD4dC5mbiPxn9DsizOc+Ot5A7T8TO0FXsAiUucotPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746168798; c=relaxed/simple;
	bh=AEdRU+ogQrE6gQAgP/rybtN8TOhshZ7X86ciQDX554g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msPR/UMfLyCejRg06M6wo+pKtRMNTiBPAxVkHPQTXjXgNqa/A0sDLR1ZSn1JoD+K/BaqeNhvAsfAznKTLTdSYA/2F+aEJr6nmcjtkucmwXRXzBCdtYDui6NGPKHNntdiYKgsWfCCr64P+ity25p5dfglEUvekY2F//o9YL3hTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CxKUsKab; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1746168790;
	bh=AEdRU+ogQrE6gQAgP/rybtN8TOhshZ7X86ciQDX554g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxKUsKabvVQtCyoctO8MV2iUdgbSXO1OeNK+W2RsL9m4NVcoUrzpeI7zuNg2eC3IS
	 ZL0Jz4TZ9bVREPe8YN+Ocj0q2Hc+biSc2XfA95gtj8Z+2GrX2G118bp/uIjQ0QmRMk
	 XDnIezQvPUDxsyD5F02EsfUCEVYsV3PK2uLBkSiQ=
Date: Fri, 2 May 2025 08:53:09 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/9] module: Introduce hash-based integrity checking
Message-ID: <840b0334-71e4-45b1-80b0-e883586ba05c@t-8ch.de>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1dca9daa01d0d2432c12ecabede3fa1389b1d29.camel@HansenPartnership.com>

Hi James,

On 2025-04-29 10:05:04-0400, James Bottomley wrote:
> On Tue, 2025-04-29 at 15:04 +0200, Thomas Weißschuh wrote:
> > The current signature-based module integrity checking has some
> > drawbacks in combination with reproducible builds:
> > Either the module signing key is generated at build time, which makes
> > the build unreproducible,
> 
> I don't believe it does: as long as you know what the key was, which
> you can get from the kernel keyring, you can exactly reproduce the core
> build (it's a public key after all and really equivalent to built in
> configuration).  Is the fact that you have to boot the kernel to get
> the key the problem?  In which case we could insist it be shipped in
> the kernel packaging.

See below.

> >  or a static key is used, which precludes rebuilds by third parties
> > and makes the whole build and packaging process much more
> > complicated. 
> 
> No, it's the same as above ... as long as you have the public key you
> can reproduce the core build with the same end to end hash.

While the scheme you propose does allow verification of rebuildability,
it does not satisfy the requirements for a reproducible build as
understood by the general reproducible builds community:

	When is a build reproducible?

	A build is reproducible if given the same source code, build environment
	and build instructions, any party can recreate bit-by-bit identical
	copies of all specified artifacts.

	The relevant attributes of the build environment, the build instructions
	and the source code as well as the expected reproducible artifacts are
	defined by the authors or distributors. The artifacts of a build are the
	parts of the build results that are the desired primary output.

https://reproducible-builds.org/docs/definition/

Specifically the output of a previous build (the public key, module
signatures) is not available during the rebuild or verification.

> However, is there also a corresponding question of how we verify
> reproduceability of kernel builds (and the associated modules ... I
> assume for the modules you do strip the appended signature)?

Currently distros either don't enforce the reproducibility of the
kernel package at all or disable MODULE_SIG.
With the proposed scheme there would be no signatures on builtin modules.

> I assume
> you're going by the secure boot hash (authenticode hash of the efi stub
> and the compressed payload which includes the key).  However, if we had
> the vmlinux.o we could do a much more nuanced hash to verify the build,
> say by placing the keyring data in a section that isn't hashed.

The currently existing tooling does not have any nuance in its
verifications. It just compares bit-by-bit.
I think this is intentional as any bespoke per-package logic would
introduce possible failure modes and stand in the way of implementing
multiple completely independent verification toolsets.
While bespoke tools like diffoscope exist, these are only for
development and debugging. Not not for the reproducibiliy check itself.

How to handle secure-boot with distro keys is not yet clearly defined.
I see two possibilities, which should be possible with the proposed
scheme, both starting with the build of an unsigned kernel package.
Then a signature would be computed on private infrastructure and either
* shipped in a standalone package, to be combined with the kernel when
  that is installed to the ESP/flash etc.
* used as input of a signed kernel package where it is combined with the
  unsigned kernel image.


Thomas

