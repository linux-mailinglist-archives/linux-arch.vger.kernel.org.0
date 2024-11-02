Return-Path: <linux-arch+bounces-8776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787759B9ED1
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 11:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6851F2183D
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 10:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E44C155741;
	Sat,  2 Nov 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="IxqSkCyy"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FE23CB;
	Sat,  2 Nov 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542807; cv=none; b=SmHpVpnoKU7h4TB992c0vX858zsoETaabKtG5Lmi0muyzM6x4Os/o1ppAj1G+Ktywru8T5Of1yzq3HSBIkEvFP8BFZGITtt1kfzk/WLy0UG9/pgy9Ej1xOTEAEG/DPoS0H5tHz1v8Yk48u2kO2R3WVKgXwJyoXK2jNmg0nOReJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542807; c=relaxed/simple;
	bh=JuJrje5n7DnZJSFOTS/GuoYnpV3wJlw2QubQhmw8Nio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N23Td4k3m6eodazQTZiGGWKxud4QTPaHTCN2cbC0gp8XqkG2prJfMHQvE5eIN0aAm+09tCLr0Hg8xp5x/1kE+dOL15Ny+V/2dOxW6Aa4xD6gpWkdczK0+N+BeHuSP11aU0fuoacOCtWho/eVc3eRt8n+VhP/cyAN7gFW9qGe86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=IxqSkCyy; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yYa+7XoJuDdb76oEmaiyHNPbnto6CbOy5cbqLih549g=; b=IxqSkCyyTRJ8QPfyWdRdr2qHrJ
	tpnjvWqxXTt+J7vxVmfkjrXd/rdKT+0RFdwGzbsRsMR9EdmzQEnFrsAgTnaI9+pdPBY3Pn9re79Nj
	57c2proTZGddCmA7w8N1JXHF1QdjpqJ+rO1URQev5azBEyB5hCBbYGnbLrSwTrfwTX1ksXWj0DUCf
	yuXLmD7dk6/d8YNZezbMYQ6VdXKIYeLQYq1Pq312XFyr1DfhbY4I3pSC7QOr5wrJ+HBrserJJF9gW
	0q+8FZncsHy0y1xio+hERsUI6SlHqDVBhozBkFMWrc3INF748cH6QiBntZMGgC5ZBSYXHEMi51PKW
	hRrho1rQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t7BEX-00Dy0V-01;
	Sat, 02 Nov 2024 18:19:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 Nov 2024 18:19:52 +0800
Date: Sat, 2 Nov 2024 18:19:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register
 arch algorithms
Message-ID: <ZyX8yEqnjXjJ5itO@gondor.apana.org.au>
References: <20241026040958.GA34351@sol.localdomain>
 <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
 <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>

On Sat, Nov 02, 2024 at 10:58:53AM +0100, Ard Biesheuvel wrote:
>
> At least btrfs supports a variety of checksums/hashes (crc32c, xxhash,
> sha) via the shash API.

OK, given that btrfs is still doing this, I think we should still
register crc32c-arch conditionally.  Having it point to crc32c-generic
is just confusing (at least if you use btrfs).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

