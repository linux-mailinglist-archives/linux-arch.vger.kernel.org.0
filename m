Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB5E365B74
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhDTOuZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Apr 2021 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhDTOuX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Apr 2021 10:50:23 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B981C06174A;
        Tue, 20 Apr 2021 07:49:51 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYrh8-006oXm-Sg; Tue, 20 Apr 2021 14:49:43 +0000
Date:   Tue, 20 Apr 2021 14:49:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 2/3] nios2: Cleanup deprecated function strlen_user
Message-ID: <YH7qBjuC4UIfwE8X@zeniv-ca.linux.org.uk>
References: <1618925829-90071-1-git-send-email-guoren@kernel.org>
 <1618925829-90071-2-git-send-email-guoren@kernel.org>
 <CAK8P3a1aNDomNiX7W1USWnmdw1VR21ALX7NvJYGW9LBO+jvA4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1aNDomNiX7W1USWnmdw1VR21ALX7NvJYGW9LBO+jvA4A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 20, 2021 at 04:32:33PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 20, 2021 at 3:37 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > $ grep strlen_user * -r
> > arch/csky/include/asm/uaccess.h:#define strlen_user(str) strnlen_user(str, 32767)
> > arch/csky/lib/usercopy.c: * strlen_user: - Get the size of a string in user space.
> > arch/ia64/lib/strlen.S: // Please note that in the case of strlen() as opposed to strlen_user()
> > arch/mips/lib/strnlen_user.S: *  make strlen_user and strnlen_user access the first few KSEG0
> > arch/nds32/include/asm/uaccess.h:extern __must_check long strlen_user(const char __user * str);
> > arch/nios2/include/asm/uaccess.h:extern __must_check long strlen_user(const char __user *str);
> > arch/riscv/include/asm/uaccess.h:extern long __must_check strlen_user(const char __user *str);
> > kernel/trace/trace_probe_tmpl.h:static nokprobe_inline int fetch_store_strlen_user(unsigned long addr);
> > kernel/trace/trace_probe_tmpl.h:                        ret += fetch_store_strlen_user(val + code->offset);
> > kernel/trace/trace_uprobe.c:fetch_store_strlen_user(unsigned long addr)
> > kernel/trace/trace_kprobe.c:fetch_store_strlen_user(unsigned long addr)
> > kernel/trace/trace_kprobe.c:            return fetch_store_strlen_user(addr);
> 
> I would suggest using "grep strlen_user * -rw", to let the whole-word match
> filter out the irrelevant ones for the changelog.
> 
> > See grep result, nobody uses it.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> All three patches
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Do you want me to pick them up in the asm-generic tree?

Might make sense to check -next from time to time...  See
a0d8d552783b "whack-a-mole: kill strlen_user() (again)" in there
