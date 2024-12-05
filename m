Return-Path: <linux-arch+bounces-9252-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2749E59FA
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 16:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3DB16A452
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4728621CA1B;
	Thu,  5 Dec 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjdi2VHY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAC218E99;
	Thu,  5 Dec 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413380; cv=none; b=H8lZzhu2urGuxrVlsQXX9eq2GqfchgdMq/jUv3TnNqVs5Mkomz9jIalt9GMyDO6pCtKMmysgHyye1OK0oYiYBUXcfYdFRBTpkosIYYp2/nsOwuxgFKZ04ixso6UrrGVKHT8RRXNtXw5TfWFmDh7gfejzYN0J4BgZUJY9slthfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413380; c=relaxed/simple;
	bh=5fJNr+uuGbzSucThB4KRt2W6mdssk1rnyKaKs1lG5TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETYncBAzq8EPO/BdkcK+fNJ1kFGuVHkLiDWKKvISfSblIsynYQwcOpploGAvOYeavrDXYds7eCuMPOrUbyvQGlcuXy0dSxHeMgkfWBRK8dcXXAqG+rF6dsmf2pkTBlcpcJEVyxFkbJi482/FPzcgWfiEWSuweL6Khv/G3C2PCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjdi2VHY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385dece873cso599283f8f.0;
        Thu, 05 Dec 2024 07:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413377; x=1734018177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm0xTA7w0trmMS63onZN9A8A0KVvItfxjJ4yazAcGOA=;
        b=Gjdi2VHYuhpwgxmzcuYW4h0DJyeUFFOGuqSwPdORwp8yuaP1VxV+GTHpm6b1PDZxfJ
         o4QF7M+hEjIgH4o4+YfeP9Uo9CSQq1XTACp4Z984l4uA8c3IHuEzUSmPVN5SXmam95cB
         42GpZJLL9m+Leo786binPMjJv6LQjauGmhdV+QIIbeLc8muRAmE3UzdNXBEyVj/s7RiL
         iGbJX5XXSk5eVjkxfT/5bRJHWdXS8/O9jtjVaZ/VDuJwlBVaQ4URkzpRkHwBTVdv2NsG
         IbwzhT23AMAqBEbvIiHer5bgKWQqyuHgt7lXwL2Bchs1KQjOZ+ih3hocFygdPZN9ePhD
         H0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413377; x=1734018177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qm0xTA7w0trmMS63onZN9A8A0KVvItfxjJ4yazAcGOA=;
        b=D3uNlChxeCL5CdBeFbHQ+bdN517Q76Ml5EXsCZxxqyTljC5H582ug6iwTEBjTOryHp
         eu6A5vi9C/+dNkwSlctnbauaiwQ9djzXN18BeOT2jfLdFfcm6K1UrzwRpfH1thQy74Dz
         Dh8VYAya1XGK80d8Cqjp0HAOLg0nKLm0kOMUcAFNqsQePa8wUt01+GwAniuNJNEfqpAo
         0CqJ6QPz5reaemSb6fSf90Mlck+KXFg50r0Ihpr8Js3HJh6dS1TwXMRGv//5FExFIHIL
         bq8/UOhwyM//8OSOm0eNsnRwprQn8qFTwlGAf5f2H+ePiiY3okJ0w8anGjHA26y/LWxC
         SPBw==
