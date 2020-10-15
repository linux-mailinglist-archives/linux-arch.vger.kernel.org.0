Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1427028FA3E
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 22:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbgJOUj4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 16:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732544AbgJOUj4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Oct 2020 16:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602794395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=drNAM9RnP6kYRtro33MBF8DkJ/VVjdpQLGpKNAKGMr0=;
        b=XQE1vKY169zUJHe8PpMOjjo8nT2H7ZQLtKK61ZasL6GD5Ad29IzcFP73xH9D4gtd49yydv
        94vWPhfqXFGRh6Nt0cX62L4aW5woTAaQ9BzhOY73j2Q3pkMFHQdYtt+aM/evrdr7PHqj46
        aY+XdFzFgaECSAI22RFL2znS0Wf4yVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-RnX1X4qvPkWYUnhEN4Iw2A-1; Thu, 15 Oct 2020 16:39:51 -0400
X-MC-Unique: RnX1X4qvPkWYUnhEN4Iw2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DC2107466A;
        Thu, 15 Oct 2020 20:39:49 +0000 (UTC)
Received: from treble (ovpn-115-218.rdu2.redhat.com [10.10.115.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 036CA6EF72;
        Thu, 15 Oct 2020 20:39:44 +0000 (UTC)
Date:   Thu, 15 Oct 2020 15:39:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
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
        linux-kbuild@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
Message-ID: <20201015203942.f3kwcohcwwa6lagd@treble>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com>
 <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015102216.GB2611@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 15, 2020 at 12:22:16PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 15, 2020 at 01:23:41AM +0200, Jann Horn wrote:
> 
> > It would probably be good to keep LTO and non-LTO builds in sync about
> > which files are subjected to objtool checks. So either you should be
> > removing the OBJECT_FILES_NON_STANDARD annotations for anything that
> > is linked into the main kernel (which would be a nice cleanup, if that
> > is possible), 
> 
> This, I've had to do that for a number of files already for the limited
> vmlinux.o passes we needed for noinstr validation.

Getting rid of OBJECT_FILES_NON_STANDARD is indeed the end goal, though
I'm not sure how practical that will be for some of the weirder edge
case.

On a related note, I have some old crypto cleanups which need dusting
off.

-- 
Josh

