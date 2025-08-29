Return-Path: <linux-arch+bounces-13327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A66B3B95C
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F812188D852
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F433112AB;
	Fri, 29 Aug 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tlxk/oXq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7725430FF13
	for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464874; cv=none; b=qLGL9xySweIW5ABo8Phy+Cs75p+oUIWHw4BlKmmTuG6QooUT8mXiuerAX9nn2sDprLeoVfk0hA1bEwzoNOb1JurkBN5ckfN9PX3HqGSF5VrHYi1s5wNEGuO5RS8/KmR0B7+nAw///MfmPDUqNlSpdjdDHWy5cer6Bpp4s29dlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464874; c=relaxed/simple;
	bh=/4lgxBFBXe5YAPib3n1NIP7CqiEc2ADQutfeyO4Ql5Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XK0sNNHM0zVZe2xov377BqVFxRd5jg5h+AXn+A7/F6996EJRq6cBJ+wzU2AEhdIzzQE/7LaG/zyIG2JX4c80GrwUcXPB4MPlkyL1tPdikJgNZwBrWwTfvxohuveh/Xo+tcWJ3sInoC9tZVYjsSPsEEhkmHdV1vSGw1RtxHg9a0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tlxk/oXq; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61c6d735f25so1812545a12.0
        for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464871; x=1757069671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MTstZdg+IFpEL06up0r6KWAqHR4urEga4onDvlcfI9I=;
        b=Tlxk/oXqaA/SneN6knomc8fsvNcga4X6Yhq6+UcMP8Tt1ItQtRroOBzY6uq7ZMkQYN
         qbcanDWyURXrYnNFZQk8d76UUjd919J+dt4VR41bAhemSEoZet9FmdIY5rOh0GdaSzli
         rsoZRMmvJFLi0KdWpoWnaFz2cqM6jriDJ7A4q7caJzSshLtISxfwOA/bhJpXb5lZw2Z7
         Ny9ZfmFm/+3FC/bPpWItmENNtK2XIWJ15BfRIkVPC8zWVed2zvARgdkiiA6s9oLVx7op
         TZATy3h/W2k1qWXO1Wk50FTdQ7P+drouKk/vwOrm0hZI3w7pOzGm+XXMXbFZCjrb8DeK
         vV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464871; x=1757069671;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTstZdg+IFpEL06up0r6KWAqHR4urEga4onDvlcfI9I=;
        b=HVudjCBc33Hl8jijpOw43HGojgo1j4NOuUzi8dK06pgIumPjB03szJy2BbiepwYZK7
         q9rBl4E6LYkcVlSfr9hZaEWDNaiFA3afW4K4ZHOdhXRk9ei1FsVYviUpnvJhSagsxQBB
         eagIVpjxwVmukM8tqp/FlCzZUNPLr5MP8HE4MPmHawpX6oQ5d2tJkC5R5XGwL1G92iTX
         IUb61APuacIhEVJQ/6mJA+2/0LqC0ujmzdSj92+YdIyg7jUvzxW6T5s1HdTmoRJw8rrR
         jv0kS/CXShMJ0bssAsx7pBwPQ4QxeCFwwRAGkwde7L24x8tnSPcZ149hdwc18TA+R6r9
         BSpA==
X-Forwarded-Encrypted: i=1; AJvYcCXmDIAk1aFMjX0tbw1fYoawl7K0P7PlrRE9U7UiC/Kjji7HGyUvQWOuDpc/+1YehfpeonAc1p4pZahF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rnI+6ug4QoJw+MZyMjn7xdl9jW8voFXKdQ5UJeudEIi4HeP/
	etBoCJ/8aR6LEwyu/MCzBT62B5o51EDH4ZAfUWfWwJye6b2cZVNVQY81GzPMAHtMSEliTkbT2+G
	vdFLztp3I+ilZezQ4Vw==
X-Google-Smtp-Source: AGHT+IGyBZPYAxC2QPneWYAvzHS6WMIz8B1nFWUJPBrnRl3yjjUsDZG3jLzbCQ+RMfQCg25v3V4Tuq3Js9lkLiA=
X-Received: from edf12.prod.google.com ([2002:a05:6402:21cc:b0:61c:f8dd:a29])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5c8:b0:61c:d4c2:bcfc with SMTP id 4fb4d7f45d1cf-61cd4c2c9aamr4614283a12.18.1756464869977;
 Fri, 29 Aug 2025 03:54:29 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:08 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-1-sidnayyar@google.com>
Subject: [RFC PATCH 00/10] scalable symbol flags with __kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

This patch series proposes a new, scalable mechanism to represent
boolean flags for exported kernel symbols.

Problem Statement:

The core architectural issue with kernel symbol flags is our reliance on
splitting the main symbol table, ksymtab. To handle a single boolean
property, such as GPL-only, all exported symbols are split across two
separate tables: __ksymtab and __ksymtab_gpl.

This design forces the module loader to perform a separate search on
each of these tables for every symbol it needs, for vmlinux and for all
previously loaded modules.

This approach is fundamentally not scalable. If we were to introduce a
second flag, we would need four distinct symbol tables. For n boolean
flags, this model requires an exponential growth to 2^n tables,
dramatically increasing complexity.

Another consequence of this fragmentation is degraded performance. For
example, a binary search on the symbol table of vmlinux, that would take
only 14 comparison steps (assuming ~2^14 or 16K symbols) in a unified
table, can require up to 26 steps when spread across two tables
(assuming both tables have ~2^13 symbols). This performance penalty
worsens as more flags are added.

Proposed Solution:

This series introduces a __kflagstab section to store symbol flags in a
dedicated data structure, similar to how CRCs are handled in the
__kcrctab.

The flags for a given symbol in __kflagstab will be located at the same
index as the symbol's entry in __ksymtab and its CRC in __kcrctab. This
design decouples the flags from the symbol table itself, allowing us to
maintain a single, sorted __ksymtab. As a result, the symbol search
remains an efficient, single lookup, regardless of the number of flags
we add in the future.

The motivation for this change comes from the Android kernel, which uses
an additional symbol flag to restrict the use of certain exported
symbols by unsigned modules, thereby enhancing kernel security. This
__kflagstab can be implemented as a bitmap to efficiently manage which
symbols are available for general use versus those restricted to signed
modules only.

Patch Series Overview:

* Patch 1-8: Introduce the __kflagstab, migrate the existing GPL-only
  flag to this new mechanism, and clean up the old __ksymtab_gpl
  infrastructure.
* Patch 9-10: Add a "symbol import protection" flag,
  which disallows unsigned modules from importing symbols marked with
  this flag.

This is an RFC, and I am seeking feedback on the overall approach and
implementation before moving forward.

Thanks,
Siddharth Nayyar

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

 Documentation/kbuild/modules.rst  |   6 +-
 include/asm-generic/vmlinux.lds.h |  21 +++----
 include/linux/export-internal.h   |  28 ++++++---
 include/linux/module.h            |   4 +-
 include/linux/module_symbol.h     |   6 ++
 kernel/module/internal.h          |   5 +-
 kernel/module/main.c              | 101 ++++++++++++++----------------
 scripts/mod/modpost.c             |  27 ++++++--
 scripts/module.lds.S              |   3 +-
 9 files changed, 107 insertions(+), 94 deletions(-)

-- 
2.51.0.338.gd7d06c2dae-goog


