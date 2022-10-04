Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA0B5F4544
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJDOSs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 10:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJDOSr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 10:18:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976AE2FC2F;
        Tue,  4 Oct 2022 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664893125; x=1696429125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/ZhcxE23XxY+wRDapL4hQYTPECwVP1wjdbRokWF4C6M=;
  b=hDxc17rngdiCzrfqOdO0kCB4KrobUCdfwdygSWb6iT21g46hp8EpG7Fc
   BYfMRpWcIRspHIMcdNeM8UOnm4RUkMa9iZyUDNtnspXfDIpXCltlw/OyY
   xTHf8pAW0rURgbVN175OhHGCuQnRqXcZloBaaVhgg4Idmne/hdMyx2u4s
   LgtYTNpffFb5t1gJ1IjfnneApYT99P3VnNL2ktn2VyDX1thVBdlv+DhfW
   j7yn5WeirC86esm6A8UsPwGj3tBeHbt5iPVqvzzI+TcIdlyJNOI+YE+5o
   JN3Yu22hPyeID3Pv9wQCq2NpNPlzJrv5UXKV9DPRYny7teMnWkBos4+MY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304464657"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="304464657"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 07:18:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="623945386"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="623945386"
Received: from samrober-mobl.amr.corp.intel.com (HELO [10.209.85.136]) ([10.209.85.136])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 07:18:44 -0700
Message-ID: <62c6c3a7-3bd2-69ee-36cd-341e11c43978@intel.com>
Date:   Tue, 4 Oct 2022 07:18:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 06/39] x86/fpu: Add helper for modifying xstate
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
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
 <20220929222936.14584-7-rick.p.edgecombe@intel.com>
 <202210031045.419F7DB396@keescook>
 <e0b3662ac478a7d2ae1991e8c674732592c2ea88.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <e0b3662ac478a7d2ae1991e8c674732592c2ea88.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/22 13:05, Edgecombe, Rick P wrote:
> The CET state is xsaves managed. It gets lazily restored before
> returning to userspace with the rest of the fpu stuff. This function
> will force restore all the fpu state to the registers early and lock
> them from being automatically saved/restored. Then the tasks CET state
> can be modified in the MSRs, before unlocking the fpregs. Last time I
> tried to modify the state directly in the xsave buffer when it was
> efficient, but it had issues and Thomas suggested this.

Can you get the gist of this in a comment, please?

