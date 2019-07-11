Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F15656DA
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2019 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfGKM2X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Jul 2019 08:28:23 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41837 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGKM2W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 08:28:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id i138so3222261ywg.8;
        Thu, 11 Jul 2019 05:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhuJhWxP1rUZnb+Vp6G8TuOnOq95+bSLey7FrYy8zQY=;
        b=sYl0JDrH8oAtoFVBl604Pm1yAHjqxTND8blSap7qhzjOw2Z2B2AhV419wvfZti0V9T
         ilrxqcI9fIX7+ume5hJ1e1R1T6hD61MZlX6ORmHftFpuHQ4BitVFtsjqHPycbb0L6skh
         9E4L9WsO0qATP8z553xv3X01J6wgQlJhB2qirzXyeOx0UCD0O003KB9U2A7SflMKIyCK
         nmwXVXTnYRjkstFLdHf3IIXMsGnk+fDNBlW8a6+5/00tnPS281dQm/tWOmBgkFfHZdMB
         2FkhPmLuP0nsO1GViWvUf/dyEi3jwn+LIqFTrXpfPeq1ErD4BtqSq8gq1WJJtNl1mzBJ
         N3qw==
X-Gm-Message-State: APjAAAUwTw5gtPpmKasXrEg5OYKKIFzMEQb7T6nGgAWiJFEyIoREC5ur
        4PITQ1v0kQsopvlq+6sALp4JlhSI6QeOoqU5MT4=
X-Google-Smtp-Source: APXvYqxnENs8rD53npbxsD00xL3VrlCkW1LR5JPpFwT+zi16w+B/f9HTckdF0z/FhReYSAwdlJwKNwtGWfJSorUq86s=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr1942490qtd.18.1562848101449;
 Thu, 11 Jul 2019 05:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190710130206.1670830-1-arnd@arndb.de> <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
In-Reply-To: <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Jul 2019 14:28:04 +0200
Message-ID: <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 11, 2019 at 2:14 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
>
> Could you please tell me which version of the compiler did you use?
>
> My building command is:
>
> # make mrproper && make CC=clang HOSTCC=clang i386_defconfig && make ARCH=i386
> CC=clang HOSTCC=clang -j56
>

See below for the patch I am using locally to work around this.
That patch is probably wrong, so I have not submitted it yet, but it
gives you a clean build ;-)

     Arnd

8<---
Subject: [PATCH] x86: percpu: fix clang 32-bit build

clang does not like an inline assembly with a "=q" contraint for
a 64-bit output:

arch/x86/events/perf_event.h:824:21: error: invalid output size for
constraint '=q'
        u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
                           ^
include/linux/percpu-defs.h:447:2: note: expanded from macro '__this_cpu_read'
        raw_cpu_read(pcp);                                              \
        ^
include/linux/percpu-defs.h:421:28: note: expanded from macro 'raw_cpu_read'
 #define raw_cpu_read(pcp)
__pcpu_size_call_return(raw_cpu_read_, pcp)
                                        ^
include/linux/percpu-defs.h:322:23: note: expanded from macro
'__pcpu_size_call_return'
        case 1: pscr_ret__ = stem##1(variable); break;                  \
                             ^
<scratch space>:357:1: note: expanded from here
raw_cpu_read_1
^
arch/x86/include/asm/percpu.h:394:30: note: expanded from macro 'raw_cpu_read_1'
 #define raw_cpu_read_1(pcp)             percpu_from_op(, "mov", pcp)
                                        ^
arch/x86/include/asm/percpu.h:189:15: note: expanded from macro 'percpu_from_op'
                    : "=q" (pfo_ret__)                  \
                            ^

According to the commit that introduced the "q" constraint, this was
needed to fix miscompilation, but it gives no further detail.

Using the normal "=r" constraint seems to work so far.

Fixes: 3c598766a2ba ("x86: fix percpu_{to,from}_op()")
Cc: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2278797c769d..e791fbf4018f 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -99,7 +99,7 @@ do {                                                  \
        case 1:                                         \
                asm qual (op "b %1,"__percpu_arg(0)     \
                    : "+m" (var)                        \
-                   : "qi" ((pto_T__)(val)));           \
+                   : "ri" ((pto_T__)(val)));           \
                break;                                  \
        case 2:                                         \
                asm qual (op "w %1,"__percpu_arg(0)     \
@@ -144,7 +144,7 @@ do {
                         \
                else                                                    \
                        asm qual ("addb %1, "__percpu_arg(0)            \
                            : "+m" (var)                                \
-                           : "qi" ((pao_T__)(val)));                   \
+                           : "ri" ((pao_T__)(val)));                   \
                break;                                                  \
        case 2:                                                         \
                if (pao_ID__ == 1)                                      \
@@ -186,7 +186,7 @@ do {
                         \
        switch (sizeof(var)) {                          \
        case 1:                                         \
                asm qual (op "b "__percpu_arg(1)",%0"   \
-                   : "=q" (pfo_ret__)                  \
+                   : "=r" (pfo_ret__)                  \
                    : "m" (var));                       \
                break;                                  \
        case 2:                                         \
@@ -215,7 +215,7 @@ do {
                         \
        switch (sizeof(var)) {                          \
        case 1:                                         \
                asm(op "b "__percpu_arg(P1)",%0"        \
-                   : "=q" (pfo_ret__)                  \
+                   : "=r" (pfo_ret__)                  \
                    : "p" (&(var)));                    \
                break;                                  \
        case 2:                                         \
