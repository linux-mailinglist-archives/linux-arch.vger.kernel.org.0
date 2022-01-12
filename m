Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7598248C962
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 18:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355597AbiALRaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 12:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355608AbiALR3S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 12:29:18 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF9AC0611FF
        for <linux-arch@vger.kernel.org>; Wed, 12 Jan 2022 09:29:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t28so5558916wrb.4
        for <linux-arch@vger.kernel.org>; Wed, 12 Jan 2022 09:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N9bf45Vsnql2DAZRfvEJqoNSxZBMQPHwxVGSKSDQy60=;
        b=LZMJCz6XYFs2xNd0usdav4SY44jSwMDhV+wZi48FWWDR8PNdi35ImXXLXkzfPoKdjR
         yTMTdllA5DXz4axM1bpqdZOpeTR3QqYyWbbHhGW06sDJaQKM0PSOSVuzAW5IdhWO1SB7
         4Xnv7ZYzgw2M4cTa/RLrfgZeeUcX7XGifNDk/naRH2OGYgKszQPgc3Q54giuavbhQ3nW
         s03lH2lPYuBrjcfDg8ac3vtU7VUJQbnCGh61PYxAqDwM8pF7VIn6QBs3DGQaTZ09L9WZ
         Ptnq5hQ0f869WYnN5iFQWx2+rEk2pQHdsGR6cWYpfPlImyRJ/o+NJDsulJEUrP7/Zl0W
         m3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N9bf45Vsnql2DAZRfvEJqoNSxZBMQPHwxVGSKSDQy60=;
        b=RBRuQRa2ndPZtQ4cNw2MU3hyrFAPbmFNZa+odfMicnCOJRK7rlTrUhfU03nBciRgCU
         nRUZEIHT6BZHnvVz/LfHrdi+wAFr/6/LZgnJO4BbZC+mNsId+zqiuXnzRifBjL78kjaU
         ZOq8DMGq9+mY1DOI1gcudukt1Fa1dIxRTQgMh6+lheV4Zyy+AzA5KvRNuFFXXsQXzgyg
         K36zwXiwvUhN2blN/1VDKMQHePdRVMViHg1uSSwWF3Wx0vrYAQg41ja1GVoH6lasKJfJ
         hd7aJr4r2PJu59r+urNCGXZwcseAjFc3tZ7LfmvW+lkh0JS/BqYDNVpDPufvvlfC3W4k
         m+vw==
X-Gm-Message-State: AOAM530niqy6wb5gb9atssdqqrBJ067Wu0chT9bI2WWAlHQH4gBe69qv
        s19cMUaJm4vyLGWk10sIitXjhA==
X-Google-Smtp-Source: ABdhPJyQ/XgEL7OqgBoSz4nyTl7HYSjbzplU/zIan0zUP3gSgEajSCNS8/OXImpkmE2kocFJlgBxkw==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr714359wru.80.1642008546166;
        Wed, 12 Jan 2022 09:29:06 -0800 (PST)
Received: from wychelm (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h2sm340446wmb.12.2022.01.12.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 09:29:05 -0800 (PST)
Date:   Wed, 12 Jan 2022 17:29:03 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 08/10] ARM: uaccess: add __{get,put}_kernel_nofault
Message-ID: <Yd8P37V/N9EkwmYq@wychelm>
References: <20210726141141.2839385-1-arnd@kernel.org>
 <20210726141141.2839385-9-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726141141.2839385-9-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 26, 2021 at 04:11:39PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These mimic the behavior of get_user and put_user, except
> for domain switching, address limit checking and handling
> of mismatched sizes, none of which are relevant here.
> 
> To work with pre-Armv6 kernels, this has to avoid TUSER()
> inside of the new macros, the new approach passes the "t"
> string along with the opcode, which is a bit uglier but
> avoids duplicating more code.
> 
> As there is no __get_user_asm_dword(), I work around it
> by copying 32 bit at a time, which is possible because
> the output size is known.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've just been bisecting some regressions running the kgdbts tests on
arm and this patch came up.

It looks like once this patch applies then copy_from_kernel_nofault()
starts faulting when it called from kgdb. I've put an example stack
trace at the bottom of this mail and the most simplified reproduction
I currently have is:
~~~
make multi_v7_defconfig
../scripts/config --enable KGDB --enable KGDB_TESTS
make olddefconfig
make -j `nproc`
qemu-system-arm -M virt -m 1G -nographic \
                -kernel arch/arm/boot/zImage -initrd rootfs.cpio.gz
# Boot and login
echo V1 > /sys/module/kgdbts/parameters/kgdbts
~~~

I suspect this will reproduce on any arm system with CONFIG_KGDB and
CONFIG_KGDB_TESTS enabled simply by running that last echo command...
but I have only tested on QEMU for now.


Daniel.


Stack trace:
~~~
# echo kgdbts=V1F1000 > /sys/module/kgdbts/parameters/kgdbts
[   34.995507] KGDB: Registered I/O driver kgdbts
[   35.038102] kgdbts:RUN plant and detach test

