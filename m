Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9A454B271
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiFNNoT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 09:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiFNNoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 09:44:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A42E22296
        for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022 06:44:18 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:44:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655214256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o76Gt/9XAYH6ADRMSregGyzB8cqGaApRoi1RHDVTT4I=;
        b=cxaRVwnooCAsF7PBt63EX6KkbsKYnhxtEgMyGZOl+skUvP0LMI6pWJlXz/9qzQkER+Tj6C
        SpIzpcTH+MhWRdodxZ0nLQ5z8Vuog51yMZbQNCs/cPAmZmThbpnWMqfdJ1s7vc2OqPV/D7
        bCcXd1HSYNVMwotfLZDAd9+RY/Kl2FaUcI/nIDVDrOGzV153X5iucodqH7BLRt6H/lqbkL
        fkWdECPVY2IGCmYHxPxjMDtlMIpexRHvgZXqarL07wJU1Lz2ub/g4Tao1smgOSr77vepPb
        V9+VCRQVPdTsdkLujIRM2jVa+MPV3ngClWh7jEfmoz/nUKStkBvZ7ys1oBayIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655214256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o76Gt/9XAYH6ADRMSregGyzB8cqGaApRoi1RHDVTT4I=;
        b=6dcnNs+/eJ4TSOq9rVizgoIbDGVevnHXLEZq+HcVnK9jUXsNX7jKg/p/3JKCKqTvNhmt5Q
        RvHeiiwFA35TrcDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] generic/softirq: Disable softirq stacks on PREEMPT_RT
Message-ID: <YqiQr5AZlOD0di+h@linutronix.de>
References: <20220613182746.114115-1-bigeasy@linutronix.de>
 <CAK8P3a18cCESYki+4_3UgALRUq1MKmjSZvfXEyKHxgSENYfnXw@mail.gmail.com>
 <Yqg0sNLrtyMvhMNY@linutronix.de>
 <CAK8P3a2KxBgdu66tbc4YEUDsjZrRRs3t78NNPLj3K9XFB+BFAg@mail.gmail.com>
 <YqhnUNzINOkhvfRb@linutronix.de>
 <CAK8P3a0Aqid+YXr_9J=G-uL7qfmk4uc9mzDOdAOK6S2KY4rPOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Aqid+YXr_9J=G-uL7qfmk4uc9mzDOdAOK6S2KY4rPOg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-06-14 15:32:16 [+0200], Arnd Bergmann wrote:
> Yes, I saw these, and that's why I wondered about it, because they looked
> like they should not be applied independently.
> 
> > I could group this softirq change for all architectures in a single
> > patch. But then powerpc didn't want the "PREEMPT_RT" annotation for the
> > warning/ stack backtrace and they may not be too keen about this. So for
> > powerpc I was thinking to present them all at once.
> > Looking at sparc and parisc, there might be more to it than just this.
> > Both were never tested while I have the missing bits for arm* and
> > powerpc in my queue.
> >
> > Eitherway, if you want I can regroup and send you the softirq bits for
> > all arches.
> 
> Yes, I think this would be good. These are still targeted for next, right?

Yup. Let me do this then.

>       Arnd

Sebastian
