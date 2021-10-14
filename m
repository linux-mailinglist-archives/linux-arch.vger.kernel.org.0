Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF22542D8B9
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhJNMFI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhJNMFH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 08:05:07 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD4C061570;
        Thu, 14 Oct 2021 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LQbu81zuvorNbNl7md+JgKHR7v/3E2/nFaDHpBUMKHE=; b=K+VqEeAQrYdM6TmqnvgqR8nQZ2
        NUVGVVdJOKwbDDGJLr2XaNah8D3QzuwIEiRxNHZTCkRVBNPcsYGoyUwvsSFUkI26FQ57xybfxRkBr
        xIKCPhafKP5jWU8T3MrrEwNDfJlZ9qcmPxjI6L5P1Fyyd6l7J+c0+vDz8E4JQB8gBWwekKorq1TPB
        mTkG7hJstKx4fg034oRxe7rWHPayvwIpCm8kaC3EoNrDKi410bqJjM+2qNJuGSsLX8FJgTReiQ0Ke
        nvz5uY+7YlYlxuOcmgx+88lfZbqgtns6SWmoBoNUKgfH5gijloXLdNXfI3Cl4FyDKOoCE2NzAHUpf
        +RdYfERQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55094)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mazRg-0001Ib-Rt; Thu, 14 Oct 2021 13:02:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mazRS-00028C-K9; Thu, 14 Oct 2021 13:02:34 +0100
Date:   Thu, 14 Oct 2021 13:02:34 +0100
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
Message-ID: <YWgcWnbsvI1rbvEj@shell.armlinux.org.uk>
References: <20211008111527.438276127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008111527.438276127@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021 at 01:15:27PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> This fixes up wchan which is various degrees of broken across the
> architectures.
> 
> Patch 4 fixes wchan for x86, which has been returning 0 for the past many
> releases.
> 
> Patch 5 fixes the fundamental race against scheduling.
> 
> Patch 6 deletes a lot and makes STACKTRACE unconditional
> 
> patch 7 fixes up a few STACKTRACE arch oddities
> 
> 0day says all builds are good, so it must be perfect :-) I'm planning on
> queueing up at least the first 5 patches, but I'm hoping the last two patches
> can be too.
> 
> Also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wchan

These patches introduce a regression on ARM. Whereas before, I have
/proc/*/wchan populated with non-zero values, with these patches they
_all_ contain "0":

root@clearfog21:~# cat /proc/*/wchan
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000root@clearfog21:~#

I'll try to investigate what is going on later today.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
