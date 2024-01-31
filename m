Return-Path: <linux-arch+bounces-1890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F610843A2E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECBA1F23791
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131B74E21;
	Wed, 31 Jan 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iS1Q3yGD"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62871B34
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691651; cv=none; b=OewDQGf6jmD5TQKfNotF2ow50X4vSbEEeDIUc+sJrCWjzylNWj2v/dEyhgIiZDpzb5q0zxjSnWCvpHsLac7+MmlsrmihhJYEDBkHpfp/qFn+37gVQi2y/2r2efq2LxXg0xKgufq2d5jgySiwTlp/GqKpl0cGD/I/hpNvyr7mQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691651; c=relaxed/simple;
	bh=WbPXvYbo7DOiKDMradZ/IJwGvEXKxgPGiqlaS/fimcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6X6hs2ecJrskYuOG9+thUU4hfWZE5mZ5uVh45RJfEZswFWwhihZ+XBo8mb427L7fAqPdIXA64fqDp1IduhxsAaoKtcNSA5+69XsWD6GS/KYJnkRbztUF5shl1jdaf8cecff2BRTSwfOCxjHLIxqWnhvhDJgaDCgPeUFHwxUiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iS1Q3yGD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706691649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YpiKUVItyUOZNWxnS77CJhTEKvHG8IwJ6DmqwnzX9Bg=;
	b=iS1Q3yGD9xAKqiNwWAxbHFtVmhM4tvRnWOiks0BLvQYdvSAUXwWozejgpq+MjqlVtesD9J
	hd9Jgp+J4OOIctuebZ2NyExgjbKqygLn1VHNdDveQehdavkzaCsxWRX+3rMfnfHpH5of5R
	rQQTCUmAx4x+LSHvYMX2OBmLUmj7yN4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-Gbu51V5IPNCF1A6skfL4qQ-1; Wed, 31 Jan 2024 04:00:46 -0500
X-MC-Unique: Gbu51V5IPNCF1A6skfL4qQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ae2dd7d4aso119433f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 01:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691645; x=1707296445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpiKUVItyUOZNWxnS77CJhTEKvHG8IwJ6DmqwnzX9Bg=;
        b=AK43L9IjCYyTrPld6zGeJo4f8S/NR+F9vaNSs9EsWiYyWGVIG0Wyu1jQuxDzBvqPsd
         4M43JbB1Y4Cuzi8XXr+D8WSaHtINvNwXkFTemZB9OcZM0/KJvD3p3F2T7u1ePNDv4O//
         XveEtE6CQFa+Rtg8RW0w1HmjjhQZhCOtG2DWyAtXeszR6wpgtg7ODO9PPXEoslmE1gCX
         PpQaq/MhoyBy1FBzZ5ChkFlw3/voLoY1cTEEqEfJn8Hr1GY1CCvV39yVxHLJMqLESzqJ
         WHufVcbJGzMPIqiGhYMLDrEeQqxFc0ulJEoUCLAhVTFzXjDDv3ZPx9HtVIvJ9o+8FNPh
         kBQA==
X-Forwarded-Encrypted: i=0; AJvYcCXJQRxQUwnSUSmv8ZBWmuS/XxXhqB3zmKnaxHFRDaSXEnm8rzAO9X+6yM8mwwQokkKk9tfuFb45VykqBlMrpM45L7DGOiRJEmDbMQ==
X-Gm-Message-State: AOJu0Yzb8Bnw3YRfOR/zHj1uztk4SNTRQJozS19ue8Nrjfnoa1SBWOF3
	JIBmKpkre3acMCZ2y3EHgcg8ViE3UnlgDNpoVeWdkO2sb7hkFemy215SEGO9VgECQ7rvPfVV/Q7
	tIsp02J2CL3bLqyxE8sTqwGyKR8MH8QDydn+l1kgb4JKEtsRnzglbf89llqU=
X-Received: by 2002:a05:600c:6003:b0:40e:eab6:f33f with SMTP id az3-20020a05600c600300b0040eeab6f33fmr749108wmb.3.1706691644847;
        Wed, 31 Jan 2024 01:00:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMnYKqFE00aeqRVpLyd4XJIWP3xUf0t9c+CMIPSvwL/karnsDc7bjq3jQzxlCPquPDLWZLnw==
X-Received: by 2002:a05:600c:6003:b0:40e:eab6:f33f with SMTP id az3-20020a05600c600300b0040eeab6f33fmr749072wmb.3.1706691644431;
        Wed, 31 Jan 2024 01:00:44 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040ee51f1025sm940261wmq.43.2024.01.31.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:00:44 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6 0/4] Regather scattered PCI-Code
Date: Wed, 31 Jan 2024 10:00:19 +0100
Message-ID: <20240131090023.12331-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@Stable-Kernel:
You receive this patch series because its first patch fixes a leak in PCI.

@Bjorn:
I decided that it's now actually possible to just embed the docu updates
to the respective patches, instead of a separate patch.
Also dropped the ioport_unmap() for now.

Changes in v6:
- Remove the addition of ioport_unmap() from patch #1, since this is not
  really a bug, as explained by the comment above pci_iounmap. (Bjorn)
- Drop the patch unifying the two versions of pci_iounmap(). (Bjorn)
- Make patch #4's style congruent with PCI style.
- Drop (in any case empty) ioport_unmap() again from pci_iounmap()
- Add forgotten updates to Documentation/ when moving files from lib/ to
  drivers/pci/

Changes in v5:
- Add forgotten update to MAINTAINERS file.

Changes in v4:
- Apply Arnd's Reviewed-by's
- Add ifdef CONFIG_HAS_IOPORT_MAP guard in drivers/pci/iomap.c (build
  error on openrisc)
