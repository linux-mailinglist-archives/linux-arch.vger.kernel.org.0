Return-Path: <linux-arch+bounces-1165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FFD81C72F
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E21B23830
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 09:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3D7D527;
	Fri, 22 Dec 2023 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="JqZHi07B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16338D50B;
	Fri, 22 Dec 2023 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703236424; x=1703841224; i=deller@gmx.de;
	bh=n+MfHC35t0Y8oIxZ/m3u33zRT3uWWgpuiarIUZkHvsY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JqZHi07BGLzBH6wGJMAtfdqGkRhT4R3mGvXPEuU7a0Ewp4yAVeflRDQ3MdEF7nTY
	 h6TKNHykr+MYBg+DfyomXVyTORB0f74N/lkKcXw336K9LCI5yuYsCy9oMxv7jflmL
	 7XIC0tfqP8V/DEYw0g8SFy8eVfdmepQgVv1T1Lef22dKthiiVeC7NCZ/yVKzlX4B5
	 Sjp5a6xXCMQun65pblV6nr8xy+mhlIu3w915+utWrOxkJNyfwmrmS/3/f2neurkia
	 saDB/GsrQuX7yQK/Yt+dJhiXo/i6nCbvcyeqJaYOz/1zGrK7x3eKVY5xwjS1KH+oU
	 ixHhrfAKQDHv5w6sDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.108]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1rPABl2zLd-009BUo; Fri, 22
 Dec 2023 10:13:44 +0100
Message-ID: <c4922789-0561-46bd-814b-1cd0253d3562@gmx.de>
Date: Fri, 22 Dec 2023 10:13:44 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Section alignment issues?
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20231122221814.139916-1-deller@kernel.org>
 <ZYIKmQj0H1YAJWlz@bombadil.infradead.org>
 <ZYNDLEzkjfrpgu7U@bombadil.infradead.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZYNDLEzkjfrpgu7U@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3zEqUv9AZnY9J4XQazbk3elNn/rcWjDfLdQDJzqcBLfiUhtMYSh
 jJkPybvj/oYwFs6O3Wu2JWJjbAao1IvpGCuWw/TyaDY7OJ3SrocW4QBDZvqOfUawqyVyC5G
 1jVQ5lIrsDnFJ/M1maFDa24ThdS27PZxoCjxS/J3oZDpfA2no53glPX21EyY1kk76OiZztP
 fI9dQ6K324bndN9usJQaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AMQrj8E/jfQ=;E1jhV0dKW144QoERt+ctLefPCuZ
 cbOmp+8WED+2rLEFeeijZJfwFuWs8BSuDhb0I10/pt9hZJlHcy1NH1ZAnyEvUy245iJ35e5T+
 n9l4kNfdKAALewRc1k69ieHMhQ+w2MNHs7xwL1Vs4Nl2QytR6iHTEwx3dFxqzqvDZTSvxUZLF
 uF0HN4Yyz2esmCZwzzTJ7cyLz6tnP10gezcIRvKXSjYpKD2dVwal8TM2zLFPOQBIFKff/2b9O
 4XFCsMCAlNOxslVwQqHt98MD8vK0l9A1QzJxwfqnc2GGsRniicjO6ki6X+8in+uJPPC96XtkB
 J9C8EL+mWpMFU+D8eLJJ8kI34rnrRuwuCtS7CqoSRP4NnI3YGKGLm8p4FN86Ir4Ijth3eQrH/
 2iyBGdl6vWcutoXVQ1k5jT1gju6TBFk0aU6U17SOamK7++SVq3wvArCOls8wNHH9PB4Ah7gNT
 YapJqaM/vYGVIH+3LS94i6UTfrueEcNDwKuLdRKfTTCR/JpW8xhV9SJN4o1iWElEhIci+/ptw
 bVm/64tb87Ps2aWjd4fFVyQWHwrFAoRAwB9KhI/MmWJpkpwoxqLQ6sY6I2mrmNObNIY9ZoQ85
 7clab0kdwmkxNsdLgsrVn4RHr0z4UyXln/948KX9HfUB98HlHNZvMhXcEj0H4KVJN9oYWAZgA
 3ZNyTg3yGMxe6MacJbq1E6awRZXGbLNEcLVKZSssuhm8Z43IoB7J+cVMH9Ec8Hiy7GuYyNNnJ
 iWZVGZuCfE2vdm0Gw/z9/pnfb5x8Qa9P0wLSEPqGggT4Xv/n4zCImMuuTiwXtFKzyw6dCtM6h
 CEE2SIzASJiirCnWI2IM1zJQtg5Dzhh5r5UIm+6i/s/ZLX5jL2V04PvpuB9GrgdFnXE1mEkMD
 g005RLUKxnJQ2Xb7A1YPIzUBp9VYaMYb8DThOIye/4NAgYptq5gMJlfMmS4FzOkpwZcs2SoPm
 D4pB7QmUCfkXlgVlcNG0devB9LI=

On 12/20/23 20:40, Luis Chamberlain wrote:
> On Tue, Dec 19, 2023 at 01:26:49PM -0800, Luis Chamberlain wrote:
>> On Wed, Nov 22, 2023 at 11:18:10PM +0100, deller@kernel.org wrote:
>>> From: Helge Deller <deller@gmx.de>
>>> My questions:
>>> - Am I wrong with my analysis?
>>
>> This would typically of course depend on the arch, but whether it helps
>> is what I would like to see with real numbers rather then speculation.
>> Howeer, I don't expect some of these are hot paths except maybe the
>> table lookups. So could you look at some perf stat differences
>> without / with alignment ? Other than bootup live patching would be
>> a good test case. We have selftest for modules, the script in selftests
>> tools/testing/selftests/kmod/kmod.sh is pretty aggressive, but the live
>> patching tests might be better suited.
>>
>>> - What does people see on other architectures?
>>> - Does it make sense to add a compile- and runtime-check, like the pat=
ch below, to the kernel?
>>
>> The chatty aspects really depend on the above results.
>>
>> Aren't there some archs where an unaligned access would actually crash?
>> Why hasn't that happened?
>
> I've gone down through memory lane and we have discussed this before.
>
> It would seem this misalignment should not affect performance, and this
> should not be an issue unless you have a buggy exception hanlder. We
> actually ran into one before. Please refer to merge commit
>
> e74acdf55da6649dd30be5b621a93b71cbe7f3f9

Yes, this is the second time I stumbled over this issue.
But let's continue discussing in the other mail thread...

Helge

