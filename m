Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE757630B
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiGONuI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiGONt7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 09:49:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D08053F;
        Fri, 15 Jul 2022 06:49:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y141so4711689pfb.7;
        Fri, 15 Jul 2022 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rs46+iydynCKHLHZ1GP3rF0W0E38SP1veulXa6gwRZ4=;
        b=U2LPKLM/AjT1a2LjEeJbIoC7cMGOq1yROmt0cZz2Ais3HJJbyhb17PcE+5FV+ybUP8
         +DSpyzNvjpXy8F2wrmZ0lTlqucMS7kjrw4Q9h/Tne1y2K9xW3tm2zMzEVInk6+Y2kNSK
         xK5+NjqnN7jZRM20X7NKghDHD1GEMUwYqciGlk2cObJdUKWdRpmYfuyS/zSPa7rtAs0J
         /eL2zWxi2I+kPcM56S+S1qVAVJaJURtunnq0/WI/1FWTaavZX0kfTCaS9YaUXyinPP0X
         /r6r+fcRBASD1bIPLyE3iFMUJV6F7KavxvqQHCWQ7TydHLHLIKdC54p0qZnsEtBjn01F
         8XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rs46+iydynCKHLHZ1GP3rF0W0E38SP1veulXa6gwRZ4=;
        b=QC7rrCtOyszSEMwMtJG1r6NUo0URaExBzKprKszNI96OIX0gTeU8/2oadbv5D0g8GN
         RByUKGiK6E7cKL6CDsZKTUaVgJTpS7b+YWUjuG4YarUAd0DMKuONAKvraRkuBWEQMOjc
         YiVf9iDP+l3yNNWmlv+N/Kv88cUgDLeE66LfPkF4gH0n752b+oUg2jrCi4SV9ckAjdtr
         ku3dIAz2HevCywRo++wHR6xgj3YV7XSGfJOvWfTgcU7rJlsYXLqNjqU21sP9D7zHaVgn
         o0WRw+4YrCdfGQVK9pjYt84CGdZCF4Fj2Ra5tFzA+hBQEvoY+LWJVdBRJ9CojRfXXk9Y
         gejA==
X-Gm-Message-State: AJIora8sixEwBKavGXmr2fmmjBgfjbgnOFn+86GBRHM2vX/+N67rXmno
        2NjL9I7iICSgxJdW2pDNStA=
X-Google-Smtp-Source: AGRyM1ulOtzAhHCGu6ywxJM6sk+U6dmHRqZvwpjYFjdMEiuPSMe0ZWPIPMhh5EKAD2SvIvDk3Xu89Q==
X-Received: by 2002:a63:d94a:0:b0:412:6986:326e with SMTP id e10-20020a63d94a000000b004126986326emr12641651pgj.56.1657892990012;
        Fri, 15 Jul 2022 06:49:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v21-20020a170902ca9500b0016b80d2fac8sm3468442pld.248.2022.07.15.06.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 06:49:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8c949bd4-d25a-d5f5-49be-59d52e4b6c9d@roeck-us.net>
Date:   Fri, 15 Jul 2022 06:49:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 6/9] bitops: let optimize out non-atomic bitops on
 compile-time constants
Content-Language: en-US
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
 <20220624121313.2382500-7-alexandr.lobakin@intel.com>
 <20220715000402.GA512558@roeck-us.net>
 <20220715132633.61480-1-alexandr.lobakin@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220715132633.61480-1-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/15/22 06:26, Alexander Lobakin wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Thu, 14 Jul 2022 17:04:02 -0700
> 
>> On Fri, Jun 24, 2022 at 02:13:10PM +0200, Alexander Lobakin wrote:
>>> Currently, many architecture-specific non-atomic bitop
>>> implementations use inline asm or other hacks which are faster or
> 
> [...]
> 
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>> Reviewed-by: Marco Elver <elver@google.com>
>>
>> Building i386:allyesconfig ... failed
>> --------------
>> Error log:
>> arch/x86/platform/olpc/olpc-xo1-sci.c: In function 'send_ebook_state':
>> arch/x86/platform/olpc/olpc-xo1-sci.c:83:63: error: logical not is only applied to the left hand side of comparison
> 
> Looks like a trigger, not a cause... Anyway, this construct:
> 
> 	unsigned char state;
> 
> 	[...]
> 
> 	if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
> 
> doesn't look legit enough.
> That redundant double-negation [of boolean value], together with
> comparing boolean to char, provokes compilers to think the author
> made logical mistakes here, although it works as expected.
> Could you please try (if it's not automated build which you can't
> modify) the following:
> 

