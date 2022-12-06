Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6264484D
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 16:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLFPsU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 10:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiLFPsB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 10:48:01 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CAAE01A
        for <linux-arch@vger.kernel.org>; Tue,  6 Dec 2022 07:47:59 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id x6so17672957lji.10
        for <linux-arch@vger.kernel.org>; Tue, 06 Dec 2022 07:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m1kCqWlRYfobNKnwTTmG2lD4ZIH0ubVAosfgV6W3Dk4=;
        b=km4nt3h3SHb/kEB2LuEUazieUkF9KftHb5F5G6SyTF0tkPyKfN2VeOikiWxEBRycBp
         HsbvpDP5MQFX5lKttQgca1p57UvCAGjzgI85ey19QT3BdjKfqI9Cvl6Wv6b4IRjUUGio
         SNCBKhia8UVi2JEXoKNgW6LJLeJ34+7z8/13c3LqbFAKDJMO8Gy/+VyTLMrA7AhhENd1
         TNOqx+MF6+0Q7sMMqfp/4fXIA6AYYQUMyiQMrZUKrOwSlFwEERF41f5MgnrniS4C+Zx7
         aT0+T5Mh7IQLLskdVC1oVbKnMT2sukhYGiYH6rQJUVqDRrBUtxo2Y0A4TZ8KfOE3PyHH
         RKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1kCqWlRYfobNKnwTTmG2lD4ZIH0ubVAosfgV6W3Dk4=;
        b=eZFInbac6rwFWECl0YOEbbLJmfV9uRcaUrgJ2U8TBtTeEC+8vtDrEpKCSMmlCJXrVk
         uDBWt/QebpYEsnm6hYXIXQAsQmR5xmK0xWKqVoLv1rhQCemKC/porMWUWBk237qcnTWo
         G6k+TXh8AaqK+UTLbUmpowqfIVKFzafzQ66P177jJgG2zUJOMixVxkqwZfAQGIhYyaGE
         1NAnENqfBcsrpLUscS96Jx8rKLbzX2Njr+L4KTWpHNEzJ5h2h+VMlUQK/incz/hSkibO
         wCyZOs00egfQN33D4w1Q0HQjQ8iE+zlidZzVHMPs4iU1IwlgPe73gqO6+AalgXspk0Y8
         v7sA==
X-Gm-Message-State: ANoB5pni9TDxyK9wFVsDL+2pWY5IjcrOXHkBkGluAB9dzcCUpA33VfKG
        pSEfT2jbltiSLLXHKEOEjRewdIoQI6QaysFCWFaHDw==
X-Google-Smtp-Source: AA0mqf670rgKAoKyVamK5fGEwo/r7qIQAwktaBqfm7a0tY0XJdGyAcQGRLzmDTdXbe+6R04s2ufEeuo3JFvMsirw8Vc=
X-Received: by 2002:a2e:a80d:0:b0:277:1295:31ca with SMTP id
 l13-20020a2ea80d000000b00277129531camr27009331ljq.280.1670341677228; Tue, 06
 Dec 2022 07:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com> <20221202061347.1070246-5-chao.p.peng@linux.intel.com>
In-Reply-To: <20221202061347.1070246-5-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 6 Dec 2022 15:47:20 +0000
Message-ID: <CA+EHjTyzZ2n8kQxH_Qx72aRq1k+dETJXTsoOM3tggPZAZkYbCA@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] KVM: Add KVM_EXIT_MEMORY_FAULT exit
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
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
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

Hi,

On Fri, Dec 2, 2022 at 6:19 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
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
> Reviewed-by: Fuad Tabba <tabba@google.com>
> ---
>  Documentation/virt/kvm/api.rst | 22 ++++++++++++++++++++++
>  include/uapi/linux/kvm.h       |  8 ++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 99352170c130..d9edb14ce30b 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6634,6 +6634,28 @@ array field represents return values. The userspace should update the return
>  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
>  spec refer, https://github.com/riscv/riscv-sbi-doc.
>
> +::
> +
> +               /* KVM_EXIT_MEMORY_FAULT */
> +               struct {
> +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE (1ULL << 0)
> +                       __u64 flags;

I see you've removed the padding and increased the flag size.

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad




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
>  ::
>
>      /* KVM_EXIT_NOTIFY */
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 13bff963b8b0..c7e9d375a902 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -300,6 +300,7 @@ struct kvm_xen_exit {
>  #define KVM_EXIT_RISCV_SBI        35
>  #define KVM_EXIT_RISCV_CSR        36
>  #define KVM_EXIT_NOTIFY           37
> +#define KVM_EXIT_MEMORY_FAULT     38
>
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -541,6 +542,13 @@ struct kvm_run {
>  #define KVM_NOTIFY_CONTEXT_INVALID     (1 << 0)
>                         __u32 flags;
>                 } notify;
> +               /* KVM_EXIT_MEMORY_FAULT */
> +               struct {
> +#define KVM_MEMORY_EXIT_FLAG_PRIVATE   (1ULL << 0)
> +                       __u64 flags;
> +                       __u64 gpa;
> +                       __u64 size;
> +               } memory;
>                 /* Fix the size of the union. */
>                 char padding[256];
>         };
> --
> 2.25.1
>
