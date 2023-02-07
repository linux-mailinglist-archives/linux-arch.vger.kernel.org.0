Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9937B68DBD0
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 15:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBGOkk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 09:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjBGOjZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 09:39:25 -0500
Received: from mail-io1-xd48.google.com (mail-io1-xd48.google.com [IPv6:2607:f8b0:4864:20::d48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE73EFE5
        for <linux-arch@vger.kernel.org>; Tue,  7 Feb 2023 06:37:44 -0800 (PST)
Received: by mail-io1-xd48.google.com with SMTP id z23-20020a6b6517000000b00718172881acso9174609iob.7
        for <linux-arch@vger.kernel.org>; Tue, 07 Feb 2023 06:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHvmkN0/lz5e2uZSzTP0PAhn6qcrEsMnI/EGrNMX6Dc=;
        b=uHQTS0sc8tt8y4mzO3Heun2vwyZHtJww4Sp7SKV2pFAcgQec1My70+r/2WCc304RBe
         XEg3nGLJLfE0zYUBnF0EdjuqMOd4b4x0YqKyHWOr/suu1A6PVkx8ROmwnZEOCMFbGSy4
         236RbdTes9yZ8H0pPldZGzUtUfN2bOq3WpE7V5taxzi7rjSnInwvTMBMVdBZtbHl0Ob9
         +u+bYPGzjDiu2drAcM1NgjgtPA5s/QBStZXbvDHBXNgWiKyUuv6VaVYHBMDRygsvI3B4
         m8UkrwzWtAvBIf5b7+Wttkg7u7TIWBV/H4N0sgJpWJ69ROKnYuwjmS4A6pz26U+v2tvj
         INHA==
X-Gm-Message-State: AO0yUKU5BBWLIOpKviO+theErDABig8UnP1Qns/3xQxPxPkW+bkbz4eG
        CJ3tit6toAQJMh6zmhGg/brGIzIUfiKfz7hGS5/LfrcJGSXz
X-Google-Smtp-Source: AK7set+RDCmQu7vyyueNAp2uziZXT5n6La9Hx5rltbF9uY3E6YW4Ax8bXn5BpYe4GzAoOntIdCxbbbpoWNsfviOgzxqB3qa6V47/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:14c3:b0:310:ce0a:d866 with SMTP id
 o3-20020a056e0214c300b00310ce0ad866mr2462405ilk.23.1675780277262; Tue, 07 Feb
 2023 06:31:17 -0800 (PST)
Date:   Tue, 07 Feb 2023 06:31:17 -0800
In-Reply-To: <3151379.1675779370@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025e37805f41d0049@google.com>
Subject: Re: [syzbot] kernel BUG in __tlb_remove_page_size (2)
From:   syzbot <syzbot+d87dd8e018fd2cc2528b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dhowells@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        npiggin@gmail.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5549 } 2638 jiffies s: 2817 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         fab9eebf iov_iter: Kill ITER_PIPE
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/ iov-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=14e2c6f3480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=facc234423e66dc6
dashboard link: https://syzkaller.appspot.com/bug?extid=d87dd8e018fd2cc2528b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
