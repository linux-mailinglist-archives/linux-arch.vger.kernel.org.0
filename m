Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7EF5F35E0
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJCSvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJCSvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:51:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D71DA58;
        Mon,  3 Oct 2022 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664823078; x=1696359078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sHpGmhITtQ8yrxSaq/GvsC2XRU7DBrZMlLdnk0v7/Vs=;
  b=X1ni+Hwut12couTZuwI2cVQ184Q6S1Kzj5rc31U3OTm6/wSIJtwqKI1/
   uKdOOSWvNwUE5J8Rd7o0o5z8E9QDSjVmuc0c+D/5ngy2IsMpQ4EaR91GH
   tUaQX5DaiQ9uqwyobw24pRipleirSvEte36R07cjYMWQiggUDiv/pnLwi
   xHd+fuaJTKBdiGZqATKyylVe0GiIPG0bpUUM0bXUmRtqlyRXMCT5U8BHy
   UlCtJNdWEDQDmiBFq6OzoElZu4644Uf0sMlEiQlHwGbejN/BCn5ZPhLLD
   IIGR9FGFqHkbD7SWcvtZDzldqPU/xJBPJTohxkgxFC77nD3qqUeOc25NZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="300333988"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="300333988"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 11:51:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="601347405"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="601347405"
Received: from akashred-mobl.amr.corp.intel.com (HELO [10.212.139.217]) ([10.212.139.217])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 11:51:16 -0700
Message-ID: <023ee88b-1f23-acb6-9ac6-c75afbcb09d9@intel.com>
Date:   Mon, 3 Oct 2022 11:51:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Mike Rapoport <rppt@kernel.org>, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-13-rick.p.edgecombe@intel.com>
 <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/22 11:11, Nadav Amit wrote:
>> +#ifdef CONFIG_X86_SHADOW_STACK
>> +	/*
>> +	 * Avoid accidentally creating shadow stack PTEs
>> +	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
>> +	 * the hardware setting Dirty=1.
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>> +		pte_t old_pte, new_pte;
>> +
>> +		old_pte = READ_ONCE(*ptep);
>> +		do {
>> +			new_pte = pte_wrprotect(old_pte);
>> +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
>> +
>> +		return;
>> +	}
>> +#endif
> There is no way of using IS_ENABLED() here instead of these ifdefs?

Actually, both the existing #ifdef and an IS_ENABLED() check would be
is superfluous as-is.

Adding X86_FEATURE_SHSTK disabled-features.h gives cpu_feature_enabled()
compile-time optimizations for free.  No need for *any* additional
CONFIG_* checks.

The only issue would be if the #ifdef'd code won't even compile with
X86_FEATURE_SHSTK disabled.
