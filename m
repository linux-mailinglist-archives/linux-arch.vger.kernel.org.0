Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ADA46C71D
	for <lists+linux-arch@lfdr.de>; Tue,  7 Dec 2021 23:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhLGWNI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Dec 2021 17:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhLGWNI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Dec 2021 17:13:08 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D2AC061746
        for <linux-arch@vger.kernel.org>; Tue,  7 Dec 2021 14:09:37 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id v18-20020a170902e8d200b00141df2da949so92653plg.10
        for <linux-arch@vger.kernel.org>; Tue, 07 Dec 2021 14:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=H9d3b7ySfPUUkyj8WwGO7YINvSuZ61NMD+2fSI/NRIQ=;
        b=kavNo4w//awmdXO5HpD/p+k8j6D9sG5ed5rnhy6iRwkpibbidw6pxcuAlSF08ANNHS
         AuzRlasPHS5c+2qkBbl5iC6XWKTL0VtiGFM5Y9jNipsSu8Mt+rVitZBMQ/C3fdD0W9no
         Gd7C9tHsD6AdQ40xfJlyUtRCxUb240E1fWiSd3/AFwMrxRZf1GTcv21jiPBDjdKx8EGV
         KcwMnMhh205HO6lvj5rdnxQA/wEvoQYWKnoJjlQ3J8fRr9WYhaGxfBBulxET05qUcXTi
         KL+VA8Iu0l+JerJE1K4vUqVNe66UTgxBGsyfCm0HJDihzF2XKvzmMO3k3OgspObBZ+VL
         p8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=H9d3b7ySfPUUkyj8WwGO7YINvSuZ61NMD+2fSI/NRIQ=;
        b=ajtJxduQKsm9v3sb/TolJ5Qj26+/nrtu0PYV8WQMvdYOuLEJEqrVEeRPErjAx7wKZe
         cMTvq05BLE3jvB1L/3whQWD+kFVtqja1iUd1hjzu2l3KFDqZ1lXuxpkZDBuYPm4R1m9p
         aP0pw59slc6JpYg+soVbs27P06Lh/zZbn2jiD6la/r5RA0FGqMv3moL+tMWkdX6dZmro
         qy/z/fpN8c/qsQrrtQSGDKr0aWV3UvMfS6sUhINYg+kxRWZ1rCAOrHef719NZ/IKwkqj
         HWEtxLZdmKzxzz7iWcm7a1SBUBIx4ECeJeUaO4bnMty8rQr3FH+SPrzXoAtuS3/445uB
         UMSw==
X-Gm-Message-State: AOAM530I5Gg69rHq5OOdbW++Z2+N8LKIfNq5i96qbkZ7jFqU1SXZ8wrl
        +PmvhSJJCXKnJqFodh3QiOeQsdLqDTc=
X-Google-Smtp-Source: ABdhPJzYigwKgXuf4QjKrxXjkaHgzzD+/k5Wx9tZeXK3ngvuCH9gJt9PRu0YFmMirUBJBLh3UP201FwOiaY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4a0e:: with SMTP id
 kk14mr2401871pjb.42.1638914976806; Tue, 07 Dec 2021 14:09:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Dec 2021 22:09:18 +0000
Message-Id: <20211207220926.718794-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 0/8] KVM: x86: Hyper-V hypercall fix and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix a bug where KVM incorrectly skips an "all_cpus" IPI request, and misc
cleanups and enhancements for KVM handling of Hyper-V hypercalls.

Based on kvm/queue, commit 1cf84614b04a ("KVM: x86: Exit to ...").

v3:
  - Collect reviews. [Vitaly]
  - Add BUILD_BUG_ON() to protect KVM_HV_MAX_SPARSE_VCPU_SET_BITS. [Vitaly]
  - Fix misc typos. [Vitaly]
  - Opportunistically rename "cnt" to "rep_cnt" in tracepoint. [Vitaly]
  - Drop var_cnt checks for debug hypercalls due to lack of documentation
    as to their expected behavior. [Vitaly]
  - Tweak the changelog regarding the TLFS spec issue to reference the
    bug filed by Vitaly.

v2: https://lore.kernel.org/all/20211030000800.3065132-1-seanjc@google.com/

Sean Christopherson (8):
  KVM: x86: Ignore sparse banks size for an "all CPUs", non-sparse IPI
    req
  KVM: x86: Get the number of Hyper-V sparse banks from the VARHEAD
    field
  KVM: x86: Refactor kvm_hv_flush_tlb() to reduce indentation
  KVM: x86: Add a helper to get the sparse VP_SET for IPIs and TLB
    flushes
  KVM: x86: Don't bother reading sparse banks that end up being ignored
  KVM: x86: Shove vp_bitmap handling down into sparse_set_to_vcpu_mask()
  KVM: x86: Reject fixeds-size Hyper-V hypercalls with non-zero
    "var_cnt"
  KVM: x86: Add checks for reserved-to-zero Hyper-V hypercall fields

 arch/x86/kvm/hyperv.c             | 175 ++++++++++++++++++------------
 arch/x86/kvm/trace.h              |  14 ++-
 include/asm-generic/hyperv-tlfs.h |   7 ++
 3 files changed, 123 insertions(+), 73 deletions(-)

-- 
2.34.1.400.ga245620fadb-goog

