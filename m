Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9A7DCFC4
	for <lists+linux-arch@lfdr.de>; Tue, 31 Oct 2023 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjJaO4M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjJaO4L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 10:56:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5529EA;
        Tue, 31 Oct 2023 07:56:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBB3C433C8;
        Tue, 31 Oct 2023 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698764168;
        bh=O+lk/MXMtV5u3UvRYzKW2LTcMBsvBkcGlPzOqhO3RYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=folYaGn1VPqbgvmsSCJ/z0B5fzNxc/RZtLJVgs0p6qLsQ5xp9n5bsqegbXwNvg9fW
         Q064aRd5fPOcOx6zWjMW8zjB0s7mCP4U+aC3qSTTptqGt6pR1TQEusQumAfvzaQreg
         PgoLP5jFoqJqPDHFoHTNaKMIKjc/k8dUeQvArt2dVNz13/vrHWXK+v/jOgFzX208RQ
         H9ZbZPLkSK4A8WiDl72tCGL+n1X5+/kZO1OsNV3+Ou5w/5Z8IUoJKAWMyZp+BDH+Ls
         qic8sk0OYVsyf4YDhLWXK5Jh4qTTLor36JEMxMcBq0bJQS3RCItt77UXJoNhPmMTZp
         rbxsqT2t81tTA==
Date:   Tue, 31 Oct 2023 22:43:52 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <ZUESqBTSS/s47qM/@xhacker>
References: <20230510162406.1955-1-jszhang@kernel.org>
 <a37fc706-78cd-4721-9af3-aabb610f49b1@siemens.com>
 <ZTah9NOMbZkf6dfL@xhacker>
 <20231024061852.7BzoCFwW@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024061852.7BzoCFwW@linutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 24, 2023 at 08:18:52AM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-10-24 00:40:20 [+0800], Jisheng Zhang wrote:
> > Hi Thomas, Sebastian
> > 
> > could you please review? Any comments are appreciated. or do you want a
> > rebase on linux-6.5.y-rt?
> 
> Please resend on top of latest v6.6-RT. Lazy preempt is gone so only
> PREEMPT_RT config switch remains from your three patch series. If you
> have generic-entry then you could use the new PREEMPT_AUTO.

Hi Sebastian,

Thank you so much for pointing out PREEMPT_AUTO, I read the discussions
last weekend, glad to know PREEMPT_AUTO. And riscv has switched to
generic entry, so it's easy to support PREEMPT_AUTO for riscv. V2 was
sent out a few mintues ago. Could you please review?

> 
> Are there any reports of this booting without warnings with LOCKDEP and
> CONFIG_DEBUG_ATOMIC_SLEEP enabled? I remember there was something
> earlier.

IIRC, Conor reported the warning and stack trace is ext4 related. But
I didn't reproduce the warning. And Schaffner also tried the series
but it seems he didn't see the warning either. So I'm asking for Conor's
help to retry v2.

Thanks
> 
> > Thanks
> 
> Sebastian
