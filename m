Return-Path: <linux-arch+bounces-15783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B06D19AEE
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 16:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D073080556
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83E62D73A1;
	Tue, 13 Jan 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSx4mOU4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EElHHGGH"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42709284686;
	Tue, 13 Jan 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316201; cv=none; b=o0wgjhKmbdX/h3jJdxLDMvVofaOuMK5KwvkFqNTYatnZhEON0CIjItTyiB4lD3Bk9kKOd8vh+IUbOnHmA+bBjQD5vA+JDoGwzdJ/XwSjBVx5iLM74NQdzOky6PfRwnfseMLcYM14SeCi1U2L4XEg/mE6DeysuL87U7MoHGOn4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316201; c=relaxed/simple;
	bh=NAqsrBRRVQ9IjNII30nTZcG+axDLjmdYDnjuoF9bBio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV6KWreyR79nz9hSHBqcqHWaQbSfQWstauNtshrJCeATQeFxgDWFsRTR7WbRw5h67t7Q5CJ3yfLkQXGbHQCUnghie4yR31tS3dXYfvRPQl/iLOnxj1AVfkqBlbialY/ys9scasObMUhnq0rTFf8Tt7MA/o2EiLmeSe/FsXFh1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sSx4mOU4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EElHHGGH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 15:56:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768316198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sfzPEDYda0fB777q3Y+R5qIxdXTsgJj2IRA+hNFGpw=;
	b=sSx4mOU4qkDYzkkx/o4BEtWyl3KyxW3euTuarzApOzTpXlaTS++4XY/zozFEdwI+2D4gqc
	X/2YYXHPhJ39OiUekNo9mxCgbd3mRKVP6iJ5LixKaumKVEOue7aHTdj2/SSw9AIA7xysiw
	khwRiBeHIgbbxPJE6nsPK4snz9MXXmwk6QsCaNwglaoU9+6Hv1fw7AOuDtH/SrsWBwtrSs
	Zpm5UWEXMa1w74IQw5HzaMgnRUPa2rwJxDOUlrasiueQFGxKTnhVEfsy49uPFRY/wFDjFK
	OtlrNM9syil5J8J1N2p2o6zWC7xe4RZ5ft3jv1L7pqgXQLYRRkdUm/6V+g4TPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768316198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sfzPEDYda0fB777q3Y+R5qIxdXTsgJj2IRA+hNFGpw=;
	b=EElHHGGH26sj8RjZyTS7MzBbQHDhVABCJGxSUKy3ePFAS2cW41IbJqoE/+HSbaCGe4llt6
	VlRf7PDMccGp4EBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <20260113145635.YfSTBhVs@linutronix.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>

On 2026-01-13 13:28:59 [+0100], Thomas Wei=C3=9Fschuh wrote:
> --- /dev/null
> +++ b/scripts/modules-merkle-tree.c
> @@ -0,0 +1,467 @@
=E2=80=A6
> +static void build_proof(struct mtree *mt, unsigned int n, int fd)
> +{
> +	unsigned char cur[EVP_MAX_MD_SIZE];
> +	unsigned char tmp[EVP_MAX_MD_SIZE];

This and a few other instances below could be optimized to avoid
hashing. I probably forgot to let you know.
-> https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/mtree-hashed-mod=
s.git/commit/?id=3D10b565c123c731da37befe862de13678b7c54877

> +	struct file_entry *fe, *fe_sib;
> +
> +	fe =3D &fh_list[n];
> +
> +	if ((n & 1) =3D=3D 0) {
> +		/* No pair, hash with itself */
> +		if (n + 1 =3D=3D num_files)
> +			fe_sib =3D fe;
> +		else
> +			fe_sib =3D &fh_list[n + 1];
> +	} else {
> +		fe_sib =3D &fh_list[n - 1];
> +	}
> +	/* First comes the node position into the file */
> +	write_be_int(fd, n);
> +
> +	if ((n & 1) =3D=3D 0)
> +		hash_entry(fe->hash, fe_sib->hash, cur);
> +	else
> +		hash_entry(fe_sib->hash, fe->hash, cur);
> +
> +	/* Next is the sibling hash, followed by hashes in the tree */
> +	write_hash(fd, fe_sib->hash);
> +
> +	for (unsigned int i =3D 0; i < mt->levels - 1; i++) {
> +		n >>=3D 1;
> +		if ((n & 1) =3D=3D 0) {
> +			void *h;
> +
> +			/* No pair, hash with itself */
> +			if (n + 1 =3D=3D mt->entries[i])
> +				h =3D cur;
> +			else
> +				h =3D mt->l[i][n + 1].hash;
> +
> +			hash_entry(cur, h, tmp);
> +			write_hash(fd, h);
> +		} else {
> +			hash_entry(mt->l[i][n - 1].hash, cur, tmp);
> +			write_hash(fd, mt->l[i][n - 1].hash);
> +		}
> +		memcpy(cur, tmp, hash_size);
> +	}
> +
> +	 /* After all that, the end hash should match the root hash */
> +	if (memcmp(cur, mt->l[mt->levels - 1][0].hash, hash_size))
> +		errx(1, "hash mismatch");
> +}

Sebastian

