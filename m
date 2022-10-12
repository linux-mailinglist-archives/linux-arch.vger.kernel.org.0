Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3275FC8CC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJLQAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJLQAA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 12:00:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A341A83A;
        Wed, 12 Oct 2022 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665590397; x=1697126397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x+Vvi8HGhrn79pVpDuauzqv2LPYrdQbCpKoSgkWyCaQ=;
  b=N7H43qoXTLbxJSfPjHM4NCPeS1rlSqKT03ZpBOZfCc1HCUKHpvN2S7Lc
   /LWM+V7kffocXoUn8fZCkc0Z7cVyGwDk/Qmaal8Bqzu04A3nbtWoinE6P
   69fKUtdPsCQA6HW+mZJa17pRGrRd3fUTd+w0ZgxhPDX0PxFXkjyKwO86+
   V3kK5xp/YaluMUOKgQcpyz1jxamEzBO0mqSyx6ybe7FnAYp3w9cvJ1S/Z
   63o7Kad+a/GYCNvcEdllfimxNhzEr5FA95UOHelCKBzmqmvyilpYSImZx
   yz98Lw1AdjlaJFeIZ6hcwx2bnHKijetXcPTFBoa2eOwoNU8cSozsmEXUS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="304818430"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="304818430"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:59:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="695522374"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="695522374"
Received: from mpatter1-mobl.amr.corp.intel.com (HELO [10.209.53.34]) ([10.209.53.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:59:51 -0700
Message-ID: <e3c3d68d-ce99-a70a-1026-0ba99520ae57@intel.com>
Date:   Wed, 12 Oct 2022 08:59:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
 <87ilkr27nv.fsf@oldenburg.str.redhat.com>
 <62481017bc02b35587dd520ed446a011641aa390.camel@intel.com>
 <87v8opz0me.fsf@oldenburg.str.redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <87v8opz0me.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/12/22 05:29, Florian Weimer wrote:
>> What did you think of the proposal to disable existing binaries and
>> start from scratch? Elaborated in the coverletter in the section
>> "Compatibility of Existing Binaries/Enabling Interface".
> The ABI was finalized around four years ago, and we have shipped several
> Fedora and Red Hat Enterprise Linux versions with it.  Other
> distributions did as well.  It's a bit late to make changes now, and
> certainly not for such trivialities. 

Just to be clear: You're saying that a user/kernel ABI was "finalized"
by glibc shipping the user side of it, before there being an upstream
kernel implementation?
