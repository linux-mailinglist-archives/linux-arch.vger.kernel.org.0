Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F0663069
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 20:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbjAITcP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 14:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbjAITcN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 14:32:13 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E82D1649A
        for <linux-arch@vger.kernel.org>; Mon,  9 Jan 2023 11:32:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c85so3685507pfc.8
        for <linux-arch@vger.kernel.org>; Mon, 09 Jan 2023 11:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MS9c8pSDmVucTZdPdHhH3mdXKbPND6bL5OXnhsaz428=;
        b=sOIFmmww5t87chNqg4RrjKvRSK55mbJUfkLlDwVdXFzdUVNQpuL8j+67d+DkgdzGV/
         cY+1zKjyGAv7inACtQNgX5uUKu4ApW+iH+DVN7GkXfrRLLF2Mvo9WifnFmurzCTgdAvo
         yO0VsoKDonS/b5FpljJp4kIUzSG1uLseP8M04BYadiPR3LnDKhEB8JDIFZ6XY2cYQ9Ip
         q/lAxkFfWGCi4n140C5isaU+LhXs1upwAI92uUGwcJ28pRBl0VFZtoKmw+InBC55cTsl
         h4qHQp+F6duxw8RJ/SXhE+ei/WHcJpuK0DK+gQrpAmJlxVZpoBxyR4o9mafVKF6RyDWB
         AG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS9c8pSDmVucTZdPdHhH3mdXKbPND6bL5OXnhsaz428=;
        b=BYfrfZu5DVmvExIXGz9of4K5Q2yCsHQIH4GGMwg2xDMx0O+wqQKOyvVZT2aJ+RrdTj
         xOV3VOqnQySJJFCvmijS896v+wOkaPKZQPJFBhfsOXMljWgGO849YlAL4jtHi0/n/5NJ
         YX7XU9CaMcdlkBHJHbEsncIwY6QILIUDwMTPlRFBoTWztIomj8mx++XSEcZDdOR37FJN
         L6kQMCxDdc4pwW5XN0xDjoArvZYotdKgJQIhm0Qs2LXmJJKuLPLrWW0ClHVrk04Htszo
         Q9I3V2DWsr0OFBFHoTjHBHXv+Dcxsblmy3SyeUI5a18zh6K6tacGx+xlH3WBD3CJfKFf
         v/Pw==
X-Gm-Message-State: AFqh2krHhIrjpKMDkWTrH9s//l5Zl4L+mp46/bt6r1xc6tenKeY9DZOg
        8C4SAsNwgHXHCvmdLHhyC3BykQ==
X-Google-Smtp-Source: AMrXdXsOvwNIYYmxRZ1A4P2qL2M11DO9ETy3xVnstT6ROBE9IIpgFgsb6iMlmsjwANei+MKsQQb7Fw==
X-Received: by 2002:aa7:973c:0:b0:574:8995:c0d0 with SMTP id k28-20020aa7973c000000b005748995c0d0mr742042pfg.1.1673292729425;
        Mon, 09 Jan 2023 11:32:09 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 194-20020a6214cb000000b005809d382016sm6429041pfu.74.2023.01.09.11.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:32:09 -0800 (PST)
Date:   Mon, 9 Jan 2023 19:32:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <Y7xrtf9FCuYRYm1q@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <Y7azFdnnGAdGPqmv@kernel.org>
 <20230106094000.GA2297836@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106094000.GA2297836@chaop.bj.intel.com>
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

On Fri, Jan 06, 2023, Chao Peng wrote:
> On Thu, Jan 05, 2023 at 11:23:01AM +0000, Jarkko Sakkinen wrote:
> > On Fri, Dec 02, 2022 at 02:13:41PM +0800, Chao Peng wrote:
> > > To make future maintenance easy, internally use a binary compatible
> > > alias struct kvm_user_mem_region to handle both the normal and the
> > > '_ext' variants.
> > 
> > Feels bit hacky IMHO, and more like a completely new feature than
> > an extension.
> > 
> > Why not just add a new ioctl? The commit message does not address
> > the most essential design here.
> 
> Yes, people can always choose to add a new ioctl for this kind of change
> and the balance point here is we want to also avoid 'too many ioctls' if
> the functionalities are similar.  The '_ext' variant reuses all the
> existing fields in the 'normal' variant and most importantly KVM
> internally can reuse most of the code. I certainly can add some words in
> the commit message to explain this design choice.

After seeing the userspace side of this, I agree with Jarkko; overloading
KVM_SET_USER_MEMORY_REGION is a hack.  E.g. the size validation ends up being
bogus, and userspace ends up abusing unions or implementing kvm_user_mem_region
itself.

It feels absolutely ridiculous, but I think the best option is to do:

#define KVM_SET_USER_MEMORY_REGION2 _IOW(KVMIO, 0x49, \
					 struct kvm_userspace_memory_region2)

/* for KVM_SET_USER_MEMORY_REGION2 */
struct kvm_user_mem_region2 {
	__u32 slot;
	__u32 flags;
	__u64 guest_phys_addr;
	__u64 memory_size;
	__u64 userspace_addr;
	__u64 restricted_offset;
	__u32 restricted_fd;
	__u32 pad1;
	__u64 pad2[14];
}

And it's consistent with other KVM ioctls(), e.g. KVM_SET_CPUID2.

Regarding the userspace side of things, please include Vishal's selftests in v11,
it's impossible to properly review the uAPI changes without seeing the userspace
side of things.  I'm in the process of reviewing Vishal's v2[*], I'll try to
massage it into a set of patches that you can incorporate into your series.

[*] https://lore.kernel.org/all/20221205232341.4131240-1-vannapurve@google.com
