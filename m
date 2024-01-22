Return-Path: <linux-arch+bounces-1421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A758E836D9D
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89DB1C280B9
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A573FE20;
	Mon, 22 Jan 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="FupSG+b4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84063D0BB;
	Mon, 22 Jan 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942082; cv=none; b=sIMgLAq0OD7QAWWc1BvayIB2h4w+FItiT6XbUOqDWvGdBGv4z8Xd+sYDEC8hXZqzea37Hb4VytuStnoFI2D8wQXn+KACz0+7FwHtU3F2ww4edvzShUzoaXT5HJ4DBSLEOjUow1TRxFkgzmFHn53QS/aNlIOl3OZHf+4tus2drRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942082; c=relaxed/simple;
	bh=lIPyg3S025BUz4/YnOih7drXs+pDN+PJEyx3Of/a6Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0eJM1Dg6qRCH9cf8Tk6J/CsY1uYjrCbQOzsq3Ml+mrGrOpzhKiMgVuuphwJ6VXUayF3TkfmK44E5SCLTBm8HpTTUKfWhWdm6Yw1PAe+ovrOZY6mg2WQuN/4VC6ZyVQPNSj+xShrk+v9GpOGjHDn4IxcldNOVppqtNZrxIdwzps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=FupSG+b4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705942070; x=1706546870; i=deller@gmx.de;
	bh=lIPyg3S025BUz4/YnOih7drXs+pDN+PJEyx3Of/a6Gc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FupSG+b4mEwvFzcy/BBAb2Ot4IjTlZINC3SKHE4Txi3CrPNcKfGnOLYQuF4ER5K+
	 /CL1HpfmXz9U1NRj1MY8nrFC5CiyJQfCdZP/I9FOZYyhrV4aa6sy2A1KURzUcaOV5
	 MYsxE1RqC4xP/n4gv5LD+mzRtjtbzuAEpMg5LFIu71PBSt+pgts5SUEf1oVkOfKZX
	 qtXjbPjHfbv/vNEex0WrSQDJIthSGJa6ZJ+0nRM/AHnPbCnQTZ9hnSVO1Fwm6+EFU
	 uQqPDPfbUYWps8yK5k5CPDUKowVxdIcG+RRyP7P8uGa2FKL0CZIqwhKzU0zi82E//
	 8V1B1aLQBvQryUT0Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.156.47]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1rDZMw16yy-00wV65; Mon, 22
 Jan 2024 17:47:50 +0100
