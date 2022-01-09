Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68637488C0D
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 20:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiAITep (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 14:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbiAITeo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 14:34:44 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0E9C06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 11:34:44 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s1so9408016pga.5
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 11:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rn8pF8O9Vf4jYKMH5OFExZArXlC7e5nB8dIFoH4sd/w=;
        b=n3fjHsp+ckhMHZqEpiBereThdj2au3a7eoyEE9x1mETnRkNtntNH7S9E3QRVN07HfA
         rK21DVUEc4c05Um3xJLgqQQ/XMeBVqhuyfJGgS3R5G8oEfAEKo3iKrJSiww35qeU9eP6
         5X4NwZPL0t5WsWx9tuuKLcu1KSe2FThWKzcQPoW5Cu7ivpXzYfFKwmvHVLPYTQ+guBGn
         fwy5n9zyuoTQz68WnIwhnot7Pu5GnlJJA0d3OVLX2I92fSPUNHiAvTsTQ6xJly/1imPX
         qNAjM7E44FbnMOKWo1r3CLY+gWNujBwyu5z/Nwli71hEzOHMa7kw36fZ5yv1jXwEHckx
         rg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rn8pF8O9Vf4jYKMH5OFExZArXlC7e5nB8dIFoH4sd/w=;
        b=8HBLhcnxKO4d/oY8tcl+5HXBD43OXCvJ7S1lw2k5q28RLZA3KIqLEQ6t6XOqf4BNIx
         PcoPJBrpBwDIY+yhxohsWjHQ0dhPBFeJNt5ptw7d2XA+Amuj0nHULP70Ppmy0o4I01Rx
         qFsDakb9+/Hwjop5h9UZ/kSkRX1DYxBDnxmsyQdo6llvuPf+0Ib8+SLj/MzcSrBhB86o
         TlhqAjJw3XhnPW0oA15F6g2c4QQ/0RTxBiIJieFe0dePh9UJjw7B4/tfJ+rU8/As3Ysf
         NeismIPFX+BJVEYGJV988zQhLw96IqeWli1s9NxSiSX4OcggtEnjZIyfSxwHwpsV4wSz
         oBUg==
X-Gm-Message-State: AOAM530DNh5irKKY6yU0BWeMDER1Ud/832olIGLTFRgUK3q4b9LvtNPJ
        w1FQr8dclGBL2gZ/jH2saSK8e/eztLI=
X-Google-Smtp-Source: ABdhPJzpxEZYrgdyEeZbLFIDHnrp5YI81GFRr1EVwQhimFbWIYq7baoC7mi28sNY8gGN+SfuuhsFHw==
X-Received: by 2002:a65:6ab6:: with SMTP id x22mr4351923pgu.215.1641756883705;
        Sun, 09 Jan 2022 11:34:43 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id o11sm4479116pfu.150.2022.01.09.11.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 11:34:42 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <ba2522fbabc8a81befd27ef20588f9356f7b885b.camel@surriel.com>
Date:   Sun, 9 Jan 2022 11:34:40 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Message-Id: <1B6896F0-7A51-4936-8B50-0B86551FA3B7@gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
 <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
 <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
 <ba2522fbabc8a81befd27ef20588f9356f7b885b.camel@surriel.com>
To:     Rik van Riel <riel@surriel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 9, 2022, at 11:22 AM, Rik van Riel <riel@surriel.com> wrote:
> 
> On Sun, 2022-01-09 at 00:49 -0800, Nadav Amit wrote:
>> 
>> It is possible for instance to get rid of is_lazy, keep the CPU
>> on mm_cpumask when switching to kernel thread, and then if/when
>> an IPI is received remove it from cpumask to avoid further
>> unnecessary TLB shootdown IPIs.
>> 
>> I do not know whether it is a pure win, but there is a tradeoff.
> 
> That's not a win at all. It is what we used to have before
> the lazy mm stuff was re-introduced, and it led to quite a
> few unnecessary IPIs, which are especially slow on virtual
> machines, where the target CPU may not be running.

You make a good point about VMs.

IIUC Lazy-TLB serves several goals:

1. Avoid arch address-space switch to save switching time and
   TLB misses.
2. Prevent unnecessary IPIs while kernel threads run.
3. Avoid cache-contention on mm_cpumask when switching to a kernel
   thread.

Your concern is with (2), and this one is easy to keep regardless
of the rest.

I am not sure that (3) is actually helpful, since it might lead
to more cache activity than without lazy-TLB, but that is somewhat
orthogonal to everything else.

As for (1), which is the most fragile aspect, unless you use
shadow page-tables, I am not sure there is a significant benefit.

