Return-Path: <linux-arch+bounces-13022-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F6B19AFE
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 07:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5EE3B66B2
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 05:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3D225402;
	Mon,  4 Aug 2025 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="p33R/bl4"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931152E3705;
	Mon,  4 Aug 2025 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754284365; cv=none; b=UQZSHz2fXBsjTF2oG5y5lkgbC80Z4ZPcJJMdGR5obEMJYa0JECPXG4hS+hQzcn/NRSAVsulX3b/lMZAFaPAtqJbmcqZ8HHel283W54aX/SUFH5d7DOaE0BTxW8ayiexBu5Fau/B3o+/LOMJk+2C2wHtppJuVovLXN6ynQ6knkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754284365; c=relaxed/simple;
	bh=ltynWgACH9WVZj84LIUriAfatzDJUh1ycy928TWSnE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UfW2CvXKJhJYKkmmoeq6myIyuKTB3cggNiILt5p//b64ew5iR4us0eO322MpeKX+upECPjNuJjnDJf6aV34Aetit1PgYuYPJYNaB+HX1nj5RqEvK4EqLYarEOyklxybnC9V3osy1I6eavA94Db3G0EKapcbQJ9LG7Q2VV0C59pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=p33R/bl4; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EvPkdQkZuTk/oKdUqX7+df3m3jcmeHsaTzG3mAWFvRg=; t=1754284361; x=1754889161; 
	b=p33R/bl4gN5ycL7repDIKEJ9ZcQogVLFlE75zaHyx6bNXHZxOW3E3HIFge3ZH3JmZqpWBT9glM+
	GuwOd8J8JKuIFaYTrYxyA6Zs6zTGrGMatM2RjljnGjhhHJUZKHUvk/DLQJHIim5ZVcuvm4haBZY5m
	BR1EDxhebFEFmrSOjx1Dl29MOevMYBHSBCITDAzOMgEenLp8mDZhxxioPGN9HhX0AQNzb88pT8N7J
	A668vgp7w4xNNfdhc0qIIXzKzwizy3nl7b6mHqQAF6mZEmPJ4ungccVPFoWXS3ofBIsyXKRwmXCCc
	25/p5s24tD8MC995R5g9MRqlkFodSDYeQdXw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uinUx-00000001ST0-03q2; Mon, 04 Aug 2025 07:12:35 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uinUw-000000008us-3HKi; Mon, 04 Aug 2025 07:12:34 +0200
Message-ID: <75cbab0cdab084795422335c0e0d69c6f57b468c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 25/36] sparc64: Implement the new page table range API
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, "Matthew Wilcox (Oracle)"
	 <willy@infradead.org>, linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, "David S. Miller"	
 <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson	
 <andreas@gaisler.com>, Rod Schnell <rods@mw-radio.com>, Sam James
 <sam@gentoo.org>
Date: Mon, 04 Aug 2025 07:12:33 +0200
In-Reply-To: <83931f05-a613-4972-be76-80bc695915e4@oracle.com>
References: <20230315051444.3229621-1-willy@infradead.org>
	 <20230315051444.3229621-26-willy@infradead.org>
	 <ce6337237169f179c75fe4a1ba1ce98843577360.camel@physik.fu-berlin.de>
	 <83931f05-a613-4972-be76-80bc695915e4@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Anthony,

On Sun, 2025-08-03 at 12:08 -0700, Anthony Yznaga wrote:
> There was a follow-on fix that addressed a bug with this patch:
>=20
> f4b4f3ec1a31 sparc64: add missing initialization of folio in tlb_batch_ad=
d()

Indeed I just tried v6.6 which has this patch and added your sun4u fix and =
it
seems to be stable. I was sure I saw problems even with v6.16 though.

Let me run more tests.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

