Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34571BB7EE
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 09:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD1HpT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 03:45:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33576 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgD1HpT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 03:45:19 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jTKvQ-00077O-8t; Tue, 28 Apr 2020 07:45:04 +0000
Date:   Tue, 28 Apr 2020 09:45:02 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
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
Message-ID: <20200428074502.ruqlxqqgnoyqvhwv@wittgenstein>
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
 <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
 <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
 <20200428063935.GA5660@laniakea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428063935.GA5660@laniakea>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 28, 2020 at 08:39:35AM +0200, Hagen Paul Pfeifer wrote:
> * Linus Torvalds | 2020-04-27 21:28:14 [-0700]:
> 
> >> I hate to say this, but I’m not convinced that asking the gdb folks is
> >> the right approach. GDB has an ancient architecture and is
> >> *incredibly* buggy. I’m sure ptrace is somewhere on the pain point
> >> list, but I suspect it’s utterly dwarfed by everything else.
> >
> >You may be right. However, if gdbn isn't going to use it, then I
> >seriously don't think it's worth changing much.
> >
> >It might be worth looking at people who don't use ptrace() for
> >debugging, but for "incidental" reasons. IOW sandboxing, tracing,
> >things like that.
> >
> >Maybe those people want things that are simpler and don't actually
> >need the kinds of hard serialization that ptrace() wants.
> >
> >I'd rather add a few really simple things that might not be a full
> >complement of operations for a debugger, but exactly because they
> >aren't a full debugger, maybe they are things that we can tell are
> >obviously secure and simple?
> 
> Okay, to sum up the the whole discussion: we go forward with Jann's proposal
> by simple adding PTRACE_ATTACH_PIDFD and friends. This is the minimal invasive
> solution and the risk of an potenial security problem is almost not present[TM].
> 
> Changing the whole ptrace API is a different beast. I rather believe that I
> see Linus Linux successor rather than a ptrace successor.
> 
> I am fine with PTRACE_ATTACH_PIDFD!

If this is enough for you use-case then we should make due with my
initial suggestion, yes. I'd be fine with adding this variant.

I initially thought that we'd likely would need to support a few more
but I don't think we want to actually; there's a bunch of crazy stuff in
there.

Christian
