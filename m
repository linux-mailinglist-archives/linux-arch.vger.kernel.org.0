Return-Path: <linux-arch+bounces-14487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB10C2D185
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 17:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702AF1885FA3
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D731D379;
	Mon,  3 Nov 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1XsnXQA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2031AF3C
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186814; cv=none; b=Z3g+vPZohe5xRvsH2O1jUatboHrJFXu395Bg/yNxMOK8PNDAHUQ/Y3YPsoH5UxsXHsvKbBp3PjOeAu1DxyKX+tcvXWM4isGUqvO7pGCE5EFlaurJRSfyuOhd++kHsQPZM3Ba8/glJxxq4vbtwQYVzgtqoA+19tVA0tB97dHiaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186814; c=relaxed/simple;
	bh=ZfLqA4q+LlT4KDHK6OgFCUnnDeCp0/yqCM3z3y4ZAUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o0x4fgMXnhVv86Y04wICwNz96fuZam71hP3wBvMz1pxpREQktBQazTT3o1Tzu3BP4NEbf64t3IrxbybGS7udHGuC7X3smKkyOlzNet2M302G1+ouGFBxqnz7MSSnALdjnC321xPBbSSxwj/B20nGVSc4x4NtoPnbhSzVNNwxBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1XsnXQA; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429be5aeea2so1889687f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186810; x=1762791610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKMXNiGZfPIVH217MRjliLXTvp1YDgJjekxykL3Rm90=;
        b=n1XsnXQAt2p3nRKaN4HTnKPHWC569qA8uToA2McZM3UKZJU0HLJHpL+s8xp2ORO7CA
         tNfjzzjpxaTzkE50+HaZGP3+3uaMq9zijiAoSatK1Mm9sygV0nPCfq7e3/8M2EKMGB/A
         FaOg1dCWLFxG8+gOu5kWjq0mbTKmPWBp9SKiqMTpAzGy7TKK4adXM2MyeRH5bYo1xynV
         JxxQxMYvQ8n0KcHogckZHciVzIpkyLnj/n+74NuRjuGivON1k1qA2La6kfBPsGXnvAXG
         olqjcjyUSwRJCRswG0Wsbwj9E3lYkCS6bbAhzttyMWQ13INhBTiFPSFfU9GJTlhmZjaE
         RYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186810; x=1762791610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKMXNiGZfPIVH217MRjliLXTvp1YDgJjekxykL3Rm90=;
        b=jNk8+Jrw1dY+XaDyDsSNzHCGa3u/YQ83zye+V1dhID0WerDw66GLFiTR077bGfX50K
         YS6BLIVOUJkToKnfjq+EVHfbr0wAiF7UPBGvuW1TlTxg8iOq3nPEzzhCMQLI4SHBhdLZ
         EF73zlSSvMqk0aWx0bLuMZM552jT9IJHl+QTPkJ00fk2R3GeZ7NfXy5b8ySYC4dHvwUY
         7+ZTBB1/XvYaLxd3V7nORsAdh27QRXhnWEtY3Hdfpdv+0VZrIlQ//rp59e2Qzids7F2d
         zBspBax+ZdFAepSQTKUDwR1ss+QPYwpokmu1pLFNiJ07aXlWhKLJOBv1QwOwdhGEFGCO
         NgvA==
X-Forwarded-Encrypted: i=1; AJvYcCVYfywmUnDMshPmLFVoMNThSIVNlQ25bFKF1dyG4qwCPiQwE4ZlHftsy9CbF8G3pel1no37LMptTg4s@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxblBfM0/VxS+ENgel/C2jdI2jQVmnxGedVq1UFNchvUxHpYD
	m60pKphbBGAWep2WvVpdcoJ4rSnBo00oH37G3PJEIHtUz0H2KbPxEzhVa6ZDhqEmEHf/a2yoGlF
	MuC+j7gGV8lmhDJ/LfA==
X-Google-Smtp-Source: AGHT+IFC8uEzBjpjBcVhKIzQAVZ9PgWEyRrTcxIH5OA39bpirlxZf+DPWIWJ65wuyC7UfWssuMtt201eUDa8ubY=
X-Received: from wmna17.prod.google.com ([2002:a05:600c:691:b0:477:11b7:17fc])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2888:b0:3ff:d5c5:6b0d with SMTP id ffacd0b85a97d-429bd6723c1mr10520562f8f.4.1762186810296;
 Mon, 03 Nov 2025 08:20:10 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:54 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-9-sidnayyar@google.com>
Subject: [PATCH v3 8/8] remove references to *_gpl sections in documentation
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 Documentation/kbuild/modules.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index d0703605bfa4..b3a26a36ee17 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -426,11 +426,12 @@ Symbols From the Kernel (vmlinux + modules)
 Version Information Formats
 ---------------------------
 
-	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
-	sections. Symbol names and namespaces are stored in __ksymtab_strings,
-	using a format similar to the string table used for ELF. If
-	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
-	symbols will be added to the __kcrctab or __kcrctab_gpl.
+	Exported symbols have information stored in the __ksymtab and
+	__kflagstab sections. Symbol names and namespaces are stored in
+	__ksymtab_strings section, using a format similar to the string
+	table used for ELF. If CONFIG_MODVERSIONS is enabled, the CRCs
+	corresponding to exported symbols will be added to the
+	__kcrctab section.
 
 	If CONFIG_BASIC_MODVERSIONS is enabled (default with
 	CONFIG_MODVERSIONS), imported symbols will have their symbol name and
-- 
2.51.1.930.gacf6e81ea2-goog


