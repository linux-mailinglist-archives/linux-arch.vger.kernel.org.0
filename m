Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED44961E999
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 04:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiKGD1E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Nov 2022 22:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiKGD1E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Nov 2022 22:27:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BAEA47C;
        Sun,  6 Nov 2022 19:27:02 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5Gqg3QqtzRnsM;
        Mon,  7 Nov 2022 11:26:55 +0800 (CST)
Received: from [10.67.110.25] (10.67.110.25) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 11:27:01 +0800
Message-ID: <cbbd3548-880c-d2ca-1b67-5bb93b291d5f@huawei.com>
Date:   Mon, 7 Nov 2022 11:27:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
To:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <xiafukun@huawei.com>, <yusongping@huawei.com>
From:   "zhaowenhui (A)" <zhaowenhui8@huawei.com>
Subject: vmlinux.lds.h: Bug report: unable to handle page fault when start the
 virtual machine with qemu
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

We compiled the kernel with x86_64_defconfig and the following configs 
from commit  d4c6399900364facd84c9e35ce1540b6046c345f (vmlinux.lds.h: 
Avoid orphan section with !SMP ):

CONFIG_SMP=n
CONFIG_AMD_MEM_ENCRYPT=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_KVM=y
CONFIG_PARAVIRT=y

Then start virtual machine with the following command (OS: Ubuntu; Arch: 
x86-64):

qemu-system-x86_64  -enable-kvm -cpu Skylake-Server -smp 10 -m 8192 
-boot menu=on,splash-time=1000 \
-device virtio-scsi-pci \
-initrd ${initramfs} \
-kernel ./linux/arch/x86/boot/bzImage \
-append "root=/dev/ram rw rdinit=/sbin/init console=tty0 
console=ttyS0,115200 earlyprintk=ttyS0 debug " \
-nographic -vnc :18

(Note:  ./linux/arch/x86/boot/bzImage  is the compiled kernel bzImage path
On my machine,  initramfs=./x86_procfs.cpio.gz_1 )

QEMU reports an error:  BUG: unable to handle page fault for address: 
ffffffff8ad01040

The bug was introduced by commit d4c6399900, and the problem can be 
avoided by rolling back the patch.
Patch link: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4c6399900364facd84c9e35ce1540b6046c345f.
We speculate that the problem is related to the hardware memory 
encryption feature in the virtualization scenario of the AMD platform.


# Error log:
[    0.000000] Linux version 6.1.0-rc3+ (root@cgsubuntu13) (gcc (Ubuntu 
7.5.0-6ubuntu2) 2
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
rel-1.15.0-0-g2dd4b9b3f4
[    0.000000] Hypervisor detected: KVM
[    0.017457] found SMP MP-table at [mem 0x000f5b90-0x000f5b9f]
[    0.018300] Using GB pages for direct mapping
[    0.162066] Memory: 7783780K/8388088K available (16398K kernel code, 
2819K rwdata, 40)
[    0.164323] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.165253] Kernel/User page tables isolation: enabled
[    0.252783] CPU: Intel Xeon Processor (Skylake) (family: 0x6, model: 
0x55, stepping: )

