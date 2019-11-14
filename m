Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6DFC56A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2019 12:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNLeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Nov 2019 06:34:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51284 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNLeB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2019 06:34:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so5299942wme.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2019 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hXXV/2kIvB08deAA2EN09TWub+GXZhxQylBGV0wly2o=;
        b=kiaWUZshTXZr77I5eM6Iord4uC+esCXUajeEDu2SLSeAXVtTQJxNXvn/FQxeDmINbP
         hT17ITCVf33E7Nuo5Pa2+FdnKKivHy4MyMPQj4CZH8O0ULOonqs1/Mepgy1lCxDcDDPo
         upBGlMw+9BhH8O2H4d2RY0V+vFjd6vM0zb3QqRYrGGOiaEwfmpMMoyhldK6cQ8vgcDHo
         9zQTdLi2HBjEGiZY49KODbfy6ti/XQ9hA8mH2PPqLNLouCSyZXIFF4NW8Y5QNvIW/7Yd
         /8KJ42P5CDv61U5sOVP7bcOPKI3zBjG5FL6it8hU7ucv8Nz4lbnbLUSrjLtHXxwnRcX7
         oNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hXXV/2kIvB08deAA2EN09TWub+GXZhxQylBGV0wly2o=;
        b=XpjssmyTKGIjSaA7fs/cKSfz7KViPNmhNFVaoiM5aoAz0qoYWB7HCpqU0shUtB+3iU
         j7vNAKjwGGJqPca5eCpEZ/7Ko4uArhU63ASI72dBZSQ3JJ96PeNPK9bXmK1trZ4HAq1U
         dE5nLVXPD+RVNbZc6673olRf5nGq+p7PSHpyr+wIRq7Xm6hsiMo6dYtV49SNXqE/Dvzg
         PzkIQTRRbrcizH3MTbgocnDMnkZusRJ6ydnL1UCoPIGZsCX65sJXI5ZXDYTP2oaHFY0j
         eLqDKivZtJUliYUIlR6JF8k5YnlFVqyIKXU+EywI+bZqiJ5Zfwoaifp+vWbTHHZMLCgg
         Ovtg==
X-Gm-Message-State: APjAAAUcze01X1i97fEOfSZDE1StGfveU7FnnNbFov6DQEOMcnCPwWsa
        zxCPhgZxUwYY/UwVZ2ydEgSvcA==
X-Google-Smtp-Source: APXvYqwa7C+SZPaRzDCDqgtRRX+BdBhI757ORIAlSyB2X3yAtBSVEylfezUJgRJyC7Xi8Z+nZfWaVw==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr6806183wmo.159.1573731239464;
        Thu, 14 Nov 2019 03:33:59 -0800 (PST)
Received: from localhost.localdomain (184.red-37-158-56.dynamicip.rima-tde.net. [37.158.56.184])
        by smtp.gmail.com with ESMTPSA id m187sm3324275wmf.35.2019.11.14.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 03:33:58 -0800 (PST)
From:   richard.henderson@linaro.org
To:     linux-crypto@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] random: Make  RANDOM_TRUST_CPU depend on ARCH_RANDOM
Date:   Thu, 14 Nov 2019 12:33:46 +0100
Message-Id: <20191114113346.25138-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Richard Henderson <richard.henderson@linaro.org>

Listing the set of host architectures does not scale.
Depend instead on the existance of the architecture rng.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 drivers/char/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index df0fc997dc3e..3c2123a23600 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -539,7 +539,7 @@ endmenu
 
 config RANDOM_TRUST_CPU
 	bool "Trust the CPU manufacturer to initialize Linux's CRNG"
-	depends on X86 || S390 || PPC
+	depends on ARCH_RANDOM
 	default n
 	help
 	Assume that CPU manufacturer (e.g., Intel or AMD for RDSEED or
@@ -559,4 +559,4 @@ config RANDOM_TRUST_BOOTLOADER
 	device randomness. Say Y here to assume the entropy provided by the
 	booloader is trustworthy so it will be added to the kernel's entropy
 	pool. Otherwise, say N here so it will be regarded as device input that
-	only mixes the entropy pool.
\ No newline at end of file
+	only mixes the entropy pool.
-- 
2.17.1

