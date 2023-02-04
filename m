Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D352768AA47
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 14:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjBDNhD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Feb 2023 08:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjBDNgo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Feb 2023 08:36:44 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AC21B55F
        for <linux-arch@vger.kernel.org>; Sat,  4 Feb 2023 05:36:39 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id e16-20020a6b5010000000b00719041c51ebso4633938iob.12
        for <linux-arch@vger.kernel.org>; Sat, 04 Feb 2023 05:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HebWX4ZluJNfAMtUTglY+qKMvVYE9Sg9knchqLl+yi0=;
        b=4MpMitu7Pv6+5t4ndr5qMuVS3KzJjIlGz+TDXw/HFYyb+nwD9E0/BJTBShq2vESu9C
         xqRJhkB66HupQXd3E1vhT0iwzATcvOsGIL4sI0U8gKxV/wfMrYUw7KCwcqioq8aSmQwc
         MeSz6A1/HH6GpGiWh9T+9wehx1hs0JLs2VqGXKzHmxBjtflYoRIoTfLgmDHQH/kRn2xR
         bMjEw/Rv3Or7ucCRR24b+8CZ8sFvexp0AMUVBKd1tsgRshOJeuiZK7MmQ/7jgcvlr2i/
         +TL6gIPd6FHGdvSp4HPs46DagxjaaaPXfJG+9V/upQS3RMDfV5bT+hWNqajeHErqtADf
         dR6A==
X-Gm-Message-State: AO0yUKUHjKr++hVYOB8kHjNzbLE09cAFGs2qaQQDXs9q81CsnG9Mij6r
        bwxztqECjJtxt/H7HWDHRWU/eszr7h0Fvm7f7D9WhP01NDj2
X-Google-Smtp-Source: AK7set+a5lUBVlCQCLw2lSiS7n/Y9j1MQW3QHT6yeX4arVP2feZDijYR7DuomxZJWFrurAxinfZ+hYkRE4c6CA4PH8qe23ir+/NY
MIME-Version: 1.0
X-Received: by 2002:a6b:cf0f:0:b0:717:f07e:f74f with SMTP id
 o15-20020a6bcf0f000000b00717f07ef74fmr3044167ioa.55.1675517799122; Sat, 04
 Feb 2023 05:36:39 -0800 (PST)
Date:   Sat, 04 Feb 2023 05:36:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b4f6805f3dfe31d@google.com>
Subject: [syzbot] kernel BUG in __tlb_remove_page_size (2)
From:   syzbot <syzbot+d87dd8e018fd2cc2528b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, npiggin@gmail.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4fafd96910ad Add linux-next specific files for 20230203
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c95b9d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=d87dd8e018fd2cc2528b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16597573480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175ecd73480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/348cc2da441a/disk-4fafd969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2dedc500f12/vmlinux-4fafd969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fae710d9ebd8/bzImage-4fafd969.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d87dd8e018fd2cc2528b@syzkaller.appspotmail.com

 destroy_args+0x6c4/0x920 mm/debug_vm_pgtable.c:1023
 debug_vm_pgtable+0x242a/0x4640 mm/debug_vm_pgtable.c:1403
 do_one_initcall+0x141/0x7d0 init/main.c:1306
 do_initcall_level init/main.c:1379 [inline]
 do_initcalls init/main.c:1395 [inline]
 do_basic_setup init/main.c:1414 [inline]
 kernel_init_freeable+0x5ec/0x900 init/main.c:1634
 kernel_init+0x1e/0x2c0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
------------[ cut here ]------------
kernel BUG at mm/mmu_gather.c:139!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6456 Comm: syz-executor168 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__tlb_remove_page_size+0x24c/0x480 mm/mmu_gather.c:139
Code: 01 00 00 8b 6d 0c e9 e1 fe ff ff e8 ae 63 c1 ff 0f 0b e8 a7 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 64 0b fa ff <0f> 0b e8 8d 63 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc9000632f7f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000632fac0 RCX: 0000000000000000
RDX: ffff8880267d9d40 RSI: ffffffff81c3070c RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: ffffea0001ca6a80 R15: ffffc9000632fae8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd97f9a298 CR3: 000000007a9d4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tlb_remove_page_size include/asm-generic/tlb.h:466 [inline]
 tlb_remove_page+0x12/0x30 include/asm-generic/tlb.h:481
 paravirt_tlb_remove_table arch/x86/include/asm/paravirt.h:92 [inline]
 ___pte_free_tlb+0x123/0x1a0 arch/x86/mm/pgtable.c:57
 __pte_free_tlb arch/x86/include/asm/pgalloc.h:61 [inline]
 free_pte_range mm/memory.c:179 [inline]
 free_pmd_range mm/memory.c:197 [inline]
 free_pud_range mm/memory.c:231 [inline]
 free_p4d_range mm/memory.c:265 [inline]
 free_pgd_range+0x497/0xbf0 mm/memory.c:345
 free_pgtables+0x2d6/0x420 mm/memory.c:386
 exit_mmap+0x1f3/0x7d0 mm/mmap.c:3045
 __mmput+0x128/0x4c0 kernel/fork.c:1209
 mmput+0x60/0x70 kernel/fork.c:1231
 exit_mm kernel/exit.c:563 [inline]
 do_exit+0x9d7/0x2b60 kernel/exit.c:856
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1019
 get_signal+0x2321/0x25b0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f778bef7bb9
Code: Unable to access opcode bytes at 0x7f778bef7b8f.
RSP: 002b:00007f778bea9318 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f778bf7f428 RCX: 00007f778bef7bb9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f778bf7f428
RBP: 00007f778bf7f420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f778bf4d074
R13: 00007ffd97f9a23f R14: 00007f778bea9400 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__tlb_remove_page_size+0x24c/0x480 mm/mmu_gather.c:139
Code: 01 00 00 8b 6d 0c e9 e1 fe ff ff e8 ae 63 c1 ff 0f 0b e8 a7 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 64 0b fa ff <0f> 0b e8 8d 63 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc9000632f7f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000632fac0 RCX: 0000000000000000
RDX: ffff8880267d9d40 RSI: ffffffff81c3070c RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: ffffea0001ca6a80 R15: ffffc9000632fae8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f778be88718 CR3: 00000000729f0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
