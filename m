Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94146724F4
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 18:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjARRbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 12:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjARRbA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 12:31:00 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E175599B7
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 09:30:42 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g9so15739710qtu.2
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 09:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45VTI8G2wI4nS2eH3K9pAMjugnugZ8TVFHXhCaZ9BN4=;
        b=KHKCIU14OK3pQZodreyf7cATu0CnBQ6Qp/eyFOrDD7AtFbqgOhemxuzdFJljGaeQVx
         fFRqwtRDmL31BGjxA2umkxBS2bzIUxJXG7wccQXsOU1uKFkErI9PWKf3gKBRSCN1cRFu
         fZ7h59H1HqHCAQh4z6y/0HqZ7cCPYHBKbh2DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45VTI8G2wI4nS2eH3K9pAMjugnugZ8TVFHXhCaZ9BN4=;
        b=zLOAV9GqW9ib+97Z0EF8iyiI/DGJv57thQ1IBKoiM2uKL0lAXzPn+sYwFR0AVMClSB
         KMjqWLrUUqqP1tAunTp3z/muLUc4FIpOCqNPJO9317gH48AkZYBN5H/L0rIizUm/rcJ4
         DKHrk6JNLNNZBhNyDDC0AlxAkpLTFY3Qa3gVQ6/DDNpiUBrG1qx3c6u/K5iAaugHO8F9
         fx+FgdJMdbPTE88bAOEHKncq44YnjbH0YiyMVF9M/sYF5yln14B9rbwaO4EogojiCod3
         8tnhWGaI40KDm+1XiOyxzkn1zc9vGtoDEcCs40fGIVgMc4WiiCequlS/T/8mvvkwCRax
         8lSg==
X-Gm-Message-State: AFqh2kpFa8NNvwMvj/u9wT/KxGBUzsDc+dpdES0eF5VszF+FTlczKykI
        PoKWVOqQva67D78Acp7c4SBXCJqW63+zTf38
X-Google-Smtp-Source: AMrXdXvpv0XIEto8fmEFE49zFnDdJhIW6zytorOrLDvNTdsTVWMvf+Tssm7iu3hZ1h41FHbuiIR7mQ==
X-Received: by 2002:ac8:5358:0:b0:3b6:6d85:8812 with SMTP id d24-20020ac85358000000b003b66d858812mr5205123qto.40.1674063039636;
        Wed, 18 Jan 2023 09:30:39 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id d25-20020ac85459000000b003b630456b8fsm4889487qtq.89.2023.01.18.09.30.39
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:30:39 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id pj1so18343239qkn.3
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 09:30:39 -0800 (PST)
X-Received: by 2002:ae9:efd8:0:b0:706:e593:2598 with SMTP id
 d207-20020ae9efd8000000b00706e5932598mr50927qkg.216.1674063038833; Wed, 18
 Jan 2023 09:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20230118080011.2258375-1-npiggin@gmail.com> <20230118080011.2258375-5-npiggin@gmail.com>
In-Reply-To: <20230118080011.2258375-5-npiggin@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jan 2023 09:30:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLaY7K6N4VF=wgS+AVsFi298fMA3Tx6rzbbP7xT+1Dqg@mail.gmail.com>
Message-ID: <CAHk-=wiLaY7K6N4VF=wgS+AVsFi298fMA3Tx6rzbbP7xT+1Dqg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
To:     Nicholas Piggin <npiggin@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[ Adding a few more x86 and arm64 maintainers - while linux-arch is
the right mailing list, I'm not convinced people actually follow it
all that closely ]

On Wed, Jan 18, 2023 at 12:00 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On a 16-socket 192-core POWER8 system, a context switching benchmark
> with as many software threads as CPUs (so each switch will go in and
> out of idle), upstream can achieve a rate of about 1 million context
> switches per second, due to contention on the mm refcount.
>
> 64s meets the prerequisites for CONFIG_MMU_LAZY_TLB_SHOOTDOWN, so enable
> the option. This increases the above benchmark to 118 million context
> switches per second.

Well, the 1M -> 118M change does seem like a good reason for this series.

The patches certainly don't look offensive to me, so Ack as far as I'm
concerned, but honestly, it's been some time since I've personally
been active on the idle and lazy TLB code, so that ack is probably
largely worthless.

If anything, my main reaction to this all is to wonder whether the
config option is a good idea - maybe we could do this unconditionally,
and make the source code (and logic) simpler to follow when you don't
have to worry about the CONFIG_MMU_LAZY_TLB_REFCOUNT option.

I wouldn't be surprised to hear that x86 can have the same issue where
the mm_struct refcount is a bigger issue than the possibility of an
extra TLB shootdown at the final exit time.

But having the config options as a way to switch people over gradually
(and perhaps then removing it later) doesn't sound wrong to me either.

And I personally find the argument in patch 3/5 fairly convincing:

  Shootdown IPIs cost could be an issue, but they have not been observed
  to be a serious problem with this scheme, because short-lived processes
  tend not to migrate CPUs much, therefore they don't get much chance to
  leave lazy tlb mm references on remote CPUs.

Andy? PeterZ? Catalin?

Nick - it might be good to link to the actual benchmark, and let
people who have access to big machines perhaps just try it out on
non-powerpc platforms...

                   Linus
