Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE37406F2
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 01:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjF0XqE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 19:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0XqD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 19:46:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81C199E;
        Tue, 27 Jun 2023 16:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687909562; x=1719445562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JwRZ15P1mfvGvsAhRba9m3i1avJ8D0VfdP6uCJ0rkDA=;
  b=TtHLiNcPMlyYOWoOu/MKtHtUZDOP23bJW0ac5anl00RRS+Z3acvLi0NV
   QNYcUCNh2fSgFni6CkOzFf+rhrZBrs2QBCgji66N4lApGjGidcoj1prJ4
   U0o7QuPBY6cgQGBjqohgzO2io1nFYE+lZRJNfrP8A1cc+mht4SpUkt8od
   AHQfgSI4TRIuwV0ke6NBwK6rGd2CxuNcNgyq0pzxm30oyExvTyKE57X59
   d+iTaA/NGCU4LVtGD54lhl0fUg6rJ1MX/Ogm+4vJmqfhLA1HqExui/bqq
   n/svSmEMcflUEhg8o0OLvO4QpgaMEUsCfJXYYfs9HihyAmfrUwsy6Sq1n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="342046596"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="342046596"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="716711566"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="716711566"
Received: from btalbott-mobl.amr.corp.intel.com (HELO [10.212.238.85]) ([10.212.238.85])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:46:01 -0700
Message-ID: <fb9b4f10-b824-4e3c-d29f-f8bbb030cd96@intel.com>
Date:   Tue, 27 Jun 2023 16:46:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 28/42] x86/shstk: Add user-mode shadow stack support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-29-rick.p.edgecombe@intel.com>
 <76a87cdf-4d4f-4b3f-b01f-0540eab71ac7@sirena.org.uk>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <76a87cdf-4d4f-4b3f-b01f-0540eab71ac7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/27/23 10:20, Mark Brown wrote:
> On Mon, Jun 12, 2023 at 05:10:54PM -0700, Rick Edgecombe wrote:
> 
>> +static void unmap_shadow_stack(u64 base, u64 size)
>> +{
>> +	while (1) {
>> +		int r;
>> +
>> +		r = vm_munmap(base, size);
>> +
>> +		/*
>> +		 * vm_munmap() returns -EINTR when mmap_lock is held by
>> +		 * something else, and that lock should not be held for a
>> +		 * long time.  Retry it for the case.
>> +		 */
>> +		if (r == -EINTR) {
>> +			cond_resched();
>> +			continue;
>> +		}
> This looks generic, not even shadow stack specific - was there any
> discussion of making it a vm_munmap_retry() (that's not a great name...)
> or similar?  I didn't see any in old versions of the thread but I
> might've missed something.

Yeah, that looks odd.  Also odd is that none of the other users of
vm_munmap() bother to check the return value (except for one passthrough
in the nommu code).

I don't think the EINTR happens during contention, though.  It's really
there to be able break out in the face of SIGKILL.  I think that's why
nobody handles it: the task is dying anyway and nobody cares.

Rick, was this hunk here for a specific reason or were you just trying
to be diligent in handling errors?
