Return-Path: <linux-arch+bounces-1013-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E3811F29
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 20:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A1A1F21822
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2477A67B6C;
	Wed, 13 Dec 2023 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jx3AMrlg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9490D9C
	for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 11:44:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e1e41fd6a6so26677747b3.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496667; x=1703101467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZ3eBLJoXN0Zb334Rc/oMDoovJgn3OQlnIJlBZWmysw=;
        b=jx3AMrlgOr+eD/lfzdIvqCV046Y6JH+gGEf6Vn29MLPFUx3JjnjEhV5tn/GWk0nd4+
         CjNohCdWyRwDnfXoCNc0KRt4yHu+vN8bVqDTEjIiYlcKHpawyST/lWJlGYMxbB8mDEX/
         QDAOBYourpvnBtVWQy0RIqhd9kVftn8KRR0g1f3mBPhyvCQINmQdDEXNncYI18KXa69S
         UkDqRfHMwSHwY5XD3uWntwBw4FM0YGZSdb+EgtBtM1WKgX7EeX8H942euN38tFFeoVv5
         ZDO2nSDVBNEkc3ZxpEVLtFOcPa4g5yQhgOQPfz/NzUvvoZxa98rPWadPDC8JvQlyRB2c
         PLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496667; x=1703101467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZ3eBLJoXN0Zb334Rc/oMDoovJgn3OQlnIJlBZWmysw=;
        b=WLJzjB7ibFlcWsrKLSiCZ3z7gbfDwjsZLuMXdDPT+87DExC3IRIPmXonNO18V8jpkS
         rH6++pdTuQLMBxMXw9/B+VFb19NsgPt9hvQlgOGhM2wuO4SaJLfQYzPBbyYb4mb6QnAD
         QlDom94kb0ClYuXR1hBtcErDTKY027VkgAyo+2Rr4aDJPZ1zCD2rL9eRQ+GUiIaPlfgS
         /shjwrsQke6vE0cTMuygCtSuCZRPOtxzyrqLUnkh+7m7MQJKRvOQrI8pdL4TfC7rPX+R
         E4ZaFfPuDGnUjx5CrjEW6QMOhb2IvhouTp1jYWqyXh64CsaVMVtfVbOcBqLBwlT947//
         PDew==
X-Gm-Message-State: AOJu0YyuznQiTPn5uJC4jCsig/FFxZW0HMWySSr2IszbsTeO+TgUazBJ
	eCvVTjXAqGbl/4WAOotWegsbV68Yqw==
X-Google-Smtp-Source: AGHT+IHUpke9zQYYoRhy3jSBDvuiZMWqdS9EZXOxv1azcDgbxZdKFBM1RfilmtUnk9IB8wj22/cc+5W6EQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:9705:0:b0:db5:45eb:75b0 with SMTP id
 d5-20020a259705000000b00db545eb75b0mr69766ybo.6.1702496666790; Wed, 13 Dec
 2023 11:44:26 -0800 (PST)
Date: Wed, 13 Dec 2023 19:44:16 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-1-rmoar@google.com>
Subject: [PATCH v5 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Alter the linker section of KUNIT_TABLE to move it out of INIT_DATA and
into DATA_DATA.

Data for KUnit tests does not need to be in the init section.

In order to run tests again after boot the KUnit data cannot be labeled as
init data as the kernel could write over it.

Add a KUNIT_INIT_TABLE in the next patch for KUnit tests that test init
data/functions.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/asm-generic/vmlinux.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bae0fe4d499b..1107905d37fc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -370,7 +370,8 @@
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
-	TRACEPOINT_STR()
+	TRACEPOINT_STR()						\
+	KUNIT_TABLE()
 
 /*
  * Data section helpers
@@ -699,8 +700,7 @@
 	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
-	EARLY_LSM_TABLE()						\
-	KUNIT_TABLE()
+	EARLY_LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\

base-commit: b285ba6f8cc1b2bfece0b4350fdb92c8780bc698
-- 
2.43.0.472.g3155946c3a-goog


