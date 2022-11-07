Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA861F824
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 17:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiKGQBI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 11:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiKGQBH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 11:01:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA131D0EF;
        Mon,  7 Nov 2022 08:01:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E77D610E7;
        Mon,  7 Nov 2022 16:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B43C433D6;
        Mon,  7 Nov 2022 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667836866;
        bh=jnUlaUcgvtn2jWIpYTr0nLM1+fcq5wzwtdQps5fxFhg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FLiw5IB0H00vNPMpiTvzqYiP98MaVFZv2XPBbjt6Z31IKe2iPdABt8hi6ofg2P5q9
         w0/b7hQcfGXj5TlkBXhHb/Q5QDEAoc2iyD/aiN8fOtZp9igVp1aQRVw8MiG/Ls0MED
         TtkwxB2wGyB3+xEe9+U6Vp+CbUbgeeZkAFIgZcoXVAXWgKZwDU7REdCGRyNWY/QZ3U
         DhfNxOfjq18K1RxImAhJxKK+LGA8ZLOo+5cgo8kCwX4aaJ5iXWBd/n9a1/mmNrTe+t
         UGkWxvtvgPT/ZJ1zLYpBoQN168L6sm6MNuUHuG7c+rr8gUbeJzN2Dz27xXlA0TTUHN
         Tvd0iIkFSwo7g==
Received: by mail-lj1-f174.google.com with SMTP id a15so16950815ljb.7;
        Mon, 07 Nov 2022 08:01:05 -0800 (PST)
X-Gm-Message-State: ACrzQf2WY0XbbEMJq6Z1SqyLuWje99hLTuTSiPWl9GOrJf2ivSTByCi/
        5CAjT8eFq8NUxHkUrvSk4SWsE7v8X/ZMDym6CEg=
X-Google-Smtp-Source: AMsMyM4NbcKdEASDwlzXy3yjvge4Ih6cRuAiYXuPttZXl0Sd3TLbjMkaE2UuNz4hQ7DtKp4yRPZnCx6ps4GYkLVN7EI=
X-Received: by 2002:a05:651c:516:b0:277:2428:3682 with SMTP id
 o22-20020a05651c051600b0027724283682mr5959901ljp.291.1667836864027; Mon, 07
 Nov 2022 08:01:04 -0800 (PST)
MIME-Version: 1.0
References: <cbbd3548-880c-d2ca-1b67-5bb93b291d5f@huawei.com>
In-Reply-To: <cbbd3548-880c-d2ca-1b67-5bb93b291d5f@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 7 Nov 2022 17:00:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXESRP9RvhPC5Wgg38BqyCn5ANv7+X9Ezyx5MXNNvEZ1kA@mail.gmail.com>
Message-ID: <CAMj1kXESRP9RvhPC5Wgg38BqyCn5ANv7+X9Ezyx5MXNNvEZ1kA@mail.gmail.com>
Subject: Re: vmlinux.lds.h: Bug report: unable to handle page fault when start
 the virtual machine with qemu
To:     "zhaowenhui (A)" <zhaowenhui8@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, xiafukun@huawei.com,
        yusongping@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 7 Nov 2022 at 04:27, zhaowenhui (A) <zhaowenhui8@huawei.com> wrote:
>
> Hello,
>
> We compiled the kernel with x86_64_defconfig and the following configs
> from commit  d4c6399900364facd84c9e35ce1540b6046c345f (vmlinux.lds.h:
> Avoid orphan section with !SMP ):
>
> CONFIG_SMP=n
> CONFIG_AMD_MEM_ENCRYPT=y
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_KVM=y
> CONFIG_PARAVIRT=y
>
> Then start virtual machine with the following command (OS: Ubuntu; Arch:
> x86-64):
>
> qemu-system-x86_64  -enable-kvm -cpu Skylake-Server -smp 10 -m 8192
> -boot menu=on,splash-time=1000 \
> -device virtio-scsi-pci \
> -initrd ${initramfs} \
> -kernel ./linux/arch/x86/boot/bzImage \
> -append "root=/dev/ram rw rdinit=/sbin/init console=tty0
> console=ttyS0,115200 earlyprintk=ttyS0 debug " \
> -nographic -vnc :18
>
> (Note:  ./linux/arch/x86/boot/bzImage  is the compiled kernel bzImage path
> On my machine,  initramfs=./x86_procfs.cpio.gz_1 )
>
> QEMU reports an error:  BUG: unable to handle page fault for address:
> ffffffff8ad01040
>
> The bug was introduced by commit d4c6399900, and the problem can be
> avoided by rolling back the patch.
> Patch link:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4c6399900364facd84c9e35ce1540b6046c345f.
> We speculate that the problem is related to the hardware memory
> encryption feature in the virtualization scenario of the AMD platform.
>

That patch looks incorrect to me. Without CONFIG_SMP, the PERCPU
sections are not instantiated, and the only copy of those variables is
created in the ordinary .data/.bss sections

Does the change below fix the issue for you?

--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -347,6 +347,7 @@
 #define DATA_DATA                                                      \
        *(.xiptext)                                                     \
        *(DATA_MAIN)                                                    \
+       *(.data..decrypted)                                             \
        *(.ref.data)                                                    \
        *(.data..shared_aligned) /* percpu related */                   \
        MEM_KEEP(init.data*)                                            \
@@ -995,7 +996,6 @@
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 #define PERCPU_DECRYPTED_SECTION                                       \
        . = ALIGN(PAGE_SIZE);                                           \
-       *(.data..decrypted)                                             \
        *(.data..percpu..decrypted)                                     \
        . = ALIGN(PAGE_SIZE);
 #else
