Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F72B2A1F
	for <lists+linux-arch@lfdr.de>; Sat, 14 Nov 2020 01:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgKNAt0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 19:49:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbgKNAtZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 19:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605314964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Pgbto6s6aJWzu/I6GVSYjwAc7k98Nrj4vzE4Tm0+xE=;
        b=MqdPjOPOU08qh/5AeNZZD80BhRJhRRMv1j1N1TRgv+zccd2RWQg15A4kfTtoAXuG16pWoC
        GS4ZQRssuCpoIjI5VfC0xOSCpO4hSz7vobIeUInt1WZHY5cuzTjxombhZ5Nv+MZm8iFRZO
        aEk3kRBwGsaRSmoC7P+6zjlShb3U+QE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-cJKt-FEhN_unyUcxBk_KIQ-1; Fri, 13 Nov 2020 19:49:20 -0500
X-MC-Unique: cJKt-FEhN_unyUcxBk_KIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6AEE5F9D1;
        Sat, 14 Nov 2020 00:49:17 +0000 (UTC)
Received: from treble (ovpn-117-69.rdu2.redhat.com [10.10.117.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0594A60C15;
        Sat, 14 Nov 2020 00:49:13 +0000 (UTC)
Date:   Fri, 13 Nov 2020 18:49:11 -0600
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
Message-ID: <20201114004911.aip52eimk6c2uxd4@treble>
References: <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com>
 <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
 <20201110022924.tekltjo25wtrao7z@treble>
 <20201110174606.mp5m33lgqksks4mt@treble>
 <CABCJKuf+Ev=hpCUfDpCFR_wBACr-539opJsSFrDcpDA9Ctp7rg@mail.gmail.com>
 <20201113195408.atbpjizijnhuinzy@treble>
 <CABCJKufA-aOcsOqb1NiMQeBGm9Q-JxjoPjsuNpHh0kL4LzfO0w@mail.gmail.com>
 <20201113223412.inono2ekrs7ky7rm@treble>
 <CABCJKueeL+1ydcZsm2BS4qrX4Wxy7zY7FUQdoN_WLuUxFfqcmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKueeL+1ydcZsm2BS4qrX4Wxy7zY7FUQdoN_WLuUxFfqcmQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 03:31:34PM -0800, Sami Tolvanen wrote:
> >  #else /* !CONFIG_STACK_VALIDATION */
> > @@ -123,6 +129,8 @@ struct unwind_hint {
> >  .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
> >  .endm
> >  #endif
> > +.macro STACK_FRAME_NON_STANDARD func:req
> > +.endm
> 
> This macro needs to be before the #endif, so it's defined only for
> assembly code. This breaks my arm64 builds even though x86 curiously
> worked just fine.

Yeah, I noticed that after syncing objtool.h with the tools copy.  Fixed
now.

I've got fixes for some of the other warnings, but I'll queue them up
and post when they're all ready.

-- 
Josh

