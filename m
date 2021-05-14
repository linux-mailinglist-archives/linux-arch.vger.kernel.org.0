Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198A53806D1
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhENKGb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 06:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233921AbhENKGN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B17F0613BC;
        Fri, 14 May 2021 10:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620986702;
        bh=8+fEpQGvOmZGTcdOWEcXXVRuIui7OYRzo8xlL/ha8Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Afedm/HX0dqQvHyQAQ0JH+c4cBhR8V86+6bYftWfPKbRhV5rm3obFx3dpUy2391RZ
         DqdqU77qt2TOLsl1HtCeaY/qExMKekWhPBt7esxl8OXJQsQtCMyeiSgUT3v/2E3NbG
         ESgkaAJSH7UIec+EVAuz8jonQczDGLUXVEJ1takv1neV5pMwg5d6kVoQnBoGPDf5Ki
         Lu1+gdgPrrriLDZJhtCFUOzAPl4iWdLipeyW1aQykA5YD4b3dlTeTxtqg1TTXlCuVE
         VjQ94WnuyYpggAmZwCvkcOGk/yNKJWNb3a1cupCaapaZ/x/J4+oTHb//yiYQnvU2K4
         P0wFtqI6giOXQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] asm-generic: uaccess: 1-byte access is always aligned
Date:   Fri, 14 May 2021 12:01:00 +0200
Message-Id: <20210514100106.3404011-13-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With the cleaned up version of asm-generic/unaligned.h,
there is a warning about the get_user/put_user helpers using
unaligned access for single-byte variables:

include/asm-generic/uaccess.h: In function ‘__get_user_fn’:
include/asm-generic/unaligned.h:13:15: warning: ‘packed’ attribute ignored for field of type ‘u8’ {aka ‘unsigned char’} [-Wattributes]
  const struct { type x __packed; } *__pptr = (typeof(__pptr))(ptr); \

Change these to use a direct pointer dereference to avoid the
warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 4973328f3c6e..7e903e450659 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -19,7 +19,7 @@ __get_user_fn(size_t size, const void __user *from, void *to)
 
 	switch (size) {
 	case 1:
-		*(u8 *)to = get_unaligned((u8 __force *)from);
+		*(u8 *)to = *((u8 __force *)from);
 		return 0;
 	case 2:
 		*(u16 *)to = get_unaligned((u16 __force *)from);
@@ -45,7 +45,7 @@ __put_user_fn(size_t size, void __user *to, void *from)
 
 	switch (size) {
 	case 1:
-		put_unaligned(*(u8 *)from, (u8 __force *)to);
+		*(*(u8 *)from, (u8 __force *)to);
 		return 0;
 	case 2:
 		put_unaligned(*(u16 *)from, (u16 __force *)to);
-- 
2.29.2

