Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849E51DE33B
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgEVJgp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 05:36:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgEVJgo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 05:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c7wce+6/DBIYjkCyqWElBhrfpiCn+9+Nidad9WAJ8xQ=; b=GS7WZ35rrw0FFrzlc9tBdIUrEc
        AC2C2hlrz0cbztdEX4e2704LmbeAVy9pVGEPBw33HfOWw08qBCBsFN0bCz8z+oo2ai1Q4hju/u5kC
        tw+XLZ4f0z0bp/Kjy+0wnCvH/76psO0MEjhDNjeeRD2lrS00xG8UJzaByqHXOhfh5KN+DsoVq6Dd2
        s1fM00t3BMT8n1ZTxUZVwC7wzHtxDNL7RT9cy7pE1wzgY/alhkhOLrT4mRCQLSfjr90gEwqGb7Plc
        7JebFJB3UubdvwK8Zw34xPkJJ3vNBbm/yr1X2BeCRF8NYlRwlnDLHMgOP6bZZJIJ85kgE9dGQVfg2
        v3FyyN+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jc3z8-0004uu-Qs; Fri, 22 May 2020 09:28:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C481530018B;
        Fri, 22 May 2020 11:28:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B428D212820ED; Fri, 22 May 2020 11:28:48 +0200 (CEST)
Date:   Fri, 22 May 2020 11:28:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Message-ID: <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521211720.20236-6-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 21, 2020 at 02:17:20PM -0700, Yu-cheng Yu wrote:

> +#pragma GCC push_options
> +#pragma GCC optimize ("O0")
> +void ibt_violation(void)
> +{
> +#ifdef __i386__
> +	asm volatile("lea 1f, %eax");
> +	asm volatile("jmp *%eax");
> +#else
> +	asm volatile("lea 1f, %rax");
> +	asm volatile("jmp *%rax");
> +#endif
> +	asm volatile("1:");
> +	result[test_id] = -1;
> +	test_id++;
> +	setcontext(&ucp);
> +}
> +
> +void shstk_violation(void)
> +{
> +#ifdef __i386__
> +	unsigned long x = 0;
> +
> +	((unsigned long *)&x)[2] = (unsigned long)stack_hacked;
> +#else
> +	unsigned long long x = 0;
> +
> +	((unsigned long long *)&x)[2] = (unsigned long)stack_hacked;
> +#endif
> +}
> +#pragma GCC pop_options

This is absolutely atrocious.

The #pragma like Kees already said just need to go. Also, there's
absolutely no clue what so ever what it attempts to achieve.

The __i386__ ifdeffery is horrible crap. Splitting an asm with #ifdef
like that is also horrible crap.

This is not how you write code.

Get asm/asm.h into userspace and then write something like:


void ibt_violation(void)
{
	asm volatile("lea  1f, %" _ASM_AX "\n\t"
		     "jmp  *%" _ASM_AX "\n\t"
		     "1:\n\t" ::: "a");

	WRITE_ONCE(result[test_id], -1);
	WRITE_ONCE(test_id, test_id+1);

	setcontext(&ucp);
}

void shstk_violation(void)
{
	unsigned long x = 0;

	WRITE_ONCE(x[2], stack_hacked);
}


