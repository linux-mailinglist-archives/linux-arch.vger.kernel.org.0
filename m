Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAB3A8D6A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 02:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhFPAZ6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 20:25:58 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39478 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhFPAZy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 20:25:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2FF9D2BAEC;
        Tue, 15 Jun 2021 20:23:43 -0400 (EDT)
Date:   Wed, 16 Jun 2021 10:23:41 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Schmitz <schmitzmic@gmail.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
In-Reply-To: <7277aa4b-5d3f-6bb3-379a-470df4addd15@gmail.com>
Message-ID: <87a5aca-e968-a1b6-e7e8-76ea2c418314@linux-m68k.org>
References: <87sg1p30a1.fsf@disp2133> <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com> <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com> <87sg1lwhvm.fsf@disp2133>
 <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com> <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com> <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
 <7277aa4b-5d3f-6bb3-379a-470df4addd15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 16 Jun 2021, Michael Schmitz wrote:

> > 
> > Do you happen to know if there is userspace that will run in 
> > qemu-system-m68k that can be used for testing?
> 
> I surmise so. I don't use qemu myself - either ARAnyM, or actual 
> hardware. Hardware is limited to 14 MB RAM, which has prevented me from 
> using more than simple regression testing. In particular, I can't test 
> sys_io_uring_setup there.
> 
> Adrian uses qemu a lot, and has supplied disk images to work from on 
> occasion. Maybe he's got something recent enough to support 
> sys_io_uring_setup ... I've CC:ed him in, as I'd love to do some more 
> testing as well.
> 

As well as Debian/m68k, there is also a Gentoo/m68k stage3 rootfs 
available here: 
https://sourceforge.net/projects/linux-mac68k/files/Gentoo%20m68k%20unauthorized/

I built that rootfs last year using Catalyst. Some background (including 
the qemu-system-m68k command-line) can be found here:
https://forums.gentoo.org/viewtopic-t-1100780.html
