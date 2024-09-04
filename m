Return-Path: <linux-arch+bounces-7008-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D796BF43
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4152128ACDA
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B6D1DB53C;
	Wed,  4 Sep 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jPvrQVkd"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A201DA626;
	Wed,  4 Sep 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458216; cv=none; b=PVj7enVBunmLQGYts9DQJld1kbJlMkPvst7ddr9Wlg4nrRcU7nK0i+bM7bZGeVlxoB3bjc5OzWMBUTkyA6Tp6a5sYbPOHKsVk0Zvf64dGMYgBFm2Lg3C4kmdyRqtoyJpEHq8j7lLXAV7HvxZWhzuS/M1P0gCrmFpziMwr4u5ZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458216; c=relaxed/simple;
	bh=qp76bWAS281S/Uxq1UJ4u0tyzs9/Sy9c4AjREuBTtNM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CD9iIzWVGI8Mn54/6NA82wDQYsGut9yyglUzsgfCQzNc1totLkjNn1+48eRC/PdV8YL6jAS/nEP79aSUMQyFjLGj/IBDD4BYDjADn8escUbSK0EjmLkbzh1ZeYardDHqsXotxtyhgT/vMUA7XpoLZ9vM5G0tEzshSB53GITIdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jPvrQVkd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iSPVVeBjMRlj7n1AdDLiYOURvyyuDgx/JqQu1fk8o9M=;
	t=1725458214; x=1726667814; b=jPvrQVkdplmJmKNFshjKnA4fgeOO1cJr8TDuPNg0NhgEb+X
	TAjt9VGwaiQtlpkng1JQP+3YWhVI0cdr+15rfQXVKNR4u6EsXuNncTl3W//cmwYDiD/8hzejyoRBq
	TZx2zRmrZRlmrUwnjxtKBsUbt9lIfHBAYBMrhA0g8kJ2bGOG5OzvqxilyQwoSuXJDtIviEz1kiDnJ
	5wRX1Jz3Xw+PCDXBQ4NCWY3vb8jGGVHNTmgv8rqXBS47QTRlcstgVW/dfdJDYr6oo3wuz8nq+HCNF
	/9BGWOtoaZSO+mcX/9E+ihFwcqcNV2unV3KkBVdzj6JES0it3ReLbnqv7EaacJOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slqV1-00000004vJp-1fJS;
	Wed, 04 Sep 2024 15:56:43 +0200
Message-ID: <942a2aa5fc93f6dc1bc88b3b25e59b044a7a425f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: kunit: resolve missing prototypes warning
From: Johannes Berg <johannes@sipsolutions.net>
To: Gabriele Monaco <gmonaco@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>,  Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  linux-um@lists.infradead.org
Date: Wed, 04 Sep 2024 15:56:42 +0200
In-Reply-To: <20240904135019.200756-1-gmonaco@redhat.com>
References: <20240904135019.200756-1-gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-09-04 at 15:50 +0200, Gabriele Monaco wrote:
> While building for KUnit with default settings, the build is generating
> the following compilation warnings.
>=20
> ```
> $ make ARCH=3Dum O=3D.kunit --jobs=3D16
> ../lib/iomap.c:156:5: warning: no previous prototype for
> =E2=80=98ioread64_lo_hi=E2=80=99 [-Wmissing-prototypes]
>   156 | u64 ioread64_lo_hi(const void __iomem *addr)
>       |     ^~~~~~~~~~~~~~
> [...]
> ```
>=20
> The warning happens because the prototypes are defined in
> `asm-generic/iomap.h` only when `readq` and `writeq` are defined.
> For UM, those function get some default definitions but are currently
> defined _after_ the prototypes for `ioread64*`/`iowrite64*` functions.
> Moving the inclusion of `asm-generic/iomap.h` fixes it.
>=20
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  include/asm-generic/io.h | 8 ++++----

I get that you have this on kunit on ARCH=3Dum, but that makes it neither
a kunit nor a um patch :)

Arnd had originally wanted to fix this another way, but that got
dropped. I don't know if this fix is right, though I can see that it
works. I have the same workaround in my tree, but I'm really not
convinced that it doesn't have side-effects on other architectures.

johannes

