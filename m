Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C995E7D4743
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 08:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjJXGTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 02:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjJXGS7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 02:18:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE6BF9;
        Mon, 23 Oct 2023 23:18:57 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:18:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698128335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFscsjM+T6PwALwjNYUJz2BmZ8r/+Bj29Kd1auX4SPI=;
        b=BofWcEkm9n8F6KpQ6sAdF6/ozNjQXcIY6g7k8pOO1SmfCTbgaD+RQTm9RqAzCWUBbQuGV0
        un7vG2L0wYx237lB5f50LOol2XJGvmn0W3NpOQX00ayhQ4RslTJ4/9MtCvCEqF4upm+oh8
        EAF8B2vLHl6ukQcKc29Bux68SLbCPD5KDTM0Mm7F1yHPJyPu+1tDsrL6oys2qHY0/+jgqU
        HnFvB3W6znOKS6v6B2rT54+RkywOSAjyBW8BKE/ZVCa+GX/eOMOW5uDMjagGowbwZQf1Qa
        p9/SvlC+0Yi0A/roVjEEFhZRTrxL+EIJPBccM8cgxVhrBQ6fnJNlSw6ImMZebA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698128335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFscsjM+T6PwALwjNYUJz2BmZ8r/+Bj29Kd1auX4SPI=;
        b=/UoBr0b/57j7ff8wRdeBxkYeDv6oK9DKML3dMC7/hTKKEGwmFS0zuJEAMwtSWbVTaEQNh8
        1DV7irNanUNEV7DA==
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
Message-ID: <20231024061852.7BzoCFwW@linutronix.de>
References: <20230510162406.1955-1-jszhang@kernel.org>
 <a37fc706-78cd-4721-9af3-aabb610f49b1@siemens.com>
 <ZTah9NOMbZkf6dfL@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTah9NOMbZkf6dfL@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-10-24 00:40:20 [+0800], Jisheng Zhang wrote:
> Hi Thomas, Sebastian
> 
> could you please review? Any comments are appreciated. or do you want a
> rebase on linux-6.5.y-rt?

Please resend on top of latest v6.6-RT. Lazy preempt is gone so only
PREEMPT_RT config switch remains from your three patch series. If you
have generic-entry then you could use the new PREEMPT_AUTO.

Are there any reports of this booting without warnings with LOCKDEP and
CONFIG_DEBUG_ATOMIC_SLEEP enabled? I remember there was something
earlier.

> Thanks

Sebastian
