Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6163F897B
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 15:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbhHZN6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 09:58:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242768AbhHZN6K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Aug 2021 09:58:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C66CF2230B;
        Thu, 26 Aug 2021 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629986237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnhMvs9n1nhsU1o7+xe9+Bo6hjRyCva0kdWrwKPRW08=;
        b=GR//V0SiIEZKLC6w/96Ri/cMSee15eFRF7D1Vw13XhIHov2iDzsBhkCDnzKVLSJpFK3HsG
        8kGlTGpPk7GQg4S3H0Q3HtwEcMPUwRcy6z3BgXTc4to++5I4qh2Z3tVt7aaH90iUtXrGB+
        XxO2hZXNgRy0t1NpHNzYylTUjcl8whY=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7E2C5A3B99;
        Thu, 26 Aug 2021 13:57:14 +0000 (UTC)
Date:   Thu, 26 Aug 2021 15:57:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 11/17] find: micro-optimize for_each_{set,clear}_bit()
Message-ID: <YSeduU41Ef568xhS@alley>
References: <20210814211713.180533-1-yury.norov@gmail.com>
 <20210814211713.180533-12-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814211713.180533-12-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat 2021-08-14 14:17:07, Yury Norov wrote:
> The macros iterate thru all set/clear bits in a bitmap. They search a
> first bit using find_first_bit(), and the rest bits using find_next_bit().
> 
> Since find_next_bit() is called shortly after find_first_bit(), we can
> save few lines of I-cache by not using find_first_bit().

Is this only a speculation or does it fix a real performance problem?

The macro is used like:

	for_each_set_bit(bit, addr, size) {
		fn(bit);
	}

IMHO, the micro-opimization does not help when fn() is non-trivial.


> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -280,7 +280,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
>  #endif
>  
>  #define for_each_set_bit(bit, addr, size) \
> -	for ((bit) = find_first_bit((addr), (size));		\
> +	for ((bit) = find_next_bit((addr), (size), 0);		\
>  	     (bit) < (size);					\
>  	     (bit) = find_next_bit((addr), (size), (bit) + 1))
>  

It is not a big deal. I just think that the original code is slightly
more self-explaining.

Best Regards,
Petr
