Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC83C3938F
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbfFGRnz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 13:43:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfFGRny (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 13:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ib5xcjylzZJYs4tQEX10bx6Iy6PiZBk7Yfn6HEJa6+k=; b=uUV0Qg4RLvuFztCksJatP1vun
        caXXdhBCXJ1/Zff5BaFrpqzvOtmY792iqKlflcEH7L4Ds+nzOZdE00i9/+A2QdpjUZaw8FTm5C0Di
        6a0ESgkewptbth56+PriX5BaJhJVXnuImAz3+GhDF6apj0C5KkbXzhVOPvgP9z/JpZvioXldA2ZyH
        zuy1FnNgL5zmKuiuFAWNNtxXbReWZY/rsPt+VJwglRFELnGzRDXjgtIXTDTsSXd0TqgtRtMjweOwZ
        c+Gb5zmZMbrHo49WAIM2sc6JhZRZ7FubJesd/SG9HdwisS9G3VLMjnBNop6B3+O0rZ9//FQS4z8+R
        sYPvGd5CA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZItt-0006lL-Ul; Fri, 07 Jun 2019 17:43:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C02B20216A2F; Fri,  7 Jun 2019 19:43:36 +0200 (CEST)
Date:   Fri, 7 Jun 2019 19:43:36 +0200
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
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
Message-ID: <20190607174336.GM3436@hirez.programming.kicks-ass.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
 <20190606200926.4029-4-yu-cheng.yu@intel.com>
 <20190607080832.GT3419@hirez.programming.kicks-ass.net>
 <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 07, 2019 at 09:23:43AM -0700, Yu-cheng Yu wrote:
> On Fri, 2019-06-07 at 10:08 +0200, Peter Zijlstra wrote:
> > On Thu, Jun 06, 2019 at 01:09:15PM -0700, Yu-cheng Yu wrote:
> > > Indirect Branch Tracking (IBT) provides an optional legacy code bitmap
> > > that allows execution of legacy, non-IBT compatible library by an
> > > IBT-enabled application.  When set, each bit in the bitmap indicates
> > > one page of legacy code.
> > > 
> > > The bitmap is allocated and setup from the application.
> > > +int cet_setup_ibt_bitmap(unsigned long bitmap, unsigned long size)
> > > +{
> > > +	u64 r;
> > > +
> > > +	if (!current->thread.cet.ibt_enabled)
> > > +		return -EINVAL;
> > > +
> > > +	if (!PAGE_ALIGNED(bitmap) || (size > TASK_SIZE_MAX))
> > > +		return -EINVAL;
> > > +
> > > +	current->thread.cet.ibt_bitmap_addr = bitmap;
> > > +	current->thread.cet.ibt_bitmap_size = size;
> > > +
> > > +	/*
> > > +	 * Turn on IBT legacy bitmap.
> > > +	 */
> > > +	modify_fpu_regs_begin();
> > > +	rdmsrl(MSR_IA32_U_CET, r);
> > > +	r |= (MSR_IA32_CET_LEG_IW_EN | bitmap);
> > > +	wrmsrl(MSR_IA32_U_CET, r);
> > > +	modify_fpu_regs_end();
> > > +
> > > +	return 0;
> > > +}
> > 
> > So you just program a random user supplied address into the hardware.
> > What happens if there's not actually anything at that address or the
> > user munmap()s the data after doing this?
> 
> This function checks the bitmap's alignment and size, and anything else is the
> app's responsibility.  What else do you think the kernel should check?

I've no idea what the kernel should do; since you failed to answer the
question what happens when you point this to garbage.

Does it then fault or what?
