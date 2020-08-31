Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30747257183
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 03:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgHaBZs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Aug 2020 21:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgHaBZr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Aug 2020 21:25:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92420C061573;
        Sun, 30 Aug 2020 18:25:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so2277340plt.3;
        Sun, 30 Aug 2020 18:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=eARx1NqbK9cEMSTK0kovkIRCeTmjYLrGl8JwZL49msc=;
        b=AMICkpYpQtfwYuM5YfzmKI/2S9Dy7iamVYX274pCkmLkM020DzLO/KECFWB0LrrYRA
         EHvm2gwJNKHGFSM3G1i5kLcG6PSFldnFM3tHw5B6GDChDXhjmI99A6t7UQnerBn0+njY
         yCjTCAyPvSArL44z50DFQxOXq/8d3d7yUHKkoylWkVDmYRRT/wYyRWxwP9Dd9LfFukU2
         ET9jTGnrgi+N09mEZVeUECtMglYsdQDVn5Gv7BcQg8KEZEWtCJEdqbhvjQO+kIqOk4Fc
         qG0ef/Oqzc6xSoMqmyj82eKigo0G/7wiERd2/zdTZYPqPa5FrEUN42l/MvQxC32emVyf
         jj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=eARx1NqbK9cEMSTK0kovkIRCeTmjYLrGl8JwZL49msc=;
        b=JY88aT06G9DvEIMR3wZmGKmLU9kGvQ/zVq6sqedB8hIzUmiz4HBm0A1EFGIj0SJYoO
         Xu5Nni58JoeXboritelDWICdhPsqBkKbGbGFMzv5zPXKkfBstCEImzESXavK8tH+qUrT
         h9On/zvg3yGpDkLdD7wgwdy4aUKklC2UDpA0xFoldzZHFxVEJycqNvpONN7PpJIIHU5K
         P29wug7QxsCUQM+9gdU11VN9U69zI/Ncz9AyDvkPMsSIA1LtZGvS1MtjaEv3Ephoy4jE
         IEj5ieYNahNr3BUQwgWnFBvqWnsO4ekfqe3jr41g6GtylhryVp8f0EgsdhEmaUqyns13
         V6Yg==
X-Gm-Message-State: AOAM533wXy73VhhrD9hnTiyIrcuw4l4E9q6RMMLTQOMK9mFFchaqGQ+D
        HP2wvApcxOdIF1igEynA7vM=
X-Google-Smtp-Source: ABdhPJx/37k6JWKk7f4bhAcf3BKShVBZljvH6AJ/SamaTx0TBqUROompCQBrZqrwy1BdpiHRWFV0kQ==
X-Received: by 2002:a17:90b:4b89:: with SMTP id lr9mr8718820pjb.126.1598837145608;
        Sun, 30 Aug 2020 18:25:45 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id d1sm5201193pjs.17.2020.08.30.18.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 18:25:45 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:25:39 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/4] mm: fix exec activate_mm vs TLB shootdown and lazy
 tlb switching race
To:     peterz@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
References: <20200828100022.1099682-1-npiggin@gmail.com>
        <20200828100022.1099682-2-npiggin@gmail.com>
        <20200828111525.GX1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200828111525.GX1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1598836589.75k5wmftvn.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from peterz@infradead.org's message of August 28, 2020 9:15 pm:
> On Fri, Aug 28, 2020 at 08:00:19PM +1000, Nicholas Piggin wrote:
>=20
>> Closing this race only requires interrupts to be disabled while ->mm
>> and ->active_mm are being switched, but the TLB problem requires also
>> holding interrupts off over activate_mm. Unfortunately not all archs
>> can do that yet, e.g., arm defers the switch if irqs are disabled and
>> expects finish_arch_post_lock_switch() to be called to complete the
>> flush; um takes a blocking lock in activate_mm().
>=20
> ARM at least has activate_mm() :=3D switch_mm(), so it could be made to
> work.
>

Yeah, so long as that post_lock_switch switch did the right thing with
respect to its TLB flushing. It should do because arm doesn't seem to
check ->mm or ->active_mm (and if it was broken, the scheduler context
switch would be suspect too). I don't think the fix would be hard, just
that I don't have a good way to test it and qemu isn't great for testing
this kind of thing.

um too I think could probably defer that lock until after interrupts are
enabled again. I might throw a bunch of arch conversion patches over the
wall if this gets merged and try to move things along.

Thanks,
Nick
