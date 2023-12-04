Return-Path: <linux-arch+bounces-654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E1280418E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 23:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BAF1C20BDA
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12D364A0;
	Mon,  4 Dec 2023 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2P6JA5qQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA49FA
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 14:19:38 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d064f9e2a1so70169687b3.1
        for <linux-arch@vger.kernel.org>; Mon, 04 Dec 2023 14:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701728377; x=1702333177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YjixCCMvWXGgvjOEZP9yI8xNcwVr5lemGtrMuIweNfo=;
        b=2P6JA5qQlREMT52OEUc2cIyZGj9qBE7ezwroygk+1oxeTFUzVQhIEUIrcUilmHVm08
         FlZ8x1P4Iz3Hr6YSvtudwmWGgH4gJRvM5752aROIvTXMxXUKCn3sZ4frU6ukk9cq1j2J
         SuqP+Wztq5G8SPHsi5kiMW0HEZKwuxKuhiQrEKcPysxMg4Qp069GErIuTbdsRc0I1+WN
         ehcJuqCgCju9Q8zPXNmZYuN3ETh0QsaJCDtXzdtykp2h7S8r0ESx1HVMHWR1ZouO+UJZ
         CvrtpOasehfnFyRb67BN4Nwort78gkdF/ZQhlS+7LKshuLKEN+hZEnY2btlK4iXIh33G
         OeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728377; x=1702333177;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjixCCMvWXGgvjOEZP9yI8xNcwVr5lemGtrMuIweNfo=;
        b=t4V3qnb6UjxxVj5MeDL5AFyZRafA1M8yosmnsCssSWCOy0NBe37Hlyyvw2x7ptA7zq
         lfuMYrRkZPaUV2CM9G3hkYYqlHRA/qHk8iyogc1xsWLaF1VXLV8Y0lo0X3a/UBMu15pa
         taLyorgfPSONUrn31su7ayhBK0jH69woj9I0ip2ZUQLq15AGyNkV0uh3ewq0g65dcBD/
         FlBU5L7mf6ehtsm4FK2nCGVRgYXAirJ4mFLfokrqPtMOxKYz/96OOdoGM5N89H01vQsV
         bG7qfeOM+LDLsRp6UbZHlQhWfOB2wuuygShdVgH1pmtOeXY/CsGZnFDHpESPnLPl2xBX
         KJtw==
X-Gm-Message-State: AOJu0Yx6PKZJijz8bIk5rX/70849nKZOGB8iN/ZCPCvq1dREI6UIe81b
	jfJfHhYNFxhFveEQMJs1Ud+UR37YMg==
X-Google-Smtp-Source: AGHT+IG3UzSly7olN8rLOVzLWmjvlzlBKa8sk/0NbpKjrd0oLTQugt5BmAC6ZKFZMeIS6NMXOFkU5H26Nw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:2509:b0:5d8:5d2c:121d with SMTP id
 dt9-20020a05690c250900b005d85d2c121dmr91236ywb.7.1701728377512; Mon, 04 Dec
 2023 14:19:37 -0800 (PST)
Date: Mon,  4 Dec 2023 22:19:26 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204221932.1465004-1-rmoar@google.com>
Subject: [PATCH v3 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
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

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.43.0.rc2.451.g8631bc7472-goog


