Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254E3303956
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 10:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbhAZJqs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 04:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731164AbhAZJqB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 04:46:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB13C06174A;
        Tue, 26 Jan 2021 01:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1CPjkpcybqu4UmrIlyT7CxahkHobB8NLRUbQkEtv9gU=; b=OepRa5e8f56TtZHozt6NKrD7SL
        7NAzZdheLyCJJIT2t2Otw19/WTxOE2bbb5RBIxNNUYL+zRG/pNHRno6mX+rkJvNO+5Yfl+od1ZH1o
        3rtGWLm8NGasKwlRHdpeezA4HOMoDdHUVBSWew6rjO8PcY92SL2J2eMftsMpOjTDBCJQCdqValhdr
        AeFKcKWSzj40c2vTUCF4YaGOvldQpTO50q23BNz4zDOWcSz013OsCF6owkBOSq9xRDB1cv3Mej/HJ
        Gyy1ToJDQEi70A8gQZw19NxIxi1aE5bMFjUNAYQSV8d2xd+oCk7UIetGWvGwjarlIS2tjnoQ4lhqc
        TPsD0BSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Kpx-005NSo-Qp; Tue, 26 Jan 2021 09:40:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50941300DB4;
        Tue, 26 Jan 2021 10:40:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A0E420297EDB; Tue, 26 Jan 2021 10:40:36 +0100 (CET)
Date:   Tue, 26 Jan 2021 10:40:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v17 11/26] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <YA/jlOuNpcPPNHA1@hirez.programming.kicks-ass.net>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-12-yu-cheng.yu@intel.com>
 <20210125182709.GC23290@zn.tnic>
 <YA/W63sob0keoD+i@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YA/W63sob0keoD+i@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 26, 2021 at 09:46:36AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 25, 2021 at 07:27:09PM +0100, Borislav Petkov wrote:
> 
> > > +		pte_t old_pte, new_pte;
> > > +
> > > +		do {
> > > +			old_pte = READ_ONCE(*ptep);
> > > +			new_pte = pte_wrprotect(old_pte);
> > 
> > Maybe I'm missing something but those two can happen outside of the
> > loop, no? Or is *ptep somehow changing concurrently while the loop is
> > doing the CMPXCHG and you need to recreate it each time?
> > 
> > IOW, you can generate upfront and do the empty loop...
> > 
> > > +
> > > +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
> > > +
> > > +		return;
> > > +	}
> 
> Empty loop would be wrong, but that wants to be written like:
> 
> 	old_pte = READ_ONCE(*ptep);
> 	do {
> 		new_pte = pte_wrprotect(old_pte);
> 	} while (try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));

! went missing, too early, moar wake-up juice.

> Since try_cmpxchg() will update old_pte on failure.
