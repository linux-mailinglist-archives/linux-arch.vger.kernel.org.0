Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43F233E0D8
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCPVwD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 17:52:03 -0400
Received: from casper.infradead.org ([90.155.50.34]:37684 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhCPVRA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 17:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5gozf9msiE9KxmQI3WyWORDOu9a/cAx+NIytFUdmLig=; b=X/SgE772DCUsq82Z3cmFeX95oO
        PqfjJ2FRHKtH42r39m6MsvF9e5TdZgVBI17+s6kSwsdLRIH6v9V4li+P1j+8WqrEOiBkH6dTpmXCl
        zj1Kf2d5mWrKPa8KsbpoPAW1aiwZWNaloYuw/CAIYs+xvotJFNzpXH8o2sLJTPSdxOe8bKxhzoW7R
        Fj+2vE8z7DbOu1UEzcqo4TMCRdDso4boo0dWkPh4i3GG1J0Wl3oHeTBkK6TokK4mP/RePGYbmcBdt
        UCFi0He2Yd3bwFvSsH+Qnhs7glJ4VOkYI0qVv+/wM6AHgCid9xL3/c/oJyHftKdVv1DVOVvqYwv5V
        V7lwKkHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMH2e-000dKj-Op; Tue, 16 Mar 2021 21:15:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59827981337; Tue, 16 Mar 2021 22:15:52 +0100 (CET)
Date:   Tue, 16 Mar 2021 22:15:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20210316211552.GU4746@worktop.programming.kicks-ass.net>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-1-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:26AM -0700, Yu-cheng Yu wrote:
> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> return/jump-oriented programming attacks.  Details are in "Intel 64 and
> IA-32 Architectures Software Developer's Manual" [1].
> 
> CET can protect applications and the kernel.  This series enables only
> application-level protection, and has three parts:
> 
>   - Shadow stack [2],
>   - Indirect branch tracking [3], and
>   - Selftests [4].

CET is marketing; afaict SS and IBT are 100% independent and there's no
reason what so ever to have them share any code, let alone a Kconfig
knob.

In fact, I think all of this would improve is you remove the CET name
from all of this entirely. Put this series under CONFIG_X86_SHSTK (or
_SS) and use CONFIG_X86_IBT for the other one.

Similarly with the .c file.

All this CET business is just pure confusion.
