Return-Path: <linux-arch+bounces-8383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660AF9A7320
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 21:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B76283773
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308921FB3F4;
	Mon, 21 Oct 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCtK9zYV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB41F7061;
	Mon, 21 Oct 2024 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538537; cv=none; b=gk5ce7B1B6rhI6N2nSBYa58plbg1ACV3xdMWrzd8eJ4WyJKTSHLZGEQxOQNMYzDxuUFoWEqcMVsFR9TIXN108+RshcSN5Y3v9GT+p0wPDgaxKb34ti1YmSVc353Lchyk/QYYg2u38MP7Xrw5mSVS7SWsgURvUGPVVSWK7UiXPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538537; c=relaxed/simple;
	bh=jegTESoksQoYGEywwiHOC1YWAK/VFTlKb/3mzRVTbeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5u9AHWbVoQvGo0b2CjBB6LUh2Y+bkzSH2xQUBTe3J0qD32wZgJUTgWAgJ0+cldlrFVAbxXrkrQhmtE9bIEy3WoRgZNTFX4wApCYj2eeGFaSdDhX1QD1PDEz0eFkt5z4J+ItBLBC3K0vaM2Gcq8cSesZxw5vF+PtNK/F/IsrmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCtK9zYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E9C4CEC3;
	Mon, 21 Oct 2024 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729538536;
	bh=jegTESoksQoYGEywwiHOC1YWAK/VFTlKb/3mzRVTbeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCtK9zYVAkJlFMycqy2SKBoFvYcTC7aLW26C31ULoYO32Tk2FcbnGnaxU0AUGSngM
	 wZ8KnEhuzE3tM2jz1ycfV7xT3cjhalQdYlcCxcB7vHEErpa7aLcJhvenvxYyRnz5bb
	 jYCN5UXTHvTjcP6TfS8sLu5eC/48b3IOSICZsUMY0IrM6eFJ/WRK7JE9iL91oPZCre
	 mYnWXjjFOfUm91zrHOFCMOdj5n5+3KUUQpoONPmmMHgYk/jhahS3flv6/xyHCcGdlt
	 5yIyDaEuBSIqyx2numM8yCrAsmqhEspe8XIF8RfJu2StPhXYALbUxiKwdnEhsWTalO
	 Wtl/hOE4y87WQ==
Date: Mon, 21 Oct 2024 12:22:14 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: deller@gmx.de, arnd@arndb.de, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] modules: few of alignment fixes
Message-ID: <Zxap5hbcXw36rRWW@bombadil.infradead.org>
References: <20240129192644.3359978-1-mcgrof@kernel.org>
 <ZbrFoKUJQ8MIdzXD@bombadil.infradead.org>
 <ZbvdbdxOKZ9FUQuC@bombadil.infradead.org>
 <CAK7LNATjKzUVR7DbJqb=yAinJ1YZo8tzwiXA79E9-VrDn11wwg@mail.gmail.com>
 <Zb0zGZrotuWyhsFd@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zb0zGZrotuWyhsFd@bombadil.infradead.org>

On Fri, Feb 02, 2024 at 10:23:21AM -0800, Luis Chamberlain wrote:
> On Sat, Feb 03, 2024 at 12:20:38AM +0900, Masahiro Yamada wrote:
> > On Fri, Feb 2, 2024 at 3:05 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Wed, Jan 31, 2024 at 02:11:44PM -0800, Luis Chamberlain wrote:
> > > > On Mon, Jan 29, 2024 at 11:26:39AM -0800, Luis Chamberlain wrote:
> > > > > Masahiro, if there no issues feel free to take this or I can take them in
> > > > > too via the modules-next tree. Lemme know!
> > > >
> > > > I've queued this onto modules-testing to get winder testing [0]
> > >
> > > I've moved it to modules-next as I've found no issues.
> > >
> > >   Luis
> > 
> > 
> > I believe this patch series is wrong.
> > 
> > I thought we agreed that the alignment must be added to
> > individual asm code, not to the linker script.
> >
> > I am surprised that you came back to this.
> 
> I misseed the dialog on the old cover letter, sorry. I've yanked these patches
> out. I'd expect a respin from Helge.

Just goind down memory lane -- Helge, the work here pending was to move
this to the linker script. Were you going to follow up on this?

I'll split out my test patch as that's useful for other reasons now.

  Luis

