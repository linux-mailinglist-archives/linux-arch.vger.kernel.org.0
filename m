Return-Path: <linux-arch+bounces-14479-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE7C2D125
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A7C188CFE7
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1C031771E;
	Mon,  3 Nov 2025 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rj09nGBa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC373164A0
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186805; cv=none; b=AenodqwI0mQAXu1z587xaTWQSUxn2dY/8h443VnpCXcWTUGyFGcG7eJsbksusmAe/MmzM5A6KMDTjKxR78iAo0aFf2cnBygcFet0iwLN3rGziS4EaTqp1Ue2mbZeAkNYSYCHCKpDJaR4+4S3RW6/LOVn+qGkOc1vLv36Ni3snzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186805; c=relaxed/simple;
	bh=h7R/k1MMSVPQfBxt0pvy0030CquRgbNXX1VOTDMoaIQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I90rDueCg4xC2KkVcmXjzKrjgGdecDEBB8RSv11DhdYlRSRPMdmp5bTON2iQ/mT1hohMShY9mYBsgKsN+iUlyI+SC9+8lcWQZ8TX9h5dA19MThB9ZBlzdohfYMKzX/GB51M4tse1XezUnG9gZtj2Gx23noq89iMs4JvKeG5GNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rj09nGBa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47717c2737bso17823905e9.2
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 08:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186802; x=1762791602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W8tTM2uCb0zl0k898LdIZTakN1ZygKd+3CMbo77PL78=;
        b=rj09nGBaFeX9xJxGNhVti1JlVGg35iSsZj581DpbIM5CayFWU0a8FRWSK4VebK7qHu
         Ux+y7H3SBxbIMMw9l7HyhN7Ptva2mSJhoC1VSqLuECr8c9NxHO9OT24T4rssf+DC3l4s
         wG/3HPFQP1bi+Nm1IMlehvS1erGMmZ1i8AlRbxXVxR0SuoaVwJ9avqqZTTYVgNf4z8+c
         X0kE/cWi2A52pNCxV6BG9vfj49Ss8qMjosifq2Sa8P6+wD4YW0jhh7Os4pN8CLUXbfjq
         4Z10drFG4KKLrxMdHOK+CXi44cRaLGDIecz3PkEHdqJnO616SPjAVuVmtTFqYEOqhzOm
         1axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186802; x=1762791602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8tTM2uCb0zl0k898LdIZTakN1ZygKd+3CMbo77PL78=;
        b=nzq6sJ+5Retz4E3lgPmuwMqDuWI+N8PjJP1HhbSBKPoB4up7s+oWqeArospUMzSUo4
         7F81ctjtLjMOS8AdBMP4W8kBAw07eRWfHbI8p5U1ipmiUcejsn6efz0LuCPx90kewxEn
         dS48VOy16lUvVdnjDtXovCiqLdflc5REK6B9waIWNGDoTt5wtPqk/5BGoYDGirk2hRFl
         OB/Bq5Zsf3dfWD9VNyeL5nxA5g11Je4qVoNogDrl3maOCovc181Ah8TxHDAxLR80NM4H
         7j3j/A90t9geui/eIQHIDDiAxbCPPIgt+y/JHz1Xr7p39aDCaU1SJL+9CCIuFiWWQBFP
         UYuA==
X-Forwarded-Encrypted: i=1; AJvYcCWSTIobNFD1EROWjSX7AwKhp/nbe1u8Z2G1thpU6SvOYvMrG3RZf0OnDE8qzS8ANQcDVJqOGlLWGNda@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+iuUA0ayCjn1w7bCntnW7oix1xr7KIlAx+DswWkhSS7r768gq
	dFGEl0tTxAhH8GLF2gnwS+HeaHJBPEyf3tWCEhDoip++oqHcprLm2QNOoGpl3nyWRRTX6+r/hoH
	VZD9omT3cMBwHC1d1QA==
X-Google-Smtp-Source: AGHT+IEbhSxEl23KciUSXJmUxlryd+9/wkj5PORgK0VgJEd3vZvStNFYMjkCuoAO6A/1vErUZgMsibakSlGcVNc=
X-Received: from wmwn6.prod.google.com ([2002:a05:600d:4346:b0:477:3fdf:4c28])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b30:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-477429d8ee4mr73769555e9.30.1762186802499;
 Mon, 03 Nov 2025 08:20:02 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:46 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-1-sidnayyar@google.com>
Subject: [PATCH v3 0/8] scalable symbol flags with __kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

This patch series implements a mechanism for scalable exported symbol
flags using a separate section called __kflagstab. The series introduces
__kflagstab support, removes *_gpl sections in favor of a GPL flag,
simplifies symbol resolution during module loading.

This series previously added symbol import protection which aims to
restrict the use of "protected symbol" exported by vmlinux, as a use
case for which __kflagstab is being introduced. Such symbols are only
allowed to be imported by signed modules when symbol protection is
enabled. This functionality requires more thought and discussion [1],
and therefore I will create a separate patch series for it. In the
meantime, this series now only focuses on introduction of __kflagstab
which right is an improvement to the module loader's code health [2].

Thank you Petr Pavlu and Jonathan Corbet for their valuable feedback.

---
Changes from v2:
- removed symbol import protection to spin off into its own series

v2:
https://lore.kernel.org/20251013153918.2206045-1-sidnayyar@google.com/

Changes from v1:
- added a check to ensure __kflagstab is present
- added warnings for the obsolete *_gpl sections
- moved protected symbol check before ref_module() call
- moved protected symbol check failure warning to issue detection point

v1:
https://lore.kernel.org/20250829105418.3053274-1-sidnayyar@google.com/

[1] https://lore.kernel.org/cac5ed5e-3320-4db0-99d8-ea5e97e56bfb@suse.com/
[2] https://lore.kernel.org/2bf54830-ea9c-4962-a7ef-653fbed8f8c0@suse.com/

Siddharth Nayyar (8):
  define kernel symbol flags
  linker: add kflagstab section to vmlinux and modules
  modpost: create entries for kflagstab
  module loader: use kflagstab instead of *_gpl sections
  modpost: put all exported symbols in ksymtab section
  module loader: remove references of *_gpl sections
  linker: remove *_gpl sections from vmlinux and modules
  remove references to *_gpl sections in documentation

 Documentation/kbuild/modules.rst  |  11 ++--
 include/asm-generic/vmlinux.lds.h |  21 ++----
 include/linux/export-internal.h   |  28 +++++---
 include/linux/module.h            |   4 +-
 include/linux/module_symbol.h     |   5 ++
 kernel/module/internal.h          |   4 +-
 kernel/module/main.c              | 102 ++++++++++++++----------------
 scripts/mod/modpost.c             |  16 +++--
 scripts/module.lds.S              |   3 +-
 9 files changed, 99 insertions(+), 95 deletions(-)

-- 
2.51.1.930.gacf6e81ea2-goog


