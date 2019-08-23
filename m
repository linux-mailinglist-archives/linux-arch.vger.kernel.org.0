Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2329B185
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbfHWOCx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 10:02:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389723AbfHWOCx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Aug 2019 10:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TlgSQbGZQbJS6HSDwi/9wyBYZmrJdjzuU/XfSgcoVhk=; b=ZjSOzcnGcfW/LTdzeR/cMRrGu
        hM5Ku9PVLtYuui8pFAfhIb6v0R6YOO5qjsMuw7dvWVbFpD+i5Z5PqZ9ahOHejsSTlE9wrd+apSRUZ
        1r1B6ol8fjseEyO1nHBCb4O2rZ9vMWpl2zedqIxRFO1cadKFaGAE9Y1lH/npc5yz38/ld/lub0fE/
        DC9LG7mINAvxT7HwTNVePM1CgJxvR+bPTXgQgq9bjLe4pZylvKfJQBGc0hX4lCccOU3PI2F1F0e6d
        OWGqm8f1dndYs52YG854QIFZs9ZzNF/Prwi1z8CqHiUww9N5xeH+mB6o5TaLm7HcIvoIVnvkAMFJ0
        c1zcqv41Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i1A9E-0006Qi-4s; Fri, 23 Aug 2019 14:02:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 415B1305F65;
        Fri, 23 Aug 2019 16:02:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4044202245EA; Fri, 23 Aug 2019 16:02:33 +0200 (CEST)
Date:   Fri, 23 Aug 2019 16:02:33 +0200
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
Message-ID: <20190823140233.GC2332@hirez.programming.kicks-ass.net>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
 <20190813205225.12032-12-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813205225.12032-12-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:52:09PM -0700, Yu-cheng Yu wrote:

> +static inline pte_t pte_move_flags(pte_t pte, pteval_t from, pteval_t to)
> +{
> +	if (pte_flags(pte) & from)
> +		pte = pte_set_flags(pte_clear_flags(pte, from), to);
> +	return pte;
> +}

Aside of the whole conditional thing (I agree it would be better to have
this unconditionally); the function doesn't really do as advertised.

That is, if @from is clear, it doesn't endeavour to make sure @to is
also clear.

Now it might be sufficient, but in that case it really needs a comment
and or different name.

An implementation that actually moves the bit is something like:

	pteval_t a,b;

	a = native_pte_value(pte);
	b = (a >> from_bit) & 1;
	a &= ~((1ULL << from_bit) | (1ULL << to_bit));
	a |= b << to_bit;
	return make_native_pte(a);

