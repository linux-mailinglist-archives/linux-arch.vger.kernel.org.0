Return-Path: <linux-arch+bounces-12963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA50B12ABD
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584F53BBA16
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29323AE66;
	Sat, 26 Jul 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/AVEycz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0F481DD;
	Sat, 26 Jul 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537375; cv=none; b=DhyByLCXU2zaUluieJAdKCxPCe+7BUapZUWH1EIe7QCBxFp4WWY6nhctFbA3DQYhg1UCThpzxVQGe8NLFd0TIMC+uVHoK8XrUhxrgtoRjEnS0vuohciYlDFKnkA6/nPvIqtQpQqc6Smzaj7G+iF8aCtvks90fNnor0gpNs5/IPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537375; c=relaxed/simple;
	bh=1hUmX5hI3J/W4Ut02JLPRXx77DgARnMFeF3OQCb0Juk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gm4dmKQj/mUvG7n5nvGHJWhQRmIhJEkJmU8kF/8IoqC9DrRrHgrhlicWyW7ij1nmQyMRgxeRBxWZacQ8sa/5D8cg51f32jG0ep6TJ9FMmf1fOAHylA6odl95otzuqYjGpBq5ieVYSn8krCSIbTAeeRQcpzEMQ7YzirCBoaLs5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/AVEycz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c8a505177so24988605ad.2;
        Sat, 26 Jul 2025 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537373; x=1754142173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPclnn9w29nvfQf0KYDGXYWPWgDFpSvkfdWvl0o/Yqc=;
        b=N/AVEyczP8HpjY3oWtc4v2A4qSuDMLuBhOiO9odxG/16o/fhn0ciZJj6jTe286/wXR
         TXYCjbPt2P7Bd+oxRpRZrJceVqgImnRSfLh99dIcYp7k159amw1LVo8iW7GDOutb3tqb
         j1bYjW5mvY4VYC5p3dfJaQXEVQUTkjmQ1CD6Ya0VhiCwGrpFOivZB9ndgrSMMK5VcjKU
         EvtyVekdLasmSZHpzHlYfdDmpwmljH1r/oIfrqozF5XFDmNVmZBIg2mUOLWKdVwxcrgU
         PIeNWBOguKSnnWISLWaJlxfAXEligm0tf9ylQ4pji9slANLcUMGDl3ktGuEGt4Xd9m2A
         Briw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537373; x=1754142173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPclnn9w29nvfQf0KYDGXYWPWgDFpSvkfdWvl0o/Yqc=;
        b=ZiQ15VtUip4o+slep/64s/tiWE/Ptru1pSfXgBu/hsw50ncbFTHXte7ynBnNWADi/H
         E5SBbesOYUmasLTSvOiSX+QiVb0GXn1Hjsc4tuQVkEu5D13qolDRqqPXvlvizPtZytqb
         I9k/btqBPFF4eOb+dUvL8pgOnuM9ICFPTB0i7REnsReoxa5zDpVs2+2Z2Jk31x/9rI2D
         BcAjndcQIbNBAMVL/yvU7ulyogJ8/VmuoGMTH4NbjcgFRXyG5pBOEwSc0PNjsD4RbOq9
         lnGxZ2at5N+23fF8QTb/MTmiocz+/83V/lNruRwh10clqH0rS/2HwOTkjPNWl3Ire6DP
         aUpw==
X-Forwarded-Encrypted: i=1; AJvYcCUp/6RgJ/csrtdUM6R+QwGcV4GjVu2bWo6cNjeXu86A/OwxbCo78bh+h9x4tcjpKXaPBBNItSjVdJiNdAgN@vger.kernel.org, AJvYcCX5ia9wxw8hBjQAf2Wkj+T+8MYUEROv7sYgepANisKPrl/6sFHb/oZiZ+wlw2Bzi5E19WSSurmKb4vjPs0F@vger.kernel.org, AJvYcCXYEcAosTxnRzuLKR4kBqiM+LExZ0VeZ9hd8K+fsDMXzcMB1KFynGDcHyPWxUxTsf1bKK9PA2JUQBWj@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdNhfKyxfP+1urNiiQfubbRriWiynwNUtvoVIBX2W/Mg9AZ0j
	z+hLv6pI2M2gpb86anw8JM4x6Uy4V+1CTW5fNPhrVWoTDDWL43oBrnYH
