Return-Path: <linux-arch+bounces-5448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75264933748
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 08:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E94B1F23326
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CEF13ACC;
	Wed, 17 Jul 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da/UtMXG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6327125DE;
	Wed, 17 Jul 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198471; cv=none; b=rbFA9S6N5InOKjVrSKwUAhE86bCHrX4QmB68w9gl2VSXKnWsfCsa2G387ZlPL1GzFPnEIdGR8UbVwB9ZmueFcZV+hqP/0Qec2Hi6ZoZ0/WsK++3qPylnXC7Z+ETJA/VxeY/q/4D5vZLSoSmmnUbDzTXKYNWv/DXl0hkslpFGm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198471; c=relaxed/simple;
	bh=TtuRc2bthK6fRDYeDiyYE7I8wA3/LSlbRqB8Z94EXF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqif1xaa8IXcUMfCeg3hIncYD43g1QTcAefxCK/NIbvgPwWXxfceLC77jYAMyz60fRkniBRuVN6+Qy9BVXnxIdDGvk0VYJh3fwFLTypfmHFr3ppndcdnNh8NtV0m3vu7NIl6152go69SaJNPexDS3JorbEk8DcfMzkhkpXn/VeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da/UtMXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC76C32782;
	Wed, 17 Jul 2024 06:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721198469;
	bh=TtuRc2bthK6fRDYeDiyYE7I8wA3/LSlbRqB8Z94EXF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Da/UtMXGLGpAloHTui+wRHmRa78G93Ysni0bH8ZiPhLaF6kWU0JSEq+A9KYhAlkSm
	 ay/J1K12NOBeucVPz1UeX0cGVegg4/ClxbTZlTHn8aiH61taFZdKtn05BVx3IxyFoN
	 po3XrI6w8bbNrUeQOjXqm/3+LoERkZVFY9JySkoiH+ovrtZR+hR7bofeYRua4D+uf7
	 LGKw4RPHd/lK0T2bIaHI2D4PpiB9xnhx/Zg8NfSIDBQqpl8uoiq02K3RXOFKK1P87U
	 NXBfXvi4t6rFBfv4Nl3xt6nakUoMQ9gYMQfiBbTnqn1S4zvbiP3jpkgj1znAR/lKm9
	 aiX7hAlo2IDBg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sTyLe-000000005p8-1glo;
	Wed, 17 Jul 2024 08:41:10 +0200
Date: Wed, 17 Jul 2024 08:41:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: Re: [GIT PULL] asm-generic updates for 6.11
Message-ID: <ZpdnhhaQum_epcGp@hovoldconsulting.com>
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
 <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
 <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
 <2b6336d1-34e0-48dd-b901-7b5208045597@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6336d1-34e0-48dd-b901-7b5208045597@app.fastmail.com>

On Wed, Jul 17, 2024 at 08:01:43AM +0200, Arnd Bergmann wrote:
> On Wed, Jul 17, 2024, at 07:08, Linus Torvalds wrote:
> > On Tue, 16 Jul 2024 at 21:57, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> Note, it really might be just 'allmodconfig'. We've had things that
> >> depend on config entries in the past, eg the whole
> >> CONFIG_HEADERS_INSTALL etc could affect things.
> 
> I had tried a partial allmodconfig build earlier to save time,
> did a full build again now, still nothing:

FWIW, I noticed this last Friday as well when I did a few builds of
linux-next and every change I made triggered what appeared to be a full
rebuild of the tree.

This was with a trimmed config [1] and separate build tree (tmpfs).

Johan


[1] https://github.com/jhovold/linux/commit/c3324059a67c7c63186107771eabc17a66772989

