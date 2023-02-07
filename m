Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8168DC14
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjBGOuZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 09:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjBGOuY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 09:50:24 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19272118
        for <linux-arch@vger.kernel.org>; Tue,  7 Feb 2023 06:50:22 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id h2-20020a92c262000000b00313b8b647ceso5957756ild.15
        for <linux-arch@vger.kernel.org>; Tue, 07 Feb 2023 06:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3BVpFeHZ4lGXaf3B9wqQOSFxEjUFqOh7/UypgMatbI=;
        b=hx3ESxuWsDxqG/kcaQhRWbAPCvHm5nnNQ8kx9D6Fw32286xJBNh8uKmPfqVhXuuBvG
         ih0F9mq4zPbM+/XHylfrjg5FVZ+T2LZ6qgMGSoKYaiGdqKneP5bDKjx/XJNdBUlkg+ul
         26pG2YT0Y4c1ZyHSl7MFpt4CRP0BYM5mpDhQW5AHnAPTnBEMXGMHPzYqi2kH+xq8dx73
         NMnfZDLaLkX7NI70akhAs/R0eKwzfqRKNLhyTS2rmFRJ3vUx59cZ0W+ryn5MbnshiHDB
         MLYP7ubDwNhINv1K5ucc8ikv9OmTrOYlA46wGxfFzTZB/NUx+MJ1JLRFvkWdcU0+rvKW
         HF6w==
X-Gm-Message-State: AO0yUKXQTj0CVL32ZyD00BLk0cVcNLoiZ+Le5oiwppYFtIYVLUSYLVJz
        +AQ6HTjqUjBiiHo4ScXhdnIAZyknHD4Q0tz+gBD8UxdLk2vp
X-Google-Smtp-Source: AK7set8pvWEhKgCAbGbH6gZM/EsmYg8BlGseGJ+RzL9CS0ajuddu+7+EUE4zu40NEaK6+tsBcKGO2IvIgNwqkmaLOCbuRIkcNeWA
MIME-Version: 1.0
X-Received: by 2002:a02:8815:0:b0:3be:9943:54f5 with SMTP id
 r21-20020a028815000000b003be994354f5mr2385849jai.84.1675781422218; Tue, 07
 Feb 2023 06:50:22 -0800 (PST)
Date:   Tue, 07 Feb 2023 06:50:22 -0800
In-Reply-To: <3151684.1675779419@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064832d05f41d44e4@google.com>
Subject: Re: [syzbot] kernel BUG in process_one_work
From:   syzbot <syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        bpf@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com,
        edumazet@google.com, hch@lst.de, jhubbard@nvidia.com,
        kuba@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, npiggin@gmail.com, pabeni@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com

Tested on:

commit:         fab9eebf iov_iter: Kill ITER_PIPE
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/ iov-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1529647b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=facc234423e66dc6
dashboard link: https://syzkaller.appspot.com/bug?extid=c0998868487c1f7e05e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
