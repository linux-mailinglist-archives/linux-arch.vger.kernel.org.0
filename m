Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E153FAC23
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 09:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfKMIgY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Nov 2019 03:36:24 -0500
Received: from m12-14.163.com ([220.181.12.14]:50514 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfKMIgY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Nov 2019 03:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=dA+ZN
        83cVR4cL1YH5CVSfq7SE556RGr+LTFA07tkT5E=; b=cFFZOvWI+2mgSBD6/Rr1E
        CbzfpiM1dd4QzN0vlqzn4dXbsAbCmPLaMAWIoL1+vVx2vqxHcRP7T8rI7x6VMe/0
        QzAXfscip9jNP2VuQqiliQYVGUIP5l1BQkh3B1LD37MgU5PXMpjdVWOiQUL8uUnl
        wH++EsFKgxtzh0g2RYAytw=
Received: from [192.168.1.133] (unknown [112.25.212.39])
        by smtp10 (Coremail) with SMTP id DsCowADHz2ddwMtd9XrUCg--.280S2;
        Wed, 13 Nov 2019 16:35:43 +0800 (CST)
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
 <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net>
 <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
 <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com>
 <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
 <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com>
 <CAK7LNATfK2pFnO2YV5zMLMxJGYyaj+f8w-k4K8xaoGbJ2Bd5eQ@mail.gmail.com>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <50602386-68b1-be38-a022-0bcf9df6a54e@163.com>
Date:   Wed, 13 Nov 2019 16:35:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATfK2pFnO2YV5zMLMxJGYyaj+f8w-k4K8xaoGbJ2Bd5eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: DsCowADHz2ddwMtd9XrUCg--.280S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw47Wr13AFWxCw4kCF13twb_yoWDKrgEvw
        10krykCr1fKr13JanxKFsxXFsrKw4kAryDX34rurn0gwsxAFZIg3ZYqFn5ZFs5t398ZFn3
        WF1FvFsa9F98ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU55u4UUUUUU==
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0h9sXlUMSx9uAQAAsd
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/13/19 3:53 PM, Masahiro Yamada wrote:
> On Wed, Nov 13, 2019 at 4:17 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>> On 11/13/19 2:57 PM, Masahiro Yamada wrote:
>>> Sorry, I really do not understand what you are doing.
>>>
>>> include/linux/compiler.h is only for kernel-space.
>>> Shrug if a user-land program includes it.
>> Hi Masahiro,
>>
>> For building tools/bpf, it is good to fix the compiler error by Daniel's
>> patch(i.e. use linux/filter from linux header).
>>
>> linux/compiler.h may be used by other code in kernel.  Is it possible to
>> trigger the same error when the other code
>>
>> including linux/compiler.h is built? Is this kind of code able to find
>> the location of <asm/rwonce.h>?
>
> <asm/rwonce.h> is also kernel-only header.
>
> The kernel code can find <asm/rwonce.h>, but user-land code cannot.

Hi Masahiro,

Sorry, I am not familar with it.

Thanks a lot for your explanation and I have seen the LINUXINCLUDE 
variable in Makefile.

I will try to send a patch as Daniel suggested.

Best Regards,

Xiao Yang

>
>
>
>
>> Best Regards,
>>
>> Xiao Yang
>>
>>
>

