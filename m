Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDC435F903
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 18:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351634AbhDNQcL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 12:32:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:34845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349084AbhDNQcK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 12:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618417896;
        bh=FZ9GrzKKcGZUQfcEpxp5BlYmttssC2dTkHA74RKI9aU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KkESVuej5eT2CJPcF5VQs0Oeu1LoTXOqiXguXm5VZoxTivkFFQuUBisUIRnLvJcpk
         qqN+nHf+AlYUbar99jp/FNpAlv4uLlo4leSeAlO69tiR3uTSMugeq/z80WhkwhL4Md
         o+22OYHsdvxq6NsZIarwaP0M9sIsMA08a2aylvkM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.158.221]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybKp-1lkvOX1jkD-00yvkz; Wed, 14
 Apr 2021 18:31:36 +0200
Subject: Re: [PATCH 15/20] kbuild: parisc: use common install script
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-16-gregkh@linuxfoundation.org>
 <CAK7LNATkQfwqr9-G5KwGmWDeG81Wn0eb3ZVxopJjxCq18S28=Q@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Message-ID: <5e16a94b-7383-3ec5-949f-f4c5d2c812f5@gmx.de>
Date:   Wed, 14 Apr 2021 18:30:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATkQfwqr9-G5KwGmWDeG81Wn0eb3ZVxopJjxCq18S28=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TDlocKOvRUziINmfgs2TvkiCW4nNU7lXGq0VVBP61oTJiZ0A07t
 /buLeUgCiwyBnknrQEm5Kd7KAeUkHPkdNTwZ0+W+iDyhuqE7EeRfO11ZX6GvCqHC0aLq2rA
 JE+DPR60MNvV6kDw82f/M2OtDqptP+wtaZAUS5mev3hxVqg8ImkolZWdDs6BHvcM9j9tNXn
 +buLPIV04t7HhKxX/vB4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KDpldex5/p0=:M1Mu70R/n4l0ji5vnqhKZc
 aE4E6oGYhzHyb9dW997jQgjZf5WYxb8ADiT3ComF+GSNVtt5omGFuJWNKYInTOhsRl5d253ws
 OOgVinVqLCsKwIQ4oAVchOz55MgeDqD/jVKBjONwsyWHNWrF924g3A7pHTuzOThOPV5mQQyz8
 /+6PY9/IdFnhFz4lZbP5uQZCbeBRfIIqVPwL+M9XGEn/YwUrB+ovbEPLMtLIP48CNS4OijmPE
 vwAlMBDvnjr+iKKnOhNg/NeqazGxifbnSAkqw2t2H/CUpP6jQX4chbxKIubX6mzZ0MG0LIIc1
 yUWZU2ow/Bw9VAhep6zngAj9KsdjHQkU3r/+b5vP8Re0gsWGwbUfRG+T6L4ZITs/fjfQF8BUI
 Px+KsBsg434zXuOvdBY426jkjhDPSPIIoWeL8cXUQag03yW6yrwkf9PlxAj69sYpFBbeGraoE
 sX4OmnoNQI8p25hIsYx0E7APYrW+SlSz43sg6W185rA7ZPgh7CiGpPh7F1Btva5xYOgG/Pf30
 xMMS9cD8CQJyvnizwszlF9xiz7apweEJTVROhUrw4xatKtmOqbaKPJlbrZmkfFge28uBPmIz/
 K8txzSuOU24Ro5LMrctPOfA46MkKUjLze76aMlG2evJ2VYzy06UerOBmuVvPb0v8ZYPUFAHrB
 pwMIMU5GIuuP/keyzKdHQU9sGo0T6bNFFR3it6xHXAfNEaGX01QsK40fSVeh1YRizkPIQbXKC
 0Es48oCCJPCLUsYZvugzJiL8zLcIX2QXYdbEweFPTOvwVpz4w37MEng5cD3nVb+y2gK2FHPY5
 afVuykgZNonRixH7CdeXpnTzb410b77HlsZ9u4KA4x+xR1amf5ZvO1uK669jFa7QW15A1ttU5
 cIW2c0lPK6y72+8wRTVZVBRHrkd25IviKMp/fdE2/O5fjNwDvnOaQENHNEXlx7FJrG63uWCDk
 E5s3GsNwjCH6kpw3cSjlydVn3CD+dw5WXdFkhkTB64SUIkQTk/GODXR4M8+rfLUaokDikEI9C
 1craIDnyBQvzW9PxcuOCakPmFEQi9I+MVY73oLRAHqD4fqXihxxxIi1xZP45hoONmWTnA4UIU
 VUSPricM6+Dpt9E2o2STiSpspBeRloRymryOpu4pqPOWqUvqDQOVJnz2k6+uMLGZpMzgKNVT/
 RLQZIEur75igqG0CZOdH5H1KbPUjN77p6E+3TgCSdglz/Lsq7om8dOgfuS/tKhwTcL8Mk=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/7/21 1:23 PM, Masahiro Yamada wrote:
> On Wed, Apr 7, 2021 at 2:34 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> The common scripts/install.sh script will now work for parisc, all that
>> is needed is to add the compressed image type to it.  So add that file
>> type check, and then we can remove the two different copies of the
>> parisc install.sh script that were only different by one line and have
>> the arch call the common install script.
>>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: linux-parisc@vger.kernel.org
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   arch/parisc/Makefile        |  4 +--
>>   arch/parisc/boot/Makefile   |  2 +-
>>   arch/parisc/boot/install.sh | 65 ------------------------------------
>>   arch/parisc/install.sh      | 66 ------------------------------------=
-
>>   scripts/install.sh          |  1 +
>>   5 files changed, 4 insertions(+), 134 deletions(-)
>>   delete mode 100644 arch/parisc/boot/install.sh
>>   delete mode 100644 arch/parisc/install.sh
>>
>> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
>> index 7d9f71aa829a..296d8ab8e2aa 100644
>> --- a/arch/parisc/Makefile
>> +++ b/arch/parisc/Makefile
>> @@ -164,10 +164,10 @@ vmlinuz: vmlinux
>>   endif
>>
>>   install:
>> -       $(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
>> +       $(CONFIG_SHELL) $(srctree)/scripts/install.sh \
>>                          $(KERNELRELEASE) vmlinux System.map "$(INSTALL=
_PATH)"
>>   zinstall:
>> -       $(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
>> +       $(CONFIG_SHELL) $(srctree)/scripts/install.sh \
>>                          $(KERNELRELEASE) vmlinuz System.map "$(INSTALL=
_PATH)"
>>
>>   CLEAN_FILES    +=3D lifimage
>> diff --git a/arch/parisc/boot/Makefile b/arch/parisc/boot/Makefile
>> index 61f44142cfe1..ad2611929aee 100644
>> --- a/arch/parisc/boot/Makefile
>> +++ b/arch/parisc/boot/Makefile
>> @@ -17,5 +17,5 @@ $(obj)/compressed/vmlinux: FORCE
>>          $(Q)$(MAKE) $(build)=3D$(obj)/compressed $@
>>
>>   install: $(CONFIGURE) $(obj)/bzImage
>> -       sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzI=
mage \
>> +       sh -x  $(srctree)/scripts/install.sh $(KERNELRELEASE) $(obj)/bz=
Image \
>>                System.map "$(INSTALL_PATH)"
>
>
>
> As far as I understood, there is no way to invoke this 'install' target
> in arch/parisc/boot/Makefile since everything is done
> by arch/parisc/Makefile.
>
> Can we remove this 'install' rule entirely?

Yes, I think it can go in arch/parisc/boot/Makefile.

Helge
