Return-Path: <linux-arch+bounces-1208-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20368203EA
	for <lists+linux-arch@lfdr.de>; Sat, 30 Dec 2023 08:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D961F21715
	for <lists+linux-arch@lfdr.de>; Sat, 30 Dec 2023 07:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8F9257F;
	Sat, 30 Dec 2023 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="fmwJGS+R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAB2569;
	Sat, 30 Dec 2023 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703921605; x=1704526405; i=deller@gmx.de;
	bh=xni73b/fmqnkrhJ8X+AT459zG1XZ686uE4vG9mDt6nY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=fmwJGS+RRwKmhAsgTUgewCzQqTSUcvlAkswOrPJAaXkB4ez6OT1DRUSYMLdkpT+i
	 pP1TkWqFVmuJJXwcl9UBryQT6Xr1Rof5QQ3QaZbpLNHWmIBClPLUw4ddQNytBLxNY
	 HdmwIM4c55SGoKVbYMtX8OjjBQiXPxzUzEn9zwBBZeMyipT3kToHqcWRRx9CwyGNu
	 ecjxx9vzEfn36/XrS7uJJDba/IeRogYdM15w6jqcF25Ybgl9aHECha+Av+epY7Jbn
	 fH9ageo5VL+KKdp7NHsM4ms47g+ZzoqIVhIESt/Dd5PNNsKc1FPP3u5c1Cy3fb+4q
	 /rKfTVOMCbot4ApLaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.152.157]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1rTzJf1Rms-00G0an; Sat, 30
 Dec 2023 08:33:25 +0100
Message-ID: <59bc81b5-820e-40ff-9159-c03e429af9a6@gmx.de>
Date: Sat, 30 Dec 2023 08:33:24 +0100
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
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZYXtPL7Ds1SUKPLT@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OzfSEZKH8jNRkcgP9iKAK8JSqt1F71b7zuc+MiQIbdUN13KrtcK
 68c11U3ceiTbQxhp+KXCVOR4Bg9aF9Y1he6dmyXnUxMWGLmXy+9iYqxEah7xT+zERYZUZfo
 a9vtJMvVgjBqQOwxm6mij9M6Od4LMHVBur5P11ctfC32m/U++0XCVAnTJunB45Wfz2wTcRS
 z4v4MPdn4/JRexgdRrngw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vRdRdOk43i4=;27Id2SuD9tQu7nOfNoSnvp7z3U4
 QuK5l8BcyVgsXgr2be7m7hwXoxck25UkBD0F/OyaL5joTgZEltkxxXUkS7umBkUGuQ/3Gnou8
 NjFrUTHMVOs3WbCC1aX9Zhp/qiwkRvz/0aKmgt3Xt8u427+3ZVg8Ytg3aF5EgveT50sm7AciF
 hX+FUF2mFtCD43Sj1xFR3yyC1aE0UPHimaIp4ksNgQzMs59nlAUCHQdulbAgspoohf4z9esvR
 UD222OTS8B+ZLG04ubuJERqZipK2sGjg4GQOgCOgVdy8lUxMyMWNLcW8z35YhOJWWRtHmcTCJ
 TQfgXVx8hKDwcUDHAf9j5anPKFK4Ig/ermHjfqbs1LcYCeFul16ByYsYaurwch1f9DnX/JKmM
 NqXU3Xa9w6O9/TDsMMHNxO7Lzh/UAfhf3D+TVObkPiHd/9dKSXPu6aI13jwCWlpkE24N56EOM
 QTx/knITFldhNPEbj4sXtDa2crbF/604mp/Hu8nEv9xy31snqYZhW9ED6swtnxTDVv/ooElsA
 0aqAJrQLTA4Yw48mQuTmeffxjIjx809+xXSswE2ZTfbLFpJ8sfqhbAxkZ1xQd0w30kO8bA7t8
 wd10ZunR3SpiZlfF2MlLrp4xJ+pR4k7pesBJDSCY2W4sNj8jFLReFazwIbRnkhG8x8fW+s4IS
 p1mB5tJe1HyzG9cAeZd2NAqma0waCIRIqlfing4X/GkoRa/aDqSsWudUmU0xvheyOF5EUiAMw
 dXbuDMEBdsoq0dp48A2q+DB06bXHdDG+eu9PpOTAUI768y6xhaslFY2L+91HM401JQxRTEK8y
 PsfGpnmqV9xdd77fLOQkuU/CMcQVs2VuqLmgdPao+YKqFw+SVnG9bpJhajmMBd4KISzQGt5rD
 XgXbZkXHioyWCCVJXisYiXjYnTWciX81OlRnj+/w5fynJFTorKiXVQslBcptXT1UMf/PIfrUd
 96whvYGuBTonijbg8gVJqMxuxpQ=

Hi Luis,

