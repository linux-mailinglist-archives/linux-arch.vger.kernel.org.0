Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63395F36D0
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJCUEo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJCUEn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 16:04:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F5C7E;
        Mon,  3 Oct 2022 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664827481; x=1696363481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y6lmOQaQb09t80GLATBzGHheq+H668G2htPXwlOpJUk=;
  b=O/R2MCGTYoaAVOT7dnsuuAab8+LxU9650iOBKpYVbaWQtRuU0bCMzXdE
   m3Z6gFShbDPzVV6Kzw8QzP5IjaUyel+V3ngeMdQuvPEHaXkGHuevAltsZ
   QxSiqE8q+MiWrzkQx9Jm2bds8ly3qvBDfmRnVlBhDWZdnc0QVp/M8JoiD
   Ae81inV/a+Vy2fAavv+RaYbER8XbXgz1xmTkc9T/CB90RRqnGvbRo7DeB
   L2baVvrUoxN+M1Dj5iurvWzj+eIkZ3UHyV0aD2A55VdSnICaz4bgXz3yB
   3QE6Ep80vznq6T811mPfSO0p4sh8U8PpLB+9cz4wdcW02jcoA33eNyxex
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="303709494"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="303709494"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 13:04:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="686277425"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="686277425"
Received: from akashred-mobl.amr.corp.intel.com (HELO [10.212.139.217]) ([10.212.139.217])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 13:04:37 -0700
Message-ID: <474d3aca-0cf0-8962-432b-77ac914cc563@intel.com>
Date:   Mon, 3 Oct 2022 13:04:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-25-rick.p.edgecombe@intel.com>
 <202210031203.EB0DC0B7DD@keescook>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <202210031203.EB0DC0B7DD@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/22 12:43, Kees Cook wrote:
>> +static inline void set_clr_bits_msrl(u32 msr, u64 set, u64 clear)
>> +{
>> +	u64 val, new_val;
>> +
>> +	rdmsrl(msr, val);
>> +	new_val = (val & ~clear) | set;
>> +
>> +	if (new_val != val)
>> +		wrmsrl(msr, new_val);
>> +}
> I always get uncomfortable when I see these kinds of generalized helper
> functions for touching cpu bits, etc. It just begs for future attacker
> abuse to muck with arbitrary bits -- even marked inline there is a risk
> the compiler will ignore that in some circumstances (not as currently
> used in the code, but I'm imagining future changes leading to such a
> condition). Will you humor me and change this to a macro instead? That'll
> force it always inline (even __always_inline isn't always inline):

Oh, are you thinking that this is dangerous because it's so surgical and
non-intrusive?  It's even more powerful to an attacker than, say
wrmsrl(), because there they actually have to know what the existing
value is to update it.  With this helper, it's quite easy to flip an
individual bit without disturbing the neighboring bits.

Is that it?

I don't _like_ the #defines, but doing one here doesn't seem too onerous
considering how critical MSRs are.
