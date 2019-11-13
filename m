Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9153FB2F7
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 15:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKMO53 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Nov 2019 09:57:29 -0500
Received: from m12-16.163.com ([220.181.12.16]:33746 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKMO53 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Nov 2019 09:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=uc1xN
        RSd2FCSdwQexfZJOgLv9+uaE7IUvg/ZBRWyIW0=; b=nlN0BeiMB/Yds/bEZDxvY
        XrJX+b1F9/gQ/FVUEh6GSZJaFxQvRFc8FiqgPaRWl/LPm2SbgjcXhyoa5VelJcpd
        I2YluspN7uebLQgEape++5EtVZUjFRbsIKdLTI/X/z0r976nfH2rvVtyuebBF/LM
        ZsBHxlnFZ+lni+xdCpc9JM=
Received: from [192.168.0.10] (unknown [183.210.50.120])
        by smtp12 (Coremail) with SMTP id EMCowACX0gRiGcxdP++PAQ--.1725S2;
        Wed, 13 Nov 2019 22:55:31 +0800 (CST)
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
 <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com>
 <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
 <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com>
 <CAK7LNATfK2pFnO2YV5zMLMxJGYyaj+f8w-k4K8xaoGbJ2Bd5eQ@mail.gmail.com>
 <50602386-68b1-be38-a022-0bcf9df6a54e@163.com>
 <CAK7LNAQ8h7zxhfndBqYRWXkaWVynH7GpBvDPLcVMZ1VEyUUX7A@mail.gmail.com>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <bdbe9e04-4da0-64b2-ab0c-ae739d8fd7ac@163.com>
Date:   Wed, 13 Nov 2019 22:55:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ8h7zxhfndBqYRWXkaWVynH7GpBvDPLcVMZ1VEyUUX7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: EMCowACX0gRiGcxdP++PAQ--.1725S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF48CF4xtryxKr4UKw18Grg_yoW5Zr1fpa
        s3G3W3JF4UX3WUArnrtr18Zry8tw48G3WjqryUWry0qryvyF1xJwsFgr48GFy0qry8tF1U
        ArW7K34agr1UXr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjE__UUUUU=
X-Originating-IP: [183.210.50.120]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiFgNsXlWBkhPalwAAs-
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/13/19 4:54 PM, Masahiro Yamada wrote:
> On Wed, Nov 13, 2019 at 5:36 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>> On 11/13/19 3:53 PM, Masahiro Yamada wrote:
>>> On Wed, Nov 13, 2019 at 4:17 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>>>> On 11/13/19 2:57 PM, Masahiro Yamada wrote:
>>>>> Sorry, I really do not understand what you are doing.
>>>>>
>>>>> include/linux/compiler.h is only for kernel-space.
>>>>> Shrug if a user-land program includes it.
>>>> Hi Masahiro,
>>>>
>>>> For building tools/bpf, it is good to fix the compiler error by Daniel's
>>>> patch(i.e. use linux/filter from linux header).
>>>>
>>>> linux/compiler.h may be used by other code in kernel.  Is it possible to
>>>> trigger the same error when the other code
>>>>
>>>> including linux/compiler.h is built? Is this kind of code able to find
>>>> the location of <asm/rwonce.h>?
>>> <asm/rwonce.h> is also kernel-only header.
>>>
>>> The kernel code can find <asm/rwonce.h>, but user-land code cannot.
>> Hi Masahiro,
>>
>> Sorry, I am not familar with it.
>>
>> Thanks a lot for your explanation and I have seen the LINUXINCLUDE
>> variable in Makefile.
>>
>> I will try to send a patch as Daniel suggested.
>>
>> Best Regards,
>>
>> Xiao Yang
>>
> Hmm, digging into the git history,
> this include path was added by the following commit:
>
>
> commit d7475de58575c904818efa369c82e88c6648ce2e
> Author: Kamal Mostafa <kamal@canonical.com>
> Date:   Wed Nov 11 14:24:27 2015 -0800
>
>      tools/net: Use include/uapi with __EXPORTED_HEADERS__
>
>      Use the local uapi headers to keep in sync with "recently" added #define's
>      (e.g. SKF_AD_VLAN_TPID).  Refactored CFLAGS, and bpf_asm doesn't need -I.
>
>      Fixes: 3f356385e8a4 ("filter: bpf_asm: add minimal bpf asm tool")
>      Signed-off-by: Kamal Mostafa <kamal@canonical.com>
>      Acked-by: Daniel Borkmann <daniel@iogearbox.net>
>      Signed-off-by: David S. Miller <davem@davemloft.net>
>
>
>
> I am not sure how big a deal it is,
> but it could be a problem on old distros??
>
Hi Daniel, Masahiro


Could we include the linux/filter.h generated by "make headers_install" 
as a higher priority?

(PS: According to above commit, just ensure that tools/bpf keeps in sync 
with new linux header as far as possible).

and then use the linux/filter.h in system if kernel doesn't provide 
linux/filter.h by "make headers_install".

--------------------------------------------------------------------------------------------------------------------

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 5d1995fd369c..1e0c768132af 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -10,7 +10,7 @@ MAKE = make
  INSTALL ?= install

  CFLAGS += -Wall -O2
-CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi 
-I$(srctree)/include
+CFLAGS += -I$(srctree)/usr/include

  # This will work when bpf is built in tools env. where srctree
  # isn't set and when invoked from selftests build, where srctree

---------------------------------------------------------------------------------------------------------------------


Best Regards,

Xiao Yang

>

