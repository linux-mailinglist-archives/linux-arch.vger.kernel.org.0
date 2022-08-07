Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6558BE0F
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 00:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiHGWmp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Aug 2022 18:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiHGWm1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2022 18:42:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7F726E3;
        Sun,  7 Aug 2022 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dLjSYAzCh4IBJ/gcod+IKEbUhjWe/9Of5cFDsSCQDGI=; b=310JJornQDy4RnuqU1FkM3sUOA
        RlpcAU9IwdVoQQ6mrP19n3L198KdGW6/P0D0oi2Dq85A9mbT0Ncxs4iD7+2BKF0ElO+d111fORGqn
        yhhSpdqxIK/H+MwbQlBidthWbBvcOyT7ldcjddq7blgvwm1YfhVVriwRCUhj8UlSeXcEPF3INm5yt
        ESo4Cw2KMzmgTE3idAITUEbr2mKi6N4gBLcXlgm4bVITxZZ5y8/IaAOpMUo4mhFccmGDW5BNoAmvg
        2dkUlCebB8v2ZsivvfmmVIIqtgyIbvyYUIV61nw17r54FMDO06+MHv3DGrgUfn7vDTuGujDTaJXGH
        hl62BVig==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKovI-003VFb-9Q; Sun, 07 Aug 2022 22:39:04 +0000
Message-ID: <3a4dad85-1102-1bab-c0af-a2c6827663b1@infradead.org>
Date:   Sun, 7 Aug 2022 15:39:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] asm-generic: unistd.h: make 'compat_sys_fadvise64_64'
 conditional
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20220807172854.12971-1-rdunlap@infradead.org>
 <CAK8P3a0FR2ySLXAMGR1ZmaAQMbVwB4MFBPvBw4py_pbgtQSfgA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK8P3a0FR2ySLXAMGR1ZmaAQMbVwB4MFBPvBw4py_pbgtQSfgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On 8/7/22 12:44, Arnd Bergmann wrote:
> On Sun, Aug 7, 2022 at 7:28 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Don't require 'compat_sys_fadvise64_64' when
>> __ARCH_WANT_COMPAT_FADVISE64_64 is not set.
>>
>> Fixes this build error when CONFIG_ADVISE_SYSCALLS is not set:
>>
>> include/uapi/asm-generic/unistd.h:649:49: error: 'compat_sys_fadvise64_64' undeclared here (not in a function); did you mean 'ksys_fadvise64_64'?
>>   649 | __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
>> arch/riscv/kernel/compat_syscall_table.c:12:42: note: in definition of macro '__SYSCALL'
>>    12 | #define __SYSCALL(nr, call)      [nr] = (call),
>> include/uapi/asm-generic/unistd.h:649:1: note: in expansion of macro '__SC_COMP'
>>   649 | __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: linux-riscv@lists.infradead.org
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arch@vger.kernel.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> ---
>>  include/uapi/asm-generic/unistd.h |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- a/include/uapi/asm-generic/unistd.h
>> +++ b/include/uapi/asm-generic/unistd.h
>> @@ -645,8 +645,10 @@ __SC_COMP(__NR_execve, sys_execve, compa
>>  #define __NR3264_mmap 222
>>  __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
>>  /* mm/fadvise.c */
>> +#ifdef __ARCH_WANT_COMPAT_FADVISE64_64
>>  #define __NR3264_fadvise64 223
>>  __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
>> +#endif
>>
> 
> This does not work: __ARCH_WANT_COMPAT_FADVISE64_64 is defined in
> arch/riscv/include/asm/unistd.h, which is not a UAPI header. By making the line
> conditional on this, user space no longer sees the macro definition.
> 
> It looks like you also drop the native definition on all architectures other
> than riscv here. What we probably want is to just make all the
> declarations in include/linux/compat.h unconditional and not have them
> depend on architecture specific macros. Some of these may have
> incompatible prototypes depending on the architecture, but if we run
> into those, I would suggest we just give them unique names.

Thanks for the comments.

With the other patch to kernel/sys_ni.c, this one is no longer needed,
although I can look into making more entries in <linux/compat.h>
unconditional. That would also mean adding them to kernel/sys_ni.c, right?
(if not already there)

-- 
~Randy
