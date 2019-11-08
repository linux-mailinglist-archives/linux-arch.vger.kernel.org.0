Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5939BF4D03
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 14:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfKHNUu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 08:20:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:22591 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfKHNUu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Nov 2019 08:20:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 05:20:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; 
   d="scan'208";a="213240569"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2019 05:20:42 -0800
Subject: Re: [PATCH v8 07/14] x86/cet/ibt: Add ENDBR to op-code-map
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
References: <20190813205359.12196-1-yu-cheng.yu@intel.com>
 <20190813205359.12196-8-yu-cheng.yu@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5b81028b-2230-51c4-f504-10067cb59bf8@intel.com>
Date:   Fri, 8 Nov 2019 15:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190813205359.12196-8-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 13/08/19 11:53 PM, Yu-cheng Yu wrote:
> Add control transfer terminating instructions:
> 
> ENDBR64/ENDBR32:
>     Mark a valid 64/32-bit control transfer endpoint.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/lib/x86-opcode-map.txt               | 13 +++++++++++--
>  tools/objtool/arch/x86/lib/x86-opcode-map.txt | 13 +++++++++++--
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> index c5e825d44766..fbc53481bc59 100644
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -620,7 +620,16 @@ ea: SAVEPREVSSP (f3)
>  # Skip 0xeb-0xff
>  EndTable
>  
> -Table: 3-byte opcode 2 (0x0f 0x38)
> +Table: 3-byte opcode 2 (0x0f 0x1e)
> +Referrer:
> +AVXcode:
> +# Skip 0x00-0xf9
> +fa: ENDBR64 (f3)
> +fb: ENDBR32 (f3)

endbr32 and endbr64 have 2-byte opcodes (0F 1E) and a ModRM byte, so a new
Grp is needed

> +#skip 0xfc-0xff
> +EndTable
> +
> +Table: 3-byte opcode 3 (0x0f 0x38)
>  Referrer: 3-byte escape 1
>  AVXcode: 2
>  # 0x0f 0x38 0x00-0x0f
> @@ -804,7 +813,7 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSS Pq,Qq
>  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
>  EndTable
>  
> -Table: 3-byte opcode 3 (0x0f 0x3a)
> +Table: 3-byte opcode 4 (0x0f 0x3a)
>  Referrer: 3-byte escape 2
>  AVXcode: 3
>  # 0x0f 0x3a 0x00-0xff
> diff --git a/tools/objtool/arch/x86/lib/x86-opcode-map.txt b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
> index c5e825d44766..fbc53481bc59 100644
> --- a/tools/objtool/arch/x86/lib/x86-opcode-map.txt
> +++ b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
> @@ -620,7 +620,16 @@ ea: SAVEPREVSSP (f3)
>  # Skip 0xeb-0xff
>  EndTable
>  
> -Table: 3-byte opcode 2 (0x0f 0x38)
> +Table: 3-byte opcode 2 (0x0f 0x1e)
> +Referrer:
> +AVXcode:
> +# Skip 0x00-0xf9
> +fa: ENDBR64 (f3)
> +fb: ENDBR32 (f3)
> +#skip 0xfc-0xff
> +EndTable
> +
> +Table: 3-byte opcode 3 (0x0f 0x38)
>  Referrer: 3-byte escape 1
>  AVXcode: 2
>  # 0x0f 0x38 0x00-0x0f
> @@ -804,7 +813,7 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSS Pq,Qq
>  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
>  EndTable
>  
> -Table: 3-byte opcode 3 (0x0f 0x3a)
> +Table: 3-byte opcode 4 (0x0f 0x3a)
>  Referrer: 3-byte escape 2
>  AVXcode: 3
>  # 0x0f 0x3a 0x00-0xff
> 

