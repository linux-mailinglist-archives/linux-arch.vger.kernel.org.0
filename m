Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4EEDF93CB
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 16:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKLPNw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 10:13:52 -0500
Received: from www62.your-server.de ([213.133.104.62]:55050 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLPNw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2019 10:13:52 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iUXrV-0001Td-3O; Tue, 12 Nov 2019 16:13:45 +0100
Received: from [2a02:1205:507e:bf80:bef8:7f66:49c8:72e5] (helo=pc-11.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iUXrU-000QBs-QI; Tue, 12 Nov 2019 16:13:44 +0100
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
Cc:     Xiao Yang <ice_yangxiao@163.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
 <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net>
Date:   Tue, 12 Nov 2019 16:13:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25631/Tue Nov 12 10:51:17 2019)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/12/19 1:50 PM, Masahiro Yamada wrote:
> On Tue, Nov 12, 2019 at 9:31 PM Will Deacon <will@kernel.org> wrote:
>>
>> [+lkml, Masahiro, Alexei and Daniel]
>>
>> On Tue, Nov 12, 2019 at 04:56:39PM +0800, Xiao Yang wrote:
>>> With your patch[1], I alway get the following error when building
>>> tools/bpf:
>>
>> In case people want to reproduce this, my branch is here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=lto
>>
>>> ----------------------------------------------------------------------------------
>>>
>>> make -C tools/bpf/
>>> make: Entering directory
>>> '/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf'
>>>
>>> Auto-detecting system features:
>>> ... libbfd: [ on ]
>>> ... disassembler-four-args: [ OFF ]
>>>
>>> CC bpf_jit_disasm.o
>>> CC bpf_dbg.o
>>> In file included from
>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0,
>>> from
>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41:
>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24:
>>> fatal error: asm/rwonce.h: No such file or directory
>>> #include <asm/rwonce.h>
>>> ^
>>> compilation terminated.
>>> Makefile:61: recipe for target 'bpf_dbg.o' failed
>>> make: *** [bpf_dbg.o] Error 1
>>> make: *** Waiting for unfinished jobs....
>>> make: Leaving directory
>>>
>>> ----------------------------------------------------------------------------------
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3
>>>
>>> It seems that include/linux/compiler.h cannot find the asm/rwonce.h because
>>> tools/bpf/Makefile doesn't include arch/*/include/generated/asm/rwonce.h.
>>
>> The problem with referring to the generated files is that they don't exist
>> unless you've configured the main source directory. The real problem here
>> seems to be that tools/bpf/ refers directly to header files in the kernel
>> sources without any understanding of kbuild, and therefore mandatory-y
>> headers simply don't exist when it goes looking for them.

Hmm, I am puzzled why that is. :/ I think there are two options, i) remove it
from CFLAGS like below (at least this doesn't let the build fail in my case
but requires linux headers to be installed) or ii) add a copy of filter.h to
tools/include/uapi/linux/filter.h so the few tools can just reuse it. We do have
bpf_common.h and bpf.h there already.

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 5d1995fd369c..08dfd289174c 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -10,7 +10,6 @@ MAKE = make
  INSTALL ?= install

  CFLAGS += -Wall -O2
-CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi -I$(srctree)/include

  # This will work when bpf is built in tools env. where srctree
  # isn't set and when invoked from selftests build, where srctree

Thanks,
Daniel
