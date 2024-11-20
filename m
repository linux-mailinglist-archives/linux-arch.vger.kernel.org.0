Return-Path: <linux-arch+bounces-9142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E89D3F0C
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2024 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6481F2463E
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF0212C54B;
	Wed, 20 Nov 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="LCeu9V1q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980034B5C1;
	Wed, 20 Nov 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116627; cv=none; b=HIl0zhmTmecopKwSjNP4a5iwpSFKV8+onBuIyfw8uqyWLbVGmJrys9l/Ra3V4VgdezUyh9gbKme/wLBL7VooG2e+iXz3TAZADg78WZoEpYnsZEzsgUFPsGP5HEQT2faX6zOXlfnBj1cJlNJ4fh/rt/fls0O0aIpQNBwah4XlZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116627; c=relaxed/simple;
	bh=j4CtSxksIEIQ1zyrX4HyLd+iQzjRfcoZC/JH6Pc12A0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FHcw1PfETiA1fP+eu1E1u9brJJk1b7CcU+erl8MoQ3/1tIHcF9yHZUoFOfQbaaB+6xHq5hcqW/X3TVoD5e3lHS+leOyJEFJQpWVFY0MyKKAD30AbaWuTJEleTvSsiBNXP/pkZyHHnG/jO8a0jkUmqWj0za6WgLPS4lcDDvMFB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=LCeu9V1q; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732116601; x=1732721401; i=frank.scheiner@web.de;
	bh=j4CtSxksIEIQ1zyrX4HyLd+iQzjRfcoZC/JH6Pc12A0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LCeu9V1quWWPcfyi4M4cbuPy6RfVhszMT4CoS9YV//WcRsdVE78CocFNkIXsdKqz
	 fxEc2e9OdV4iF5/LyCYxMWpVwWtrv784tdYMEqHO0ki1brq3jZwDt0CHpbZ5cgDWX
	 RA8uLa7g5tTNa9EimzZDP9GjyJWwQyeVhu0J2WZhWFXJ3rCpbaR4dlzcvA6sI+vcW
	 gKghPS+XiBFMfDleAdYhxgf07AEPJFsTAaCc5xWZjiiDGwETWlcr8CecvDD1XYh9d
	 Ib62eKOMqGs/iS2j9mAzlmH1/JokL56eOOFzoptyZx21y60UMALCbEB62vq33Rcj1
	 hVxVP+QYCp1zt3VBsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([79.200.222.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFhe-1tiBmk3ya2-00fs21; Wed, 20
 Nov 2024 16:30:01 +0100
Message-ID: <775f2bd5-5567-4da2-9b79-8f2e7fc9b38a@web.de>
Date: Wed, 20 Nov 2024 16:29:59 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Frank Scheiner <frank.scheiner@web.de>
Subject: Re: Linux 6.12
To: torvalds@linux-foundation.org
Cc: =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
 Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-ia64@vger.kernel.org,
 t2@t2sde.org
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xOzZJ5tRyFkvfKBxbt7nBXwHvuyAkdxlFiNel3j6c45R0SIxgw2
 WhByoy/IWm3Ua9ZjPC5ayNsN8lxpt5RrkGiPf+HzHG5kDpkHSWqLFVDpHmJzkS6BMf6uemP
 qRol1Rw4qKxWARMCe0oyStLniuRF04HSaFIFyegypRCimWJv2LnFQIfpkMYQ51LMIWG6Hq4
 q6K2z+N+ZJ5P0LVe31QMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qG0oXz7UEGQ=;LnaInnpYYmBF6D5xWf4W5rc7ol/
 xYpB5Z8upXqUQN24aS875AGYwMg7Vmcp7OMqtvP6Plz4XGQqOkLIJmbqT0qxwWhIb6dnz5ZMz
 vCNKmMsLRUQnTn51ttIc7b7tSPEzDc5eMUF/cAEOnoi0wkqqwX+gy6ymJmBHW61gIo5+wfOZ0
 08nJh7vsqW6WF12DPQoLiEqnW6RewIXkoKTL19neh38UY6HrpHFHiTcwZFLWnPW3Y9Ao+bKzV
 zhHVAt1OrWMqNVKrSobI+GTLKZjeQ83+1RPOJcARMw8aj5G8HkR8Dxbi1catSWlOWAR5VSD4R
 Ja3Gkwbkx07afgaD5biKmyUu/WoXWVNMkcLcK/fSI3VxsQfaJLDkUxL4CMsDUfTjy0SbOXe6I
 oEWoUF4b3F+kTFQCutLt9ZPyr8ZGLL33rjjCmd6JqT2oiv8FPdric6pHVq29/zjubmsyuxEZf
 ZEOpTpJ5Cl9jG8hYUFzv7ukyyzIZ77ruUS9kVoeHUNSFrgZ27YK7PAKNHZRqP5IAnwV9BaRlp
 1n7XWwfRU6BXGf+JyMd6b8L8AvN/6lux8Mxmfcr4E5iRzcNuxq/I5Gzw+TxtvH2Cs2RNbuZPD
 ht6XofMozlkOBD1IJ+SAt/itlt3prKu/aEG+vweVphtmyigILndn0wpKxmcQlvbnaBrkDprrD
 kKi/w7mv/0olL+7vaebOkjxdS1CLznoRo+EKF3bI2rFHsXFbHbU9rPJOXXKbNkGb9nnEFGHR3
 HA5NXpr6L19ErBsLY0euUl/W9k61UT3p4BotcaQctXFmQHNc2mTugskPPGPJL0tvmO6dryENi
 7cNa/WbtGIy0f6o4Yi4pRAffvGj5P6RK6yHvPlYuZGX0tMkoJIKNJvp3lg2hG2+QF+nJ2VkWy
 duJdYy6+wZoQ3xyiuvmFi3xeiIt5Q3v7vfMoE1bDoo4L4xvyPM1scnsFqE/1DaSaEeKBmTKeU
 jYK6vffuuRMoXGE4A87SkbqBxRjxdGProlw3245erUmEIJ6GVQnoM/WbU+VGH0+cI0lrEZIIQ
 wUY9EjDlIPEAQY18DdksvMNjCkSKiceL6S28jDW1qMUpYEMadwC7wYqYfzAslSNd4qtrIfJET
 nEkq9IGEEM4d3xvokJPiaYX0gTc1Il

Dear all,

here comes the usual update on Linux/ia64 for v6.12:

We're already past mid November, so it looks like we're doing this now
since over a year actually. Maybe a good occasion to go through some of
the highlights during this time frame:

* Six mainline releases v6.7 - v6.12, all running on the ia64 hardware
we have available for testing ([1]). Not to speak of all the RCs and
test builds during merge windows tested in between. To have a
forward-look on possible build problems between RCs and during merge
windows an auto-builder for Linux mainline was set up, that builds
mainline for ia64 each day. This also shortens the time frame for us to
check for a cause when problems arise.

[1]: http://epic-linux.org/#!testing-effort/tested-kernels-table.md


* The hp-sim platform was reinstated for Linux up to mainline, allowing
everybody to run ia64 software (kernels and userland) on non-ia64
hardware, thanks to ski maintained by Sergei Trofimovich. This is for
example used for our Linux stable R(C) auto-builder to test-boot each
kernel after it was built and run some userland tools for a test. By
involving ski for this auto-builder it can not only demonstrate build
problems, but also problems during runtime, as shown already in the
corresponding issues ([2]).

[2]: https://github.com/linux-ia64/linux-stable-rc/issues


* Two Linux distributions keep support for ia64: T2/SDE ([3]) and EPIC
Slack [(4)].

[3]: https://t2sde.org/

[4]: http://epic-slack.org/


* Also http://epic-linux.org/ was established to allow interested people
to find current and relevant information about Linux/ia64 at a central
place.


Maybe someone can help me here with the history, but was there another
architecture that has been kicked out of the kernel, that received that
level of continuation afterwards?

We'll see where this goes.


Find the last Linux/ia64 update on [5].

[5]: https://lore.kernel.org/lkml/5d1b5880-9bdc-4b04-81dc-341df7b02177@web.de/

****

Thank you all for your hard work on Linux!

Cheers,
Frank et al

