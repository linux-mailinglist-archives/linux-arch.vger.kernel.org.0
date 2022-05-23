Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BEB5314BD
	for <lists+linux-arch@lfdr.de>; Mon, 23 May 2022 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiEWQTB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 May 2022 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiEWQTA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 May 2022 12:19:00 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943DC6622C;
        Mon, 23 May 2022 09:18:51 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e93bbb54f9so19029520fac.12;
        Mon, 23 May 2022 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=hQcgMTFMJYnyHnemQfKiYLe9sphIr8EWIxdDBht7rsM=;
        b=dieU2w40td4lVVuMYpChFlJijG4d/mRbTWuTkfLJO+rd5dTHUvtF90DCLbRWn9VOrL
         mX//C2UJB8sj+RRFEC7+9H6TeuH3ZkjwcV6Ys77lSzWNLiwcaAveA6r1ER9SXwQFWx40
         8A8C6ttPUP15uYrXIkcPpWNJN6BalKyF700rzIrWCaW0mpgkmLMRKgx3ijlQYI10tpQ0
         ECnQfMulZuNzDQ1dJ7D76v52tei6kEqGPhmr6vo0EACV7xKUsISIOIiGG/K+gr5eJqej
         4vUBViwvjS/DYwYy9utos9soLpsGYqRI8C4FF24KynA4nL2nCTrF7Jy+JbkOixmA9hYF
         9NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=hQcgMTFMJYnyHnemQfKiYLe9sphIr8EWIxdDBht7rsM=;
        b=eAb/itcx0EhK3WXHwyjCc9IiuMWtUaqCLpipMKnRCmYzZ77ZWJPHJGR/SbT3W5ALH4
         gTJANFdra6z1PyRSaQN3Gv23gFAMM81S1VutJQyfWbdA6+Wmxs29AQOO/0OIXtjZPYPx
         fjfvL1rtPnoeVXMgIhHLgomdok0vHB0zGjFFA2ixOL/HmzgC8a5DfCNVqBOqaVeYbT0m
         kAKvPyt8tfiQ8s4D9GqVkJyA//KTLifLt3u7/CLfDoIGtmUWJgzG/MT1e8TE+TeJ3RHg
         ySwxsAuthBzR++zgGSip+eR0LygEoGU/c4CwoDcbZlmycvsmsvWV3A7Y1xREXK97V75q
         pf6g==
X-Gm-Message-State: AOAM532ViHxr1dt9soeUkDNz1F+IFg6rOnUc3+vINQzb9Eotz38Aul2M
        tv77YPCw5Q7M7dSibNThrwL+O7+DxeeCyA==
X-Google-Smtp-Source: ABdhPJzEeMLEErIRmEqmOqh6pwlmTVu5iDNzBHUXaHlkhoYmpIg+hOdekbZa4kGCcVymO31EtbGIsw==
X-Received: by 2002:a05:6870:659e:b0:f1:8d7a:9f36 with SMTP id fp30-20020a056870659e00b000f18d7a9f36mr12120928oab.217.1653322730772;
        Mon, 23 May 2022 09:18:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1-20020a9d6501000000b0060ae002cd3bsm4053518otl.55.2022.05.23.09.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 09:18:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0ecdb673-b9a8-40af-7dee-2ba7fe739e5f@roeck-us.net>
Date:   Mon, 23 May 2022 09:18:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20220322144003.2357128-1-guoren@kernel.org>
 <20220322144003.2357128-21-guoren@kernel.org>
 <20220523054550.GA1511899@roeck-us.net>
 <CAJF2gTSCcYif4DEpvrJ6d02no3CU_viyE+OkhhjCV3VsGmcT5Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V9 20/20] riscv: compat: Add COMPAT Kbuild skeletal
 support
