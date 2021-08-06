Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F8C3E31A3
	for <lists+linux-arch@lfdr.de>; Sat,  7 Aug 2021 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbhHFWUX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 6 Aug 2021 18:20:23 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53843 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhHFWUX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Aug 2021 18:20:23 -0400
Received: by mail-io1-f71.google.com with SMTP id w3-20020a0566020343b02905393057ad92so6982689iou.20
        for <linux-arch@vger.kernel.org>; Fri, 06 Aug 2021 15:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=TjZwUUDBCQTtiiphMf5lNNvkaUWGIfnKKUGZRCHod4s=;
        b=R/RuUxIvEbSkQaTYKntIjgFTq07NcaVjZDn43jlKb/P1lWoM9+/thY+YyEDU0JvO/v
         s9CxQzp153BhJx1BFxD3+YqD9I+xwJ5CYF9R+dZq55n5elnWkfUPBiDtuAgjPzOwInYV
         6Tn0uZ6U39hvbGziV0EMz177ik9ZlFPDQ1fOf5iA1FOdShDtfoGKxALXkPbxA1JzVaCb
         kKiae4DGjCshAkrVyLDJCPmWCr3kj8Kmtv+1xbjsQhrweSobqXo9yTIGYlZro8NO1E0F
         TeedDioguGoe61l7jmWbLvsKqCCPvUyOFCT6rZAn2lND5rHf2POEzx3nz1J6xBIrvPil
         J0nA==
X-Gm-Message-State: AOAM5322WEJecgXUsIzO9tY7TSHazRiyMvXFXME4P0Ey0CSivr2kZ02h
        VgU4tEzT+53tbrxxMfSw5RqeBfOimnQVuFavmyPPZaMB7Id5
X-Google-Smtp-Source: ABdhPJzpIVDaCuynJVK3t71sYw7TX40yeX/4nyImc7KlRSQjfeTEFmrDpDfvonESvtNNCm06n335BFZZQFgOc40sQxqK3J4I4gE0
MIME-Version: 1.0
X-Received: by 2002:a92:c266:: with SMTP id h6mr517881ild.273.1628288406528;
 Fri, 06 Aug 2021 15:20:06 -0700 (PDT)
Date:   Fri, 06 Aug 2021 15:20:06 -0700
In-Reply-To: <000000000000b8a3e905c69535e3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000102b9305c8eb70da@google.com>
Subject: Re: [syzbot] kernel BUG in __tlb_remove_page_size
From:   syzbot <syzbot+2f816ba9b71ca9a8e6b0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org,
        aneesh.kumar@linux.ibm.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, npiggin@gmail.com, peterz@infradead.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        toke@redhat.com, will@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit af0efa050caa66e8f304c42c94c76cb6c480cb7e
Author: Toke Høiland-Jørgensen <toke@redhat.com>
Date:   Tue Jul 6 12:23:55 2021 +0000

    libbpf: Restore errno return for functions that were already returning it

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b872fa300000
start commit:   3dbdb38e2869 Merge branch 'for-5.14' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=2f816ba9b71ca9a8e6b0
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151ee572300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: libbpf: Restore errno return for functions that were already returning it

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
