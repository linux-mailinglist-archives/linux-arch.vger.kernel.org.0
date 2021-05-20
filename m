Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97C138B581
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhETRxM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 13:53:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:2204 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231680AbhETRxM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 13:53:12 -0400
IronPort-SDR: vVhR/DwApdYxvjNHZAvNwK53gUSupAjObUSJ26PC9wg0RH9ElJReMaye6o0djQsBUHQ42aHG5N
 6/vrJ6GWv+uA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="265205147"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="265205147"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 10:51:49 -0700
IronPort-SDR: 8JNksvObprn0+tyfBq8A84G210WIVRliyNYxaJ3iN7nLYyaawky6DosNXGpWOzPzhSm+7a1qeV
 xZ169Yw7pVBQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="475295228"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.167.234]) ([10.209.167.234])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 10:51:48 -0700
Subject: Re: [PATCH v26 26/30] ELF: Introduce arch_setup_elf_property()
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-27-yu-cheng.yu@intel.com> <YKVUgzJ0MVNBgjDd@zn.tnic>
 <c29348d8-caae-5226-d095-ae3992d88338@intel.com> <YKYrQQ6tKfifjNjW@zn.tnic>
 <d04259f1-a869-ec1c-aa74-93cd6c2c2d7b@intel.com> <YKad0e5VDNZhBw+4@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <3243001b-db72-3cd3-889f-6fe390276715@intel.com>
Date:   Thu, 20 May 2021 10:51:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKad0e5VDNZhBw+4@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/20/2021 10:35 AM, Borislav Petkov wrote:
> On Thu, May 20, 2021 at 10:18:10AM -0700, Yu, Yu-cheng wrote:
>> The latest pdf's are posted here.
>>
>> https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI
> 
> Ah, that document.
> 
> Please make sure it is specified over those defines from which document
> they're coming from.
> 

I will do that.
