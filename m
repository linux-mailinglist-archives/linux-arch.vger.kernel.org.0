Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970B84E3B7
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFUJiJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:38:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33086 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJiJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2019 05:38:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so3963560qkc.0;
        Fri, 21 Jun 2019 02:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FEpr/HTFcZTm84CTGTRQ7vot2qZMrXbzR3E1H7td1Y=;
        b=SJlqq79/sQy4z1pGNEszIyefch+9nPWjNa5pIvVOv5cpZN39HPRWrK7gbrkt5cPU5D
         SEIM1rHI+caxqklyXGVnu/pTwQ62Xz6REbk3xPJgRSVLG5sMULj0K3IKqXsgjMZ+ENby
         ehMPPjz71mwa+zaeIq0ZA6+psF8vgrld6oy0nO8OnOEtafAXq/7/1Khlw+Xyn7G7nkVC
         U+kQOrxkZ5Ae3Bc2ZHQUOl5r3w8x71lCMqzweB/kNHfQAxuaiQeJbmxe3y0F9QAS9V00
         R/n7cUgVEMBpEbvpInVmom2oHJ7PcHI4poxqf5NYeycC1/FaaKvaRvdXnwxDtHN6QK7T
         xurA==
X-Gm-Message-State: APjAAAVmHtQE7793zZou5tfG86mSID+bvNk1RtUngck7W8/JaXxACtlT
        UjZJAhA38SQK1xqE6jDAZ9vNLSx4UtfwATKvc5s=
X-Google-Smtp-Source: APXvYqyu1R3/ArJ1RnXaJee6C3gWbMnJXIFJvhO/RLJ0IrTQdGZ3aTOn68Wt0uwa5ueBtlRMpktn3DRr8VyhAhaQnSA=
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr110347907qki.286.1561109887787;
 Fri, 21 Jun 2019 02:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190604160944.4058-1-christian@brauner.io> <20190604160944.4058-2-christian@brauner.io>
 <20190620184451.GA28543@roeck-us.net> <20190620221003.ciuov5fzqxrcaykp@brauner.io>
In-Reply-To: <20190620221003.ciuov5fzqxrcaykp@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 11:37:50 +0200
Message-ID: <CAK8P3a2iV7=HkHBVL_puvCQN0DmdKEnVs2aG9MQV_8Q58JSfTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 12:10 AM Christian Brauner <christian@brauner.io> wrote:
> On Thu, Jun 20, 2019 at 11:44:51AM -0700, Guenter Roeck wrote:
> > On Tue, Jun 04, 2019 at 06:09:44PM +0200, Christian Brauner wrote:
>
> clone3() was placed under __ARCH_WANT_SYS_CLONE. Most architectures
> simply define __ARCH_WANT_SYS_CLONE and are done with it.
> Some however, such as nios2 and h8300 don't define it but instead
> provide a sys_clone stub of their own because of architectural
> requirements (or tweaks) and they are mostly written in assembly. (That
> should be left to arch maintainers for sys_clone3.)
>
> The build failures were on my radar already. I hadn't yet replied
> since I haven't pushed the fixup below.
> The solution is to define __ARCH_WANT_SYS_CLONE3 and add a
> cond_syscall(clone3) so we catch all architectures that do not yet
> provide clone3 with a ENOSYS until maintainers have added it.
>
> diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
> index 7a39e77984ef..aa35aa5d68dc 100644
> --- a/arch/arm/include/asm/unistd.h
> +++ b/arch/arm/include/asm/unistd.h
> @@ -40,6 +40,7 @@
>  #define __ARCH_WANT_SYS_FORK
>  #define __ARCH_WANT_SYS_VFORK
>  #define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SYS_CLONE3

I never really liked having __ARCH_WANT_SYS_CLONE here
because it was the only one that a new architecture needed to
set: all the other __ARCH_WANT_* are for system calls that
are already superseded by newer ones, so a new architecture
would start out with an empty list.

Since __ARCH_WANT_SYS_CLONE3 replaces
__ARCH_WANT_SYS_CLONE for new architectures, how about
leaving __ARCH_WANT_SYS_CLONE untouched but instead
coming up with the reverse for clone3 and mark the architectures
that specifically don't want it (if any)?

       Arnd
