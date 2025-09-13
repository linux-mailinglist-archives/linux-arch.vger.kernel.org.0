Return-Path: <linux-arch+bounces-13532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D0B55B67
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 02:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A741D63028
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 00:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D52CBA34;
	Sat, 13 Sep 2025 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXC5LHaV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9D78F43
	for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724530; cv=none; b=V9TSZ2ZnjD/UbddTV7XEv/TmRPJ6lN6++5cmojAIfknkq5/1cZEcRBYh8lndhho9YSjT85XnKsV2bXFETcZ67pvf7T8uPhR6hhjJ+nDoXIfUrElvS05ux3huK7+S2Bw4GneTLrN3YV9FpPjDmKUDQoco35umBD3t5J/9sOE1ljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724530; c=relaxed/simple;
	bh=xKqULWXz/2FiENcJWmfzamYmMIE4imk3W/BtNdWBiQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFDrDzYlwdth+zdiPTMnWzOsCH/DWwgDyBOJSfBiUaypAkvUgvP+mVFnLdfV+olHEKQ5SyEZL65F3hfTukyuYTur5Mm/o96pIOF3nNQSvTxSr7nN8ldU0pz2qQWv4+eEKKABnTe1OHZfWkR6Ut0X/Djz7KWEJXldM0hV1xNxFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXC5LHaV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b04770a25f2so357253666b.2
        for <linux-arch@vger.kernel.org>; Fri, 12 Sep 2025 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724526; x=1758329326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=LXC5LHaVko3hLgitulh2D+X+9QzDfKDNhew7kFXwh3JBpMXe8S8TiFwp92HLY5PnX/
         nE0PBrgrSYYmvUr7nB60XBcUGWbD3ENdwZDdGEZEpmftZ+HtA+EeeF7PR1uT2dDM52dc
         ZMVq+Hm8pSzt/CvRPR7Me2trqTMPiaCvHkP6+b+IEQvD5eF5k0u5n4FsZ31R41RDQcDQ
         BrBCpUlXV52huKpy2TgomHW9QVs9Ykrr2tU/v4K4dgAQoo0ONvDQb+XsjiZSFbJ2IgvS
         xrCTwIgGWYosdnf/NGyWsk7DdhjDkNLnA/ofhmUV8ldCxH2yGyu11Sj/DxoAM0vBqfC8
         jM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724526; x=1758329326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=MItOFFEIBPqXZxNGN2mcRQOQI1v1TRRl200kn8bk2N+EKI65ZkTPor1dH+K6aRnHSN
         n4xSW6+8FmvD8yWWNQJtJALyLhAWZe9L1/ixJvTF9BxNStnsGX3TpLojK1ERyvYBbp7d
         XEMz8ugJYUAkm9P/8lhVAbVtc8f6N57oyute0TZtRZQgBtRtEV9erP4dprt3iYa/9Fha
         IgJH077hBW93RI37542XDpoHivO0wmvzwed55IkcAMCnMdSkyvvE7ADKHfIdRgejEhHP
         ZzFoF1oxSywYa3qYRI6NF6A5TNeAdPHLBUHBKlY3FQLK9wsruHhV++bmTQ4teyr9v+fS
         byew==
X-Forwarded-Encrypted: i=1; AJvYcCVEAvpZGbuB+mCilBkh+geVdfAv5DYDiPzmx+YnjRGhFeA2kFMLITmZtD9DXQliaObJfHDHXL/OcGzn@vger.kernel.org
X-Gm-Message-State: AOJu0YxsO5oiH6lbiGlkpQAD/J26Z8UjKPYHR56YgP8BPohBNKCapilm
	X98BOzTWhbQXSzBv1pa5qKkRRcCHsAafHJXFvVngybkKgSOnBnioh27o
X-Gm-Gg: ASbGncufVOQGDpJnHZGWMWnYidHomTLS1bqTv7wJ3fzeNbfbEaaTLE31LPv8fsrYzyu
	5K6IZllNJ5W4tERGP+UipJ4Zv8uOSkrgLzgbKAh7sahhf5u/Wq7OVsbQONQ4uhtR9x9edpaB1om
	aYWcis17TcgSSdnf7e5tjjmHj6pYJbL0RuxK+D9bnZ5VDUPM8vHz8y1mDDd/qe4tYRodJotip1q
	4elKXsXp00wtbVjFw5XnCj5GZZruol9ofUmYqFbQZTXu8w53TJKsWEk3lCKYFof9AeS77dCZz3N
	jqaBvN39fFxwU1FV7RLUxie+3RdqxjyfQBYhlb81RSSRGi/+m2B5Duq18Ts6RAiKYL+6g5hwmws
	W+luoKBQtvjmuJP9FuhQ=
X-Google-Smtp-Source: AGHT+IG9OWg6vz1Y30fO80tUWulNMPWiUpAt7xVByuYcp52he6rblxs++6dTXTQkGfdvR2czpiOABA==
X-Received: by 2002:a17:907:d88:b0:af9:add3:6bbb with SMTP id a640c23a62f3a-b07c35fb469mr433586666b.29.1757724525627;
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5bfsm461777466b.63.2025.09.12.17.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 08/62] arm: init: remove FLAG_RDLOAD and FLAG_RDPROMPT
Date: Sat, 13 Sep 2025 00:37:47 +0000
Message-ID: <20250913003842.41944-9-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They are unused since previous commit

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/arch/arm/setup.rst | 4 ++--
 arch/arm/kernel/atags_compat.c   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
index 8e12ef3fb9a7..be77d4b2aac1 100644
--- a/Documentation/arch/arm/setup.rst
+++ b/Documentation/arch/arm/setup.rst
@@ -35,8 +35,8 @@ below:
     =====   ========================
     bit 0   1 = mount root read only
     bit 1   unused
-    bit 2   0 = load ramdisk
-    bit 3   0 = prompt for ramdisk
+    bit 2   unused
+    bit 3   unused
     =====   ========================
 
  rootdev
diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
index b9747061fa97..8d04edee3066 100644
--- a/arch/arm/kernel/atags_compat.c
+++ b/arch/arm/kernel/atags_compat.c
@@ -44,8 +44,6 @@ struct param_struct {
 	    unsigned long ramdisk_size;		/*  8 */
 	    unsigned long flags;		/* 12 */
 #define FLAG_READONLY	1
-#define FLAG_RDLOAD	4
-#define FLAG_RDPROMPT	8
 	    unsigned long rootdev;		/* 16 */
 	    unsigned long video_num_cols;	/* 20 */
 	    unsigned long video_num_rows;	/* 24 */
-- 
2.47.2


