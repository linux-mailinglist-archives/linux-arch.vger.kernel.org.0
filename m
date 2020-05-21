Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D21DD6A3
	for <lists+linux-arch@lfdr.de>; Thu, 21 May 2020 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgEUTIS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 15:08:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:27314 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgEUTIR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 15:08:17 -0400
IronPort-SDR: AHRBXT38Z60Ha78+Q2f2u1ovALvPVfCg8IlS7FZC6MsKaHIPn3was6oXM4iuDmYL7hOhUGqyQP
 h2YMGjUxdLZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 12:08:17 -0700
IronPort-SDR: 93Vu3B+93lKfydNCZfkzVcaYeq12dbBuZ6dMqUCQ0jI0DsnXZwUwDds9mS+hbrMENHwhh1NHBJ
 qxJ/VtWAlqqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="300414991"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002.fm.intel.com with ESMTP; 21 May 2020 12:08:17 -0700
Message-ID: <84d0e6ad65b77b69854c9b0a53de7dc17d80efff.camel@intel.com>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Thu, 21 May 2020 12:08:23 -0700
In-Reply-To: <20200521185015.aopfkpwpfhzwd4hs@treble>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200521151556.pojijpmuc2rdd7ko@treble>
         <a1e7c71c72de517a288e6273ba0c18dac2e937bc.camel@intel.com>
         <20200521185015.aopfkpwpfhzwd4hs@treble>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-05-21 at 13:50 -0500, Josh Poimboeuf wrote:
[...]
> 
> Thanks.  FYI, I got the following warning on an AMD system.
> 
> [   18.936979] get of unsupported state
> [   18.936989] WARNING: CPU: 251 PID: 1794 at arch/x86/kernel/fpu/xstate.c:919 get_xsave_addr+0x83/0x90
> [   18.949676] Modules linked in:
> [   18.952731] CPU: 251 PID: 1794 Comm: dracut-rootfs-g Not tainted 5.7.0-rc6+ #162
> [   18.960121] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X, BIOS RDY1005C 11/22/2019
> [   18.968198] RIP: 0010:get_xsave_addr+0x83/0x90
> [   18.972637] Code: 5b c3 48 83 c4 08 31 c0 5b c3 80 3d f9 c2 7a 01 00 75 bc 48 c7 c7 c4 cb 8f a9 89 74 24 04 c6 05 e5 c2 7a 01 01 e8 3f 49 0a 00 <0f> 0b 8b 74 24 04 eb 9d 31 c0 c3 66 90 0f 1f 44 00 00 48 89 fe 0f
> [   18.991373] RSP: 0018:ffffb8db103cfcd8 EFLAGS: 00010286
> [   18.996591] RAX: 0000000000000000 RBX: ffff947da1189440 RCX: 0000000000000000
> [   19.003715] RDX: 0000000000000000 RSI: ffffffffaa6809d8 RDI: ffffffffaa67e58c
> [   19.010839] RBP: ffff947da1188000 R08: 0000000468bb5e6c R09: 0000000000000018
> [   19.017962] R10: 0000000000000002 R11: 00000000000000f0 R12: ffffb8db103cfd20
> [   19.025087] R13: ffff947da1189400 R14: 0000000000000000 R15: 0000000000000007
> [   19.032211] FS:  00007f0a81b15740(0000) GS:ffff947dcf8c0000(0000) knlGS:0000000000000000
> [   19.040321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   19.046057] CR2: 00007f0a81b156c0 CR3: 0000003fa125a000 CR4: 0000000000340ee0
> [   19.053183] Call Trace:
> [   19.055637]  cet_restore_signal+0x26/0xf0
> [   19.059649]  __fpu__restore_sig+0x4cc/0x6e0
> [   19.063832]  ? remove_wait_queue+0x20/0x60
> [   19.067928]  ? reuse_swap_page+0x6e/0x340
> [   19.071939]  restore_sigcontext+0x162/0x1b0
> [   19.076128]  ? recalc_sigpending+0x17/0x50
> [   19.080223]  ? __set_task_blocked+0x34/0xa0
> [   19.084401]  __do_sys_rt_sigreturn+0x92/0xde
> [   19.088675]  do_syscall_64+0x55/0x1b0
> [   19.092342]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   19.097394] RIP: 0033:0x7f0a811389d1
> [   19.100970] Code: 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 41 ba 08 00 00 00 b8 0e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 81 44 38 00
> [   19.119709] RSP: 002b:00007ffd643d5dd8 EFLAGS: 00000246
> [   19.124933] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f0a811389d1
> [   19.132056] RDX: 0000000000000000 RSI: 00007ffd643d5e60 RDI: 0000000000000002
> [   19.139182] RBP: 000055e140190e20 R08: 000055e14017a014 R09: 0000000000000001
> [   19.146307] R10: 0000000000000008 R11: 0000000000000246 R12: 000055e13f47e4e0
> [   19.153436] R13: 00007ffd643d5e60 R14: 0000000000000000 R15: 0000000000000000
> 

Thanks!  I will fix it.

Yu-cheng

