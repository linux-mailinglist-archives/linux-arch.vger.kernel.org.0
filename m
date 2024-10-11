Return-Path: <linux-arch+bounces-8008-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F7F9997EF
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 02:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32361284A4C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 00:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FAF8F5B;
	Fri, 11 Oct 2024 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Pwr3vYqB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77951C36
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606742; cv=none; b=Arjesqhl33aKYuKdqKKxIRmZvEfagnx9a1bGfEOM2SJ4sWCObuW8+ssCBgGPMQors7eaWUQbPrikVqzIM8D7+wsrAYTM1WqBuVQYv5YxNfK+QziWNS0azsy82XrK7HCkX/XlUKHhhkIjYuxo7lePsHtBMdoPBCn1sRoHbP+3t/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606742; c=relaxed/simple;
	bh=U6PUAykp73iKKHV5fdD8PAkfE5kmnNbKtNiNViCmipg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=scit+H0GK76Iz97IktXkjGBshz2XnkIFv30Njz8fjw1KW67q4P1epG5ydJKd2cnrm6r+iNRWkFaMSQJZ6OLsHeXNQHcrXs4yqc1pDIiybTBBjrJg7XCPxDiD5TmXOe8jbvkzxiVQvb5d2fne1NWsGFkmjgKrWnUgsIM2xSqGaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Pwr3vYqB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e03be0d92so1299877b3a.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 17:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728606740; x=1729211540; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L88k/6LQJ6n1DZsE/un1+ux0jKynkO+0CSLGH0Z2NJk=;
        b=Pwr3vYqBDOAy8cnkB7RyrcMYV+dJyFEgkKpAbFmEoUJ+E3YEYhTvlc+MeiLCU4xsE4
         nPCvNXXvdICIPLrvvZEf+Ws7eYulqt/x8rJs0iTYpdjil17iLt8FMI4Fex+s4+hS6eSw
         GP65XkrvTHwAXR2t8TRCuvYk9HVImv6HpCODdU9hda8LaXSLuaa3JFhSSXtfMj2OXcZQ
         pynd+O3vJnkfxl00bU6ZgacquJKWJqp9GFD2TyWHfXSo+RLSh7F9dpZ492lchdGV1p7I
         mwOW10ncjDa/X9j2yVbzl+q90VWgJkVhC0ihFdx/6IZBCT1HNC+ycjZKYxY9b+vFFRN8
         037A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606740; x=1729211540;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L88k/6LQJ6n1DZsE/un1+ux0jKynkO+0CSLGH0Z2NJk=;
        b=KdpRXhhv6ERD3MLDdzz31K8qjZC6C4VJPSQOt3SvqMC4SM85MELQLgEEkfmgunw4kK
         9HptXLHR3GyGbsL/CSe8n41Al//0peeFhJObCjFj6W4aCwoOZ50Lk5Kobrym6doBZTF7
         6RXjCyV0l5kpbF0hTdVNq31mXjEaq+1+cWDcV3gyM/xRLHuDO+8e8Silmz34u3L6Ewsb
         qXLTYYgdciGo1ik4Fh9muaw2zh+GJ2EdKmBaNAhWjtQpm9Po7oZh916p39SJcJwybw9U
         W9ltq80Z9BtaCOQAj1VlFg83Tti5waCNrAh6oPIzc429sfWOH72dfVmqKZn8dAjvPMkF
         iuaA==
X-Forwarded-Encrypted: i=1; AJvYcCV/DrRyv8HD/l9Zn2QdNFs64737VZWiZK2Uoqk/e7gyNYmOBroruVxjuJGOb87gFynC90GYa3RtFXQD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SvHBSfDMmtpjA5qcZ+BCWUikk5NacCYULkTRfgwBLkI8lP3P
	cUGDEhpuWe8krsiFKHoXNwoHggGb4hmTBSPysZal0HK3uddgc0YNW5pTRFGQ3io=
X-Google-Smtp-Source: AGHT+IGyS+aA9UxCtkzeUWYlobH1ifyQtJfGEXOmfg62rhTEkQa/syWVFaq3tPCmx1Ml8NjwqupEEw==
X-Received: by 2002:a05:6a00:4f95:b0:71e:21:d2da with SMTP id d2e1a72fcca58-71e38083ec2mr1436401b3a.27.1728606740101;
        Thu, 10 Oct 2024 17:32:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496b1afsm1545600a12.94.2024.10.10.17.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:32:19 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH RFC/RFT 0/3] Converge common flows for cpu assisted shadow
 stack
Date: Thu, 10 Oct 2024 17:32:02 -0700
Message-Id: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJyCGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MD3eKM4pLs+OT8vLLUIqBsYmpaUnJSapppirmhElBTQVFqWmYF2MB
 opSA3Z/0gtxCl2NpaAE6oGlppAAAA
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-arch@vger.kernel.org, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Mark Brown <broonie@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
 David Hildenbrand <david@redhat.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
X-Mailer: b4 0.14.0

x86, arm64 and risc-v support cpu assisted shadow stack. x86 was first
one and most of the shadow stack related code is in x86 arch directory.
arm64 guarded control stack (GCS) patches from Mark Brown are in -next.

There are significant flows which are quite common between all 3 arches:

- Enabling is via prctl.
- Managing virtual memory for shadow stack handled similarly.
- Virtual memory management of shadow stack on clone/fork is similar.

This led to obvious discussion many how to merge certain common flows in
generic code. Recent one being [1]. Goes without saying having generic
code helps with bug management as well (not having to fix same bug for 3
different arches).

In that attempt, Mark brown introduced `ARCH_HAS_SHADOW_STACK` as part
of arm64 gcs series [2]. This patchset uses same config to move as much
as possible common code in generic kernel. Additionaly this patchset
introduces wrapper abstractions where arch specific handling is required.
I looked at only x86 and risc-v while carving out common code and defining
these abstractions. Mark, please take a look at this and point out if arm64
would require something additional (or removal).

I've not tested this. Only compiled for x86 with shadow stack enable. Thus
this is a RFC and possible looking for some help to test as well on x86.

[1] - https://lore.kernel.org/all/20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com/T/#m98d14237663150778a3f8df59a76a3fe6318624a

[2] - https://lore.kernel.org/linux-arm-kernel/20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org/T/#m1ff65a49873b0e770e71de7af178f581c72be7ad

To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Liam R. Howlett <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Mark Brown <broonie@kernel.org>

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
Deepak Gupta (2):
      mm: helper `is_shadow_stack_vma` to check shadow stack vma
      kernel: converge common shadow stack flow agnostic to arch

Mark Brown (1):
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK

 arch/x86/Kconfig                       |   1 +
 arch/x86/include/asm/shstk.h           |   9 +
 arch/x86/include/uapi/asm/mman.h       |   3 -
 arch/x86/kernel/shstk.c                | 270 ++++++------------------------
 fs/proc/task_mmu.c                     |   2 +-
 include/linux/mm.h                     |   2 +-
 include/linux/usershstk.h              |  25 +++
 include/uapi/asm-generic/mman-common.h |   3 +
 kernel/Makefile                        |   2 +
 kernel/usershstk.c                     | 289 +++++++++++++++++++++++++++++++++
 mm/Kconfig                             |   6 +
 mm/gup.c                               |   2 +-
 mm/vma.h                               |  10 +-
 13 files changed, 392 insertions(+), 232 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241010-shstk_converge-aefbcbef5d71
--
- debug


