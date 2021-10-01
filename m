Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6812641F50F
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhJASin (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355969AbhJASig (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:38:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C9C061775;
        Fri,  1 Oct 2021 11:36:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p1so2647059pfh.8;
        Fri, 01 Oct 2021 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U/jeo0cc4IS12fXu/3bym/iiyWz3QTfkGKyYijbo8pY=;
        b=cPfJPl85flsr5d4GoEpVUbaPdgMoIQXFsKWqOJIawh2OktBJif4WDJTgJfCp+DZVLE
         xWjav8cTfeSzwz6vvFgspe8IuaOqaPNp1QmAXMnLOJhWBr+i9jTOc6g0I++ZmPq70S2u
         wz+gnit0JRnRxpEKSiaFE/4qg58Qj5poqu6BZscEk7exNp72iz2SVBawCsfF7bRb9kd4
         WQHbaZ7lwO2hmVGRat0sOY4CbIqesw4bhvmbdOsncWv6mImb8vtBs90Az8MFfTQzaGqX
         NLKwh1XOC6ZlMYoPzZDX2cqXJ7bDqFJFTjyJjRGAPHJ1urMr9+ZmccUHI/ZdKgggTBpL
         HMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U/jeo0cc4IS12fXu/3bym/iiyWz3QTfkGKyYijbo8pY=;
        b=p3PHMLbvL10ZT7WKQ3MUmMalH4Xgz4SBRI5LFbymV3M7k00S65G7KB4Cc5qX7eQk8Q
         JsUYMVfDDmHcqSb3EsnzmcyEh0nOBVqDgC0nbBHXyHERFZeOsZ6rP3iRaYFgPXlee0wf
         vmJ3h5k7Bln7j3ZEk10xfxZPIvlEStDjdfvkoZeMaUIAapj73mdUpF2tYauS3DxeinCi
         U8b443AhUC9FnkJcYJGkJSoWjcC7/TUC5ROE9NdPi7qUr4OfIB7kFzsBaR4M6wxDIV8H
         A+fhxsqMoarDLgyMSd3iBXNV04Vhijq9/DWM0dAht5tMNf5q8cMAZkyHd2UGXD7RZTgB
         rCiQ==
X-Gm-Message-State: AOAM532SN6xnR6UcfWMoch6otfb7/kqlT7QRc6pY9CF0AXvCTys+t+ip
        EgB4Oui4+Jl6jxpWlYnRVBs=
X-Google-Smtp-Source: ABdhPJxpcN7h+xroaO4ziJJc8u4TcIRQF/ZupaBuavc2M/JBoGPwQoLCynTihJtuxc2oGWN1VfWgvw==
X-Received: by 2002:a62:e210:0:b0:44b:ae4c:8c01 with SMTP id a16-20020a62e210000000b0044bae4c8c01mr11498160pfi.45.1633113403479;
        Fri, 01 Oct 2021 11:36:43 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id t23sm2310819pgn.25.2021.10.01.11.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:36:43 -0700 (PDT)
Date:   Fri, 1 Oct 2021 11:36:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
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
Message-ID: <YVdVPGaF2Gq1PGpG@yury-ThinkPad>
References: <20211001181226.228340-1-yury.norov@gmail.com>
 <YVdSK4rFmLVFrKrD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVdSK4rFmLVFrKrD@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 01, 2021 at 09:23:39PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 01, 2021 at 11:12:10AM -0700, Yury Norov wrote:
> > Hi Stephen,
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
> 
> This is a dup with the same subject. Which one should we look into?

Please ignore this (short) series. It's a duplication, my connection
was broken and I had to restart submitting.

Sorry for noise.
