Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAED52C8E62
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgK3TsP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 14:48:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:60307 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbgK3TsO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 14:48:14 -0500
IronPort-SDR: Fa5ywpL0Q9iyDBlloG20yGVYGU8RVzRYsw5qJTFkETcY+uHZ7BgIkdfnrtGmlZ+1VL+8R+UBc2
 /RP1vwkxAFEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172800330"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="172800330"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:47:33 -0800
IronPort-SDR: orzMZuJ32woFCZ7q36QfA9/NJY3Ac/tcD/xJWvuX5MZfyK9drPO8O/V1TgLerY62KI4YLy9zco
 QzvT6RXgKkIA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="372623976"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.122.22]) ([10.212.122.22])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:47:32 -0800
Subject: Re: [PATCH v15 01/26] Documentation/x86: Add CET description
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        bsingharora@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        dave.hansen@linux.intel.com, esyr@redhat.com,
        Florian Weimer <fweimer@redhat.com>, gorcunov@gmail.com,
        "H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        jannh@google.com, Kees Cook <keescook@chromium.org>,
        linux-api@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        luto@kernel.org, mike.kravetz@oracle.com,
        Ingo Molnar <mingo@redhat.com>, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        vedvyas.shanbhogue@intel.com, weijiang.yang@intel.com,
        X86 ML <x86@kernel.org>, Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        erich.keane@intel.com
References: <20201110162211.9207-2-yu-cheng.yu@intel.com>
 <20201130182641.29812-1-ndesaulniers@google.com>
 <4fad528b-e467-f96d-b7fb-9484fd975886@intel.com>
 <CAFP8O3LjdP69_T1Ve-zZjvg7+v8xV1mh9Wk8zm4LpAsE2PG58Q@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a675b406-dcb9-ac38-3ecb-c98378d333cf@intel.com>
Date:   Mon, 30 Nov 2020 11:47:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAFP8O3LjdP69_T1Ve-zZjvg7+v8xV1mh9Wk8zm4LpAsE2PG58Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/30/2020 11:38 AM, Fāng-ruì Sòng wrote:
> On Mon, Nov 30, 2020 at 10:34 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>
>> On 11/30/2020 10:26 AM, Nick Desaulniers wrote:
>>> (In response to https://lore.kernel.org/lkml/20201110162211.9207-2-yu-cheng.yu@intel.com/)
>>>
>>>> These need to be enabled to build a CET-enabled kernel, and Binutils v2.31
>>>> and GCC v8.1 or later are required to build a CET kernel.
>>>
>>> What about LLVM? Surely CrOS might be of interest to ship this on (we ship the
>>> equivalent for aarch64 on Android).
>>>
>>
>> I have not built with LLVM, but think it probably will work as well.  I
>> will test it.
>>
>>>> An application's CET capability is marked in its ELF header and can be
>>>> verified from the following command output, in the NT_GNU_PROPERTY_TYPE_0
>>>> field:
>>>>
>>>>       readelf -n <application> | grep SHSTK
>>>>           properties: x86 feature: IBT, SHSTK
>>>
>>> Same for llvm-readelf.
>>>
>>
>> I will add that to the document.
>>
>> Thanks,
>> Yu-cheng
> 
> The baseline LLVM version is 10.0.1, which is good enough for  clang
> -fcf-protection=full, llvm-readelf -n, LLD's .note.gnu.property
> handling (the LLD option is `-z force-ibt`, though)
> 
> 

Thanks!

Yu-cheng