Agreed, the existing code seems wrong. The change below looks correct
and fixes the problem. Feel free to add

Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>

to the real patch.

Thanks,
Guenter

> --- a/arch/x86/platform/olpc/olpc-xo1-sci.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
> @@ -80,7 +80,7 @@ static void send_ebook_state(void)
>   		return;
>   	}
>   
> -	if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
> +	if (test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == !!state)
>   		return; /* Nothing new to report. */
>   
>   	input_report_switch(ebook_switch_idev, SW_TABLET_MODE, state);
> ---
> 
> We'd take it into the bitmap tree then. The series revealed
> a fistful of existing code issues already :)
> 
>>
>> Bisect log attached.
>>
>> Guenter
>>
>> ---
>> # bad: [4662b7adea50bb62e993a67f611f3be625d3df0d] Add linux-next specific files for 20220713
>> # good: [32346491ddf24599decca06190ebca03ff9de7f8] Linux 5.19-rc6
>> git bisect start 'HEAD' 'v5.19-rc6'
>> # good: [8b7e002d8bc6e17c94092d25e7261db4e6e5f2cc] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
>> git bisect good 8b7e002d8bc6e17c94092d25e7261db4e6e5f2cc
>> # good: [07f6d21d6e33c1e28e24ae84e9d26e4e7d4853f5] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>> git bisect good 07f6d21d6e33c1e28e24ae84e9d26e4e7d4853f5
>> # good: [5ff085e5d4f6700e03635d5e700f52163a6dc2a7] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
>> git bisect good 5ff085e5d4f6700e03635d5e700f52163a6dc2a7
>> # good: [eb9e3fdbdd8b61ef0f4bee23259fe6ab69e463ab] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
>> git bisect good eb9e3fdbdd8b61ef0f4bee23259fe6ab69e463ab
>> # good: [9f2183cd961e5ddb7954eafb6bb01a495c6a9c7b] hexagon/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
>> git bisect good 9f2183cd961e5ddb7954eafb6bb01a495c6a9c7b
>> # bad: [e878aa5faf9ac8c0b5d0c3f293389c194c250fff] Merge branch 'mm-nonmm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> git bisect bad e878aa5faf9ac8c0b5d0c3f293389c194c250fff
>> # good: [cf95d50205f62c4f5f538676def847292cf39fa9] fs: don't call ->writepage from __mpage_writepage
>> git bisect good cf95d50205f62c4f5f538676def847292cf39fa9
>> # good: [5103cbfd92d3587713476f94f9485b96e02f0146] Merge branch 'for-next/execve' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
>> git bisect good 5103cbfd92d3587713476f94f9485b96e02f0146
>> # good: [ee56c3e8eec166f4e4a2ca842b7804d14f3a0208] Merge branch 'master' into mm-nonmm-stable
>> git bisect good ee56c3e8eec166f4e4a2ca842b7804d14f3a0208
>> # bad: [dc34d5036692c614eef23c1130ee42a201c316bf] lib: test_bitmap: add compile-time optimization/evaluations assertions
>> git bisect bad dc34d5036692c614eef23c1130ee42a201c316bf
>> # good: [bb7379bfa680bd48b468e856475778db2ad866c1] bitops: define const_*() versions of the non-atomics
>> git bisect good bb7379bfa680bd48b468e856475778db2ad866c1
>> # bad: [b03fc1173c0c2bb8fad61902a862985cecdc4b1b] bitops: let optimize out non-atomic bitops on compile-time constants
>> git bisect bad b03fc1173c0c2bb8fad61902a862985cecdc4b1b
>> # good: [e69eb9c460f128b71c6b995d75a05244e4b6cc3e] bitops: wrap non-atomic bitops with a transparent macro
>> git bisect good e69eb9c460f128b71c6b995d75a05244e4b6cc3e
>> # first bad commit: [b03fc1173c0c2bb8fad61902a862985cecdc4b1b] bitops: let optimize out non-atomic bitops on compile-time constants
> 
> Thanks,
> Olek

