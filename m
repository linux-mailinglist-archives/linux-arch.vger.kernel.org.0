Return-Path: <linux-arch+bounces-14480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA881C2D12E
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9485188C19B
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19503318155;
	Mon,  3 Nov 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJu4fRlT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C031691D
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186806; cv=none; b=VoLrYaTKLLFyzTr+ujR0GIa2Am0Xl/QTlWAcgJeuBq0FGNI1eQE0W+8eVSrLq2iynUM1I2mZ6+99HrBU1g6tYm5L0JXKGv3C7ztru0JFqbL8YPLpUBwPOhol8gomFS2d0M/739YdvFTMrMo2Ekxp3NINgYrBrcMOFelaDduIzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186806; c=relaxed/simple;
	bh=/5wAYAreFX43kAUmx0C0owVCwGfgfUmGJQjEtp5PpmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDxCYFmrUSlKMGspjpdUplnQH10N0xKeuXsyRGWOPofVRwKKurPpXG+EfRSMgQ16ImpwJmGdUCvhlYNdpubR1OpxX6xo9xj91/yryBjRIteGtNOBq7gqxS6BgmtSBUC/WmniLe/KHQ9iC0tBrZ7tb0lo63j1yfhYWYfE+JWVQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJu4fRlT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47113dfdd20so20670045e9.1
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 08:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186803; x=1762791603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftIFzkEm1zjsUR3x20qQ2ikS9QsKBzHYJMroz5LF+Dc=;
        b=UJu4fRlTIAtrZ7NFRQwUJeBxNsfxMBET1Qvx9Ec2jMjSfb3X2AUQHuN0/H2xcOTlem
         0J3ixvJSyFWjTrdhHfrL97EyhLoSmR7lHpB5h8ThvVM7Dr0CDYUe5DJot1+I1/bWdb6i
         /dIgQmXayRmHP5g8xmOiXMS81VJXH2MRS8NU3MPRalTPGIMbdqK1VYkyLzK+ZXAu2aMz
         D8voxAOBBqZAVdgMJzuU8wNxXNgQ4sEAsW49Tf3EtAheFRYutjyBZuyJkOQfoxY2/9Ur
         /4w5lVkHEpuM7mzFy7cP6v2J6EM2ss+FjdlwAJb/31yvD7l1q32P2LX8q6y1LOd/z6F6
         vPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186803; x=1762791603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftIFzkEm1zjsUR3x20qQ2ikS9QsKBzHYJMroz5LF+Dc=;
        b=Pwm7VXnS+MNi3NZ+n/Lfe6F3/E3iEo70wB0HxaRZ8PlbD8uNOwpkLGc4Uyk+Na8otL
         Wto1pg9aNR8PoK3/rpoWE9EXPvX/TZwpcqLFiPO4TNaaY/oq2yt+NKWUTU60RttQYjGg
         5PhQP5+Dh0TMsM2lbFfmBDanfk8TMbaZ+b73NYbWlsmY6GZs5mgceZbERJwUUKE2bI7v
         krWffwObgZkXHU/eWjhpPBBmoS1Jlxk0kHtTVogoOx9/KLWcYWEyRJUaiBYFTcMDk/O6
         D8t6QvynM6IpygfAPHSO+WODaX3W5uqSXQWtn2POSjxxm+1/o4dECsTatKm8dJUzTzcG
         Dkgw==
X-Forwarded-Encrypted: i=1; AJvYcCW2/sfLcl8qen+LaZXZA3qsVfLduEDXjzhCYJPTAokiapEAsIiKxyRH96jrLBx7/TiXRoQvV4dVadyb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76ODHHSuhC+iLEoyVtmhLcRS4YPrPuOAvfLh6nhe72dSf54nS
	H1jmDyN1lz5D4ZzdC7VmpF+6AdOQnojNaMCB7O3wspnJCMsscY0HJWcA+QJtEVKRgEPE3AD2CbM
	cB4YqnR2UBCam50bQgg==
X-Google-Smtp-Source: AGHT+IGECLnp+Wa6r4Tdn5YaQ0l1JnV9PG0t+Gh1GDl+yBw8QkV/OxuaBN7aNEBYUrBG8kD7+TwvFiS8NMYrRcQ=
X-Received: from wmkn22.prod.google.com ([2002:a7b:c5d6:0:b0:476:9bb8:201b])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524e:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4773089c6a2mr132957575e9.32.1762186803282;
 Mon, 03 Nov 2025 08:20:03 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:47 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-2-sidnayyar@google.com>
Subject: [PATCH v3 1/8] define kernel symbol flags
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

Symbol flags is an enumeration used to represent flags as a bitset, for
example a flag to tell if a symbols GPL only.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module_symbol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 77c9895b9ddb..574609aced99 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -2,6 +2,11 @@
 #ifndef _LINUX_MODULE_SYMBOL_H
 #define _LINUX_MODULE_SYMBOL_H
 
+/* Kernel symbol flags bitset. */
+enum ksym_flags {
+	KSYM_FLAG_GPL_ONLY	= 1 << 0,
+};
+
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
 static inline bool is_mapping_symbol(const char *str)
 {
-- 
2.51.1.930.gacf6e81ea2-goog


