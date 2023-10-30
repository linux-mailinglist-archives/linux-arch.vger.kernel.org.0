Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474BB7DBB32
	for <lists+linux-arch@lfdr.de>; Mon, 30 Oct 2023 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjJ3N65 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Oct 2023 09:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjJ3N65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Oct 2023 09:58:57 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB438CC
        for <linux-arch@vger.kernel.org>; Mon, 30 Oct 2023 06:58:53 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-5402e97fdd1so3320810a12.0
        for <linux-arch@vger.kernel.org>; Mon, 30 Oct 2023 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698674332; x=1699279132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwv0nNI/GXb5sK6crMnTZzX7DXnGnuo4VkjJxSyGGBE=;
        b=Pw/SRXYoxDLks3cmJ83KKdDUaLJOw/++8rzzczrv5QNwLvEh6F/aVJ4p8Vm04Tu5ST
         uxoT1x1n7FxzK7ZAn2srR/K/yTwAfdbIeAYEuxwpyr3Iz/H/slZDCFi2x3TM/QbHZTXy
         0fgOZvmzkr2c96W96XsJemLGGtK9rGVnG832Z7lJDXfDsrFvh/JIq2H20S+6La/asCPF
         XE1qRMs36ns1Vpzu/g4yS1N+6xp03dknrCTZrLJeVBh3YUu4oo2IPGZHOgxkPVauPDlI
         2wf2LzII9tsSqUiPPYy0trkBFEKk5NJ82FQCOhJbHqfx+Ys3qx8Y2dDSdi/Rg4roxr3W
         FkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674332; x=1699279132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwv0nNI/GXb5sK6crMnTZzX7DXnGnuo4VkjJxSyGGBE=;
        b=kvgAeiC3AbTkP7suOUoQTqUTdWGlvKXaNhsovE5mATgmqr2N7wSz7oTMx3PExDU7SC
         3092lhiHnvcGD1SG75AFmpXjLYmqO/r9BrUI56XdsbV/rKIGCfKsTt2TqIZ74DspO628
         SpZLxepmK5sgJUePCrchcZ1QWVgerMw7A/YEvfMQvlVODgp+UzT0HMX1QO8dHXTtEVJI
         1iIJj4/SMULj1zcRVkW/qNC5yDKeXiz8bFz7zF4H1K85ShY9dK9A/xxH52FI1aenRvYr
         an03lXlHS/Gz7rmo5P0J4X+9T4nGV8t8v5i7ncGUWeKFP8NvfZXW62LE+9HsoBWblVGB
         gDJg==
X-Gm-Message-State: AOJu0YymugpTK05cO9IvY8LFVWLy/z5KfI1k6yyUriHqy9bK94Pk5cZN
        62acKLfuk6+kMsGwHas889bmze3UL/Yj/MM=
X-Google-Smtp-Source: AGHT+IGNKlEATVPDh6rVqDOpRvWhA0c/AXkrrys3npUtceRNXpU/wxHpIZOuNkZ6upnlTs5QHBR1A23TFUXF5l4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6402:f19:b0:53e:b944:d5ca with SMTP
 id i25-20020a0564020f1900b0053eb944d5camr92691eda.0.1698674332155; Mon, 30
 Oct 2023 06:58:52 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:58:49 +0000
In-Reply-To: <ZTmelWlSncdtExXp@boqun-archlinux>
Mime-Version: 1.0
References: <ZTmelWlSncdtExXp@boqun-archlinux>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030135849.1587717-1-aliceryhl@google.com>
Subject: Re: [RFC] rust: types: Add read_once and write_once
From:   Alice Ryhl <aliceryhl@google.com>
To:     boqun.feng@gmail.com
Cc:     a.hindborg@samsung.com, akiyks@gmail.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, brauner@kernel.org, david@fromorbit.com,
        dhowells@redhat.com, dlustig@nvidia.com, elver@google.com,
        gary@garyguo.net, gregkh@linuxfoundation.org, j.alglave@ucl.ac.uk,
        joel@joelfernandes.org, kent.overstreet@gmail.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        luc.maranget@inria.fr, nathan@kernel.org, ndesaulniers@google.com,
        npiggin@gmail.com, ojeda@kernel.org, parri.andrea@gmail.com,
        paulmck@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, stern@rowland.harvard.edu,
        trix@redhat.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com,
        will@kernel.org, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:
>> On Wed, Oct 25, 2023 at 09:51:28PM +0000, Benno Lossin wrote:
>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>> index d849e1979ac7..b0872f751f97 100644
>>> --- a/rust/kernel/types.rs
>>> +++ b/rust/kernel/types.rs
>> 
>> I don't think this should go into `types.rs`. But I do not have a good
>> name for the new module.
> 
> kernel::sync?

I think `kernel::sync` is a reasonable choice, but here's another
possibility: Put them in the `bindings` crate.

Why? Well, they are a utility that intends to replicate the C
`READ_ONCE` and `WRITE_ONCE` macros. All of our other methods that do
the same thing for C functions are functions in the bindings crate.

Similarly, if we ever decide to reimplement a C function in Rust for
performance/inlining reasons, then I also think that it is reasonable to
put that Rust-reimplementation in the bindings crate. This approach also
makes it easy to transparently handle cases where we only reimplement a
function in Rust under some configurations.

Alice
