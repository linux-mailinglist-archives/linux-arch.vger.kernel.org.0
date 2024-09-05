Return-Path: <linux-arch+bounces-7062-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF7E96DA94
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 15:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086C2285091
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CAD19D891;
	Thu,  5 Sep 2024 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIVMffKc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B419925B;
	Thu,  5 Sep 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543872; cv=none; b=ZeYXJW6NXZ1UyNZFWvg9wzEDD8xCV9AkgMLBaE4M7jJI6ZKcDp6Rs0snKV6I7qHmx9/veNUVsuh0OOBuMI9uTVOb4mtw9kh7n46wx9qDzD6AW4Oxmd8+1McEAXgRwdkGpfjrCsvBXtfkcN0AQESrx6Xy067WD5JBhAiq7ccHzMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543872; c=relaxed/simple;
	bh=b9acX5IhkohSbskqXXvGeItLmD2/cfBjvS2Wfhcu7XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwLj1OPqk+p8eJugqALldeKyexpH2ncpwjc72/+LNZV82fgA2WBPj0CnOc+sqMzpR7NOM4VJGlPDTBsoNMR8GspOVfzDIcCMKToJ/Iuh5XVDg45oBAnmFnBX1mWgnXVEr/LjVttG38Z+VLORamWGqhHVXX7xmgIOt2pTI9quXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIVMffKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2709C4CEC3;
	Thu,  5 Sep 2024 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725543870;
	bh=b9acX5IhkohSbskqXXvGeItLmD2/cfBjvS2Wfhcu7XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uIVMffKcqsMxDOvKmpQ/o52EIXtFaMD2p2GliETZD9N0Dk4ATVa7h8aY7R3arCYMp
	 6PEOjR1bq/MdcLyU9jcyTwzMWMRPlsX+J/UIMUYK7RKvPwFssxhdY4iVx2DY4c0Z7s
	 uue4s4wk1gtXDdxkJet5ojFq8gd9VObkCdj0dTyHH57NfvWZ5V2GcbYjNN4Zn+06uQ
	 EzMbC3xKlj7V45GE7t/TPviuOx7NkOFlIil6D3lPT+VE0ZjrR6uPchXtQ0cvPHDUyH
	 wdIw6zQPG6/KSBHdFcAAp18fvvQcsOIsAXX2GSUbcoLchhW8ng4EhXQUVAUZ21rsoH
	 CzGYdGtYtvYfQ==
Date: Thu, 5 Sep 2024 08:44:28 -0500
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 02/15] kbuild: split device tree build rules into
 scripts/Makefile.dtbs
Message-ID: <20240905134428.GA1517132-robh@kernel.org>
References: <20240904234803.698424-1-masahiroy@kernel.org>
 <20240904234803.698424-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904234803.698424-3-masahiroy@kernel.org>

On Thu, Sep 05, 2024 at 08:47:38AM +0900, Masahiro Yamada wrote:
> scripts/Makefile.lib is included not only from scripts/Makefile.build
> but also from scripts/Makefile.{modfinal,package,vmlinux,vmlinux_o},
> where DT build rules are not required.
> 
> Split the DT build rules out to scripts/Makefile.dtbs, and include it
> only when necessary.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  drivers/of/fdt.c       |   2 +-
>  drivers/of/unittest.c  |   4 +-
>  scripts/Makefile.build |  25 +++-----
>  scripts/Makefile.dtbs  | 142 +++++++++++++++++++++++++++++++++++++++++
>  scripts/Makefile.lib   | 115 ---------------------------------
>  5 files changed, 153 insertions(+), 135 deletions(-)
>  create mode 100644 scripts/Makefile.dtbs

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

