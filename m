Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16C2C8CE6
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 19:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgK3SfY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 13:35:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:62352 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbgK3SfX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 13:35:23 -0500
IronPort-SDR: UTdE267KSYaxn8SJxWlVjn4DEvbhyY/FSyIB+6PRlgsMhdNpAnZI9bdUy8RANMU0YkahP6RYyj
 ZZWD49aavLWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="190876622"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="190876622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:34:42 -0800
IronPort-SDR: 9dOX7jHwsdaXZ+0ublJbeehadYhgfNdrRIew/cg2EBrlxQ8Z8VCjMhjxmSSYjpqFnIOReAcFrd
 drhoHvA7exmA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="345167847"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.122.22]) ([10.212.122.22])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:34:39 -0800
Subject: Re: [PATCH v15 01/26] Documentation/x86: Add CET description
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dave.Martin@arm.com, arnd@arndb.de, bp@alien8.de,
        bsingharora@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        esyr@redhat.com, fweimer@redhat.com, gorcunov@gmail.com,
        hjl.tools@gmail.com, hpa@zytor.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mike.kravetz@oracle.com, mingo@redhat.com, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        peterz@infradead.org, ravi.v.shankar@intel.com,
        rdunlap@infradead.org, tglx@linutronix.de,
        vedvyas.shanbhogue@intel.com, weijiang.yang@intel.com,
        x86@kernel.org, maskray@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, erich.keane@intel.com
References: <20201110162211.9207-2-yu-cheng.yu@intel.com>
 <20201130182641.29812-1-ndesaulniers@google.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <4fad528b-e467-f96d-b7fb-9484fd975886@intel.com>
Date:   Mon, 30 Nov 2020 10:34:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201130182641.29812-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/30/2020 10:26 AM, Nick Desaulniers wrote:
> (In response to https://lore.kernel.org/lkml/20201110162211.9207-2-yu-cheng.yu@intel.com/)
> 
>> These need to be enabled to build a CET-enabled kernel, and Binutils v2.31
>> and GCC v8.1 or later are required to build a CET kernel.
> 
> What about LLVM? Surely CrOS might be of interest to ship this on (we ship the
> equivalent for aarch64 on Android).
> 

I have not built with LLVM, but think it probably will work as well.  I 
will test it.

>> An application's CET capability is marked in its ELF header and can be
>> verified from the following command output, in the NT_GNU_PROPERTY_TYPE_0
>> field:
>>
>>      readelf -n <application> | grep SHSTK
>>          properties: x86 feature: IBT, SHSTK
> 
> Same for llvm-readelf.
> 

I will add that to the document.

Thanks,
Yu-cheng
