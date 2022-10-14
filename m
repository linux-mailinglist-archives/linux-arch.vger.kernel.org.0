Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575785FEBF3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 11:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJNJm5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJNJmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 05:42:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA814DF2A;
        Fri, 14 Oct 2022 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j68hgOrkjo4GGasFG1vTrc8ztTwD88q1qsBwVyQ1Wuc=; b=MplQU52fBaglr236u9ScGhovH3
        oOemWW9AmwGD+pFB09HHDp1rdG3ndu7ekn1V+qkqm3uBaDsMYnUotdB7imWv+t6zzv3H+KExDqTZH
        zKwL3dD2GA2ikVFDkzoxMtwm/CjDFTMHCpiWjcKRk5GBo1ePsEJ38D4GztebpoTTMU2f8TQxF+jJB
        C7OqWXh/odDEmNX4XTSx1HytVPHwFvgh3J3g7ZZ1aEfWlMUPgzqW+HWH51pyqV9ncmxfqywnTSlAW
        kGYouxzMG/Lbp8dgUw0CtWpDrAFZnii6CVq0XtPQXx4xNwpTdfNlpUyplPHQhgD2yaoYKiHpz1K4H
        2S/T03yw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojHD1-007W9P-Dq; Fri, 14 Oct 2022 09:42:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8619430012F;
        Fri, 14 Oct 2022 11:42:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71B1B2C164D13; Fri, 14 Oct 2022 11:42:22 +0200 (CEST)
Date:   Fri, 14 Oct 2022 11:42:22 +0200
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
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Message-ID: <Y0ku/kgLrs77rGxz@hirez.programming.kicks-ass.net>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-11-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-11-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:07PM -0700, Rick Edgecombe wrote:
> @@ -300,6 +324,44 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
>  	return native_make_pte(v & ~clear);
>  }
>  
> +/*
> + * Normally the Dirty bit is used to denote COW memory on x86. But

This is misleading; this isn't an x86 specific thing. The core-mm code
does this.

> + * in the case of X86_FEATURE_SHSTK, the software COW bit is used,
> + * since the Dirty=1,Write=0 will result in the memory being treated
> + * as shaodw stack by the HW. So when creating COW memory, a software
> + * bit is used _PAGE_BIT_COW. The following functions pte_mkcow() and
> + * pte_clear_cow() take a PTE marked conventially COW (Dirty=1) and
> + * transition it to the shadow stack compatible version of COW (Cow=1).
> + */
