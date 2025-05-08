Return-Path: <linux-arch+bounces-11873-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1374DAB017F
	for <lists+linux-arch@lfdr.de>; Thu,  8 May 2025 19:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC953BB430
	for <lists+linux-arch@lfdr.de>; Thu,  8 May 2025 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169F92135A4;
	Thu,  8 May 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="NmrWcQOn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C920F066
	for <linux-arch@vger.kernel.org>; Thu,  8 May 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725539; cv=none; b=TiJHMOlv4wd+/PkHvYVLsUpI7ZJTdfLaKAtKYjf0iyJUH1IZzKtKSpMUHnh1tacI8P9rrlcICXmVCZsFHft7IOt8z/WhQLY7Ig/EleHGkt+MPYU4BtUY2M3JOJkEr29SZHalpM3Hhi7U5xBk3JX8RBnznKxx4SXA9Pb+9J8Fl/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725539; c=relaxed/simple;
	bh=Czoa04WdZHAxDxPaTXnsEJ/wALLQLIdenMBRznAZXqs=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=W7pRnxNNmS8jG8b46g6hZNAYSiABDUCGH6Yo/mz0ySiYNWYfkPqc7vHlI3d2J5bJOTldTmS28Rp+90wqZxN6YkRg0eEcv3bBV0MXB+hC/hXyVbALtTwbShbFJlEj749WdYSuI1D2CyjhV3km+RTQbZvApFBFIbpx0l9g/nGdcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=NmrWcQOn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227b828de00so13853965ad.1
        for <linux-arch@vger.kernel.org>; Thu, 08 May 2025 10:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1746725535; x=1747330335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPMbNxc43AcR45VhaO0+Mz0+fFeHkW9XaM5DPtDrlDo=;
        b=NmrWcQOnrtLr3g3nQhX++vcFyXlVGVwSJ+YCF8etoVJIStbDOpNABHSQlvQzyuFkAe
         N4EHPGL18J44/FXxysimKh6WJIV8xlGK8ADqf9eaMwqMoneqzL0wTc/KczQyBDSN6ZwU
         2HWrPhKAjJXObTcpBB9xF/BtPbuEPGagtnzlbDtewiCvhyv+Wl2Vts7GRg52eQ/TnHqN
         QHiCLFEfGyPc/rFRLGvyMW2K5C9R4e2cuFOD97mZs4BZ3s3+dj6f+oDXWhcJiSC8UUsq
         VfxZlmiELLTHf//UsjF81QGP/B+v/2QoInFlu6d/ckuDP4mM4o3ZYclkd2NOyuU6MCRK
         AEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746725535; x=1747330335;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPMbNxc43AcR45VhaO0+Mz0+fFeHkW9XaM5DPtDrlDo=;
        b=BrJ8iBAFr+UuSrfCam98peElOkNYFsEMo9Bci+S0qGpaciWP4gLZl+l9KNa/7YLr7k
         kH0/XF6Xpggzn16FjXPEnFuX65HUAX2M43/3NL9vHLmZZMytxxzEtBbXl6KwT2hFvK6J
         sOck3OxW5ej0YFLOGxZpFILSp/WA+6cwya8Ql967R2VyXV+KBWjRoSltRi4PLyqGiN8i
         5JZP+6YJPpvCl4m9avC0yB5VDmr0C3z3yEDftsL6EAXYqsR88liqLCoKusZ5NgJmkEeT
         ai4d489FYLpAYbR3VbXURMTYlk+q8peX/iZkt1E6A21FwL6aidCQoMW2WZqafsRUWXT0
         ZHug==
X-Forwarded-Encrypted: i=1; AJvYcCUqH4Au+G5TDXRqqpNdupOMo2PUptWh+J9i6FMDiPPNFgw0XCtwOFgMRM7hqU9MK8ni3mTf32xRLMKx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywps9LWEUGOT99pHv/EiTrNt7TMY7GlCirQ9cgZgwg+zqCiyfV0
	oUM+VPTJ8CIH1/624Aaez+d8CieKk4Xz/5nzvSHUuL9uR+CHC1DOuf3K9rhZNhk=
