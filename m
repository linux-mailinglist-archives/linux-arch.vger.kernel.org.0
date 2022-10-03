Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3B5F38AB
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 00:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJCWOo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 18:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJCWOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 18:14:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1FE51A38;
        Mon,  3 Oct 2022 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664835267; x=1696371267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hzc2df+MLVVbc4Zq72Mgkf8FxKiTS251nfNBExvVIT8=;
  b=iu0EAJ5Q5DWl/PjKVxggbVQDyobQKlljNf/4JRzs0HEgm/KDp0pMkY53
   br03BeFzYVaLevsSmm4VNwvlR64DN+Negf3aWDKNktddRSNG2BybBTLZo
   BemWkoGxA2vkycVzdQEGaqncbpvPH0Twd8NCIyGmMAvMa9L35H771oL84
   PsesPcONA45UntjZ62Max7ZKalq0vhe7Z7cs/DwrhZhysUylWAKE23WIJ
   o3Eli3RENhMQu36lBTSFDnBwiHyEdloB73W8mABun8kf1mR8iheRUBuXZ
   DPXjgs8p6pNnI/wFKuHE9oPf+0kSR8hZIy+9RJ6eVI/mZ4rHvSFE5R9GM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366870606"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366870606"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:14:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="625963353"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="625963353"
Received: from akashred-mobl.amr.corp.intel.com (HELO [10.212.139.217]) ([10.212.139.217])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:14:23 -0700
Message-ID: <a1345893-4b76-e224-f68f-ff27857b6feb@intel.com>
Date:   Mon, 3 Oct 2022 15:14:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-11-rick.p.edgecombe@intel.com>
 <20221003162613.2yvhvb6hmnae2awz@box.shutemov.name>
 <9e9f2ce8193ea2e86474ab999ad2a034c49d8b22.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <9e9f2ce8193ea2e86474ab999ad2a034c49d8b22.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/22 14:36, Edgecombe, Rick P wrote:
>>> +static inline pte_t pte_clear_cow(pte_t pte)
>>> +{
>>> +     /*
>>> +      * _PAGE_COW is unnecessary on !X86_FEATURE_SHSTK kernels.
>>> +      * See the _PAGE_COW definition for more details.
>>> +      */
>>> +     if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
>>> +             return pte;
>>> +
>>> +     /*
>>> +      * PTE is getting copied-on-write, so it will be dirtied
>>> +      * if writable, or made shadow stack if shadow stack and
>>> +      * being copied on access. Set they dirty bit for both
>>> +      * cases.
>>> +      */
>>> +     pte = pte_set_flags(pte, _PAGE_DIRTY);
>>> +     return pte_clear_flags(pte, _PAGE_COW);
>>> +}
>> These X86_FEATURE_SHSTK checks make me uneasy. Maybe use the
>> _PAGE_COW
>> logic for all machines with 64-bit entries. It will get you much more
>> coverage and more universal rules.
> Yes, I didn't like them either at first. The reasoning originally was
> that _PAGE_COW is a bit more work and it might show up for some
> benchmark.
> 
> Looking at this again though, it is just a few more operations on
> memory that is already getting touched either way. It must be a very
> tiny amount of impact if any. I'm fine removing them. Having just one
> set of logic around this would make it easier to reason about.
> 
> Dave, any thoughts on this?

The cpu_feature_enabled(X86_FEATURE_SHSTK) checks enable both
compile-time and runtime optimization.  What makes this even more fun is:

+#ifdef CONFIG_X86_SHADOW_STACK
+#define _PAGE_COW      (_AT(pteval_t, 1) << _PAGE_BIT_COW)
+#else
+#define _PAGE_COW      (_AT(pteval_t, 0))
+#endif

which I think means that the pte_clear_flags() goes away if
CONFIG_X86_SHADOW_STACK is disabled.  So, what Rick posted here ends up
doing the following with:

	  | X86_FEATURE_SHSTK=1	|  X86_FEATURE_SHSTK=0
==========+=====================+========================
CONFIG=n  |  compiled out	|  compiled out
CONFIG=y  |  set/clear		|  boot-time patched out


If we pull the cpu_feature_enabled() out, I think we end up getting
behavior like this:

	  | X86_FEATURE_SHSTK=1	|  X86_FEATURE_SHSTK=0
==========+=====================+========================
CONFIG=n  |  set _PAGE_DIRTY	|  set _PAGE_DIRTY
CONFIG=y  |  set/clear		|  set/clear

It ends up adding instruction overhead (set _PAGE_DIRTY) to two cases
where it completely compiled out before.  It also adds runtime overhead
(the "tiny amount of impact" you mentioned) to set/clear where it would
have runtime patched out before.

None of this is a deal breaker in terms of runtime overhead.  But, I do
think the benefits of the cpu_feature_enabled() are worth it, even if
it's just an optimization.  You could move it to the end of the series
and we can debate it on its own merits if you want.

