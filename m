Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1486A3FB5CC
	for <lists+linux-arch@lfdr.de>; Mon, 30 Aug 2021 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhH3MNs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Aug 2021 08:13:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57296 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhH3MNq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Aug 2021 08:13:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EC26D1FE07;
        Mon, 30 Aug 2021 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630325571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2hWoCd86FOkOw7A98E1hRLN7RLXNnAR31E/MeyrKApg=;
        b=Y1gMMOSG4Lbl6n6EPJf1XND9hTBA55SaCavADAkaMhKtcCo/fdtC90kY49WhTWrpd2I2Qw
        ihSEer7fh+GydVOL5lgJ+x54xNtaI/DzPJNEfiUsx3J1/ggxYMTOuH0fO1Tzf0qlIEFEpO
        Ao6FdqbDH28DfZ6nb62XRrXvVEsIYJg=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C0204A3B8C;
        Mon, 30 Aug 2021 12:12:49 +0000 (UTC)
Date:   Mon, 30 Aug 2021 14:12:49 +0200
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
Message-ID: <20210830121249.2fgyvf47py2tz5s5@pathway.suse.cz>
References: <20210814211713.180533-1-yury.norov@gmail.com>
 <20210814211713.180533-12-yury.norov@gmail.com>
 <YSeduU41Ef568xhS@alley>
 <YSgDI9NpC51GhB/2@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSgDI9NpC51GhB/2@yury-ThinkPad>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu 2021-08-26 14:09:55, Yury Norov wrote:
> On Thu, Aug 26, 2021 at 03:57:13PM +0200, Petr Mladek wrote:
> > On Sat 2021-08-14 14:17:07, Yury Norov wrote:
> > > The macros iterate thru all set/clear bits in a bitmap. They search a
> > > first bit using find_first_bit(), and the rest bits using find_next_bit().
> > > 
> > > Since find_next_bit() is called shortly after find_first_bit(), we can
> > > save few lines of I-cache by not using find_first_bit().
> > 
> > Is this only a speculation or does it fix a real performance problem?
> > 
> > The macro is used like:
> > 
> > 	for_each_set_bit(bit, addr, size) {
> > 		fn(bit);
> > 	}
> > 
> > IMHO, the micro-opimization does not help when fn() is non-trivial.
>  
> The effect is measurable:
> 
> Start testing for_each_bit()
> for_each_set_bit:                15296 ns,   1000 iterations
> for_each_set_bit_from:           15225 ns,   1000 iterations
> 
> Start testing for_each_bit() with cash flushing
> for_each_set_bit:               547626 ns,   1000 iterations
> for_each_set_bit_from:          497899 ns,   1000 iterations
> 
> Refer this:
> 
> https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg356151.html

I see. The results look convincing on the first look.

But I am still not sure. This patch is basically contradicting many
other patches from this patchset:

  + 5th patch optimizes find_first_and_bit() and proves that it is
    much faster:

    Before (#define find_first_and_bit(...) find_next_and_bit(..., 0):
    Start testing find_bit() with random-filled bitmap
    [  140.291468] find_first_and_bit:           46890919 ns,  32671 iterations
    Start testing find_bit() with sparse bitmap
    [  140.295028] find_first_and_bit:               7103 ns,      1 iterations

    After:
    Start testing find_bit() with random-filled bitmap
    [  162.574907] find_first_and_bit:           25045813 ns,  32846 iterations
    Start testing find_bit() with sparse bitmap
    [  162.578458] find_first_and_bit:               4900 ns,      1 iterations

       => saves 46% in random bitmap
	  saves 31% in sparse bitmap


  + 6th, 7th, and 9th patch makes the code use find_first_bit()
    because it is faster than find_next_bit(mask, size, 0);

  + Now, 11th (this) patch replaces find_first_bit() with
    find_next_bit(mask, size, 0) because find_first_bit()
    makes things slower. It is suspicious at minimum.


By other words. The I-cache could safe 10% in one case.
But find_first_bit() might safe 46% in random case.

Does I-cache cost more than the faster code?

Or was for_each_set_bit() tested only with a bitmap
where find_first_bit() optimization did not help much?

How would for_each_set_bit() work with random bitmap?
How does it work with larger bitmaps?

Best Regards,
Petr
