Return-Path: <linux-arch+bounces-3327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14C891617
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 10:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F832879F9
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA09482E9;
	Fri, 29 Mar 2024 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcU3pgyb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F61238FA6
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704854; cv=none; b=fRiGVYmMQM4Ke23V2rzfCzOypwJafx7PsaMyRy+qULkxwFMfilTuM4PFQqBPGGuaFOVsEV8opLZSFy5rPG9CvI4+3FPVRMoFkBIFv/tTIDR8OJbKJKzlZTmX+bamFQ+K247lwvFuifrP0001IlJqee0H9ye0UCxVRAtGyh2P1tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704854; c=relaxed/simple;
	bh=YqzLsUuh++ZlBracS/PXtopG9p7kP2UzeZKBKBcMbbY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UMSEpUNS8Pw1VoiUrIKjuKJbr44EAliNeQxznEbBm/1JKVr5oetmn2iAxfAXpXWDroKPLfDBNs7+GM8lCJn9FNqjKRTcocw7vAQqWNkBqC0h8ynMSpbPiOg+9UwOQWIzUNeBlcKyjIIQXwpyGD9OWhf3uNTfN9wizFaBRnBiCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcU3pgyb; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3419f517aceso808842f8f.3
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711704850; x=1712309650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kSI+K3Sj79xTDwp3kEwJFO6zCHnVt2HEzFL8mdP9uWo=;
        b=wcU3pgybbRvCTZ1vJMWfwkW7xBg7/ga1kZvWCgcRCxQyjEVQoXHXOjjjDHHWz/xnl+
         CK48PX5YV7EKeDv8C48L2k20pe6TfywKVEVTSzGmUGMAyzfYpo+IkoDdE1Mweleo+Y7j
         N3FmaHxZZQl6jhQUx/LP+WZi0DE/gGeoHpkSPHx7e8PIrS0Rp5B/op6beWYfMiXwcZM5
         8V+nlVYg4b4F+4yz2vu71jge92y3gCLP5eHzctjUEEz82aFXmuW8NKULquHHPo/16IuU
         MTD0MUjheKHP3s8F7F7T91dTCmmRBKI16G5WGkRBCfiGKobq6gBXoy/EgeSECWFsbxkS
         FQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704850; x=1712309650;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSI+K3Sj79xTDwp3kEwJFO6zCHnVt2HEzFL8mdP9uWo=;
        b=QWEKPvCcgNhYdrL35SINtNVVD8XMik5bOkgIGFYUIRIHEK0nlvVpBXnRajWX/7ycnW
         vmYy5JcVyE03RS+Tuk6EzpdjAeLje2S0yGTPrB8bpSh7TU4oxEsMZNN/UmwOn5AL/9Ik
         w6XxVOcn7Yo3Cb08nJ0Hj0RPEsxEfXvWksTt+rZYwBNyvgGulAnw8iqyKr7MubcxyqNP
         3w9GIDfDmg4bTfc14WZRsaGE/KrXzBnc569rda22m+OcKXdoAjHQPJUpAk0Z7Baubf/O
         8UzWUssNDDJSD5Xw8OBFKKKq3mUA8vWoGYKmWY/xGuU+X/3aTyvFJaSFauy3HerdgSmG
         6sXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2+7vZA7O+GT4QOjVHemMgdpxPE41y7vkeTrQi+4Asobyg+jZeLiTPD8L1KsYPtLsRhovC4vrZ1uGYC1OLPfsIUlYqWiedDYzLBQ==
X-Gm-Message-State: AOJu0Yygz13OMzYXBWMWfgUKYBKzHFfHwMDRhd2KYEPe6J3JGM4+2Mdx
	f7GBZLGRcJ1s9qiXgeGgaVQQzgnKGyIEJLEcdgtMZcKce68Z1baSaVzuYK9hvDL57NrOFA==
X-Google-Smtp-Source: AGHT+IGcwlMy3+7hgVTbOD2Y2cNsSH8oCeqS+0FGa05sbpjsthtpwwKqM1asTqo0T9/0yAvtPJ1tq/sc
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:6a10:0:b0:343:3e4a:3e73 with SMTP id
 m16-20020a5d6a10000000b003433e4a3e73mr147wru.5.1711704849580; Fri, 29 Mar
 2024 02:34:09 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:33:57 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=ardb@kernel.org;
 h=from:subject; bh=O3B+MP1L7ukd5u8YOc4vTvrdKdbfN6TIr9UOdzn8cCc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY2tm/X8qeDsk1anEj4xy3xvMXDL+PvbzvfTVLOvZkIrt
 WZm2N7sKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOp8WNk2BrKNsf/Rvoj06Ay
 Nr7quce9uhbwTF3UumaK9qeZaxwnWjIyvBC/c3X//Vqfio13YwOnnz6X6CzX933tJmYWK453R1d b8wIA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329093356.276289-5-ardb+git@google.com>
Subject: [PATCH 0/3] kbuild: Avoid weak external linkage where possible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Weak external linkage is intended for cases where a symbol reference
can remain unsatisfied in the final link. Taking the address of such a
symbol should yield NULL if the reference was not satisfied.

Given that ordinary RIP or PC relative references cannot produce NULL,
some kind of indirection is always needed in such cases, and in position
independent code, this results in a GOT entry. In ordinary code, it is
arch specific but amounts to the same thing.

While unavoidable in some cases, weak references are currently also used
to declare symbols that are always defined in the final link, but not in
the first linker pass. This means we end up with worse codegen for no
good reason. So let's clean this up, by providing preliminary
definitions that are only used as a fallback.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: bpf@vger.kernel.org

Ard Biesheuvel (3):
  kallsyms: Avoid weak references for kallsyms symbols
  vmlinux: Avoid weak reference to notes section
  btf: Avoid weak external references

 include/asm-generic/vmlinux.lds.h | 21 ++++++++++++++
 kernel/bpf/btf.c                  |  4 +--
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 kernel/ksysfs.c                   |  4 +--
 lib/buildid.c                     |  4 +--
 6 files changed, 39 insertions(+), 30 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


