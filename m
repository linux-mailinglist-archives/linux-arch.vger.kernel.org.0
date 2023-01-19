Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E295672F5D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 04:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjASDE7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 22:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjASDE5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 22:04:57 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442842DD9
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 19:04:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so4541593pjm.1
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 19:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/gHZEBJUqbXfG5JX1H5lnam0IN6TNXNjBZYcdLB8wc=;
        b=bhWSFtHFWzg3KaP6hdKmTWRc+V9Fox21VYwUq0wTkIBSKY3ClnhvXUqHrGuuAvBhkz
         WCDVAI3Rzb79DGG3/FspTjpuS3o0BQV8+iwZDwbwkFhojO8Am0TFeO2AS4AJ/1Vpl/bu
         QOPOLbW6JtRWSdr3FGbSfDZEMf3D6AB4c9WZEho6CHb9N37dU4DdY5qfoaNQJkQZpR9+
         TZAo0/OD8U9HQka/hBfHIubzNBRsd14gwDKc0p+jI9ZVwweOmb7ZbrHA1AclDU2wwKPH
         9T1TQWRHh9PyQ0Qm/E2ioM7u0ztci3DrxDuMlwc1oQAKgRjh871aYDRUEITBu2ZxqsDS
         wMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c/gHZEBJUqbXfG5JX1H5lnam0IN6TNXNjBZYcdLB8wc=;
        b=URi+ibXknqj1Yb18oF+LHjL9oMquGd/mecVurEVFbiOw0iI8t/HuDa/mNvQDg3SkFv
         nzPlOfL1j144DFj3bKRumQU/b1TYSQvHXx1atblMyY8TgdaUIMaIEkBqOW1i1KoyOtkv
         KhNcsO+1gtv/xw7aRhEgnOWrL7RS5aTy3su2W8nFIEaYjhZwkaH/ASOvF+gNEuzQ9xai
         Y3fRjaIQApGMkhMJvpv+8LDw2Zhc0n2apx2nFnV9JuK6bIqC9U61TkrbKWF+FbznsY+9
         jyxxN835X7o7SHQuiVk9vViFNcB3/YYaLZl+UcPiuWFzDuzXi44Uoxwn+b+v+Zu6ZlhS
         EG2g==
X-Gm-Message-State: AFqh2kqI+vzLocFJwN6vyNbjgcVWFI6g9hdJLHhkvsaVU4bFReMOqFU9
        Y73RlEDNcC0YRQNe2E77muU=
X-Google-Smtp-Source: AMrXdXvH7nWDObatVJJJ0rFrPx7ePH/E+zXu/f0VqlxwbgvnLGgalRPIiDu/+GlHLmvdgYcf9hqo9Q==
X-Received: by 2002:a17:902:8a8a:b0:194:480d:6afc with SMTP id p10-20020a1709028a8a00b00194480d6afcmr8663252plo.48.1674097491373;
        Wed, 18 Jan 2023 19:04:51 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902b49400b00194caf3e975sm227479plr.208.2023.01.18.19.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 19:04:50 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 19 Jan 2023 13:04:44 +1000
Message-Id: <CPVU13AC1206.2SHGMTJDZK6H8@bobo>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-arch" <linux-arch@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 4/5] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
X-Mailer: aerc 0.13.0
References: <20230118080011.2258375-1-npiggin@gmail.com>
 <20230118080011.2258375-5-npiggin@gmail.com>
 <CAHk-=wiLaY7K6N4VF=wgS+AVsFi298fMA3Tx6rzbbP7xT+1Dqg@mail.gmail.com>
In-Reply-To: <CAHk-=wiLaY7K6N4VF=wgS+AVsFi298fMA3Tx6rzbbP7xT+1Dqg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu Jan 19, 2023 at 3:30 AM AEST, Linus Torvalds wrote:
> [ Adding a few more x86 and arm64 maintainers - while linux-arch is
> the right mailing list, I'm not convinced people actually follow it
> all that closely ]
>
> On Wed, Jan 18, 2023 at 12:00 AM Nicholas Piggin <npiggin@gmail.com> wrot=
e:
> >
> > On a 16-socket 192-core POWER8 system, a context switching benchmark
> > with as many software threads as CPUs (so each switch will go in and
> > out of idle), upstream can achieve a rate of about 1 million context
> > switches per second, due to contention on the mm refcount.
> >
> > 64s meets the prerequisites for CONFIG_MMU_LAZY_TLB_SHOOTDOWN, so enabl=
e
> > the option. This increases the above benchmark to 118 million context
> > switches per second.
>
> Well, the 1M -> 118M change does seem like a good reason for this series.

It was an artificial corner case, mind you. I don't think it's a reason
to panic and likely smaller systems with faster atomics will care far
less than our big 2-hop systems.

Benchmark is will-it-scale:

  ./context_switch1_threads -t 768
  min:2174 max:2690 total:1827952

    33.52%  [k] finish_task_switch
    27.26%  [k] interrupt_return
    22.66%  [k] __schedule
     2.30%  [k] _raw_spin_trylock

  ./context_switch1_threads -t 1536
  min:103000 max:120100 total:177201906

The top case has 1/2 the switching pairs to available CPU, which makes
them all switch the same mm between real and lazy. Bottom case is
just switching between user threads so that doesn't hit the lazy
refcount.

> The patches certainly don't look offensive to me, so Ack as far as I'm
> concerned, but honestly, it's been some time since I've personally
> been active on the idle and lazy TLB code, so that ack is probably
> largely worthless.
>
> If anything, my main reaction to this all is to wonder whether the
> config option is a good idea - maybe we could do this unconditionally,
> and make the source code (and logic) simpler to follow when you don't
> have to worry about the CONFIG_MMU_LAZY_TLB_REFCOUNT option.
>
> I wouldn't be surprised to hear that x86 can have the same issue where
> the mm_struct refcount is a bigger issue than the possibility of an
> extra TLB shootdown at the final exit time.
>
> But having the config options as a way to switch people over gradually
> (and perhaps then removing it later) doesn't sound wrong to me either.

IMO it's trivial enough that we could carry both, but everything's a
straw on the camel's back so if we can consolidate it would always be
preferebale. Let's see how it plays out for a few releases.

> And I personally find the argument in patch 3/5 fairly convincing:
>
>   Shootdown IPIs cost could be an issue, but they have not been observed
>   to be a serious problem with this scheme, because short-lived processes
>   tend not to migrate CPUs much, therefore they don't get much chance to
>   leave lazy tlb mm references on remote CPUs.
>
> Andy? PeterZ? Catalin?
>
> Nick - it might be good to link to the actual benchmark, and let
> people who have access to big machines perhaps just try it out on
> non-powerpc platforms...

Yep good point, I'll put it in the changelog. I might submit another
round to Andrew in a bit with acks and any minor tweaks and minus the
last patch, assuming no major changes or objections.

Thanks,
Nick
