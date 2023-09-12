Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C4B79C249
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 04:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjILCIN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 22:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239366AbjILCDL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 22:03:11 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7215FF4
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 18:34:35 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26d52dc97e3so6051214a91.2
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 18:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694482475; x=1695087275;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99pQarvPvV1vI/NZ6ucA6oInnil7+zjro6ya8tjs7F0=;
        b=LGCbDep6h/N2SbyJMx41OAaNiEqpNYs3uJCNDaZA2ZEV4+7C1hisOvt9vmJ+eg3Rt7
         +V1xuCyrZTOfdBaxzelxzrXGDSDbVJjk1t9Z7loWjBJef896Y25EDbUVpOjtTVB1VI3U
         eGRf3m6IqSRtyXxGc4X4IGsNdljgds++EopF2egbs1UoQDYwUGFt+xUIpjYEDoKp85eh
         sNKzS5YpAGrevw6kKgphrYqj6XLgt/lbqbZzWLorkEHE/9exVCUsyGwIC9JAwUOXKcLA
         l5dYyiQ1HsYnIsE0GDMJEFU/Ci25UxBx4UGvRl4ROPvAlgo3vRrTxWKUc7ysQyEpLo0+
         h7xg==
X-Gm-Message-State: AOJu0Yz/nZ2WNEQcI8Dp1v/x2n17vx8mYpcFgeSFIWUfjY+rI3819Dwa
        IsxRUqepF5pe0QlX1bw1Y6daxi3fwzzuKgkMhnOvZhCBBhc6
X-Google-Smtp-Source: AGHT+IG/uk4ab+/o9mpNiJ736IHnt52ha05CAPfdJJp8V9PvPQM77+mhbrRmd2FHH0Pcu4/Cy1TV/hBfNSQjDknGsfqZNtweOeZj
MIME-Version: 1.0
X-Received: by 2002:a17:90a:e647:b0:262:ffa8:f49d with SMTP id
 ep7-20020a17090ae64700b00262ffa8f49dmr2924273pjb.9.1694482475506; Mon, 11 Sep
 2023 18:34:35 -0700 (PDT)
Date:   Mon, 11 Sep 2023 18:34:35 -0700
In-Reply-To: <0000000000003afcb4060135a664@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007e38806051f72e2@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in arch_tlbbatch_flush
From:   syzbot <syzbot+5759bce381cb6f9c51fa@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        apopple@nvidia.com, arnd@arndb.de, bgray@linux.ibm.com,
        bp@alien8.de, catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

syzbot has bisected this issue to:

commit 75c400f82d347af1307010a3e06f3aa5d831d995
Author: Alistair Popple <apopple@nvidia.com>
Date:   Wed Jul 19 12:18:44 2023 +0000

    mmu_notifiers: call invalidate_range() when invalidating TLBs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bd6d0c680000
start commit:   c58c49dd8932 Add linux-next specific files for 20230720
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16bd6d0c680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12bd6d0c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27d64413bce3a1d8
dashboard link: https://syzkaller.appspot.com/bug?extid=5759bce381cb6f9c51fa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f484ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e4a4e6a80000

Reported-by: syzbot+5759bce381cb6f9c51fa@syzkaller.appspotmail.com
Fixes: 75c400f82d34 ("mmu_notifiers: call invalidate_range() when invalidating TLBs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
