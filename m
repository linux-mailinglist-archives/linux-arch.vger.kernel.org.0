Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786675E5B08
	for <lists+linux-arch@lfdr.de>; Thu, 22 Sep 2022 07:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIVFz6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Sep 2022 01:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIVFzz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Sep 2022 01:55:55 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB94B4402;
        Wed, 21 Sep 2022 22:55:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 51D9C2B05A32;
        Thu, 22 Sep 2022 01:55:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 22 Sep 2022 01:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663826151; x=1663829751; bh=pDihx2esA4
        exqYSoysdIrl0A4cMMAS4Smj5B4iUbcv4=; b=oX0/1s0xiefgX2k+p1TaZvn0hw
        5LY30RKp2V58bczCHgyQZ++gsrtlGO7tPmX5PLbtu4phbxV4NyPIOcd9ACWSCJBk
        QfugJ+iqD8lAxylKO/fZIjSbjSbzzJmLLFGxC6gA30EabLQTMoDRuQDc+qU+PXWA
        cFzgaXngYV8aYjPNAgMiyN33pPBzed2NH/bHZ9jYOYDKJSkbwzTm5fPIqaPNCwkr
        SEPbtgcX5S8b4lcwfdpNYamHoLdSp5KSA6SxwV1Oj2YnwLiduSJDo7cjLSdRnRjU
        ivPivcKmCRUt0UD0jQqK+TNerpqA734ccmKSHULAs3x3w+0hh5SO82KqdeRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663826151; x=1663829751; bh=pDihx2esA4exqYSoysdIrl0A4cMM
        AS4Smj5B4iUbcv4=; b=ZMDGcCJLFdOWJ0KMnqMtWJ0dDzGj/E0qsJvD504rmIEs
        ZPTMX1cQaLMLrtkWk+17iw5F9YJT+luhOJz7ZBQ5EnlnyrC2b+rbD8E3t3lzjgXi
        8+ymWoSEVSfFQz69NwDwrtrT1N9zqjIWNEbKicICC0/RLoO8CHvDSlCJdCmPbxFD
        alA+TmU/5twCLwkQFImEZsp56faXggMx6TutGXMATWOqnywe/CkLA6DZhzT8y8mA
        ac1lRfrBOw0hNNNVlhKNpU6+7ILB+T2HZrc2vync6AXPFFGHJMtMSHEp5xV9VrnC
        FupVOfR7R3rgzmLj37IRbz8RUNhTWO0CCYu7SrFUuQ==
X-ME-Sender: <xms:5vgrYzp8n8zeTxwADLhxEc3u89xjX3Pvbfr1_clCJzWuflCwpp6oOg>
    <xme:5vgrY9oc8oJrRzfCoR1_IK2_jPxbJa2gaUt-KUZ3zlAeIkXTb926kNjalXdwH0yzQ
    ud3CQwvwF88pHwPBdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:5vgrYwN9WuObfeR5JiU-pBldMrXdU2GWSgwwNSe95QO-AAkQ9AO-dQ>
    <xmx:5vgrY25YfzderixcvmtZY8RB0dwA5sHGgTOrqaUukedmHrqof8CRnA>
    <xmx:5vgrYy4_VzAHjNY7vazXdBKYlLUwF7vUs8TfEAZ32CgiZoD8hncIKQ>
    <xmx:5_grY_yNOJtPhBFGu7m9nZ-hHCgQW1jMB6inQsQmLVgLJfXz2GwHblPag1q0IvkS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 807DFB60086; Thu, 22 Sep 2022 01:55:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <5f6e6c39-b846-4392-b468-02202404de28@www.fastmail.com>
In-Reply-To: <CAJF2gTSR9CMxda3Zjz9Ovg5bhXa_Ro622LVT+spHqTTE5zUKDA@mail.gmail.com>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com>
 <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
 <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
 <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com>
 <7a2379cf-c1cf-46af-9172-334d2b9b88d5@www.fastmail.com>
 <CAJF2gTSvaNh_m_hrub5Z=kqLAYJfRbpYzB1Mc5aOgdN+Bm8bag@mail.gmail.com>
 <CAJF2gTQGB97kh=47dsZ8MFpTTpy7pxYyd=MoLOUzgF9kTm1wdA@mail.gmail.com>
 <CAJF2gTSWHMfE-Tyn=cwJLDDsvFKXPyGXgxT9DCUT3Aqf6FTDgA@mail.gmail.com>
 <CAJF2gTSR9CMxda3Zjz9Ovg5bhXa_Ro622LVT+spHqTTE5zUKDA@mail.gmail.com>
Date:   Thu, 22 Sep 2022 07:55:29 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>, lazyparser@gmail.com,
        falcon@tinylab.org, "Huacai Chen" <chenhuacai@kernel.org>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Guo Ren" <guoren@linux.alibaba.com>,
        "Andreas Schwab" <schwab@suse.de>
Subject: Re: [PATCH V4 8/8] riscv: Add config of thread stack size
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 21, 2022, at 12:46 PM, Guo Ren wrote:
> Hi Arnd,
>
> No more coding conventions for the patch, THREAD_ALIGN &
> THREAD_SIZE_ORDER are used by vmlinux.lds.S and common code. So here
> is my considerable version:
>

That's fine with me, it should get the job done.

I still think a way to use 12KB stacks with VMAP_STACK
would be a good addition, but that can come later, and we
may want to do this in an architecture-independent way
when we get there.

    Arnd
