Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49CF1C04
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 18:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfKFRCs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 12:02:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44842 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfKFRCr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 12:02:47 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSOhf-0000Cr-9F; Wed, 06 Nov 2019 18:02:43 +0100
Date:   Wed, 6 Nov 2019 18:02:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mohammad Nasirifar <far.nasiri.m@gmail.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mohammad Nasirifar <farnasirim@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Subject: Re: [PATCH 1/1] syscalls: Fix references to filenames containing
 syscall defs
In-Reply-To: <20191106164756.GA558585@gmail.com>
Message-ID: <alpine.DEB.2.21.1911061755060.1869@nanos.tec.linutronix.de>
References: <20191105022928.517526-1-farnasirim@gmail.com> <alpine.DEB.2.21.1911051033050.17054@nanos.tec.linutronix.de> <CAK8P3a0wyw=CwhiU34t1zBiSesf+HGBLeaV+=JVko_TjnvATHQ@mail.gmail.com> <20191106164756.GA558585@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 6 Nov 2019, Mohammad Nasirifar wrote:

> On Tue, Nov 05, 2019 at 10:49:12AM +0100, Arnd Bergmann wrote:
> > On Tue, Nov 5, 2019 at 10:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Mon, 4 Nov 2019, Mohammad Nasirifar wrote:
> > > > Fix stale references to files containing syscall definitions in
> > > > 'include/linux/syscalls.h' and 'include/uapi/asm-generic/unistd.h',
> > > > pointing to 'kernel/itimer.c', 'kernel/hrtimer.c', and 'kernel/time.c'.
> > > > They are now under 'kernel/time'.
> > > >
> > > > Also definitions of 'getpid', 'getppid', 'getuid', 'geteuid', 'getgid',
> > > > 'getegid', 'gettid', and 'sysinfo' are now in 'kernel/sys.c'.
> > > 
> > > Can we please remove these file references completely. They are going
> > > to be stale sooner than later again and they really do not provide
> > > any value.
>
> I actually refer to them a lot when locating syscall implementations,
> which is how I found out that they were stale in the first place.

# git grep -n 'SYSCALL.*(nanosleep'

kernel/time/hrtimer.c:1945:SYSCALL_DEFINE2(nanosleep, struct ...
kernel/time/hrtimer.c:1965:SYSCALL_DEFINE2(nanosleep_time32, struct ...

Gives you the always correct answer including the line number.

So there is really no value in keeping those file references and have them
outdated once a function or a file moves. It's just matter of fact that
nobody ever fixes them up when a function or a file moves. Why? Because
they have no connection. The compiler does not complain and there are no
tools which could ever validate them. So removing them is the right thing
to do.

Thanks,

	tglx
