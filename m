Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99F362807
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhDPSwH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhDPSwH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Apr 2021 14:52:07 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE02C061574;
        Fri, 16 Apr 2021 11:51:42 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id k18so23916148oik.1;
        Fri, 16 Apr 2021 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2r2vkwG9UCNB7xrSeMaXDYuTdlG3jHjzPkkxswC7vmg=;
        b=lcF00QwLC8PK7GTMRhPSub3JPTJ1qNCRqaoSkaih+zPeslAq7Ez+xOVPJCaYARn/9h
         XHrGmLWD6OZrRMoi2WQSve0KlJyB3BPniNNxHPTudpnkvj9c8UJf2GW6Y2GEvyKBSsgc
         JltwUxOpXH0FK0i0q2ScMVocYe4sBtWOoQYapC/U67iphGwTEv/lZwF2tbIKuRPVWoC3
         hvc+SY8EFbsgAB9LWqY2WsfVhP03OYzL5pp+/QNiKegArHNkr0szL90g59fR0iHETA4R
         r9Q0+Tbcvb8uePaTFUgeOpsPJRrijUVhHveDagf9Vf/F7DAHV98Xkows9dL4YF8DBixd
         qDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2r2vkwG9UCNB7xrSeMaXDYuTdlG3jHjzPkkxswC7vmg=;
        b=EaFFflHJFuaHhowENhC5n9S0C7pOGmhBOrIh0SeTc4cbd/bWNn62bUfeIdowOWwGVW
         eQq9eDY2tlCM9OnMOPBha0PoqB2pB4f5c01yV1t06ctTHJ8S2QNr2LYF2MX1VpQ89+ny
         cemydgmVowdhyupPjtfG2QCG0/vAhR7xnB2M97VB3x4G9wIfgbWSU73uW6bco0tFTzPm
         XYUkPTl+J9H2lUyoffqqPZD8a0/we+W4g+tg4tvVBwq0cui8taIMTFB9Ps0x18vBrvuI
         8zIYvhTIEINED8FrR8WOAvw1BN0I1BT7/GXj+hIGBNrfs6TARhnDvMR4J32T1VADHAlG
         pkuA==
X-Gm-Message-State: AOAM533opCDH4Sylrq0js5i+1clhy46HDjf7HT2Q9fjQgBHsEfGDd03W
        VSX/RK6AiA05JMKkFuJrKBor7RNdjZc=
X-Google-Smtp-Source: ABdhPJz9hVqfsgFcDqumj8Y7g+QmwdbvvK8f4T/Tz19SDlxLNY4HtR0EBBFy/mHjKN7ulNYRmXaO0Q==
X-Received: by 2002:a05:6808:1444:: with SMTP id x4mr7654073oiv.142.1618599101889;
        Fri, 16 Apr 2021 11:51:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y25sm1608634otj.64.2021.04.16.11.51.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Apr 2021 11:51:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 16 Apr 2021 11:51:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] riscv: Move kernel mapping outside of linear
 mapping
Message-ID: <20210416185139.GA42339@roeck-us.net>
References: <20210409061500.14673-1-alex@ghiti.fr>
 <20210409061500.14673-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409061500.14673-2-alex@ghiti.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 09, 2021 at 02:14:58AM -0400, Alexandre Ghiti wrote:
> This is a preparatory patch for relocatable kernel and sv48 support.
> 
> The kernel used to be linked at PAGE_OFFSET address therefore we could use
> the linear mapping for the kernel mapping. But the relocated kernel base
> address will be different from PAGE_OFFSET and since in the linear mapping,
> two different virtual addresses cannot point to the same physical address,
> the kernel mapping needs to lie outside the linear mapping so that we don't
> have to copy it at the same physical offset.
> 
> The kernel mapping is moved to the last 2GB of the address space, BPF
> is now always after the kernel and modules use the 2GB memory range right
> before the kernel, so BPF and modules regions do not overlap. KASLR
> implementation will simply have to move the kernel in the last 2GB range
> and just take care of leaving enough space for BPF.
> 
> In addition, by moving the kernel to the end of the address space, both
> sv39 and sv48 kernels will be exactly the same without needing to be
> relocated at runtime.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

In next-20210416, when booting a riscv32 image in qemu, this patch results in:

[    0.000000] Linux version 5.12.0-rc7-next-20210416 (groeck@desktop) (riscv32-linux-gcc (GCC) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP Fri Apr 16 10:38:09 PDT 2021
[    0.000000] OF: fdt: Ignoring memory block 0x80000000 - 0xa0000000
[    0.000000] Machine model: riscv-virtio,qemu
[    0.000000] earlycon: uart8250 at MMIO 0x10000000 (options '115200')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] Kernel panic - not syncing: init_resources: Failed to allocate 160 bytes
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.12.0-rc7-next-20210416 #1
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] Call Trace:
[    0.000000] [<80005292>] walk_stackframe+0x0/0xce
[    0.000000] [<809f4db8>] dump_backtrace+0x38/0x46
[    0.000000] [<809f4dd4>] show_stack+0xe/0x16
[    0.000000] [<809ff1d0>] dump_stack+0x92/0xc6
[    0.000000] [<809f4fee>] panic+0x10a/0x2d8
[    0.000000] [<80c02b24>] setup_arch+0x2a0/0x4ea
[    0.000000] [<80c006b0>] start_kernel+0x90/0x628
[    0.000000] ---[ end Kernel panic - not syncing: init_resources: Failed to allocate 160 bytes ]---

Reverting it fixes the problem. I understand that the version in -next is
different to this version of the patch, but I also tried v4 and it still
crashes with the same error message.

Guenter
