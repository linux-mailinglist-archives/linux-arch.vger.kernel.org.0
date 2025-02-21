Return-Path: <linux-arch+bounces-10313-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6EBA3FFD0
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D0C17EE17
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480071FF1A9;
	Fri, 21 Feb 2025 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nXuh8rCG"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E11D7E50;
	Fri, 21 Feb 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166631; cv=none; b=WruvxAK7FFkF9clZ5vCpWqlkXLGqmWvJRta3G6WMko6FDE8DC3cYwlcLUGMYh9rhkQ5BVpDzGJdzH4SxSnypEQCVg+YousihfUjC4mXWfdg2yR87cEvdQy4AmBJVSl7pAyI/JX+5BosqcnDQhgKgxE4Y3WIMpXa6CTjY/AMAt8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166631; c=relaxed/simple;
	bh=zDxTSXduPQXA4xHKPlyHXnfxQxWR7o6zkvl4FTCCsPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmMWGoXoXEY6oa8NJhs9jrpdSplL+kDw7q2ViLlL0fllnhUaeKbbPldHibjk69kcp+JDhLIgdDjn64HeK+mChoNMUEZPIZpmWG6GvWoWFC8XUaYIrxRjYVJtiUslNOCSHXFSHRhinOh8y343oOmD50Fr5SuOr26mT0jwz/8vYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nXuh8rCG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zDxTSXduPQXA4xHKPlyHXnfxQxWR7o6zkvl4FTCCsPY=;
	t=1740166629; x=1741376229; b=nXuh8rCGqsfC3M2xAznPkwmoiPBWtC+d9yFk7989Wm+EiBe
	cq6CGtatT5XGh/DqtDIy+UVkvnpDwSnALN0h3GIkDMzWpdgd0M5LrLl9kUwr0WoiJ2jv9rXYWI98t
	BX94haLt4oatQhLfxjfHjJ8bLruAkrTbhAq3hnbNU5LBsY850740i8Yk2zyjzlGjCma/Q8f9c/yHY
	4YT8TYd3DU76NDpemOfAkK2N1vbWMftzJ6EIK6LI8rw1hG1xmbpVS/h91s7ASEIGED99av4bwzot4
	uPBPOv8Vz33cBJ18VPWaTfUWMohuHYnxweLYJFnPgprQtfISwoRrqINnv6hgqgDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tlYp2-00000005Y57-49wJ;
	Fri, 21 Feb 2025 20:36:29 +0100
Message-ID: <9af9413b7ab41c6b2db5f862d0fa50e9de279d67.camel@sipsolutions.net>
Subject: Re: [PATCH *-next 00/18] Remove weird and needless 'return' for
 void APIs
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Hemminger <stephen@networkplumber.org>, Zijun Hu
	 <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon	
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew
 Morton	 <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter
 Zijlstra	 <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Thomas
 Gleixner	 <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich	 <dakr@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang	 <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jason Gunthorpe	 <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, Linus Walleij	 <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Lee Jones	 <lee@kernel.org>, Thomas Graf
 <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>,  Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Miquel
 Raynal	 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>,
 linux-arch@vger.kernel.org, 	linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, 	iommu@lists.linux.dev,
 linux-mtd@lists.infradead.org
Date: Fri, 21 Feb 2025 20:36:26 +0100
In-Reply-To: <20250221110042.2ec3c276@hermes.local>
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
	 <20250221110042.2ec3c276@hermes.local>
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

On Fri, 2025-02-21 at 11:00 -0800, Stephen Hemminger wrote:
>=20
> Is this something that could be done with a coccinelle script?
>=20

Almost enough to do this:

@@
identifier fn;
expression E;
@@
void fn(...)
{
...
-return
E;
}


It takes a long time to run though, and does some wrong things as well:
if the return is in the middle of the function, it still matches and
removes it erroneously.

johannes

