Return-Path: <linux-arch+bounces-2008-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468CA847756
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7999C1C210C7
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 18:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8724314D435;
	Fri,  2 Feb 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DBOCsalK"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7914D429;
	Fri,  2 Feb 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898203; cv=none; b=hGhCILrEh+RP8dst8+EYvJEgQrtd+g+QYwrVdjNavaH4AY2QKkdig1sdIPrMRaAH5tFcpI/xaqAIkrCNwbISddJWIt4UcMGyH/h1JQoo4NtEyh5Ji+vIjiH0+PIbC72SHJnGIATjiWQwzYvnRz95Q6wKapeTeVDePXZIEhUaSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898203; c=relaxed/simple;
	bh=Mq5f8BlBsLgopA58WYB43YJj75zn5OsbTH8V6XA8wSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swS74O2HVcwMCNrEP40ZC0nyI9ygkYTQUNE6QdwZ/z7RDKzJ5kqNtaC53stIG42qhBTqzvyR96EmpShSTLHhDeGmgrr/322zKeArnrpLbqOQkCmK24a6o3Bv4bhtI0o86LVsTiVkBhB146LsW5BbmaECGKvzA7GSJoC3C9Grtgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DBOCsalK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=G/isOO34EEGV9BhtSpWnjNTYed7cEI4+VMGyKCP+Msg=; b=DBOCsalKD1VPHSni9abJHU0dI3
	8iZYNdeKtSPdEaxUujT0YrOlIMhOfHXgjZu0uLsRrF68mGSWC1Bai3QHkb/0GZAat9xFQBY+15pW3
	q1jhFyq4+amXcZMEBy+GfRaiKmIMKPxGiuLj+PaMAxgT4C+Ot2Nz6tBj8iGQnO5V7uOBkDgp0prCO
	ULMBDpjAPPkOOpfbK5wId21zShSXK0+5IVKSgVkUC31TlJQEDpb8kC3GNO5OEJmCEW0zMlKwyTQsj
	4FJrP1TmU3hk0ZQlhYULuu+kLId38qNBgmtHFwYiJZx6RKz3eubPGy1fOkyGcYAUKvYZxCQ2STlaT
	pHsFBk+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVyC9-0000000Cqm8-0piI;
	Fri, 02 Feb 2024 18:23:21 +0000
Date: Fri, 2 Feb 2024 10:23:21 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: deller@gmx.de, arnd@arndb.de, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] modules: few of alignment fixes
Message-ID: <Zb0zGZrotuWyhsFd@bombadil.infradead.org>
References: <20240129192644.3359978-1-mcgrof@kernel.org>
 <ZbrFoKUJQ8MIdzXD@bombadil.infradead.org>
 <ZbvdbdxOKZ9FUQuC@bombadil.infradead.org>
 <CAK7LNATjKzUVR7DbJqb=yAinJ1YZo8tzwiXA79E9-VrDn11wwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATjKzUVR7DbJqb=yAinJ1YZo8tzwiXA79E9-VrDn11wwg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sat, Feb 03, 2024 at 12:20:38AM +0900, Masahiro Yamada wrote:
> On Fri, Feb 2, 2024 at 3:05 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Jan 31, 2024 at 02:11:44PM -0800, Luis Chamberlain wrote:
> > > On Mon, Jan 29, 2024 at 11:26:39AM -0800, Luis Chamberlain wrote:
> > > > Masahiro, if there no issues feel free to take this or I can take them in
> > > > too via the modules-next tree. Lemme know!
> > >
> > > I've queued this onto modules-testing to get winder testing [0]
> >
> > I've moved it to modules-next as I've found no issues.
> >
> >   Luis
> 
> 
> I believe this patch series is wrong.
> 
> I thought we agreed that the alignment must be added to
> individual asm code, not to the linker script.
>
> I am surprised that you came back to this.

I misseed the dialog on the old cover letter, sorry. I've yanked these patches
out. I'd expect a respin from Helge.

  Luis

