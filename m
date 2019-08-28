Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89E29FB15
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2019 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfH1HD7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Aug 2019 03:03:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfH1HD7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 03:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b0lWlRYuwpcJp7FZARuB7iv+wNKnjSY45sYdI3qTaw0=; b=SRcswj1NZftwI/XnJvFP3pShU
        znc/n+mtlRHu6TFjynsrTcX7AJbxhiAxqbwLDQuGtAPg3JfrBRRm0ct4NUb75sMosNwo6zzPno6++
        UalJ7tB/CF1fibAZwF3XnkUahC3vLwVicDfZaOzdUfznqQYyj4cqeEELzUx5OBLE/UoBVq4xNa3fb
        MAGABj29H9rsz6o5r+c35Ec806uTVIFEp3KPjzXh72MNxZwttb5puS+/o9mL5A6kR9sqWGaybBoG8
        jFsHa7toIBBHEB+Y8OPHVqgL3GH3gy6DAyVnffryEZ3lpK0XGznfntg42Nb/sbcfkNgDjX3ozypqN
        oKJ6ql6IQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2rz6-0000Q5-2E; Wed, 28 Aug 2019 07:03:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95D553070F4;
        Wed, 28 Aug 2019 09:02:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D7E02018508C; Wed, 28 Aug 2019 09:03:08 +0200 (CEST)
Date:   Wed, 28 Aug 2019 09:03:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 11/27] x86/mm: Introduce _PAGE_DIRTY_SW
Message-ID: <20190828070308.GJ2332@hirez.programming.kicks-ass.net>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
 <20190813205225.12032-12-yu-cheng.yu@intel.com>
 <20190823140233.GC2332@hirez.programming.kicks-ass.net>
 <6c3dc33e16c8bbb6d45c0a6ec7c684de197fa065.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c3dc33e16c8bbb6d45c0a6ec7c684de197fa065.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 27, 2019 at 03:37:12PM -0700, Yu-cheng Yu wrote:
> On Fri, 2019-08-23 at 16:02 +0200, Peter Zijlstra wrote:
> > On Tue, Aug 13, 2019 at 01:52:09PM -0700, Yu-cheng Yu wrote:
> > 
> > > +static inline pte_t pte_move_flags(pte_t pte, pteval_t from, pteval_t to)
> > > +{
> > > +	if (pte_flags(pte) & from)
> > > +		pte = pte_set_flags(pte_clear_flags(pte, from), to);
> > > +	return pte;
> > > +}
> > 
> > Aside of the whole conditional thing (I agree it would be better to have
> > this unconditionally); the function doesn't really do as advertised.
> > 
> > That is, if @from is clear, it doesn't endeavour to make sure @to is
> > also clear.
> > 
> > Now it might be sufficient, but in that case it really needs a comment
> > and or different name.
> > 
> > An implementation that actually moves the bit is something like:
> > 
> > 	pteval_t a,b;
> > 
> > 	a = native_pte_value(pte);
> > 	b = (a >> from_bit) & 1;
> > 	a &= ~((1ULL << from_bit) | (1ULL << to_bit));
> > 	a |= b << to_bit;
> > 	return make_native_pte(a);
> 
> There can be places calling pte_wrprotect() on a PTE that is already RO +
> DIRTY_SW.  Then in pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW) we do not
>  want to clear _PAGE_DIRTY_SW.  But, I will look into this and make it more
> obvious.

Well, then the name 'move' is just wrong, because that is not the
semantics you're looking for.

So the thing is; if you provide a generic function that 'munges' two
bits, then it's name had better be accurate. But AFAICT you only ever
used this for the DIRTY bits, so it might be better to have a function
specifically for that and with a comment that spells out the exact
semantics and reasons for them.
