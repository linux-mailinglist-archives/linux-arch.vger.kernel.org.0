Return-Path: <linux-arch+bounces-13335-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540EB3B96F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 12:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0FB3606FB
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD04314B88;
	Fri, 29 Aug 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h94eX1K5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562CC3148DB
	for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464882; cv=none; b=ZRanHC7bJWfI1kJZOLDJmK69mGShlXj3L/Y1W3iKYAxEgUDKXHcAY9SOCc45LC3H8T9enmZzzM/adUyFBYySEvqEIlrIgGlsr756t/eocV+XVZcBEP+hTWJUbIvF79sOiitwTX9K2OXblPw6ZwzbqzmmavO1e+84+bHRpiMR0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464882; c=relaxed/simple;
	bh=so0KS5+HKtS7bLgo8wlIBPBrMrd/uZF6z+PZRF+H0bI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PsFUTzkKZhXqf0D0S5ae1fP8QrVEmDHehgyrwop2E/zEcNDeouTInFlWK1D7Hz6w9Tc525fPMjd1YEumBOKoLFP9XLUHBx8yTD+C104vC2H5o8C8Yh9lFfrUDLRB4MlCNX7b/fstqjeba7o0mslOUHFTb6G8KOZGRBwOIaSkGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h94eX1K5; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3cf12498799so446583f8f.2
        for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464877; x=1757069677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2RLysX4FvFaZxrrpQCtMS5piDnkGHi5CdyrEUjW23Q=;
        b=h94eX1K5Wxx/ICOyOMU2fJj16skwRe0a9i0pccb0ZMRC/3GLURFA0Aal8HOHLNX2k7
         H6YJ478Y3YEpC86P9BvjP4C6l+EPWlc5q6gPOVKdGeB8SNZ9MQUVkuMCTwOjEX0RLPop
         3ilypXLnkPuLWkvGkTnssu99nIiFCY1db86yiqoDE3YdcZGdHV4QzBgbsGU/itBis6sg
         I4+JwUwXjCS7dOhQRpZOAxwX1u1HSLWCi7QI7msNV6oIckQlVZGjToKUCAOIVNMQkXGf
         mKNje/UtkF5PvsO3sn2a6PF66VjnLsC9nF8mrlXeC3BzG028wQ03HtSjlwHJaDYWruKP
         TxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464877; x=1757069677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2RLysX4FvFaZxrrpQCtMS5piDnkGHi5CdyrEUjW23Q=;
        b=P/apFOEBltMn+edJVVlwGfK1X1iHdKZOQ7KTeXfO0guJFfKgyjnVmVSgO5/krwBiji
         yYxdHBnyBdCt/RkxopLAUG9KZVNteA6hiprH8bCBsHCUhaiFoHyR60X5a4k7jWVJvarl
         ZO6eCdioJ5hD0R7kLW9ocVwy/PglAeHEf4cRNmE9CZwGUv7CEPJZ9+KF53WvULUfp1zM
         TY1fu7bruIMkCtKTBmEfpapOGzRLGAdhugV5tsp6HZ1edfN2Ch/LTaGh4j0TEzmCtzr/
         o3cmrJd8FWj0frnczU8yf9NwgznnnyS9ry1GZ1NdZH2yTQk3BcrUhO2xrURyBcno5/8q
         ttyg==
X-Forwarded-Encrypted: i=1; AJvYcCW1c2VEliqO2cCD3nu3FtZmT5+cNsADY2rN3umjzSkG4hfuyHapRA8CmAZqM0az0qPH20dENIHWHywL@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOPAqy3ErZuj/4H2HxKoBBHf5kJNPb3WaAVcObUHd2QGwnMHu
	KM33xshhwfMnsD1Pa3MXhm0+zvq09EFNP0RDWFoeFFCSw1OFvC/p9F9IuiP64NPzem2dAPmacO/
	Sm2S+kEuqH+3y5SwG0g==
X-Google-Smtp-Source: AGHT+IGn0Rpy1dY1XrZvELEcqgT8iGR3jz5ujSyOBLj7FBCWbv3AUGiqUNArS0IwRoFyThmIfPNLn57QEPEFlW0=
X-Received: from wrbm25.prod.google.com ([2002:adf:a3d9:0:b0:3b7:76ea:26cd])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5887:0:b0:3b7:88f5:eaae with SMTP id ffacd0b85a97d-3c5dc542ac7mr20449959f8f.39.1756464877398;
 Fri, 29 Aug 2025 03:54:37 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:16 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-9-sidnayyar@google.com>
Subject: [PATCH 08/10] remove references to *_gpl sections in documentation
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 Documentation/kbuild/modules.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index d0703605bfa4..f2022fa2342f 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -426,11 +426,11 @@ Symbols From the Kernel (vmlinux + modules)
 Version Information Formats
 ---------------------------
 
-	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
-	sections. Symbol names and namespaces are stored in __ksymtab_strings,
+	Exported symbols have information stored in the __ksymtab section.
+	Symbol names and namespaces are stored in __ksymtab_strings section,
 	using a format similar to the string table used for ELF. If
 	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
-	symbols will be added to the __kcrctab or __kcrctab_gpl.
+	symbols will be added to the __kcrctab section.
 
 	If CONFIG_BASIC_MODVERSIONS is enabled (default with
 	CONFIG_MODVERSIONS), imported symbols will have their symbol name and
-- 
2.51.0.338.gd7d06c2dae-goog


