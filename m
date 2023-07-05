Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17E1747DD5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGEHF4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 03:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGEHFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 03:05:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03EE1713;
        Wed,  5 Jul 2023 00:05:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-991fe70f21bso736500266b.3;
        Wed, 05 Jul 2023 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688540739; x=1691132739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L/7+ADavvvyF4LSZY4sdmtXzOtp56QtTGpuC9sfCc0=;
        b=W9eUSQyjAn9DCw4gpTJPLbmOfWIgG2dYvKsbwEzyNUWP0Tgqv8B1bmaXn3kLsrNXpu
         dCmzIoVb63rzhJzvH/sEyVtExRL1BhZeuP/9kXyASV3t8wXjUmribViAj5C7qh8t0kdK
         HqtE9CU0YEVO45PMz+dFgTvWBsMb9FLFPSpS1noxCdvAphaDkzhc0PswbgO4vEaf30BR
         K73VuYXvVXdRfstJMkGf7krhiltuEIz59AUCkeSUiClQUjfM7jDge6venjBgRdnKbT5e
         d7UjHIEFQQP0Jjcl6QeASBG+ARjqrFuuvibml14PMEFlHlGieBou+G28CUD74W/pdCQ9
         7i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688540739; x=1691132739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1L/7+ADavvvyF4LSZY4sdmtXzOtp56QtTGpuC9sfCc0=;
        b=UXO7j90EyA11BUttYtYtVYm/hGuvAZQq+2ySMA4tUvICO2tXxqKkqFWMi6cEjpH5oO
         13SFaL8dqjO2HcvXArqYToOO7xM4ckFkG7kqJUV6NKXOuUZYievfHq2+NxnQIltGbRhy
         z/NOZZFI/GVcqnKjw3w2/aKWn41iPMWXawESuQQvmCRJR0u3WzTo3M9if/9SaLLyhplg
         zne7cG9YogNLrIc+wfs2uh7+G0x6Y7XQdgmz71VHPaUpEpGSYicElSI6H1dogzra+qXC
         nTMBNHpGf07EXb+jmrG+lwkOb7I7Cnh9/+qMR7Ts+U7YqOADnzD1Qg9t16RfpNg2NIbL
         XnIA==
X-Gm-Message-State: ABy/qLY7Ab0mKBlQun5lccbLCfmjaYGQcJCEllJdOvx+cqqO0lV4m2Pb
        fIcsI1bHSy03TpFeUP8WAiE=
X-Google-Smtp-Source: ACHHUZ7yB1Zgz07L0TLTmfykw8a4sOEU/eFIHP3KCrX24n7QCIw/xY1kFeAt2XCSB3uiXewn2MvVhQ==
X-Received: by 2002:a17:906:86d1:b0:988:a0d6:c4fa with SMTP id j17-20020a17090686d100b00988a0d6c4famr11346376ejy.13.1688540738741;
        Wed, 05 Jul 2023 00:05:38 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id e8-20020a1709062c0800b0098822e05539sm14096295ejh.191.2023.07.05.00.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 00:05:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5FF2F27C005B;
        Wed,  5 Jul 2023 03:05:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jul 2023 03:05:35 -0400
X-ME-Sender: <xms:PhalZGwSNPEWjYKdw3j73VG_Z7rtNfrVTdxskgEabR5RZeWN2JzGtg>
    <xme:PhalZCT8PmdHp0y3dG5kKRt1K_5NJUX3KI-O615B_cLWqGXOXnSnFek4tMZMy7mYs
    0CXwhq6fgX0X9ni0g>
X-ME-Received: <xmr:PhalZIUL6izZwEO588ngyzwzYFTkgM71-LX_7BiAxy1ON5aCDQPfF6SmRvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefgieegkeelgfekheetudeiiedvlefghfeffefffefgudejvefgtdfhhfet
    hfegjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:PhalZMjRf585G6SVXbyHab2SiQ0sFyuZsNLVumJX76z9t9wYsjpgGw>
    <xmx:PhalZIDGidCSObwJW-lp844Rqy6xbxMPj-Z3aL0MDwyajJg6xe9Ggw>
    <xmx:PhalZNIg5xFXW-sbd7OnX5yr3sQCWSAjIQnuZbvwv7_fHLvib7YTng>
    <xmx:PxalZA724Fv94sSi9Uhn021_3_OlzOdsRySMfA9xVQrdThklU4lkIw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 03:05:33 -0400 (EDT)
Date:   Wed, 5 Jul 2023 00:05:32 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Olivier Dion <odion@efficios.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rnk@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm@lists.linux.dev
Subject: Re: [RFC] Bridging the gap between the Linux Kernel Memory
 Consistency Model (LKMM) and C11/C++11 atomics
Message-ID: <ZKUWPKWAnjZvqsgL@Boquns-Mac-mini.local>
References: <87ttukdcow.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttukdcow.fsf@laura>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
[...]
> NOTE: On x86-64, we found at least one corner case [7] with Clang where
> a RELEASE exchange is optimized to a RELEASE store, when the returned
> value of the exchange is unused, breaking the above expectations.
> Although this type of optimization respect the standard "as-if"
> statement, we question its pertinence since a user should simply do a
> RELEASE store instead of an exchange in that case.  With the
> introduction of these new primitives, these type of optimizations should
> be revisited.
> 

FWIW, this is actually a LLVM bug:

	https://github.com/llvm/llvm-project/issues/60418

Regards,
Boqun