On 12/22/23 21:10, Luis Chamberlain wrote:
> On Fri, Dec 22, 2023 at 01:13:26PM +0100, Helge Deller wrote:
>> On 12/22/23 06:59, Luis Chamberlain wrote:
>>> On Wed, Nov 22, 2023 at 11:18:12PM +0100, deller@kernel.org wrote:
>>>> On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>>> (e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro store=
s
>>>> 64-bit pointers into the __ksymtab* sections.
>>>> Make sure that those sections will be correctly aligned at module lin=
k time,
>>>> otherwise unaligned memory accesses may happen at runtime.
>>> ...
...
>> So, honestly I don't see a real reason why it shouldn't be applied...
>
> Like I said, you Cc'd stable as a fix,

I added "Cc: stable@vger.kernel.org" on the patch itself, so *if* the patc=
h
would have been applied by you, it would later end up in stable kernel ser=
ies too.
But I did not CC'ed the stable mailing list directly, so my patch was neve=
r
sent to that mailing list.

> as a maintainer it is my job to
> verify how critical this is and ask for more details about how you found
> it and evaluate the real impact. Even if it was not a stable fix I tend
> to ask this for patches, even if they are trivial.
> ...
> OK, can you extend the patch below with something like:
>
> perf stat --repeat 100 --pre 'modprobe -r b a b c' -- ./tools/testing/se=
lftests/module/find_symbol.sh
>
> And test before and after?
>
> I ran a simple test as-is and the data I get is within noise, and so
> I think we need the --repeat 100 thing.

Your selftest code is based on perf.
AFAICS we don't have perf on parisc/hppa, so I can't test your selftest co=
de
on that architecture.
I assume you tested on x86, where the CPU will transparently take care of
unaligned accesses. This is probably why the results are within
the noise.
But on some platforms the CPU raises an exception on unaligned accesses
and jumps into special exception handler assembler code inside the kernel.
This is much more expensive than on x86, which is why we track on parisc
in /proc/cpuinfo counters on how often this exception handler is called:
IRQ:       CPU0       CPU1
   3:       1332          0         SuperIO  ttyS0
   7:    1270013          0         SuperIO  pata_ns87415
  64:  320023012  320021431             CPU  timer
  65:   17080507   20624423             CPU  IPI
UAH:   10948640      58104   Unaligned access handler traps

This "UAH" field could theoretically be used to extend your selftest.
But is it really worth it? The outcome is very much architecture and CPU
specific, maybe it's just within the noise as you measured.

IMHO we should always try to natively align structures, and if we see
we got it wrong in kernel code, we should fix it.
My patches just fix those memory sections where we use inline
assembly (instead of C) and thus missed to provide the correct alignments.

Helge

> ------------------------------------------------------------------------=
-----------
> before:
> sudo ./tools/testing/selftests/module/find_symbol.sh
>
>   Performance counter stats for '/sbin/modprobe test_kallsyms_b':
>
>          81,956,206 ns   duration_time
>          81,883,000 ns   system_time
>                 210      page-faults
>
>         0.081956206 seconds time elapsed
>
>         0.000000000 seconds user
>         0.081883000 seconds sys
>
>
>
>   Performance counter stats for '/sbin/modprobe test_kallsyms_b':
>
>          85,960,863 ns   duration_time
>          84,679,000 ns   system_time
>                 212      page-faults
>
>         0.085960863 seconds time elapsed
>
>         0.000000000 seconds user
>         0.084679000 seconds sys
>
>
>
>   Performance counter stats for '/sbin/modprobe test_kallsyms_b':
>
>          86,484,868 ns   duration_time
>          86,541,000 ns   system_time
>                 213      page-faults
>
>         0.086484868 seconds time elapsed
>
>         0.000000000 seconds user
>         0.086541000 seconds sys
>
> ------------------------------------------------------------------------=
-----------
> After your modules alignement fix:
> sudo ./tools/testing/selftests/module/find_symbol.sh
>   Performance counter stats for '/sbin/modprobe test_kallsyms_b':
>
>          83,579,980 ns   duration_time
>          83,530,000 ns   system_time
>                 212      page-faults
>
>         0.083579980 seconds time elapsed
>
>         0.000000000 seconds user
>         0.083530000 seconds sys
>
>
>
>   Performance counter stats for '/sbin/modprobe test_kallsyms_b':
>
>          70,721,786 ns   duration_time
>          69,289,000 ns   system_time
>                 211      page-faults
>
>         0.070721786 seconds time elapsed
>
>         0.000000000 seconds user
>         0.069289000 seconds sys
>
>
>
>   Performance counter stats for '/sbin/modprobe test_kallsyms_b':
>
>          76,513,219 ns   duration_time
>          76,381,000 ns   system_time
>                 214      page-faults
>
>         0.076513219 seconds time elapsed
>
>         0.000000000 seconds user
>         0.076381000 seconds sys
>
> After your modules alignement fix:
> sudo ./tools/testing/selftests/module/find_symbol.sh
>   Performance counter stats for '/sbin/modprobe test_kallsyms_b':
>
>          83,579,980 ns   duration_time
>          83,530,000 ns   system_time
>                 212      page-faults
>
>         0.083579980 seconds time elapsed
>
>         0.000000000 seconds user
>         0.083530000 seconds sys
>
>
>
>   Performance counter stats for '/sbin/modprobe test_kallsyms_b':
>
>          70,721,786 ns   duration_time
>          69,289,000 ns   system_time
>                 211      page-faults
>
>         0.070721786 seconds time elapsed
>
>         0.000000000 seconds user
>         0.069289000 seconds sys
>
>
>
>   Performance counter stats for '/sbin/modprobe test_kallsyms_b':
>
>          76,513,219 ns   duration_time
>          76,381,000 ns   system_time
>                 214      page-faults
>
>         0.076513219 seconds time elapsed
>
>         0.000000000 seconds user
>         0.076381000 seconds sys
> ------------------------------------------------------------------------=
-----------
>
> [perf-based selftest patch from Luis stripped]


