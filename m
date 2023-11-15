Return-Path: <linux-arch+bounces-225-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E27EC397
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 14:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148EF1C2074E
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DEC1A708;
	Wed, 15 Nov 2023 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8G4Uevf"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153FF1A5BA
	for <linux-arch@vger.kernel.org>; Wed, 15 Nov 2023 13:28:19 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A148196
	for <linux-arch@vger.kernel.org>; Wed, 15 Nov 2023 05:28:18 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50930f126b1so9024560e87.3
        for <linux-arch@vger.kernel.org>; Wed, 15 Nov 2023 05:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700054896; x=1700659696; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwN4XVt8yK1X3+YfAI5MPsrSuan+JzWxqjLblP1tQKk=;
        b=U8G4Uevfz+kHk0zZH4Xj4k/HqAagC61Z5A7roLUdDSoeAGL83SRc6bJWyn5Tl+tQ8c
         Lmpf6x/qr6bp39utb+XPzTKWPtsZxcwMHKrr20ENEReQH4tDWpx56C8HRLUHCiw/PZOm
         PyYmYVYywVXySeZsW/POAoHjIGBpaUtZFg2CsbHc9UTq2m/te0/9DcnJ8J27iQELwO/x
         eBU31l7ADziA4V6WCPqtwTTd6UKL2M3+csZO7kj0m2RcPW8H3oD4IUjL/YFDbD1kuRCA
         Jbb6+OLtn7d0m6lYlAod08sVzg7tglDPlMVWNZjh13WntC8qXUyNnqprOoPRLznQ1ir0
         XjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054896; x=1700659696;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwN4XVt8yK1X3+YfAI5MPsrSuan+JzWxqjLblP1tQKk=;
        b=SOMSFMCUSOiJmFgcKTs88vkkAcgtPCHASSnL0xdPyops3pqvzLOGxAp1pTC84sC1XX
         MgXC4iTy4+GlKW724qZljaQfJJpOvyEaQo6SsCfQC333wVNYPeqaLZHLYQMgL+VMuRXN
         7lRs10QXV/bm1wJ7raBAIzWK0xgWxnYGlpccmuK/HfCAOK9Zsey1mWBWdOEOshwWYDJE
         pFW9L0vKUnib2jxE3uq2xr63ATv+twKFjYKG3CHKpvHvsLkEwcjY1B5i9RjJATRFJ6TY
         MUAp0w/iT9/gNH+/OzcPw1xcBbnE0dHOQZOyN/tlD8pNaskAmBFZ+fpiR8pbIaJqf4zO
         sEgg==
X-Gm-Message-State: AOJu0YyQfzgXKbOjRiW7r/8HCaeg60VPcyHkMovyqflq9PMV2ekXM+32
	XiwssFIfZTywTtnwKoObYe9wMwGYT8XW1w6IoFQ=
X-Google-Smtp-Source: AGHT+IF6FsX84+Bpu5NsuR9YTgjgvPm5Ii4b6DzTvo5LXdZ+KTsK38zulfyHnqY8V8cYq+V7VMdbJg==
X-Received: by 2002:a05:6512:3e1e:b0:509:4b8a:b65f with SMTP id i30-20020a0565123e1e00b005094b8ab65fmr10675082lfv.60.1700054895757;
        Wed, 15 Nov 2023 05:28:15 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b00507b1da672bsm1648705lfc.174.2023.11.15.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:28:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] arch: Virt to phys to static inlines
Date: Wed, 15 Nov 2023 14:28:13 +0100
Message-Id: <20231115-virt-to-phy-arch-tree-v1-0-8b61296eae73@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3HVGUC/x3MPQqAMAxA4atIZgON/3gVcdAabRaVtBRFvLvF8
 Rvee8CzCnvosweUo3g59gTKM7Bu2jdGWZKhMEVJRDVG0YDhwNPdOKl1GJQZqWxn27Wmapggtaf
 yKtf/Hcb3/QD/9wbVZwAAAA==
To: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, 
 Brian Cain <bcain@quicinc.com>
Cc: linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Some architectures have been given patches to switch their
virt_to_phys()/phys_to_virt() or underlying *pfn etc functions
over to static inlines.

Some patches have been ignored or have no maintained arch
tree.

This set includes patches that I suggest to simply be applied
to the arch tree so they get in.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      ARC: mm: Make virt_to_pfn() a static inline
      Hexagon: Make pfn accessors statics inlines

 arch/arc/include/asm/page.h           | 21 ++++++++++++---------
 arch/arc/include/asm/pgtable-levels.h |  2 +-
 arch/hexagon/include/asm/page.h       | 15 +++++++++++++--
 3 files changed, 26 insertions(+), 12 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231115-virt-to-phy-arch-tree-137bc87046e1

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


