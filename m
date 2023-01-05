Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AAF65F54C
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 21:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjAEUis (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 15:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjAEUio (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 15:38:44 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96C363F45
        for <linux-arch@vger.kernel.org>; Thu,  5 Jan 2023 12:38:42 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id i20so30947705qtw.9
        for <linux-arch@vger.kernel.org>; Thu, 05 Jan 2023 12:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5R84gnDXIcZCl3q1uuKNVrzE7JF/GewA0GD7Joj4Tac=;
        b=JTqD02qzpNL7au3Z3GUF4Xu2ARxubYVglZyPFMGjd5IBB76X21fyAUfGvELrmmzFik
         QzBJjZBaZ6aZe7oTAlxNCti0+kLpAukE+qZM7LrpHVjgAMiyLgJZ2+98YW1K5vKsRoVw
         2umAOw9diVB8LQA7BnZCONR8pssadQA3XE8f0al71RlaiMm7wUNlcWpSs5hmEzVyjqeM
         eYv5U34leRc2bqLAihlC18sqPCveW9G6816ZQccg0Z2ovOthL6yQhQkI0guVnNH8iTu7
         dG6eqdfXW1bD1DNzwo+oob/r+0lWSVvlcjXTltffxVApLthVRgT5BHTNgmHgdLEzU0KX
         YdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R84gnDXIcZCl3q1uuKNVrzE7JF/GewA0GD7Joj4Tac=;
        b=sbdYZ/+UKcIjy9M/CBvcJzVQfVsemyNYmOWk2/Y4nsZc2vowUA29/o06RTvde3yvyp
         dibtumW1CSqw1LS7z3Bklnh6oDFayHGWdDYcIutz3MZ4Q1KBX41siP3dTSa1xHK8w6QY
         7bR6QC8Ojm2V+bb3eVGM3nAIxD6wJPvouXoZmKu/O1n8gFl0eIJQNIAmvT9iy/h8UsEV
         ox4wSEjOMDVmqr0CYdQGKBr3MOAzK6i5uQot2ABeYmgTql3FXrlFp9v9YgR6D/BrOO4e
         NAcxuGZzNY+RKZJOeV0uKuqAEulB8/TDma5kr2yDa3wai6bUnLkFuibJ6EkMl6ax2LkB
         1qww==
X-Gm-Message-State: AFqh2kpZ9jui+iEYKx0NcWsA+QWE1wXL3g1vw0tkJvRQJpvF7nWMN43d
        Xsb2MTXDKaczPQRR2+l36SSiGlILUk6YtGloBP7uXQ==
X-Google-Smtp-Source: AMrXdXsO9CWfLwOzPVqYnAJucA/qVRf1ChKGrluQUWC1ROk0zrv6560/2Dre8nwP8Lxgkk7sOMhP2BMCSX8GFdVvZpI=
X-Received: by 2002:ac8:5e0c:0:b0:3ab:754e:f0b3 with SMTP id
 h12-20020ac85e0c000000b003ab754ef0b3mr2062105qtx.583.1672951121587; Thu, 05
 Jan 2023 12:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com> <20221202061347.1070246-10-chao.p.peng@linux.intel.com>
In-Reply-To: <20221202061347.1070246-10-chao.p.peng@linux.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 5 Jan 2023 12:38:30 -0800
Message-ID: <CAGtprH_pbSo1HeEFUEB6ZZxm-=NEw+nLZ6ZVvr76=9BeX=AHPA@mail.gmail.com>
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 1, 2022 at 10:20 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> +#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
> +static bool restrictedmem_range_is_valid(struct kvm_memory_slot *slot,
> +                                        pgoff_t start, pgoff_t end,
> +                                        gfn_t *gfn_start, gfn_t *gfn_end)
> +{
> +       unsigned long base_pgoff = slot->restricted_offset >> PAGE_SHIFT;
> +
> +       if (start > base_pgoff)
> +               *gfn_start = slot->base_gfn + start - base_pgoff;

There should be a check for overflow here in case start is a very big
value. Additional check can look like:
if (start >= base_pgoff + slot->npages)
       return false;

> +       else
> +               *gfn_start = slot->base_gfn;
> +
> +       if (end < base_pgoff + slot->npages)
> +               *gfn_end = slot->base_gfn + end - base_pgoff;

If "end" is smaller than base_pgoff, this can cause overflow and
return the range as valid. There should be additional check:
if (end < base_pgoff)
         return false;


> +       else
> +               *gfn_end = slot->base_gfn + slot->npages;
> +
> +       if (*gfn_start >= *gfn_end)
> +               return false;
> +
> +       return true;
> +}
> +
