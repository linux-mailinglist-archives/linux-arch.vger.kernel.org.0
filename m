Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B58276A27
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2019 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfGZN4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jul 2019 09:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387777AbfGZNlu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Jul 2019 09:41:50 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2672A22CF5;
        Fri, 26 Jul 2019 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148509;
        bh=zX30Y7I8lGQSE39mcBLgCQnD1zhzLqgkvgnTgW8bI/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k7/MYg0MGLbki0g3EqS6d5XoAuDjmxLmZ5gir1IHBeua4yDd4S/goV17so5PiFt8n
         +FJh7ZVsJa/LcxUvub/nflNlyhoyELQboQqE6meOYLtPh7zlfMdNwoyEKTbOxO4dvN
         n1+yN7Rq6NuEbvgyeiChNQerVHe6alV6d3tfnU8g=
Received: by mail-qk1-f172.google.com with SMTP id v22so39029500qkj.8;
        Fri, 26 Jul 2019 06:41:49 -0700 (PDT)
X-Gm-Message-State: APjAAAW6M4OTnD6ssHM6XypNkKeXuIX16MHEhAhKgQNS9mb8d+YFTD4h
        wk3szdOcuFgO0FJ3KMpWPvDVUqaPGOoQOF9q9Q==
X-Google-Smtp-Source: APXvYqxjuwBX7ksE7JbZB0mI6ceV0xcxiT8SPZ6Gi56d7P4U1vzH0bY2zZ15ZhXiikKw8Sd4XxO8RlHxVifobutyBU8=
X-Received: by 2002:a37:a010:: with SMTP id j16mr64220208qke.152.1564148507205;
 Fri, 26 Jul 2019 06:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564140865.git.mchehab+samsung@kernel.org> <430ed96cb234805d1deb216e8c8559da22cc6bac.1564140865.git.mchehab+samsung@kernel.org>
In-Reply-To: <430ed96cb234805d1deb216e8c8559da22cc6bac.1564140865.git.mchehab+samsung@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 26 Jul 2019 07:41:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK_rfHehrKW_NS89BOV0=dYoao0H=zOzG=D-724vKduKw@mail.gmail.com>
Message-ID: <CAL_JsqK_rfHehrKW_NS89BOV0=dYoao0H=zOzG=D-724vKduKw@mail.gmail.com>
Subject: Re: [PATCH 1/7] docs: fix broken doc references due to renames
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Ajay Gupta <ajayg@nvidia.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        rcu@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        esc.storagedev@microsemi.com, SCSI <linux-scsi@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 26, 2019 at 5:47 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Some files got renamed but probably due to some merge conflicts,
> a few references still point to the old locations.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Wolfram Sang <wsa@the-dreams.de> # I2C part
> Reviewed-by: Jerry Hoemann <jerry.hoemann@hpe.com> # hpwdt.rst
> ---
>  Documentation/RCU/rculist_nulls.txt                   |  2 +-
>  Documentation/devicetree/bindings/arm/idle-states.txt |  2 +-
>  Documentation/locking/spinlocks.rst                   |  4 ++--
>  Documentation/memory-barriers.txt                     |  2 +-
>  Documentation/translations/ko_KR/memory-barriers.txt  |  2 +-
>  Documentation/watchdog/hpwdt.rst                      |  2 +-
>  MAINTAINERS                                           | 10 +++++-----
>  drivers/gpu/drm/drm_modes.c                           |  2 +-
>  drivers/i2c/busses/i2c-nvidia-gpu.c                   |  2 +-
>  drivers/scsi/hpsa.c                                   |  4 ++--
>  10 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
