Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FD674897
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 02:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjATBHn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 20:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjATBHl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 20:07:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A218AA5
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:07:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl3so3985096plb.8
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPHorCLnKFAaUXh/8WgKdTalHhbVSsdE/cMoZ2FJYp8=;
        b=IUA2bJA2O+UUd9QC47MgS7ecQ0dFW+vV7HicI8gGMdf7pgA3kqYYezRIZjCZNw4l06
         wc6H+qWCoTrdyrjFTxZXNfNGrw84DgPvPAdtkGDjrV53nzqBLeKsQDF4Kr2xzQ7U8A/Q
         v6CmDg1pYGdO0wh/J7t6BYvGpVoV/MTUw3boA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPHorCLnKFAaUXh/8WgKdTalHhbVSsdE/cMoZ2FJYp8=;
        b=jWa0eB9g/6yGBOAg5cqZ94b0iBaZ2z5kFQtxXZ0hxjfL8uqLJhQiWxZltV2yYMbFZc
         NHTPBtxnBcQ8O9VnlnYs6+qw/gAx3YJYc2wDbtxPHn9xwgDQ1CiToi6gCzlI4Nn3fJKC
         cFgDEARuPmtZEfdZqbmKk7mBvePygxuFgdEk/3O3ZKLU4lSM4XDimp1O0c37ugY5tcsO
         dkKPPZmTtNTpPac2K1WUKDOF2k0cMyHY3R303c4R80IM6c4oU0L0aU/gIlHnfZ/O3Ybw
         IIJ95FpUXo+ClmEFoKF1uHd6wVXsGND1ac0BN3R91YPO8n8BA9LzfFjH6if/ZiLXdU4v
         Me8A==
X-Gm-Message-State: AFqh2krOEHeCHc3RR2sfPVnTcIGzRLMlf3WWhG8du/PCaSIh5jTmJnDl
        KjUWx7/bi4YxbwVx6bd6MQ1Mgw==
X-Google-Smtp-Source: AMrXdXteQiwZGYC6ZWkAuTK209ZRm5P4tsbVh1gdGPdLFoNByetVL9ycW3afunzU6DVSHhjAaDO+Wg==
X-Received: by 2002:a17:902:bb8f:b0:194:8c5c:5c2a with SMTP id m15-20020a170902bb8f00b001948c5c5c2amr12841064pls.67.1674176856320;
        Thu, 19 Jan 2023 17:07:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b0019488a36e2asm9580955pln.277.2023.01.19.17.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:07:35 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:07:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Subject: Re: [PATCH v5 31/39] x86/shstk: Introduce map_shadow_stack syscall
Message-ID: <202301191707.30AEEE21@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-32-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-32-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:23:09PM -0800, Rick Edgecombe wrote:
> When operating with shadow stacks enabled, the kernel will automatically
> allocate shadow stacks for new threads, however in some cases userspace
> will need additional shadow stacks. The main example of this is the
> ucontext family of functions, which require userspace allocating and
> pivoting to userspace managed stacks.
> 
> Unlike most other user memory permissions, shadow stacks need to be
> provisioned with special data in order to be useful. They need to be setup
> with a restore token so that userspace can pivot to them via the RSTORSSP
> instruction. But, the security design of shadow stack's is that they
> should not be written to except in limited circumstances. This presents a
> problem for userspace, as to how userspace can provision this special
> data, without allowing for the shadow stack to be generally writable.
> 
> Previously, a new PROT_SHADOW_STACK was attempted, which could be
> mprotect()ed from RW permissions after the data was provisioned. This was
> found to not be secure enough, as other thread's could write to the
> shadow stack during the writable window.
> 
> The kernel can use a special instruction, WRUSS, to write directly to
> userspace shadow stacks. So the solution can be that memory can be mapped
> as shadow stack permissions from the beginning (never generally writable
> in userspace), and the kernel itself can write the restore token.
> 
> First, a new madvise() flag was explored, which could operate on the
> PROT_SHADOW_STACK memory. This had a couple downsides:
> 1. Extra checks were needed in mprotect() to prevent writable memory from
>    ever becoming PROT_SHADOW_STACK.
> 2. Extra checks/vma state were needed in the new madvise() to prevent
>    restore tokens being written into the middle of pre-used shadow stacks.
>    It is ideal to prevent restore tokens being added at arbitrary
>    locations, so the check was to make sure the shadow stack had never been
>    written to.
> 3. It stood out from the rest of the madvise flags, as more of direct
>    action than a hint at future desired behavior.
> 
> So rather than repurpose two existing syscalls (mmap, madvise) that don't
> quite fit, just implement a new map_shadow_stack syscall to allow
> userspace to map and setup new shadow stacks in one step. While ucontext
> is the primary motivator, userspace may have other unforeseen reasons to
> setup it's own shadow stacks using the WRSS instruction. Towards this
> provide a flag so that stacks can be optionally setup securely for the
> common case of ucontext without enabling WRSS. Or potentially have the
> kernel set up the shadow stack in some new way.
> 
> The following example demonstrates how to create a new shadow stack with
> map_shadow_stack:
> void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
