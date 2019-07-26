Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A66876B8D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2019 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbfGZOZB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jul 2019 10:25:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41400 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfGZOZA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jul 2019 10:25:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so53418500eds.8
        for <linux-arch@vger.kernel.org>; Fri, 26 Jul 2019 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iKvptB00eRJtAAyTA2xD7jIbIFN8n5r7X55dRtJg5Cw=;
        b=f5L5IA3ayQmsQHY5KhIVuOFZAzingVgEcKk8EvRC5mL0KaqQyGnWAI0cbPTrNNuCz7
         K18hM9pz10KIe5v0Z75fubUwSrYuFdOojHzAiYoIdyx9DO1Z5oW1vH1CNjwbsYziO6sT
         /QI7SGtnnJxli3UbqAjXRyOHKL5kB7R4In+E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=iKvptB00eRJtAAyTA2xD7jIbIFN8n5r7X55dRtJg5Cw=;
        b=iBgNy9q/QNetAfoFch5HFTHRJIs8TqUrNpPcqvJbcwbrdgJ6sDS6R8ptpNX2TFSBgh
         +fy32RHs1Vtjw4IWXXgdsVfNj7N6tPvd9VIEx1seFi9cgwJtksltj1Epgqg70dKpfiZP
         oE+stfh7s3kUjlPmygyFz3m4R3jsSVJVLC55LvvZh0tVS1ntK7CmMZRxTphXa/GvEBHr
         IPgF6MeBbiCO2cEAMAtt5fOUz9OsxkLxDvw2qNaxYlf5mcI6Hm4PEHnrFLnng5vzETj2
         AFUkD90CPFpPbMOlv1l+NsOkxqI1L3V2axzoPpNFXJgclOwz6PWx52FRNOIYTR/+MMdh
         XUhg==
X-Gm-Message-State: APjAAAVUswy2jOMTyPWOn0Z6vmNY8Mznre1XeZk307J9pzV4grL8uPpJ
        b28on1yRfThy5ui42Kg90Hg=
X-Google-Smtp-Source: APXvYqziEeXaDKlMzj6WkqFhfWfsWvSAtDFO47Ob8pLZS5KABUGhUNYgZNlFDTi49ewicGXyP7F9Dg==
X-Received: by 2002:a50:ad48:: with SMTP id z8mr82669671edc.66.1564151094716;
        Fri, 26 Jul 2019 07:24:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m31sm14121701edd.42.2019.07.26.07.24.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 07:24:53 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:24:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
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
Subject: Re: [PATCH 1/7] docs: fix broken doc references due to renames
Message-ID: <20190726142450.GJ15868@phenom.ffwll.local>
Mail-Followup-To: Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
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
        Ajay Gupta <ajayg@nvidia.com>, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        rcu@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux I2C <linux-i2c@vger.kernel.org>, esc.storagedev@microsemi.com,
        SCSI <linux-scsi@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
 <430ed96cb234805d1deb216e8c8559da22cc6bac.1564140865.git.mchehab+samsung@kernel.org>
 <CAL_JsqK_rfHehrKW_NS89BOV0=dYoao0H=zOzG=D-724vKduKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK_rfHehrKW_NS89BOV0=dYoao0H=zOzG=D-724vKduKw@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 26, 2019 at 07:41:35AM -0600, Rob Herring wrote:
> On Fri, Jul 26, 2019 at 5:47 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > Some files got renamed but probably due to some merge conflicts,
> > a few references still point to the old locations.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > Acked-by: Wolfram Sang <wsa@the-dreams.de> # I2C part
> > Reviewed-by: Jerry Hoemann <jerry.hoemann@hpe.com> # hpwdt.rst
> > ---
> >  Documentation/RCU/rculist_nulls.txt                   |  2 +-
> >  Documentation/devicetree/bindings/arm/idle-states.txt |  2 +-
> >  Documentation/locking/spinlocks.rst                   |  4 ++--
> >  Documentation/memory-barriers.txt                     |  2 +-
> >  Documentation/translations/ko_KR/memory-barriers.txt  |  2 +-
> >  Documentation/watchdog/hpwdt.rst                      |  2 +-
> >  MAINTAINERS                                           | 10 +++++-----
> >  drivers/gpu/drm/drm_modes.c                           |  2 +-

for the drm part:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> >  drivers/i2c/busses/i2c-nvidia-gpu.c                   |  2 +-
> >  drivers/scsi/hpsa.c                                   |  4 ++--
> >  10 files changed, 16 insertions(+), 16 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
