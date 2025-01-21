Return-Path: <linux-arch+bounces-9846-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0CA187EF
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 23:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC519169ADC
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 22:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303BC1F893F;
	Tue, 21 Jan 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="kO0NPbS7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38301F8698;
	Tue, 21 Jan 2025 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500194; cv=none; b=FHjHYaSMgFAocZQFkGciD9Pl+hjh/PRM6tjYXdW5iWEDZCbUq7YFaUcAxNUIJPWtk9geSEjZUGyMQz5Lwr81kZL2Z3Fcu/fX8onLkA+bjazEl65g2Ce3JBacv/rqeOdkdmpmu/0gquFreJRuDY2S/qgZWIdW4XXGbitPDCRKMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500194; c=relaxed/simple;
	bh=AJ98crD8TyhowO+ZiKFusJxxUDtVnGQ1gYexJP1S0HI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XlfxHooE2faQ6ogco2jmUHZu99n3hHBihvI8NaUZcJON4o4O83n4W4WzdGyyG663ExQvcsT1/2aCcJjuk4sEeb/F8O8kTb2Aly/5ZE+zhKggiqiEqOW0z86vJOaxm8Zg3x5hkATZBqMw0RJw4esR2UpYpsHd/g/5d0BJn64DaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=kO0NPbS7; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737500168; x=1738104968; i=frank.scheiner@web.de;
	bh=AJ98crD8TyhowO+ZiKFusJxxUDtVnGQ1gYexJP1S0HI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kO0NPbS7gy9ymCf14oWJxOQyhFs1swICATXjb7KEQAss/JoKqTIeIy1ZSCAg2L6d
	 pagclPwzCcZZpm5vHdb2FcwdO+PX9O84N79RqwrCFDdoIfWZS3MYhSGcbfh3vkVBw
	 hlvc0rZsxbWBDg2GX3rHcKj97jl0NnjSkV/0OTH38c7SaXetcOK9mQvRyxeVpazdn
	 BtB0UbkynRoXMpJzk3BEvLg7erDpWkYIwu/fEZfiYBUXeZ3YXlNuXSOBVoYWQXnnK
	 8KNRwm9vzkEkJKXsoAoiKGMwWSTVVrHC8zWUEtidcAWC5gahw68lEn83wms6uH3Ry
	 5G8y3YaqrjOflmVrWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([84.152.249.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zns-1tFh5Y1lXY-00s19u; Tue, 21
 Jan 2025 23:56:08 +0100
Message-ID: <53e3e309-4d66-40fe-9d47-dac6a61461d0@web.de>
Date: Tue, 21 Jan 2025 23:56:07 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Frank Scheiner <frank.scheiner@web.de>
Subject: Re: Linux 6.13
To: torvalds@linux-foundation.org
Cc: =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
 Sergei Trofimovich <slyich@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-ia64@vger.kernel.org, t2@t2sde.org
References: <CAHk-=wiprabAQcCwb3qNhrT5P50MJNqunC9JU5v99kdvM-2rsg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wiprabAQcCwb3qNhrT5P50MJNqunC9JU5v99kdvM-2rsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mSSkqmsJuUs2AknCI1ZhDLFtO7KC6siZlnGj54QcVYVm2VOKNAE
 NMbwRPdF4E1lvnYHorOYACwkmSNgYIuXQ6kI7ULTRNfHQrcXlIQc087yMezDRiIIASDgmBb
 860yfAfTUoFzfeXEB3iIFMidzDpjcQ8Uh5tMoFCc425IwHP2yhdLDPNtc+KVsQEc5LTHEk9
 /8yP2ilxl+2M+s5vu3lHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PLGqESy+w4s=;ijmSYARNiMJTkKkbZUigr380uYJ
 n+MOxnNcBtHkVP9gGqyclVi1FF+ZvAWFFtJr7dgGPv84vYo8gSkQIhizFKf47ieiJ6vf4YEaO
 VNVSlCNJqGbhM4fx5ZmJ77UsEafh2pOoeGbZu1Q8tk3A0XynPS5okTrO3AzzHpNyO76PPDbu0
 NNm1dAon356/u9Z93RyuvW37wRrh+VJ3YpTCz4tTQh7yUo2QE0/l1bA8zRBUSn6eQDgiq1JbJ
 QZaThbt2W9+0GShNlUiIRW7KlXDFa61NNvYP9UuMjevgDME11yXjSLpzNPMOKi4qIwRLYrptv
 rMRTHND9ns4/4+GwhbRWFVvC4/yDCZlHTKy4TINZvFvbCFTy8lpZlv8crozxZXLEgaJcW7s19
 31oChfQp7rBeGNZTqu5bkms3LoijO+DvCgNXF4Z5CexuXSDxVSMDOl3USOhaES3PywNWAQ+PH
 Bc+J9hNX8WDhADNJNw7M15f9CTls/H/c0tggwWmHdb+wtIoxvQ3oSjGCrOC7UgmHzU1xiv51U
 zRdAuMj6wuktidviKGsNm9pYtvGNilfqeeFXsoOnpKxFtnyEqv4UT0XG89bcHd0icKmCQJcPg
 yOCT90Bedu8QoNPxI2jX8rNd2HORp8vra71w4jN7y91MoC2eERKsQAldG3xM/iy7iMXZSLt1h
 yrrDOqi7tksEKP07nQQtygG2bbhlXMWqmIRBZ48lwqYjEwsyQR81LVKrO/KoITQ5sFP9mtrtp
 NcjAcmtRywmbcUU6aNC7KM7qlJw15xBnrtpQ/K7XGmXIR8vzCkoGpOj9s+SRve4B/e2oBEKCs
 t+WtqOTO+S0HagBNO2/ny3SnqDS+qTn3DszuxqTpi8uNfzc/p1SsiEL9XDt02YVxpa6dzbqgz
 IigljZJrL/mcidt2pG1lSqyl8kpfOpVED3hCfOVNPKnEMB2cr8OFcTXxTiBr3/JyKndTgx7HL
 Rv85Wr6tdFbm0MrXVRtr2MB+NLtEcpf+N+Q+7nXuyp0Gadc4W4ZclpaEZO2WH7/6xb3tisnT6
 Pc0EQ4W6fQ7wpE81t1zKMsbS1yf0jkH9npiDo+ZdsPCxpq25MsBWfLjj85Itlxme5Vi5DGENb
 1BmJ+AKg/fgFcfpDBMcY4yxXmUL1N3xJrXX3ynZM9Uknrn/irKVbYT0qhKLisIfjldJizNAsk
 on3YySJ05owzmvUhhbfI+dafARuoVJoucAQFwgDN7unNI8ZC8RNBXyl7nJQ57K2yTvO4K37hS
 kBQNGoLwwD97

Dear all,

here comes the usual update on Linux/ia64, this time for v6.13:

In short: looking good!

It felt like this cycle required a bigger than usual effort to fix build
regressions for ia64 during the merge window or maybe the number of
regressions was bigger, but by the time 6.13-rc1 was released things
had stablized. There weren't any additional regressions detected in the
following RCs, apart from needed adaptations due to changes in the
kernel configuration that is used for the regular testing of the ia64
machines available to us.

Per release (candidate) sources can be found on [1].

[1]: https://github.com/johnny-mnemonic/linux-ia64

This time we also put something "new" and useful for ia64 machines into
the kernel. Albeit small changes like extending the processor feature
flags or including useful driver code for specific machines (enabling
HBA operation of the integrated SAS controller in rx2800 i2s) or giving
Ski its own processor model - the MonteSkito. :-) Because from the
exposed processor feature flags, it is equal to a Montecito processor.


Apropos Ski: During this cycle we also managed to improve the
performance of the simulator by up to 1.53 times for disk writes and up
to 1.36 times for package builds (for example up to 1.47 times for the
configure step and up to 1.39 times for the make step, all determined by
instrumenting the package builds and taking the timing on the host).
Well, connoisseurs of Ski might argue that 1.x times slow is still slow,
but it's also a considerable speedup for a micro-change in the firmware
(the ski-bootloader in this case).

The change is trivial ([2]) and possibly related to the max clock of the
host processor, but the effect is real. Ski still hogs a full hardware
thread, but you can get more out of it, so that's a plus.

[2]: https://github.com/linux-ia64/ski/commit/b53b78c2379ec8f0e78ed37986db654a73d69534

Apart from the benchmarking we also examined what else is possible with
Ski:

* In system mode ski can run a HP-Sim kernel (thanks to Sergei also with
an initrd - like a real machine) and boot complete operating systems.

* Also networking is supported but during our testing so far required a
separate real interface on the host (can be a USB2Ethernet adapter) for
use by Ski. It also allows to mount NFS shares from other machines than
the host inside Ski, which makes it possible to have a shared storage
during runtime between Ski and the host. Together with the remote
control we came up so far, this can be used to quickly execute ia64
binaries inside Ski with output forwarded to the host (including the
exit code). Booting the kernel can be avoided for later invocations by
SIGSTOPping the Ski process and SIGCONTinuing it when needed.

* We also looked into running Ski inside a Docker container which should
make it easy to use for container savvy people.

To round this up it is planned to create one or more howto(s) for Ski to
give people all required information at hand to use it easily, making
Ski an adequate solution for emulating ia64. If you desire more
performance, get a real machine or invest into a much faster host
machine, or even better put some effort into further improving Ski's
performance.


The autobuilders for Linux mainline and Linux stable and toolchain
continue to be useful for maintaining Linux and glibc for ia64. They are
also proof that there is an easy way to build-test source changes for
ia64. Ready-made toolchains are available from [3]. But you can also
build those yourself. Two howtos were created for that: (1) about
building a toolchain to create a (ia64) kernel ([4]), like the ones from
Arnd and (2) for manually building a (ia64) kernel with such a toolchain
([5]).

[3]: https://ftp.machine-hall.org/pub/toolchains/

[4]: http://epic-slack.org/#!articles/2024-12-01-building-a-toolchain.md

[5]: http://epic-slack.org/#!articles/2024-12-15-building-your-own-kernel.md


Lastly a few words about documentation: Parts of the vast but widely
distributed IA-64 documentation (like papers, articles, presentations,
white papers, general documentation and data sheets) available on the
web were catalogued and links were curated on [6] for quick and easy
usage and occasional reading.

[6]: http://epic-linux.org/#!/docs/


Find the last Linux/ia64 update on [7].

[7]: https://lore.kernel.org/lkml/775f2bd5-5567-4da2-9b79-8f2e7fc9b38a@web.de/

****

Thank you all for your hard work on Linux!

Cheers,
Frank et al


