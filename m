Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693F270E74F
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjEWVZz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 17:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjEWVZy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 17:25:54 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E9FA
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2023 14:25:52 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2532c2c41f7so91033a91.0
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2023 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684877152; x=1687469152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhkFXCVK7IIddxQvfyYvbxUVBVCNC01wPMYY5cCrGec=;
        b=QivLoo6aTt7ePCsCuUzSciGYVzVkNfEjQJObWk6rpXU0sQA/5e38aC/9Y/PAkp2ug6
         xMWTUG/8Jy0fzXiJMXWLVH/2rVCwS+5FBaOqeTSeqZo1/FNi9GWe43UA8o7gqrfGQ8fD
         B54VINXLIXwdoIoca2En2IUUNyT/l3WlMum1E8gltNqbL5Z4hcKLehaG9sWO2KqSSzyA
         b7/g/E7x9ZZRL2I+Gz0s8J6m5FdZexmUb08Q/y9M4iO66z0oaX5yNjop6Zgy8VSJpFMw
         aAl7J7cA1POhuz8TBmQYDJftF5bHnS7NV8PDY71EFtuzMKacBOHhvc/JiBVPVvV2zE+2
         1iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877152; x=1687469152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhkFXCVK7IIddxQvfyYvbxUVBVCNC01wPMYY5cCrGec=;
        b=gXj3xGClfxr1mcb1mrksOZTiuxknYbqjtUHYmjQNHOv3abshVHdK9MeQW36KoMH7SQ
         22KPEUZ+K1GrE7xre1JtFNrKDpnNyNzftjdy1HmRxb7rNq+YMLa4t3y5z6W1qRtWkpkW
         /MF7JkK81Ldyf7zXjX3o3tNMpIewah8W4MHlWt5iEtQW4hv7o4CeoD1MVw002uEzQRDW
         LmB9RRDypfhM9lbK8VM+tZLPXACi8Ijcrd1p8aBXMt6yrUzCYcNNVHly+aQwDQ7Eg2G6
         UGQEUVN4PtON9MDoL4Sy9fcMFCPxLeT9j1Ot96KGlANxtX0v+ANdH/aqEuL3K5XYpuEw
         LoEQ==
X-Gm-Message-State: AC+VfDyi82miMhL1XYn90Znzw3rdK6pXKDmZp5WYDT8E2AlOsKh2Ni5d
        iVk6IUowIHGCXthIZOeOdYNyai4bOc8=
X-Google-Smtp-Source: ACHHUZ6cDaf5azT55gDV/yqP4cbXNitd7JzyJe1bVaEXt9rD11LqMO7WDye75MvNzuOMX6Fy8++PMZfD+g0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:890:b0:255:5a01:cc48 with SMTP id
 bj16-20020a17090b089000b002555a01cc48mr2274966pjb.3.1684877151953; Tue, 23
 May 2023 14:25:51 -0700 (PDT)
Date:   Tue, 23 May 2023 14:25:50 -0700
In-Reply-To: <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
Mime-Version: 1.0
References: <20230504225351.10765-1-decui@microsoft.com> <20230504225351.10765-3-decui@microsoft.com>
 <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
Message-ID: <ZG0vXlQpXgll+YJ1@google.com>
Subject: Re: [PATCH v6 2/6] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 23, 2023, Dave Hansen wrote:
> On 5/4/23 15:53, Dexuan Cui wrote:
> > When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> > allocates buffers using vzalloc(), and needs to share the buffers with the
> > host OS by calling set_memory_decrypted(), which is not working for
> > vmalloc() yet. Add the support by handling the pages one by one.
> 
> I think this sets a bad precedent.

+1 

> There are consequences for converting pages between shared and private.
> Doing it on a vmalloc() mapping is guaranteed to fracture the underlying
> EPT/SEPT mappings.
> 
> How does this work with load_unaligned_zeropad()?  Couldn't it be
> running around poking at one of these vmalloc()'d pages via the direct
> map during a shared->private conversion before the page has been accepted?

Would it be feasible and sensible to add a GFP_SHARED or whatever, to communicate
to the core allocators that the page is destined to be converted to a shared page?
I assume that would provide a common place (or two) for initiating conversions,
and would hopefully allow for future optimizations, e.g. to keep shared allocation
in the same pool or whatever.  Sharing memory without any intelligence as to what
memory is converted is going to make both the guest and host sad.
