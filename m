Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99D221AFF7
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 09:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgGJHUs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 03:20:48 -0400
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:51344 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgGJHUs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 03:20:48 -0400
X-Greylist: delayed 5029 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2020 03:20:46 EDT
Received: from av3.ics.forth.gr (av3in [139.91.1.77])
        by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id 06A5mKfN028585;
        Fri, 10 Jul 2020 05:48:22 GMT
X-AuditID: 8b5b014d-257ff700000045c5-ee-5f080124e40e
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 67.B4.17861.421080F5; Fri, 10 Jul 2020 08:48:20 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 10 Jul 2020 08:48:17 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, mark.rutland@arm.com,
        steve@sk2.org, gregory.0xf0@gmail.com, catalin.marinas@arm.com,
        linus.walleij@linaro.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        zaslonko@linux.ibm.com, glider@google.com, krzk@kernel.org,
        zong.li@sifive.com, mchehab+samsung@kernel.org,
        linux-riscv@lists.infradead.org, alex.shi@linux.alibaba.com,
        will@kernel.org, ardb@kernel.org, linux-arch@vger.kernel.org,
        paulmck@kernel.org, alex@ghiti.fr, bgolaszewski@baylibre.com,
        masahiroy@kernel.org, linux@armlinux.org.uk, willy@infradead.org,
        takahiro.akashi@linaro.org, james.morse@arm.com,
        kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>,
        pmladek@suse.com, elver@google.com, aou@eecs.berkeley.edu,
        keescook@chromium.org, uwe@kleine-koenig.org, rostedt@goodmis.org,
        broonie@kernel.org, davidgow@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
        gxt@pku.edu.cn, linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>, tglx@linutronix.de,
        rdunlap@infradead.org, matti.vaittinen@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>, mhiramat@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net
Subject: Re: [PATCH 1/5] lib: Add a generic version of devmem_is_allowed()
Organization: FORTH
In-Reply-To: <20200710053850.GA27019@infradead.org>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
 <20200709200552.1910298-2-palmer@dabbelt.com>
 <20200709204921.GJ781326@linux.ibm.com>
 <20200710053850.GA27019@infradead.org>
Message-ID: <a037dac961c989d027eab293a0280643@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.9
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVDTdRzH+/4eN2Tx46Hzd5hUA1MoniSuz5Vnnan3y+Lyrv5AUdaSCRxP
        3ngo+cOWTYWB11qMxRhBDENsZzw4QIJJcCAkhROOh8kShRhIazxNRdwRg+uO/173/rzv3q8/
        Pjzc5wHpz0tOz5JI08WpQsqDKIjTBIYGIZ4o4vrNXaD7xUDB1ZsKHKbGnCRcPKvBwLiipWF5
        yYHApeqmYansdwLU9ycpcPxUiECjvo1A1y8noKeuloDzfU0kXJhvw6FYU0uCq62OglvKSgzu
        maox6CtIg+YmP+jvr6Wh6NlaktfiJKB+YoiEgRYdBY2Lcgo61G0ILg2bMbg/PkJC06MHFIwo
        /0bgWMjHQF/9KswpVzGYGSjEwVh3FcF5rRcsVD0iYHViTdo+piHAlDeOwUiRjALLbBUJz24s
        E9BQr8ZheMGCgXwsGlaerO11zy8jmLOWUu9GcY2/NpKc4QcD4gaGzDi38lSFOMfIOZorlZkJ
        7p+ZGYK7VjOKcZ15SzS30jVBc3/1FJPcda2V5uQmC81V1GdzDZdDOH3rDHY44KjHngRJanKO
        RBq+91OPJK1OhZ066/lFfvtDUoasfAXi8VjmDfZhe7ICefB8mC7EuvpkhALx1/JotrQtH7lZ
        wHizvSWT6znOAKsevIE2+CX2a2Mp7maC2cFePte2zhQTzJbf+W2977fGluoLuHsAZ2q2sE9V
        jZR72Jc5xN7RvuXueDG+7ILVTLqZz0SxjtlOtCHUitiBb5XUhsR+1jrRQ23IBbFzK+O0m19g
        AtnRThutRN7aTa7aTa7aTa4VCL+CGHFOVFjyicywkxnSrKSwRGk9Wn9DFNOM7jbYwzoQxkMd
        iOXhQj9BxCukyEeQID6dK5FmiKTZqZLMDrSNRwi3CtK3VB/3YRLFWZIUieSURPr/FePx/WVY
        91BgdsmHdfGf6+wZZfbKYweNO8v0uz9SnIjrmi6Iiz9yTz75r2vAUxfcNWreevRl0ZXykymt
        /E9e+y7hywDnOwF5B5Q1kalTUp8A+kf9N0FfxVfkTOOhIkNsVMgljQTZDtpakhr09W++aAg6
        /jil8ICrTt18pt1mv0gq/GPpw0VOIbWr+rPi7cvhuXu83369d29a9HZVVbmvEzNNGGJyuwe1
        iXnBh8bTFlOeWGwxlY7vs8WrRrmj+blyS+Z7XvFnGiYFtd5E6GB+5OkP9n+87c9S6WzMvKcp
        8vmf/yghI5Z79/Fv37o71buzS/U4XzatWzwSe2zfjmGBa/c1mc0U3vl+jJDITBJHhuDSTPF/
        Gk8Jw/UDAAA=
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Fri, 10 Jul 2020 05:48:22 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in' HELO:'av3.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Fri, 10 Jul 2020 05:48:22 +0000 (GMT)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2020-07-10 08:38, Christoph Hellwig έγραψε:
> On Thu, Jul 09, 2020 at 11:49:21PM +0300, Mike Rapoport wrote:
>> > +#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
>> > +extern int devmem_is_allowed(unsigned long pfn);
>> > +#endif
> 
> Nit: no need for the extern here.
> 
>> > +config GENERIC_LIB_DEVMEM_IS_ALLOWED
>> > +	bool
>> > +	select ARCH_HAS_DEVMEM_IS_ALLOWED
>> 
>> This seems to work the other way around from the usual Kconfig chains.
>> In the most cases ARCH_HAS_SOMETHING selects GENERIC_SOMETHING.
>> 
>> I believe nicer way would be to make
>> 
>> config STRICT_DEVMEM
>> 	bool "Filter access to /dev/mem"
>> 	depends on MMU && DEVMEM
>> 	depends on ARCH_HAS_DEVMEM_IS_ALLOWED || 
>> GENERIC_LIB_DEVMEM_IS_ALLOWED
>> 
>> config GENERIC_LIB_DEVMEM_IS_ALLOWED
>> 	bool
>> 
>> and then s/select ARCH_HAS_DEVMEM_IS_ALLOWED/select 
>> GENERIC_LIB_DEVMEM_IS_ALLOWED/
>> in the arch Kconfigs and drop ARCH_HAS_DEVMEM_IS_ALLOWED in the end.
> 
> To take a step back:  Is there any reason to not just always
> STRICT_DEVMEM? Maybe for a few architectures that don't currently
> support a strict /dev/mem the generic version isn't quite correct, but
> someone selecting the option and finding the issue is the best way to
> figure that out..
> 

During prototyping / testing having full access to all physical memory 
through /dev/mem is very useful. We should have it enabled by default 
but leave the config option there so that users / developers can disable 
it if needed IMHO.
