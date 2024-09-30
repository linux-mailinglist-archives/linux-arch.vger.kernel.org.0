Return-Path: <linux-arch+bounces-7486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597A1989B51
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 09:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0F11C21403
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D521547DB;
	Mon, 30 Sep 2024 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="aGrxWo51"
X-Original-To: linux-arch@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9714A0AB;
	Mon, 30 Sep 2024 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681039; cv=none; b=aaoe/jgTRcmAMCw49AR/dKcXU/8r2uUx0xrVWK+l81IrfiTpeyTwGdU0XlX+30K3/EI0DQYWs+XEeMWyb5D8P+BWugyx9ZAohxOOkh0iXtGgURr+WLN6W/nt11PhexdBe1RDHfT18flUBjERo74Yo/HDnj4U+ukBt4jQw8vEMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681039; c=relaxed/simple;
	bh=TB+lAUntaUaqbb0cnwsq5yTV7KiTDQl3nqbvmuCkaSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3D2aTuUpFOgMt+SmHd7GSRlSy7SPLafxBmPZiqChw8gMX5B6FK1kW6LhSLuwuXvcY6egOXmmH0kQaI+mlU0M8rXJ8tsVedHjP5IQ1K6aJL7qQvqCJldzY9ksbRkdbrcqINiHfnbbTfiJOLYlFgqUGnSKA7KQtj/r7bEzKpiQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=aGrxWo51; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AA2F11C009E; Mon, 30 Sep 2024 09:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1727681027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDMeTQHukrC1IMq/Dz0vfZpF3Fws59G6fh/19WKGSek=;
	b=aGrxWo51Giacs+I/9mGxdpHn5O+j0lzEj2rJ/XD5qT88MvNucWlsarIgij+At/L5gU5gPh
	fnGkkvOMhNjq5seH6/1VA1QjuCycNVjnPOlh6iBeeJYpARK8mWPF2/RZmwTyio+eo0ZUZw
	rA1HftgEXqOL32EgoJ2OkDgMlyp7b1c=
Date: Mon, 30 Sep 2024 09:23:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Vlastimil Babka <vbabka@suze.cz>
Subject: Re: [RFC PATCH 0/4] implement lightweight guard pages
Message-ID: <ZvpSA7ks/qATHEq3@duo.ucw.cz>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W0cxVuCFjuLpnb26"
Content-Disposition: inline
In-Reply-To: <cover.1727440966.git.lorenzo.stoakes@oracle.com>


--W0cxVuCFjuLpnb26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Userland library functions such as allocators and threading implementatio=
ns
> often require regions of memory to act as 'guard pages' - mappings which,
> when accessed, result in a fatal signal being sent to the accessing
> process.
=2E..
> Suggested-by: Vlastimil Babka <vbabka@suze.cz>

suse.cz, I believe. (They may prefer suse.com address).

BR,
									Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--W0cxVuCFjuLpnb26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvpSAwAKCRAw5/Bqldv6
8hAuAJ92TjqtQXkEDCopy+H3+ERGTckKJgCfZ6IwGhZZzzVTDKuv9wjxbwBtzgE=
=UXT7
-----END PGP SIGNATURE-----

--W0cxVuCFjuLpnb26--

