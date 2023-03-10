Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248DA6B529A
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 22:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjCJVOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 16:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJVOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 16:14:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA29310A29C;
        Fri, 10 Mar 2023 13:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678482846; i=deller@gmx.de;
        bh=We4tVJ9aX8WWemGD0IA7ECCoCjcoMbMpuqwmPkvAqqQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Fs4lLH/bAjI990hi6oAWHu3X3VrWy3tjXXuztt8y3REr7ICCFlamg5QYRmGvdM5Fu
         GHSdyxSyJiY888XV0gZzrBL+Ko5rb5YOLxATE1ZhCv2jOVEuRFWO909M3OGH7pZr75
         k0x1rtJuDFogkmQlkVKFnxI/8XDlOeh3utjdYYwg90cukCxJmgql8lC5VeeReKk9QX
         fpFXPD5UFxkVgQKl7Ww4eBAG0ICrOSt7bZ1rAVEPfR7OotYtt2ULvJZvjm9MJVFWyF
         A/U4OnCaEf9lpDimlHnv1cYE6G8TPQ4rU04hN4/EYRVECsXbxTRryC4MsIRusiEKd9
         mcYHsMUH8P6MA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1psPTK0gdc-00HffQ; Fri, 10
 Mar 2023 22:14:06 +0100
Message-ID: <5f807b94-9169-3120-9329-611e4031c665@gmx.de>
Date:   Fri, 10 Mar 2023 22:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/4] arch/*/io.h: remove ioremap_uc in some
 architectures
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, mpe@ellerman.id.au,
        geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-4-bhe@redhat.com>
 <20230309143621.GA12350@alpha.franken.de> <ZAqLuNrPng9i0rZV@MiWiFi-R3L-srv>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <ZAqLuNrPng9i0rZV@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:prdbfw0jkbpA2cD4PS8A/Q/bnmnu3OYgfeuy9CIfivml0OBah6B
 MGo7+iBseCwD1PVcU+5RG0jP1OD3CZxHtN3uIEBZi1dA22tJEq0pWnkq3La76NAmGwRayBS
 XciNoSO+Vo1DYUji/arGP4M8bHAlcRtDybpPn25b5aXw0gCZzJphAKo80pokJRNsnu3Acov
 Kgc55jhLjK07WSzPwizYQ==
UI-OutboundReport: notjunk:1;M01:P0:GnB6wuRuGe8=;Hhtz914/IJ7nAaMT9Ty0LJE9nJ3
 qsX6/pRaqe8JSsd8AX0qlvxgerripOr2OMvkR5AqBzN13ZBB0WbSVdMd0wRslRJhLPVk2NfHP
 ne08fK/1oClR0HB6P3x+0S5JVDyXfnFK9t/HMO1MyRvEKT0bxSZsgNzBtlnOZ6AhckHlp24i5
 nwt5q+71jXG5JVP+J4zZHqgbVlUnbwuBSbnufn+NzNqGYqezWq5DgmihIjtMmcgkRsxmSIHNi
 VdBCFyNM9HPfHABBkNRRj3iIKHCI+mpcivp4IEbCO0UWpKkKYJluXWbUa5IDZIwxvqWxpoAy7
 TiipvhxhzW2BorDhthOlGuhZ7nYBllk/JoCQMQiBTTlJQQGbl+CXSnF+66y0XzoV0MhVD+7Uy
 aHbxO1dajxVOJ0AfMDW5wtdd+wH/s7dS/eyeidfTAileP/wP/Wxm9bt39Wq4amDiQlhl+doB5
 d7M3sNlxWIpyJJ412QUc0qvYN4M/iGsKJ6QmVZBaR7xZPtJ/mKYGf8Kn4W5WePzDY/TS74eeN
 myHgsVkxZieoPf6jz69JNCOs/ClaoN/bMxmVrtj6OeY6xBykhd3tpSArDi37WEgAkyu9YkGYS
 n+FlUHPOhs3W/Pr9cpydihcay7P9drt6ICYqYelTz1QbexPv/n7HeXvNTvSPYKMDBymqdIQaL
 cqnrhpZg7Yd45xlppdOdVQ83zuB1eF4kyC3UfmX6P/Csto0lwOzKDKFZoMbUz05B+UcVluR1i
 igya/wFC/IPhXB680mewg5DfSn7jCQ5CuSV3BxWu8pp9a5eV8F0C1cVKVecIAtzZSvLYpiBMc
 /Cf5EvHPb5GrTt2niJegozx3hwjdStg7lataEEStinQVZyD4n2SpvjRo1PRXtJ6C4G4gvomaa
 2q1sYMfCsVv/UDyrsnqaEUKx7lI1dYWviSy0nvRw4B8HSZ//zhewIMUCNZgawtD/QEYY5Or4X
 qEXb3zwt3cWnfN7WclsZWX/U35U=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/10/23 02:45, Baoquan He wrote:
> On 03/09/23 at 03:36pm, Thomas Bogendoerfer wrote:
>> On Wed, Mar 08, 2023 at 09:07:09PM +0800, Baoquan He wrote:
>>> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
>>> extension, and on ia64 with its slightly unconventional ioremap()
>>> behavior. So remove the ioremap_uc() definition in architecutures
>>> other than x86 and ia64. These architectures all have asm-generic/io.h
>>> included and will have the default ioremap_uc() definition which
>>> returns NULL.
>>>
>>> This changes the existing behaviour, while no need to worry about
>>> any breakage because in the only callsite of ioremap_uc(), code
>>> has been adjusted to eliminate the impact. Please see
>>> atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.
>>>
>>> If any new invocation of ioremap_uc() need be added, please consider
>>> using ioremap() intead or adding a ARCH specific version if necessary.
>>>
>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> Cc: linux-alpha@vger.kernel.org
>>> Cc: linux-hexagon@vger.kernel.org
>>> Cc: linux-m68k@lists.linux-m68k.org
>>> Cc: linux-mips@vger.kernel.org
>>> Cc: linux-parisc@vger.kernel.org
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: linux-sh@vger.kernel.org
>>> Cc: sparclinux@vger.kernel.org
>>> ---
>>>   Documentation/driver-api/device-io.rst | 9 +++++----
>>>   arch/alpha/include/asm/io.h            | 1 -
>>>   arch/hexagon/include/asm/io.h          | 3 ---
>>>   arch/m68k/include/asm/kmap.h           | 1 -
>>>   arch/mips/include/asm/io.h             | 1 -
>>>   arch/parisc/include/asm/io.h           | 2 --
>>>   arch/powerpc/include/asm/io.h          | 1 -
>>>   arch/sh/include/asm/io.h               | 2 --
>>>   arch/sparc/include/asm/io_64.h         | 1 -
>>>   9 files changed, 5 insertions(+), 16 deletions(-)
>>
>> this doesn't apply to v6.3-rc1... what tree is this based on ?
>
> Sorry, I forgot mentioning this in cover letter. This series is
> followup of below patchset, so it's on top of below patchset and based
> on v6.3-rc1.
>
> https://lore.kernel.org/all/20230301034247.136007-1-bhe@redhat.com/T/#u
> [PATCH v5 00/17] mm: ioremap:  Convert architectures to take GENERIC_IOR=
EMAP way

I've applied both patch series on top of v6.3-rc1 and
tested it with success on the parisc platform (32- and 64-bit kernel).

You may add to both patch series:

Acked-by: Helge Deller <deller@gmx.de>  # parisc

Thank you!
Helge
