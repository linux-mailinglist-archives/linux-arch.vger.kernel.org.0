Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA404EA19B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Mar 2022 22:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbiC1UhS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Mar 2022 16:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbiC1UhL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2022 16:37:11 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586F368FB4;
        Mon, 28 Mar 2022 13:35:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AFB663FBF24;
        Mon, 28 Mar 2022 16:35:13 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eGl2JjcfyixH; Mon, 28 Mar 2022 16:35:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3D39A3FBF23;
        Mon, 28 Mar 2022 16:35:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3D39A3FBF23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1648499713;
        bh=tNcH335YJ/4x8yVi8nSDMIeS4E89Ow3BdGUYIADF9gI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oE92hvqbxg9Ro3dlq/CWgRV8YpFDucYZj2ABJ+hhQudLX9eNslVwB6xxCFKfHU0I+
         fbrYGadCY9zJZDRZlePVW2zcV/9miO7E0VIYbrNuGUdd1h/6nWL0HkgW7np+90kKiR
         mDZMj/gDz8VGoMvHPotk6XZSXILGQ+5FqjJoanjcgo84Jym9lHV1Z8Os6O5WMXdk+F
         GmpFmRLX2u+T+jZmYcH9DhhdShuC9K2FE9dQVj1CWowINZWRhtw9A6zI4nBZuWPweq
         K6HdkqUpxMCRa7I4IXeKaGds6T/qKSTTe1+uPE2LSFtIN7BUwMDw+RDnWmHcCQUwMG
         dbhvny9nKC0rw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hz3AuyqO_hcb; Mon, 28 Mar 2022 16:35:13 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3205F3FC089;
        Mon, 28 Mar 2022 16:35:13 -0400 (EDT)
Date:   Mon, 28 Mar 2022 16:35:13 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Beau Belgrave <beaub@microsoft.com>, rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <1283359416.196715.1648499713041.JavaMail.zimbra@efficios.com>
In-Reply-To: <2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com>
References: <2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com>
Subject: Re: Comments on new user events ABI
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: Comments on new user events ABI
Thread-Index: B0M+BmOcIucczO4F1K4t0lJIcDaNNfBSo6mg
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Mar 28, 2022, at 4:24 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi Beau, Hi Steven,
> 
> I've done a review of the trace events ABI, and I have a few comments.
> Sorry for being late to the party, but I only noticed this new ABI recently.
> Hopefully we can improve this ABI before the 5.18 release.
> 

Also a bit of testing shows that dyn_event_add() is called without holding the event_mutex.
Has this been tested with lockdep ?

[  144.192299] ------------[ cut here ]------------
[  144.194026] WARNING: CPU: 10 PID: 2689 at kernel/trace/trace_dynevent.h:82 user_event_parse_cmd+0x972/0xa00
[  144.196850] Modules linked in:
[  144.197836] CPU: 10 PID: 2689 Comm: example Not tainted 5.17.0+ #269
[  144.199805] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[  144.202303] RIP: 0010:user_event_parse_cmd+0x972/0xa00
[  144.203899] Code: 48 00 00 00 00 e9 cf f8 ff ff 41 bf f4 ff ff ff e9 3a f7 ff ff be ff ff ff ff 48 c7 c7 08 bb f7 8a e8 b2 05 de 00 85 c0 75 02 <0f> 0b 48 83 bb 30 01 00 00 00 0f 84 54 fa ff ff e9 25 fa ff ff 48
[  144.209398] RSP: 0018:ffffb6264b87be10 EFLAGS: 00010246
[  144.211098] RAX: 0000000000000000 RBX: ffff9c3045cb7c00 RCX: 0000000000000001
[  144.213314] RDX: 0000000000000000 RSI: ffffffff8aa2d11e RDI: ffffffff8aac2f16
[  144.215577] RBP: ffff9c3045cb7d20 R08: 0000000000000001 R09: 0000000000000001
[  144.217723] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000011
[  144.221511] R13: ffffb6264b87bea8 R14: 000000000000000c R15: 0000000000000000
[  144.223760] FS:  00007ff6d10e54c0(0000) GS:ffff9c3627a80000(0000) knlGS:0000000000000000
[  144.226364] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  144.228203] CR2: 00007ff6d0b16a80 CR3: 00000006530ae004 CR4: 00000000001706e0
[  144.230349] Call Trace:
[  144.231307]  <TASK>
[  144.232140]  ? _copy_from_user+0x68/0xa0
[  144.233534]  user_events_ioctl+0xfe/0x4d0
[  144.234980]  __x64_sys_ioctl+0x8e/0xd0
[  144.236268]  ? lockdep_hardirqs_on+0x7d/0x100
[  144.237771]  do_syscall_64+0x3a/0x80
[  144.239036]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  144.240696] RIP: 0033:0x7ff6d0b16217
[  144.241938] Code: b3 66 90 48 8b 05 71 4c 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4c 2d 00 f7 d8 64 89 01 48
[  144.247797] RSP: 002b:00007ffce19eb3b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  144.252578] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff6d0b16217
[  144.254897] RDX: 00007ffce19eb3e0 RSI: 00000000c0082a00 RDI: 0000000000000003
[  144.257162] RBP: 00007ffce19eb400 R08: 0000000000000003 R09: 0000000000000000
[  144.259487] R10: 0000000000000000 R11: 0000000000000246 R12: 000056095fe00820
[  144.261817] R13: 00007ffce19eb550 R14: 0000000000000000 R15: 0000000000000000
[  144.264135]  </TASK>
[  144.264980] irq event stamp: 4515
[  144.266162] hardirqs last  enabled at (4523): [<ffffffff8916ab2e>] __up_console_sem+0x5e/0x70
[  144.268987] hardirqs last disabled at (4532): [<ffffffff8916ab13>] __up_console_sem+0x43/0x70
[  144.271739] softirqs last  enabled at (4390): [<ffffffff8a400361>] __do_softirq+0x361/0x4a8
[  144.274480] softirqs last disabled at (4385): [<ffffffff890e7554>] irq_exit_rcu+0x104/0x120
[  144.277220] ---[ end trace 0000000000000000 ]---


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
