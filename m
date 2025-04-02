Return-Path: <linux-arch+bounces-11239-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A9A79662
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 22:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261F47A2785
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3742F1EB18F;
	Wed,  2 Apr 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="aeXuR7TP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE58B674;
	Wed,  2 Apr 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625104; cv=none; b=k4cF2ZdPzwg/zInsXLaz3tCsOO3k7/zNSn4DVoBodBjreLNQUD1+J1fZpE2YctcVug/OrfJwvFdQqJzhDhkNFrYt1c42HwsqzoIUumJ9PqbkuBX7xTieOa4yEgBuijDjwdt2D2eerB3VCqikTIms0WG5k5isEjW+ysnVJSBxcno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625104; c=relaxed/simple;
	bh=MpJVhRgZ7LUpR6onJCeLiTRp0b5MlWrOY5kpXQCMI6E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WsIjAAtQSfaAK0PgzVvcjus+iNBDBVqad+YP6fZwiPKqXoPoYKKDs0jtekQp1alZq6f5an2k8lpStzkzKjQmeJqO4SkQsHy/xozuDgTqIXd3Z4cmmYIMQSjmjsFT6PhRhU1JhOHepb9phVg22mLfGQEv7KJOBWxgD2F1fhVu9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=aeXuR7TP; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743625082; x=1744229882; i=frank.scheiner@web.de;
	bh=MpJVhRgZ7LUpR6onJCeLiTRp0b5MlWrOY5kpXQCMI6E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aeXuR7TPnwSGVB4U/f7Y7uFNws62V3DfUtBmR95q0IsesgzjcZSTu7XIwsvg7VXk
	 ZvcKeai3Ody349fmfzpjrD/33ibD9nHfpMLNfpph4l8YyhxSBFZcNZgDHcn+bvmZl
	 fyK/KxoxFBi8Hv4lpclPR6kRjc+Ku8CYmJw8ct9qgBYN0TahshpX5xVBe9Keteo+H
	 0JhLbrls2eoU5ycIr5W49wziCBrBGNNVkoAKf6PjuMl2NCzi8Eo0l9YdHzDOWsKO7
	 eTzN4NqcuZWXO/nxm+T2bagxPLjbwBx/uc7Hjk1jllpbgKwtc/imbMNkLTTvsw/Pv
	 uoe2H6vrfgWTpfz4yQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([84.152.244.176]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eGT-1szcNR1dgd-017Br7; Wed, 02
 Apr 2025 22:18:02 +0200
Message-ID: <0855440c-8448-4e56-858c-49d0d2adca34@web.de>
Date: Wed, 2 Apr 2025 22:18:01 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: torvalds@linux-foundation.org
Cc: =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
 Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-ia64@vger.kernel.org,
 t2@t2sde.org
References: <CAHk-=wg7TO09Si5tTPyhdrLLvyYtVmCf+GGN4kVJ0=Xk=5TE3g@mail.gmail.com>
Subject: Re: Linux 6.14
Content-Language: en-US
From: Frank Scheiner <frank.scheiner@web.de>
In-Reply-To: <CAHk-=wg7TO09Si5tTPyhdrLLvyYtVmCf+GGN4kVJ0=Xk=5TE3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gLIE8kUPbJpq3dfTDSLsXMSKwPWNv9IhzTqgT+H3ShyfNcv1jv7
 vPajAoWwif0jKL5OEN0pnLgZkcfH4D0A887fmLBMKo3JBn6FvLHaSZWvstGKodDCwt9Y3p6
 nza8IEkbeHY+6SP2K6fTdQuI8efoYHMxMq0X6+cb2uAdU0pFb/rykHadFY7SUWQX3n2ycT0
 RHQrX/yQb8ntwutsyb9RA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jQX54MUzdow=;x1DpACLCAXa5S8IbRzOz3O4PdyD
 pMxvsdTUJ/N+j64jtj7fhlVj/zSX3FCoayWsY5i0FEoGp7y1fAPGNq0Ezi9PLeQBKWWWRjHkk
 x+p1JSfyL0HPYKatY8BKQ6X7IIulSfsSnjL1GNgUlZy8aWHSznNqiUDD1sDdD19+WBXDa/dW3
 32xphPqssFoQIWgsYcukZkKIkYQwnMiLn0nV03KycoFqXull9Efdx8uyNpElazDH+QpilGXy7
 cWODCfEHG2YV1vZHC08nSQBvORWrXsiulpG5yNcOCLK9B1o3Y6C2iYXuFnnnZXXt5oVyCJ1us
 1+c37CVNM6QRmKY0Vc6kDcXUc+cjnCxX1JwmiohbCwj0u8ee4Hgd1cnZj7y59uU+5DisbP+Sn
 zjgS0BByjM/zhyF1CXp8KHHGmZBWw6bAlNYwO50rzlnt4q9pJ0Z94spAFeux71od3T3pXVLK1
 PAwzRIRKzwmPRs8uc1+NrHBW/whi5dnbScQI+Pa7CgvCDMGuzVy6QOl1lv5dkH7Lo3THja+q+
 IjlJT5gw8TyfmsOM/87uYkYl//jC27QKEymPGUc5RXnm5w3Bmg7x8uW1JD/nD3eiXxw04RJBo
 bMxScLX+RdYcWud+IZ1iZXvhUgB6OBtQUL3uuA+GIAxws1t/rkpaw7BkfgUOIA+h2VmFuA1Ny
 yVJV6lefuBkuKDpdWx0sj2B0ba6VxbOb6hfqecR9XYwsCGEY0zJwC8T42EKD0Isx1hgSK7K1U
 zX4DQSGG3y39yrdWX62QqsDwrOFkZm5t/AUDclzksu0F/C595WKMIphxQ0dZ8fX5C9vT8Tz04
 8Ez+EYtksN0JnT7GdmLWn3m7durFjRIyEJt1qSkYiYa1aV9Yp087nB7cWef7p8lQbf4CxMx8s
 xs5Y+Lo3umXEAZe8KaNJV2IJdDuh0Dmz8Ls5uv9agas/sC+aRykXs2Etq4Z+sziK17ux1vYaq
 oQ3niUyQLkjPwzr2DKZPXVzuTtBz6iMcRyJgR6eX6FIM9Si8Ex7kSaaq9C2pDl4e5jgBNkndq
 Y9xsSM9PjoH1z/vgrgUd3lGITOcy258calokFf7XRXHc8v7yLyO5NEfumoOmartfbSo85uCXz
 +bekwBpQCh3LDAeib4BTTtkxhpZh18F/WCbfAEB6jGP9e5QtY+AXeo6GW9nj3RKeq+XyqSmej
 C2t5zLSK0gmRsthqeyVlGPxyRZC7wTeL9EtJFu+FqQWnSSHmJaxBdpYsBwiK/iEy4SyhjiS9q
 8A6pIMjRmND+77l5T87vxbvf2b9TUOJb9lT0VNZh8BM1b0gnAaT7OAq3Ury1DE6hRtEgtaLCu
 RIyDaso/kV6TZxN9vHpgWLL6f9z7wJQd7380bJPOGWIKcHkd7RcfEJwbHBowl+Qmc3IFTWrto
 pQNILT62nDmf9jAeo3XSLvqb+A6N59mcx9WEIqYXMc+doiRiM6IVhA0i5jQ4gd25m/wHDIA4O
 Jq1Y09Jw5HN6FwTUywj2vf0nCLpQoNPETCphq4rJs+maH0+IZ

Dear all,

here comes the update on Linux/ia64, unfortunately a little later than
usual. This one is for v6.14, but as we're already in the midst of the
merge window for v6.15 I can report on the progress there, too.

So, IIRC the merge window for v6.14 required a really low effort, much
less involvement than the one for v6.13. Still I didn't manage to extend
testing also to on-disk installations during the v6.14 cycle. But a new
hardware "target" could be made available for testing - a BL860c blade
server. A description of the process still needs to be done so others
can repeat it, it's not that hard to accomplish. So this makes six real
machines and one simulated machine avilable for regular testing:

* rx2620
* rx4640
* rx2660
* BL860c
* rx6600
* rx2800 i2
* Ski/hp-sim

You'll find more details about these here (incl. boot logs):

http://epic-linux.org/#!/machines/

But also other vendors once made ia64 machines. Some really cool ones
were the Altixen from SGI and there has been a real progress in bringing
Linux support closer to newer kernels for these just recently. To the
best of my knowledge, this has never worked with anything newer than
3.x.y in the past. Well, guess what, running a numalinked 32-processor
Altix 3700 or a smaller numalinked Altix 350 is now possible with
4.19.325. Later kernels still make problems, but 4.19.325 is a good
resting point as CIP ([1]) still supports 4.19.x.

[1]: https://www.cip-project.org/

****

But as real hardware is still hard to get and quite expensive unless
you're lucky, a focus has been put on Ski, the only ready-to-use closest
thing to a real ia64 machine that's available for free right now. As it
is still something not that well-known, an overview and outlook article
has been created for it, partly the reason why this update is so late
:-). If you're interested in working with ia64 "machines" w/o much
investment, Ski is currently the way to go. Have a look here for a
start:

http://epic-linux.org/#!articles/ski-the-undiscovered-country.md

****

So the merge window for v6.15 looks good so far, despite being a more
involved one, as can be seen by the number of failed runs for the Linux
mainline autobuilder ([2]). First manual kernel builds were done based
on [3] with binutils 2.42 and GCC 15-20250330 and have been
boot-to-login tested on all available hardware. The HP Sim patch set
will require an update though. More extensive testing was done on the
rx2800 i2 with building new packages for EPIC Slack for a few hours,
that also went well.

[2]: https://github.com/johnny-mnemonic/linux-mainline-autobuilds/actions

[3]: https://github.com/johnny-mnemonic/linux-ia64/commit/4e82c87058f45e79eeaa4d5bcc3b38dd3dce7209

****

Find the last Linux/ia64 update on [4].

[4]: https://lore.kernel.org/all/53e3e309-4d66-40fe-9d47-dac6a61461d0@web.de/

****

Thank you all for your hard work on Linux!

Cheers,
Frank et al


