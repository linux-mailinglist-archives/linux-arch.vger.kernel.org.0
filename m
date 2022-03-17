Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99FD4DCA14
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 16:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiCQPgI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiCQPgH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 11:36:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C9B181B16;
        Thu, 17 Mar 2022 08:34:51 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v13so4634470qkv.3;
        Thu, 17 Mar 2022 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qtliUzkRIUdjqjO0W+fikeYFFq5bQx8hw1n4Uq6lPAg=;
        b=qZRRueAnOHjaHMRHQ+QIIoDnWulYAUxCMJ1f9PLJOiXq+diWU/Nsh3HRXjKTOHUm89
         FdVU4EnrCVLmv+jdu1vwRuH5xMQyCKdw/F0Qk4dOA5DQSO/zfZ7fqVB+ZiP20rwRTgL2
         Tx1no5rGcZqDfFMOdohpUGHQxgvf4P+eQQVo07wTPTbk6zai1gX84K5lqBJB+7ICayuN
         be5wo9BbPg8ZE/axbhzenv08W3Rzfbbd1dZ3GoXVU9f0y3NwzmnLpdrAkYx8ephYpXeP
         05w3fv1bqTdhGsZYxLe1PqWeeUS7hccm0sxAy0O9cbJcJBo1HrIV21wQxYRxMJDyHngu
         3Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qtliUzkRIUdjqjO0W+fikeYFFq5bQx8hw1n4Uq6lPAg=;
        b=l3XuVBAh4RRf3my01j+MSKE4Z4TC1cJAqHHWv7Xh1h8dvzYS4QS8inpZBJPvCiIxKs
         7j0hI3+thsiRJA5xvLa0MY6hGZE0VCETJBOGGDTKP+5HxUZ4qNn7KidfVAgWrt78NuJX
         cXehDYan25/d0TtU7wDlPMOjOQj8sDEKV78907ZvL8POn0bWZF+PvnKQqwCChhloeBRh
         wheOp022etoSmv6rmGZAlOu2wTYWqjRFH/Hel5Mh6V1sTrAPLnqCkCOH93TrHgtGrWD0
         1hFTeDtw64Qvzd41sCHIU0KfckhgWr4yLW98wm0oiDhDmRGgmi2O/bUW7f5wwAqsaEMi
         XXVg==
X-Gm-Message-State: AOAM533Um69EjMOMtuTABA1XnLwC0zvbeje0XP9rXEXqc4+QJWgFrcuv
        Akxq94qHBgaKUKiTtuSaZHg=
X-Google-Smtp-Source: ABdhPJx8dXv4UXQyiWK4n7wEDfULbNQbnJsKlVOxYDBmUuKOSaCsRNCIvmR7bFavxrrEy4dWi4VA8A==
X-Received: by 2002:a05:620a:28c4:b0:67d:c400:a9d7 with SMTP id l4-20020a05620a28c400b0067dc400a9d7mr3231420qkp.369.1647531290494;
        Thu, 17 Mar 2022 08:34:50 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k1-20020ac85fc1000000b002e1c6420790sm3840883qta.40.2022.03.17.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:34:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C3AFC27C0054;
        Thu, 17 Mar 2022 11:34:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 17 Mar 2022 11:34:48 -0400
X-ME-Sender: <xms:FFUzYvYeHB8UgJLpkpjGoO87Dhu0M5cz9KeoEWrnjVktCEfb1vUgmw>
    <xme:FFUzYuZOiKnmJ9UPGFPz4T8kLq-7OgnWaYZQ3_YQiP4jKERtQl_YhT2meotSV3qM3
    n-PA6boLk5hbLP7wQ>
X-ME-Received: <xmr:FFUzYh-UVM2fTmsTdkWHiKYdFTe43WEYk361olaw-wwkAqtLNKQRGT7kKQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FFUzYlpXjh1DBe_h89xavc8SP5ArO-AFfAUabR_Rm9M1SOFWb5QB5Q>
    <xmx:FFUzYqrRUUeB5Tk3Yl3nSEtpNiuzFix1x61nNAGT5NoGdrxgBJYFvw>
    <xmx:FFUzYrSd0xVQNCjGqzNwy83mxeIizp-GUgA4qMhUkwGPis5Jmoo2Hw>
    <xmx:FVUzYt80E1fXaJ1tXGQtXLBz1Dc4KYT1JWMoG6alobFQJ9QsAHALhS8RthE>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 11:34:44 -0400 (EDT)
Date:   Thu, 17 Mar 2022 23:34:18 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, peterz@infradead.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, mingo@redhat.com, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/5] asm-generic: ticket-lock: New generic ticket-based
 spinlock
Message-ID: <YjNU+tj5YJrYtwtK@boqun-archlinux>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-3-palmer@rivosinc.com>
 <YjM+P32I4fENIqGV@boqun-archlinux>
 <364c72a9-64ca-592a-510b-d48a963121aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364c72a9-64ca-592a-510b-d48a963121aa@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 17, 2022 at 11:03:40AM -0400, Waiman Long wrote:
[...]
> > > + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
> > > + * sub-word of the value. This is generally true for anything LL/SC although
> > > + * you'd be hard pressed to find anything useful in architecture specifications
> > > + * about this. If your architecture cannot do this you might be better off with
> > > + * a test-and-set.
> > > + *
> > > + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> > > + * uses atomic_fetch_add() which is SC to create an RCsc lock.
> > > + *
> > Probably it's better to use "fully-ordered" instead of "SC", because our
> > atomic documents never use "SC" or "Sequential Consisteny" to describe
> > the semantics, further I'm not sure our "fully-ordered" is equivalent to
> > SC, better not cause misunderstanding in the future here.
> 
> The terms RCpc, RCsc comes from academia. I believe we can keep this but add

I'm not saying we cannot keep "RCpc" and "RCsc", and we actually use
them to describe the memory ordering attributes of our lock or atomic
primitives. These terms are well defined.

The thing is that instead of "SC" we use "fully-ordered" to describe the
memory ordering semantics of atomics like cmpxchg(), and IIUC the
definition of "SC" isn't equivalent to "fully-ordered", in other words,
there is no "SC" atomic in Linux kernel right now. So using "SC" here
is not quite right. Just say "...which is fully-ordered to create an
RCsc lock."

But yes, maybe I'm wrong, and "SC" can be used exchangably with
"fully-ordered", but at least some reasoning is needed.

Regards,
Boqun

> more comment to elaborate what they are and what do they mean for the
> average kernel engineer.
> 
> Cheers,
> Longman
> 
