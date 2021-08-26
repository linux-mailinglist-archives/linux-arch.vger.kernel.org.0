Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9972A3F8C75
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbhHZQup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 12:50:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243057AbhHZQuo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Aug 2021 12:50:44 -0400
Received: from zn.tnic (p200300ec2f131000dba9b80c472eda01.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1000:dba9:b80c:472e:da01])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D62201EC05A0;
        Thu, 26 Aug 2021 18:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629996590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xrrLoUFQeTzSv38tX8kg/sBY3s9iE6Grlnu4Ib+IL4w=;
        b=Niz6S7oZDR2Axj3lptRap8tMoCfDtYU0aCE/5Ruk8qqTLxFk4LNQ3Yb9tm2laIvHHeU9xg
        RY9zVoTSpMpeYsaJrK/baDxYAh7/jRThR7B7v3AN/yQG8N8w/MVg6288Rrsjhye+e/lXwa
        8WPKCUbtMwXvxyQ4bDhuAA87KVWHCss=
Date:   Thu, 26 Aug 2021 18:50:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v29 25/32] x86/cet/shstk: Handle thread shadow stack
Message-ID: <YSfGUlGJdV/5EcBs@zn.tnic>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-26-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820181201.31490-26-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 20, 2021 at 11:11:54AM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 5993aa8db338..7c1ca2476a5e 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -75,6 +75,61 @@ int shstk_setup(void)
>  	return err;
>  }
>  
> +int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> +			     unsigned long stack_size)
> +{
> +	struct thread_shstk *shstk = &tsk->thread.shstk;
> +	struct cet_user_state *state;
> +	unsigned long addr;
> +
> +	if (!shstk->size)
> +		return 0;
> +
> +	/*
> +	 * Earlier clone() does not pass stack_size.  Use RLIMIT_STACK and

What is "earlier clone()"?

> +	 * cap to 4 GB.
> +	 */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
