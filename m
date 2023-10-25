Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AB47D74DE
	for <lists+linux-arch@lfdr.de>; Wed, 25 Oct 2023 21:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYTyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Oct 2023 15:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYTyc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2023 15:54:32 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915C893;
        Wed, 25 Oct 2023 12:54:30 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a82c2eb50cso860327b3.2;
        Wed, 25 Oct 2023 12:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698263670; x=1698868470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p6jzHaWTKlGSa7gW0KxMQikIkjGjrHxsb4GjecdcJn0=;
        b=ZahyFL13OVt27cpBrFOFCWM6R+swbSN0MZ0bcTr43eYBc6zIE38AECvW6c4RgMsLjm
         elnWgQ7WaBd/2hT4vC/l1uBBQ1upxqngGzmji0+7iAwj4ei3tQAq+8cqkyLSUU8LpxFA
         wb8B6rq+ctadJGpM6g137qrkChEyt2jj6TTZhnXVZs7aZ5SWzHGJO7ZInWML4xgvH/in
         leDllM9PdHvrfjgeurj9lE67f6SwY5t4kHOyefF3AT2e+tGKPmMkgEvjTd2UeX+7rRBv
         pMznuzabzjaNSKdRH8gfGUzljnNg744ReDoFQQ3ii8WJa+LDsUGD5mILlABpSd3oXaA8
         Oo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263670; x=1698868470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6jzHaWTKlGSa7gW0KxMQikIkjGjrHxsb4GjecdcJn0=;
        b=n+yrr+cy/cRUVbv0zFkKEdzWy9zYcgUa4zbtelKNFYWckLsxQBSL1SxbwUtBUYfUMV
         yYEJBQ16Y0L7N9Ibu08Nt2+fSI8u0Db0AKofoqbES6jhnp+yRRvKjTeqpW3jRV64opHO
         yobqwKbQreWX1/Q7HzWawiv6K5qa6dwcSmD38lTLv/l9Gsu0rAEafF5bvZf0U5UDPvGR
         0+tY3g32400G/poqSAL+BXk/6lYvFhKGhrd3CjZVIwSTufLxBAV62kQYPcfF0+1LPuxy
         W8S4UMH6kq1qEjRnrUJXBzB+PXFxK6vbrFr4tbRoHmpZq3uMNeCeTuHjKDCao2KzPcdS
         kYOw==
X-Gm-Message-State: AOJu0YyUIFMsbnuY9pWSVLen4qPbVcgr4pUgn+UIzsyJ7S2gVu+Q5fjV
        wVE7/AY1+wOiE5AY3yEoEVY=
X-Google-Smtp-Source: AGHT+IE1Qoa4fNnTrlw2zi+7SL0JCE9t3C3ItrrVVXqK/dgYfAvHje3e4eM5qTM2/rpQ9A6/alwxZg==
X-Received: by 2002:a81:ca08:0:b0:5a7:e4d9:f091 with SMTP id p8-20020a81ca08000000b005a7e4d9f091mr13541440ywi.25.1698263669715;
        Wed, 25 Oct 2023 12:54:29 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m124-20020a0de382000000b0059b2be24f88sm5237780ywe.143.2023.10.25.12.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:54:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 20A6027C0060;
        Wed, 25 Oct 2023 15:54:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 25 Oct 2023 15:54:28 -0400
X-ME-Sender: <xms:cnI5ZWZTeke_xoOgsGIkXHFnfFohKjDOcE_V2oT5Th5_P2KTEEnInA>
    <xme:cnI5ZZZCAfQS4C3m50zr8JFHYGqKOhVh2wMrJJlB6isP24MIIkxn4nZDgHTste-O7
    X-r2LqcPAj7hTZzrg>
