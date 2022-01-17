Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6A049097A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 14:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiAQNYe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 08:24:34 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:44289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiAQNYd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 08:24:33 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1YxX-1nBupo2alf-0035sr; Mon, 17 Jan 2022 14:24:31 +0100
Received: by mail-wm1-f48.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso24314402wmc.3;
        Mon, 17 Jan 2022 05:24:31 -0800 (PST)
X-Gm-Message-State: AOAM530S+K8nZjQ6nFaGRCvNnTDitvHffA5wJM+mQxJLOBSsaeyV/96U
        HaiwzEMVWeQQtHLyytgAMFwv08QKifd0jiHqm9w=
X-Google-Smtp-Source: ABdhPJzwoJkEaoGGXnlAvPaP47OezsA8eKcjAxDcOQgtdtF8WLkjuRjpDfLzF+MQZK0bfVBBvZxhMzR2xOsL/ukw3dY=
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr20194084wmk.98.1642425871265;
 Mon, 17 Jan 2022 05:24:31 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-3-ebiederm@xmission.com> <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
 <87tuefwewa.fsf@email.froward.int.ebiederm.org> <YeUjVZX764zLm9/K@infradead.org>
In-Reply-To: <YeUjVZX764zLm9/K@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jan 2022 14:24:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
Message-ID: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
Subject: Re: [PATCH 03/10] exit: Move oops specific logic from do_exit into make_task_dead
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8bIhuw277tfE4HLaWlFOWrJ6rrxuiD9sBkYWBO6XkfVkLUNjvQU
 GhFgiDoRwUfYspdA33XVXAEyoiwpyyIkKMui9XUaBLKAnyjyQW6BGLyfslvGbNxcvlba4PY
 k1t2bLWhYSwomHDO6vxRRbRhRbDGrcLSRH0uf0w/vmOrqE9RrZ93OykSKU8mGK7bT3/UDj8
 NwtiYDKGUR1ZKHhZWzrYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UasFNevNMQQ=:vMmOPlj3KKZvx9gLV8YB9a
 AsWi8f9gXhaNzNxGQYrWpeZXpBUqWZ7kaH/I+5AmaEEE823/KF71N0p7Ff12n2HxxNMQARlse
 A7dz/2SYH2xjZYdNmsD3ZIEloylhMw4TEn8c2SG/XWl/Ll8NSVerCCNVXwPoPo7Q2XxzP+KGq
 kjUDt3v3qk7pM+9IJfvC1WizbhA1DnySzYcH/9MvgcvF1Qd7Sdp46Ai9D4PC2VM6jTQAKjb+g
 p2VwrbCkpkQSTISKOf/wxZCnQTsd4FIUjYrGUCQuAsWDTPHQvrucNkCQ+yvG2ZtdTMex01ym9
 2ftMeGfJpW5qc8AubWxm5RIMMpnosa6eq2PdPVkR7MT0hRANoqnIAiKGqteZ67uPwCuNr1Li3
 X0XPPUvP+kea6Mq1O8IBTU2jSnp2h/4mLpA+VZLfT5wJ1cpEBDjSTN7RCEKvzctdMOWrFFH44
 +Eua5+N7L/bA7K05W0RPu9l1Rl6kX3O2r/7CO5RKjVzNEzXriazNA5rUr8YzTa2O3Jviz8cct
 qMz6ItOl9gPwjpti3MnJxYx4ZLitEAvTp0yKSJteAcmVXEqt1SsxgFuYutvHr8LwFTHQOvwLq
 DBaKqHJ2P4SO0aSMBPNIu6FkLEK4/YoN+ZB7iQTOOGIlMighbe7hbN2B+yEcs5f1leT9dZb7E
 u+bsxhBZtuy57vCedwgz8CZMOj5K0/6E0Zw2MN5qAh8fuh6GZX93UrfQ92iBID6iKNlo=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 17, 2022 at 9:05 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jan 07, 2022 at 12:59:33PM -0600, Eric W. Biederman wrote:
> > Assuming it won't be too much longer before the rest of the arches have
> > set_fs/get_fs removed it looks like it makes sense to leave the
> > force_uaccess_begin where it is, and just let force_uaccess_begin be
> > removed when set_fs/get_fs are removed from the tree.
> >
> > Christoph does it look like the set_fs/get_fs removal work is going
> > to stall indefinitely on some architectures?  If so I think we want to
> > find a way to get kernel threads to run with set_fs(USER_DS) on the
> > stalled architectures.  Otherwise I think we have a real hazard of
> > introducing bugs that will only show up on the stalled architectures.
>
> I really need help from the arch maintainers to finish the set_fs
> removal.  There have been very few arch maintainers helping with that
> work (arm, arm64, parisc, m68k) in addition to the ones I did because
> I have the test setups and knowledge.  I'll send out another ping,
> for necrotic architectures like ia64 and sh I have very little hope.

I did a conversion of microblaze for fun at some point, and I think I never
sent that out. I haven't tested it, but if this looks correct to you and
Michal, it could serve as a model for other trivial conversions.

I also looked into converting ia64 and sh at the same time, but I can't
find those patches now, so I think they were never complete.

       Arnd
