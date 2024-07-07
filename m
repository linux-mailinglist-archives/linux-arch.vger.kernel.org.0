Return-Path: <linux-arch+bounces-5302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E464929973
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 21:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E393C1F21197
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C425553373;
	Sun,  7 Jul 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NfLe4usG";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Ijbdeqxn"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B71EDC;
	Sun,  7 Jul 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720379666; cv=none; b=ekBMcTMMYllUfgNPhD2Ih/5LwyzjaqPXNI/qprWcw5XnfnFJWOuVekTKZ4KsLPbVvxS7bGpatmr1CSL+aQR5l+RUXcrCigO9h9h5TTkEG9OtFSpyBHehIgchDekAX4PtpePkMtOt6LWUC7QiDwSsKKqqdY5fKddueBODeOxTuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720379666; c=relaxed/simple;
	bh=hJi9qT7NMiPGNELhd/gsQKoJiUPQe9Di6PK9WXAAzkU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FqvicCwPjvLkk+752eWxw/DIrl31q0H3eOtrpImzoMyaCkJqYz7gOBlF3dlCiO5HsUts+uR7zQKJF8l9OIo0o3UMZ1AuuIbgAzc3dmDgZrKtrXI3/5ZnWICVVrY+LB+dxwKx5M8jCIOUm24pTh854ptRyEnTMKIhalG0ctre1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NfLe4usG; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Ijbdeqxn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0574C1A299;
	Sun,  7 Jul 2024 15:14:24 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=hJi9qT7NMiPGNELhd/gsQKoJiUPQe9Di6PK9WX
	AAzkU=; b=NfLe4usGZ65tMdGiRnaEInS7GA3HSU/vESYEuFbuC4Nj+XAc6jN8rk
	4Lfg/p/F+af65Ea6Vva3ScSwgZKhcunJPUq/0N9yOlvmaVGv5xEbctvuykh2h38o
	JexLk5KRmJZB++KwsekrJrB8sJPayMd811PqkQia4gLUE55/vfAnk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DE2C61A298;
	Sun,  7 Jul 2024 15:14:23 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=hJi9qT7NMiPGNELhd/gsQKoJiUPQe9Di6PK9WXAAzkU=; b=IjbdeqxnIm+QsnUgpUv0I2waeZDxnrFtS2meCVqqvBnchIkgZ3KjDT8hl02rqTGkDMC40wDh8msX0+kBzMW6zn3cLR3hLxY2G6lNj3svKCXlhdWyuCK1J21a+mITxWFSmWfW0WzcJQ8bWmEY1u6STjC5F6EEJPbH4CaqpsmKmo8=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4775B1A297;
	Sun,  7 Jul 2024 15:14:23 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 16A3FD3B514;
	Sun,  7 Jul 2024 15:14:22 -0400 (EDT)
Date: Sun, 7 Jul 2024 15:14:21 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>
cc: Russell King <linux@armlinux.org.uk>, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] __arch_xprod64(): make __always_inline when
 optimizing for performance
In-Reply-To: <55a8cff0-1d73-4743-9c56-2792616426c7@app.fastmail.com>
Message-ID: <8251045r-26sn-4674-p820-4qp6s5o322qq@syhkavp.arg>
References: <20240707171919.1951895-1-nico@fluxnic.net> <20240707171919.1951895-5-nico@fluxnic.net> <55a8cff0-1d73-4743-9c56-2792616426c7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 1E9BF95C-3C95-11EF-89E4-965B910A682E-78420484!pb-smtp2.pobox.com

On Sun, 7 Jul 2024, Arnd Bergmann wrote:

> On Sun, Jul 7, 2024, at 19:17, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> >
> > Recent gcc versions started not systematically inline __arch_xprod64()
> > and that has performance implications. Give the compiler the freedom to
> > decide only when optimizing for size.
> >
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> 
> Seems reasonable. Just to make sure: do you know if the non-inline
> version of xprod_64 ends up producing a more effecient division
> result than the __do_div64() code path on arch/arm?

__arch_xprod_64() is part of the __do_div64() code path. So I'm not sure 
of your question.

Obviously, having __arch_xprod_64() inlined is faster but it increases 
binary size.


Nicolas

