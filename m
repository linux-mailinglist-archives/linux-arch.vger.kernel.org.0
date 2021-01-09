Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D12F01B6
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhAIQed (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 11:34:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726779AbhAIQec (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 11:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610209986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4LWfpJc6jpinLV5977gRkGzupeL+O5/UzxgtGo5uQo=;
        b=bcEnqCVPqo2Chj6Zz1vfHrLCQNoe7blFrsniT4viER7huwOlTQ3UeKqum8EJQbh8Sqx15T
        BJ0qCQYivI0Mo0Fcut/SMx/j4iaweoeXVNk7/yCG59vYHywLpVuceTe+RyDS/Wn4k8Fm9E
        GGZwu488eUA/4scywF9pY0jg13vcspg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-rKKz2IqhPGaW8lF3ScipBQ-1; Sat, 09 Jan 2021 11:33:02 -0500
X-MC-Unique: rKKz2IqhPGaW8lF3ScipBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFA8B15720;
        Sat,  9 Jan 2021 16:32:59 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0291E5D9D3;
        Sat,  9 Jan 2021 16:32:57 +0000 (UTC)
Date:   Sat, 9 Jan 2021 10:32:56 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 00/16] Add support for Clang LTO
Message-ID: <20210109163256.3sv3wbgrshbj72ik@treble>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <CA+icZUWYxO1hHW-_vrJid7EstqQRYQphjO3Xn6pj6qfEYEONbA@mail.gmail.com>
 <20210109153646.zrmglpvr27f5zd7m@treble>
 <CA+icZUUiucbsQZtJKYdD7Y7Cq8hJZdBwsF0U0BFbaBtnLY3Nsw@mail.gmail.com>
 <20210109160709.kqqpf64klflajarl@treble>
 <CA+icZUU=sS2xfzo9qTUTPQ0prbbQcj29tpDt1qK5cYZxarXuxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUU=sS2xfzo9qTUTPQ0prbbQcj29tpDt1qK5cYZxarXuxg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> > > Did you push it (oh ah push it push it really really really good...)
> > > to your remote Git please :-).
> >
> > I thought I already pushed it pretty good ;-) do you not see it?
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> >
> > d6baee244f2d — objtool: Alphabetize usage option list (3 weeks ago)
> > c0b2a6a625ac — objtool: Separate vmlinux/noinstr validation config options (3 weeks ago)
> > 84c53551ad17 — objtool: Enable full vmlinux validation (3 weeks ago)
> > e518ac0801cd — x86/power: Support objtool validation in hibernate_asm_64.S (3 weeks ago)
> > d0ac4c7301c1 — x86/power: Move restore_registers() to top of the file (3 weeks ago)
> > d3389bc83538 — x86/power: Convert indirect jumps to retpolines (3 weeks ago)
> > 7a974d90aa40 — x86/acpi: Support objtool validation in wakeup_64.S (3 weeks ago)
> > 6693e26cd6cc — x86/acpi: Convert indirect jump to retpoline (3 weeks ago)
> > 0dfb760c74d1 — x86/ftrace: Support objtool vmlinux.o validation in ftrace_64.S (3 weeks ago)
> > 89a4febfd7bf — x86/xen/pvh: Convert indirect jump to retpoline (3 weeks ago)
> > b62837092140 — x86/xen: Support objtool vmlinux.o validation in xen-head.S (3 weeks ago)
> > 705e18481ed9 — x86/xen: Support objtool validation in xen-asm.S (3 weeks ago)
> > 3548319e21b9 — objtool: Add xen_start_kernel() to noreturn list (3 weeks ago)
> > 6016e8da8c3d — objtool: Combine UNWIND_HINT_RET_OFFSET and UNWIND_HINT_FUNC (3 weeks ago)
> > 56d6a7aee8b1 — objtool: Add asm version of STACK_FRAME_NON_STANDARD (3 weeks ago)
> > 68259d951f1a — objtool: Assume only ELF functions do sibling calls (3 weeks ago)
> > 0d6c8816cf91 — x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub (3 weeks ago)
> > 24d6ce8cd8f6 — objtool: Support retpoline jump detection for vmlinux.o (3 weeks ago)
> > 8145ea268f16 — objtool: Fix ".cold" section suffix check for newer versions of GCC (3 weeks ago)
> > b3dfca472514 — objtool: Fix retpoline detection in asm code (3 weeks ago)
> > b82402fa5211 — objtool: Fix error handling for STD/CLD warnings (3 weeks ago)
> > 1f02defb4b79 — objtool: Fix seg fault in BT_FUNC() with fake jump (3 weeks ago)
> > 2c85ebc57b3e — Linux 5.10 (4 weeks ago)
> >
> 
> I already have this one in my patch-series - I hoped you pushed
> something new to your objtool-vmlinux Git branch.
> That is what I mean by shortened... <jpoimboe.git#objtool-vmlinux>.
> 
> Hey, it's based on Linux v5.10 - I can test this with Linux v5.10.6 :-).

This is the most recent version of the patches.  I only pushed them this
morning since you said the prior version wasn't applying on Sami's
clang-cfi branch.  This version rebases fine on 'clang-cfi'.

-- 
Josh

