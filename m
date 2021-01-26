Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8372304503
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390707AbhAZRVG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 12:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390560AbhAZIrv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 03:47:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2970C061573;
        Tue, 26 Jan 2021 00:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HTfSorXdnEfh5Pm6XuKzd/GUg2qCTwSNwfeKANXmstw=; b=OgRpkyAv7EKJSlbJknfC0DSAe9
        R12QvtgLZUBskgoi/tToyYrG9mczu0Gs5i24dRdDz7pzyKn9JrwR+mJioR2S2bHUOkUBwaU1oYdAX
        YDnD+7G5+f/40Yol964RBKzZtH4hRXwczJFKv/2pQXeOQ6HOgFggEVRrrdWZO7Bm88qXwTkl2t8LD
        LZxNRXDVyH5nrniYeqh6aFSqq7nTDfn97yhufrVLz+Y8+wAZ2RXzSssqwEPjBusWSOtqYjV0sEccf
        NwBxu6uCkLnJUnOKbj+Cd8gdOIcmdgbq2VewKberESEB7QqQs1IWt2PKROscW1Q2sx0wIEXCHTB6n
        19f+D4IA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4Jzj-0006Ar-QW; Tue, 26 Jan 2021 08:46:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A13B300DAE;
        Tue, 26 Jan 2021 09:46:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 059A3209C50F2; Tue, 26 Jan 2021 09:46:35 +0100 (CET)
Date:   Tue, 26 Jan 2021 09:46:35 +0100
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
Message-ID: <YA/W63sob0keoD+i@hirez.programming.kicks-ass.net>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-12-yu-cheng.yu@intel.com>
 <20210125182709.GC23290@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125182709.GC23290@zn.tnic>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 25, 2021 at 07:27:09PM +0100, Borislav Petkov wrote:

> > +		pte_t old_pte, new_pte;
> > +
> > +		do {
> > +			old_pte = READ_ONCE(*ptep);
> > +			new_pte = pte_wrprotect(old_pte);
> 
> Maybe I'm missing something but those two can happen outside of the
> loop, no? Or is *ptep somehow changing concurrently while the loop is
> doing the CMPXCHG and you need to recreate it each time?
> 
> IOW, you can generate upfront and do the empty loop...
> 
> > +
> > +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
> > +
> > +		return;
> > +	}

Empty loop would be wrong, but that wants to be written like:

	old_pte = READ_ONCE(*ptep);
	do {
		new_pte = pte_wrprotect(old_pte);
	} while (try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));

Since try_cmpxchg() will update old_pte on failure.
