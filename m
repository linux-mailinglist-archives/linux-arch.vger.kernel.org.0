Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FFD54AA1F
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 09:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353334AbiFNHLu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 03:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353327AbiFNHLt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 03:11:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874273B54A
        for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022 00:11:48 -0700 (PDT)
Date:   Tue, 14 Jun 2022 09:11:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655190706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5a2IyAEyfYQKh+zlE/zrlNycCeJ8BhQSCraR18Fr9Q=;
        b=U9FI09k6gN6yZh7IBvCxRE2zJ/Y/VkTjvUOeWUrTlPctzy2kwqAKdcCyXWTZk0kI50kuVf
        gAP5louT7kw4zf4Cmtnk9rmmUh8h0DjmK2QuJk4Ohy1ssztyDE/aq9hARPXAPwd3xRqUpW
        gsfT3LB9XP86WfhS3yrTNIbWcXmIe0d0/SSk/Ggfv1GbPKZywbvZxPNa0l961BbgsuccPy
        w/BpKCksVDLmeaSskSALNmUefbuG/n9BY9uzd2d7snC8+4rhdIi9JxVHKpSR0ivWqqEmRR
        llMLYfZq4sMek9yZPyoO8B0XJVYEUX/hbhzqdWYjMcWt+OjUlu9Iz8++QkLwQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655190706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5a2IyAEyfYQKh+zlE/zrlNycCeJ8BhQSCraR18Fr9Q=;
        b=Bj+usAHq0y1JZa9cTKoc9wKRYgchaKp/OT8Jx3o1BzeiCbaTYbgGjK/3soCq11qqeM9m62
        C43v/DQi19V4TkDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] generic/softirq: Disable softirq stacks on PREEMPT_RT
Message-ID: <Yqg0sNLrtyMvhMNY@linutronix.de>
References: <20220613182746.114115-1-bigeasy@linutronix.de>
 <CAK8P3a18cCESYki+4_3UgALRUq1MKmjSZvfXEyKHxgSENYfnXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a18cCESYki+4_3UgALRUq1MKmjSZvfXEyKHxgSENYfnXw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-06-13 23:13:49 [+0200], Arnd Bergmann wrote:
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> It's probably best to keep this together with the corresponding architecture
> specific changes. I was a bit worried about bisection at first, but
> then realized
> that this is not a problem for mainline since ARCH_SUPPORTS_RT is not
> yet enabled on any architecture.

So where do I put this patch to? If I remember correctly then arm64 is
using this. ARM has its own thing and x86 has this change already.

> How are softirqs called on preempt_rt? Does this result in higher stack usage
> for the normal task stacks again, or are they run in separate threads anyway?

one of:
- ksoftirqd thread.
- in the force-threaded interrupt after the main handler.
- any time after bh-counter hits zero due local_bh_enable().

The last one will cause higher task stacks.

>           Arnd

Sebastian