[    1.535968] PM:   Magic number: 14:957:648
[    1.537003] acpi LNXCPU:01: hash matches
[    1.537857] printk: console [netcon0] enabled
[    1.538766] netconsole: network logging started
[    1.540923] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[    2.078792] input: ImExPS/2 Generic Explorer Mouse as 
/devices/platform/i8042/serio1/3
[    6.876322] Freeing initrd memory: 358780K
[    6.878474] modprobe (63) used greatest stack depth: 13192 bytes left
[    6.880931] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.882256] platform regulatory.0: Direct firmware load for 
regulatory.db failed with2
[    6.883983] ALSA device list:
[    6.884646]   No soundcards found.
[    6.885399] cfg80211: failed to load regulatory.db
[    6.887176] Freeing unused decrypted memory: 2036K
[    6.888195] Freeing unused kernel image (initmem) memory: 1360K
[    6.889804] BUG: unable to handle page fault for address: 
ffffffff8ad01040
[    6.890856] #PF: supervisor write access in kernel mode
[    6.891663] #PF: error_code(0x0002) - not-present page
[    6.892459] PGD 1ee25067 P4D 1ee25067 PUD 1ee26063 PMD 100105063 PTE 
800fffffe08fe062
[    6.893668] Oops: 0002 [#1] PREEMPT PTI
[    6.894309] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #4
[    6.895244] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.15.0-0-4
[    6.896924] RIP: 0010:kvm_guest_apic_eoi_write+0x0/0x30
[    6.897740] Code: 59 41 58 5f 5e 5a 59 c3 cc cc cc cc 66 66 2e 0f 1f 
84 00 00 00 00 00
[    6.900388] RSP: 0018:ffffab8680003fd8 EFLAGS: 00010046
[    6.901198] RAX: ffffffff88eb4c80 RBX: 0000000000000000 RCX: 
0000000000000017
[    6.902253] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000000b0
[    6.903327] RBP: ffffffff8a403de8 R08: 0000000413a0c8af R09: 
0000000000000000
[    6.904398] R10: 0000000000000000 R11: ffffab8680003ff8 R12: 
0000000000000000
[    6.905466] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[    6.906527] FS:  0000000000000000(0000) GS:ffffffff8a465000(0000) 
knlGS:00000000000000
[    6.907769] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.908648] CR2: ffffffff8ad01040 CR3: 000000001ee22001 CR4: 
00000000007706f0
[    6.909712] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    6.910778] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[    6.911845] PKRU: 55555554
[    6.912341] Call Trace:
[    6.912808]  <IRQ>
[    6.913209]  __sysvec_apic_timer_interrupt+0x41/0x120
[    6.914013]  sysvec_apic_timer_interrupt+0x82/0xb0
[    6.914784]  </IRQ>
[    6.915203]  <TASK>
[    6.915624]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[    6.916434] RIP: 0010:default_idle+0xb/0x10
[    6.917114] Code: ff ff 4c 89 f7 e8 25 e1 89 ff e9 26 ff ff ff e8 9b 
72 ff ff cc cc c2
[    6.919764] RSP: 0018:ffffffff8a403e98 EFLAGS: 00000246
[    6.920595] RAX: ffffffff89ac49c0 RBX: 0000000000000000 RCX: 
0000000000000000
[    6.921677] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 
0000000000000004
[    6.922745] RBP: 0000000000000000 R08: 00000004139503a8 R09: 
0000000000000001
[    6.923880] R10: ffffab8680013e48 R11: ffffab8680013da0 R12: 
ffffffffffffffff
[    6.924948] R13: 0000000000000000 R14: ffffffff8a42aa00 R15: 
0000000000000000
[    6.926020]  ? __cpuidle_text_start+0x8/0x8
[    6.926705]  ? __cpuidle_text_start+0x8/0x8
[    6.927393]  default_idle_call+0x28/0xb0
[    6.928049]  do_idle+0x172/0x200
[    6.928613]  cpu_startup_entry+0xa/0x10
[    6.929250]  rest_init+0xb9/0xc0
[    6.929818]  arch_call_rest_init+0x5/0xa
[    6.930470]  start_kernel+0x651/0x67c
[    6.931092]  secondary_startup_64_no_verify+0xe5/0xeb
[    6.931893]  </TASK>
[    6.932321] Modules linked in:
[    6.932859] CR2: ffffffff8ad01040
[    6.933435] ---[ end trace 0000000000000000 ]---
[    6.934179] RIP: 0010:kvm_guest_apic_eoi_write+0x0/0x30
[    6.934998] Code: 59 41 58 5f 5e 5a 59 c3 cc cc cc cc 66 66 2e 0f 1f 
84 00 00 00 00 00
[    6.937626] RSP: 0018:ffffab8680003fd8 EFLAGS: 00010046
[    6.938440] RAX: ffffffff88eb4c80 RBX: 0000000000000000 RCX: 
0000000000000017
[    6.939509] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000000b0
[    6.940575] RBP: ffffffff8a403de8 R08: 0000000413a0c8af R09: 
0000000000000000
[    6.941639] R10: 0000000000000000 R11: ffffab8680003ff8 R12: 
0000000000000000
[    6.942698] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[    6.943789] FS:  0000000000000000(0000) GS:ffffffff8a465000(0000) 
knlGS:00000000000000
[    6.945026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.945915] CR2: ffffffff8ad01040 CR3: 000000001ee22001 CR4: 
00000000007706f0
[    6.946991] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    6.948061] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[    6.949122] PKRU: 55555554
[    6.949613] Kernel panic - not syncing: Fatal exception in interrupt
[    6.950575] Kernel Offset: 0x7e00000 from 0xffffffff81000000 
(relocation range: 0xfff)
[    6.952157] ---[ end Kernel panic - not syncing: Fatal exception in 
interrupt ]---

(Note: In some environments, different errors may occur as follows:
[ C0] BUG: stack guard page was hit at 00000000eb1b929b (stack is 
0000000034e7e985..000000005beaadc6)
[ C0] kernel stack overflow (double-fault): 0000 [#1] PTI  )

Regards
