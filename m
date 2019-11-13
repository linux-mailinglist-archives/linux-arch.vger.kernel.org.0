Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5544FA9DE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 06:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfKMFwE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Nov 2019 00:52:04 -0500
Received: from m12-14.163.com ([220.181.12.14]:45254 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfKMFwE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Nov 2019 00:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=nSNBn
        HfDuOGVTZsa1//WZd8rW2c2XliYAXWmMqzCFUw=; b=l5OJXQLa6t0qqIHUdG+rq
        PNQKZnueyEMrlFabV/apN1D5AAAgN/05B6/q6Eyr5vPOJC29W0c6r6pzXamUl8pY
        qiy4f8RAF1zacadyMlmIJX6ioyoWcUzPNgXho45pdhQmVcg5xxDONC4TGh37fZlr
        /gvIw0slfUKduQxEC4/gKI=
Received: from [192.168.1.133] (unknown [112.25.212.39])
        by smtp10 (Coremail) with SMTP id DsCowACnr5_mmctdFEfFCg--.555S2;
        Wed, 13 Nov 2019 13:51:35 +0800 (CST)
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
 <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net>
 <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com>
Date:   Wed, 13 Nov 2019 13:51:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: DsCowACnr5_mmctdFEfFCg--.555S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw47AF45Jr43Kry3XF47Jwb_yoWrXr43pa
        sxCF4xtF4UXFy5JrnFyw17Za4Utw4UKr1YgryUGry8ArnYvr13tr4xur1ruF9xXrWUJw1j
        yrZrW3y7Ww1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bOSdkUUUUU=
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0ghsXlUMSxvoNQAAs8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/13/19 1:28 PM, Masahiro Yamada wrote:
> On Wed, Nov 13, 2019 at 12:13 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 11/12/19 1:50 PM, Masahiro Yamada wrote:
>>> On Tue, Nov 12, 2019 at 9:31 PM Will Deacon <will@kernel.org> wrote:
>>>> [+lkml, Masahiro, Alexei and Daniel]
>>>>
>>>> On Tue, Nov 12, 2019 at 04:56:39PM +0800, Xiao Yang wrote:
>>>>> With your patch[1], I alway get the following error when building
>>>>> tools/bpf:
>>>> In case people want to reproduce this, my branch is here:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=lto
>>>>
>>>>> ----------------------------------------------------------------------------------
>>>>>
>>>>> make -C tools/bpf/
>>>>> make: Entering directory
>>>>> '/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf'
>>>>>
>>>>> Auto-detecting system features:
>>>>> ... libbfd: [ on ]
>>>>> ... disassembler-four-args: [ OFF ]
>>>>>
>>>>> CC bpf_jit_disasm.o
>>>>> CC bpf_dbg.o
>>>>> In file included from
>>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0,
>>>>> from
>>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41:
>>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24:
>>>>> fatal error: asm/rwonce.h: No such file or directory
>>>>> #include <asm/rwonce.h>
>>>>> ^
>>>>> compilation terminated.
>>>>> Makefile:61: recipe for target 'bpf_dbg.o' failed
>>>>> make: *** [bpf_dbg.o] Error 1
>>>>> make: *** Waiting for unfinished jobs....
>>>>> make: Leaving directory
>>>>>
>>>>> ----------------------------------------------------------------------------------
>>>>>
>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3
>>>>>
>>>>> It seems that include/linux/compiler.h cannot find the asm/rwonce.h because
>>>>> tools/bpf/Makefile doesn't include arch/*/include/generated/asm/rwonce.h.
>>>> The problem with referring to the generated files is that they don't exist
>>>> unless you've configured the main source directory. The real problem here
>>>> seems to be that tools/bpf/ refers directly to header files in the kernel
>>>> sources without any understanding of kbuild, and therefore mandatory-y
>>>> headers simply don't exist when it goes looking for them.
>> Hmm, I am puzzled why that is. :/ I think there are two options, i) remove it
>> from CFLAGS like below (at least this doesn't let the build fail in my case
>> but requires linux headers to be installed) or ii) add a copy of filter.h to
>> tools/include/uapi/linux/filter.h so the few tools can just reuse it. We do have
>> bpf_common.h and bpf.h there already.
>>
>> diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
>> index 5d1995fd369c..08dfd289174c 100644
>> --- a/tools/bpf/Makefile
>> +++ b/tools/bpf/Makefile
>> @@ -10,7 +10,6 @@ MAKE = make
>>    INSTALL ?= install
>>
>>    CFLAGS += -Wall -O2
>> -CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi -I$(srctree)/include
>>
>>    # This will work when bpf is built in tools env. where srctree
>>    # isn't set and when invoked from selftests build, where srctree
>>
>
> I think this is the most sane fix
> to include the linux/filter.h in the system.
>
> (probably, it is located in /usr/include/linux/filter.h)

Hi Masahiro,

Is it correct for include/linux/compiler.h to include <asm/rwonce.h>?

On x86_64 arch, asm/rwonce.h is generated in 
./arch/x86/include/generated/ directory and compiler.h cannot find it.

Best Regards,

XIao Yang

>
>

