Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15E3FA78B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 04:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKMDqU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 22:46:20 -0500
Received: from m12-15.163.com ([220.181.12.15]:39188 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfKMDqT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Nov 2019 22:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=wGTC7
        hWMuc2qXn0pLpRaiNnbFZ9qbgGOVxKsuc3aPf0=; b=HfADcYTwNLtdITD2Sh0T7
        do5m1hPuvEYsgDD7LOkRELafFiGKhY7OQ6QocKBdHHQrWggxPQGMauxc+nQdKPD5
        nHpct1M6pkqPTZXRn8Mx4d4XU1WOTIrYLHs+EnSxS1DyLfeffoRxwJuRpA4gnV9x
        iIEJhHyDRr6yRdVcF6SiOI=
Received: from [192.168.1.133] (unknown [112.25.212.39])
        by smtp11 (Coremail) with SMTP id D8CowABXXIg7fMtdlFXLAg--.27S2;
        Wed, 13 Nov 2019 11:45:01 +0800 (CST)
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
 <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <c5e41f55-4f9e-81a3-2d45-befddee42d13@163.com>
Date:   Wed, 13 Nov 2019 11:44:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: D8CowABXXIg7fMtdlFXLAg--.27S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF48Cr4xAFW5AryxJF4fXwb_yoWrGFyUpa
        sIkF47tF4UXFy5ArnFyw17Ja4Utw4rGr1YgryUWry8AFn0vF1Sqr4I9r1ruF9xXrWUJw1j
        yrW7W3y7W34UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07betxhUUUUU=
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMx5sXlXl0TlJbwAAsh
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/12/19 11:13 PM, Daniel Borkmann wrote:
> On 11/12/19 1:50 PM, Masahiro Yamada wrote:
>> On Tue, Nov 12, 2019 at 9:31 PM Will Deacon <will@kernel.org> wrote:
>>>
>>> [+lkml, Masahiro, Alexei and Daniel]
>>>
>>> On Tue, Nov 12, 2019 at 04:56:39PM +0800, Xiao Yang wrote:
>>>> With your patch[1], I alway get the following error when building
>>>> tools/bpf:
>>>
>>> In case people want to reproduce this, my branch is here:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=lto 
>>>
>>>
>>>> ---------------------------------------------------------------------------------- 
>>>>
>>>>
>>>> make -C tools/bpf/
>>>> make: Entering directory
>>>> '/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf' 
>>>>
>>>>
>>>> Auto-detecting system features:
>>>> ... libbfd: [ on ]
>>>> ... disassembler-four-args: [ OFF ]
>>>>
>>>> CC bpf_jit_disasm.o
>>>> CC bpf_dbg.o
>>>> In file included from
>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0, 
>>>>
>>>> from
>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41: 
>>>>
>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24: 
>>>>
>>>> fatal error: asm/rwonce.h: No such file or directory
>>>> #include <asm/rwonce.h>
>>>> ^
>>>> compilation terminated.
>>>> Makefile:61: recipe for target 'bpf_dbg.o' failed
>>>> make: *** [bpf_dbg.o] Error 1
>>>> make: *** Waiting for unfinished jobs....
>>>> make: Leaving directory
>>>>
>>>> ---------------------------------------------------------------------------------- 
>>>>
>>>>
>>>> [1] 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3
>>>>
>>>> It seems that include/linux/compiler.h cannot find the asm/rwonce.h 
>>>> because
>>>> tools/bpf/Makefile doesn't include 
>>>> arch/*/include/generated/asm/rwonce.h.
>>>
>>> The problem with referring to the generated files is that they don't 
>>> exist
>>> unless you've configured the main source directory. The real problem 
>>> here
>>> seems to be that tools/bpf/ refers directly to header files in the 
>>> kernel
>>> sources without any understanding of kbuild, and therefore mandatory-y
>>> headers simply don't exist when it goes looking for them.
>
> Hmm, I am puzzled why that is. :/ I think there are two options, i) 
> remove it
> from CFLAGS like below (at least this doesn't let the build fail in my 
> case
> but requires linux headers to be installed) or ii) add a copy of 
> filter.h to
> tools/include/uapi/linux/filter.h so the few tools can just reuse it. 
> We do have
> bpf_common.h and bpf.h there already.

Hi Daniel,


Thanks for your suggestions.

Did you mean that building bpf uses the filter.h from installed linux 
header rather than include/uapi/linux/filter.h in kernel?

It seems that you just try to workaround the issue by using 
linux/filter.h from linux header.

The root casue is that include/linux/compiler.h cannot find the location 
of <asm/rwonce.h>.


Thanks,

Xiao Yang

>
> diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
> index 5d1995fd369c..08dfd289174c 100644
> --- a/tools/bpf/Makefile
> +++ b/tools/bpf/Makefile
> @@ -10,7 +10,6 @@ MAKE = make
>  INSTALL ?= install
>
>  CFLAGS += -Wall -O2
> -CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi 
> -I$(srctree)/include
>
>  # This will work when bpf is built in tools env. where srctree
>  # isn't set and when invoked from selftests build, where srctree
>
> Thanks,
> Daniel

