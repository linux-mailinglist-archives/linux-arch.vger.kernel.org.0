Return-Path: <linux-arch+bounces-15062-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B9C7FACA
	for <lists+linux-arch@lfdr.de>; Mon, 24 Nov 2025 10:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CFB3A3399
	for <lists+linux-arch@lfdr.de>; Mon, 24 Nov 2025 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063062F6166;
	Mon, 24 Nov 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="U58iFAJL"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99021DEFE9;
	Mon, 24 Nov 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977323; cv=none; b=a9YbMp9daI5sLlap/znnv8ghkVvBm0qZNtIgDVJKiTBHroUP/JbuglzCLNXhjRh1dawrig8YDyYsZEFkZr1BaNIhP7ycX4kSTpmCzmlWRiit7Uedyqanr6JyQbz9Pwru4ynTcpEcUL6RN363nwpWz8Cc2xr6gdJUXBJUUpL/4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977323; c=relaxed/simple;
	bh=ggo0FIh6yZF0vZdd1wccMpu7GQYzL53JaLhCrTFUHSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxMR+jnN1zVEX52nQ9iWam/o1T8e6tsCPWUlF5Ypc9yGMXfeaJUp+f6FbAPs0qziVRPdMW4s04gy1c1DaA56Qkg6PYSvgwZmiWOGnICsRt8NXxvSLgwK2K2XjfeoKZgxDGN1RSMP3ut+o+tSfIN/elthx7ch8DFXQOau269dLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=U58iFAJL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763977313;
	bh=ggo0FIh6yZF0vZdd1wccMpu7GQYzL53JaLhCrTFUHSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U58iFAJLixclCXqRuNo0HJp1vUKu08nuKIB/G0v66x/wLz2rOHOAdU7iWZmANdZ0L
	 OxN1WL/KFOB3VA2k+WEf+wGRZ0ObkZhP2BdZqKFF9GbzjB+opzoU/Ep9EEw+75oCNx
	 En12qDqZaV2WgkqGfVMzxnf7Jo6mqaQMTEmZwMho=
Date: Mon, 24 Nov 2025 10:41:52 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
	kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/9] module: Introduce hash-based integrity checking
Message-ID: <a8802164-60c0-441f-973a-5fda415caff7@t-8ch.de>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
 <f1dca9daa01d0d2432c12ecabede3fa1389b1d29.camel@HansenPartnership.com>
 <20251119154834.A-tQsLzh@linutronix.de>
 <20251123170502.Ai5Ig66Z@breakpoint.cc>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123170502.Ai5Ig66Z@breakpoint.cc>

Hi Sebastian,

On 2025-11-23 18:05:02+0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-19 16:48:34 [+0100], Sebastian Andrzej Siewior wrote:
> > I fully agree with this approach. I don't like the big hash array but I
> > have an idea how to optimize that part. So I don't see a problem in the
> > long term.
> 
> The following PoC creates a merkle tree from a set files ending with .ko
> within the specified directory. It will write a .hash files containing
> the required hash for each file for its validation. The root hash is
> saved as "hash_root" and "hash_root.h" in the directory.

Thanks a lot!

> The Debian kernel shipps 4256 modules:
> 
> | $ time ./compute_hashes mods_deb
> | Files 4256 levels: 13 root hash: 97f8f439d63938ed74f48ec46dbd75c2b5e5b49f012a414e89b6f0e0f06efe84
> | 
> | real    0m0,732s
> | user    0m0,304s
> | sys     0m0,427s
> 
> This computes the hashes for all the modules it found in the mods_deb
> folder.
> The kernel needs the root hash (for sha256 32 bytes) and the depth of
> the tree (4 bytes). That are 36 bytes regardless of the number of
> modules that are built.
> In this case, the attached hash for each module is 420 bytes. This is 4
> bytes (position in the tree) + 13 (depth) * 32.
> The verification process requires 13 hash operation to hash through the
> tree and verify against the root hash.

We'll need to store the proof together with the modules somewhere.
Regular module signatures are stored as PKCS#7 and appended to the module
file. If we can also encode the merkle proof as PKCS#7, the integration
into the existing infrastructure should be much easier.
It will require some changes to this series, but honestly the Merkle
tree aproach looks like the clear winner here.

> For convience, the following PoC can also be found at
> 	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/mtree-hashed-mods.git/
> 
> which also includes a small testsuite.

(...)


Thomas

