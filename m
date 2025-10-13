Return-Path: <linux-arch+bounces-14044-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BADBD4C96
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A2194F9AB3
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCDF311592;
	Mon, 13 Oct 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="it2pL4kr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDA3112DF
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369987; cv=none; b=M+Erk1KNa7S9egqChvh90DMmkQvUQtnm0VIqvk6oXgokcQDijoFc805NRHvNRoLUfA84/6zTw7AP1IUTaFJEyA48Qu2RomdYkSsqJhNTMs/r+PQPCzGLKA4Zq6C1hWtjwDn39dFymcMEUpZM2Lng/mPJnBrU8TTImTogOi0oe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369987; c=relaxed/simple;
	bh=zQmTVOaQ2conlnD0XZSZ6oY7jQQ4SJUuOz94+kxZw5Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KgBU8qfXoBzY0w91it8zeXFQEgzz6uPL7wTzTmrlt4XwawE3LOfhtaGaEhQubfXSCH9KN9zDB/rUiUTXgKPM2j0rxAtWQr/W0L+ZUZ0TNEkoa6XutcHXR/dLxqYnnw7Gd2+kb5ia0K+T/UTfPr6H9W0fClWgpr/rAoKADC9nB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=it2pL4kr; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso3533411f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369983; x=1760974783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DezCksN63P76aa8HtfW+Fd8qwQxc2N6lFBI0VjqaVgQ=;
        b=it2pL4krxHIWQJiQ6bR2s8LijadLgzoLpCZ93iZK0nvkyQtYRC+3iJd5acMpEpO+2B
         bZOxlIsim/vhY+lUWnOoFkp74q4YFDp06xTN35GZwrlBg1/41H7x5S5jQ0aMraelEoZo
         692mUDSxDGITv5T74Ivjf915j56ZEEZWgp9iM2td2vaN/2QRPZJnDMgTe2aN1utTwsXz
         /VyxjtEuJWYliSWZkLdnn624ZecimmU1xYF9LkJKyYPM2doI9McfWF0xJhLtwit4DX7Z
         XjLvdRgUE26LoME7bxyvwjMAHZvYbc40+nLddyNcL1mpw7o/7Twv/j0ZSyZd5xjylOMw
         iCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369983; x=1760974783;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DezCksN63P76aa8HtfW+Fd8qwQxc2N6lFBI0VjqaVgQ=;
        b=cbkX3cT2vmLYdjdf+iiZZvtddsuZiXYYCItIcnUdfNc5VN1XyxMHzP3qI3jQjHHKMN
         umaTMbxBnUpaWGo46vwZ6iVnTEescWZBTI+8ZBffhq5Fg/SAClkix1GNfTQ65BB0rcFw
         buvT/JkO/iiyUJGxaEhl8TcNOCcZcvIA2HJKcaoYtFZA9K/R20t2tldS9xj1/qI6GjNO
         52jUDHRy20PSHs87sHwVhLyyB7VRGYxucwQ2/jbKJDxht/f0DT3/DvKbUXeK1I9d7rmA
         ZDIVM6v2pj5x+rywOO20vggv3nk11/Fns/W9XmNWi0XhiAwvwDiCdKl5HIEgIPWUCgtb
         68lg==
X-Forwarded-Encrypted: i=1; AJvYcCXqIJ2dOhISxkO4qlOETG/0ftto4qCgr+y3mQ7iF+KZKFdJvMtRbIsj+GFZKdkspEYmcO4/z0XQ+omU@vger.kernel.org
X-Gm-Message-State: AOJu0YxihkrvVLWTwyowxMg1DHeurog+WjMp5KLJ8sWFc2f6yAr0G5b8
	s/yWbZCvKOakK0hrRZWzE1qNmfKVkKpM1kA0PG0G6z9iRtw8rCXh76HwLjVs+hZ91vIyk4l6vl8
	dJADUtNvDDs5DvWSobw==
X-Google-Smtp-Source: AGHT+IHT9D8nobwVH6g+HgY0QG4zVcAjf8Z0CihPbisBYc1GTcqFHPtDQkugsLoIe+WAtFs/dhifTn8tMXvfHZY=
X-Received: from wror14.prod.google.com ([2002:adf:f10e:0:b0:425:f04a:4d95])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6f04:0:b0:426:da92:d3a9 with SMTP id ffacd0b85a97d-426da92d584mr5857129f8f.46.1760369983567;
 Mon, 13 Oct 2025 08:39:43 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:08 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-1-sidnayyar@google.com>
Subject: [PATCH v2 00/10] scalable symbol flags with __kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

This patch series implements a mechanism for scalable exported symbol
flags using a separate section called __kflagstab. The series introduces
__kflagstab support, removes *_gpl sections in favor of a GPL flag,
simplifies symbol resolution during module loading, and adds symbol
import protection.

Thank you Petr Pavlu for their valuable feedback.

---
Changes from v1:
- added a check to ensure __kflagstab is present
- added warnings for the obsolete *_gpl sections
- moved protected symbol check before ref_module() call
- moved protected symbol check failure warning to issue detection point

v1:
https://lore.kernel.org/all/20250829105418.3053274-1-sidnayyar@google.com/

Siddharth Nayyar (10):
  define kernel symbol flags
  linker: add kflagstab section to vmlinux and modules
  modpost: create entries for kflagstab
  module loader: use kflagstab instead of *_gpl sections
  modpost: put all exported symbols in ksymtab section
  module loader: remove references of *_gpl sections
  linker: remove *_gpl sections from vmlinux and modules
  remove references to *_gpl sections in documentation
  modpost: add symbol import protection flag to kflagstab
  module loader: enforce symbol import protection

 Documentation/kbuild/modules.rst  |  11 +--
 include/asm-generic/vmlinux.lds.h |  21 ++----
 include/linux/export-internal.h   |  28 +++++---
 include/linux/module.h            |   4 +-
 include/linux/module_symbol.h     |   6 ++
 kernel/module/internal.h          |   5 +-
 kernel/module/main.c              | 112 +++++++++++++++---------------
 scripts/mod/modpost.c             |  27 +++++--
 scripts/module.lds.S              |   3 +-
 9 files changed, 120 insertions(+), 97 deletions(-)

-- 
2.51.0.740.g6adb054d12-goog


