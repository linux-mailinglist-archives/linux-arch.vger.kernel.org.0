Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D30BF8B2B
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 09:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfKLI4v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 03:56:51 -0500
Received: from m12-11.163.com ([220.181.12.11]:34759 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfKLI4v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Nov 2019 03:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=LoUmS
        bm5SE6GuPi9Dr4iZ23U+EcmGB3vT8vSzL4VgCI=; b=jMVrNe44kArLUDXRhfHZg
        EXGqO1qR/63fLuwqdDZJJEjsdU4aN/PK8NKgLvTWVr4oF3SsMMP1CxXu3KEyaxhW
        WlNac3fC/61oEUdTQ71kGSg0fL/71tLJhbpxclzmvCy+J/zczIrV1K74RaRsVDG3
        7CxNiOjG8nIIsmQdkf96ok=
Received: from [192.168.1.133] (unknown [112.25.212.39])
        by smtp7 (Coremail) with SMTP id C8CowADX3l7Ic8pdDs7cCg--.39S2;
        Tue, 12 Nov 2019 16:56:42 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
Subject: Question about "asm/rwonce.h: No such file or directory"
To:     will@kernel.org
Cc:     linux-arch@vger.kernel.org
Message-ID: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
Date:   Tue, 12 Nov 2019 16:56:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: C8CowADX3l7Ic8pdDs7cCg--.39S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWxXFWUCF15KF17ZFyxZrb_yoW8WF43p3
        ZxKrs3tr1UX348Wr1DAw17J3WUJw45GryUK348Gry8Ar4rur17Gr42kw1rWFy3JayUJw1j
        yF17CrW3Ww1vyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bcwIDUUUUU=
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiFgJrXlWBkfS-SAAAsn
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will,


With your patch[1], I alway get the following error when building tools/bpf:

----------------------------------------------------------------------------------

make -C tools/bpf/
make: Entering directory
'/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf'

Auto-detecting system features:
... libbfd: [ on ]
... disassembler-four-args: [ OFF ]

CC bpf_jit_disasm.o
CC bpf_dbg.o
In file included from
/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0,
from
/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41:
/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24:
fatal error: asm/rwonce.h: No such file or directory
#include <asm/rwonce.h>
^
compilation terminated.
Makefile:61: recipe for target 'bpf_dbg.o' failed
make: *** [bpf_dbg.o] Error 1
make: *** Waiting for unfinished jobs....
make: Leaving directory

----------------------------------------------------------------------------------

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3


It seems that include/linux/compiler.h cannot find the asm/rwonce.h 
because tools/bpf/Makefile doesn't include 
arch/*/include/generated/asm/rwonce.h.

Did I miss some operations to build tools/bpf?


Best Regards,

XIao Yang


