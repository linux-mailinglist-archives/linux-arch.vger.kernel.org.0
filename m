Return-Path: <linux-arch+bounces-5446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA41E933715
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 08:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8651A2817FA
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DF1156E4;
	Wed, 17 Jul 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="T4TxoWBi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119E1FC4
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197817; cv=none; b=Qu18qTGKo+eSpWp/YYReuJH3EYmPd9avoMNt+8S6cR1nFFt1bTCE/CCwVIEvjNJoERpfrl+aZoZJczRr33HdhMAiUKFyCYcGvLSi7oe8wj6Sy5f5qdLtNAtUKjMjaXFZ6X7IIF+cS/SrVNa9XyBXW0PLmz8h+Q0U+f1lCKqEeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197817; c=relaxed/simple;
	bh=V9Jzk4N2zS36v1WQ5gEhoUIZc3Ly89MBgolvymqDsAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itrPJVv1i//YNHCIWpkFXoWxN5uDrxqDXVcFIDppdTRjBD9cpswfgsW9w1CxlynzvAfuorVakOGZ1wgDInoucQth4GDY1ulSEOFYzOLqYqRGTT9vS+a3MWm3NHIX8qH9yfeya6yrp0k11H/sHHjYgl6NYVpucOlxRSyL0Qp9ci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=T4TxoWBi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so51437705e9.0
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721197813; x=1721802613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/a3I9RG+3lbcPTW2WISOokc8gewDy3fkMsPDZhy/D4=;
        b=T4TxoWBiQ7J7z3doxhHqMilZccLpeo/vCwAtUpKuuP+myV49KcZikkAfThhiqEsZgU
         6gfHD+PDyo1GRWtzVi/bDJjcfvGSPrsdcaNYgZI7URcw+9eBmXWcuQ0q7om8jO9IHNwR
         /AhsNZ3pwphzKrvWMD0YA/v4i+YuUQJNlbdnXg/xeIJnri1LCj0e+70b0JefrLhz+hkF
         F3yhc9wWcpbB1VcL9I8XLKJLCnDzqEwaVibgXBQjMTGLbgPbgT7/8dc2vKwGVlBAAnAm
         B1myDcVgh3Cn38o4vXgcMZgWGIVTjKNizRWXJu5cvIUGpSnv7OKDdupQ0sAJTGahp3ZO
         rdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197813; x=1721802613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/a3I9RG+3lbcPTW2WISOokc8gewDy3fkMsPDZhy/D4=;
        b=NMnpzvq0nR1H6XhRVBuoyVOTMm9gvyc7ZAS+Ii1/qmuvZ5RnYk5f3ifd06EiZbicxA
         pIuXPU6Tw43OHQ9gjCHp5U7gP0+pvtJ3uOO7lM3HodH7oTqVr67WC38GsQ1G5GJ4FpLB
         umbBH0/IOycDIolYrc0IozEEDuAEVlNXfBejBeCMBcuiFdbmi8/7Bil3baGBHW6vEMkp
         ARXuX7mK5olVKTqSiX0xW/45Zzo7hg828tpVIhcqO52aM9yP52A/WlZuLXNwq/AhNfZV
         pN1fjf8zDN4Ap2ECcPVZab0FMNh6Z0rCvtRxvVfvIVqGRUpe+kRk0+1GedQGi+HiaVlm
         7mDA==
X-Forwarded-Encrypted: i=1; AJvYcCX+BWJTR4ThKP9l1S3pyNN72HMXDYVo0l70RYsXZgNRpKJ481MfJMivz/qaKbIikuhvaVdJQ/VRSGywb+Hd5aq45UaKJ1Skg4F69Q==
X-Gm-Message-State: AOJu0YxIbIFyqeM1Cbynm/SjCUtLaJukibcFSvoNyqp9UVZAF/XEbiN1
	RvF6CZj+vYJ39bj6Ru74ULcRMZIYapVsGaD+Sm69rcoAs3hkVGFHtaLnCa9w+Dk=
X-Google-Smtp-Source: AGHT+IHes7c6JkEf7yEOk72RnIcqQqTVYNuy3gJbWA9je9hHeJGPheqNOo3gwFeqz1xI+QDtIGxtPA==
X-Received: by 2002:a05:600c:4ec9:b0:426:62c5:4731 with SMTP id 5b1f17b1804b1-427c2d01cafmr5720315e9.29.1721197812676;
        Tue, 16 Jul 2024 23:30:12 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef460csm158127685e9.44.2024.07.16.23.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:30:12 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 10/11] dt-bindings: riscv: Add Ziccrse ISA extension description
Date: Wed, 17 Jul 2024 08:19:56 +0200
Message-Id: <20240717061957.140712-11-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717061957.140712-1-alexghiti@rivosinc.com>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Ziccrse ISA extension which was introduced in
the riscv profiles specification v0.9.2.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index e6436260bdeb..b08bf1a8d8f8 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -245,6 +245,12 @@ properties:
             in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
             riscv-isa-manual.
 
+        - const: ziccrse
+          description:
+            The standard Ziccrse extension which provides forward progress
+            guarantee on LR/SC sequences, as introduced in the riscv profiles
+            specification v0.9.2.
+
         - const: zk
           description:
             The standard Zk Standard Scalar cryptography extension as ratified
-- 
2.39.2


