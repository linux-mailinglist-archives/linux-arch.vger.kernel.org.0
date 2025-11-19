Return-Path: <linux-arch+bounces-14929-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 152EFC6FBF2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id A32DA29CDB
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940236A00A;
	Wed, 19 Nov 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmDHNoQu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D502D4805
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567140; cv=none; b=pR/RCaWiMu4qSADj9IZXDqA2PFTxliGFdg4QbLYestCdYgZIin97rHV2wzbgGRD00Tivi3TWFUL7VoNZWEmBiCWLIjZasbMqDNxAVMFRQvj2UntpYfD6gNyBS0g4sXHpdtAcEVcw+pb9mhNo2j9G4xOs4O9/Me6Y2uJP/ezsyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567140; c=relaxed/simple;
	bh=TD1by0OTaP880US48xY3+1tAtbimE4nLFyenW4Dl/t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CP5tLoPREFZOP5y7aHswO10EpTEUhDFlMwS3QmUq6s7e0lBxgcX9mtA4WqQeYUzoG3En7Gu9WYJbdvrJZA2rh9FIe1BarsCtrz2OouOHJqPJ5YiG4SXt//wKHMzmPW/7rEtkM7ir19HOyYAydw2rqApkECOTJmkh4UcjCuB1QPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmDHNoQu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42bb288c219so3582969f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567132; x=1764171932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THAjTq9x4zT81mmTnIarOvW/kNy7ppuR0bAFxzz05mc=;
        b=kmDHNoQu64HbmUGpkc9vYVbHScLy0U0K3t13WEAzv2EDq8a8uPl0d4aWu6NxEH4N1t
         DYYE8ac89yB69Gol4kY2PYMld6Mj6ywoy/rzvjIZJaK5HRAdqiRUeyuEFTVsLejLbh6W
         3TJ/neVjVhIoqjX30M95snlbaU209rNFQn27MGf9j4vlM2WJL/UQ+DElN6BeNUSNt0m9
         MtOlEDObIPHZ8AQoxYJFwIPUr/dgA/ysyug1orn6TqhN4UiVORtBU+5OYM511Gy710PF
         t+B5gphP+SGCjRgl3wzXRoSe9gTtaPOY3qj52wB5VXVOyBK1swi0MrDrAiE86iSXtahV
         SpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567132; x=1764171932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THAjTq9x4zT81mmTnIarOvW/kNy7ppuR0bAFxzz05mc=;
        b=qknWC4YRAx4Mh9GqHWbSMvSMWXwNsJEBt9n/79r7duiHsXkdL2qB0Anfhv4aGPdhLK
         PeTDiUnH5at0blNdo0mh7qjvGT6IdIxu6oAcUd3Aur0Vaphd4lY60fT/KU8ej7JKdp7z
         krdasv5kaLilMp2Uq/zIxr9iFjFA/uobEQI8An5FS2caIsIFXTjjRmv4Xjk73muipiyU
         9azjpQxKg2jN9xr86JacayOI8R5MbJYtbIiSmzkGLg0910OnyCNX/c+DePGOwhoYOO8v
         qcJDTMH6mbCVaQE2GpD6VldhcJ0fboNGSeFDzTZ5TRL27j+er0NwydBxSeu1feBWInxG
         hfdg==
X-Forwarded-Encrypted: i=1; AJvYcCV5km1rbVu9tC4rGBm/8EMy41g7wowuuVVk/RNL1u2unZEzP6I0JukKEZmZqa95Alzq+iLchBd5Jy52@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kdEv3GC3p+SBaEFQBezpevtwNtAiDdbDhpd6uI8OmjWIyXKt
	moyEdErlID7yh2E298zd+HSGZea7h5hUY2OT+H2EEWzS8jzq5p9Nj3oe4iDNvj4gsWU=
X-Gm-Gg: ASbGncsXd4+eOeFCtV55eJ0VmuZ84AdS2ETQ6xRykDPofhnXTs2FpvEhVzXnTLloCVa
	gU2ymMASxz4/dH6r2RwRo+sedREq25jhnTrfWzsJap1IFBeh7vGqB9rUNRr/awC79boWqpcVwdu
	YGwexmD/BNWrabuAzLz7bzr3RyYnpnsujO0KgUWeoYwugbd20pqK0/RpsZSC8iCIUim4IJYwBTS
	kXPmsUWvgSsdQ3etvVfrPthlgCdw3bo7+r6UysEqxjgnedqXmoooETANYQVA8EniUoL8NF3V+DB
	z92SsB4/Zr1YcZowTbLoTl3Uv+K0lY2+Wjdtvl6NndEs9Zr2xM82/XhBcoH+rOvAYiOOQ+X6l+6
	Q8WMwc0Lz4x+nznARL4uWOJH7ooF5wRd/T86bQl1kuTnP9DxS33mXFIy3dgY/hMwIM00P0MnPEM
	+o0vAgR/PPRlkPPnP8AiHHA9WYQrZd9w==
X-Google-Smtp-Source: AGHT+IFM/SLutYeAmIo2p7oRt8B5TNnuLzBZ4qt+3E18Kli5wgQjVTHlMxDsxZxKW/tnJD9yRmbxGA==
X-Received: by 2002:a05:6000:2a0a:b0:42c:a449:d68c with SMTP id ffacd0b85a97d-42ca449da11mr9102186f8f.30.1763567132399;
        Wed, 19 Nov 2025 07:45:32 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:32 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 09/26] mm/show_mem: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:10 +0200
Message-ID: <20251119154427.1033475-10-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - _totalram_pages

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/show_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 3a4b5207635d..be9cded4acdb 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -14,12 +14,14 @@
 #include <linux/mmzone.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
+#include <linux/meminspect.h>
 
 #include "internal.h"
 #include "swap.h"
 
 atomic_long_t _totalram_pages __read_mostly;
 EXPORT_SYMBOL(_totalram_pages);
+MEMINSPECT_SIMPLE_ENTRY(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 
-- 
2.43.0


