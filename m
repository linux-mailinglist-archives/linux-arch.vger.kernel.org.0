Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400A033DE4C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 20:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhCPT6d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbhCPT6U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 15:58:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC298C06174A;
        Tue, 16 Mar 2021 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KkZwEPUQCMwOivHO6m7Z9239lBaUNqbxUKZ6UDSVFWY=; b=X5oOAwBnqFKCT2F+1ptWGWXzlC
        J+05EeH3R5PZAymU4r1zQjaCX27P1TpJ9FYvTkoKe9oj+5GENdr+vSSmcjL4h43qamaTIZ9/50wYs
        ET+iGhFylz8fZ4gMAsgPpRcpq0GPuU8OX/iKVvD1RyVxSUUDhR3t1ZF/P1rD6n41PwsYl36O7EZum
        bXFkTsm661rBnfNSEVGrL0mZAlnrgJC2YveF95TKG0PTZa6p+ClYVHwr6I4nDcS+rlwG0y+VzLcAY
        koOnNTC1PdRjnrgCBnHxEMIC5naZSQ7l61PyM5LSKc7vTEmOz40Oahjx4PiPLbs/KWPOmdkB2IiOj
        FFlgk68w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMFpA-001lEm-11; Tue, 16 Mar 2021 19:57:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48299301124;
        Tue, 16 Mar 2021 20:57:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3752520B05D79; Tue, 16 Mar 2021 20:57:50 +0100 (CET)
Date:   Tue, 16 Mar 2021 20:57:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v23 6/9] x86/entry: Introduce ENDBR macro
Message-ID: <YFENvgrR8JSYq1ae@hirez.programming.kicks-ass.net>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-7-yu-cheng.yu@intel.com>
 <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
 <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 10:12:39AM -0700, Yu, Yu-cheng wrote:
> Alternatively, there is another compiler-defined macro _CET_ENDBR that can
> be used.  We can put the following in calling.h:
> 
> #ifdef __CET__
> #include <cet.h>
> #else
> #define _CET_ENDBR
> #endif
> 
> and then use _CET_ENDBR in other files.  How is that?
> 
> In the future, in case we have kernel-mode IBT, ENDBR macros are also needed
> for other assembly files.

Can we please call it IBT_ENDBR or just ENDBR. CET is a horrible name,
seeing how it is not specific.
