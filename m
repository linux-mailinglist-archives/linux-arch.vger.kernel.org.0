Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C543D41FF38
	for <lists+linux-arch@lfdr.de>; Sun,  3 Oct 2021 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhJCChy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 22:37:54 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:41396 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJCChx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 22:37:53 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWrFZ-009Wlr-Ea; Sun, 03 Oct 2021 02:29:13 +0000
Date:   Sun, 3 Oct 2021 02:29:13 +0000
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH V4 14/22] LoongArch: Add signal handling support
Message-ID: <YVkVeREEIy23yVFX@zeniv-ca.linux.org.uk>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-15-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927064300.624279-15-chenhuacai@loongson.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 27, 2021 at 02:42:51PM +0800, Huacai Chen wrote:
> This patch adds signal handling support for LoongArch.

No matter what you get in regs[4] after sys_rt_sigreturn(),
you should *NOT* treat it as restartable.  IOW, you need to set
regs[0] to 0 in there (or in restore_sigcontext()).  See e.g.
653d48b22166 for details of similar bug on arm.
