Return-Path: <linux-arch+bounces-7511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E2F98BCD5
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389F72811B3
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468321C245F;
	Tue,  1 Oct 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ntJCOUuK"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C719D88D;
	Tue,  1 Oct 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787234; cv=none; b=N6xVzAm8DmmhzwTPdjyJGV/C61stmSY0Aa4AWy8TK9fVqConscwGF5V6FojrOcnG4Wi+G0wprLxgUtyeDQrrA+I+h0v/7Gww+8GKxnjwBzrDKeMiqr/p9QrhOqFYlCbpqtyakJexmNFlEhJ0pOWBE1BhZjDMUEIiQ9HfF9V8rzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787234; c=relaxed/simple;
	bh=wVmIzLHrlB9vbqZZ4IHk4yXT9OkBR1Nuo7JXvIjOmAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZiYatGgHUFBgktib31jQFARudtbm4DgqL7jyDS0YUqpF5U2jKm9Hh5l2mmp4o4cRYeWO4wQYHxBC2zGTMVNCpJOmLA5LZ+CCBqmipClU3nKIZWdA3d5VuOOnrhTIRwyWgsBmi3JGpIHDkSLn9FkK/nbrtSLh+7cCD2S+BxqM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ntJCOUuK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wVmIzLHrlB9vbqZZ4IHk4yXT9OkBR1Nuo7JXvIjOmAQ=;
	t=1727787232; x=1728996832; b=ntJCOUuK3sDdtk53DJ4WarNW5pHlX5uKG+pdjf+EajFeF9I
	u2W/S4tYfNcwDYrV5sd5BTB9Y1CswC/V4PTq2aChKbJZGgoqVHvsdfzj453Ri7vD5zXsDSy5DBP2h
	Mb432pJleTOxhScrcvMc6sXwq+oqbsw3VdOBtO0o7aLA82FDip44DrHAoTJukCGRJP873el8drwB1
	292xlW/jyd66G2/xq7piPEXnPYv3h2/HnLreNuez8SUuY8JPke2Q5W/9lCcJz08QXJ+uDEcNzQCwA
	BkgIfWdJdaC4BC3/GTRjBcxuDWKNSvPMV/D1Y9ZHOXqiB5cRS0hweGU0kf6M6TUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svcNg-0000000Elbd-23z1;
	Tue, 01 Oct 2024 14:53:32 +0200
Message-ID: <168acf1cc03e2a7f4a918210ab2a05ee845ce247.camel@sipsolutions.net>
Subject: Re: [PATCH v7 09/10] um: Add dummy implementation for IO
 memcpy/memset
From: Johannes Berg <johannes@sipsolutions.net>
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>, 
 Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,  Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>,  Andrew Morton <akpm@linux-foundation.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
  Matt Turner <mattst88@gmail.com>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>,  Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,  Richard
 Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, Yann Sionneau
	 <ysionneau@kalrayinc.com>
Date: Tue, 01 Oct 2024 14:53:31 +0200
In-Reply-To: <20240930132321.2785718-10-jvetter@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
	 <20240930132321.2785718-10-jvetter@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-09-30 at 15:23 +0200, Julian Vetter wrote:
> The um arch is the only architecture that sets the config 'NO_IOMEM',
> yet drivers that use IO memory can be selected. In order to make these
> drivers happy we add a dummy implementation for memcpy_{from,to}io and
> memset_io functions.

Maybe I'm just not understanding this series, but how does this work
with lib/logic_iomem.c?

You're adding these inlines unconditionally, so if this included
logic_io.h, you should get symbol conflicts?

Also not sure these functions should/need to do anything at all, there's
no IO memory on ARCH=3Dum in case of not having logic_io.h. Maybe even
BUG_ON() or something? It can't be reachable (under correct drivers)
since ioremap() always returns NULL (without logic_iomem).

I think Arnd also said that other architectures might want to use
logic_iomem, though I don't see any now.

johannes

