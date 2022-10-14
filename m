Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6129D5FF174
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJNPdx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiJNPdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 11:33:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E142B9B86E;
        Fri, 14 Oct 2022 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tcM8guTF51y4dORNbVL0TNPgqKXsDWO1cxQKagb6RpQ=; b=WVap/vaDDQsosYCxpzXStdd50N
        Xk2922O8Nbnqsjsb7+6hUodsPGVCrgVKrgsn6NfJbcuv4mwas/y+srH7BfoI2LqFrwhgi10jfsRA5
        BF5HbdvfzMysaPdmw34TGJWtYFtfTuuYzrMdn5E4wZaR/0h+CS+5Lnjj8/qEz9fk+crwilALA5lcd
        9vyrq/l1kfFZRojAVxnCzyxStxB5YJ4n7DHWVFx7y6nbeh/ctE5/IXQaj3VZTKyKCpdrmYIup4hIp
        AsBs24qOaZHKyxFCm7DrkIKq/qg/Idd5PdX88EJkUS3LBwmoVyLOnJfA5QcfscgRUwmW1tqkjEaWb
        ymkHe8ig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojMfw-003RUm-BQ; Fri, 14 Oct 2022 15:32:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 248EA30004F;
        Fri, 14 Oct 2022 17:32:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D9852C1B0A4D; Fri, 14 Oct 2022 17:32:39 +0200 (CEST)
Date:   Fri, 14 Oct 2022 17:32:38 +0200
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
Subject: Re: [PATCH v2 16/39] x86/mm: Update maybe_mkwrite() for shadow stack
Message-ID: <Y0mBFjfOAA+hJcUn@hirez.programming.kicks-ass.net>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-17-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-17-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:13PM -0700, Rick Edgecombe wrote:

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8cd413c5a329..fef14ab3abcb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -981,13 +981,25 @@ void free_compound_page(struct page *page);
>   * servicing faults for write access.  In the normal case, do always want
>   * pte_mkwrite.  But get_user_pages can cause write faults for mappings
>   * that do not have writing enabled, when used by access_process_vm.
> + *
> + * If a vma is shadow stack (a type of writable memory), mark the pte shadow
> + * stack.
>   */
> +#ifndef maybe_mkwrite
>  static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>  {
> -	if (likely(vma->vm_flags & VM_WRITE))
> +	if (!(vma->vm_flags & VM_WRITE))
> +		goto out;
> +
> +	if (vma->vm_flags & VM_SHADOW_STACK)
> +		pte = pte_mkwrite_shstk(pte);
> +	else
>  		pte = pte_mkwrite(pte);
> +
> +out:
>  	return pte;
>  }
> +#endif

Why the #ifndef guard? There is no other implementation, nor does this
patch introduce one.

Also, wouldn't it be simpler to write it like:

static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
{
	if (!(vma->vm_flags & VM_WRITE))
		return pte;

	if (vma->vm_flags & VM_SHADOW_STACK)
		return pte_mkwrite_shstk(pte);

	return pte_mkwrite(pte);
}

? (idem for the pmd version etc..)
