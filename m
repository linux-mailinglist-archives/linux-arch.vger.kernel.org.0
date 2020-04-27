Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC21BAACA
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 19:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgD0RIa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 13:08:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37408 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgD0RIa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 13:08:30 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jT7F6-0005PO-1P; Mon, 27 Apr 2020 17:08:28 +0000
Date:   Mon, 27 Apr 2020 19:08:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Message-ID: <20200427170826.mdklazcrn4xaeafm@wittgenstein>
References: <20200426130100.306246-1-hagen@jauu.net>
 <20200426163430.22743-1-hagen@jauu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200426163430.22743-1-hagen@jauu.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Apr 26, 2020 at 06:34:30PM +0200, Hagen Paul Pfeifer wrote:
> Working on a safety-critical stress testing tool, using ptrace in an
> rather uncommon way (stop, peeking memory, ...) for a bunch of
> applications in an automated way I realized that once opened processes
> where restarted and PIDs recycled.  Resulting in monitoring and
> manipulating the wrong processes.
> 
> With the advent of pidfd we are now able to stick with one stable handle
> to identifying processes exactly. We now have the ability to get this
> race free. Sending signals now works like a charm, next step is to
> extend the functionality also for ptrace.
> 
> API:
>          long pidfd_ptrace(int pidfd, enum __ptrace_request request,
>                            void *addr, void *data, unsigned flags);

I'm in general not opposed to this if there's a clear need for this and
users that are interested. But I think if people really prefer having
this a new syscall then we should probably try to improve on the old
one. Things that come to mind right away without doing a deep review are
replacing the void *addr pointer with a dedicated struct ptract_args or
union ptrace_args and a size argument. If we're not doing something
like this or something more fundamental we can equally well either just
duplicate all enums in the old ptrace syscall and append a _PIDFD to it
where it makes sense.

Christian