X-Forwarded-Encrypted: i=1; AJvYcCUBXIOXX+ebFQGFZh3veSBaav7BHJ3dkrwRCiib3c/ish6Y7sNlLV6STtdKh9kLwdaTYcxDHS1n1nqP3jQX@vger.kernel.org, AJvYcCV19bkoKQmbb0Mhm52MenhAuvTN9ol/JWu0jhzevaGy+SsCmuaK3Yk0Z+eyYpuW9V4jMzsIz3oz@vger.kernel.org, AJvYcCVzFPT1RG4EPPBfK7G+85wr8QpFUjeHGvbEpZHBdFCAADnlDa12izAXx7Z6gxiVbO1g/8+fecGV1mC4cj/EbcM=@vger.kernel.org, AJvYcCXm5y+t6LYSSbm8dEVq6BDjmZXEYb+DeZonNoE9vUhj0KdWG4LOVSe5EcieG9mWCuik1spDCMGidHri@vger.kernel.org
X-Gm-Message-State: AOJu0YzR864xyUtIb8U2poxxPcCaNcZPQXuD8Wy/AcOscWd7KnrWh8Ur
	8IMucr5FNiqiWKdOsmNGXbG3WGlCrJv7xQoWPKfJX0C2x4HnGjdZ
X-Gm-Gg: ASbGncvLCjGgS6rlVJM6TC5UqeQjujL81yKDeR4DYUbupxKPAPS7UHRLtsi22YGOBup
	iVs67fiw2Er7OpfNSjLDBGBVbzL7akIPIVWYXcYWLUQLEQ2sOUj6urnfetDTY86SWvId+bt+gpT
	UNmPLRi1+21mFvMi2z7lVVm0iYURY3qIJTO7K6rTBZmXqPuMkBThjod+2nTIWGpEcgjB8DWlmjS
	Utm9U9wIRGJQrx3FooMVvDI8DEoA8MZBu0sjxwAhglxhGtWmzmdOIABD+4=
X-Google-Smtp-Source: AGHT+IE1FZ5JkMJKChb9COrcHR93yKEZdHzkg3M98KstBiKvfHSE5uSF5BeN4exQl35vdPQhMGDNYw==
X-Received: by 2002:a5d:588b:0:b0:385:f114:15d6 with SMTP id ffacd0b85a97d-38607ac1ad6mr7179392f8f.13.1733413376413;
        Thu, 05 Dec 2024 07:42:56 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da11387dsm27020185e9.30.2024.12.05.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:42:56 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/6] Enable strict percpu address space checks
Date: Thu,  5 Dec 2024 16:40:50 +0100
Message-ID: <20241205154247.43444-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset enables strict percpu address space checks via x86 named 
address space qualifiers. Percpu variables are declared in
__seg_gs/__seg_fs named AS and kept named AS qualified until they
are dereferenced via percpu accessor. This approach enables various
compiler checks for cross-namespace variable assignments.

Please note that current version of sparse doesn't know anything about
__typeof_unqual__() operator. Avoid the usage of __typeof_unqual__()
when sparse checking is active to prevent sparse errors with unknowing
keyword.

v2: - Add comment to remove test for __CHECKER__ once sparse learns
      about __typeof_unqual__.
    - Add Acked-by: tags.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Uros Bizjak (6):
  x86/kgdb: Use IS_ERR_PCPU() macro
  compiler.h: Introduce TYPEOF_UNQUAL() macro
  percpu: Use TYPEOF_UNQUAL() in variable declarations
  percpu: Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors
  percpu: Repurpose __percpu tag as a named address space qualifier
  percpu/x86: Enable strict percpu checks via named AS qualifiers

 arch/x86/include/asm/percpu.h  | 38 ++++++++++++++++++++++---------
 arch/x86/kernel/kgdb.c         |  2 +-
 fs/bcachefs/util.h             |  2 +-
 include/asm-generic/percpu.h   | 41 +++++++++++++++++++++++-----------
 include/linux/compiler.h       | 13 +++++++++++
 include/linux/compiler_types.h |  2 +-
 include/linux/part_stat.h      |  2 +-
 include/linux/percpu-defs.h    |  6 ++---
 include/net/snmp.h             |  5 ++---
 init/Kconfig                   |  3 +++
 kernel/locking/percpu-rwsem.c  |  2 +-
 net/mpls/internal.h            |  4 ++--
 12 files changed, 84 insertions(+), 36 deletions(-)

-- 
2.42.0


