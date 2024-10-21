Return-Path: <linux-arch+bounces-8389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFB9A9093
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 22:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB09B21345
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD21D3578;
	Mon, 21 Oct 2024 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Ch69hwiY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90D1EEE0;
	Mon, 21 Oct 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541247; cv=none; b=W5kjPes0lOU3MJM13ZamBTY+n79zLQRTyh8z0I5dbTSGbVFrs8zXJnhqmlfnLF22V+YfDOzTfGaMR05SZmlq6Xysu/NMF/OJuhxiYDCf4hPe9LB2x7b1tyqnr6N0dVAwI86buWvxxqlL2z5ktDCerMDpf7wj8XB7dja0m2YObzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541247; c=relaxed/simple;
	bh=5oXIcTrQZAtzw18y0rs7gshmvS5QZaMQmutrLZexqao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKlIPPQIPr9meNBQ/OebtWZxHREjF3QNSPYT2eprGoitHcMC7AGycTB8WVDwRWPaTLnPk1pifRnrP7bDdISSBa/fIwIhKVA18yoqpAoKQz+6P/uJVwVRtUK1jxx9qVMV7tbrFVsMCvQ4NKMJqluE4sw2sPAMLU4Nl6A3AFissvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Ch69hwiY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729541233; x=1730146033; i=deller@gmx.de;
	bh=4kHeIc2ueZGUQRwHGI0zQ0Nmip6ei5oU77tg0uxJUQE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ch69hwiYqSqDD892JRMeQUtLXnm0C1NnqTrFIxI0ht2TGQhtFB2Fw050LqeoRDGH
	 ITxSl54GlhGGc1LRDq1JUGkxYz02j3eXA0lW9zvHD82SMMsQI4r8bNM/Ko7UoX8UI
	 8LOqp+eZjXPIZMkjvCaewd+IvlgYHi39YS4zWhsVC/5XLSjNEN3ohvz6zA8f0Y6LO
	 /sSDNlAOMeJEciTMDenEvFbLapGKZ7rsV1AiBpzsgYsT8JV6q0ORtMg4EIcy4TQ/V
	 Aue4mWx3CPAAE6GtAcZnbNu8C48zm/ovbfTZDuJb/WwMIqhbGiaXl2xJVU6SvcRyy
	 VT8YRhnQXtmyMxacWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1szwPV3zHZ-007yQ9; Mon, 21
 Oct 2024 22:07:13 +0200
Message-ID: <7d0ce4fc-c9ab-4c67-8666-d5bd56dc970d@gmx.de>
Date: Mon, 21 Oct 2024 22:07:12 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] modules: few of alignment fixes
To: Luis Chamberlain <mcgrof@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240129192644.3359978-1-mcgrof@kernel.org>
 <ZbrFoKUJQ8MIdzXD@bombadil.infradead.org>
 <ZbvdbdxOKZ9FUQuC@bombadil.infradead.org>
 <CAK7LNATjKzUVR7DbJqb=yAinJ1YZo8tzwiXA79E9-VrDn11wwg@mail.gmail.com>
 <Zb0zGZrotuWyhsFd@bombadil.infradead.org>
 <Zxap5hbcXw36rRWW@bombadil.infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <Zxap5hbcXw36rRWW@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AgWuJGo59In4rhgi5GDmG8GtghZPcqJnEGmuUC8oK8oq6meStTn
 sh+zkLs3N3oA+oeazpgg5EorrSSAJBUJjvnN6fSbc5TdCoM7lW+xXRL4cSEznTGVSWLYRCu
 iiuBpRLNm7rPKHvxydbV6WTS/TqAFlohTMXNtLIt+MOS+NgaqOmYAWrdrM655B2Kdavckh3
 lw++coUf91yr2LVhMizQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nxB7dh0a4/Y=;vjf3Pao4C9jU+uRf+0sFdSXyQTV
 xTeA3ToC9HIEpZAUtCe0XmiwU6mDRDw3CPQVEHGn22LM8z176ONShRu/SuMdgp588rg5SmxWo
 cVzd4GS79Me7MbSop8v7DbmMpHIqe7JfLJtA7Z37EMflJ9E4D1pNXNjz2xKC/RuiA8D0HAmZs
 +KT+UIfs0YDvkgh6nYq696/ErVGFyBxKG2kVEmTRR04gARZwPWQ+uIYBC0hrKwBlP/mA6MawC
 6tBt506KL6R0zX9UBwlkZ9pAgS1zgh2DPgmXJ5jTqZdTM0Dds7q+qxtlguA40uwCpKr+KrIco
 K63+D1BxGMBXar5IefBFXYUi+45Gzu3hNzB9NERMqXigLVb1qOrXi9rLvvOuqlhk9wBm3MEWP
 bWNarQLw4/RYPWQBEUYHMgj5Cp23OLyRKLHvGlfAVB20z3TJacyFoKH4Wo19nxQcS36vdM6yv
 ndPoj44Ox0rMeV2o5UpIrlM/S6rshoGoV8PgqsWEFkf2mjlBJnZL1gRFBXkt+NpYQYzgQoeVi
 SpJXjs57aH1wDhxTaYanxiPNZPCcO52pBEzxlQQE7ZtrSBuPeHGOsdRVnEPec/WRxdZ7rhnBc
 t6NblnmQwcEHxphku3yX9vNEfVZ1wzVnA7BY5B4bH4G/q0XLA6Z3PRV81JbSB8ShVsVFmuUsP
 Uj6s2+vp1rKPQ/FjRrj0fqgFJ/qt7nmTeC6aXT5EPWcrM6Xjug9vl7hfMLZWSnaKkQWFC6wGk
 7i7oWpNmXIuK2t9nLSmd7v6GVYRIu7zqMW6ToM1Bh4Z2dhZz3drjBMLfITgYnx/nUuAgFeTWN
 Qf9olvg8yTY2SpXUe0Cv2eAw==

On 10/21/24 21:22, Luis Chamberlain wrote:
> On Fri, Feb 02, 2024 at 10:23:21AM -0800, Luis Chamberlain wrote:
>> On Sat, Feb 03, 2024 at 12:20:38AM +0900, Masahiro Yamada wrote:
>>> On Fri, Feb 2, 2024 at 3:05=E2=80=AFAM Luis Chamberlain <mcgrof@kernel=
.org> wrote:
>>>>
>>>> On Wed, Jan 31, 2024 at 02:11:44PM -0800, Luis Chamberlain wrote:
>>>>> On Mon, Jan 29, 2024 at 11:26:39AM -0800, Luis Chamberlain wrote:
>>>>>> Masahiro, if there no issues feel free to take this or I can take t=
hem in
>>>>>> too via the modules-next tree. Lemme know!
>>>>>
>>>>> I've queued this onto modules-testing to get winder testing [0]
>>>>
>>>> I've moved it to modules-next as I've found no issues.
>>>>
>>>>    Luis
>>>
>>>
>>> I believe this patch series is wrong.
>>>
>>> I thought we agreed that the alignment must be added to
>>> individual asm code, not to the linker script.
>>>
>>> I am surprised that you came back to this.
>>
>> I misseed the dialog on the old cover letter, sorry. I've yanked these =
patches
>> out. I'd expect a respin from Helge.
>
> Just goind down memory lane -- Helge, the work here pending was to move
> this to the linker script. Were you going to follow up on this?

Masahiro mentions above, that the alignment should be added
to the individual asm code. This happened in the meantime for parisc, but
I'm not sure if all platforms get this right.
So in addition, I still believe that adding the alignment to the linker
script too is another right thing to do.

Helge

