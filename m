Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D404343E55
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 11:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCVKsy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCVKsr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 06:48:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D24C061574;
        Mon, 22 Mar 2021 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hlbTbL1bDzeKPY7EsML2QdUuMjl1zuiAUSBb6VTOOwQ=; b=vq0G7E4dmauEGmK8/emUUDYZon
        NNjYF1OmrbnibpO3sK1EBuqrCPxvPbi1lPhi596vu88weXqmIoZyMZLdhlRZbM3uVaQfI0emm9Jtj
        RiDuBpCWr63s0qIMBMs6uA7WiR86Nj2OLZKxdxjxK5tQwjtWPgy7Y930lSF7TG9vgZJyyYbTPUyKp
        qNhW2Ua6yzlwbRWuoZrQyU2lBXygmzHy5TXRAe0Rka+X0qyfNJqvCwH8GGbej/kUSRULePgXUWtkE
        N1VoPqVRrySUL0/J6X8cKELQoEvhP+Ge+y3YrAIRAN2XxhcT7DnSd4eUgT0BNRTVarEvyRZD88FES
        jFbA8mrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOI4l-008Mnt-8c; Mon, 22 Mar 2021 10:46:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1171E306BCA;
        Mon, 22 Mar 2021 11:46:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED1832BCFBDAA; Mon, 22 Mar 2021 11:46:21 +0100 (CET)
Date:   Mon, 22 Mar 2021 11:46:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 12/28] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <YFh1fabrBok74F8X@hirez.programming.kicks-ass.net>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-13-yu-cheng.yu@intel.com>
 <20210322101502.b5hdy3qgyh6hf3sr@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322101502.b5hdy3qgyh6hf3sr@box>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 22, 2021 at 01:15:02PM +0300, Kirill A. Shutemov wrote:
> On Tue, Mar 16, 2021 at 08:10:38AM -0700, Yu-cheng Yu wrote:

> > +		pte_t old_pte, new_pte;
> > +
> > +		old_pte = READ_ONCE(*ptep);
> > +		do {
> > +			new_pte = pte_wrprotect(old_pte);
> > +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
> 
> I think this is wrong. You need to update old_pte on every loop iteration,
> otherwise you can get in to endless loop.

It is correct, please consider why the old argument is a pointer.
