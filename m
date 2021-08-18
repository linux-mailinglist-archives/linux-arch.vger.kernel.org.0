Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FF63EFCFA
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 08:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhHRGmS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhHRGmS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Aug 2021 02:42:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659FC061764;
        Tue, 17 Aug 2021 23:41:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so1057680wmb.5;
        Tue, 17 Aug 2021 23:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AcoE87R52VyKOHG28xukneuIANPukP0XGTGJ2UbaRWQ=;
        b=fSJEiK8mzY/9sHx+lIix/vXIsZux5UcOrmqHIKFFn6AFzXA16kA8wY8tXgEWjSJ8Lm
         JVZbcK9v67RTRrO4H9ViCz8+tTJnDGbpPGwTjvmjYIYQ5oP6vkCOaXp73cPYglu5RFXi
         cCJNXfPk/HN74TLzICueAgB/uVmNjv1ccTM1UHfd2bGqhWWiDT+HgJjCbB0Vj7d2m3zP
         p3ruTGxFqReyEQi4dE9EH38Q46UbBJWyqhlkN2QcPB+EVpg0e8SpDfTYUgjzWizmNb+b
         GuT8n3Cxl9k9vpcX3Z5HKgj5QmptwBrNPVvzbJJRDAMDWLtd4I6Xsh8f38O+QtMwYlbs
         vuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AcoE87R52VyKOHG28xukneuIANPukP0XGTGJ2UbaRWQ=;
        b=GmogE87SlYz/AmxtomQfD8v76fG/zu1ta7nC0GAEiyT8I+1VggmNM5Oz8AKWSP+bZk
         ZNoa4E4mtSAyEG0+aejdWkubkDf7BfF0AxF+EojDirCXji9Z6bnCT+RG060Q8YNK/gAb
         MaId6+GCrxPvjNhc4aYzzk9m2TCnYEmPw7PLofoVlJ6vV9r5NHR5K9vUVr/wKHxId7Eq
         FMlOqKh/lrgp8R+1lVswMCntzbSX5jJzH3N8cjUS/Az8DP6Ac+VUzK8DEgPrjJoRDJfL
         0mIjN257IBTEHrx5RQe0D4DYyrMnHIW+oRnTEmdaceYE8y/L9gDqNSSWAor3DQBvEZUg
         D2Aw==
X-Gm-Message-State: AOAM531XC2+zWNCewOGlJk2Ef/DzOxmESQlc1Utc9EMKOqFa5OCV6wp/
        22GpM4auXGqHYmN7U01qEVvXTECOBLM=
X-Google-Smtp-Source: ABdhPJwEOHOCBm92kSOopobU33IB1fbEqL6eDL2ttMM07p39cfeSqG8JM1ie1mhI+cnHppoMpGKV9w==
X-Received: by 2002:a05:600c:2c4a:: with SMTP id r10mr6992863wmg.68.1629268902891;
        Tue, 17 Aug 2021 23:41:42 -0700 (PDT)
Received: from gmail.com (77-234-64-129.pool.digikabel.hu. [77.234.64.129])
        by smtp.gmail.com with ESMTPSA id r8sm4927717wrj.11.2021.08.17.23.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:41:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Aug 2021 08:41:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     manfred@colorfullife.com, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [GIT PULL lkmm] LKMM commits for v5.15
Message-ID: <YRyrpPhEdRCnRmlq@gmail.com>
References: <20210812002535.GA405507@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812002535.GA405507@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo!
> 
> This pull request contains changes for the Linux-kernel memory model
> (LKMM).  These changes focus on documentation, providing additional
> examples and use cases.  These have been posted to LKML:
> 
> https://lore.kernel.org/lkml/20210721211003.869892-1-paulmck@kernel.org/
> https://lore.kernel.org/lkml/20210721211003.869892-2-paulmck@kernel.org/
> https://lore.kernel.org/lkml/20210721211003.869892-3-paulmck@kernel.org/
> https://lore.kernel.org/lkml/20210721211003.869892-4-paulmck@kernel.org/
> 
> They have been exposed to -next and the kernel test robot, not that these
> services do all that much for documentation changes.
> 
> The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:
> 
>   Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm
> 
> for you to fetch changes up to 87859a8e3f083bd57b34e6a962544d775a76b15f:
> 
>   tools/memory-model: Document data_race(READ_ONCE()) (2021-07-27 11:48:55 -0700)
> 
> ----------------------------------------------------------------
> Manfred Spraul (1):
>       tools/memory-model: Heuristics using data_race() must handle all values
> 
> Paul E. McKenney (3):
>       tools/memory-model: Make read_foo_diagnostic() more clearly diagnostic
>       tools/memory-model: Add example for heuristic lockless reads
>       tools/memory-model: Document data_race(READ_ONCE())
> 
>  .../memory-model/Documentation/access-marking.txt  | 151 ++++++++++++++++++---
>  1 file changed, 135 insertions(+), 16 deletions(-)

Pulled into tip:locking/debug, thanks a lot Paul!

	Ingo
