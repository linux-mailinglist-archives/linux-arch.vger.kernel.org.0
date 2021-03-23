Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF094346A70
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 21:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhCWUu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhCWUuB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 16:50:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B57FC061574;
        Tue, 23 Mar 2021 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n2keAYHmYw/YVTL7PvtDv0VPnQ+WyrD9i93/IeDB6CA=; b=L6fFr3JWTwXIPut2SRcVTu4FAx
        f3EA5NxGBDrrzXHWQc9lfvvoWVF7oob30Y7BKgoWWVUhu6PMYnOBTYrK0rT6rUdwsuxpOykK3t9Lm
        g5yioVj+5OsOZgj6mvNMy88muwwL9yku3YQnPyDLwSsyvd4ITbDsyvSPJnHUfABaa13sEgPZDKccL
        PrOl/sIMX6/UDFdP3sQhV9jJo3xy3fwPMGdoUYEcQ8d8EpJ4kkxT3dabmNMXKiHlhz9+DXFOdnp60
        unf0lFBU3bnZUI9nT67zraE8+KWhJLkjZiFjFOWRn6+mL79EYClAFTqdHS+Y5Y72vKi4Blj/AUCkM
        vL0Ve5sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOny1-00FjQ9-6j; Tue, 23 Mar 2021 20:49:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26CE79864DD; Tue, 23 Mar 2021 21:49:32 +0100 (CET)
Date:   Tue, 23 Mar 2021 21:49:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 00/28] Control-flow Enforcement: Shadow Stack
Message-ID: <20210323204932.GC4746@worktop.programming.kicks-ass.net>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316211552.GU4746@worktop.programming.kicks-ass.net>
 <adb72123-e8b3-c022-47da-b8c423952caf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb72123-e8b3-c022-47da-b8c423952caf@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 19, 2021 at 02:43:04PM -0700, Yu, Yu-cheng wrote:
> On 3/16/2021 2:15 PM, Peter Zijlstra wrote:
> > On Tue, Mar 16, 2021 at 08:10:26AM -0700, Yu-cheng Yu wrote:
> > > Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> > > return/jump-oriented programming attacks.  Details are in "Intel 64 and
> > > IA-32 Architectures Software Developer's Manual" [1].
> > > 
> > > CET can protect applications and the kernel.  This series enables only
> > > application-level protection, and has three parts:
> > > 
> > >    - Shadow stack [2],
> > >    - Indirect branch tracking [3], and
> > >    - Selftests [4].
> > 
> > CET is marketing; afaict SS and IBT are 100% independent and there's no
> > reason what so ever to have them share any code, let alone a Kconfig
> > knob.
> > > In fact, I think all of this would improve is you remove the CET name
> > from all of this entirely. Put this series under CONFIG_X86_SHSTK (or
> > _SS) and use CONFIG_X86_IBT for the other one.
> > 
> > Similarly with the .c file.
> > 
> > All this CET business is just pure confusion.
> > 
> 
> What about this, we bring back CONFIG_X86_SHSTK and CONFIG_X86_IBT.
> For the CET name itself, can we change it to CFE (Control Flow Enforcement),
> or just CF?

Carry Flag :-)

> In signal handling, ELF header parsing and arch_prctl(), shadow stack and
> IBT pretty much share the same code.  It is better not to split them into
> two sets of files.

Aside from redoing the UAPI we're stuck with that I suppose :/ And since
I think the CET name is all over the UAPI, you might as well keep it for
the kernel part of it as well :-(

But if there's sufficient !UAPI bits it might still make sense to also
have ibt.c and shstk.c
