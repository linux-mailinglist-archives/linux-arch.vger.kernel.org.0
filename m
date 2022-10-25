Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8443E60D081
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiJYP0e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Oct 2022 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiJYP0d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2022 11:26:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58B45245F
        for <linux-arch@vger.kernel.org>; Tue, 25 Oct 2022 08:26:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q1so11769668pgl.11
        for <linux-arch@vger.kernel.org>; Tue, 25 Oct 2022 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f0Fk+0/Amw7nskzxgUFtOOx5Md+yUa8AJYsojRyR41E=;
        b=at2Vihq0ZysdnRIAuOMyqUBdq1/FFvX63hDc58gBWKAYTaAmkdYraFO/pRcQUDSDYE
         0fkDw3uZaS0h9nyoTmESSO/FjPD1QqpECPNASv+D/6l+zaxAf+VJn/1HbEpmn5RksRqM
         Kzp2cehpcT91+FjF962CIIiyPLseroHnn8m58E8xAwNn8/VzQz0SjVNwnMGfPlyntwWG
         1v+JEBR3ZSQGmfEMYXT1afvMpcQP3UQ/MndzyKc736Oi9OUW1NIyDDMvB7aFBM+fsgL1
         HkgjZvE5tmNi+7E1mPJH+qwH0v1PNDsMYQONw16TaTIl5SmDaOKIjaZzxn0BT619gx8g
         +GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0Fk+0/Amw7nskzxgUFtOOx5Md+yUa8AJYsojRyR41E=;
        b=Ieirsvi6wz8RdCkrZUkzYEVFGmOlWAuO2ts91UQbBrtwjkFLyC01i8cWM5BT5+eOIF
         FZGagbOWAcoJvVVt8htjovsEOkz3LQWMPMYODay5WeXgsNOESMxdb/G3iZL+JBX1M3CN
         K4MR/lTv9SpTMck1b0vztsWgc521G2XthwVl/FqcgQkeuXFsbi5min/Y0/G6SHsp8iRk
         t3SBTzn7u3e2RFHAz5sXu/s70iU2U3Ovtes3aSJGdUAuLxfuasossDqCPvTBKVP8H9+e
         WmV5Rr4RFk9QRLAusXrvLhOD+UcEF5beYwPdyC0SmRNDeg8JzJNVkfZGcrV+snJ16geY
         0ruw==
X-Gm-Message-State: ACrzQf2jvR6HLnsSTvl8m618WUHnzRT9P6lhLiv+pGrPPCg3eNSYbanE
        Iv2MHwpyyW5TE1bxBW/BTw2P0Su2GMJtMpQAoKNA2Q==
X-Google-Smtp-Source: AMsMyM7S5IISqnVExEMx/Y/NdDoxoi+mPZLZks2JQtwFF+Q9Vn8DzGWDrBRBdHkSKruNqn9cxFFTv641nHc01V+gClk=
X-Received: by 2002:a63:1d5a:0:b0:46e:d157:39ef with SMTP id
 d26-20020a631d5a000000b0046ed15739efmr17120402pgm.231.1666711590299; Tue, 25
 Oct 2022 08:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com> <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
In-Reply-To: <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 25 Oct 2022 16:26:18 +0100
Message-ID: <CAFEAcA-=Sc9Sc4oLq13HAFW49ZBw8u6DtN7bf_vjVYX_AAaKSg@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
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
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 25 Oct 2022 at 16:21, Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> This new KVM exit allows userspace to handle memory-related errors. It
> indicates an error happens in KVM at guest memory range [gpa, gpa+size).
> The flags includes additional information for userspace to handle the
> error. Currently bit 0 is defined as 'private memory' where '1'
> indicates error happens due to private memory access and '0' indicates
> error happens due to shared memory access.
>
> When private memory is enabled, this new exit will be used for KVM to
> exit to userspace for shared <-> private memory conversion in memory
> encryption usage. In such usage, typically there are two kind of memory
> conversions:
>   - explicit conversion: happens when guest explicitly calls into KVM
>     to map a range (as private or shared), KVM then exits to userspace
>     to perform the map/unmap operations.
>   - implicit conversion: happens in KVM page fault handler where KVM
>     exits to userspace for an implicit conversion when the page is in a
>     different state than requested (private or shared).
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  Documentation/virt/kvm/api.rst | 23 +++++++++++++++++++++++
>  include/uapi/linux/kvm.h       |  9 +++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index f3fa75649a78..975688912b8c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6537,6 +6537,29 @@ array field represents return values. The userspace should update the return
>  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
>  spec refer, https://github.com/riscv/riscv-sbi-doc.
>
> +::
> +
> +               /* KVM_EXIT_MEMORY_FAULT */
> +               struct {
> +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE (1 << 0)
> +                       __u32 flags;
> +                       __u32 padding;
> +                       __u64 gpa;
> +                       __u64 size;
> +               } memory;
> +
> +If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that the VCPU has
> +encountered a memory error which is not handled by KVM kernel module and
> +userspace may choose to handle it. The 'flags' field indicates the memory
> +properties of the exit.
> +
> + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
> +   private memory access when the bit is set. Otherwise the memory error is
> +   caused by shared memory access when the bit is clear.
> +
> +'gpa' and 'size' indicate the memory range the error occurs at. The userspace
> +may handle the error and return to KVM to retry the previous memory access.
> +

What's the difference between this and a plain old MMIO exit ?
Just that we can specify a wider size and some flags ?

-- PMM
