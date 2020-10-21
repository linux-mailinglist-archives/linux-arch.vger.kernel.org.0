Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEFF29523A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 20:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504074AbgJUSae (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 14:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406149AbgJUSad (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 14:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603305032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWk1HmGPS11z1lVFpxCdMWGo2d19IWvUVpCVt8eeJUo=;
        b=XHIwdzkNCGrU5fCsAQRbk5YfmiV/PQsYaq+XrMK5tFAbe3G6vGj+Yw5nL7gOLFB8pJEygv
        zOOrM4vIktBpXjVOfAjiDuzqojSlCFQF1LxBf5rBo/5HQN0JpTQPP/jt+n3eJKxhgoNdvo
        W254vtdiIhxK5R6Ho3PKawfx8Dfy/20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-ts4ydIjKNra8FmPa6CjVIA-1; Wed, 21 Oct 2020 14:30:26 -0400
X-MC-Unique: ts4ydIjKNra8FmPa6CjVIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51CD0101962B;
        Wed, 21 Oct 2020 18:30:24 +0000 (UTC)
Received: from treble (ovpn-117-195.rdu2.redhat.com [10.10.117.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 912706EF42;
        Wed, 21 Oct 2020 18:30:14 +0000 (UTC)
Date:   Wed, 21 Oct 2020 13:30:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
Message-ID: <20201021183009.qbvhz7hsrm46vksn@treble>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com>
 <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <20201021095133.GA2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021095133.GA2628@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 11:51:33AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 20, 2020 at 01:52:17PM -0500, Josh Poimboeuf wrote:
> > > arch/x86/lib/retpoline.S:
> > > __x86_retpoline_rdi()+0x10: return with modified stack frame
> > > __x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=7+8
> > > __x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=-1+0
> > 
> > Is this with upstream?  I thought we fixed that with
> > UNWIND_HINT_RET_OFFSET.
> 
> I can't reproduce this one either; but I do get different warnings:
> 
> gcc (Debian 10.2.0-13) 10.2.0, x86_64-defconfig:
> 
> defconfig-build/vmlinux.o: warning: objtool: __x86_indirect_thunk_rax() falls through to next function __x86_retpoline_rax()
> defconfig-build/vmlinux.o: warning: objtool:   .altinstr_replacement+0x1063: (branch)
> defconfig-build/vmlinux.o: warning: objtool:   __x86_indirect_thunk_rax()+0x0: (alt)
> defconfig-build/vmlinux.o: warning: objtool:   __x86_indirect_thunk_rax()+0x0: <=== (sym)
> 
> (for every single register, not just rax)
> 
> Which is daft as well, because the retpoline.o run is clean. It also
> doesn't make sense because __x86_retpoline_rax isn't in fact STT_FUNC,
> so WTH ?!

It is STT_FUNC:

  SYM_FUNC_START_NOALIGN(__x86_retpoline_\reg)

  $ readelf -s vmlinux.o |grep __x86_retpoline_rax
  129749: 0000000000000005    17 FUNC    GLOBAL DEFAULT   39 __x86_retpoline_rax

-- 
Josh

