Return-Path: <linux-arch+bounces-1429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13B1837207
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 20:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C401C2AD64
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D0C40BF7;
	Mon, 22 Jan 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJ0SsbNF"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0363D991;
	Mon, 22 Jan 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949340; cv=none; b=WOQs1FpL16reZREm76svlEEU5G+PXcIq5YhM58Mmx32mp2+gdMzlAI7sfzCFxE5LVuOO5CH54xBG2R1jyt7jF9hx+WQmb6gJsPvMqV9pzVz25IK4/EwyjfpNH7Z1xdl/wSA1VmWfcm2ulW/2tVOdc46AVgkpQyjpwX5a7u0qYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949340; c=relaxed/simple;
	bh=MAQEcRqHb3if5HkmAI43gXvFuhSvOtbVx+WrKREOnrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfamSanOfKWnjICbo7FZfNDOCYygmfVloxB3ErV8N9+PkG5MpdIDblNvsONd4LnxzkqtH+OQOrMttMBD+G90ExSw8BjzOW+AQSkzbRRDCO9KFBN3Q0Qwv80oMM8FNH2+LNfLExcvx48N2rKEc8yKLCdEYZDiWodibE6LEX02NY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aJ0SsbNF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W4nN7oLLaAH1mNj9CSrB8+XTPs6nsG2lTrYk1k3mo8Y=; b=aJ0SsbNFlexreTJ+32upLpZTgK
	FeQ69FjtTeeF/ourGpH6q+CDAPsfhJIPuJCdvAz4dXR9RVagl35pYAIeZZ0FA58YUaLik8mFdMB0i
	nNCp5BZOdsdZ2XurWcprbwB154NniOgVHIYSrdxuZjpYkmg8VT6ug8cgIVe19G7bLRa9aDyCif1SV
	3WZA/dwtiWeLQcoCPxOeDJHz+Mro3aJNR9FRybP3wlgY2IPPL0NyD9kFA2bEW1h2SAbTIqSMXFmLd
	aR0BBjqQ+R7aZvhjJIeUnMFrtDU4QW3K7PSNq11JvF4w4kpgnQwLb3UiOXdZiQEEeeJ4PG934jqnQ
	sZ5FHp+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzLt-00DbCX-17;
	Mon, 22 Jan 2024 18:48:57 +0000
Date: Mon, 22 Jan 2024 10:48:57 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/4] modules: Ensure 64-bit alignment on __ksymtab_*
 sections
Message-ID: <Za64mVrm528kYoCW@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-3-deller@kernel.org>
 <ZYUlpxlg/WooxGWZ@bombadil.infradead.org>
 <1b73bc5a-1948-4e67-9ec5-b238723b3a48@gmx.de>
 <ZYXtPL7Ds1SUKPLT@bombadil.infradead.org>
 <59bc81b5-820e-40ff-9159-c03e429af9a6@gmx.de>
 <Za6Td6cx3JbTfnCZ@bombadil.infradead.org>
 <b5e98501-6262-4b04-bbae-238e4956f904@gmx.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5e98501-6262-4b04-bbae-238e4956f904@gmx.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Jan 22, 2024 at 05:47:49PM +0100, Helge Deller wrote:
> On 1/22/24 17:10, Luis Chamberlain wrote:
> > 
> > It's within the noise for x86_64, but given what you suggest
> > for parisc where it is much more expensive, we should see a non-noise
> > delta. Even just time on loading the module should likely result in
> > a considerable delta than on x86_64. You may just need to play a bit
> > with the default values at build time.
> 
> I don't know if it will be a "considerable" amount of time.

There are variables which you can tune, so given what you suggest
it should be possible to get to that spot rather easily with a few
changes to the default values I think.

> > If you don't feel like doing that test that's fine too, we can just
> > ignore that.
> 
> I can do that test, but I won't have time for that in the next few weeks...

I would appreciate it!

  Luis

