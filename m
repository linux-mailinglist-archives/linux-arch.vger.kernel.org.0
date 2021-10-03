Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA341FF45
	for <lists+linux-arch@lfdr.de>; Sun,  3 Oct 2021 04:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJCCwT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 22:52:19 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:41542 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJCCwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 22:52:18 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWrXy-009Wzm-I7; Sun, 03 Oct 2021 02:48:14 +0000
Date:   Sun, 3 Oct 2021 02:48:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V4 11/22] LoongArch: Add process management
Message-ID: <YVkZ7jLWJpvZz9us@zeniv-ca.linux.org.uk>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-12-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927064300.624279-12-chenhuacai@loongson.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 27, 2021 at 02:42:48PM +0800, Huacai Chen wrote:

> +/*
> + * Does the process account for user or for system time?
> + */
> +#define user_mode(regs) (((regs)->csr_prmd & PLV_MASK) == PLV_USER)
> +
> +static inline int is_syscall_success(struct pt_regs *regs)
> +{
> +	return !regs->regs[7];
> +}
>
> +static inline long regs_return_value(struct pt_regs *regs)
> +{
> +	if (is_syscall_success(regs) || !user_mode(regs))
> +		return regs->regs[4];
> +	else
> +		return -regs->regs[4];
> +}

Huh???  That looks like you've copied those from MIPS, but on MIPS we have
things like
        li      t0, -EMAXERRNO - 1      # error?
        sltu    t0, t0, v0
        sd      t0, PT_R7(sp)           # set error flag
        beqz    t0, 1f

        ld      t1, PT_R2(sp)           # syscall number
        dnegu   v0                      # error
        sd      t1, PT_R0(sp)           # save it for syscall restarting
1:      sd      v0, PT_R2(sp)           # result
right after the call of sys_...(), along with the restart logics
looking like
        if (regs->regs[0]) {
                switch(regs->regs[2]) {
                case ERESTART_RESTARTBLOCK:
                case ERESTARTNOHAND:
IOW, syscall return values from -EMAXERRNO to -1 are negated, with
regs[7] set accordingly.  Nothing of that sort is done in your
patchset after syscall, and if it had been, your restart logics in
signal handling would've been wrong anyway.

What's going on there?
