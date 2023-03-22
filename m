Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355116C4040
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 03:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCVCR3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 22:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCVCR2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 22:17:28 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143159E7F
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 19:17:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54184571389so314248167b3.4
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679451445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXmlWsfpHidjnzMMfJhnUbznIcU3qDUMNvteO7VcB5A=;
        b=RMxoO7oSwkzKqjHaV+Bo8mIUTpsxaztVLZ4vz6mi4hzfQV+R4NSRXWMnLKwnWuzeaY
         JmkfT/dycDTyyiKWbg0P3TgHiZQupruPxfbCvxByU09HATYSU0aCQBOCUp7QaHy++Udh
         HNS4ONj7SQnAe6xqeFHklnV6a2NgfdulJS+gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679451445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXmlWsfpHidjnzMMfJhnUbznIcU3qDUMNvteO7VcB5A=;
        b=2Zp9KuXJrAuC8p+jLJlx233K40ELUEGDMNTCJXF3ugVq0b1sJiphyIAhdYEQD+gtEu
         McG5OPQ5VWrvqFHDvWsD/E91cqqheFPhFkEzopFAqoKQ35IUNex7H8nM9DqzXgn5qRi/
         YyAZlNCcbs2jVSEzw292nhisxtc2ErBbJ1XZU6PsSF0jQXxw0fKHNeJX/k4Yzqj6GgKF
         iEFJ/47XKa2IHcwH9zk4MABkkoTSybZ2CQsNKMr7bJ9zmjFjGuxSoE3QH3JoCRsbxxa7
         v0NQoXcJW1coYlm10Z+5b8UvrLKLkrndO3pCU6ssf/y6Fgsnu6ucSWNQMoYg5xRzX6U6
         k6LQ==
X-Gm-Message-State: AAQBX9e8TXtHdV/BP1dY4b2xfyxLRCObsroj4PGLwmr5ix5dK7+NueQO
        cr/58eBwApQmMFNVYoH/WjNk0XyTm/JrxYxbwC/bwA==
X-Google-Smtp-Source: AKy350ZtKDIxbb00+fn9TcSFKm6hNLq8rMsMzKMCKahHS5r8rYYO9fLhPjUB1VsTQddlq/zRIfz83Ckc8/IoElRP3fE=
X-Received: by 2002:a81:ad53:0:b0:541:693f:cdd1 with SMTP id
 l19-20020a81ad53000000b00541693fcdd1mr2386512ywk.9.1679451445522; Tue, 21 Mar
 2023 19:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-7-paulmck@kernel.org> <ZBpcpPIq9k2mX7cw@andrea>
In-Reply-To: <ZBpcpPIq9k2mX7cw@andrea>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 21 Mar 2023 22:17:14 -0400
Message-ID: <CAEXW_YTTFa7mC_1v-oDbFWPxHyfx58CvcCyNu+53MWNNo8d+NA@mail.gmail.com>
Subject: Re: [PATCH memory-model 7/8] tools/memory-model: Add documentation
 about SRCU read-side critical sections
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 9:40=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> On Mon, Mar 20, 2023 at 06:02:45PM -0700, Paul E. McKenney wrote:
> > From: Alan Stern <stern@rowland.harvard.edu>
> >
> > Expand the discussion of SRCU and its read-side critical sections in
> > the Linux Kernel Memory Model documentation file explanation.txt.  The
> > new material discusses recent changes to the memory model made in
> > commit 6cd244c87428 ("tools/memory-model: Provide exact SRCU
> > semantics").
>
> How about squashing the diff below (adjusting subject and changelog):
>
>   Andrea
>
> diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/me=
mory-model/Documentation/litmus-tests.txt
> index 26554b1c5575e..acac527328a1f 100644
> --- a/tools/memory-model/Documentation/litmus-tests.txt
> +++ b/tools/memory-model/Documentation/litmus-tests.txt
> @@ -1028,32 +1028,7 @@ Limitations of the Linux-kernel memory model (LKMM=
) include:
>                 additional call_rcu() process to the site of the
>                 emulated rcu-barrier().
>
> -       e.      Although sleepable RCU (SRCU) is now modeled, there
> -               are some subtle differences between its semantics and
> -               those in the Linux kernel.  For example, the kernel
> -               might interpret the following sequence as two partially
> -               overlapping SRCU read-side critical sections:
> -
> -                        1  r1 =3D srcu_read_lock(&my_srcu);
> -                        2  do_something_1();
> -                        3  r2 =3D srcu_read_lock(&my_srcu);
> -                        4  do_something_2();
> -                        5  srcu_read_unlock(&my_srcu, r1);
> -                        6  do_something_3();
> -                        7  srcu_read_unlock(&my_srcu, r2);
> -
> -               In contrast, LKMM will interpret this as a nested pair of
> -               SRCU read-side critical sections, with the outer critical
> -               section spanning lines 1-7 and the inner critical section
> -               spanning lines 3-5.
> -
> -               This difference would be more of a concern had anyone
> -               identified a reasonable use case for partially overlappin=
g
> -               SRCU read-side critical sections.  For more information
> -               on the trickiness of such overlapping, please see:
> -               https://paulmck.livejournal.com/40593.html
> -
> -       f.      Reader-writer locking is not modeled.  It can be
> +       e.      Reader-writer locking is not modeled.  It can be
>                 emulated in litmus tests using atomic read-modify-write

Good point! And for the diff:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>                 operations.
>
>
>   Andrea
