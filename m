Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A47D81A7
	for <lists+linux-arch@lfdr.de>; Thu, 26 Oct 2023 13:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbjJZLRI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Oct 2023 07:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjJZLRH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2023 07:17:07 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187D1AD
        for <linux-arch@vger.kernel.org>; Thu, 26 Oct 2023 04:17:04 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b636ee2b38so495178241.0
        for <linux-arch@vger.kernel.org>; Thu, 26 Oct 2023 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698319023; x=1698923823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ADQcQPFXDFUAE1kDLSEymM4GykgZRpKmE6Mqe8TDGH4=;
        b=hLgA+35TwPIRTqpwo25BV1IqB+22lDsO+ZzJFFejglYNU/9CBRxzasxR079HuJaP2f
         Fi5D4lWHOm0QRKswoeNH/oI5IGtlaIB5zPrZ+BzqgDVRdZWp4QTDZ9C9NcFp0bd3YHhi
         Fpvi/P1favuSuzE3GgqZSo0CrStCLNAdKijyAcDlXWWXtb2cd0I46eEkZ1072haxM8BG
         IR00FZVGSJHkd7tBApkrlOHcrXgkT3bDe8mz64MTuvnd5lfBBTz51/6wwZ3mxIwJ3m1G
         H9yUD698Em0cNN/z11Dtdbo483KqIquOuP3cffQ8KHFB3AzfC0gyGQrTdtbP65Qsh1/G
         IZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698319023; x=1698923823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADQcQPFXDFUAE1kDLSEymM4GykgZRpKmE6Mqe8TDGH4=;
        b=K0mmgFFTw/bptzBIU97UmvGlcZRblOiwrl103dObwjcDG3LT0/3RT8Wg6O+nsc3CX2
         6iCPVA3EplRAsBNmViNW9flVe/Nu3UTzuXdYCuCv3pPTEPktM1llt9kzbKXSJzou1e8U
         VflBQQcX+NyjXrK5yeyx4iMWTZQOhggXMaEBGw4VwCRfzquwhasAm8uWApDXje1RO4/f
         XZ4xFv3LkF2Zz8tATYKiuUiLzGST8LoKog9Do15SWEObeqYLRcKPq2MPOGV18qzvR87q
         xGn/sCXxXTU4UjLLKrhkT9lgiCOnEhjgwvKTVGD+H8KPm0/ZUhwlK6F60Xvur9YdMCe5
         Ghwg==
X-Gm-Message-State: AOJu0Yx9MiklXzr44UiVtt1oPJmCf2Luetsx37f/S0zcIit4bHLFuURg
        8kYsBaHzbXyTTO8StjaM32dXnlNI1CnZ7QrqwV9TSw==
X-Google-Smtp-Source: AGHT+IFL1Bi1n9i8tyu/TR0kE59uAhq0MbAYLquMr3viL391nUxuNb4eUNFXaqX2lALhkyqgTfVTxU9ppHTJB0CpVFA=
X-Received: by 2002:a67:e086:0:b0:450:cebb:4f15 with SMTP id
 f6-20020a67e086000000b00450cebb4f15mr1164753vsl.1.1698319023532; Thu, 26 Oct
 2023 04:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
In-Reply-To: <20231025195339.1431894-1-boqun.feng@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 26 Oct 2023 13:16:25 +0200
Message-ID: <CANpmjNN6PN7tNLuUKZXcTe5n=HOv9Po0er0cDhvP9x=uA7rTTw@mail.gmail.com>
Subject: Re: [RFC] rust: types: Add read_once and write_once
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        kent.overstreet@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 25 Oct 2023 at 21:54, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> In theory, `read_volatile` and `write_volatile` in Rust can have UB in
> case of the data races [1]. However, kernel uses volatiles to implement
> READ_ONCE() and WRITE_ONCE(), and expects races on these marked accesses
> don't cause UB. And they are proven to have a lot of usages in kernel.
>
> To close this gap, `read_once` and `write_once` are introduced, they
> have the same semantics as `READ_ONCE` and `WRITE_ONCE` especially
> regarding data races under the assumption that `read_volatile` and
> `write_volatile` have the same behavior as a volatile pointer in C from
> a compiler point of view.
>
> Longer term solution is to work with Rust language side for a better way
> to implement `read_once` and `write_once`. But so far, it should be good
> enough.

One thing you may also want to address is the ability to switch
between READ_ONCE implementations depending on config. For one, arm64
with LTO will promote READ_ONCE() to acquires.
