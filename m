Return-Path: <linux-arch+bounces-4424-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B608C67AA
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AA22818AE
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD6713E8BE;
	Wed, 15 May 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="CP+A1NYe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27D136983;
	Wed, 15 May 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780738; cv=none; b=CAVwoQsqN7HHBHMPSg117U/H2w3FnbnsFUcKCgoNfqhDgKO7qAQVBAKtfpcqJxF5SHnWPv08VtZLILpsqJO85w7oqAv5dpLtieEROu6OyOBAal0fT6pgFeHqOhAiHBPnqGwHEAp8xsZTnn9chYq4ldNAjQAfarqV08GePY1OT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780738; c=relaxed/simple;
	bh=YE7mdJ69I1zEoXQBaNcngBx75+rQO1q57VLEI4yySyM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G+b045Sax4wq+etayFKOvi/IyAwpOBvdElFW9uhgEq5AGuPFVZSDMXRlQJRQ6t5rXSOYkbtASMP4iBo/2c3JmTvblpEf+ap0Wt3KjO4UtGmuG2t6preLsh+fgHWWffyzJallFFVsVJXWGNxdXgXir0kQBgYM95DwkrPD9yNXVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=CP+A1NYe; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715780688; x=1716385488; i=frank.scheiner@web.de;
	bh=YE7mdJ69I1zEoXQBaNcngBx75+rQO1q57VLEI4yySyM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CP+A1NYeKHy13DD7flBGsl0mfI+mkdiE2QcY76l2iMUPcSvPhVYl1XBPTTQAN4um
	 w9mUTYH+FB/PrfJfDwu7MrBP2lhwSOCMzlyg/rseJ6ZZO1xKzOZsxjgci6MdvbUe2
	 wzRIIk0OT/gwUWEH3aQHqwWrO/yHqIAbw9qOTntXdD7LCcR9m0H1RKXLZLctoTaPh
	 9pcGRdY0aiEEQT7EStyGQdaDIGjuM49Yt486DnsOV2QEYuxF7jl3UjAdUrtTjp8+x
	 dW35GPzHmYyewo+XVkBRdnvbjTQmJ+tdEZs98i8TlhlTNwECqp2aytBNz4LgWCbQy
	 h+Yql96IKjck/jMGDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([84.152.252.20]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mty5u-1sPrDg21mu-016P9E; Wed, 15
 May 2024 15:44:48 +0200
Message-ID: <d308ad95-bee4-4401-a6f5-27bcf5bcc52d@web.de>
Date: Wed, 15 May 2024 15:44:47 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Frank Scheiner <frank.scheiner@web.de>
Subject: Re: Linux 6.9
To: torvalds@linux-foundation.org
Cc: =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-ia64@vger.kernel.org, debian-ia64 <debian-ia64@lists.debian.org>,
 t2@t2sde.org
References: <CAHk-=whnKYL-WARzrZhVTZ8RP3WZc24C9_DT7JMJooONNT2udQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=whnKYL-WARzrZhVTZ8RP3WZc24C9_DT7JMJooONNT2udQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PpT30J7xl4RRoKLU5DgYkRSnzhpsr3kgxmbWkAflkk40x0/SdOt
 UDqnmRjYK1Mg44M02VHNgpo8Pli6mru6Kt1mORjv30zVXZxHSxFQ9J76SszJXOBbzrtW2Ki
 6JIqo5DIQTdBrPUf29CSvMRzIarPttcDWEnvZmLoax6AnLie4lLj9uJykvxXexGH9Y9yRlE
 A7JfGJs84BymHzrSqAXiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:loiOJGidEi4=;IIpzaHGk0bUhcjcdXTYEUKBLt3K
 TUajYuU82VbE1GlP8e3BTtxtpMcXcDOvDeCk6hUjyy51aIny9taA0L3JDxC+Fmbl0t73XonV3
 Ig386hiUYscgI0YZuHWFc3bhe8l1UkG2EbUqtBlo9gOnZIaxmgj063Y+TaOBA5E+pIFavhK26
 ifAjejU6duXKAtFX3DW9X52jArTIyN7HQX0E3ufW3KNPBt0U7lCEFiyERUq0gc6ETcCknSCgY
 YFqXgYDc1kZczYiSBn5kKshGikrP248vKf7gO/syXIpFE+Da1mwzqnjR7EtjAvpDqGxCTLNec
 Xe/rdPtnAHGsp5T05Tq5FRGw1tZbMwhGtsZoGwkhTESvD7UW2jEEkMXb9CGANrVjjuG/83PIA
 MSTTRljiiB0+Nk2dPBqBfAgPzuPnfX6KjK3YFKKuy6PSuzeTzVI6g1siIEufZuZLQ0CrIdGU9
 WB/Z6h7P64YMSri1/pv2Jiu67sye/xWNaQag9AtQvduqa6LSec+Nryl25OaBVEe52BynaYdi4
 hqY1CYyzHiYQ2gEGPdtXxlrnF+UQldoylU43kBcygaqTnACmeG4MedlAYlRon6+502AIPwoYU
 zgCFBWnU78p1VMXOsPGjcVRGNHMzMAnMWXlmlB3wYNessY6SD7IVVgON/8C993tJRB//JjuX2
 bWSNs/dtHOB6+NfsvEDmSS68TIp8pm/bPA7XJZ0AUehbIkIsB4f/2kmhcldFN/te6uTJDrkKW
 5Ao5ETNkLCjHULSAIv28Sa2CF6bhIp/LWjFMhofr0FUrXqNNgFVevjRNbBjj46bIXFzZ+2rAW
 lQUT/S1SgeWIiElcpV62a7VAqbw99hWqGeMc6hrvjFOH8=

Dear all,

here comes the usual update on Linux/ia64:

The reason for the userland regression we mentioned last time (in [1])
was found and fixed shortly after the release of v6.8.

[1]:
https://lore.kernel.org/all/145da253-b3bc-43da-a262-a3ebdfbea5a2@web.de/

Furthermore there were no new hard regressions detected in addition to
what was reported in [2] already. If you have an ia64 machine with more
than 64 hardware threads and want to run Linux on it, get in touch with
us. :-)

[2]:
https://lore.kernel.org/linux-ia64/CAHtyXDdy5Lub_UeMQRgr8O_G-XK0_XRD3J7wVB=
9t9rRD5x6d4g@mail.gmail.com/

Again all ia64 machines (see [3] for a list) and platforms (HP Sim on
Ski) we have available for testing continue to work, no system support
was lost during this cycle.

[3]:
https://lore.kernel.org/all/fe5f6e9b-02a2-42e9-8151-ae4b6fdba7e3@web.de/

In the meantime gcc-14 was released, meaning that the regular
compilation and testing of Linux mainline release (candidates) switched
to gcc-15 snapshots now (starting with v6.9-rc6). Enabling LRA for the
cross-compiler continues to make **no problems** for ia64 kernels. The
same is true with the switch to binutils 2.42 since v6.9-rc2.

****

Last time ([1]) we had to report about an approaching decrease in the
number of available Linux distributions with support for ia64. This was
sad to report, also because options are important.

But don't worry, the distro options for your ia64 gear just have
increased again:

Enter **EPIC Slack** ([4]) - an unofficial "port" of Slackware for ia64
that was started recently and - though still work in progress - is
already network booting on all test machines available to us. If you're
too young to know what Slackware is, head over to [5] and learn more
about it (-;.

[4]: http://epic-slack.org/

[5]: http://www.slackware.com/

****

Thank you all for your hard work on Linux!

Cheers,
Frank et al

