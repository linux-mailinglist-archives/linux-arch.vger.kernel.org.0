Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00BB28F01B
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 12:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbgJOKWo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 06:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389271AbgJOKWo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Oct 2020 06:22:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA8BC061755;
        Thu, 15 Oct 2020 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rmt+w86dS/ArDl7p6coE3p1FQiRlDnETDOF85EAeo80=; b=H7urFq9tcKjVEHrGlgs6qqhDf4
        oQMvOJQ0ykGC0OUWm6j6P40c2ClfoS4N1iUdDzI7NszgLIB2YI4qMJ892z90AJsTn11EvwW+MtOVh
        ddVXM7uYTIl+ahd+gEQFvcaxfyuaPnkbEsTt/vmXLtStZfCQlSfc+oQ9GKbTIbh1QtEndZUFKS8iQ
        RG2CeCNJ8oLWOZ1j2VOtlC36cNeboOcj3IpHWd0dVqImsYZOp+GtYIoL4M+5SqxrBrt55upHkAlVA
        rdh+0h6U56l/Lqn5r2zQ2t0WOc1/OVeHC7M8/6/Im8NyIi7W3dDDZL1d8iqegaLUsqXcJBsUpBLPv
        pDxD+k8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT0Oo-0006aX-4e; Thu, 15 Oct 2020 10:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 835C0300DAE;
        Thu, 15 Oct 2020 12:22:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F7A9235F4457; Thu, 15 Oct 2020 12:22:16 +0200 (CEST)
Date:   Thu, 15 Oct 2020 12:22:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20201015102216.GB2611@hirez.programming.kicks-ass.net>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com>
 <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 15, 2020 at 01:23:41AM +0200, Jann Horn wrote:

> It would probably be good to keep LTO and non-LTO builds in sync about
> which files are subjected to objtool checks. So either you should be
> removing the OBJECT_FILES_NON_STANDARD annotations for anything that
> is linked into the main kernel (which would be a nice cleanup, if that
> is possible), 

This, I've had to do that for a number of files already for the limited
vmlinux.o passes we needed for noinstr validation.
