Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628B465C0A
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 03:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352292AbhLBCQv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Dec 2021 21:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbhLBCQu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Dec 2021 21:16:50 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F47C061748
        for <linux-arch@vger.kernel.org>; Wed,  1 Dec 2021 18:13:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nn15-20020a17090b38cf00b001ac7dd5d40cso3360542pjb.3
        for <linux-arch@vger.kernel.org>; Wed, 01 Dec 2021 18:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xqdq69bklkVGPaiuC/hhcniUDsb69a5Tsomp+eMdT8Y=;
        b=kLe2Jr2E6gqbImzVXFbWuWelxOvMTjUr3eE3r6UXGeXlSFHQJujz3lKGG1L8GrT/jA
         tZc+qlJVZ58JjH0g5XNMGk6jNl01J+5YdmbMgSs4RYG+rZnunYfoVS5CVwrghZldDJyO
         QsL/vfDrNDDfrswvVpKh4G3/Rp546pliFVtuK/l3YPREcTeI5wXswL8GsLhOo8t+L3zO
         eEWvcu/xAKtGB5MCBINyHO9v189tvqdZBzA343XYcBSiMvbmvZ5h5HhvMN1neTO3sFuf
         4KjN5JhpI1gvBnhZ1ekaA2hzk6QsMmK5uzhPhUAXOQETZO338FaIlVCWBJjU9Mdq9WON
         fmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xqdq69bklkVGPaiuC/hhcniUDsb69a5Tsomp+eMdT8Y=;
        b=F/Jz+QVlca2VS1CoC0HkSL3RtOZdBSUdwtX4bDa1Kcy9exxzJukV8oa4OhMof6f7d7
         ObMovHAFQKft2d4riwaw5iej4yt/oCieGvaso8v7/8DzkovceERmtUVVFgay+swrzWM6
         HF28wD/dacKJ7Yc0ZdEcgOPq7D6PN5UtUQdFo6bfDVCWmn+eV4zjZ2Y27/6vqn4xHy93
         12N2zMKcVJtKApvI1IGJFlkmuG0LsDpQwBLX8bgk9nt7pJp3V9Sf+FGG9qAd0V90wC9l
         6v35SGIoM0sgSYhKNI+wo7QgPMxaf1ubGUa/m3TlbnfxoPdMWl1MmztZ/B38hjwszcAw
         7JHQ==
X-Gm-Message-State: AOAM530WvnTaut26NgF3Xrhf5f9zBd3dUN4dIFoX4jGp2+BlmfhioHCA
        GCfZjmA436vplW8cxI/haP9RbQ==
X-Google-Smtp-Source: ABdhPJwI9/kW+841BCq3bJVjpyet3MmhhrawiCLnHAmmZ9PuYqso3ZTZlCgmtcoT/lCxdVVnUZYA0g==
X-Received: by 2002:a17:90b:92:: with SMTP id bb18mr2454366pjb.133.1638411208204;
        Wed, 01 Dec 2021 18:13:28 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j7sm1152501pfc.74.2021.12.01.18.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 18:13:27 -0800 (PST)
Date:   Thu, 2 Dec 2021 02:13:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 8/8] KVM: x86: Add checks for reserved-to-zero Hyper-V
 hypercall fields
Message-ID: <YagrxIknF9DX8l8L@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-9-seanjc@google.com>
 <87v91cjhch.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v91cjhch.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 01, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Add checks for the three fields in Hyper-V's hypercall params that must
> > be zero.  Per the TLFS, HV_STATUS_INVALID_HYPERCALL_INPUT is returned if
> > "A reserved bit in the specified hypercall input value is non-zero."
> >
> > Note, the TLFS has an off-by-one bug for the last reserved field, which
> > it defines as being bits 64:60.  The same section states "The input field
> > 64-bit value called a hypercall input value.", i.e. bit 64 doesn't
> > exist.
> 
> This version are you looking at? I can't see this issue in 6.0b

It's the web-based documentation, the 6.0b PDF indeed does not have the same bug.

https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface#hypercall-inputs
