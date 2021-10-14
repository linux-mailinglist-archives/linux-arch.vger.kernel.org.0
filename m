Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85742DA9D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJNNkz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 09:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJNNky (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 09:40:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0EDC061570;
        Thu, 14 Oct 2021 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HWqNRH4pgw0HjVJuPYKRAMq24ZY1u+MmeLlY73dlskY=; b=GdhF8aAHI2tg4ayb0fZ00QGb+4
        qkvEWQ/MF3GGTDDkZKtnCQ+1inWmvXLiLhP93/1CWSoiSfpoWxdrvJwcyLVuebjtnigAP3uzZzEJ8
        cszr+VlIlq6dojhDWb8cViF8LrRRGPhb3JmgTcuUbLVeDAtR2oqnovGjOEV2nvyA79tZZA40CxYfk
        cfNQwwDmN1PX/wkG5HvfnPQE0QgSztfI0aS4EP6owv5wEZW85DEemsHkA2k6oK+G8srqzWQzxABX9
        eNtFJuV21+rhtyNSiZvbBTCJoLZxuBJJX4oPIaQFug6pbJvufsa9Yi2+UpXf4uxWfNxMGvP83/pBa
        1Ws0aQHQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55096)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mb0wL-0001O4-N8; Thu, 14 Oct 2021 14:38:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mb0w7-0002BL-Qz; Thu, 14 Oct 2021 14:38:19 +0100
Date:   Thu, 14 Oct 2021 14:38:19 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, jannh@google.com,
        linux-kernel@vger.kernel.org, vcaputo@pengaru.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        mark.rutland@arm.com, axboe@kernel.dk, metze@samba.org,
        laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, jonas@southpole.se, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, hca@linux.ibm.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, chris@zankel.net
Subject: Re: [PATCH 0/7] wchan: Fix wchan support
Message-ID: <YWgyy+KvNLQ7eMIV@shell.armlinux.org.uk>
References: <20211008111527.438276127@infradead.org>
 <YWgcWnbsvI1rbvEj@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWgcWnbsvI1rbvEj@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 01:02:34PM +0100, Russell King (Oracle) wrote:
> On Fri, Oct 08, 2021 at 01:15:27PM +0200, Peter Zijlstra wrote:
> > Hi,
> > 
> > This fixes up wchan which is various degrees of broken across the
> > architectures.
> > 
> > Patch 4 fixes wchan for x86, which has been returning 0 for the past many
> > releases.
> > 
> > Patch 5 fixes the fundamental race against scheduling.
> > 
> > Patch 6 deletes a lot and makes STACKTRACE unconditional
> > 
> > patch 7 fixes up a few STACKTRACE arch oddities
> > 
> > 0day says all builds are good, so it must be perfect :-) I'm planning on
> > queueing up at least the first 5 patches, but I'm hoping the last two patches
> > can be too.
> > 
> > Also available here:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wchan
> 
> These patches introduce a regression on ARM. Whereas before, I have
> /proc/*/wchan populated with non-zero values, with these patches they
> _all_ contain "0":
> 
> root@clearfog21:~# cat /proc/*/wchan
> 0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000root@clearfog21:~#
> 
> I'll try to investigate what is going on later today.

What is going on here is that the ARM stacktrace code refuses to trace
non-current tasks in a SMP environment due to the racy nature of doing
so if the non-current tasks are running.

When walking the stack with frame pointers, we:

- validate that the frame pointer is between the stack pointer and the
  top of stack defined by that stack pointer.
- we then load the next stack pointer and next frame pointer from the
  stack.

The reason this is unsafe when the task is not blocked is the stack can
change at any moment, which can cause the value read as a stack pointer
to be wildly different. If the read frame pointer value is roughly in
agreement, we can end up reading any part of memory, which would be an
information leak.

The table based unwinding is much more complex being essentially a set
of instructions to the unwinder code about which values to read from
the stack into a set of pseudo-registers, corrections to the stack
pointer, or transfers from the pseudo-registers. I haven't analysed
this code enough to really know the implications of what could be
possible if the values on the stack change while this code is running
on another CPU (it's not my code!) There is an attempt to bounds-limit
the virtual stack pointer after each unwind instruction is processed
to catch the unwinder doing anything silly, so it may be safe in so far
as it will fail should it encounter anything "stupid".

However, get_wchan() is a different case; we know for certain that the
task is blocked, so it won't be running on another CPU, and with your
patch 4, we have this guarantee. However, that is not true of all
callers to the stacktracing code, so I don't see how we can sanely
switch to using the stacktracing code for this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
