Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E01BB6E0
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 08:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgD1Gjs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 02:39:48 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:9918 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1Gjr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 02:39:47 -0400
X-Greylist: delayed 137075 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 02:39:46 EDT
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 49BBp91szrzQl1t;
        Tue, 28 Apr 2020 08:39:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id lcNNyXHwjvSI; Tue, 28 Apr 2020 08:39:40 +0200 (CEST)
Date:   Tue, 28 Apr 2020 08:39:35 +0200
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Message-ID: <20200428063935.GA5660@laniakea>
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
 <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
 <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
X-Rspamd-Queue-Id: AA8701754
X-Rspamd-Score: 0.57 / 15.00 / 15.00
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Linus Torvalds | 2020-04-27 21:28:14 [-0700]:

>> I hate to say this, but I’m not convinced that asking the gdb folks is
>> the right approach. GDB has an ancient architecture and is
>> *incredibly* buggy. I’m sure ptrace is somewhere on the pain point
>> list, but I suspect it’s utterly dwarfed by everything else.
>
>You may be right. However, if gdbn isn't going to use it, then I
>seriously don't think it's worth changing much.
>
>It might be worth looking at people who don't use ptrace() for
>debugging, but for "incidental" reasons. IOW sandboxing, tracing,
>things like that.
>
>Maybe those people want things that are simpler and don't actually
>need the kinds of hard serialization that ptrace() wants.
>
>I'd rather add a few really simple things that might not be a full
>complement of operations for a debugger, but exactly because they
>aren't a full debugger, maybe they are things that we can tell are
>obviously secure and simple?

Okay, to sum up the the whole discussion: we go forward with Jann's proposal
by simple adding PTRACE_ATTACH_PIDFD and friends. This is the minimal invasive
solution and the risk of an potenial security problem is almost not present[TM].

Changing the whole ptrace API is a different beast. I rather believe that I
see Linus Linux successor rather than a ptrace successor.

I am fine with PTRACE_ATTACH_PIDFD!

Hagen
