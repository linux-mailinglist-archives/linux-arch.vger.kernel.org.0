Return-Path: <linux-arch+bounces-1313-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFAC82892C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DC51C2431A
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840839FE4;
	Tue,  9 Jan 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="kdcpbEYO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5D8364B4;
	Tue,  9 Jan 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704814846; x=1705419646; i=frank.scheiner@web.de;
	bh=JApP6Az+WCyJ8LZWaJLAbWiRJ0Ez2KkG8ThNNGlpP1E=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=kdcpbEYOkBjRi5CFyWzdHPHM841bTRuqlYalXCvClPki02td9jsoeZ/xfppAyD0B
	 feZ33uAdAy9mBKZ6PJD60NzCs7e1dF4nyDAxVrgnioIbrpC/HM+JsDX/VQpaFuoH2
	 5RLGrNIHHVxvnBMBto77sByc5cNamhNemj8/RU27UkhY/barUxEx/rGPrV7YHiQ2F
	 B1nATWvilxK5ctowfQhf6xeRcK1HrZWydEirPJPFnc/ylmiDNXRcLn81VLw34qCRE
	 qL98RgPcF6jJ4NzG6sEgeVcMuYxJuO2hlowqJzLtIvEHYlilznFFo6muV5IBHohdF
	 d6CsK0hYoGnAlhmvPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([79.200.211.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZI5-1rl2aV1Y7t-00Ss1N; Tue, 09
 Jan 2024 16:40:46 +0100
Message-ID: <fe5f6e9b-02a2-42e9-8151-ae4b6fdba7e3@web.de>
Date: Tue, 9 Jan 2024 16:40:45 +0100
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
 linux-ia64@vger.kernel.org, debian-ia64 <debian-ia64@lists.debian.org>,
 t2@t2sde.org
References: <CAHk-=widprp4XoHUcsDe7e16YZjLYJWra-dK0hE1MnfPMf6C3Q@mail.gmail.com>
Subject: Re: Linux 6.7
Content-Language: en-US
From: Frank Scheiner <frank.scheiner@web.de>
In-Reply-To: <CAHk-=widprp4XoHUcsDe7e16YZjLYJWra-dK0hE1MnfPMf6C3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wWzEv5bAtpy6bP4LP7Hgh5gymAnXFNgcMqUwtQHO2xO2FXy8Wpi
 6Y8WxYKW6VOv17orN62phc2Q6pB14YwtLMYv3dhN4VSFB0oZ5gZ8UWtu2L7awoDtFAn3xas
 /cZagUOMZ+u6G5fTE5mmxzFQEDXcVxqiS8Yq2z+v/Wi/bI0Ko46rzgbS7SutFk9vDxv8S/u
 gZP+oX4nbcTJvGU9UsKFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZUg6mkXc7wo=;03QlFNZkWXXFVW74jmZTa/XzOtb
 S9SrukX8DLJkqG5/NxLv1RajQy9fZCUG8kSFiyHbRL+wwOJcDnM/mtJbG6bdnNyjDM049txGD
 IL/lGmKTtnrVPQ8FkJw6ZfBZCYmgixEpLa/vxIBJ6wLU1NkrwiJE6JGHFNG8+mpYDOMKd1q1+
 OCoCUD4lsdkvP1tJ+DMn6m/wZ2p2MB62Iyfd07wRADyYRHiFe10Vvcaum/SxyXhqt1SoYOXI+
 tgUlCY5xjHfr0Sb3nqmPA03fT/Xi4SLWtJnY9ZQGgP78qVq45rlgK510lwL572YUJoJ8D9Vmw
 8S8Zq9qWGUjEjagwkC0qu2c65yqYJjOzMAqR5+5JecTI4N8MpHMk8+YpQ6oouVOjCgoW/6Dpz
 dKqGBNyOZ+gcOScnyXr5YpZc+USAb2reVXuj8P6Wt4boU5DrSwiO6oeBNl0miPC28cqmpGk1v
 xcQJaynvQkYIuBY0rdd7fVj2jVmFYmh7KjUK9TiDyAdTwE07149Kkr1EM92YC+rSRu9Nj0dlo
 Lzwg3d42ed63AGQLKAw1Saqw44ler7QAmXFy0U0gaTYV/9Icl0WY0JCBlkIFXr9wQPSnztXaC
 de2iRz5D1uDopy7Qf5ueFuRPrFNOdv+wuGjEX+yPNmUvR5QAIa0spFjxl4cMcetnlwSttwW3w
 ZV5tluad7/UcJ/fiCXLDZ/hsl0nqTnFUxxm7txuupZls6guGkELgglw03NceCrvTCFsePRml5
 DfTmosct9wCED9FrcepEq1rYCy2SSqZZYd7mT+q8czsvpDjC1qpUyMO1uSWpuG2OICsV1QnXz
 0wZ5tnbpxbomHZVf+TTKnrXfPxEpZb7nuETOIQOcg9JHXxakRFgf54YDywJQVYsS+Hn++cakW
 L2FwqwSFkXf6RQED5PkWLPPJzGVOBqhWWjAW4vMpRS1MBQMSwpBgWP/NRREMVoOp2fMEJbMxr
 nam2y3e4NArzSz91idhIU3xuzm8=

Dear all,

an update for Linux/ia64:

After finishing the verification tests with Linux v6.7 on all of my ia64
machines, I can confirm that this one is again a good one for ia64. I
didn't detect any regressions or new problems for this version and it
continues to run on the following machines:

* rx4640 (w/Madison)
* rx2620 (w/Montecito)
* rx2660 (w/Montecito)
* rx6600 (w/Montvale)
* rx2800 i2 (w/Tukwila)

..., as could be expected from the positive test results of all v6.7
release candidates on the same selection of machines.

Tomas maintains the ia64 patchset for Linux on [1] and you can find the
per Linux release (candidate) source code used for regular testing on
[2]. Please use the `[...]-w-ia64` branches.

[1]: https://github.com/lenticularis39/linux-ia64/

[2]: https://github.com/johnny-mnemonic/linux-ia64/

****

On the way to v6.7-w-ia64 we also managed to solve the mm problem on the
rx6600. The patch is on [3] at the moment and should be looking familiar
to loongson developers because there was a similar problem for loongson
([4]) after 61167ad5fecd got merged. Therefore Linux v6.7-w-ia64 is the
first release since v6.4 that works unmodified on the rx6600.

[3]:
https://github.com/lenticularis39/linux-ia64/commit/13a05b70f9a5a117560caf=
ef0aa54425d6914550

[4]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Db795fb9f5861ee256070d59e33130980a01fadd7

****

Also some good news for your choice of Linux distributions for ia64:

In the meantime, ia64 is not only still available in Debian Ports ([5])
and Gentoo ([6]), but we now also got another distribution - T2/Linux
([6]) - that supports it.

[5]: https://www.ports.debian.org/

[6]: https://www.gentoo.org/downloads/#ia64

[7]: https://t2sde.org/#news-2023-12-05

****

Thank you all for your hard work on Linux!

Cheers,
Frank et al

