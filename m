Return-Path: <linux-arch+bounces-8839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3719BBA0C
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 17:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7905A283029
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64A1C1AB4;
	Mon,  4 Nov 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="B0Gfw9hb"
X-Original-To: linux-arch@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393B1C07CF
	for <linux-arch@vger.kernel.org>; Mon,  4 Nov 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737091; cv=none; b=Xjpj0n6qsxSg5aLlRmHkHHqEFMGm67oIWJJQaKYXPq4QYmnlculHJjlfXTJG8TdLx3sVfDVFFwQzZSBzEowybLTJpsSsFw/T51ncXNOvslpRHCczEurSrvmx/cpjBqFzmXlWhIWowm11kkVFwlexhVaA4JGC2KAIsR7NMm2AkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737091; c=relaxed/simple;
	bh=sk6U4/K3R+jeus2MgsDXnr8zNq7ciOtwdtktA7ckUVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5Zm3Dph0p4YWkmNISXIWTHkNMCvRfmMDEOu10EhhaT474ezciBMly5oS+hQLKkF5cAd/WU+9KJY9h4Gpx4tiPBVMRUuzi4C4MM30SiFR0k0r0DvuPmhKOnf7dqsB5AW78gOJ44UNQWurqsejZTlQZ2fotSG59CGCKPxwargJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=B0Gfw9hb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-131.bstnma.fios.verizon.net [173.48.115.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A4GHDZq005094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 11:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730737037; bh=MfBLldae6HpVT/J0uH6IxgYAl1BDd58WeCFp8bpuhVM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=B0Gfw9hby54Mawf3nVtoZfShOFAGukbl6ZTbcBRlBYtaOGsQCDtF0qrCRjYcyueMN
	 kV3YMqvlfKnXp0p4fCWynaSg163bApSkqyhJqyYAnlJGmGsBqD0LP+xC7Ub8B3AkMW
	 fCaW+bTFL4V+NDN7Mwtj3eK4pBVhp1exceawLgFrmz6mC17UMOrLmM35q5gxC4WiPa
	 dU/am5SfTEXUCGkYocIUCIDjggZimNzSIcTYzrac8AXMHympLwlrhdp6OGCVFYpanm
	 7zZxGz70mRgKnWKu+qePBhSgO7AcPnfmUhE92pXrgqBwyRWdRGP2hoQHMO6YFDD2gt
	 W9K47pAC0MkrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8C6D915C02FA; Mon, 04 Nov 2024 11:17:13 -0500 (EST)
Date: Mon, 4 Nov 2024 11:17:13 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 15/18] ext4: switch to using the crc32c library
Message-ID: <20241104161713.GA43869@mit.edu>
References: <20241103223154.136127-1-ebiggers@kernel.org>
 <20241103223154.136127-16-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103223154.136127-16-ebiggers@kernel.org>

On Sun, Nov 03, 2024 at 02:31:51PM -0800, Eric Biggers wrote:
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32c().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Theodore Ts'o <tytso@mit.edu>

Thanks for the cleanup!


