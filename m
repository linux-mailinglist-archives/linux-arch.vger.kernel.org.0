Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC33385C7
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 09:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfFGHyl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 03:54:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfFGHyl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 03:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xvljMUbhfLfotrIrCrjLlY8mPPXR4L/80hig3F5dpFs=; b=UuIzSHZ9YwR97SKzqkrVCQI+v
        GffCOVEUdSut0lgJr1DyKcWI+cWHHzHrMXcEBJ2OpppuG/N80JVQSOEK+VzI712E7KCva3L3Oj+f0
        wHJc1XpVbUaW20zGOy62EuE8N+ZKgZisPSwfMvDlnRyAKYVLc9t6OeD58tvZxg7MCJ/s95lkMdrbb
        jWQGX9wKVnrA6sUspkFQIWtCU6de6Wab9dRrjqza83D+MCJoGEBn0S7xBdDsQTlGZuimzmU6t4rYQ
        OJgCbv6CW3/40aaEa3b8cdd0nZXt4jIAWjlMKAyoxsqKGKU+7jceUr/GN7egWsIPxqBBh2iFtOch4
        liJ2fFuFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZ9hl-0004MJ-Nx; Fri, 07 Jun 2019 07:54:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37DA4205663B2; Fri,  7 Jun 2019 09:54:28 +0200 (CEST)
Date:   Fri, 7 Jun 2019 09:54:28 +0200
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
Subject: Re: [PATCH v7 23/27] x86/cet/shstk: ELF header parsing of Shadow
 Stack
Message-ID: <20190607075428.GQ3419@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-24-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200646.3951-24-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 06, 2019 at 01:06:42PM -0700, Yu-cheng Yu wrote:

> +#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
> +int arch_setup_property(void *ehdr, void *phdr, struct file *f, bool inter)
> +{
> +	int r;
> +	uint32_t property;

Flip those two lines around.

> +
> +	r = get_gnu_property(ehdr, phdr, f, GNU_PROPERTY_X86_FEATURE_1_AND,
> +			     &property);
> +
> +	memset(&current->thread.cet, 0, sizeof(struct cet_status));

It seems to me that memset would be better placed before
get_gnu_property().

> +	if (r)
> +		return r;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {

	if (r || !cpu_feature_enabled())
		return r;

> +		if (property & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
> +			r = cet_setup_shstk();
> +		if (r < 0)
> +			return r;
> +	}
> +	return r;

and loose the indent.

> +}
> +#endif
> -- 
> 2.17.1
> 
