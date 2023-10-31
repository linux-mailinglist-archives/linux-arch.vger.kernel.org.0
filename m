Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCD7DD09E
	for <lists+linux-arch@lfdr.de>; Tue, 31 Oct 2023 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbjJaPee (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 11:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345058AbjJaPee (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 11:34:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FF0115;
        Tue, 31 Oct 2023 08:34:30 -0700 (PDT)
Date:   Tue, 31 Oct 2023 16:34:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698766468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJDz1UY+faR8aNgW5FPh3ep7TyJU8rHswb3s8K85yec=;
        b=cBwLmZ7lA/S63vM3k8+zJ5pET19wh+Bl+iwgV8tZ2+sBuh+fwsCy+u59WJQ+cTe+Oo1JP0
        QiPUBYhXSqU9MVSvzgM+gdL2qKj3heGdBwQPHbeRaG0sMHJ0mcxsUjycCcFP2T0zG1wGXH
        jB1tlC7OpiBRBLXagXIjhng4C6CdGAt0u8s6HBFfBUsO5F/xbH1HJWN+ktRD1dtw1OULDf
        4OxsLcJHXwtMRBH1LP5WdI/qzuf5obPtO4q/mK39zrMAXm0MU/o2WklKV+7oyraKPYZxQW
        +zbH+XrWhhSuNz/NymmQp/eBlyHFT3sD7enivufOJ3eAv8Q1XhuyVx1/XdUzDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698766468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJDz1UY+faR8aNgW5FPh3ep7TyJU8rHswb3s8K85yec=;
        b=uH+4gOFp27CsyIhM7FJh9npqVvAytZ0l/Vt+qstOBB2Vbc7R61mi26JzygpU1IBPbAuzmV
        fe1NqXJyVYMyssBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "minda.chen@starfivetech.com" <minda.chen@starfivetech.com>
Subject: Re: [PATCH RT 0/3] riscv: add PREEMPT_RT support
Message-ID: <20231031153427.goCGGJRm@linutronix.de>
References: <20230510162406.1955-1-jszhang@kernel.org>
 <a37fc706-78cd-4721-9af3-aabb610f49b1@siemens.com>
 <ZTah9NOMbZkf6dfL@xhacker>
 <20231024061852.7BzoCFwW@linutronix.de>
 <ZUESqBTSS/s47qM/@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUESqBTSS/s47qM/@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-10-31 22:43:52 [+0800], Jisheng Zhang wrote:
> Hi Sebastian,
Hi Jisheng,

> Thank you so much for pointing out PREEMPT_AUTO, I read the discussions
> last weekend, glad to know PREEMPT_AUTO. And riscv has switched to
> generic entry, so it's easy to support PREEMPT_AUTO for riscv. V2 was
> sent out a few mintues ago. Could you please review?

Sure. I have no idea what the upstream status about PREEMPT_AUTO but I
think we want this.

> > Are there any reports of this booting without warnings with LOCKDEP and
> > CONFIG_DEBUG_ATOMIC_SLEEP enabled? I remember there was something
> > earlier.
> 
> IIRC, Conor reported the warning and stack trace is ext4 related. But
> I didn't reproduce the warning. And Schaffner also tried the series
> but it seems he didn't see the warning either. So I'm asking for Conor's
> help to retry v2.

oki.

> Thanks

Sebastian
