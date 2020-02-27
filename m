Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17D51725B2
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgB0Ryr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 12:54:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35184 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbgB0Ryr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 12:54:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id m3so370738wmi.0;
        Thu, 27 Feb 2020 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qg3PYnu5FMOFFG74LY324w2ZLOY5uaDUIGkPZAgNISI=;
        b=QjmqPzGLhMLFeNr1TulCmkzrpPqy5aZwrdoXdE40JjHV4eEdPARSSOZI6776w5Oqyp
         0VHCPJytsTqoCRuUHGXyp0fdejrESNpIMoCnrLnXfZ1I4aL09DmQDWdYAqYXjumyOEVb
         y0EzgRosdHDLhWtn3pRKXY0Yqd3TSei+iAxexl/KHnV+noUbWg9vs+lJTpRFtWPRyp+l
         XMGxmoqNeQwJKmGE/OW+V4//17r3BdO/I3RkONQcLK+3yCOq9tG7dgHJr1zI1mRJSJ2d
         eRj1AqePZtqVan/ZbbNe+cTJs6F21Ko9I7N5+YIvGA64utLtpctEssiwzTkP0ipz+Far
         o73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qg3PYnu5FMOFFG74LY324w2ZLOY5uaDUIGkPZAgNISI=;
        b=g0gv4KOvP1w8oSiXStEarjuRoCuypKn1Wr93pBfGS2ooRy0v1IwCeFl5MNbUfMUOh7
         7E8Jv38Nqg7A5eJ5vp6G90XKDIxNizu3CucKtk3JcJJr4weu9AR+s0rawOTgS9sGEKOu
         usXL/ttkHuO1B51XoPyWweB+q5A/8eP8mIt/QwIYq0HHIS6sQyraA3EcsBdWzIG7x5Zd
         bx5M2ZpF3nTi+iI6Tf4UrPgHH97LI9CuqD5PTwe7/qJ6gDZIYjJiqLoIkMFzRhdq7nHA
         LsUuMLQkaCVHCkfxnPGy8Iy5uz1Xw6nT4zIcUNbteAHCJAVoIDXL+jgAIqbIN3sQ2fQ7
         q7TA==
X-Gm-Message-State: APjAAAXFY7DcYVnYTt9FY90n1OnZF88ePzR6ni3EQqFMPl+MAWaSahax
        D26r9/TQ6wTWS33KbFeGgL8=
X-Google-Smtp-Source: APXvYqySqIDZ19wB8xHfz+5M018Wsx6j0e/fmElcfbQoaUip8y3pNJ2EWlvWYPQNlf3XJcrZdtzHVA==
X-Received: by 2002:a05:600c:22c8:: with SMTP id 8mr676376wmg.178.1582826084396;
        Thu, 27 Feb 2020 09:54:44 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id z21sm8579538wml.5.2020.02.27.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 09:54:43 -0800 (PST)
Date:   Thu, 27 Feb 2020 18:54:41 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Documentation/locking/atomic: Add litmus tests
 for atomic APIs
Message-ID: <20200227175441.GB12046@andrea>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227004049.6853-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 27, 2020 at 08:40:44AM +0800, Boqun Feng wrote:
> A recent discussion raises up the requirement for having test cases for
> atomic APIs:
> 
> 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> 
> , and since we already have a way to generate a test module from a
> litmus test with klitmus[1]. It makes sense that we add more litmus
> tests for atomic APIs. And based on the previous discussion, I create a
> new directory Documentation/atomic-tests and put these litmus tests
> here.
> 
> This patchset starts the work by adding the litmus tests which are
> already used in atomic_t.txt, and also improve the atomic_t.txt to make
> it consistent with the litmus tests.
> 
> Previous version:
> v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> 
> Changes since v2:
> 
> *	Change from "RFC" to "PATCH".
> 
> *	Wording improvement in atomic_t.txt as per Alan's suggestion.
> 
> *	Add a new patch describing the usage of atomic_add_unless() is
> 	not limited anymore for LKMM litmus tests.
> 
> My PR on supporting "(void) expr;" statement has been merged by Luc
> (Thank you, Luc). So all the litmus tests in this patchset can be
> handled by the herdtools compiled from latest master branch of the
> source code.
> 
> Comments and suggestions are welcome!

A few nits (see inline), but otherwise the series looks good to me;
with those fixed, please feel free to add:

Acked-by: Andrea Parri <parri.andrea@gmail.com>

to the entire series.

Thanks,
  Andrea


> 
> Regards,
> Boqun
> 
> [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> 
> Boqun Feng (5):
>   tools/memory-model: Add an exception for limitations on _unless()
>     family
>   Documentation/locking/atomic: Fix atomic-set litmus test
>   Documentation/locking/atomic: Introduce atomic-tests directory
>   Documentation/locking/atomic: Add a litmus test for atomic_set()
>   Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()
> 
>  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
>  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
>  Documentation/atomic-tests/README             | 16 ++++++++++
>  Documentation/atomic_t.txt                    | 24 +++++++-------
>  MAINTAINERS                                   |  1 +
>  tools/memory-model/README                     | 10 ++++--
>  6 files changed, 92 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>  create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  create mode 100644 Documentation/atomic-tests/README
> 
> -- 
> 2.25.0
> 
