Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230DC3F8FF5
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 23:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhHZU75 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhHZU75 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Aug 2021 16:59:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D37AC061757;
        Thu, 26 Aug 2021 13:59:09 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id e14so5004056qkg.3;
        Thu, 26 Aug 2021 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ldGhthI++t3w6986XDZba6Q1yZRX4odOpIMvkvePfHc=;
        b=OheyBCur9wHxyJUrnhNfW2lfxtb3kQ6W+jYCnrD/Bu07QjycyF9xZlAaegudPBLJDn
         8IasTBBZUwesaV7XZh07vNgJiN8jrvVWJ8J4rQc75VV7OjbAXUBZZFZl8OoOa9x+RkH8
         a+zqgpivSYpVXoh3UyUiiRzKCsjGNKsVSvHCjBkgBRHXqUcBxnzpvPN+/JSNzmMgk/Pr
         j+jFRlarz83iekoCTYuz3n8xJHqVv0TduhQ+s2z85F+z3T1p0x0PIlmLjvbdPN1sPfZ1
         4W1CTRqSEXOju5Kpnsp28Ty9GYmqdRlmEeiFCGCnXrSo6Fyedw0U0GsFQSsblkbUZtjz
         +7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ldGhthI++t3w6986XDZba6Q1yZRX4odOpIMvkvePfHc=;
        b=r42gHwmPFkI3T3XN4PkDiRDMkA9H+6Q05S0ADO0wdUWewxKFtlSnHm2BfPfL0WRkTN
         hcKgPBCu1ea/wsG/PJ+M/cxbvZMLtBZGkLujRQIAPVJLXpSfb/owcv80Xn1TnZB7Wdht
         8BGfZ8srZ6JKojPn7pZulchVGX/6Xrb3RqG/+dRB5XcFTbB5TpF6cDLS0kxBNarNWdY6
         XyhcuanfgnKIVjXaOBr+UKFuJlf3wkxxwv3BMqemHp45O0oHCJ+K//eWtKvqF+JYFzQT
         GrQL/HiZwz8eLPn42y4mRj2JDXushy50/ilbo/zcn6JvnvHx4yMhXdxskfPzTcpJR1+7
         ZvUg==
X-Gm-Message-State: AOAM533Mqiu0Cuyspej28MCPpbJmP9G910MRl54U2Bbdb6D3uAiOH2Nt
        GR8+U3FtuAsY/tNRH3L6AGHSZHDA4h5Lqg==
X-Google-Smtp-Source: ABdhPJxrD+K1ALRaZQSDKJ72hjbpCHhEic6Csz/W3OUeeXf3irJ5comsp24peI48bMJIZwCal3yxRA==
X-Received: by 2002:a37:61d5:: with SMTP id v204mr5747644qkb.308.1630011547957;
        Thu, 26 Aug 2021 13:59:07 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id p22sm3327691qkj.16.2021.08.26.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 13:59:07 -0700 (PDT)
Date:   Thu, 26 Aug 2021 13:59:06 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
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
Subject: Re: [PATCH 17/17] vsprintf: rework bitmap_list_string
Message-ID: <YSgAmjvwscaRb8PT@yury-ThinkPad>
References: <20210814211713.180533-1-yury.norov@gmail.com>
 <20210814211713.180533-18-yury.norov@gmail.com>
 <YSeh7SrwoMhWb8CO@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSeh7SrwoMhWb8CO@alley>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 26, 2021 at 04:15:09PM +0200, Petr Mladek wrote:
> On Sat 2021-08-14 14:17:13, Yury Norov wrote:
> > bitmap_list_string() is very ineffective when printing bitmaps with long
> > ranges of set bits because it calls find_next_bit for each bit in the
> > bitmap.  We can do better by detecting ranges of set bits.
> > 
> > In my environment, before/after is 943008/31008 ns.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> I like the patch. The new code is much easier to follow.
> Feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr

Thanks Petr! The patch is already in the linux-next.

Andrew, Stephen, can you please append Petr's reviewed-by?

Thanks,
Yury
