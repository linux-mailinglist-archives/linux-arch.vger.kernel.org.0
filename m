Return-Path: <linux-arch+bounces-9709-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763E8A09BAC
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 20:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C47A2A5B
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B7C20A5D0;
	Fri, 10 Jan 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkGMxF94"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0942066C9;
	Fri, 10 Jan 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536602; cv=none; b=eo94zJlVCRfdA/zHhNR9OxuU7NKb0X4KGJfkCNGrxfMgHVxyVijhtm+4OumV5PL4nx+nOT9CiBZ4K8NLeW4QHw9qDTvd8pt3y5eymuIQeuFU9zP4BcfyvodHwu3HHHNTl99G2q76mPconj1Pj/Wih4JiUyllLgdOw884UQWH12U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536602; c=relaxed/simple;
	bh=sfn3yOFMuAextGzWHj4juuUKpN4aPNdOVMwP5bH8vHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5EhIgxJcsD/hafQ6yNof4dfZEUDfNe9etIgkR6CMUovQHPbKiAGd9+83U+Fv/egOKnKR59etth1Zj3VXht/D7wgFZN/izgjG554yjh80hOMyTB4TKPlo+BbZA2SRF8V4SR8I4de4qg2/OtAR2HDuZWGS3ZRXxTNwrdJWp/4P48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkGMxF94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE36CC4CED6;
	Fri, 10 Jan 2025 19:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736536602;
	bh=sfn3yOFMuAextGzWHj4juuUKpN4aPNdOVMwP5bH8vHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkGMxF94g6FPah/+OxXGQP1MttsGxoeyi7qi9JvNIIIer94PjOrzgJDRXZcC8hRCu
	 LYwL9WlMkZSampb7+E0QtqPEP47VzNIQGMefPcF/Byc5ezlCufHaPNVvmuTU/G2Mx6
	 /BVcRDX4J0Lq8QlLhLe9qDglEFeglzOhuSispuaGr6cKE43klokd08zJky1JZI6Zsi
	 3iYEsWr3dc8J9NwkV7mBYI3cp7il5RWmNp1g9UNRWzf/0qa7MnYEkFtaBKJEGQ14Tg
	 823WI75+hXooV7yHfIHgbOEj1pRaNaRRNpMeL+HrHG0cknCOf2v7mHH29DSEn5yeZ4
	 t2K4PXFj4wTPQ==
Date: Fri, 10 Jan 2025 11:16:40 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Arnout Engelen <arnout@bzzt.net>
Cc: linux@weissschuh.net, arnd@arndb.de, da.gomez@samsung.com,
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
	petr.pavlu@suse.com, samitolvanen@google.com
Subject: Re: [PATCH RFC 2/2] module: Introduce hash-based integrity checking
Message-ID: <Z4FyGEXBK4EUi_Oq@bombadil.infradead.org>
References: <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
 <20250109105227.1012778-1-arnout@bzzt.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109105227.1012778-1-arnout@bzzt.net>

On Thu, Jan 09, 2025 at 11:52:27AM +0100, Arnout Engelen wrote:
> On Fri, 3 Jan 2025 17:37:52 -0800, Luis Chamberlain wrote:
> > What distro which is using module signatures would switch
> > to this as an alternative instead?
> 
> In NixOS, we disable MODULE_SIG by default (because we value
> reproducibility over having module signatures). Enabling
> MODULE_HASHES on systems that do not need to load out-of-tree
> modules would be a good step forward.
> 

Mentioning this in the cover letter will also be good. So two
distros seemt to want this.

  Luis

