Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749C62F015A
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 17:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbhAIQIz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 11:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbhAIQIy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 11:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610208448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4tZTudWMHL9XHsahjxKGAOBjt0qYTZ11jrT8O8TLnA=;
        b=aDE2r7+Yko7OcKgq832KjC+4bSKckr5S2XeNUktMywHpMq4J3uegw6B0wNaVT+Y91RCpEf
        jbnwih1pbd50S4mRaMnPTYs0Ehfiiw1tPs/BQ9FE/3OTCdthGZTB45NH/1Y+6co0Xt1CFY
        MBLDay0BZmiXRBt79qRoonkH5SK87xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-ZQW85TisMNyB3WjeOrGOXw-1; Sat, 09 Jan 2021 11:07:24 -0500
X-MC-Unique: ZQW85TisMNyB3WjeOrGOXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99F22801817;
        Sat,  9 Jan 2021 16:07:21 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8833C10013BD;
        Sat,  9 Jan 2021 16:07:16 +0000 (UTC)
Date:   Sat, 9 Jan 2021 10:07:09 -0600
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
Message-ID: <20210109160709.kqqpf64klflajarl@treble>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <CA+icZUWYxO1hHW-_vrJid7EstqQRYQphjO3Xn6pj6qfEYEONbA@mail.gmail.com>
 <20210109153646.zrmglpvr27f5zd7m@treble>
 <CA+icZUUiucbsQZtJKYdD7Y7Cq8hJZdBwsF0U0BFbaBtnLY3Nsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUUiucbsQZtJKYdD7Y7Cq8hJZdBwsF0U0BFbaBtnLY3Nsw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 09, 2021 at 04:46:21PM +0100, Sedat Dilek wrote:
> On Sat, Jan 9, 2021 at 4:36 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Sat, Jan 09, 2021 at 03:54:20PM +0100, Sedat Dilek wrote:
> > > I am interested in having Clang LTO (Clang-CFI) for x86-64 working and
> > > help with testing.
> > >
> > > I tried the Git tree mentioned in [3] <jpoimboe.git#objtool-vmlinux>
> > > (together with changes from <peterz.git#x86/urgent>).
> > >
> > > I only see in my build-log...
> > >
> > > drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
> > > eb_relocate_parse_slow()+0x3d0: stack state mismatch: cfa1=7+120
> > > cfa2=-1+0
> > > drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
> > > eb_copy_relocations()+0x229: stack state mismatch: cfa1=7+120
> > > cfa2=-1+0
> > >
> > > ...which was reported and worked on in [1].
> > >
> > > This is with Clang-IAS version 11.0.1.
> > >
> > > Unfortunately, the recent changes in <samitolvanen.github#clang-cfi>
> > > do not cleanly apply with Josh stuff.
> > > My intention/wish was to report this combination of patchsets "heals"
> > > a lot of objtool-warnings for vmlinux.o I observed with Clang-CFI.
> > >
> > > Is it possible to have a Git branch where Josh's objtool-vmlinux is
> > > working together with Clang-LTO?
> > > For testing purposes.
> >
> > I updated my branch with my most recent work from before the holidays,
> > can you try it now?  It still doesn't fix any of the crypto warnings,
> > but I'll do that in a separate set after posting these next week.
> >
> 
> Thanks, Josh.
> 
> Did you push it (oh ah push it push it really really really good...)
> to your remote Git please :-).

I thought I already pushed it pretty good ;-) do you not see it?

git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux

d6baee244f2d — objtool: Alphabetize usage option list (3 weeks ago)
c0b2a6a625ac — objtool: Separate vmlinux/noinstr validation config options (3 weeks ago)
84c53551ad17 — objtool: Enable full vmlinux validation (3 weeks ago)
e518ac0801cd — x86/power: Support objtool validation in hibernate_asm_64.S (3 weeks ago)
d0ac4c7301c1 — x86/power: Move restore_registers() to top of the file (3 weeks ago)
d3389bc83538 — x86/power: Convert indirect jumps to retpolines (3 weeks ago)
7a974d90aa40 — x86/acpi: Support objtool validation in wakeup_64.S (3 weeks ago)
6693e26cd6cc — x86/acpi: Convert indirect jump to retpoline (3 weeks ago)
0dfb760c74d1 — x86/ftrace: Support objtool vmlinux.o validation in ftrace_64.S (3 weeks ago)
89a4febfd7bf — x86/xen/pvh: Convert indirect jump to retpoline (3 weeks ago)
b62837092140 — x86/xen: Support objtool vmlinux.o validation in xen-head.S (3 weeks ago)
705e18481ed9 — x86/xen: Support objtool validation in xen-asm.S (3 weeks ago)
3548319e21b9 — objtool: Add xen_start_kernel() to noreturn list (3 weeks ago)
6016e8da8c3d — objtool: Combine UNWIND_HINT_RET_OFFSET and UNWIND_HINT_FUNC (3 weeks ago)
56d6a7aee8b1 — objtool: Add asm version of STACK_FRAME_NON_STANDARD (3 weeks ago)
68259d951f1a — objtool: Assume only ELF functions do sibling calls (3 weeks ago)
0d6c8816cf91 — x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub (3 weeks ago)
24d6ce8cd8f6 — objtool: Support retpoline jump detection for vmlinux.o (3 weeks ago)
8145ea268f16 — objtool: Fix ".cold" section suffix check for newer versions of GCC (3 weeks ago)
b3dfca472514 — objtool: Fix retpoline detection in asm code (3 weeks ago)
b82402fa5211 — objtool: Fix error handling for STD/CLD warnings (3 weeks ago)
1f02defb4b79 — objtool: Fix seg fault in BT_FUNC() with fake jump (3 weeks ago)
2c85ebc57b3e — Linux 5.10 (4 weeks ago)

-- 
Josh

