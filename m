Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C9766FDB
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbjG1Ovk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbjG1Ovj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 10:51:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932AD12D;
        Fri, 28 Jul 2023 07:51:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690555896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WgtQnEvcjnIA6OssBWgWKQGQOlpPGr/TktCgM5MH5Qk=;
        b=SBoI1IVxgnSSvXQ53cwYA0wdV8l1C4rCtG7kkuwOvN6012sDhiLL9KCMJBi5HjGQOSF+4H
        4pejiklppMcfhRh9HnciknpMEPPfqnFG05C0APcyVpXHpb2QRymBZwt01P2uUR+UeHLe9u
        ugyKnml+vlZYRWbrOW2CZUdApiF+swXL9wq5BKGF5sE6B9AImZ8PyBcwnImSCFh55F8Vmi
        +xZAPlVpjcsxHiAmmDwQvRWPK8+L5JcFftr+4QojEv7PR8rffM6LJlcM/5s2yEezxgePff
        C7yLcajuIjVqmvBxnWDanSkGbz9jPsGVYO3wdjiLW0/3riMseGclzQJ6+rf6oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690555896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WgtQnEvcjnIA6OssBWgWKQGQOlpPGr/TktCgM5MH5Qk=;
        b=u14Jh2+qN17+TLZ3MIa91VdBRZUZrJLtBzQEvavFoM4fEhUDc/1OAgVhNqxa11WRLuDlSR
        +RGQ3niR5V8SrBCA==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>
Cc:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
In-Reply-To: <beaab9ae25de92bace2f2e30dff5e0d2e7774e56.camel@intel.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
 <c66e3e800a7d257ef7a90749fe567f056f4c3ace.camel@intel.com>
 <87wmykqyam.ffs@tglx>
 <beaab9ae25de92bace2f2e30dff5e0d2e7774e56.camel@intel.com>
Date:   Fri, 28 Jul 2023 16:51:36 +0200
Message-ID: <87edksqebr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 28 2023 at 14:23, Rui Zhang wrote:
> On Fri, 2023-07-28 at 09:40 +0200, Thomas Gleixner wrote:
>> On Sun, Jul 09 2023 at 15:25, Rui Zhang wrote:
>> > I ran into a boot hang regression with latest upstream code, and it
>> > took me a while to bisect the offending commit and workaround it.
>> 
>> Where is the bug report and the analysis? And what's the workaround?
>
> As it is an iwlwifi regression, I didn't paste the link here.
>
> The regression was reported at
> https://lore.kernel.org/all/b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com/
>
> And it was fixed later by below commit in 6.5-rc2.

Ah, ok. I was worried that you ran into issues with the parallel bootup
muck.