Entering kdb (current=0xd4264380, pid 134) on processor 0 due to Keyboard Entry
[0]kdb> [   35.056005] kgdbts:RUN sw breakpoint test
[   35.062309] kgdbts:RUN bad memory access test
[   35.063619] 8<--- cut here ---
[   35.064022] Unhandled fault: page domain fault (0x01b) at 0x00000000
[   35.064212] pgd = (ptrval)
[   35.064459] [00000000] *pgd=942dc835, *pte=00000000, *ppte=00000000
[   35.065071] Internal error: : 1b [#1] SMP ARM
[   35.065381] KGDB: re-enter exception: ALL breakpoints killed
[   35.065850] ---[ end trace 909d8c43057666be ]---
[   35.066088] 8<--- cut here ---
[   35.066189] Unhandled fault: page domain fault (0x01b) at 0x00000000
[   35.066332] pgd = (ptrval)
[   35.066406] [00000000] *pgd=942dc835, *pte=00000000, *ppte=00000000
[   35.066597] Internal error: : 1b [#2] SMP ARM
[   35.066906] CPU: 0 PID: 134 Comm: sh Tainted: G      D           5.14.0-rc1-00013-g2df4c9a741a0 #60
[   35.067152] Hardware name: ARM-Versatile Express
[   35.067432] [<c0311bdc>] (unwind_backtrace) from [<c030bdc0>] (show_stack+0x10/0x14)
[   35.067880] [<c030bdc0>] (show_stack) from [<c114b9c8>] (dump_stack_lvl+0x58/0x70)
[   35.068054] [<c114b9c8>] (dump_stack_lvl) from [<c0430cdc>] (kgdb_reenter_check+0x104/0x150)
[   35.068213] [<c0430cdc>] (kgdb_reenter_check) from [<c0430dcc>] (kgdb_handle_exception+0xa4/0x114)
[   35.068395] [<c0430dcc>] (kgdb_handle_exception) from [<c0311268>] (kgdb_notify+0x30/0x74)
[   35.068563] [<c0311268>] (kgdb_notify) from [<c037422c>] (atomic_notifier_call_chain+0xac/0x194)
[   35.068745] [<c037422c>] (atomic_notifier_call_chain) from [<c0374370>] (notify_die+0x5c/0xbc)
[   35.068933] [<c0374370>] (notify_die) from [<c030bf04>] (die+0x140/0x544)
[   35.069079] [<c030bf04>] (die) from [<c03164d4>] (do_DataAbort+0xb8/0xbc)
[   35.069220] [<c03164d4>] (do_DataAbort) from [<c0300afc>] (__dabt_svc+0x5c/0xa0)
[   35.069434] Exception stack(0xd4249c10 to 0xd4249c58)
[   35.069616] 9c00:                                     ???????? ???????? ???????? ????????
[   35.069776] 9c20: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   35.069943] 9c40: ???????? ???????? ???????? ???????? ???????? ????????
[   35.070107] [<c0300afc>] (__dabt_svc) from [<c049c8c4>] (copy_from_kernel_nofault+0x114/0x13c)
[   35.070291] [<c049c8c4>] (copy_from_kernel_nofault) from [<c0431688>] (kgdb_mem2hex+0x1c/0x88)
[   35.070463] [<c0431688>] (kgdb_mem2hex) from [<c04322b0>] (gdb_serial_stub+0x8c4/0x1088)
[   35.070640] [<c04322b0>] (gdb_serial_stub) from [<c04302e8>] (kgdb_cpu_enter+0x4f4/0x988)
[   35.070796] [<c04302e8>] (kgdb_cpu_enter) from [<c0430e08>] (kgdb_handle_exception+0xe0/0x114)
[   35.070982] [<c0430e08>] (kgdb_handle_exception) from [<c0311210>] (kgdb_compiled_brk_fn+0x24/0x2c)
[   35.071166] [<c0311210>] (kgdb_compiled_brk_fn) from [<c030c40c>] (do_undefinstr+0x104/0x230)
[   35.071342] [<c030c40c>] (do_undefinstr) from [<c0300c6c>] (__und_svc_finish+0x0/0x54)
[   35.071502] Exception stack(0xd4249dc8 to 0xd4249e10)
[   35.071614] 9dc0:                   ???????? ???????? ???????? ???????? ???????? ????????
[   35.071778] 9de0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   35.071944] 9e00: ???????? ???????? ???????? ????????
[   35.072054] [<c0300c6c>] (__und_svc_finish) from [<c042fd20>] (kgdb_breakpoint+0x30/0x58)
[   35.072211] [<c042fd20>] (kgdb_breakpoint) from [<c0b14b08>] (configure_kgdbts+0x228/0x68c)
[   35.072395] [<c0b14b08>] (configure_kgdbts) from [<c036fdcc>] (param_attr_store+0x60/0xb8)
[   35.072560] [<c036fdcc>] (param_attr_store) from [<c05bcf14>] (kernfs_fop_write_iter+0x110/0x1d4)
[   35.072745] [<c05bcf14>] (kernfs_fop_write_iter) from [<c050f074>] (vfs_write+0x350/0x508)
[   35.072920] [<c050f074>] (vfs_write) from [<c050f370>] (ksys_write+0x64/0xdc)
[   35.073075] [<c050f370>] (ksys_write) from [<c03000c0>] (ret_fast_syscall+0x0/0x2c)
[   35.073259] Exception stack(0xd4249fa8 to 0xd4249ff0)
[   35.073372] 9fa0:                   ???????? ???????? ???????? ???????? ???????? ????????
[   35.073527] 9fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   35.073679] 9fe0: ???????? ???????? ???????? ????????
[   35.073960] Kernel panic - not syncing: Recursive entry to debugger
[   36.286118] SMP: failed to stop secondary CPUs
[   36.286568] ---[ end Kernel panic - not syncing: Recursive entry to debugger ]---
~~~
