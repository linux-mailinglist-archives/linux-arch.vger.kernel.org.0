Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8856C686B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 13:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjCWMeH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 08:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjCWMeG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 08:34:06 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B33196AD;
        Thu, 23 Mar 2023 05:34:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DE791420CF;
        Thu, 23 Mar 2023 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1679574842;
        bh=dU+ouRLpZkJDik6nlmkKXlAzXALaF6/l7WtvgLXO5Rg=;
        h=From:Date:Subject:To:Cc;
        b=KCmfvMiMVpberx82OFDcDMPsbno/GMxpzLzAunpRDDyccD9oRx9YXrVvq0B6ja2+2
         6uAd6QuJb1ZCVPPwdf/RGoVp75+S3HGkXKUDFCr+VVhcDzC/Jgj9OS0RHq8mTW5Lpy
         oveYqQCEB+E6sLFoZLXvAMkw+TSoPwMz+/EMvfRtz7W25bmDCZnzDdz3O+I5hlzw/c
         Ipp/GSvbwL+OJk7o6phNwyM+rppi2PTa7V9C/GGm1clx5RFaXOUl6BXrka47vzZ6Hz
         +RCm2sSZzsaH1Vn8csb+A/YA7Jso4wbt13rysCibodoHQ9HZUVER/8lctaDjycbsZi
         q3S585ItjEupw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Thu, 23 Mar 2023 21:33:54 +0900
Subject: [PATCH v3] rust: ioctl: Add ioctl number manipulation functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-ioctl-v3-1-3c5f7a6954b5@asahilina.net>
X-B4-Tracking: v=1; b=H4sIADFHHGQC/3WNwQ6CMBBEf4X0bBW2FMWT/2E8LLDQTUwhLTQaw
 r/bcjR6fJN5M6vw5Ji8uGarcBTY82gjqEMmWoN2IMldZAE5qByglG7xs+SxnZ8SNeS9okYhXkQ
 UGvQkG4e2NUkZpuW0t1MOqTA56vm1v90fkQ37eXTv/TwUKf35EwpZSF2U0KlKY63KG3o0/GSLR
 0uzSFMB/uuQdAWazhXW0PXf+rZtHzY15/EIAQAA
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, linux-arch@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679574839; l=4426;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=dU+ouRLpZkJDik6nlmkKXlAzXALaF6/l7WtvgLXO5Rg=;
 b=pNeQGZgAbH44+sahsleVEVvZ/xncu3esemq28+oJ0oHzhrHwUv6yVnjKisOIoI73mCXQ0/ayb
 W5kgtIYTLLLDl5j0pqcQPo7VuOzOvobdPG7yMPnAilECZwhGMG8BzWF
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add simple 1:1 wrappers of the C ioctl number manipulation functions.
Since these are macros we cannot bindgen them directly, and since they
should be usable in const context we cannot use helper wrappers, so
we'll have to reimplement them in Rust. Thankfully, the C headers do
declare defines for the relevant bitfield positions, so we don't need
to duplicate that.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Changes in v3:
- Actually made the change intended in v2.
- Link to v2: https://lore.kernel.org/r/20230224-rust-ioctl-v2-1-5325e76a92df@asahilina.net

Changes in v2:
- Changed from assert!() to build_assert!() (static_assert!() can't work
  here)
- Link to v1: https://lore.kernel.org/r/20230224-rust-ioctl-v1-1-5142d365a934@asahilina.net
---
 rust/bindings/bindings_helper.h |  3 +-
 rust/kernel/ioctl.rs            | 71 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 75d85bd6c592..aef60f300be0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,8 +6,9 @@
  * Sorted alphabetically.
  */
 
-#include <linux/slab.h>
+#include <linux/ioctl.h>
 #include <linux/refcount.h>
+#include <linux/slab.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
new file mode 100644
index 000000000000..b2076113b6a8
--- /dev/null
+++ b/rust/kernel/ioctl.rs
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#![allow(non_snake_case)]
+
+//! ioctl() number definitions
+//!
+//! C header: [`include/asm-generic/ioctl.h`](../../../../include/asm-generic/ioctl.h)
+
+use crate::build_assert;
+
+/// Build an ioctl number, analogous to the C macro of the same name.
+#[inline(always)]
+const fn _IOC(dir: u32, ty: u32, nr: u32, size: usize) -> u32 {
+    build_assert!(dir <= bindings::_IOC_DIRMASK);
+    build_assert!(ty <= bindings::_IOC_TYPEMASK);
+    build_assert!(nr <= bindings::_IOC_NRMASK);
+    build_assert!(size <= (bindings::_IOC_SIZEMASK as usize));
+
+    (dir << bindings::_IOC_DIRSHIFT)
+        | (ty << bindings::_IOC_TYPESHIFT)
+        | (nr << bindings::_IOC_NRSHIFT)
+        | ((size as u32) << bindings::_IOC_SIZESHIFT)
+}
+
+/// Build an ioctl number for an argumentless ioctl.
+#[inline(always)]
+pub const fn _IO(ty: u32, nr: u32) -> u32 {
+    _IOC(bindings::_IOC_NONE, ty, nr, 0)
+}
+
+/// Build an ioctl number for an read-only ioctl.
+#[inline(always)]
+pub const fn _IOR<T>(ty: u32, nr: u32) -> u32 {
+    _IOC(bindings::_IOC_READ, ty, nr, core::mem::size_of::<T>())
+}
+
+/// Build an ioctl number for an write-only ioctl.
+#[inline(always)]
+pub const fn _IOW<T>(ty: u32, nr: u32) -> u32 {
+    _IOC(bindings::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
+}
+
+/// Build an ioctl number for a read-write ioctl.
+#[inline(always)]
+pub const fn _IOWR<T>(ty: u32, nr: u32) -> u32 {
+    _IOC(
+        bindings::_IOC_READ | bindings::_IOC_WRITE,
+        ty,
+        nr,
+        core::mem::size_of::<T>(),
+    )
+}
+
+/// Get the ioctl direction from an ioctl number.
+pub const fn _IOC_DIR(nr: u32) -> u32 {
+    (nr >> bindings::_IOC_DIRSHIFT) & bindings::_IOC_DIRMASK
+}
+
+/// Get the ioctl type from an ioctl number.
+pub const fn _IOC_TYPE(nr: u32) -> u32 {
+    (nr >> bindings::_IOC_TYPESHIFT) & bindings::_IOC_TYPEMASK
+}
+
+/// Get the ioctl number from an ioctl number.
+pub const fn _IOC_NR(nr: u32) -> u32 {
+    (nr >> bindings::_IOC_NRSHIFT) & bindings::_IOC_NRMASK
+}
+
+/// Get the ioctl size from an ioctl number.
+pub const fn _IOC_SIZE(nr: u32) -> usize {
+    ((nr >> bindings::_IOC_SIZESHIFT) & bindings::_IOC_SIZEMASK) as usize
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 223564f9f0cc..7610b18ee642 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,7 @@ compile_error!("Missing kernel configuration for conditional compilation");
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod ioctl;
 pub mod prelude;
 pub mod print;
 mod static_assert;

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230224-rust-ioctl-a520f3eb3aa8

Thank you,
~~ Lina

