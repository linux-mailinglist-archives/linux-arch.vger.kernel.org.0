Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA642247CD
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jul 2020 03:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGRBix (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 21:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBiw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 21:38:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732AAC0619D2;
        Fri, 17 Jul 2020 18:38:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so7478092pgg.10;
        Fri, 17 Jul 2020 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KteNnStqsCqAGcdw9ggpAGeghm53Iiz3RiOfiuEXth4=;
        b=E/K1EvJ3aO75BbPCj25vCwPKo5cuXB1IMfNWuZqLQUUZdcKcW+OOezlyKt7z/rmQRj
         tCMRekDZ6z+3Ltmp7EuLj8k1OTEotX0tP04sQu5QyPvVrpLMc3rpstGFhxqeuSGBj0WG
         HDh2NJzrY16Izwqybb6of8r0gEjZYyw5+rc5nitix2/Bf25quq6STbHvx4VQROHC3hXT
         nqfZVqIpqZ8ieDjomLko80TX/HQ5JdHtxccIBtqnOnZhmDJ3vAYqJvSZ1KsEpmFoufsQ
         FF4BHeQOT3foE38dOYi1ZY5fF2qCn3+065HVe5qvgLPolAZdsynLt92uiQpAX43+lsiF
         2rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KteNnStqsCqAGcdw9ggpAGeghm53Iiz3RiOfiuEXth4=;
        b=gwxLIdeVBEqBQcTChKImEpy+dGysLZFzR3y4F15u6Q0RHh3GwPCGYS1geC2YND00Tu
         VeD3yqXk0IZ2viqPh2nIGtc6rkxCA7pvcpqTKQyUZMBSiq/jEaWYHD/EoewJLkn6ZhPF
         z7rRLRMyoOZ+Qkh8WyBt6vft0xmDh+632BVdO2IA3FsdmLS9v0Mwwsld4VSJqizt+T4j
         ZsDnNukD0iYXb09JVMPU4O6fXEDbI3yzq7ToxnYX33Bwl9Eu87HyxxffN2Y43WxvHBcu
         WAV2lEboeN09L7GCpS7Fb9BoOIiQbSb9Xkr/5V7acGC40sj7+C6vdsUB7SLy2QY76mpQ
         T6rA==
X-Gm-Message-State: AOAM530B18OGnk5eC64wGr9YrkkqYoIOSYcwlnc9FB7O2WDaMC6Z7mqH
        zr4pxA/ncnuBPxFg+MwJfhI=
X-Google-Smtp-Source: ABdhPJz6DOJ38Rs1B1GFNBSrSmJ5MkwTYCNw130+Arke2nttVtU8/7N5ZRwYUHNS4kq4iZURwTnEQA==
X-Received: by 2002:a65:43c1:: with SMTP id n1mr10547707pgp.67.1595036331816;
        Fri, 17 Jul 2020 18:38:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mv6sm3801237pjb.57.2020.07.17.18.38.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jul 2020 18:38:51 -0700 (PDT)
Date:   Fri, 17 Jul 2020 18:38:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Message-ID: <20200718013849.GA157764@roeck-us.net>
References: <20200714105505.935079-1-hch@lst.de>
 <20200714105505.935079-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714105505.935079-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Tue, Jul 14, 2020 at 12:55:00PM +0200, Christoph Hellwig wrote:
> Use the uaccess_kernel helper instead of duplicating it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch causes a severe hiccup with my mps2-an385 boot test.

[    8.545195] ------------[ cut here ]------------
[    8.545294] WARNING: CPU: 0 PID: 1 at ./include/linux/syscalls.h:267 addr_limit_check_failed+0x11/0x24
[    8.545376] Invalid address limit on user-mode return
[    8.545487] CPU: 0 PID: 1 Comm: init Not tainted 5.8.0-rc5-next-20200717 #1
[    8.545603] Hardware name: MPS2 (Device Tree Support)
[    8.546053] [<2100af9d>] (unwind_backtrace) from [<2100a353>] (show_stack+0xb/0xc)
[    8.546240] [<2100a353>] (show_stack) from [<2100dadb>] (__warn+0x6f/0x80)
[    8.546311] [<2100dadb>] (__warn) from [<2100db1d>] (warn_slowpath_fmt+0x31/0x60)
[    8.546383] [<2100db1d>] (warn_slowpath_fmt) from [<2100a159>] (addr_limit_check_failed+0x11/0x24)
[    8.546464] [<2100a159>] (addr_limit_check_failed) from [<210080f3>] (ret_to_user_from_irq+0xf/0x18)
[    8.546567] Exception stack(0x21427fb0 to 0x21427ff8)
[    8.546649] 7fa0:                                     00000000 00000000 00000000 00000000
[    8.546729] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 21744f80 00000000
[    8.546800] 7fe0: 00000000 21757fa8 00000000 21700b6c 01000000 00000000
[    8.546910] ---[ end trace f1b0cd10cc3456dc ]---

This keeps happening until qemu aborts.

Reverting the patch isn't possible since segment_eq() is gone in
next-20200717.

Guenter

---
# bad: [aab7ee9f8ff0110bfcd594b33dc33748dc1baf46] Add linux-next specific files for 20200717
# good: [11ba468877bb23f28956a35e896356252d63c983] Linux 5.8-rc5
git bisect start 'HEAD' 'v5.8-rc5'
# good: [4d55a7a1298d197755c1a0f4512f56917e938a83] Merge remote-tracking branch 'crypto/master'
git bisect good 4d55a7a1298d197755c1a0f4512f56917e938a83
# good: [e63bf5dcce255302e355cb2277a3a39c83752c92] Merge remote-tracking branch 'devicetree/for-next'
git bisect good e63bf5dcce255302e355cb2277a3a39c83752c92
# good: [94d932ec3afb923efd8c736974f8316413175a5b] Merge remote-tracking branch 'thunderbolt/next'
git bisect good 94d932ec3afb923efd8c736974f8316413175a5b
# good: [5ddd2e0dbe8fceb80b0b36bd38a32217be7a04a5] Merge remote-tracking branch 'livepatching/for-next'
git bisect good 5ddd2e0dbe8fceb80b0b36bd38a32217be7a04a5
# bad: [40346f79983caf46fb92f779b0353422d43580a9] ipc/shm.c: Remove the superfluous break
git bisect bad 40346f79983caf46fb92f779b0353422d43580a9
# good: [0b917599517f71ddef5f7274a8199a33cecd49b2] kasan: update required compiler versions in documentation
git bisect good 0b917599517f71ddef5f7274a8199a33cecd49b2
# good: [701571ae06641cc0632d113a6d25f54ce651e723] mm,hwpoison: rework soft offline for free pages
git bisect good 701571ae06641cc0632d113a6d25f54ce651e723
# bad: [1c21deffe923b068d2d297c248845ec93531d1bf] lib/test_bits.c: add tests of GENMASK
git bisect bad 1c21deffe923b068d2d297c248845ec93531d1bf
# bad: [9549375184b2cb4f63fa7917665acf9c44114499] uaccess: add force_uaccess_{begin,end} helpers
git bisect bad 9549375184b2cb4f63fa7917665acf9c44114499
# good: [233d009c15719e43c53b73296144664e0bd59a2e] mm/memory_hotplug: introduce default dummy memory_add_physaddr_to_nid()
git bisect good 233d009c15719e43c53b73296144664e0bd59a2e
# good: [42889ca325dd735ce964838cff81a444637d9d01] mm: drop duplicated words in <linux/mm.h>
git bisect good 42889ca325dd735ce964838cff81a444637d9d01
# bad: [3b17e98704eedeeff41672b2f64cef1bbefbb8b2] nds32: use uaccess_kernel in show_regs
git bisect bad 3b17e98704eedeeff41672b2f64cef1bbefbb8b2
# bad: [02dc30b876b111276fe7d83d492ddfc2b39b80e3] syscalls: use uaccess_kernel in addr_limit_user_check
git bisect bad 02dc30b876b111276fe7d83d492ddfc2b39b80e3
# first bad commit: [02dc30b876b111276fe7d83d492ddfc2b39b80e3] syscalls: use uaccess_kernel in addr_limit_user_check
