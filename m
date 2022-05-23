Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477825308F5
	for <lists+linux-arch@lfdr.de>; Mon, 23 May 2022 07:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiEWFp4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 May 2022 01:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiEWFpy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 May 2022 01:45:54 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1C52655D;
        Sun, 22 May 2022 22:45:53 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e93bbb54f9so17116184fac.12;
        Sun, 22 May 2022 22:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kK4Ka04kceqN8VVd9w6tDOmbYPZ+nJZTIe88jIZoSJk=;
        b=bXwOmwvptXUzVEf8w+LjU8kE7nkSzHrjDVPCC77O/zHZxaE7Um57oJfNSQvms127Vg
         6bVR+SErg44S1V80Z6bc4GM2Z2FO9T4mQLwDIRDmL9hD/pvQuLzwjq9zNUFcrGLEc8LO
         7OaccycPlYwewUEVPyM7GtavDiuB1e14X2NVHnRB5BLlpGtpNAEQNzd+Izih4uBvXhks
         xd+08qJAhqvzotdJ7BMPNOIk/G/7GfyOHXvm0qGrS7Z3LC9XSTseYoj102Y7IlTZc6Sq
         jKMw76OUOdxUurNA+tEjR3JNslzHLKtGCM+hn+4PYsPkOcm7T068yqc7PbOcaEZEsIQT
         XThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kK4Ka04kceqN8VVd9w6tDOmbYPZ+nJZTIe88jIZoSJk=;
        b=ns94DGshDvLoFDPitT38HsalfN7ZsVrUo7ThOeCHuuuw8Zc8NCVPMjOM5q4tVA/G9m
         XiLiKKatw2Oa7U7aFGwxRaO106w6xy/ufl+EyTY2pi2c2qkM11YivW2mRhRaJgcehFWw
         HgiB6dkK5ZcRkf6TDvn8uYU0gzk43BlEaq90kQ4Rw3mErRXFO+eydc2jcFemwr7RhHqx
         QqSOlXYCzV0RhqkSjqLRqdqB1sT/v5aQ1aCD+J58EK6snvk5P0BacQFzQezmsHR5aU5E
         LpGYgW2odWt0t+IAKuGVjFh46/MbR6R8nf2cGktETqgEVrkjfW4uKkLPYJmv8VKxPa7l
         3ZoQ==
X-Gm-Message-State: AOAM533adjBSqzIaiObngnyMdX9dAGv0UqiFHJW7nzQB6v/E8vgDbBNI
        TAFASPygymp4KoPXJJTO8x4=
X-Google-Smtp-Source: ABdhPJzFVeM2nlljQKtG8croc7W21cxaI0vylQicrB+nyqNUTxI9l8dpKFNg37Q+twl0LUnv80NpPQ==
X-Received: by 2002:a05:6871:283:b0:f1:a2cb:1371 with SMTP id i3-20020a056871028300b000f1a2cb1371mr10792141oae.147.1653284752356;
        Sun, 22 May 2022 22:45:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 106-20020a9d0bf3000000b0060603221276sm3660850oth.70.2022.05.22.22.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 22:45:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 22 May 2022 22:45:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        hch@lst.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V9 20/20] riscv: compat: Add COMPAT Kbuild skeletal
 support
Message-ID: <20220523054550.GA1511899@roeck-us.net>
References: <20220322144003.2357128-1-guoren@kernel.org>
 <20220322144003.2357128-21-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322144003.2357128-21-guoren@kernel.org>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 22, 2022 at 10:40:03PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Adds initial skeletal COMPAT Kbuild (Running 32bit U-mode on
> 64bit S-mode) support.
>  - Setup kconfig & dummy functions for compiling.
>  - Implement compat_start_thread by the way.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>

With this patch in linux-next, all my riscv64 emulations crash.

