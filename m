Return-Path: <linux-arch+bounces-4335-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCA8C3531
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 08:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACB6281DF6
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 06:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A26E56C;
	Sun, 12 May 2024 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="oy4px8we"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9DCA40;
	Sun, 12 May 2024 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715493792; cv=none; b=RErCN0V3kfYBz+5Yb6dO1Yc/JJhGTTCaZo8Qn7WXZXPvJhq8VkA7wlXYArXNr6mAsjJsNozJTJLve2jnFVu2E3xBv4Yo017xWYtWUavZUSGjDjU6/KlzL14DczaL8fFvLkPwyD+uT1Iuxbb/lNH1H2fZz44GQ7kMMvJ1RvxAJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715493792; c=relaxed/simple;
	bh=wc0n9iid1qRQsONSgOFJNmciYzUpoJMhC69toRZiXW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VoAvcDRlju4R5VEz6t8D/TnQSKormzGje6wyYPfbj1DJfk+jpXZ+3siIyjhGQif1MjRGLd67rmea9oAujrCO4R7OxLczJ8d5fVkZFlLYl3RE6Z65W01yiNNWb5WcX93nCDc+A+GAgHZovjHaGvwH9r8zViOmKpPL0Sl3Y4NBFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=oy4px8we; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kly5u5emMu+abVf+gUTZH7K7hMn2WkPSWkhp2VHU1Gc=; t=1715493789; x=1716098589; 
	b=oy4px8weEDORIDuFSH3IYbi29zNGkdmdl/6xx5NldG7YxNC102CRHiKpF+3zw+v8tzJUocIgYZ/
	x2rk6Fe0lciA316AZ7vXPdzrVu+dXIuOUEVqlIrrRpzQcmBXllRjWz8gXaDrf+2Z6JOoQr4ba86aI
	cTkyNSxK9/v92kMclqZrf4lwoENi4P+JbHXU3qvlxfhlx1S0OBlXKdReGlHjVGlLPgRppXwbITGvq
	5ZdgKuL+4JjaqXbHLxtv/Yd81UaCEUkVgIw5o48VqwGOmDvI5DTEZpU8N0ZfZ2ew5Y1SpRwQCGKDq
	lWNWoJIpFHEADM+XgN3qm2FRFePo0/2AQFwg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s62IW-00000000ej4-1n2q; Sun, 12 May 2024 08:03:00 +0200
Received: from dynamic-077-191-174-180.77.191.pool.telefonica.de ([77.191.174.180] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s62IW-00000000EOs-0rco; Sun, 12 May 2024 08:03:00 +0200
Message-ID: <975442500864e4f30a830afb4ffd09a9bedb65d6.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: paulmck@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
 linux-alpha@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>,  Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>
Date: Sun, 12 May 2024 08:02:59 +0200
In-Reply-To: <f01d9eb2-9ab8-4e82-99d2-467385ebce2b@paulmck-laptop>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
	 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
	 <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>
	 <46543a98-4767-471a-91be-20fb60ab138b@paulmck-laptop>
	 <7432d241b538819b603194bfb3a306faf360d4b1.camel@physik.fu-berlin.de>
	 <a1331c86-dc07-4635-b169-623fcdd11824@paulmck-laptop>
	 <8dd1c466-54e3-45c1-a19f-f81dd9dbf243@app.fastmail.com>
	 <f01d9eb2-9ab8-4e82-99d2-467385ebce2b@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Sat, 2024-05-11 at 18:26 -0700, Paul E. McKenney wrote:
> And that breaks things because it can clobber concurrent stores to
> other bytes in that enclosing machine word.

But pre-EV56 Alpha has always been like this. What makes it broken
all of a sudden?

My question was whether it actually stopped working, i.e. it's no
longer usable on these machines but that's not the case as far as
I know as not too long ago someone was actually running Debian on
a Jensen machine [1].

We could actually ask Ulrich Teichert what the current state is
on his Jensen machine.

Adrian

> [1] https://marc.info/?l=3Dlinux-alpha&m=3D163265555616841&w=3D2

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

