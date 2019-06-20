Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381334DD39
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 00:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFTWKK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 18:10:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33586 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfFTWKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jun 2019 18:10:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so4607057wru.0
        for <linux-arch@vger.kernel.org>; Thu, 20 Jun 2019 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=osQ4T6cHI9dS6FXTVEWB3XzgaXkhdOGQwr24b6JLCQo=;
        b=JrwSrOMqW6pdRX/MfVgjguikzmfB2AM5MTvWAoZcvSUV87L4iAhtFu+vVuAqerIFG4
         YD9OJqiT5a56xrSyv71I38B7Pt5v8iOQBMdMXLsI79lqkTCWEo02Nt3jtnKh6SFsB8EG
         KuskCykxLQkQ992OrO59yi9LtmL0VofckfHvmHr884smqufwyRlaXXm9j8pdtXC9r28x
         h0uOIb32beFoOYUiZXETw8u7Ae6wChqgCX+7DmXEqpT8lijAMIvdTF2di9x9b9HBBMZP
         PYkSFbcucR2Ilsh9OAOcuzv4cVW/xib12ot2hwFaQJYq1bpQZJaCoifkFff68L1p/Xsc
         hQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=osQ4T6cHI9dS6FXTVEWB3XzgaXkhdOGQwr24b6JLCQo=;
        b=XxXGgUdV20OpAJmgNJEOMAVfhhl2IwD4gwEGZkzpubl4Tt66aeZHPyt2Uu1+EHZqtc
         Z+OaPuwmiqetDmqIJUzzpHVMM56ysmmwQItc0WMxAEuMiPf8Mm9SamUyjYwPLWZb5WHP
         szog4fzJFfh375fuy5JpWEeTvYhl0wbrYXWQR3MHxnFl7VSijk37341vKAuWIT7CSgS3
         3abVR30FdvtWOpbjw7gFQOyeBsye0ogP5eH34VL6wWA9nRTORBeU3VMX1ZGnM0hrDyQy
         rlGOT2Pum4zJnmdx4ZeF+ox/pwLGuMFqqPPpC5j5tof5GZ/nR54hHekUi5ww4/IxMiGY
         2EkQ==
X-Gm-Message-State: APjAAAUgLRX0UsvOqPNNx2rcRKD4kuIoQCLfUEe3n7pw6RMz8kJZJQj0
        nFNcfNabmBq23xA7MDCVmKPQGA==
X-Google-Smtp-Source: APXvYqy/anSRn/zCi4pr0B+FnsissvYptswWTiSJCYV1O2ADeDbazP83NMugvS4Ri9Oq77DuK6ekSg==
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr8010601wrn.125.1561068606919;
        Thu, 20 Jun 2019 15:10:06 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id x129sm525212wmg.44.2019.06.20.15.10.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 15:10:06 -0700 (PDT)
Date:   Fri, 21 Jun 2019 00:10:04 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        keescook@chromium.org, fweimer@redhat.com, oleg@redhat.com,
        arnd@arndb.de, dhowells@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
Message-ID: <20190620221003.ciuov5fzqxrcaykp@brauner.io>
References: <20190604160944.4058-1-christian@brauner.io>
 <20190604160944.4058-2-christian@brauner.io>
 <20190620184451.GA28543@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620184451.GA28543@roeck-us.net>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 20, 2019 at 11:44:51AM -0700, Guenter Roeck wrote:
> On Tue, Jun 04, 2019 at 06:09:44PM +0200, Christian Brauner wrote:
> > Wire up the clone3() call on all arches that don't require hand-rolled
> > assembly.
> > 
> > Some of the arches look like they need special assembly massaging and it is
> > probably smarter if the appropriate arch maintainers would do the actual
> > wiring. Arches that are wired-up are:
> > - x86{_32,64}
> > - arm{64}
> > - xtensa
> > 
> 
> This patch results in build failures on various architecetures.
> 
> h8300-linux-ld: arch/h8300/kernel/syscalls.o:(.data+0x6d0): undefined reference to `sys_clone3'
> 
> nios2-linux-ld: arch/nios2/kernel/syscall_table.o:(.data+0x6d0): undefined reference to `sys_clone3'
> 
> There may be others; -next is in too bad shape right now to get a complete
> picture. Wondering, though: What is special with this syscall ? Normally
> one would only get a warning that a syscall is not wired up.

clone3() was placed under __ARCH_WANT_SYS_CLONE. Most architectures
simply define __ARCH_WANT_SYS_CLONE and are done with it.
Some however, such as nios2 and h8300 don't define it but instead
provide a sys_clone stub of their own because of architectural
requirements (or tweaks) and they are mostly written in assembly. (That
should be left to arch maintainers for sys_clone3.)

The build failures were on my radar already. I hadn't yet replied
since I haven't pushed the fixup below.
The solution is to define __ARCH_WANT_SYS_CLONE3 and add a
cond_syscall(clone3) so we catch all architectures that do not yet
provide clone3 with a ENOSYS until maintainers have added it.

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 7a39e77984ef..aa35aa5d68dc 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -40,6 +40,7 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 
 /*
  * Unimplemented (or alternatively implemented) syscalls
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 24480c2d95da..e4e0523102e2 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -48,6 +48,7 @@
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 
 #ifndef __COMPAT_SYSCALL_NR
 #include <uapi/asm/unistd.h>
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 146859efd83c..097589753fec 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -54,5 +54,6 @@
 # define __ARCH_WANT_SYS_FORK
 # define __ARCH_WANT_SYS_VFORK
 # define __ARCH_WANT_SYS_CLONE
+# define __ARCH_WANT_SYS_CLONE3
 
 #endif /* _ASM_X86_UNISTD_H */
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index 30af4dc3ce7b..b52236245e51 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -3,6 +3,7 @@
 #define _XTENSA_UNISTD_H
 
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 #include <uapi/asm/unistd.h>
 
 #define __ARCH_WANT_NEW_STAT
diff --git a/kernel/fork.c b/kernel/fork.c
index 08ff131f26b4..98abea995629 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2490,7 +2490,9 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 
 	return _do_fork(&args);
 }
+#endif
 
+#ifdef __ARCH_WANT_SYS_CLONE3
 noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 					      struct clone_args __user *uargs,
 					      size_t size)
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d9ae5ea6caf..34b76895b81e 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -137,6 +137,8 @@ COND_SYSCALL(capset);
 /* kernel/exit.c */
 
 /* kernel/fork.c */
+/* __ARCH_WANT_SYS_CLONE3 */
+COND_SYSCALL(clone3);
 
 /* kernel/futex.c */
 COND_SYSCALL(futex);