[   11.600082] Run /sbin/init as init process
[   11.628561] init[1]: unhandled signal 11 code 0x1 at 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
[   11.629398] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc7-next-20220520 #1
[   11.629462] Hardware name: riscv-virtio,qemu (DT)
[   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp : 00ffffffc58199f0
[   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 : ffffffffffffffff
[   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 : 00ffffff8ade0cc0
[   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 : 00ffffffc5819a00
[   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 : 00ffffffc5819b00
[   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 : 0000000000000000
[   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 : 00ffffff8ade0728
[   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 : 00ffffffc5819e40
[   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10: 0000000000000000
[   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 : 0000000000000001
[   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
[   11.629699] status: 0000000000004020 badaddr: 0000000000000000 cause: 000000000000000d
[   11.633421] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   11.633664] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc7-next-20220520 #1
[   11.633784] Hardware name: riscv-virtio,qemu (DT)
[   11.633881] Call Trace:
[   11.633960] [<ffffffff80005e72>] dump_backtrace+0x1c/0x24
[   11.634162] [<ffffffff809aa9ec>] show_stack+0x2c/0x38
[   11.634274] [<ffffffff809b8482>] dump_stack_lvl+0x60/0x8e
[   11.634386] [<ffffffff809b84c4>] dump_stack+0x14/0x1c
[   11.634491] [<ffffffff809aaca0>] panic+0x116/0x2e2
[   11.634596] [<ffffffff80015540>] do_exit+0x7ce/0x7d4
[   11.634707] [<ffffffff80015666>] do_group_exit+0x24/0x7c
[   11.634817] [<ffffffff80022294>] get_signal+0x7ee/0x830
[   11.634924] [<ffffffff800051c0>] do_notify_resume+0x6c/0x41c
[   11.635037] [<ffffffff80003ad4>] ret_from_exception+0x0/0x10

Guenter

---
# bad: [18ecd30af1a8402c162cca1bd58771c0e5be7815] Add linux-next specific files for 20220520
# good: [42226c989789d8da4af1de0c31070c96726d990c] Linux 5.18-rc7
git bisect start 'HEAD' 'v5.18-rc7'
# bad: [f9b63740b666dd9887eb0282d21b5f65bb0cadd0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad f9b63740b666dd9887eb0282d21b5f65bb0cadd0
# bad: [7db97132097c5973ff77466d0ee681650af653de] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect bad 7db97132097c5973ff77466d0ee681650af653de
# good: [2b7d17d4b7c1ff40f58b0d32be40fc0bb6c582fb] soc: document merges
git bisect good 2b7d17d4b7c1ff40f58b0d32be40fc0bb6c582fb
# good: [69c9668f853fdd409bb8abbb37d615785510b29a] Merge branch 'clk-next' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
git bisect good 69c9668f853fdd409bb8abbb37d615785510b29a
# bad: [1577f290aa0d4c5b29c03c46ef52e4952a21bfbb] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
git bisect bad 1577f290aa0d4c5b29c03c46ef52e4952a21bfbb
# good: [34f0971f8ca73d7e5502b4cf299788a9402120f7] powerpc/powernv/flash: Check OPAL flash calls exist before using
git bisect good 34f0971f8ca73d7e5502b4cf299788a9402120f7
# good: [0349d7dfc70a26b3facd8ca97de34980d4b60954] Merge branch 'mips-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
git bisect good 0349d7dfc70a26b3facd8ca97de34980d4b60954
# bad: [20bfb54d3b121699674c17a854c5ebc7a8f97d81] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
git bisect bad 20bfb54d3b121699674c17a854c5ebc7a8f97d81
# bad: [9be8459298eadb39b9fe9974b890239e9c123107] riscv: compat: Add COMPAT Kbuild skeletal support
git bisect bad 9be8459298eadb39b9fe9974b890239e9c123107
# good: [01abdfeac81b5f56062d0a78f2cdc805db937a75] riscv: compat: Support TASK_SIZE for compat mode
git bisect good 01abdfeac81b5f56062d0a78f2cdc805db937a75
# good: [f4b395e6f1a588ed6c9a30474e58cf6b27b65783] riscv: compat: Add hw capability check for elf
git bisect good f4b395e6f1a588ed6c9a30474e58cf6b27b65783
# good: [3092eb45637573c5e435fbf5eaf9516316e5f9c6] riscv: compat: vdso: Add setup additional pages implementation
git bisect good 3092eb45637573c5e435fbf5eaf9516316e5f9c6
# good: [4608c159594fb40a5101357d4f614fdde9ce1fdb] riscv: compat: ptrace: Add compat_arch_ptrace implement
git bisect good 4608c159594fb40a5101357d4f614fdde9ce1fdb
# first bad commit: [9be8459298eadb39b9fe9974b890239e9c123107] riscv: compat: Add COMPAT Kbuild skeletal support