Message-ID: <b5e98501-6262-4b04-bbae-238e4956f904@gmx.de>
Date: Mon, 22 Jan 2024 17:47:49 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] modules: Ensure 64-bit alignment on __ksymtab_*
 sections
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-modules@vger.kernel.org, linux-arch@vger.kernel.org
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-3-deller@kernel.org>
 <ZYUlpxlg/WooxGWZ@bombadil.infradead.org>
 <1b73bc5a-1948-4e67-9ec5-b238723b3a48@gmx.de>
 <ZYXtPL7Ds1SUKPLT@bombadil.infradead.org>
 <59bc81b5-820e-40ff-9159-c03e429af9a6@gmx.de>
 <Za6Td6cx3JbTfnCZ@bombadil.infradead.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <Za6Td6cx3JbTfnCZ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYWNfsdJBYydO+e9IW/6LWf91uPZpCyLwqwk8OWokVoUL2t3Tli
 2xkCUlGTSIjoRM7jMLcLgY0z9OBPLd/mhJhbUffjVULEsigtpNZjfxR7GBRsJKSo/lRhVc3
 hqrAwWO52dauqV58tSiApSPnZfVPA/YKLLgWNZRh6yP33ms0Nk93yJDkMFe+oIWslL0Z8Iq
 YmpB6dH5RRZkxHgLgZOIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DYeAATLUhG0=;4Bmjmu6zM29l8nJzQYU6xm3iR5+
 GI9950LiKjtT/U74gMfkcidZu3ES26tdejQgirDoqAJwusliYsasuBHw9eOAR+Av/Cxv3qO6r
 lIUn7MQbMuL2cdbUYXnSGlNz+GnotLoamrO+5y4vMdky6Sj0LrGb9TtdjlE7OHRHdZKBE6cIO
 wE0HhvpG3XxvuqgNqbOZSzFlJ477A+WzwRrFKImDB+7v239UfgNxMl2YmdJOGqD4Bnm7RHbbe
 oUH2JDdRpZFsLwUVf4iXadWCrz0zcbkvSp+dsWLoyTGubVVqjUwpkq6KAoIUZD2xEC4w9Aym4
 Oa2cf1iKuI1qnqolIUuZVHHqX+JxCcTftfRBvYQdMEhiYUFfpv2G4JUCkpSsUnC8m1yEM5m6z
 s7MANV1MURKZmIp3g+S4mLvnGFlDFQWXL3A/Rt/ok2LSaz4F1D1OkLLymTxeLYnKqR+OsaJC8
 BBEzAyJQYXmvdrdbFXATBt3zTxatnIvEXUCD8LhnbSlbzT+feeXqoBaC1U1iwTd40AeWp4eWy
 Z1ZuOYTCTXZA3BFYj+WreFL60KU9nBCmpBtiCQUNIKZuL0XyJeU0JtW9Dg+PEL6dH8ekvpAy/
 T+yySRs6LNnK7L2Y0xvjE9VeV953G3K6DrgTnEF5Bdm+5ucUcOt9oskT/1C2TF8fJrzq6+Yzz
 U7pwG/7V0jVJvXIHiGXV81dysQ3EbtaaasddyrGQfyWuNN13+wMQRH9F6TjxyHsLjhyLglAjO
 oNjQt9zvJrA0DjmAh/hTLzuxiCFPY2Je0ERkMP8wuft6YOlbepOcvvSem2aA9SmTIVl41hCH7
 PZcANsLO8C2NAD3onxvP8/nFN0j2Pxr6Y5GkR+AK3AwdHffKaoPSoRCYic8MN11fCoIFJjNWZ
 /fVCU6OdfPXsCvXRinuw+SE0zIRMQmMx3yeR2mnh38Va0WEdOv+KAIUaGEEnrrMmVAx9+z3U7
 fZaLVg==

On 1/22/24 17:10, Luis Chamberlain wrote:
> On Sat, Dec 30, 2023 at 08:33:24AM +0100, Helge Deller wrote:
>> Your selftest code is based on perf.
>> AFAICS we don't have perf on parisc/hppa,
>
> I see!
>
>> so I can't test your selftest code
>> on that architecture.
>> I assume you tested on x86, where the CPU will transparently take care =
of
>> unaligned accesses. This is probably why the results are within
>> the noise.
>> But on some platforms the CPU raises an exception on unaligned accesses
>> and jumps into special exception handler assembler code inside the kern=
el.
>> This is much more expensive than on x86, which is why we track on paris=
c
>> in /proc/cpuinfo counters on how often this exception handler is called=
:
>> IRQ:       CPU0       CPU1
>>    3:       1332          0         SuperIO  ttyS0
>>    7:    1270013          0         SuperIO  pata_ns87415
>>   64:  320023012  320021431             CPU  timer
>>   65:   17080507   20624423             CPU  IPI
>> UAH:   10948640      58104   Unaligned access handler traps
>>
>> This "UAH" field could theoretically be used to extend your selftest.
>
> Nice!
>
>> But is it really worth it? The outcome is very much architecture and CP=
U
>> specific, maybe it's just within the noise as you measured.
>
> It's within the noise for x86_64, but given what you suggest
> for parisc where it is much more expensive, we should see a non-noise
> delta. Even just time on loading the module should likely result in
> a considerable delta than on x86_64. You may just need to play a bit
> with the default values at build time.

I don't know if it will be a "considerable" amount of time.

>> IMHO we should always try to natively align structures, and if we see
>> we got it wrong in kernel code, we should fix it.
>
> This was all motivated by the first review criteria of these patches
> as if they were stable worthy or not. Even if we don't consider them
> stable material, given the test is now written and easily extended to
> test on parisc with just timing information and UAH I think it would
> be nice to have this data for a few larger default factor values so we
> can compare against x86_64 while we're at it.
>
> If you don't feel like doing that test that's fine too, we can just
> ignore that.

I can do that test, but I won't have time for that in the next few weeks..=
.

> I'll still apply the patches
Yes, please do!
Even if I don't test now, I (or others) will test at a later point.

> but, I figured I'd ask to collect information while the test was already
> written and it should now be easy to compare / contrast differences.
Ok.

Helge

