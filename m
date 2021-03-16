Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C349133DE7D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 21:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCPUQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 16:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhCPUQL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 16:16:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40F6C06174A;
        Tue, 16 Mar 2021 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=25Try9Vsj8b5XGaRHjhes0qHsMMyPZK0kTaQIOavQ6A=; b=AnHus7XJzGVxIFuzMangQl62Hu
        v1y8qc5CSlkUQDXqbfOA9DNG4wicfwaNcF84seZZoQ093qg+6T2sWpFwW7GLKvaunoRSedXJg4Q7T
        IohHNum/GOeZdWKAOk3Wi0OagYHQ3Gi7Q8VP5mUzOz3bcLoZjR6ECx5/23Nda1Yoxn0EVTrNQWIlx
        jwNMZLzBQ6KQpIz+LHBOAFjJQcsnQWUZ6Eh5ciVqYQqH79Z6C84B4B2no38hwu+QKvvqvYzDQpdNN
        5HhksWs8e0S/syyl5EvPS2A2CWec9m0KNNhw0zf+6SRhM/PrZbOn7i8/awQsztL82mAIqaTsHH39p
        6aIHG54Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMG6S-001mTt-7H; Tue, 16 Mar 2021 20:15:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A3E5304D58;
        Tue, 16 Mar 2021 21:15:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2307423CC228C; Tue, 16 Mar 2021 21:15:43 +0100 (CET)
Date:   Tue, 16 Mar 2021 21:15:43 +0100
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
Message-ID: <YFER79kU+ukn3YZr@hirez.programming.kicks-ass.net>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-7-yu-cheng.yu@intel.com>
 <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
 <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
 <YFENvgrR8JSYq1ae@hirez.programming.kicks-ass.net>
 <65845773-6cf0-1bdc-1ecf-168de74cc283@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65845773-6cf0-1bdc-1ecf-168de74cc283@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 01:05:30PM -0700, Yu, Yu-cheng wrote:
> On 3/16/2021 12:57 PM, Peter Zijlstra wrote:
> > On Tue, Mar 16, 2021 at 10:12:39AM -0700, Yu, Yu-cheng wrote:
> > > Alternatively, there is another compiler-defined macro _CET_ENDBR that can
> > > be used.  We can put the following in calling.h:
> > > 
> > > #ifdef __CET__
> > > #include <cet.h>
> > > #else
> > > #define _CET_ENDBR
> > > #endif
> > > 
> > > and then use _CET_ENDBR in other files.  How is that?
> > > 
> > > In the future, in case we have kernel-mode IBT, ENDBR macros are also needed
> > > for other assembly files.
> > 
> > Can we please call it IBT_ENDBR or just ENDBR. CET is a horrible name,
> > seeing how it is not specific.
> > 
> 
> _CET_ENDBR is from the compiler and we cannot change it.  We can do:
> 
> #define ENDBR _CET_ENDBR
> 
> How is that?

Do we really want to include compiler headers? AFAICT it's not a
built-in. Also what about clang?

This thing seems trivial enough to build our own, it's a single damn
instruction. That also means we don't have to worry about changes to
header files we don't control.
