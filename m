Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1969C1A6
	for <lists+linux-arch@lfdr.de>; Sun, 19 Feb 2023 18:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjBSRN3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Feb 2023 12:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjBSRN2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2023 12:13:28 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B138FEB6A
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 09:13:27 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z28so871681ljq.9
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FLnCzmxIt/DonRK9GYLq9VyjsNvoMWiJE0QzVv883cU=;
        b=fOBczrEtv/5bv99CXGdpRptOHgsXWAD9U1VVVyr0JRfP6QawLJL82rB1qCO4zmAq+5
         vZCHDUeI3vOaLji95aMc8TWy6TbGD5INfNvhK84pMglDkPgOMKDewk9j14JYhxdFpZgG
         BSIICRfOdzibHAxZrfpeVvyGwnj0mwQHZB5Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLnCzmxIt/DonRK9GYLq9VyjsNvoMWiJE0QzVv883cU=;
        b=MiMRcGcpTE/dy0Flw1zfguBZEcD5Ef8g+vlGQWmPH9E18w02E7cF6OoR90NDutc72v
         JE8M0Dp0v098wWVpgN9aiEAAKn6PG7w9CViJqZGENc5OmhRBHgGwFZu60FpavZVDJm6X
         UntA0bJ3PJAsOQ+TUElOBx9OPxWP3VPH897Uz1vY85SqHrMDpW+F7Y/eUEF5QYuOamQP
         IOT96gitstUvYTOnz9ycx+f8rCmiASdgmLjElimivsk6CI2yhj+rhp14hSYvf+gZIdJw
         jy6yUJcYYn/E3V1aQFQ5wWeV0yZi3VFPy7BE8mPXuk2S8JfKI8pBhX9O7zV+7auBJPcL
         xqLA==
X-Gm-Message-State: AO0yUKVs3NWnNue7cEYZvGuz63M7eI3yZycSM40obeUfZFtNavbHw1lf
        0m41T/zdpHhNLcb4OYu5DOGmovOzOSsCDc3g4xQbFw==
X-Google-Smtp-Source: AK7set8BayFeZknI9LfP/O0U7moXKLwWto8roCzAE9yYJZOYS1BGfiVsyZ4pjzm2DdO3cwz8ZgT6RLXu9c90eDn3YOA=
X-Received: by 2002:a05:651c:3de:b0:294:764a:330d with SMTP id
 f30-20020a05651c03de00b00294764a330dmr618109ljp.3.1676826805896; Sun, 19 Feb
 2023 09:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20230213015506.778246-1-joel@joelfernandes.org>
 <Y/JS5SYKPeeDQErL@rowland.harvard.edu> <CAEXW_YQrFSiDEM9cuhkTT2_1+CZoGbg7vC9oL-D-Wd5OQ2mm2w@mail.gmail.com>
In-Reply-To: <CAEXW_YQrFSiDEM9cuhkTT2_1+CZoGbg7vC9oL-D-Wd5OQ2mm2w@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 19 Feb 2023 12:13:14 -0500
Message-ID: <CAEXW_YR6eKDCv+E8Xv2aX=Eo=H0667cqrXkMqKhc_QMZ4Vf59A@mail.gmail.com>
Subject: Re: [PATCH] tools/memory-model: Add details about SRCU read-side
 critical sections
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 19, 2023 at 12:11 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Sun, Feb 19, 2023 at 11:48 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, Feb 13, 2023 at 01:55:06AM +0000, Joel Fernandes (Google) wrote:
[...]
> > +       A: idx1 = srcu_read_lock(&s);
> > +       B: srcu_read_unlock(&s, idx1);
> > +       C: idx2 = srcu_read_lock(&s);
> > +       D: srcu_read_unlock(&s, idx2);
> > +
> > +it would appear that B was a store to a temporary variable (i.e., s)
> > +and C was a load from that variable, thereby allowing carry-srcu-data
> > +to extend a data dependency from A to D and giving the impression
> > +that D was the srcu-unlock event matching A's srcu-lock.
>
> Even though it may be redundant: would it be possible to also mention
> (after this paragraph) that this case forms an undesirable "->rf" link
> between B and C, which then causes us to link A and D as a result?
>
> A[srcu-lock] ->data B[once] ->rf C[once] ->data D[srcu-unlock].

Apologies, I meant here, care must be taken to avoid:

A[srcu-lock] ->data B[srcu-unlock] ->rf C[srcu-lock] ->data D[srcu-unlock].

Thanks,

  - Joel
