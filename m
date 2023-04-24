Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B426DCF68
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 03:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDKBf3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Apr 2023 21:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDKBfX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Apr 2023 21:35:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16247272A
        for <linux-arch@vger.kernel.org>; Mon, 10 Apr 2023 18:35:22 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id fu21-20020a17090ad19500b00246d7bc13c5so494386pjb.9
        for <linux-arch@vger.kernel.org>; Mon, 10 Apr 2023 18:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681176921;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P3v7tjSHGZNeYf6fkHAGvkufX/1T+vrTWm+HxnUGut4=;
        b=ckDnI+qYpROoTcufCDcwOgr9iK1RPksPsWmIOeBsLNA/uyUeqNZdzhUf9sXthlctPf
         F+wMi3ClOnexsABXRbEypc3cqMNPH6Z0tNPVuwd8fhbDH8ln+SkWrpjNxEGwPxC/2glt
         FMI52wFhtuuDKkOMoaifJqIS9sTG7C5BknJRLtVbUZ9NqSkywnTZ/Opexpr9pbApTgcj
         GvPQtEzR7qQ4/fxydRQd5pWtJ5dgkv7JwSBfm07pT8ToRPItu6TrUnHKJfJ+avfBnkLl
         UgRpWyM2oduh/jLdoDELNXyYnRgcaaN+uD3VPgKEYl1EqI5ru4nTcuI8zBQ1sZRVNTWk
         QFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681176921;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3v7tjSHGZNeYf6fkHAGvkufX/1T+vrTWm+HxnUGut4=;
        b=LLNUod3ycLl5wWzzHjTsWYop+QJAHjChnYfPufqNXE6rVY6TX4nBK4TNI1q1tSDWEJ
         /8g29N2Jhb1brMZRsHOvN12WGFyXpe6B88OrbdVeiTa7XpGD4VDUqqEmh6oGM+UqQ9DW
         QoO8+NxxHtfWOi+MEvU6QkAKX3UTvZ2/vMfOlyNe4dRPdstY5Y2QOg3W4fzVW8kKfMMX
         b1SnswFnXarDCzh9Cv5S/bfpFoO0fbQXl4YUXdmrhk6OU6cFZwmHBGenXxAWdaFCXKkc
         UXsUj8glEeqTJ2aHIP+ivOWUfQja7NMqz5udO+PV/pIAxKqQzpnsijxOPY7uvd5wbwV9
         qWFw==
X-Gm-Message-State: AAQBX9eHR/woNxoNiu8CneJwL1Ks5rwJWF7iqBjh+tTgwWCKvR0n0pHt
        e/i9mb6npuyONljFzeyudqJJTcPHwT2V+4Z8lw==
X-Google-Smtp-Source: AKy350ZpEpeQ13YWXEI6KoaJD09D+A99JikQlgyPpvIj63sO7he4qmnLCAo5joZFqabrZuaV6dwRVFPxHRliUjWyCg==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a63:4c1c:0:b0:518:1f4d:3dbc with SMTP
 id z28-20020a634c1c000000b005181f4d3dbcmr213711pga.10.1681176921489; Mon, 10
 Apr 2023 18:35:21 -0700 (PDT)
Date:   Tue, 11 Apr 2023 01:35:20 +0000
In-Reply-To: <9bbdc378-e66e-0a44-244b-33dffe888a2b@redhat.com> (message from
 David Hildenbrand on Mon, 3 Apr 2023 10:24:37 +0200)
Mime-Version: 1.0
Message-ID: <diqz5ya319rb.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [RFC PATCH v3 2/2] selftests: restrictedmem: Check hugepage-ness
 of shmem file backing restrictedmem fd
From:   Ackerley Tng <ackerleytng@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, ddutile@redhat.com,
        dhildenb@redhat.com, hpa@zytor.com, hughd@google.com,
        jlayton@kernel.org, jmattson@google.com, joro@8bytes.org,
        jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, luto@kernel.org, mail@maciej.szmigiero.name,
        mhocko@suse.com, michael.roth@amd.com, mingo@redhat.com,
        naoya.horiguchi@nec.com, pbonzini@redhat.com, qperret@google.com,
        rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
        steven.price@arm.com, tabba@google.com, tglx@linutronix.de,
        vannapurve@google.com, vbabka@suse.cz, vkuznets@redhat.com,
        wanpengli@tencent.com, wei.w.wang@intel.com, x86@kernel.org,
        yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 01.04.23 01:50, Ackerley Tng wrote:
>> For memfd_restricted() calls without a userspace mount, the backing
>> file should be the shmem mount in the kernel, and the size of backing
>> pages should be as defined by system-wide shmem configuration.

>> If a userspace mount is provided, the size of backing pages should be
>> as defined in the mount.

>> Also includes negative tests for invalid inputs, including fds
>> representing read-only superblocks/mounts.


> When you talk about "hugepage" in this patch, do you mean THP or
> hugetlb? I suspect thp, so it might be better to spell that out. IIRC,
> there are plans to support actual huge pages in the future, at which
> point "hugepage" terminology could be misleading.


Thanks for pointing this out! I've replaced references to hugepage with
thp, please see RFC v4 at
https://lore.kernel.org/lkml/cover.1681176340.git.ackerleytng@google.com/T/

>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>    tools/testing/selftests/Makefile              |   1 +
>>    .../selftests/restrictedmem/.gitignore        |   3 +
>>    .../testing/selftests/restrictedmem/Makefile  |  15 +
>>    .../testing/selftests/restrictedmem/common.c  |   9 +
>>    .../testing/selftests/restrictedmem/common.h  |   8 +
>>    .../restrictedmem_hugepage_test.c             | 486 ++++++++++++++++++
>>    6 files changed, 522 insertions(+)
>>    create mode 100644 tools/testing/selftests/restrictedmem/.gitignore
>>    create mode 100644 tools/testing/selftests/restrictedmem/Makefile
>>    create mode 100644 tools/testing/selftests/restrictedmem/common.c
>>    create mode 100644 tools/testing/selftests/restrictedmem/common.h
>>    create mode 100644  
>> tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c

>> ...