In-Reply-To: <CAJF2gTSCcYif4DEpvrJ6d02no3CU_viyE+OkhhjCV3VsGmcT5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/23/22 08:18, Guo Ren wrote:
> I tested Palmer's branch, it's okay:
> 8810d7feee5a (HEAD -> for-next, palmer/for-next) riscv: Don't output a
> bogus mmu-type on a no MMU kernel
> 
> I also tested linux-next, it's okay:
> 
> rv64_rootfs:
> # uname -a
> Linux buildroot 5.18.0-next-20220523 #7 SMP Mon May 23 11:15:17 EDT
> 2022 riscv64 GNU/Linux
> #

That is is ok with one setup doesn't mean it is ok with
all setups. It is not ok with my root file system (from
https://github.com/groeck/linux-build-test/tree/master/rootfs/riscv64),
with qemu v6.2.

> #
> #
> # ls /lib
> ld-uClibc-1.0.39.so  libatomic.so.1       libgcc_s.so
> ld-uClibc.so.0       libatomic.so.1.2.0   libgcc_s.so.1
> ld-uClibc.so.1       libc.so.0            libuClibc-1.0.39.so
> libatomic.so         libc.so.1            modules
> 

My root file system uses musl.

Guenter

> rv32_rootfs:
> buildroot login: root
> # uname -a
> Linux buildroot 5.18.0-next-20220523 #7 SMP Mon May 23 11:15:17 EDT
> 2022 riscv64 GNU/Linux
> # ls /lib
> ld-linux-riscv32-ilp32d.so.1  libm.so.6
> libanl.so.1                   libnss_dns.so.2
> libatomic.so                  libnss_files.so.2
> libatomic.so.1                libpthread.so.0
> libatomic.so.1.2.0            libresolv.so.2
> libc.so.6                     librt.so.1
> libcrypt.so.1                 libthread_db.so.1
> libdl.so.2                    libutil.so.1
> libgcc_s.so                   modules
> libgcc_s.so.1
> 
> Here is my qemu version:
> commit 19f13a92cef8405052e0f73d5289f9e15474dad3 (HEAD ->
> riscv-to-apply.next, alistair/riscv-to-apply.next)
> Author: Tsukasa OI <research_trasio@irq.a4lg.com>
> Date:   Sun May 15 11:56:11 2022 +0900
> 
>      target/riscv: Move/refactor ISA extension checks
> 
>      We should separate "check" and "configure" steps as possible.
>      This commit separates both steps except vector/Zfinx-related checks.
> 
>      Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
>      Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>      Message-Id:
> <c3145fa37a529484cf3047c8cb9841e9effad4b0.1652583332.git.research_trasio@irq.a4lg.com>
>      Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> 
> On Mon, May 23, 2022 at 1:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Tue, Mar 22, 2022 at 10:40:03PM +0800, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> Adds initial skeletal COMPAT Kbuild (Running 32bit U-mode on
>>> 64bit S-mode) support.
>>>   - Setup kconfig & dummy functions for compiling.
>>>   - Implement compat_start_thread by the way.
>>>
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>
>> With this patch in linux-next, all my riscv64 emulations crash.
>>
>> [   11.600082] Run /sbin/init as init process
>> [   11.628561] init[1]: unhandled signal 11 code 0x1 at 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
>> [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc7-next-20220520 #1
>> [   11.629462] Hardware name: riscv-virtio,qemu (DT)
>> [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp : 00ffffffc58199f0
>> [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 : ffffffffffffffff
>> [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 : 00ffffff8ade0cc0
>> [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 : 00ffffffc5819a00
>> [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 : 00ffffffc5819b00
>> [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 : 0000000000000000
>> [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 : 00ffffff8ade0728
>> [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 : 00ffffffc5819e40
>> [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10: 0000000000000000
>> [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 : 0000000000000001
>> [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
>> [   11.629699] status: 0000000000004020 badaddr: 0000000000000000 cause: 000000000000000d
>> [   11.633421] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>> [   11.633664] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc7-next-20220520 #1
>> [   11.633784] Hardware name: riscv-virtio,qemu (DT)
>> [   11.633881] Call Trace:
>> [   11.633960] [<ffffffff80005e72>] dump_backtrace+0x1c/0x24
>> [   11.634162] [<ffffffff809aa9ec>] show_stack+0x2c/0x38
>> [   11.634274] [<ffffffff809b8482>] dump_stack_lvl+0x60/0x8e
>> [   11.634386] [<ffffffff809b84c4>] dump_stack+0x14/0x1c
>> [   11.634491] [<ffffffff809aaca0>] panic+0x116/0x2e2
>> [   11.634596] [<ffffffff80015540>] do_exit+0x7ce/0x7d4
>> [   11.634707] [<ffffffff80015666>] do_group_exit+0x24/0x7c
>> [   11.634817] [<ffffffff80022294>] get_signal+0x7ee/0x830
>> [   11.634924] [<ffffffff800051c0>] do_notify_resume+0x6c/0x41c
>> [   11.635037] [<ffffffff80003ad4>] ret_from_exception+0x0/0x10
>>
>> Guenter
>>
>> ---
>> # bad: [18ecd30af1a8402c162cca1bd58771c0e5be7815] Add linux-next specific files for 20220520
>> # good: [42226c989789d8da4af1de0c31070c96726d990c] Linux 5.18-rc7
>> git bisect start 'HEAD' 'v5.18-rc7'
>> # bad: [f9b63740b666dd9887eb0282d21b5f65bb0cadd0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>> git bisect bad f9b63740b666dd9887eb0282d21b5f65bb0cadd0
>> # bad: [7db97132097c5973ff77466d0ee681650af653de] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
>> git bisect bad 7db97132097c5973ff77466d0ee681650af653de
>> # good: [2b7d17d4b7c1ff40f58b0d32be40fc0bb6c582fb] soc: document merges
>> git bisect good 2b7d17d4b7c1ff40f58b0d32be40fc0bb6c582fb
>> # good: [69c9668f853fdd409bb8abbb37d615785510b29a] Merge branch 'clk-next' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
>> git bisect good 69c9668f853fdd409bb8abbb37d615785510b29a
>> # bad: [1577f290aa0d4c5b29c03c46ef52e4952a21bfbb] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
>> git bisect bad 1577f290aa0d4c5b29c03c46ef52e4952a21bfbb
>> # good: [34f0971f8ca73d7e5502b4cf299788a9402120f7] powerpc/powernv/flash: Check OPAL flash calls exist before using
>> git bisect good 34f0971f8ca73d7e5502b4cf299788a9402120f7
>> # good: [0349d7dfc70a26b3facd8ca97de34980d4b60954] Merge branch 'mips-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
>> git bisect good 0349d7dfc70a26b3facd8ca97de34980d4b60954
>> # bad: [20bfb54d3b121699674c17a854c5ebc7a8f97d81] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
>> git bisect bad 20bfb54d3b121699674c17a854c5ebc7a8f97d81
>> # bad: [9be8459298eadb39b9fe9974b890239e9c123107] riscv: compat: Add COMPAT Kbuild skeletal support
>> git bisect bad 9be8459298eadb39b9fe9974b890239e9c123107
>> # good: [01abdfeac81b5f56062d0a78f2cdc805db937a75] riscv: compat: Support TASK_SIZE for compat mode
>> git bisect good 01abdfeac81b5f56062d0a78f2cdc805db937a75
>> # good: [f4b395e6f1a588ed6c9a30474e58cf6b27b65783] riscv: compat: Add hw capability check for elf
>> git bisect good f4b395e6f1a588ed6c9a30474e58cf6b27b65783
>> # good: [3092eb45637573c5e435fbf5eaf9516316e5f9c6] riscv: compat: vdso: Add setup additional pages implementation
>> git bisect good 3092eb45637573c5e435fbf5eaf9516316e5f9c6
>> # good: [4608c159594fb40a5101357d4f614fdde9ce1fdb] riscv: compat: ptrace: Add compat_arch_ptrace implement
>> git bisect good 4608c159594fb40a5101357d4f614fdde9ce1fdb
>> # first bad commit: [9be8459298eadb39b9fe9974b890239e9c123107] riscv: compat: Add COMPAT Kbuild skeletal support
> 
> 
> 

