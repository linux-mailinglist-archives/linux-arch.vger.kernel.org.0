Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0090355956
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 22:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFYUrY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 16:47:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfFYUrY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 16:47:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 926EB37EEB;
        Tue, 25 Jun 2019 20:47:23 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-125.ams2.redhat.com [10.36.116.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA7C36085B;
        Tue, 25 Jun 2019 20:47:16 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-x86_64@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Carlos O'Donell" <carlos@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: Detecting the availability of VSYSCALL
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1906251824500.32342@nanos.tec.linutronix.de>
        <87lfxpy614.fsf@oldenburg2.str.redhat.com>
        <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com>
Date:   Tue, 25 Jun 2019 22:47:14 +0200
In-Reply-To: <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com>
        (Andy Lutomirski's message of "Tue, 25 Jun 2019 13:11:25 -0700")
Message-ID: <87a7e5v1d9.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 25 Jun 2019 20:47:23 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

>> We want binaries that run fast on VSYSCALL kernels, but can fall back to
>> full system calls on kernels that do not have them (instead of
>> crashing).
>
> Define "VSYSCALL kernels."  On any remotely recent kernel (*all* new
> kernels and all kernels for the last several years that haven't
> specifically requested vsyscall=native), using vsyscalls is much, much
> slower than just doing syscalls.  I know a way you can tell whether
> vsyscalls are fast, but it's unreliable, and I'm disinclined to
> suggest it.  There are also at least two pending patch series that
> will interfere.

The fast path is for the benefit of the 2.6.32-based kernel in Red Hat
Enterprise Linux 6.  It doesn't have the vsyscall emulation code yet, I
think.

My hope is to produce (statically linked) binaries that run as fast on
that kernel as they run today, but can gracefully fall back to something
else on kernels without vsyscall support.

>> We could parse the vDSO and prefer the functions found there, but this
>> is for the statically linked case.  We currently do not have a (minimal)
>> dynamic loader there in that version of the code base, so that doesn't
>> really work for us.
>
> Is anything preventing you from adding a vDSO parser?  I wrote one
> just for this type of use:
>
> $ wc -l tools/testing/selftests/vDSO/parse_vdso.c
> 269 tools/testing/selftests/vDSO/parse_vdso.c
>
> (289 lines includes quite a bit of comment.)

I'm worried that if I use a custom parser and the binaries start
crashing again because something changed in the kernel (within the scope
permitted by the ELF specification), the kernel won't be fixed.

That is, we'd be in exactly the same situation as today.

Thanks,
Florian
