Return-Path: <linux-arch+bounces-5495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48BF934B84
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 12:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A21C21D06
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 10:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70697A715;
	Thu, 18 Jul 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=frank.scheiner@online.de header.b="Gt2sJXq+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C448C06;
	Thu, 18 Jul 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721297560; cv=none; b=Z99vQC0w1s5iwCvCECWTTEGivL6i+IwNsjRrLhAnpOpI/nV44nCEqzAwa2P8sjZqNKCq9y/WT3CyJTjxxdB1sISf7cDJZI3pwxADux/BTV0Tt7sHPOPY+SiHZAhP4xdYVj+qbCRQXN9wGUGptdPIlepESuxiIAY6Iu6cddCFZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721297560; c=relaxed/simple;
	bh=KY9GmeigUT2A3/Vsw1Iw7TBh+WH4pXgIITVAi38kpRc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cHH+lvto//sxM9hPRgSF+3JbgfB9BrQi3bP8uA6RSkS9+3hROSBKfWXnDOATKf7Q7k5Wkkh81oQHqwwARGNRGirS0zPZ/MUwNEPjYuaeEWn/FaUAhSS9R+H9DTO47LpL2wxkPxrOqh6zy4HKvFjPnI4xZyvhewiUDgX6wZx+GNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=frank.scheiner@online.de header.b=Gt2sJXq+; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1721297553; x=1721902353;
	i=frank.scheiner@online.de;
	bh=KY9GmeigUT2A3/Vsw1Iw7TBh+WH4pXgIITVAi38kpRc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gt2sJXq+CWgB0cuaWN+i1WdPz4OBu0Bi0JMFuFeYFcFwdTy/ARHjLE7yTcUoJrhW
	 BsfoWGjRPnIWx3oqp4c1luYxjgntudJtnrHA2oKJ9jFoJOD5rB+xnjl+rwS/p/q1j
	 f1vzuuRJokJcQZLxs8C/OCLFmgsxAJjRCQ7TW5dCtZBDy2v3iQ60Gk8q8e+Fose6d
	 t402+cCguZppHe8GbEq2zpKaJR9I2Jzb4OY3ehbAhrp2zqWNUyzzq5gCKxqP8m0+u
	 8IoUw9ze9qn3rcy1Kmvb5fF2wJ1KmId5YGJAGe3eHkbVfzPDil96q+NCSqSslCG5Z
	 eEX+4b3/9nzvENcbDw==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from [192.168.178.30] ([79.200.220.73]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MHmuE-1saQRE04H8-00HCUb; Thu, 18 Jul 2024 12:06:15 +0200
Message-ID: <8dcb5d36-fc38-46f3-bb97-0e4e335c313b@online.de>
Date: Thu, 18 Jul 2024 12:06:12 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: torvalds@linux-foundation.org
Cc: =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-ia64@vger.kernel.org, t2@t2sde.org,
 debian-ia64 <debian-ia64@lists.debian.org>
References: <CAHk-=wjV_O2g_K19McjGKrxFxMFDqex+fyGcKc3uac1ft_O2gg@mail.gmail.com>
Subject: Re: Linux 6.10
Content-Language: en-US
From: Frank Scheiner <frank.scheiner@online.de>
In-Reply-To: <CAHk-=wjV_O2g_K19McjGKrxFxMFDqex+fyGcKc3uac1ft_O2gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q/HDgBgt8vDzzKiEs0Tdykgw+sZKbcEH1kFFE/a65ijK2jI80cH
 zTh5iWQbCSmiM8XcL/O63E9j+yedh9EJ/aMm6PJDu1C3vka8pgo+bY/e6q3+vvgaJIjLJxr
 BLzRcAxMHzIhFfomRkxeNEsUuHcUS9BEmimMeLj7kAHJtj08zcDoUlOujWbMgMbHneoFP3q
 qCFngMfJZNhlKzXrImEtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fq/vFAUCl5E=;nEruqZeqr+KGt9a5kffg276cqpV
 NNYciQi2b9nwc5NIi50N5qBnRaJG+Snhm+1x9qK8oA5u55+AjmOpUMq1at/cBLWPm8GdrRgEr
 Z/DPFRSTO4AaGPEiK+lktc9fN4U/j1Tm3AFwDYouXVjLjqpuLJu/OZhHGtqbJQ2EE4+uQ73hl
 BUE0h9AC9/30XfTKdfgjZsOGNUb5NWG2Li6xUrfI9TiKNyJ3EB2/yZBsjp0CvP46l9+3pIYj4
 RWyLj6v2EQKXxs5tu+3W+d5rkkrtdzF3TGilKirve5eZY472cv8mAzSXivKytMzL3wIkmsvZA
 BWqadfUvR52mBY1rudUHyCCobauMBbDrYU7/avb9Hb76NHYJpBgTOrk1OY8lfCf9nmHsOMJIz
 xOa5oPdHpqmcDeiLWKO53OtMSEkCM0zKE/WSk5odOpo3Jc/ZMtFWSVJOqiGeqhtej2lTMMmI1
 4dtskTrR5zaK91eaDBktRe3bqLusWMuGJJ4cEzIPzoi0Qf3S0l66Bla80AoY5GsiBorsqQL1z
 GBFb1QSXwvnEQfnnfjX2BbOxmQo1H82dc/E6KqwnsjbySJ+JT4TQGXn2Ro4jMlQbKZarvNovh
 nhutqg2hN92n31keEsvcygl/qFfZRf7abuZ746SU1lE3COqcxKotj+bU34dVhYV4JTuDS/NSg
 M3VyPicauCdhcRsODzZ6lhtol2sLo42wsxksFCd4ymSm0A2Fj4eZ//pG9VI8rZZcD4fE7ARX+
 LpEfaDOhOWyXO/Zui7KNOCv8XdDuugOVw==

Dear all,

a little later than usual, here comes the update on Linux/ia64 for v6.10:

Well, nothing special to report in this cycle compared to the last cycle
(see last update on [1] for details).

[1]:
https://lore.kernel.org/lkml/d308ad95-bee4-4401-a6f5-27bcf5bcc52d@web.de/

No new regressions were detected on any of the tested ia64 machines and
platforms (HP Sim on Ski) we have available for testing. Again no system
support was lost during this cycle. Everything works as expected.

Tomas maintains the ia64 patchset for Linux on [2] and is currently
working on some EPIC updates. Please note the new URL. You can always
find the per Linux release (candidate) source code used for regular
testing on [3]. Please use the `[...]-w-ia64` branches.

[2]: https://github.com/linux-ia64/linux-ia64/

[3]: https://github.com/johnny-mnemonic/linux-ia64/

****

In an earlier report I already mentioned our autobuilder that
cross-builds Linux stable releases and release candidates on x86 for
ia64 and also tests HP-Sim kernels within Ski (see [4] for an example
run). This continues to be helpful in detecting issues in stable kernels
early on and even catched two issues recently. But those two also were
the only ones found so far in the roughly 6 months this has been
established.

[4]: https://github.com/linux-ia64/linux-stable-rc/actions/runs/9984893242

To also better cover the new developments outside of the kernel, this
now got a commpanion autobuilder that cross-builds ia64 toolchain parts
for us with T2 based on the regular snapshots of binutils, gcc and glibc
(see [5] for an example run).

[5]:
https://github.com/johnny-mnemonic/toolchain-autobuilds/actions/runs/99849=
83546

****

No new additions to the selection of Linux distributions for ia64 this
time. In the meantime Debian on ia64 became history. Farewell.

****

Thank you all for your hard work on Linux!

Cheers,
Frank et al

