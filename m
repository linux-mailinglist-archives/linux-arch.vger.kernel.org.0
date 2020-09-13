Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01950267E67
	for <lists+linux-arch@lfdr.de>; Sun, 13 Sep 2020 09:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgIMHoP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Sep 2020 03:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgIMHoP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Sep 2020 03:44:15 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC729C061573;
        Sun, 13 Sep 2020 00:44:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bq1hp3411z9sTS;
        Sun, 13 Sep 2020 17:44:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1599983052;
        bh=czRzqse3LcOYZ30/6LCMJ8nuNlZbjy30OEAHsP1OmHU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YFWcemGvYU4YxnGdEwoQv4snJqlwHLH2V/kScnwSVek6LrbZ23UmZRC1NQJHAh/3C
         0VTCObFzg5Z0SQRWQ5CdFvb8rEiZZ+33WSEvHZwwlh+J13RLx+tV6Um0wZB7qZGEBF
         qETyK/vhO3DTKXyV3KdzLev30YnMyDmAfAvAxSAVZ9b5VLurhK6AJ9ldS1FMLzZNpR
         d9IKT7vsjaH+5g14Fk8v+3SG4FYe3nwMjje+7G8TCudb9NYWhPFtNDbpHxTExiE2+i
         Hl3FC+2HacrKuM/TirIre1WH0ujUH1h3If4gG0Gs3cUG6gKomVQD1agZzW0kuGez1y
         5hVHV0d6sgHXg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kyle Huey <me@kylehuey.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to change the syscall number at entry via orig_ax
In-Reply-To: <202009111609.61E7875B3@keescook>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com> <87blj6ifo8.fsf@nanos.tec.linutronix.de> <87a6xzrr89.fsf@mpe.ellerman.id.au> <202009111609.61E7875B3@keescook>
Date:   Sun, 13 Sep 2020 17:44:09 +1000
Message-ID: <87d02qqfxy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Wed, Sep 09, 2020 at 11:53:42PM +1000, Michael Ellerman wrote:
>> I can observe the difference between v5.8 and mainline, using the
>> raw_syscall trace event and running the seccomp_bpf selftest which turns
>> a getpid (39) into a getppid (110).
>> 
>> With v5.8 we see getppid on entry and exit:
>> 
>>      seccomp_bpf-1307  [000] .... 22974.874393: sys_enter: NR 110 (7ffff22c46e0, 40a350, 4, fffffffffffff7ab, 7fa6ee0d4010, 0)
>>      seccomp_bpf-1307  [000] .N.. 22974.874401: sys_exit: NR 110 = 1304
>> 
>> Whereas on mainline we see an enter for getpid and an exit for getppid:
>> 
>>      seccomp_bpf-1030  [000] ....    21.806766: sys_enter: NR 39 (7ffe2f6d1ad0, 40a350, 7ffe2f6d1ad0, 0, 0, 407299)
>>      seccomp_bpf-1030  [000] ....    21.806767: sys_exit: NR 110 = 1027
>
> For my own notes, this is how I reproduced it:
>
> # ./perf-$VER record -e raw_syscalls:sys_enter -e raw_syscalls:sys_exit &
> # ./seccomp_bpf
> # fg
> ctrl-c
> # ./perf-$VER script | grep seccomp_bpf | awk '{print $7}' | sort | uniq -c > $VER.log
> *repeat*
> # diff -u old.log new.log
> ...
>
> (Is there an easier way to get those results?)

I did more or less the same thing, except I ran the trace event manually
(via debugfs), which is no better really.

I think the right way to test it would be to have a test that modifies
the syscall via seccomp and also monitors the trace event using perf
events. But that wouldn't be easier :)

> I will go see if I can figure out the best way to correct this.

I think this works?

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 18683598edbc..901361e2f8ea 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -60,13 +60,15 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
                        return ret;
        }
 
+       syscall = syscall_get_nr(current, regs);
+
        if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
                trace_sys_enter(regs, syscall);
 
        syscall_enter_audit(regs, syscall);
 
        /* The above might have changed the syscall number */
-       return ret ? : syscall_get_nr(current, regs);
+       return ret ? : syscall;
 }
 
 static __always_inline long


cheers
