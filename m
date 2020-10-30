Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380182A0BCC
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 17:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgJ3Qxp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3Qxp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Oct 2020 12:53:45 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EC0C0613CF;
        Fri, 30 Oct 2020 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KEeA33OEqDGWbAtgRNQqJFf7DgtZxfBU7JaReRDm16k=; b=jX3FXm1XC8wFy0ppOFkRv0VZg
        S/xciqwX5i4N+Lb7KH1fWrhIUHgt+d8DdDmlJ1tX5644PUSgZ+NHLdh6K0IaR4IHPTQ5eyGe/SV44
        eEA4Sz7tvDIvBgMj6t2nocefChfW3EP3RX/x2Ch/f05gnqOtRAmPyLFjHBySJx6LZtcsJfixpP/04
        vbftM9PvBzSxTYvr2a3H2GzWPOd6JBffM9umOGDmEgptm6jukqAoSIbCllqnhfKs8283efkI6tcMh
        LMF2s9QxgP7W/VKypWL/4AJ3OoYBqk9ceaTWO4dukcWLCV+D5FJBA9iWz9hW5J7L9chX3TfkUM20O
        3/N2Sf7mg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52960)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kYXem-0006Ot-8l; Fri, 30 Oct 2020 16:53:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kYXel-0007KL-3L; Fri, 30 Oct 2020 16:53:39 +0000
Date:   Fri, 30 Oct 2020 16:53:39 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        linus.walleij@linaro.org, arnd@arndb.de
Subject: Re: [PATCH 4/9] ARM: syscall: always store thread_info->syscall
Message-ID: <20201030165338.GG1551@shell.armlinux.org.uk>
References: <20201030154519.1245983-1-arnd@kernel.org>
 <20201030154919.1246645-1-arnd@kernel.org>
 <20201030154919.1246645-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030154919.1246645-4-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30, 2020 at 04:49:14PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The system call number is used in a a couple of places, in particular
> ptrace, seccomp and /proc/<pid>/syscall.
> 
> The last one apparently never worked reliably on ARM for tasks
> that are not currently getting traced.
> 
> Storing the syscall number in the normal entry path makes it work,
> as well as allowing us to see if the current system call is for
> OABI compat mode, which is the next thing I want to hook into.

I'm not sure this patch is correct.

Tracing the existing code for OABI:

asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
{
        current_thread_info()->syscall = scno;

        /* Legacy ABI only. */
USER(	ldr     scno, [saved_pc, #-4]   )       @ get SWI instruction
	bic     scno, scno, #0xff000000         @ mask off SWI op-code
	eor     scno, scno, #__NR_SYSCALL_BASE  @ check OS number
	tst     r10, #_TIF_SYSCALL_WORK         @ are we tracing syscalls?
	bne     __sys_trace

__sys_trace:
	mov     r1, scno
	add     r0, sp, #S_OFF
	bl      syscall_trace_enter

So, thread_info->syscall does not include __NR_SYSCALL_BASE. The
reason for this is the code that makes use of that via syscall_get_nr().
kernel/trace/trace_syscalls.c:

	syscall_nr = trace_get_syscall_nr(current, regs);
	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
		return;

and NR_syscalls is the number of syscalls, which doesn't include the
__NR_SYSCALL_BASE offset.

So, I think this patch actually breaks OABI.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
