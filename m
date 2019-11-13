Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12167F9FBE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 01:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKMA7i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 19:59:38 -0500
Received: from m12-15.163.com ([220.181.12.15]:39292 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfKMA7i (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Nov 2019 19:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=E8au+
        6fmIdKg4g6nquQmx+6A/N6qSHx7pcBJykcLtPg=; b=X+L5Gnw356nd6A4qwc5hp
        rPaqVoFO7qEpGNUAQlPmHZUJx85rwqpSreq2+0q31nwXlpKv9RfmDeoPTNoac712
        R1awvxOFw6MUPPqhH1opS8Iufg5ogaxOfgaWrNX//aTpyFl1L2l1nLM2iluLywBY
        GqGrCLbBNfermYcU+WfJUg=
Received: from [192.168.1.133] (unknown [112.25.212.39])
        by smtp11 (Coremail) with SMTP id D8CowACHfNxiVctdLKG9Ag--.166S2;
        Wed, 13 Nov 2019 08:59:15 +0800 (CST)
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Will Deacon <will@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yamada.masahiro@socionext.com, ast@kernel.org, daniel@iogearbox.net
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
 <20191112123125.GD17835@willie-the-truck>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <cf0a0d1b-8680-7275-66b6-f704ef5cd89c@163.com>
Date:   Wed, 13 Nov 2019 08:59:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191112123125.GD17835@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: D8CowACHfNxiVctdLKG9Ag--.166S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4DGr1kWw45tFykXr45GFg_yoW5Xw1fpF
        Wa9r4IyF4UJFy8GrnrAw17A3WUA3y3Gry5Kr1UGry8Ar1rur13Kr4xur18ur9xZ3y7Jr4j
        yFsrWrWUW340yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bYCztUUUUU=
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMwxsXlXl0TWPkAABsH
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/12/19 8:31 PM, Will Deacon wrote:
> [+lkml, Masahiro, Alexei and Daniel]
>
> On Tue, Nov 12, 2019 at 04:56:39PM +0800, Xiao Yang wrote:
>> With your patch[1], I alway get the following error when building
>> tools/bpf:
> In case people want to reproduce this, my branch is here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=lto
>
>> ----------------------------------------------------------------------------------
>>
>> make -C tools/bpf/
>> make: Entering directory
>> '/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf'
>>
>> Auto-detecting system features:
>> ... libbfd: [ on ]
>> ... disassembler-four-args: [ OFF ]
>>
>> CC bpf_jit_disasm.o
>> CC bpf_dbg.o
>> In file included from
>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0,
>> from
>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41:
>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24:
>> fatal error: asm/rwonce.h: No such file or directory
>> #include <asm/rwonce.h>
>> ^
>> compilation terminated.
>> Makefile:61: recipe for target 'bpf_dbg.o' failed
>> make: *** [bpf_dbg.o] Error 1
>> make: *** Waiting for unfinished jobs....
>> make: Leaving directory
>>
>> ----------------------------------------------------------------------------------
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3
>>
>> It seems that include/linux/compiler.h cannot find the asm/rwonce.h because
>> tools/bpf/Makefile doesn't include arch/*/include/generated/asm/rwonce.h.
> The problem with referring to the generated files is that they don't exist
> unless you've configured the main source directory. The real problem here
> seems to be that tools/bpf/ refers directly to header files in the kernel
> sources without any understanding of kbuild, and therefore mandatory-y
> headers simply don't exist when it goes looking for them.
>
> Perhaps it's possible to introduce a dependency on a top-level "make
> asm-generic" so that we can reference the generated headers from the arch
> directly. Thoughts?

Hi Will,


Thanks for your reply.

I tried to do "make asm-generic" operation before, but it just generated 
asm/rwonce.h

in arch/*/include/generated directory and building tools/bpf still 
cannot find it.

Perhaps, the Makefile of tools/bpf needs to be improved.


Best Regards,

Xiao Yang

>
> Will

