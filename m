Return-Path: <linux-arch+bounces-12933-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE6DB10C8C
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30BA189932B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88C2ECD1B;
	Thu, 24 Jul 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0iRzo/H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300292E92DC
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365412; cv=none; b=gGidRz9TGvon00hfqRwHrerPzVQsOejyL4tVJPX78sDn13Y1CnjDQHTh6dBBqasEQkBnXh0kjYewd0mGw+0NjBXHzPUo+1HBNHUeyoA9lkhijK3nU1PFYv7/CU5+zA0XB5WW53uz650QkGPRpEYkxsQiXcSsCq2FxZawfcFrTjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365412; c=relaxed/simple;
	bh=wEuXEElSEoeDjBLwM+2PEoqxG10Mf5YuozE9z8W97nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4R0QEYCrinvSyK2QMyTyV+8YlgY8uQqdFSTmankDaoUdOtNkCmaEEsU62v8XALnPDtzVmRUNF4Pje6lCuxWwIT4eS21GUcsm3SHS7QS+Phx2V9m/a2N6IHj1oDc7OExsYZltdevAtpD5ieaYBeUY2AN2W68Y+3hR4EnVhBd/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N0iRzo/H; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45611a6a706so4975455e9.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365406; x=1753970206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrjIGy29vhQmG8TWG3X2445EHE3hkTtQk53xAku5ZzY=;
        b=N0iRzo/HSw4GpGt17bXx6b6/O6ZuRBfug9PwLPcIbNX++v94NlSmli3aFPaEPK7H5r
         iaY+TKWGEB5SfGBTAh7kaxb3R4rulLXH1c/u705kGj2fk5OEnziJZSORD+5Su9Df9h77
         SLXNpM5LJtstYeKvG/AH0aSMHepM9tbTUo5eL/B4hyAAksFCeDY9CAq9DFQlQEHRxTmV
         frlisfgdDdcs9lsDMmzS2iHl0vq2a6XGezRMSPMqVjbHSEIx3xFWhpPwCvrtRI10jRXY
         fC4BJZt4VUx3H60OGMoh0qoSCptGcgPQlwoEEPuFQKolRFeRV/gh7d0hfkHSSyOK/4y6
         sl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365406; x=1753970206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrjIGy29vhQmG8TWG3X2445EHE3hkTtQk53xAku5ZzY=;
        b=GwyvNsPRvF3UhlykU0u27NyFBNxsFfYa7yI2Dt8NUL5e43D3DXHgQV0G642S9YQCQ4
         D0ltFhF4wjzvzKK9NNxetgtrLIx3uZvUs08EGkMrCh8AwIWwZBl4+rvQkr1HIhLtxX1U
         Nr2/LAIL/iyX/GcohAOWWcs/3X9xme2L2n8xkuuANtmY6BuL1rqv0YTksiX2a+bZPMPL
         UqIb4yBYa6W3vcJoiRWXKBtB3+TIj5Wl3QjviiYuG9vBr9OV6+IGEWXk/O1L3aplyyMH
         6QLhGq/CenzJURWahQLIz9cgwKaWmIfCcwStsyDGnuh6E6VykN0QC0tjazdT+I6PZPGd
         MtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/amyiYDVN4mJDwhDJPFy334BG1NDQmaPh2jXj98V3HJuZVKXpU9vX2+ydP5Xv//WSWA/Gxaq4nLd3@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFauiIMTO25dEAo2owc38f8Gc9jNqyzCToFoNHTADaN893cUa
	X8iKJABINmsDLIJqWLOAOqYhLp8qvU4BnWLU/24VYEa4GK8HbqhsOlgG/iRyQW89Xfk=
X-Gm-Gg: ASbGncvBVX/z1p4kBjiSuBA2VtVpZ0uP9eydOamtxk1VSgehPTzZWObEsJV2/I0O4vK
	MzcAKdJy9L6uegh1khJOxQ0DGzqThXX1KC9l/qA1h81ZSBvOtAzmS7VTyZQvKLCDldgF/sze4ug
	xMUGz1hK7WP/QeCujffoml9D3mdjx3+Y9wuMSwgSb2kTp7+rmyBu0ieKkFoHxRg1z2z9idB0sqk
	hTxIaMsyX3nmyycQbo9j/qPT1NTerT4Avd/O7I23NoDHBAkhRjXkHf3SPjji+dqvnFU6hf8poYY
	7QaOg/ZWGN6tDmYTYH25y1+xxgmPNq8sOpUnbk5awZ9jmIkQ22y1gA/0PcOo6mibmwQN0mg6Bi3
	PrVdU+Eg5Qmx2EtsMUQSKAKFmVQLctzzpHFPJ99OYoZ1dSs4roWnv+OUQks5GeTYRZ9g53CRYfj
	p/TkT2QkTjB/Le
X-Google-Smtp-Source: AGHT+IEVcqWnuyhtVrHKBupbieg0QvSQq5CXC89YW4ucbe/Xkxqrak9r8AlJ1/jdx+SIbeQvU+walA==
X-Received: by 2002:a05:600c:8b70:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-45868d2c4cfmr54619365e9.20.1753365405757;
        Thu, 24 Jul 2025 06:56:45 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:45 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 26/29] init/version: Annotate init uts name separately into Kmemdump
Date: Thu, 24 Jul 2025 16:55:09 +0300
Message-ID: <20250724135512.518487-27-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some specific firmware is looking for the init uts name region.
In consequence this has to be registered as a dedicated region into
kmemdump.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 init/version.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/version.c b/init/version.c
index f5910c027948..364e7768da68 100644
--- a/init/version.c
+++ b/init/version.c
@@ -53,6 +53,8 @@ const char linux_banner[] __weak;
 #include "version-timestamp.c"
 
 KMEMDUMP_VAR_CORE(init_uts_ns, sizeof(init_uts_ns));
+KMEMDUMP_VAR_CORE_NAMED(init_uts_ns_name, init_uts_ns.name,
+			sizeof(init_uts_ns.name));
 KMEMDUMP_VAR_CORE(linux_banner, sizeof(linux_banner));
 
 EXPORT_SYMBOL_GPL(init_uts_ns);
-- 
2.43.0


