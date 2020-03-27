Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE32D1960F2
	for <lists+linux-arch@lfdr.de>; Fri, 27 Mar 2020 23:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgC0WSs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 18:18:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37623 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgC0WSp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 18:18:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id x3so12586609qki.4
        for <linux-arch@vger.kernel.org>; Fri, 27 Mar 2020 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7gy/G5yt4C6gRMEJcBMgk3+X7PiFDeDUNz7oegRXTc=;
        b=jCyHDDxnBfF/r4/912n+KwCBdRCnAbq0UBj3G8+HIjnKd+Ah5x2L8MCROJ0t5AuUPH
         uKyWVUP4P9eeMqpOMjdj3SNpUA/MFPTTunwWKdvArGIEWmn/VzLWo2z/kSo5iGXUlQ6W
         FOdWDHLQsBtkpt0t9NzbPsKeForxOVVJckPG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7gy/G5yt4C6gRMEJcBMgk3+X7PiFDeDUNz7oegRXTc=;
        b=twuf0YY/QcVKGHpcre+sWaC+uonc564yvUx3yoKJyGROqxdIu7txG1d1kxT4xtJSzF
         bsU/A/y2zoxEaVjx/OyuMd5ozarg4hv3UCBgxjpYv2h/jSbZPkO+bZ6qVBdT+HAkPO+N
         sMdLt4yTQN8cKHDQd7EMQxoGJhZ8dZbqiJuRrfPZXwYQCtvvm53qq0PPuIu7zqzolTLJ
         7y6iUp/NzVzHz/5RW75bJ4krP70M72Z40ujU5VZyKrFZYbr+FCZYb/AC4Cv8Ca8qURux
         Ry+gm9Nas5OnqIJC5/bRNUog1I1/TNH5ZA3AxXpcssUATpqbsbYnRVV9yzHO/wsL8GVI
         kutA==
X-Gm-Message-State: ANhLgQ1lz++hJXYD25bCdPBD4Dul8SPWCtrANwjbVxI/q2Z1+ecteRd6
        KiRzjqF0MSF4anZwhUHI/Oldag==
X-Google-Smtp-Source: ADFU+vu0g7q3fxyouuFS26fuvwVSpjPJNDmOaZ5QUZLg7+PprW6EA4oP+A3S2YPT8MOEVRaSlw3/jw==
X-Received: by 2002:a37:992:: with SMTP id 140mr1664796qkj.36.1585347524268;
        Fri, 27 Mar 2020 15:18:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d201sm4559968qke.59.2020.03.27.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 15:18:43 -0700 (PDT)
Date:   Fri, 27 Mar 2020 18:18:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Subject: Re: [PATCH v4 0/4] Documentation/litmus-tests: Add litmus tests for
 atomic APIs
Message-ID: <20200327221843.GA226939@google.com>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326024022.7566-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 26, 2020 at 10:40:18AM +0800, Boqun Feng wrote:
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
> v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/

For full series:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

One question I had was in the existing atomic_set() documentation, it talks
about atomic_add_unless() implementation based on locking could have issues.
It says the way to fix such cases is:

Quote:
    the typical solution is to then implement atomic_set{}() with
    atomic_xchg().

I didn't get how using atomic_xchg() fixes it. Is the assumption there that
atomic_xchg() would be implemented using locking to avoid atomic_set() having
issues? If so, we could clarify that in the document.

thanks,

 - Joel

> 
> Changes since v3:
> 
> *	Merge two patches on atomic-set litmus test into one as per
> 	Alan. (Alan, you have acked only one of the two patches, so I
> 	don't add you acked-by for the combined patch).
> 
> *	Move the atomic litmus tests into litmus-tests/atomic to align
> 	with Joel's recent patches on RCU litmus tests.
> 
> I think we still haven't reach to a conclusion for the difference of
> atomic_add_unless() in herdtools, and I'm currently reading the source
> code of herd to resovle this. This is just an updated version to resolve
> ealier comments and react on Joel's RCU litmus tests.
> 
> Regards,
> Boqun
> 
> [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> 
> Boqun Feng (4):
>   tools/memory-model: Add an exception for limitations on _unless()
>     family
>   Documentation/litmus-tests: Introduce atomic directory
>   Documentation/litmus-tests/atomic: Add a test for atomic_set()
>   Documentation/litmus-tests/atomic: Add a test for
>     smp_mb__after_atomic()
> 
>  Documentation/atomic_t.txt                    | 24 +++++++-------
>  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
>  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
>  Documentation/litmus-tests/atomic/README      | 16 ++++++++++
>  tools/memory-model/README                     | 10 ++++--
>  5 files changed, 91 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  create mode 100644 Documentation/litmus-tests/atomic/README
> 
> -- 
> 2.25.1
> 
