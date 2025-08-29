Return-Path: <linux-arch+bounces-13329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B07B3B959
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 12:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EBA7C50B9
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFAD31196B;
	Fri, 29 Aug 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egosu7hm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9153101D7
	for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464875; cv=none; b=Z3iPrGntfAvDPiP9bYIhm/0aTSc4rVyQCKbnCYBsrtcSuPV5jLttlaDNRiohRDwMZ8qdTKCWRve0u1rShzdSf4Qz4ikPh3cfywYjQ18yLEOZSSzkJux40u2T/LSjFZA2jyqBGj0+pi7lelfLzi8zKZjvTWuE89HmZEOxCLWsHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464875; c=relaxed/simple;
	bh=gRovmQuH2UtNnwZvSmPpczaZbZGecSis3mfrjkbqTIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZQ/wzpT0fshrEnsncBshUPhSXCDJZ0mM4LO47Z9W/eGBnv4wCRwJHAVDRemZ0x0fEn68drdNB/6Mt9E+dCXPw8f5e3Pi/48RlT25DOOrD+/UBwRl0P12YLZWcUeJtPvyKNVlNDLlo95jq/MghWaGjsqDmJ2cmTSV5EJ3XzAjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egosu7hm; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c79f0a57ddso1174292f8f.1
        for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464872; x=1757069672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yM7j7Qx57ly8fS8GyHAmsOp7RH5RV9aoVcQOsSKjdc=;
        b=egosu7hmyxvPwJ8yxFHf9s6LTXlunyphHUgjwkl/WqvuFVy+ZAy172Q/h1LwYJuUfQ
         +IEy2/iCLXDpRczFsa3iOgUX2bjpgP3k9ZYUbwL9IuXDwjV5NFdRcJRutKYAoci4UmR8
         A3nEvXzuYc3/bQ+5KI7Q2X+yLstsfypqB6TFjryM3EV4DWow7y/pAaohOzzOYZOiX9oA
         448Ds4bMsuyXLhDxnqp3YDHRu+ZgLcAAGXvCz+v6oPF+3dtEgCrANDZ6bNnXaihoMmVG
         5QIxQ8wi36kWStSGdAYx7TVy2ZzwRpxVKk3MN8ouJLhOYVU4kPM0i1C+8ty39NqF/QpD
         ywaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464872; x=1757069672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yM7j7Qx57ly8fS8GyHAmsOp7RH5RV9aoVcQOsSKjdc=;
        b=adiBgrWQ/Phev9p1CsTaz9IpBEKw1j9ATE82XRq5a+J8OYgJue2J19bv5kRqMpqzdj
         kEg98GrNJU4cpJmXV66OYZRXesQ0BFtAHD6vPB2D3XSTCOTsRr/yoT9R3GS2nMbntQxR
         0Kq6SYOuhzeRGwvn4ZbdQ7ySGeuKAovDDvoWMxDF9eL+Y4F5We5yPI4NFHnIGouLqfWE
         ZyWoxN5+qtjWBUChAimboWlA0l2g+WXzGNlz/xJXcTeCs42bmkMlAp8D3PzPcmRdGcyS
         DP7A1l0p1VpA4HJG9d+rJ4K5sU4yux+VPH38jhiXujEBdejo0eab0v9KU4gLEv0/EN+i
         Gl1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFjNrfESlMu2b//ltYJolk0lFuR1OXUQECicItoLKuSVv7pMuDCeUuda4hm9MRUeh65xNOdN7obOsH@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYuOc1u5W+Pnwo+8j4z+wQnFb3c/m2drKreo5rZFA2e45CC46
	7V3P0ktp936jIGLPjgFqRKmkp6WTJyBbGXO4bDICbBnQ+bqfxxhlKb5EAa9XhmYTSzfkRXnqRmD
	lN7a/aa9IuvSFvplDkg==
X-Google-Smtp-Source: AGHT+IHwqLzW8AsFBaut7VXJETAMa4EmJuYMwngEAyyui2jcQSConTi2ueB/MSNCerNr9v8EE1wUOpLQRN2mL6k=
X-Received: from wmsp29.prod.google.com ([2002:a05:600c:1d9d:b0:458:bea8:57ef])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2406:b0:3d0:affe:ed6f with SMTP id ffacd0b85a97d-3d0affef412mr1214056f8f.57.1756464871870;
 Fri, 29 Aug 2025 03:54:31 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:10 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-3-sidnayyar@google.com>
Subject: [PATCH 02/10] linker: add kflagstab section to vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

This section will contain read-only kernel symbol flag values in the
form of a 8-bit bitset.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/asm-generic/vmlinux.lds.h | 7 +++++++
 scripts/module.lds.S              | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ae2d2359b79e..310e2de56211 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -518,6 +518,13 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		__stop___kcrctab_gpl = .;				\
 	}								\
 									\
+	/* Kernel symbol flags table */					\
+	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
+		__start___kflagstab = .;				\
+		KEEP(*(SORT(___kflagstab+*)))				\
+		__stop___kflagstab = .;					\
+	}								\
+									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index ee79c41059f3..9a8a3b6d1569 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -23,6 +23,7 @@ SECTIONS {
 	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
 	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
+	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
-- 
2.51.0.338.gd7d06c2dae-goog


