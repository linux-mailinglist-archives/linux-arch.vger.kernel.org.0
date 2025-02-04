Return-Path: <linux-arch+bounces-10006-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4034BA27D08
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 22:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95E61885732
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D823021A449;
	Tue,  4 Feb 2025 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Dv5z6qVW"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B421A43A;
	Tue,  4 Feb 2025 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738703310; cv=none; b=s1WnDih1jtHOPE9Ou9B2cwWN/wL0jCB9TbjEySETL/YP1zeA3sr3/wEMqtgDsW2bfokwf/6s2Ghv7uCyyvuOzRLuBQmgBEuq3+hxX4z0YMe694YS4ClTj6e2/wmrgL8wP3Ubdev4jTMQlHvC1+GUBGBAUhRjNGCv8AkIlvNPwMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738703310; c=relaxed/simple;
	bh=gVu0/OU66wDhI5WrK8fkD90mnoCdFZJ9acV8nvKiCb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj6Dr+BRVaUwZTA10YJ47eG50UPMTCrotXqNKC0BllefaNDUR3qM7P3nyZCGRbJs2XIqvB4A7b6ZtlWe/rA8kZgYGjU+RIsQnh3AWf+2pD4ZMMjHnLCek+HenlWSuHqlOVEkFFUlm5dekWbmhm4vOiudqpoxjoFCjQEZ42jk6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Dv5z6qVW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738703304;
	bh=gVu0/OU66wDhI5WrK8fkD90mnoCdFZJ9acV8nvKiCb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dv5z6qVWmdkOOVUdpgXz2bBitwe7aZ6Dbdw+NLqejMNeubS3o0VPxrQ8Vz+x/wLD3
	 zCW9adnlaVmp3ar2Z17uZfGjDiZT+03rsIRvutaKn7KjiMwQTAJS8dHgrDXsIyN8WM
	 WtfKcyPvXDWxaLXLfpyK2MV/XNzqUIAcT2626hns=
Date: Tue, 4 Feb 2025 22:08:23 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Christian Heusel <christian@heusel.eu>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
	kpcyrd <kpcyrd@archlinux.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/6] module: Introduce hash-based integrity checking
Message-ID: <1686ea9d-ad36-4a2d-9427-70cd74e64300@t-8ch.de>
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
 <62c93d58-2e27-4304-a6ad-36aa932f18ac@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62c93d58-2e27-4304-a6ad-36aa932f18ac@heusel.eu>

On 2025-02-03 14:14:41+0100, Christian Heusel wrote:
> Hey Thomas,
> 
> On 25/01/20 06:44PM, Thomas Weißschuh wrote:
> > Thomas Weißschuh (6):
> >       kbuild: add stamp file for vmlinux BTF data
> >       module: Make module loading policy usable without MODULE_SIG
> >       module: Move integrity checks into dedicated function
> >       module: Move lockdown check into generic module loader
> >       lockdown: Make the relationship to MODULE_SIG a dependency
> >       module: Introduce hash-based integrity checking
> 
> thanks for working on this!
> 
> I had a look at this patch series together with kpcyrd over the weekend
> and we were able to verify that this indeed allows one to get a
> reproducible kernel image with the toolchain on Arch Linux (if the patch
> you mentioned in your cover letter is also applied), which is of course
> great news! :)

Great!
FYI the BTF patch shouldn't be necessary anymore with pahole 1.29.

> We also found a major issues with it, as adding it on top of the v6.13
> kernel and setting the needed config options while removing modules
> signatures made the kernel unable to load any module while also not
> printing any error for the failure, therefore resulting in an early boot
> failure on my machine.
> 
> Do you have any clue what could be going wrong here or what we could
> investigate? I have pushed my build config into [this repository][0] and
> also uploaded a prebuilt version (signed with my packager key)
> [here][1] (you can therefore just install it via "sudo pacman -U
> <link>").

I would guess the issue is the usage of INSTALL_MOD_STRIP.

What are the contents of .tmp_module_hashes.c ?
Do they match the hashes from the build directory and package?
You can also enable CONFIG_MODULE_DEBUG and '#define DEBUG' in
kernel/module/hashes.c

> Happy to test more stuff, feel free to CC me on any further revision /
> thread on this!

Will do!

> Cheers,
> Christian
> 
> [0]: https://gitlab.archlinux.org/gromit/linux-mainline-repro-test
> [1]: https://pkgbuild.com/~gromit/linux-bisection-kernels/linux-mainline-6.13-1.2-x86_64.pkg.tar.zst



