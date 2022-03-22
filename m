Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAD4E4323
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiCVPiq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 11:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiCVPiq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 11:38:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319D942ECC;
        Tue, 22 Mar 2022 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Zq9b6qW9yqhzWMBguVnnbJQ6vTAg5F0MU+Zq1pB747c=; b=aIJTZtt6pziYzGkma+W+rGdydn
        GeuoZw+OPZ9XCXNgkQtGrplz61bo2oXckqq06onWdSJWftdWCJwDi5ZBx7ILWmkwxQOaTT0xtAtr4
        BGTFHrKXXXXWMyhdvjdd+IBV6NGc9HFOFqD/TI76JXceavlpCsPex4+yCKdBsShH0Z+jIVRSf2aQE
        hlC34JB5soOZz5mbo+T7puKZoYMBuRuIbNmWMuPHuPMyzmZLnUQACvWPI0U8Jf0z27i1yYgKjxdlG
        S0GEJ58BO+VYPBMaxlKIwuMa4Hiuemk3ARKBo1udE38xLefQtlTFbbPukQqx6SkYpF/SBH+oR0RPz
        MBvut3Cw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgZN-00Bicc-Mw; Tue, 22 Mar 2022 15:37:14 +0000
Message-ID: <b8095bf8-961f-827c-2bd6-2ffa6298b730@infradead.org>
Date:   Tue, 22 Mar 2022 08:37:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [TREE] "Fast Kernel Headers" Tree -v3
Content-Language: en-US
To:     Kari Argillander <kari.argillander@stargateuniverse.net>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kari.argillander@gmail.com
References: <Ydm7ReZWQPrbIugn@gmail.com> <YjBr10JXLGHfEFfi@gmail.com>
 <CAKBF=pvWzuPx0JB3XZ-v+i7KGbhMQTgH6xtii_Bed+qKRFx+ww@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAKBF=pvWzuPx0JB3XZ-v+i7KGbhMQTgH6xtii_Bed+qKRFx+ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Kari,

On 3/22/22 00:59, Kari Argillander wrote:
> 15.3.2022 12.35 Ingo Molnar (mingo@kernel.org) wrote:
>>
>> This is -v3 of the "Fast Kernel Headers" tree, which is an ongoing rework
>> of the Linux kernel's header hierarchy & header dependencies, with the dual
>> goals of:
>>
>>  - speeding up the kernel build (both absolute and incremental build times)
>>
>>  - decoupling subsystem type & API definitions from each other
>>
>> The fast-headers tree consists of over 25 sub-trees internally, spanning
>> over 2,300 commits, which can be found at:
>>
>>     git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
> 
> I have had problems to build master branch (defconfig) with gcc9
>     gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
> 
> I did also test v2 and problems where there too. I have no problem with gcc10 or
> Clang11. Error I get is:
> 
> In file included from ./include/linux/rcuwait_api.h:7,
>                  from ./include/linux/rcuwait.h:6,
>                  from ./include/linux/irq_work.h:7,
>                  from ./include/linux/perf_event_types.h:44,
>                  from ./include/linux/perf_event_api.h:17,
>                  from arch/x86/kernel/kprobes/opt.c:8:
> ./include/linux/rcuwait_api.h: In function ‘rcuwait_active’:
> ./include/linux/rcupdate.h:328:9: error: dereferencing pointer to
> incomplete type ‘struct task_struct’
>   328 |  typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>       |         ^
> ./include/linux/rcupdate.h:439:31: note: in expansion of macro
> ‘__rcu_access_pointer’
>   439 | #define rcu_access_pointer(p) __rcu_access_pointer((p),
> __UNIQUE_ID(rcu), __rcu)
>       |                               ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/rcuwait_api.h:15:11: note: in expansion of macro
> ‘rcu_access_pointer’
>    15 |  return !!rcu_access_pointer(w->task);
> 
>     Argillander

You could try the patch here:
https://lore.kernel.org/all/917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org/

although the build error that it fixes doesn't look exactly the same
as yours.

>> There's various changes in -v3, and it's now ported to the latest kernel
>> (v5.17-rc8).
>>
>> Diffstat difference:
>>
>>  -v2: 25332 files changed, 178498 insertions(+), 74790 deletions(-)
>>  -v3: 25513 files changed, 180947 insertions(+), 74572 deletions(-)


-- 
~Randy
