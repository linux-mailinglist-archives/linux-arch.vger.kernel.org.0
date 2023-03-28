Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1916CCA31
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 20:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjC1Sqf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjC1Sqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 14:46:34 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7142107;
        Tue, 28 Mar 2023 11:46:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 341855C00B9;
        Tue, 28 Mar 2023 14:46:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 28 Mar 2023 14:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680029187; x=1680115587; bh=OR
        P2FIKdfRirdyD2Lu4aWJpigZ2drmLWozeD8QCTfbg=; b=Zmq41Z/qSRMn9rYp+h
        QDNmVcNMoLhclV/Hq1H5ugsx2lOCfEYHLvvTFmQg+RMWJrkym/WeIRc3MLvDHkDO
        HTLlocYp2MP2d8ICO4tnvSs469GkfAH6/BwEDWyKiyXrt/Grg0Q36E3ytLWoMgVY
        kVs6uuC6q4rihRfqOtOtxlAzLj5Do+ABME+dLp8/dowyD7zms93hlezwCC0hO2jO
        gc4Etx3f3cr9lkTjP9KQr25IAKxCDW6mY9imntxbaqqBHgOY+zPHISXPfZNt/fuE
        hdzRkfn+jZ/Tf25ykGdteW4/5VebEAdEgCiW2ZmIVpd9GHM26wsg4EidEvJeT/07
        dtHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680029187; x=1680115587; bh=ORP2FIKdfRird
        yD2Lu4aWJpigZ2drmLWozeD8QCTfbg=; b=tdxBQh+0EYo2NEcZuqxzWQqO0iBup
        z7kKFZO7eLXSnp/penapQpwCORauQUrn1+S28WIKpr9NXH22yUC7X7WM4KoT0sSA
        Utdqa1wIqN3voN9NMdJhx+n1s/L0/t0c2qL7KhFQMUVrtS6IEovWlufwT4grYd2g
        Mpvz5DsY3OOX4Brj/D+dZx/AThVFwhXIAhMoqD/yv/9Sc/Nx7VdtZdWPfPb9NT15
        gTtJyaIh/FC/BxrH9ORyJMvFvYyPUafyy6Rrx2Hlw0Syj2ID5lqcQPJdSSMOhNwy
        OCKv82SpmoGpl8+byqpQUt7DnPctCQ+AwuApPF2SjgNgsRo5HKGVYMvZQ==
X-ME-Sender: <xms:AjYjZKbgzVIbwPrq7_BIJIaFu20D34SyJbGqsiK4XwKns_w6Nqafeg>
    <xme:AjYjZNbme47GuCgltwoyMI2lamCL7qadYs67pfnBxYcEsfn0Y4m6CzxbITNpe_LPe
    j8-T9eqA18pUsnotsk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:AjYjZE_lzVS2e3UQMYqpds57bY5IRM2trHFYYatTNaqTiMtbXjs0Zg>
    <xmx:AjYjZMoIZ0O43yjyTJ-QbGtT2jmdVTsfR9278Yf55J9URtL8rIz6IQ>
    <xmx:AjYjZFr-P8cIFe3xJN12TNHds6E7fgzjA64i5ULxbG61OHNEOdXovw>
    <xmx:AzYjZLblnJuQRIaOyK96rwdmhmhmXmoh6aBI-vdT4fT2hJyOA9OBMA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4754DB60098; Tue, 28 Mar 2023 14:46:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-237-g62623e8e3f-fm-20230327.001-g62623e8e
Mime-Version: 1.0
Message-Id: <b0d8da28-2499-48db-be17-7d126697e303@app.fastmail.com>
In-Reply-To: <20230328164811.2451-2-gregory.price@memverge.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
Date:   Tue, 28 Mar 2023 20:46:06 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Price" <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Oleg Nesterov" <oleg@redhat.com>, avagin@gmail.com,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>, krisman@collabora.com,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jonathan Corbet" <corbet@lwn.net>, shuah <shuah@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, tongtiangen@huawei.com,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of access_ok
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 28, 2023, at 18:48, Gregory Price wrote:
> On arm64, access_ok makes adjustments to pointers based on whether
> memory tagging is enabled for a task (ARM MTE). When leveraging ptrace,
> it's possible for a task to enable/disable various kernel features (such
> as syscall user dispatch) which require user points as arguments.
>
> To enable Task A to set these features via ptrace with Task B's
> pointers, a task variant of access_ok is required for architectures with
> features such as memory tagging.
>
> If the architecture does not implement task_access_ok, the operation
> reduces to access_ok and the task argument is discarded.
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>
