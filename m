Return-Path: <linux-arch+bounces-2983-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312A87B1FC
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 20:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76321F29742
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6611B4AEC7;
	Wed, 13 Mar 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="gYvpRxVQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96369481DB;
	Wed, 13 Mar 2024 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358291; cv=none; b=pGSvGVnlS8s1upKIJRCFouXDmM/JryFJPsDfTNrX1+T9QlegxYcz9riZWtLapWBWLoZiMiqv/Kr5ZTmNPdmFs5sqbJatpfj2nCf87Z5KOYo82Tc5E2FXtE18gFeR6TwRvavc3z/Hu1Zl9IFOT4ygfuwhdwGdzftRQlsPNoWAQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358291; c=relaxed/simple;
	bh=Pe930XdgTBF50NCZ5d+nfgQQhAAhVzRcfDqGqQfxZ1I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kMl6Tv7SGmf2tG358mj7Tk7CPNJEAUzyWCjR7JmPVlQVoJsbf5zfEnZjZhT/5xU8uUc0RkpcNim7ylTiVzLSWzZQSf9f40KG+/c9as4Jxmjpuqp0PAX3hWb3eIFLghXVGjDdN/xbkjs52KFoYJ+CQXbFa+ls4vUTTjO/maoQOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=gYvpRxVQ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1710358248; x=1710963048; i=frank.scheiner@web.de;
	bh=Pe930XdgTBF50NCZ5d+nfgQQhAAhVzRcfDqGqQfxZ1I=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=gYvpRxVQt3E92dxoWQpVRM+EGNa/YPzqI692XGzDRlLkooUonI76aOl7XB3qmYsV
	 BVw83lxlQCMDaOmx96AE41pP6MBDTy8izelNXq+E9GzCZNLp7cALdTWzWstLEoI5l
	 RzpluS6Ke/1xcG0R37DJ4e2geIe2gLKt1SZQTGaFajqls5+m37rw8EHjAp8Hc6dWT
	 4YrqIaVPLGobIxlJzXlnkU3jbyInheOIVPQLlbpUpxZ3O3sKu1cJK4ioySBZqiVUg
	 qOJcBQyn0/U1y+t9IbJB4dvXS1SFZpmKJfZ36r/By79RcQQ24VATGhrz00/4QX5b1
	 nZBUL43d7js3hXu33w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([79.200.223.110]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB49-1rFIN43FLt-00V29G; Wed, 13
 Mar 2024 20:30:47 +0100
Message-ID: <145da253-b3bc-43da-a262-a3ebdfbea5a2@web.de>
Date: Wed, 13 Mar 2024 20:30:46 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: torvalds@linux-foundation.org
Cc: =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
 Sergei Trofimovich <slyich@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-ia64@vger.kernel.org, debian-ia64 <debian-ia64@lists.debian.org>,
 t2@t2sde.org
References: <CAHk-=wiehc0DfPtL6fC2=bFuyzkTnuiuYSQrr6JTQxQao6pq1Q@mail.gmail.com>
Subject: Re: Linux 6.8
Content-Language: en-US
From: Frank Scheiner <frank.scheiner@web.de>
In-Reply-To: <CAHk-=wiehc0DfPtL6fC2=bFuyzkTnuiuYSQrr6JTQxQao6pq1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HjAvP5dWM1MULtpFSlHsjsaqS9+nE6xoed922SsSkss51KuEXDl
 Egi6UIJlglIIXmnCuguqN30pYXRmo5iVTfQn00uWCGJ2pe5JkDcayoSBDefcC9MbbAkZQSV
 oPlbBHiOV6GCwsjdCEcrwvbPvMKpB5lXx/TybLYl//qDnVnyaQs+mCNjAPDVGIUAwmehZuX
 PMVjhNSrMmx8uMjthnk2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OM4F6wbf9W0=;nMhuKSUvrg9qTOvWr4nAegC67Li
 UZ/7ATF4PdaELPJ878xoId16VnysjAG5018nyjlSsED0CHoD9S8bQVOo/ILZ9lRGFg68E4TSB
 HzEtSogYnVxQaWTdTvRRKgYd1CYugkqDQzdS1tNxo+0MVmNmJcakY6aduf2DM9U5UY+qIikR3
 mSZo46X6/lmrWKwmyO9KXa1EXBd6rVnkmTkBnjAuN1jpL/5+zEQnkNfRZcT1wW5A2NgXIzEaX
 AEIUIdH8/v28PDPf+KBa6hiGXleyxMgG5XBmJMJ99e83CVvsGb3aYfeMoBxjHjA7KQhe/j5sX
 Y/ryfb1YP+LnL3HluRshUMLkGDcrPhfWhBijLpVW7eUOZ4N/M4yiH2WbGoiBbBWYF4UlcyMsN
 BhHlE51G3zqQ7LzU8TeBryHenNGBkcHEOK6wz0T0v8WZhggtZHV8JyrmsGEww+8Pbk0Y4CJpn
 yp2X4jGWRjv3vGGxbu1inVomhGqSSf9HgMIiw24E7UeQnEF+nPQLMEYIMi3fKkIQupTpuCyts
 8e9sCs3A4mCPmV71R7WzYeGTUK8mtOcoznz6cALFQQZoWNepIqe2ZGyeXAI5UCFac8IlhDph/
 SvThGMxhApX2tlTAJqSXAfF18PQbu0YKarlcP9xK1+rguPvz1oeWV2qkHSGpoYYfApanSBCjm
 hIU6rGp0CB+UhpgqjilNRaIQMgvk+nfFX38qh7RqzlbTCsUCW3ho6UB6nfrRielD+hdpndAJo
 vHqK4pVYtc93blg7y9sQpUJp4d0kCKVoMnKRM4K3dK2wo2xtoZXTTPzaWpEe/nV/+/VFAuT9x
 d2zOjez56PNaH+abeVgEm1/4MNsLvU+oVGoaFoK62TYII=

Dear all,

as usual, an update for Linux/ia64:

As far as I can tell, the v6.8 development cycle for us looked not much
different to the v6.7 one: The ia64 patch set ([1]) was extended where
need was identified. All ia64 machines we have available for testing
continue to work, no system support was lost during this cycle. No, we
even got another "system" back: the HP Sim platform - up to mainline,
that is. Together with Ski [2], thankfully kept together and updated by
Sergei Trofimovich, this allows to run ia64 kernels and (light) ia64
userland software on for example x86_64 hosts. Like it's done for the
recently established auto-builds for Linux stable RCs and releases on
GitHub. Have a look on [3] for example: all building, all working (in
Ski). For the manual testing of the Linux mainline RCs and releases some
changes were introduced. Mainly that compilation always happens with the
latest gcc-14 snapshot starting with v6.8-rc1 - so far no surprises -
and recently, the enabling of LRA for the compiler.

[1]: https://github.com/lenticularis39/linux-ia64

[2]: https://github.com/trofi/ski

[3]:
https://github.com/johnny-mnemonic/linux-stable-rc/actions/runs/8258902207

Unfortunately there's one difference to v6.7 with v6.8 (actually
beginning with v6.8-rc1 as we found out later during the cycle): there
is a userland regression present that leads to segfaults with v6.8 where
it does not with v6.7. We collected the following examples for this
regression (if they are all related):

* Debian: apt(-get) segfaults (though not immediately) and is affected
to a different degree depending on non-usrmerged or usrmerged root FS
* Gentoo: segfaults happen when emerging different packages
* T2: compiling a specific Perl source code file with gcc leads it to
segfault

...and hope to find the cause of it and a solution. Before you ask, no,
this is not due to enabling LRA for the compiler, it already happened
before that was done.

****

This time no new distributions for ia64, but unfortunately one less
soon: Debian will close shop on ia64 ([4]). As much as this make me sad,
because this was the distribution that got me going on ia64 nearly ten
years ago, better switch to another option sooner than later. I am
switching to T2 ([5]) for example for future testing. For network boot
this was really simple to set up, similar to how you can create an
OpenBSD root FS by unpacking a list of tarballs plus some manual
configuration afterwards.

[4]: https://lists.debian.org/debian-ia64/2024/02/msg00002.html

[5]: https://t2sde.org/

****

Thank you all for your hard work on Linux!

Cheers,
Frank at al

