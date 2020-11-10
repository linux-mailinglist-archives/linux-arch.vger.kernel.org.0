Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EC72ADD4C
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgKJRqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 12:46:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729183AbgKJRqY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 12:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605030382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLppkAldaglNseeA1mLxrkn09RICx19onIxN5TInB1E=;
        b=GVGL4ZpAPVUPna9JI/Y/q5C0Djvv8sabIfR7/x/FMRUSdlq+mwCoEX+ZALnjnkkmZu3IuX
        Gaaw77hNqZ7K0/xE/dmf69v7QbaLts1umh1tts5gmYWyz93dWBjCiTcM+gTM3mp9vE7ljL
        c10TbKbgOEzTuFOGOFcLyPlb+W/uCLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-k_d5_NtXO2qoXW_XbKINLw-1; Tue, 10 Nov 2020 12:46:18 -0500
X-MC-Unique: k_d5_NtXO2qoXW_XbKINLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C5FD804758;
        Tue, 10 Nov 2020 17:46:15 +0000 (UTC)
Received: from treble (ovpn-120-104.rdu2.redhat.com [10.10.120.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BAA52C31E;
        Tue, 10 Nov 2020 17:46:09 +0000 (UTC)
Date:   Tue, 10 Nov 2020 11:46:06 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20201110174606.mp5m33lgqksks4mt@treble>
References: <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
 <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com>
 <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
 <20201110022924.tekltjo25wtrao7z@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110022924.tekltjo25wtrao7z@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 09, 2020 at 08:29:24PM -0600, Josh Poimboeuf wrote:
> On Mon, Nov 09, 2020 at 03:11:41PM -0800, Sami Tolvanen wrote:
> > CONFIG_XEN
> > 
> > __switch_to_asm()+0x0: undefined stack state
> >   xen_hypercall_set_trap_table()+0x0: <=== (sym)

With your branch + GCC 9 I can recreate all the warnings except this
one.

Will do some digging on the others...

-- 
Josh

