Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608D741FE97
	for <lists+linux-arch@lfdr.de>; Sun,  3 Oct 2021 01:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhJBXMG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 19:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhJBXMF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 19:12:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607EFC061714;
        Sat,  2 Oct 2021 16:10:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p1so5148507pfh.8;
        Sat, 02 Oct 2021 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uWsmnTdLYgGTIESxzt0fKdeqEQq87Inaf5bYUeItpZw=;
        b=VFvP6LrVFrumdKonxWiPTWqt1wzR+4nfggmOkAXBi0frjODwU7AKHK6odrkaYnuJH6
         hvx/WNaTEmlAFhuFCDSkfmWjHZ2mopR9wqO4r2yWBX9G81P3VIsitAMlmlR+lc/KsA4K
         8BKBYUE4G1ZJqIJd4czLQd7wc0tVfxedzujFAQz7pbJJ/THHc8GB8xlA+gYw6x39yVG7
         siZFQmTZ4QJqtYPRsAhWeIRD/o1/mU3c6F8DH8ykZHWu/C9uDSWRDdKaEwZk7HWEMJAF
         mR35EDQs2T3U+0p16dx/HxGPQTWQT8bX8JPYhYHp8129LxLdQY+wJBTAUU9DbLn3WxKs
         WTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWsmnTdLYgGTIESxzt0fKdeqEQq87Inaf5bYUeItpZw=;
        b=IE1av44gleedUCOqhEMyL/BpkWObpfMB8E80p+txqnA0mBWG0inUxKjqrWGArs2RmO
         H6g+UTwX2H3f9+kDQ7HjjA4glPEjqMB0Eq6LRGbsjQawTC4L41pgQ7K9qRLXuIHogkyW
         NyMk5fU3ikh28Kl9KI64/uha8gkvi8OYk9Tsfo2v/aLVZLuyY5qg9SzG7LT+beOMHpyh
         Km6pBLPjtBRCabnW3YYcsQVPEIe22lSlodX+wzq0io8jPRKizIb/YRLXUbMTnkDVdkeA
         EIgml6woBGWC2oP8ZxtUJZyIjg2xFuyy0aKzrw0bLRQViCif/KWRz0k/VDxlFoi2M1hl
         +3rQ==
X-Gm-Message-State: AOAM533P+9WBOmClEGKschl3HUlGiF2+yA29lkY2k+UHZmkYEicrzxRd
        VRw4pc0d4PZPxs0RweG5HX8=
X-Google-Smtp-Source: ABdhPJxBPfASvqvpKaozrHZlhb76h0W/4pnVSDT2NKcdRSrRFmnKkE73nJpee/T1k5kzMl0+1fkGqA==
X-Received: by 2002:a63:cc49:: with SMTP id q9mr4712022pgi.463.1633216218668;
        Sat, 02 Oct 2021 16:10:18 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id b142sm10096505pfb.17.2021.10.02.16.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 16:10:18 -0700 (PDT)
Date:   Sat, 2 Oct 2021 16:10:20 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
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
        Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [PATCH RESEND 2 00/16] Resend bitmap patches
Message-ID: <YVjm3NXEhoBQtUSI@yury-ThinkPad>
References: <20211001181245.228419-1-yury.norov@gmail.com>
 <20211003094722.434c030d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003094722.434c030d@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 03, 2021 at 09:47:22AM +1100, Stephen Rothwell wrote:
> Hi Yury,
> 
> On Fri,  1 Oct 2021 11:12:29 -0700 Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Can you please take this series into the next tree? It has been already
> > in next-tree for 5.14:
> > 
> > https://lore.kernel.org/linux-mmc/YSeduU41Ef568xhS@alley/T/
> > 
> > But it was damaged and we decided to merge it in 5.15 cycle. No changes
> > comparing to 5.14, except for Andy's patch that was already upstreamed
> > and therefore removed from here.
> > 
> > The git tree is here:
> > 	https://github.com/norov/linux/tree/bitmap-20210929
> 
> Sorry, I cannot include that in linux-next since it it based on (an old
> version of) linux-next itself.  If it needs to be based on other trees in
> linux-next, then it has to be added to Andrew Morton's patch series (in
> the post linux-next section.  Otherwise, if it can be based on Linus
> Torvald's tree (even with a few conflicts), then that is better.

Ok, I'll resend it based on Linus tree shortly

Thanks,
Yury