X-Gm-Gg: ASbGncvzLiyAvLKHl89UjTpkg2wsfoqeqxS88j3HvuR9i0wlsdrKlJ0vV98KwJGen8s
	OlZOBw6cdWPG/1AZCFavhN6lTsvLBvYT4GqJGUBg0+WrNE0gqYq1/Xym0wQk2Ks+LBx0VxNRR07
	qASvGEJ+jNvvRaEu8S5HnK4CcvDehnZpMJvdWRnpFhNZIonj5cbUbYuUXMrReQE6uGSAhwkxYQ7
	UanskTtOeZ7apqyuU0weaWEMQjyyhr2zlMEG275w4t5i7pWuUhD29YnuCDqQgFswhroCJLvq7Gg
	3dxbaKJgRV7NcxfqAi5jkwzTGQSWh7PU9w==
X-Google-Smtp-Source: AGHT+IE9VgVPP9dUNk5nU36GZVaBczxNclok26A18Dg0EZaOSiwRtsNDoM6n6nUdbHkW7QysWWdeDA==
X-Received: by 2002:a17:902:dacd:b0:22e:566f:bca7 with SMTP id d9443c01a7336-22fc8b5192fmr2750915ad.17.1746725535067;
        Thu, 08 May 2025 10:32:15 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82c3063sm1796455ad.244.2025.05.08.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:32:14 -0700 (PDT)
Date: Thu, 08 May 2025 10:32:14 -0700 (PDT)
X-Google-Original-Date: Thu, 08 May 2025 10:32:12 PDT (-0700)
Subject:     Re: [PATCH v4 0/2] Implement endianess swap macros for RISC-V
In-Reply-To: <20250426-riscv-swab-v4-0-64201404a68c@iencinas.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, alex@ghiti.fr, ebiggers@kernel.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
  skhan@linuxfoundation.org, zhihang.shao.iscas@gmail.com, bjorn@kernel.org, linux-arch@vger.kernel.org,
  ignacio@iencinas.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ignacio@iencinas.com, Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-3695679f-b501-42f4-95e0-69457773b787@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sat, 26 Apr 2025 07:56:17 PDT (-0700), ignacio@iencinas.com wrote:
> Motivated by [1]. A couple of things to note:
>
> RISC-V needs a default implementation to fall back on. There is one
> available in include/uapi/linux/swab.h but that header can't be included
> from arch/riscv/include/asm/swab.h. Therefore, the first patch in this
> series moves the default implementation into asm-generic.

This seems fine to me, so 

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

It's asm-generic, though, so I usually try to wait for a review from 
Arnd for those.

> Tested with crc_kunit as pointed out here [2]. I can't provide
> performance numbers as I don't have RISC-V hardware yet.
>
> [1] https://lore.kernel.org/all/20250302220426.GC2079@quark.localdomain/
> [2] https://lore.kernel.org/all/20250216225530.306980-1-ebiggers@kernel.org/
>
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
> Changes in v4:
>
> - Add missing include in the 1st patch, reported by
>   https://lore.kernel.org/all/202504042300.it9RcOSt-lkp@intel.com/
> - Rewrite the ARCH_SWAB macro as suggested by Arnd
> - Define __arch_swab64 for CONFIG_32BIT (Ben)
> - Link to v3: https://lore.kernel.org/r/20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com
>
> Arnd, I know you don't like Patch 1 but I tried your suggestions and
> couldn't make them work. Please let me know if I missed anything [3] [4]
>
> [3] https://lore.kernel.org/linux-riscv/f5464e26-faa0-48f1-8585-9ce52c8c9f5f@iencinas.com/
> [4] https://lore.kernel.org/linux-riscv/b3b59747-0484-4042-bdc4-c067688e3bfe@iencinas.com/
>
> Changes in v3:
>
> PATCH 2:
>   Use if(riscv_has_extension_likely) instead of asm goto (Eric). It
>   looks like both versions generate the same assembly. Perhaps we should
>   do the same change in other places such as arch/riscv/include/asm/bitops.h
> - Link to v2: https://lore.kernel.org/r/20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com
>
> Changes in v2:
> - Introduce first patch factoring out the default implementation into
>   asm-generic
> - Remove blank line to make checkpatch happy
> - Link to v1: https://lore.kernel.org/r/20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com
>
> ---
> Ignacio Encinas (2):
>       include/uapi/linux/swab.h: move default implementation for swab macros into asm-generic
>       riscv: introduce asm/swab.h
>
>  arch/riscv/include/asm/swab.h   | 62 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/asm-generic/swab.h | 33 ++++++++++++++++++++++
>  include/uapi/linux/swab.h       | 33 +---------------------
>  3 files changed, 96 insertions(+), 32 deletions(-)
> ---
> base-commit: a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
> change-id: 20250307-riscv-swab-b81b94a9ac1b
>
> Best regards,