- Fix typo in patch no.5

Changes in v3:
- Create a separate patch for the leaks in lib/iomap.c. Make it the
  series' first patch. (Arnd)
- Turns out the aforementioned bug wasn't just accidentally removing
  iounmap() with the ifdef, it was also missing ioport_unmap() to begin
  with. Add it.
- Move the ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT-mechanism from
  asm-generic/io.h to asm-generic/ioport.h. (Arnd)
- Adjust the implementation of iomem_is_ioport() in asm-generic/io.h so
  that it matches exactly what pci_iounmap() previously did in
  lib/pci_iomap.c. (Arnd)
- Move the CONFIG_HAS_IOPORT guard in asm-generic/io.h so that
  iomem_is_ioport() will always be compiled and just returns false if
  there are no ports.
- Add TODOs to several places informing about the generic
  iomem_is_ioport() in lib/iomap.c not being generic.
- Add TODO about the followup work to make drivers/pci/iomap.c's
  pci_iounmap() actually generic.

Changes in v2:
- Replace patch 4, previously extending the comment about pci_iounmap()
  in lib/iomap.c, with a patch that moves pci_iounmap() from that file
  to drivers/pci/iomap.c, creating a unified version there. (Arnd)
- Implement iomem_is_ioport() as a new helper in asm-generic/io.h and
  lib/iomap.c. (Arnd)
- Move the build rule in drivers/pci/Makefile for iomap.o under the
  guard of #if PCI. This had to be done because when just checking for
  GENERIC_PCI_IOMAP being defined, the functions don't disappear, which
  was the case previously in lib/pci_iomap.c, where the entire file was
  made empty if PCI was not set by the guard #ifdef PCI. (Intel's Bots)
- Rephares all patches' commit messages a little bit.


Sooooooooo. I reworked v1.

Please review this carefully, the IO-Ranges are obviously a bit tricky,
as is the build-system / ifdef-ery.

Arnd has suggested that architectures defining a custom inb() need their
own iomem_is_ioport(), as well. I've grepped for inb() and found the
following list of archs that define their own:
  - alpha
  - arm
  - m68k <--
  - parisc
  - powerpc
  - sh
  - sparc
  - x86 <--

All of those have their own definitons of pci_iounmap(). Therefore, they
don't need our generic version in the first place and, thus, also need
no iomem_is_ioport().
The two exceptions are x86 and m68k. The former uses lib/iomap.c through
CONFIG_GENERIC_IOMAP, as Arnd pointed out in the previous discussion
(thus, CONFIG_GENERIC_IOMAP is not really generic in this regard).

So as I see it, only m68k WOULD need its own custom definition of
iomem_is_ioport(). But as I understand it it doesn't because it uses the
one from asm-generic/pci_iomap.h ??

I wasn't entirely sure how to deal with the address ranges for the
generic implementation in asm-generic/io.h. It's marked with a TODO.
Input appreciated.

I removed the guard around define pci_iounmap in asm-generic/io.h. An
alternative would be to have it be guarded by CONFIG_GENERIC_IOMAP and
CONFIG_GENERIC_PCI_IOMAP, both. Without such a guard, there is no
collision however, because generic pci_iounmap() from
drivers/pci/iomap.c will only get pulled in when
CONFIG_GENERIC_PCI_IOMAP is actually set.

I cross-built this for a variety of architectures, including the usual
suspects (s390, m68k). So far successfully. But let's see what Intel's
robots say :O

P.


Original cover letter:

Hi!

So it seems that since ca. 2007 the PCI code has been scattered a bit.
PCI's devres code, which is only ever used by users of the entire
PCI-subsystem anyways, resides in lib/devres.c and is guarded by an
ifdef PCI, just as the content of lib/pci_iomap.c is.

It, thus, seems reasonable to move all of that.

As I were at it, I moved as much of the devres-specific code from pci.c
to devres.c, too. The only exceptions are four functions that are
currently difficult to move. More information about that can be read
here [1].

I noticed these scattered files while working on (new) PCI-specific
devres functions. If we can get this here merged, I'll soon send another
patch series that addresses some API-inconsistencies and could move the
devres-part of the four remaining functions.

I don't want to do that in this series as this here is only about moving
code, whereas the next series would have to actually change API
behavior.

I successfully (cross-)built this for x86, x86_64, AARCH64 and ARM
(allyesconfig). I booted a kernel with it on x86_64, with a Fedora
desktop environment as payload. The OS came up fine

I hope this is OK. If we can get it in, we'd soon have a very
consistent PCI API again.

Regards,
P.

Philipp Stanner (4):
  lib/pci_iomap.c: fix cleanup bug in pci_iounmap()
  lib: move pci_iomap.c to drivers/pci/
  lib: move pci-specific devres code to drivers/pci/
  PCI: Move devres code from pci.c to devres.c

 Documentation/driver-api/device-io.rst |   2 +-
 Documentation/driver-api/pci/pci.rst   |   6 +
 MAINTAINERS                            |   1 -
 drivers/pci/Kconfig                    |   5 +
 drivers/pci/Makefile                   |   3 +-
 drivers/pci/devres.c                   | 450 +++++++++++++++++++++++++
 lib/pci_iomap.c => drivers/pci/iomap.c |   5 +-
 drivers/pci/pci.c                      | 249 --------------
 drivers/pci/pci.h                      |  24 ++
 lib/Kconfig                            |   3 -
 lib/Makefile                           |   1 -
 lib/devres.c                           | 208 +-----------
 12 files changed, 490 insertions(+), 467 deletions(-)
 create mode 100644 drivers/pci/devres.c
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

-- 
2.43.0


