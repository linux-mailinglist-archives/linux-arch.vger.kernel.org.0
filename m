Return-Path: <linux-arch+bounces-7351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B425697BB3E
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 13:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F8D1C21A73
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2717AE0C;
	Wed, 18 Sep 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="JAA/tC3/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94D291E;
	Wed, 18 Sep 2024 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657331; cv=none; b=Od5tkUPqgPCwP706GfjCOBUcNACRdWek6CIBMsnD1hSihF9h4DrJpHFH8MFWUe3L5DxqOuzpdC1nfbouoqqLVeWQ+Y5ut2cmnkPIB6JEnF5S1xMuZAbMkCBWSRK7aC01jOFFc3KHndKQWRw2TrKwCMbX06LkFjI+De7d1sKk6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657331; c=relaxed/simple;
	bh=fTEocBYZ1+d+G2Kb2hcI97mXIzn4E/wx1Xt4FJfCMuE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EX7jIYCw4PZ0B1HKEtp63XsxJzxvaKIKaroQmE2Z2End4sdAnWOsCFuq8SBd1y8CKnEXjhDrIUK9flKfgbaL2J4xxzr+zaVpQXwhq6dH9tEEuf95fvdngPycGB3D78jnE+7RXotS2aeUsh+LjzeumcMMy9lOUnELCose8Jtrdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=JAA/tC3/; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726657297; x=1727262097; i=frank.scheiner@web.de;
	bh=fTEocBYZ1+d+G2Kb2hcI97mXIzn4E/wx1Xt4FJfCMuE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JAA/tC3/CxC2ujJR4yBVDx+rWTwtinZJ8xzeLeW4xgcmBT5XVtD4gW0+wnA6hbi1
	 iYJ05jiE0OxzlzmmapyfkEMQGZ5jamUp8N/iIr7bm2UCTY5UA9hSCDUc/bAZUec+R
	 5mr6mlLI1pmd0i/WVbhYJ7ds3wRS8NDwv6BQuaK6IapnLI813rhDm2KXdFjBmAWSB
	 slshGJkvxiO4kXPqSE49WeIa7k9KOjj3RLbmrEbvgRJn/8+GqcUNujgHeB/cZB0cA
	 cDegEKmegdISrSw7rBF9/x3xC+Ixi767WdJ7vx5MTWR7k6bdPD3iQJSuNXk3PLhZR
	 JPpcyxtBjqiHDunpig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([84.152.254.122]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N45xz-1rrS893hQ1-00wJKa; Wed, 18
 Sep 2024 13:01:36 +0200
Message-ID: <5d1b5880-9bdc-4b04-81dc-341df7b02177@web.de>
Date: Wed, 18 Sep 2024 13:01:35 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Frank Scheiner <frank.scheiner@web.de>
Subject: Re: Linux 6.11
To: torvalds@linux-foundation.org
Cc: =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-ia64@vger.kernel.org, t2@t2sde.org, gentoo-dev@lists.gentoo.org
References: <CAHk-=whVpSHw9+4ov=oLevfv8sPYbh59T_9VKif-6Vqkr41jQA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=whVpSHw9+4ov=oLevfv8sPYbh59T_9VKif-6Vqkr41jQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3E5Aj6H9d3VPyWgoj4x5IHO85ao+A1Zb0ZwoJIrecu97rh8kp6s
 ImvaKcZa8iFds07lwbaVUp/7o9ScEhuzqibOEy1BFuS+tx7cM09guITJbl/63fJsP4ZlIWC
 ws6CZtoFOxtb3AuqqI1rxT4+R2cjDjaTgaHc9m1Wwr+rhri7dtBcc4updhsac6ThW71D0+y
 WcLerPiEt52Yw/b5u6qVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qXt5DoX+nJU=;DCTmcOzuvrb5ZcdB9XgT2Wwg+tG
 NXaNYquG42guKh1w3hBOacizN1K2SbyzRVXdfbQzNrxhmUCe+xp2Bpt2lpY6KaWehicyhVvXK
 ev2HelK/DqjN6NsufiXJYNl93vje1g//Z6XjSGTtUgWnSNMCeZ1LzUySaaX9Gf25lFCr7b1jr
 uglHRv4G8aMGyVNfI0h2eNq+sgNK/nXCsS6CCHaVhG073Hdhm5jZpivbxxCJkwKpH7v3xVh61
 GEbxdKtW3Rcx/eY+bMl+nug9zXH+gQ1OD4ddtapm8gubBO7+jw9BN5ba94PWwOZ4RxC5Opxm8
 fhgu8H43jspb+LKFYe0RczjJ35xWVIvVaE/fhCbyW0aUkjj6w6ECGMiQ1jILMz93/UhxuMrZ+
 TRX92Jg18Ab+2mB6sbrBar4bhmnF0yYC5e4qOw4geODakNxH4lM9dP5NNn4f1J9IEX8q317uO
 gPVZwWyzASRMgEVLDuQ+SDmpdbAFBHtxQzP0RkgYG5maElhdpN3PmfOvA9C0aT81OCcw1RLb0
 AfBNQioaeXdLAibo2qfXchfnn2eW6oZxhDriuIskSaHYf5af5zixmTgasYRgsKd20g0hnKYue
 OvBHd/ygBhFFy8MZ5SEbmxApak+q1vwyZzBtO744+J19ghSoTgy4KM2Scv7PYlQt0GuHCut7B
 ZUGbbV0V+xUA8n+tLYfBdSOIfIN7BRzSKctlI8s6lQcgpS+I9/aMHWxpVa5nzxCdJk2iO0jOY
 XuojynQS9EzaWLuPiMlW+Ft8eMW9A/EERmmqYV2KNpSAIwhsbY9K2XOMCQohrkPkUrh8H9A9z
 HIa2FcH5m3Ln21+7cVrvPoCfBuh3v8uqz9/SaH3TgyulI=

Dear all,

here comes the usual update on Linux/ia64 for v6.11:

The v6.11 cycle was cut short by vacation, which thankfully didn't
create problems and the test results looked good for all tested machines
(up to and including v6.11-rc7 - more on that later). This cycle also
saw the switch from Binutils 2.42 to 2.43.1. And like for the v6.10
cycle (see last update on [1] for details) each release candidate and
release in this cycle was always built with the latest gcc-15 snapshot
(w/LRA enabled) available.

[1]:
https://lore.kernel.org/lkml/8dcb5d36-fc38-46f3-bb97-0e4e335c313b@online.d=
e/

Unfortunately I was a little too optimistic at the end and changed my
used kernel config at the last minute (i.e. for the v6.11 release) to
help with testing on Tomas' rx2620 and OS installation with btrfs
support and 64 KB page size. But that change must have somehow broken
successful operation inside the initrd on my rx4640. Well, the rx4640 is
not technically broken with v6.11, because it continues to work when
using a kernel based on Tomas' tree ([2]) on top of v6.11 with the very
same config. And my per-release (candidate) branches also showed no
regressions for the other machines (rx2620. rx2660, rx6600, rx2800 i2,
not to forget hp-sim, but uses a different config) with the exact same
initrd and v6.11. So maybe I should retest all real machines with a
kernel made with my older kernel config to be sure.

[2]: https://github.com/linux-ia64/linux-ia64/

[3]: https://github.com/johnny-mnemonic/linux-ia64/

****

Again no new additions to the selection of Linux distributions for ia64
this time - or at least I'm not aware of any. In the meantime Gentoo
dropped support for ia64, too, which honestly came as a surprise. I used
Gentoo some years ago for some time starting on a rx2660. I later also
used it on a rx2800 i2, because their ia64 kernel was the only one that
could run on the latter back then. I never found out exactly what was
responsible for this oddity, but fortunately it was somehow solved in
mainline some time later. So, farewell Gentoo/ia64. You were very useful
in times, thanks for that and to all people involved to make that happen
in the past.

This leaves T2/SDE and EPIC Slack as possibly the last remaining active
Linux distributions supporting ia64 machines for the time being. But
that can change easily, like it happened for MIPS and Alpha, if we look
at the latest headline over at gentoo.org:

https://www.gentoo.org/news/2024/09/11/Improved-MIPS-and-Alpha-support.htm=
l

****

One more thing:

So far we missed a public place were people can find current information
about Linux/ia64. This gap is now closed by epic-linux.org ([4]). There
you'll find a collection of resources around ia64, including news,
current code, our CIs, our testing effort, Linux distributions
supporting ia64, supported machines and links to other sites related to
ia64. And possibly even more in the future.

[4]: http://epic-linux.org/

****

Thank you all for your hard work on Linux!

Cheers,
Frank et al

