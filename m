Return-Path: <linux-arch+bounces-1164-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2012C81C717
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 10:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8960AB235EB
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383A1D301;
	Fri, 22 Dec 2023 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="FhfaRI6Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA7D2E0;
	Fri, 22 Dec 2023 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703235741; x=1703840541; i=deller@gmx.de;
	bh=V6sDV6pyBLKf2NuZ6ATFB3thXBq+AktPzbQKhUhh9OY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FhfaRI6Y595PzRvvMav97qjsLp8WuDJATf2au16b9pQrJzD+NHMMiOE1j+6jUhsJ
	 3DKvg8VIvRnBjHVxsuI4bw6o0vgo7dPqk1jFlBscYg0UyDg7GhlBfSZC16u2I1oS5
	 e++uA5oWxu+nwI4kLe30lCCwffuHCLdt15BmjdVAv9600is7aJGNLSJHSiSH+Vr3W
	 BownU8J2tUaWF/DW3BtGxwUVg4/9539ApJT3rsbu7V8qDxJP6GCT9PkJgp+woVbDm
	 OkDNR/dFGqhFwBypGdPDVl+jB0Y2kBousJELx+4b8o5C/Fxbvw9+ukj2WF7+F3sbh
	 m13Fu6t6mZKRqh6+7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.108]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSt8W-1ridEZ1AYI-00UI2a; Fri, 22
 Dec 2023 10:02:21 +0100
Message-ID: <7a504ceb-da00-4c0b-acc0-3ab48fb60f5e@gmx.de>
Date: Fri, 22 Dec 2023 10:02:20 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vmlinux.lds.h: Fix alignment for __ksymtab*,
 __kcrctab_* and .pci_fixup sections
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>, deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-modules@vger.kernel.org, linux-arch@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-4-deller@kernel.org>
 <CAK7LNARgQ0t=4dfkJXDhSzdFGbxDuN2kPGxTgDR7siCYTtGU5w@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAK7LNARgQ0t=4dfkJXDhSzdFGbxDuN2kPGxTgDR7siCYTtGU5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C3E3fy9OPbBQ3+Xd0xFPyWcs6FoPCmKpr4ERn01kYTSd1IeBBm3
 ZgFn72lcVW/H+2DgR2xPNgr/CYqiNpitwZXF9Bs78h1+WebOTku2Xw+2uQ9NpLOQ+nX7jED
 0cem5oeRXJa0WTL3GZoGiBXWUnJIJFzOw/jcgLFOTU26y9OS5epQEUNucR9jTmC+EZDB1DK
 L/3tyFSmz8iH9U3m4LOhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YCbcKvLbE8k=;xRb6+he4cYIuCvBQ6U6kllbFRqM
 C8A4cqocP3A9ntmnd8vjgkiwEJYj+pBelLBUHpm2BaOqe6+sPEUaM2ywliEr7XEjNpiKbrXhA
 3Rcf7pSdPlPpE4zU6FBRz4RTtYCbhhAk7qwEF2oY7gMAwZ9S/vKfy5J3dHBVWxzKOnOSnS3IB
 8N80Xtg/39xaetE1uHMTsNnOxAfK119p7B066Mq4Hf4SM8vnruWWLyW72KYNWhD9IPSfw9pxj
 zYsJ2mJRtdvRmBbJL9SwYqqb6sdbx052jpXYo4sFafeKf6AhEE4G+6DLiGpAoc4/IWFqw+IH2
 02IvN7PXY6fvE+RQ4kwYhMhBzJgIls1b+VtF16BII8ZzB28YeV0OPos4gIws4RfEx5E9EGH11
 PMtZbzcxW5QJLO+VyxsJ6PEwAqjRKKLGT11R4CQwwpUL3MDs8r6sROSvOGT1g6TtTv5qKjBTH
 Yin0PIgQkhyLXizQ77WA1X/mFMa4wEXH/y5YlocMFGD/SKz65XqE+3LmazvwO3ifZJrZpERwe
 fN6fcDHWmhALebCKPd7ziMapioiQifoKxPTjmHeG+p23wzaLCVdvWQrYt6LdkL5y9rPHKxsHh
 i/tonVL9Ye+24Xyi6t8KIqV6CN6FCb7UxKtTFdx6e/MjXNRJbTpE9F1CuBHC0TPGHXwXwvSlN
 dIqs/SwKYRFbUtJcsjY18cDgoubARv1PqDqq5UFiJkF4fapXiuVe99jhXa95bPTX1DgTTDLwl
 zljP4Bn3d+YmT+cOI3X8OGYyxFkZaySanna+PHb//2TEiTXzQr0DiGe/13GoMVSd8u0mo6tQ2
 PREuD84czUnSW6e7Sh2BfeBFSGKVJMJPhyY1f45Fj4ayzxWGbDDTzyrcA8PNcX3Gvp9Pyb/Jp
 gubqXAkvk/zhrbWJbiY0WbcCwzlE6l4vtyJcWvOYaEm2sgbw9NC+H8YXXF4UBNxxfoknapcOE
 pPaPeK3P9g1ltpmd8adAEtHeG78=

On 12/21/23 14:07, Masahiro Yamada wrote:
> On Thu, Nov 23, 2023 at 7:18=E2=80=AFAM <deller@kernel.org> wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>> (e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
>> 64-bit pointers into the __ksymtab* sections.
>> Make sure that the start of those sections is 64-bit aligned in the vml=
inux
>> executable, otherwise unaligned memory accesses may happen at runtime.
>
>
> Are you solving a real problem?

Not any longer.
I faced a problem on parisc when neither #1 and #3 were applied
because of a buggy unalignment exception handler. But this is
not something which I would count a "real generic problem".

> 1/4 already ensures the proper alignment of __ksymtab*, doesn't it?

Yes, it does.

>...
> So, my understanding is this patch is unneeded.

Yes, it's not required and I'm fine if we drop it.

But regarding __kcrctab:

>> @@ -498,6 +501,7 @@
>>          }                                                             =
  \
>>                                                                        =
  \
>>          /* Kernel symbol table: Normal symbols */                     =
  \
>> +       . =3D ALIGN(4);                                                =
   \
>>          __kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {       =
  \
>>                  __start___kcrctab =3D .;                              =
    \
>>                  KEEP(*(SORT(___kcrctab+*)))                           =
  \

I think this patch would be beneficial to get proper alignment:

diff --git a/include/linux/export-internal.h b/include/linux/export-intern=
al.h
index cd253eb51d6c..d445705ac13c 100644
=2D-- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -64,6 +64,7 @@

  #define SYMBOL_CRC(sym, crc, sec)   \
         asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""     "\n" \
+           ".balign 4"                                         "\n" \
             "__crc_" #sym ":"                                   "\n" \
             ".long " #crc                                       "\n" \
             ".previous"                                         "\n")


Helge

