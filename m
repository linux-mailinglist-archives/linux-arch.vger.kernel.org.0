Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B23666FB
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 10:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhDUI3f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 04:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234632AbhDUI3e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Apr 2021 04:29:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82A3D6142C;
        Wed, 21 Apr 2021 08:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618993741;
        bh=PlDQaFaPk/kK/krQ9Bde4x/76KoZ9JGgl7x0Ep6sHVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pO4njqXE6uBEbx7G0wZlpJqd1p67dfNA7DkA542Htbybn2qZOAeINQEBvtbR0yfD+
         +laEtyvzotfzONDY7GUxCcU+DfEaGDwy3pIK4fuPtZtCKsnYphOKhPjJyNP8zbL8i6
         0oJAxKrvFMkrd8JSevVqFzmQA4JD1q2vehc35jNjw/dXeDuMwHScKLsll2gnDWjQtm
         UtjkQCqY0xXSPnYT5heGL8ZZgifqb5n2DWESfobdYjmTtPJAC+6N5wxQhHL+VTfEQ+
         2uvhALFQZNX+3ztsJ/2yAuILymkQUThB6HBxQQcfuP7I9MmRGCkKT5gFlGZPxqLZxb
         AXABIwbNdIhCQ==
Received: by mail-lf1-f54.google.com with SMTP id 4so5769291lfp.11;
        Wed, 21 Apr 2021 01:29:01 -0700 (PDT)
X-Gm-Message-State: AOAM531Af6FekkVT9zBhiW2RGJ7cDxd11/64oYKjJ7rHNRBWWKT0nVuL
        I9bPxOtM7Vj4u02GFn3lnktWAktxZNtckjvx0oQ=
X-Google-Smtp-Source: ABdhPJyLGHbOYUo5kuRuRui9Du9S01mLmss+HOmeO1VcFN20rB5jfa8IKdI3kVIvvkC7cLrIhIA+yBJKbfVJGWJ89/A=
X-Received: by 2002:a19:e34c:: with SMTP id c12mr19212590lfk.555.1618993739734;
 Wed, 21 Apr 2021 01:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <1618925829-90071-1-git-send-email-guoren@kernel.org>
 <1618925829-90071-2-git-send-email-guoren@kernel.org> <CAK8P3a1aNDomNiX7W1USWnmdw1VR21ALX7NvJYGW9LBO+jvA4A@mail.gmail.com>
In-Reply-To: <CAK8P3a1aNDomNiX7W1USWnmdw1VR21ALX7NvJYGW9LBO+jvA4A@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Apr 2021 16:28:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ7LPW7tb-Q+mPVnVbfqUCaBotqOQhwk32N7tr59HZU9A@mail.gmail.com>
Message-ID: <CAJF2gTQ7LPW7tb-Q+mPVnVbfqUCaBotqOQhwk32N7tr59HZU9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] nios2: Cleanup deprecated function strlen_user
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx Arnd,

On Tue, Apr 20, 2021 at 10:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
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
Yes, please take them.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