X-ME-Received: <xmr:cnI5ZQ92BHTnKIGmNHw9h9GC6gYuPrbuI7AnvO0ztLe1Taej2gj8PZ4RTEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefkeeijefhvefhfffgfedtkedtveeulefggfejfefhudehleejieeikedvfefh
    heenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:cnI5ZYoqr4SgwvJ6XLhjqBtp_kKFy4P4xHdcaBd0Di3LnhZF7-6_4Q>
    <xmx:cnI5ZRrdSP7NauFhBhtWmmwz_HkN8nzThC2PXd99wCmFSxwTk9BBtQ>
    <xmx:cnI5ZWQcipx3D9EVRo09vAx8Dqq_7kUfP-mlOfVQNWlsNq4iMvI0EA>
    <xmx:dHI5ZeKTOhdY5FRFZesTApaVS7J9EpJQXBBVCrh-83EATNl-ZotTQA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 15:54:25 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
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
        elver@google.com, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC] rust: types: Add read_once and write_once
Date:   Wed, 25 Oct 2023 12:53:39 -0700
Message-ID: <20231025195339.1431894-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In theory, `read_volatile` and `write_volatile` in Rust can have UB in
case of the data races [1]. However, kernel uses volatiles to implement
READ_ONCE() and WRITE_ONCE(), and expects races on these marked accesses
don't cause UB. And they are proven to have a lot of usages in kernel.

To close this gap, `read_once` and `write_once` are introduced, they
have the same semantics as `READ_ONCE` and `WRITE_ONCE` especially
regarding data races under the assumption that `read_volatile` and
`write_volatile` have the same behavior as a volatile pointer in C from
a compiler point of view.

Longer term solution is to work with Rust language side for a better way
to implement `read_once` and `write_once`. But so far, it should be good
enough.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://doc.rust-lang.org/std/ptr/fn.read_volatile.html#safety [1]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---

Notice I also make the primitives only work on T: Copy, since I don't
think Rust side and C side will use a !Copy type to communicate, but we
can always remove that constrait later.


 rust/kernel/prelude.rs |  2 ++
 rust/kernel/types.rs   | 43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ae21600970b3..351ad182bc63 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -38,3 +38,5 @@
 pub use super::init::{InPlaceInit, Init, PinInit};
 
 pub use super::current;
+
+pub use super::types::{read_once, write_once};
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index d849e1979ac7..b0872f751f97 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -432,3 +432,46 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// (Concurrent) Primitives to interact with C side, which are considered as marked access:
+///
+/// tools/memory-memory/Documentation/access-marking.txt
+
+/// The counter part of C `READ_ONCE()`.
+///
+/// The semantics is exactly the same as `READ_ONCE()`, especially when used for intentional data
+/// races.
+///
+/// # Safety
+///
+/// * `src` must be valid for reads.
+/// * `src` must be properly aligned.
+/// * `src` must point to a properly initialized value of value `T`.
+#[inline(always)]
+pub unsafe fn read_once<T: Copy>(src: *const T) -> T {
+    // SAFETY: the read is valid because of the function's safety requirement, plus the assumption
+    // here is that 1) a volatile pointer dereference in C and 2) a `read_volatile` in Rust have the
+    // same semantics, so this function should have the same behavior as `READ_ONCE()` regarding
+    // data races.
+    unsafe { src.read_volatile() }
+}
+
+/// The counter part of C `WRITE_ONCE()`.
+///
+/// The semantics is exactly the same as `WRITE_ONCE()`, especially when used for intentional data
+/// races.
+///
+/// # Safety
+///
+/// * `dst` must be valid for writes.
+/// * `dst` must be properly aligned.
+#[inline(always)]
+pub unsafe fn write_once<T: Copy>(dst: *mut T, value: T) {
+    // SAFETY: the write is valid because of the function's safety requirement, plus the assumption
+    // here is that 1) a write to a volatile pointer dereference in C and 2) a `write_volatile` in
+    // Rust have the same semantics, so this function should have the same behavior as
+    // `WRITE_ONCE()` regarding data races.
+    unsafe {
+        core::ptr::write_volatile(dst, value);
+    }
+}
-- 
2.41.0

