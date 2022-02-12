Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EFF4B31BE
	for <lists+linux-arch@lfdr.de>; Sat, 12 Feb 2022 01:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354341AbiBLALK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 19:11:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354337AbiBLALJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 19:11:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B433D71;
        Fri, 11 Feb 2022 16:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644624668; x=1676160668;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=VdSJ8eY/U+4hpxtDAQ/eHvpH0QesMIBN4OIVk8QPpY0=;
  b=XGdQRUoIGJzAerK6Qqom3H9IGMQzIctNG2B+2LE2p6K8hySfLHXiaCwN
   kWmVOWonWsiDdPp38zPyyFds+CmkuzMzAt8G4o86rz7bBYR1ZDBalgMzE
   CTqQQC7PKEvwWe4P+AoathTD4EtPMPmL6lFDZsmQkRAhb3RvlKkeb37/o
   vgejXMDfdERt/Y6EVfSGbEsFpCWNtCn463rYB2jgb0K3TWDNld1Psk5Cc
   S0xGFbovdO09klMV4HFOxTIe+R/PugJGOa+izdVLl/7JfTkYyLn0xXqZg
   BKPFoTGjOkRioBkQ8G1FGmmMYPiHUziEClVXOhGhAsrA+EllvEz6P1bSM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="274395593"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="274395593"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 16:11:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542295349"
Received: from nsmdimra-mobl.amr.corp.intel.com (HELO [10.209.96.127]) ([10.209.96.127])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 16:11:06 -0800
Message-ID: <bbcf2cf9-e039-0fba-457c-40455b8acf65@intel.com>
Date:   Fri, 11 Feb 2022 16:11:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "Eranian, Stephane" <eranian@google.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-26-rick.p.edgecombe@intel.com>
 <e2586482-dfba-2752-0247-7b8dfe95d7fe@intel.com>
 <4eeab037-502c-4d8d-84da-e29203dad6ad@www.fastmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 25/35] x86/cet/shstk: Add user-mode shadow stack support
In-Reply-To: <4eeab037-502c-4d8d-84da-e29203dad6ad@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/11/22 16:07, Andy Lutomirski wrote:
> On Fri, Feb 11, 2022, at 3:37 PM, Dave Hansen wrote:
>> On 1/30/22 13:18, Rick Edgecombe wrote:
>>> Add the user shadow stack MSRs to the xsave helpers, so they can be used
>>> to implement the functionality.
>> Do these MSRs ever affect kernel-mode operation?
>>
>> If so, we might need to switch them more aggressively at context-switch
>> time like PKRU.
>>
>> If not, they can continue to be context-switched with the PASID state
>> which does not affect kernel-mode operation.
> PASID?  PASID is all kinds of weird.  I assume you mean switching it
> with all the normal state.

I was grouping PASID along with the CET MSRs because they're the only
supervisor state.  But, yeah, it's all XRSTOR'd at the same spot right
now, user or kernel.
