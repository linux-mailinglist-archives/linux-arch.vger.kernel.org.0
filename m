Return-Path: <linux-arch+bounces-6298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA36955B94
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 08:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172DA281DDE
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 06:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990A5FC02;
	Sun, 18 Aug 2024 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DUjnMekm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1F12B63
	for <linux-arch@vger.kernel.org>; Sun, 18 Aug 2024 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963683; cv=none; b=R1yM1ONILv4FL8Zh5PTQo9+rPt+gRy76bM8MtBw4fQxbKRIDAL2T0muHEZPtT0aWOsXt7S2S0mRcE9XcjMYU/7diiXpvumSHwLRaGtDohUiTTHvGPclLLsGwgnx9iR1KXHXKRT5kPg1CqjDaJJAuAUssxEyeW3OCfpqfSSmmro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963683; c=relaxed/simple;
	bh=yIsmDu+znujFYSMd/qij8s9ZhZp0YCl3HXaNmhK3U1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJmBKsFxsoNe2kgj7gjC/VoPbVWySBzeXapPswNzx6BKejha8/AK5XypEeCFs7fqJoi1zNYTvZkK/Uq5k7DcFNxTMkHGIMI9nF7y+vEccdXJV6mf+lZiZnrGPoOpbJIBue0EkyjycP65/pVCbcqU4UgkKYuaNb1KaKj8MospIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DUjnMekm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37196786139so1335545f8f.2
        for <linux-arch@vger.kernel.org>; Sat, 17 Aug 2024 23:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723963680; x=1724568480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUJVvfa71x+iwF5DF3rrBv6vNd03sOzmOgv8ZqY/vyI=;
        b=DUjnMekmsptAb+IIPJdJ7L5zWLyRHw5Mz4QlBSQDK5gX2Y4X+QNlBwrl6WBqNpAfTt
         6cpSFyRIvkFeXpsA4R55+YKzF47HmO755FmHIz5f6iDulw5r4CtGOn4WRkcVO3/Fflws
         84P/9+ypW835ccX6f4sPhQQABQS1gAe0+u143H5MT7BMzvTsfC+QNgSO5KHlU5jPLR9K
         QWqxhE5syuH+I1MYMlhGpfCAunrtg6Ye6p3T6JsByOIcRczweaz8yYd70oYfbQ9yCfHs
         oMdaLP9pfTOV+FteiQwlBoZ4XGNFpQWzITwBfaAnPsEyFdNi82JiK+7RtLnzCR78Q2bn
         fXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963680; x=1724568480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUJVvfa71x+iwF5DF3rrBv6vNd03sOzmOgv8ZqY/vyI=;
        b=JOz0T+XTpOP1XfgMAEp9RhE2PiE4Eyi6GiOi4mA7XH6c5meldWMZRzElVZfaMsjwjW
         TPli5tblkmXqL8FoCFSbPXcLg1GiRVvkR1OQxqKvmZ+C88y4spwt7I18Ut/yGJWvhqaN
         fB51ixhnQlOaAMpezoIgRvgDIeiudmHgQACd3YVsAF284oXv0QmdQmJlq/sYxH3viiqn
         h8o8kyVvHbGirnvxIIFPHzpNXMhjTtZaMyKowrz/8tr1vudycTfesJPSkhZCVZ9aRsBs
         h/rDbIHnKGbwkFRPDefxg6Zh4xYsHepbE4eGqhckVySNHsyj6pdeEIvgx+vTiUr82HK1
         xGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp4jhn4ZYbB4bjiHZMurU+fE6lcsgLLtvPw01ZdyZnn3x3jIggTJ8vBfENsnmVmnV6dfj7OLKmrue1gu0dbcGZXN3UQxZ92xiV1g==
X-Gm-Message-State: AOJu0YzleM8zPck1ISsO4yDm2IxeIjO25vfvay5az7E7o5yxuK0DgcWZ
	CZcfazxmmG98t80wPaLBni7bsfEgdwlFqcgPhNeMiNdpbwf6JD0jHlE24ZVfw5M=
X-Google-Smtp-Source: AGHT+IHGhKQ874lL1J7nsjPh6FSfKHuvYCqLot3YTtCsdD7yaCkb97X7rPbK0sQldMNV0hrVqhCG+Q==
X-Received: by 2002:a5d:53c5:0:b0:367:8a00:fac3 with SMTP id ffacd0b85a97d-371946514e9mr5069861f8f.30.1723963680234;
        Sat, 17 Aug 2024 23:48:00 -0700 (PDT)
Received: from alex-rivos.guest.squarehotel.net ([130.93.157.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a1b8sm7336054f8f.5.2024.08.17.23.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:47:59 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 12/13] dt-bindings: riscv: Add Ziccrse ISA extension description
Date: Sun, 18 Aug 2024 08:35:37 +0200
Message-Id: <20240818063538.6651-13-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818063538.6651-1-alexghiti@rivosinc.com>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Ziccrse ISA extension which was ratified in
the riscv profiles specification v1.0.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a63578b95c4a..4f174c4c08ff 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -289,6 +289,12 @@ properties:
             in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
             riscv-isa-manual.
 
+        - const: ziccrse
+          description:
+            The standard Ziccrse extension which provides forward progress
+            guarantee on LR/SC sequences, as ratified in commit b1d806605f87
+            ("Updated to ratified state.") of the riscv profiles specification.
+
         - const: zk
           description:
             The standard Zk Standard Scalar cryptography extension as ratified
-- 
2.39.2


