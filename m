Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537343854A
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfFGHoY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 03:44:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGHoX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 03:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JShvpN7WursRgWDXz41S2caRK10woHUgD4tuDRKgTsc=; b=1S7ljWD5ClCiKXft78kkDXYzu
        BR5E9SvvKZIxdJe1mhQhdLj/GwLRgpPtPTkqFWmg9yqjwQNhVjrPRSIeL/OoZlxczwx//D68q1XJs
        FfByu9/q4FNFB5MXMSXJOJgnvL+2AJsWyK9lsq/Ah8896IEYsL9RTqGpSzTSuB3kfr8fec3EzuxQ/
        65SeGDN5iK4k08dfXCNFi4ombF+WbCqRMUKIS3vXBM5VM3WBfBI8n3Yv55ZdItHAuZ42Kr9bR+wpr
        j2D8T94McWzfsRBDWW4DzC7eThiUDI9XwBhKlICynz4wC6UJFeY7+mKw6hOTG2CA3XB8AR1FgneV1
        THzrvW5Mw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hZ9X3-0002X3-7w; Fri, 07 Jun 2019 07:43:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 394D5202CD6B2; Fri,  7 Jun 2019 09:43:22 +0200 (CEST)
Date:   Fri, 7 Jun 2019 09:43:22 +0200
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
Subject: Re: [PATCH v7 18/27] mm: Introduce do_mmap_locked()
Message-ID: <20190607074322.GP3419@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-19-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200646.3951-19-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 06, 2019 at 01:06:37PM -0700, Yu-cheng Yu wrote:
> There are a few places that need do_mmap() with mm->mmap_sem held.
> Create an in-line function for that.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  include/linux/mm.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 398f1e1c35e5..7cf014604848 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2411,6 +2411,24 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
>  static inline void mm_populate(unsigned long addr, unsigned long len) {}
>  #endif
>  
> +static inline unsigned long do_mmap_locked(unsigned long addr,
> +	unsigned long len, unsigned long prot, unsigned long flags,
> +	vm_flags_t vm_flags)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long populate;
> +
> +	down_write(&mm->mmap_sem);
> +	addr = do_mmap(NULL, addr, len, prot, flags, vm_flags, 0,
> +		       &populate, NULL);

Funny thing how do_mmap() takes a file pointer as first argument and
this thing explicitly NULLs that. That more or less invalidates the name
do_mmap_locked().

> +	up_write(&mm->mmap_sem);
> +
> +	if (populate)
> +		mm_populate(addr, populate);
> +
> +	return addr;
> +}


