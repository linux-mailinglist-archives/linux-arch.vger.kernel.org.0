Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA86A62A20E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 20:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiKOTi6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 14:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKOTiz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 14:38:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9A1FD3B;
        Tue, 15 Nov 2022 11:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m/idPlmlMSHYNd4VPV/uZ+42R303Fem83Y9Bl6HGhEk=; b=QB/jjPrQQAT8hA+XnNLKn5newW
        3sIB6p85AcVqg9GDTQd5XWrkPSGYi7VE7q/AVPmk3oA5zsywMXiE2K9+PbdWTCSfcSsBQQ/rat+Zq
        69IMgrgyQ1lr9mR6+2Z+yLZ0MOqLL9g8Eqx9nzn3mGUmjIPmdJyZvm/Ux4PM9ZDRSxvF9allMdE6h
        r48VCIodLTC3ZoFqCUFvx/x6AE/BaoBzheW3DGE4ScZYnDQ/Xgoa594c/Ns9X0PNh+xB56z/RtxdX
        kFFbMpPqHRpwE7hXwGN0JkqawQrlYLsjvzVEeAUouU8S6FJNz5HjDXNvDEiMY76cQne9+ZCPCzS5T
        19aD/+KA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov1lT-00GYBj-0V; Tue, 15 Nov 2022 19:38:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21F70300C6F;
        Tue, 15 Nov 2022 13:32:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 094CE2C36896F; Tue, 15 Nov 2022 13:32:31 +0100 (CET)
Date:   Tue, 15 Nov 2022 13:32:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v3 25/37] x86/shstk: Add user-mode shadow stack support
Message-ID: <Y3OG31hoj/q4Bgh7@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-26-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104223604.29615-26-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 04, 2022 at 03:35:52PM -0700, Rick Edgecombe wrote:

> +static int shstk_setup(void)
> +{
> +	struct thread_shstk *shstk = &current->thread.shstk;
> +	unsigned long addr, size;
> +
> +	/* Already enabled */
> +	if (features_enabled(CET_SHSTK))
> +		return 0;
> +
> +	/* Also not supported for 32 bit and x32 */
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_32bit_syscall())
> +		return -EOPNOTSUPP;
> +
> +	size = adjust_shstk_size(0);
> +	addr = alloc_shstk(size);
> +	if (IS_ERR_VALUE(addr))
> +		return PTR_ERR((void *)addr);
> +
> +	fpregs_lock_and_load();
> +	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
> +	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);

This..

> +	fpregs_unlock();
> +
> +	shstk->base = addr;
> +	shstk->size = size;
> +	features_set(CET_SHSTK);
> +
> +	return 0;
> +}

> +static int shstk_disable(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return -EOPNOTSUPP;
> +
> +	/* Already disabled? */
> +	if (!features_enabled(CET_SHSTK))
> +		return 0;
> +
> +	fpregs_lock_and_load();
> +	/* Disable WRSS too when disabling shadow stack */
> +	set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_SHSTK_EN);

And this... aren't very consistent in approach. Given there is no U_IBT
yet, why complicate matters like this?

> +	wrmsrl(MSR_IA32_PL3_SSP, 0);
> +	fpregs_unlock();
> +
> +	shstk_free(current);
> +	features_clr(CET_SHSTK);
> +
> +	return 0;
> +}