X-Gm-Gg: ASbGnctmItEbqq8Xg2r1392aYi8Mmf99LtuhEtCQIC5C05M984IXFnCQ80ptAOktgqH
	sODguNTxuS6FCQ1Qv7EkQB7JPJmKylessu2RkQaX2OAOHt9oBhv2HcjoFpEt/jvC8HoYXugB/oa
	49kR4n6UkkvzMNb+iHoWienIx47QU7SQ+hR6QB7+txyWwGPSbgAHClU4Da57ahfO4YPLAn9Cehr
	qnHnrAGeN+gWqsFnoNooTiMlpzQmyMMg7u/oWmCB3oUm1RmV6zYoD0ROxj+gvKiKnAiWr2WOCMa
	F4CMD+FT6nfQYqymY7wm/5eKs8pfPVi7qnMnJkvt7FN48VDN4aICXz4JkLM0LY6Y90TFEEDxHx+
	BQlVKDxAwwKokgqfWg6/NJgNLjWOBKh/KjlqNWMBfhj5mXGBtH+4suy/kWGblJQ==
X-Google-Smtp-Source: AGHT+IFl4YktStVqSJzIgw4nrH9zK2DTy2v4RE7W0FzzvKqWNmbztzhlW1/vpTeYPzZHAjMZ16gRRw==
X-Received: by 2002:a17:903:1aef:b0:23e:3c33:6be8 with SMTP id d9443c01a7336-23fb2fe127emr72410635ad.8.1753537372804;
        Sat, 26 Jul 2025 06:42:52 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:77:9619:11b0:a73:e5a6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83508500sm1869190a91.22.2025.07.26.06.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:42:52 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH V4 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Date: Sat, 26 Jul 2025 09:42:46 -0400
Message-Id: <20250726134250.4414-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

Secure AVIC is a new hardware feature in the AMD64
architecture to allow SEV-SNP guests to prevent the
hypervisor from generating unexpected interrupts to
a vCPU or otherwise violate architectural assumptions
around APIC behavior.

Each vCPU has a guest-allocated APIC backing page of
size 4K, which maintains APIC state for that vCPU.
APIC backing page's ALLOWED_IRR field indicates the
interrupt vectors which the guest allows the hypervisor
to send.

This patchset is to enable the feature for Hyper-V
platform. Patch "Drivers: hv: Allow vmbus message
synic interrupt injected from Hyper-V" is to expose
new fucntion hv_enable_coco_interrupt() and device
driver and arch code may update AVIC backing page
ALLOWED_IRR field to allow Hyper-V inject associated
vector.

This patchset is based on the AMD patchset "AMD: Add
Secure AVIC Guest Support"
https://lkml.org/lkml/2025/6/10/1579

Chnage since v3:
	- Disable VMBus Message interrupt via hv_enable_
       	  coco_interrupt() in the hv_synic_disable_regs().
	- Fix coding style issue and update change log.

Change since v2:
       - Add hv_enable_coco_interrupt() as wrapper
        of apic_update_vector()
       - Re-work change logs

Change since v1:
       - Remove the check of Secure AVIC when set APIC backing page
       - Use apic_update_vector() instead of exposing new interface
       from Secure AVIC driver to update APIC backing page and allow
       associated interrupt to be injected by hypervisor.

Tianyu Lan (4):
  x86/hyperv: Don't use hv apic driver when Secure AVIC is available
  drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
  x86/hyperv: Don't use auto-eoi when Secure AVIC is available
  x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts

 arch/x86/hyperv/hv_apic.c      | 8 ++++++++
 arch/x86/hyperv/hv_init.c      | 7 +++++++
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 drivers/hv/hv.c                | 2 ++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 6 files changed, 25 insertions(+)

-- 
2.25.1


