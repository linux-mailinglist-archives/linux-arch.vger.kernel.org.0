Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09705B4D4A
	for <lists+linux-arch@lfdr.de>; Sun, 11 Sep 2022 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIKKVS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Sep 2022 06:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiIKKVQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Sep 2022 06:21:16 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B32386A5
        for <linux-arch@vger.kernel.org>; Sun, 11 Sep 2022 03:21:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q83so2764475iod.7
        for <linux-arch@vger.kernel.org>; Sun, 11 Sep 2022 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LI2Uo6Tmdemv51kW6UJr3TCKiPY+3GJGH3hoofYFDu4=;
        b=RhFokGjK2j5RbQPHD9NcTCbkQ+lTMfJ+4AIyq/YtM2l/gzcYspCapBPQBc66Ulkt/8
         k1f8BSdZAUPsj/4YHRFyMnZR4PlgnOnWKZ5xxzEkf/ZG9t3pEsJ7jEICidKDF6HEdLNo
         wmqyBrEoW7ixTWTJK19vZBZMwnpfcv8uc3vgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LI2Uo6Tmdemv51kW6UJr3TCKiPY+3GJGH3hoofYFDu4=;
        b=IZBjbbiqMF3E/j3ES27yitO2SbFVTHh9ig8nkhYhgRH9ULtwMRYVx4r04S7+GmfsY5
         55f+OrcbpZypkrqdQ9LQErG8yeczjsqT1F6D/dO1pGzd7xYhb/kzUsrCnpnNpSk0s/1v
         1QqBWuzClVwbaPP1+zcHAjlYxjEzyBlu6w3wImkMB+kYmb1hMalhNnCo92euj9mhecmw
         bdl260PcUMq6JkAh5PcWwsyX9CB+SQlzsyLTumBv8O9lDfzcy8ClLb+pNzkU+blxcELl
         VdvACpOk1eirt4c3reRt0j3Xz80AHn+aD5sAheS+2RaejjefZDg7Gain/mEeefVibP+V
         j2Ag==
X-Gm-Message-State: ACgBeo3dWWkcsCbR/vyiGP2Q5cYvmqaVSlD17dNWhSAwHZGgHQx9jGp9
        4Em+w3iSBcwWAlq3kPaMXRwoL531MoA9FXYmWV6kkg==
X-Google-Smtp-Source: AA6agR51GPEhssBFdsRVzgnkToIjVVOTuCnLHPPRI5Dpj6SiND4rs791ZVKjSyuBj33lZ5DESkoqheBs8/jWd3NucvA=
X-Received: by 2002:a05:6602:2d09:b0:688:f387:aab5 with SMTP id
 c9-20020a0566022d0900b00688f387aab5mr9973334iow.107.1662891669755; Sun, 11
 Sep 2022 03:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net> <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net> <YwpAzTwSRCK5kdLN@rowland.harvard.edu>
 <YwpJ4ZPVbuCnnFKS@boqun-archlinux> <674d0fda790d4650899e2fcf43894053@huawei.com>
 <b7e32a603fdc4883b87c733f5681c6d9@huawei.com> <YxynQmEL6e194Wuw@rowland.harvard.edu>
 <e8b6b7222a894984b4d66cdcc6435efe@huawei.com>
In-Reply-To: <e8b6b7222a894984b4d66cdcc6435efe@huawei.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 11 Sep 2022 06:20:58 -0400
Message-ID: <CAEXW_YQPSi7RyA=Cz5S753uw4SqBp2v+7CqqE3LN9VQ48q40Zg@mail.gmail.com>
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak Memory Models"
To:     Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 10, 2022 at 4:41 PM Hernan Luis Ponce de Leon
<hernanl.leon@huawei.com> wrote:
>
> > You were quoting Jonas here, right?  The email doesn't make this obvious
> > because it doesn't have two levels of "> > " markings.
>
> Yes, I was quoting Jonas.
> It seems my mail client did not format the email correctly and I did not notice.
> Sorry for that.
>
> > In general, _no_ two distinct relations in the LKMM have the same propagation
> > properties.  If wmb always behaved the same way as mb, we wouldn't use two
> > separate words for them.
>
> I understand that relations with different names are intended to be different.
> What I meant was
>         "wmb gives weaker propagation guarantees than mb and because of this, liveness of qspinlock is not guaranteed in LKMM"
>

I wonder if this sort of liveness guarantee (or lack thereof) is
really a problem in practice, where writes will eventually propagate
even though they may not for a bit. Is it possible to write a liveness
test case on any hardware, or is this more in the realms of theory?
Either way, quite intriguing!

Thanks,

 - Joel
